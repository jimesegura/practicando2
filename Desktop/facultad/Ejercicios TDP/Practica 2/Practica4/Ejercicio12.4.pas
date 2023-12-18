{Implementar un programa modularizado para una librería que:
a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados la cantidad total de
unidades vendidas y el monto total. De cada venta se lee código de venta, código del
producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las
ventas finaliza cuando se lee el código de venta -1.
b. Imprima el contenido del árbol ordenado por código de producto.
c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.
d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.
e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).
}


program Ejercicio1;
type
	producto=record
		codP:integer;
		totalUniVendidas:integer;
		montoTotal:real;
	end;
	ventas=record
		codigo:integer;
		codProducto:integer;
		cantUnidadesVendidas:integer;
		precioUnitario:real;
	end;
	
	arbol=^datosProductos;
		datosProductos=record
			dato:producto;
			hi:arbol;
			hd:arbol;
		end;


Procedure cargarArbol(var a:arbol);
	Procedure leerVentas(var v:ventas);
	begin
		write('Ingrese codigo de venta:');readln(v.codigo);
		if(v.codigo<>-1)then
		begin
			write('Ingrese codigo de producto: ');readln(v.codProducto);
			write('Ingrese cantidad de unidades vendidas: ');readln(v.cantUnidadesVendidas);
			write('Ingrese precio unitario: ');readln(v.precioUnitario);
		end;
	end;
	
	Procedure agregarProducto(var a:arbol; v:ventas);
		Procedure cargarProducto(v:ventas;var p:producto);
		begin
			p.codP:=v.codProducto;
			p.totalUniVendidas:=v.cantUnidadesVendidas;
			p.montoTotal:=v.cantUnidadesVendidas*v.precioUnitario;
		end;
	var p:producto;
	begin
		if(a=nil)then
		begin
			new(a);
			cargarProducto(v,p);
			a^.dato:=p;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(v.codProducto=a^.dato.codp)then
			begin
				a^.dato.totalUniVendidas:=a^.dato.totalUniVendidas+v.cantUnidadesVendidas;
				a^.dato.montoTotal:=a^.dato.montoTotal+(v.cantUnidadesVendidas*v.precioUnitario);
			end
			else 
				if(v.codProducto<a^.dato.codP)then
					agregarProducto(a^.hi,v)
				else
					agregarProducto(a^.hd,v);
	end;

var v:ventas;
begin
	leerVentas(v);
	while (v.codigo<>-1)do 
	begin
		agregarProducto(a,v);
		leerVentas(v);
	end;
end;


Procedure imprimir(a:arbol);
begin
	if(a<>nil)then
	begin
		imprimir(a^.hi);
		writeln('codigo de preducto: ',a^.dato.codP);
		writeln('total unidades vendidas : ',a^.dato.totalUniVendidas);
		writeln('monto total: ',a^.dato.montoTotal:2:2);
		imprimir(a^.hd);
	end;
end;
{c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.}
Procedure productoMasVendido(a:arbol);
	procedure buscarMaximo(a:arbol; var cantMax: integer; var codMax:integer);
	begin
		if(a<>nil)then
		begin
			if(a^.dato.totalUniVendidas>cantMax) then
			begin
				cantMax:=a^.dato.totalUniVendidas;
				codMax:=a^.dato.codP;
			end;
				buscarMaximo(a^.hi,cantMax,codMax);
				buscarMaximo(a^.hd,cantMax,codMax);
			
		end;
	end;
var cantMax, codMax:integer;
begin	
	cantMax:=-1;
	codMax:=-1;
	buscarMaximo(a,cantMax,codMax);
	writeln('Producto mas vendido: ', codMax);
end;
{d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.}
Procedure codigosMenores(a:arbol);
	Function contarCodMenores(a:arbol; cod:integer):integer;
	begin
		if(a<>nil)then
		begin
			if(cod>a^.dato.codP)then
				contarCodMenores:=1+contarCodMenores(a^.hi,cod)+contarCodMenores(a^.hd,cod)
			else 
				contarCodMenores:=contarCodMenores(a^.hi,cod);
		end
		else
			contarCodMenores:=0;
	end;

var cod:integer; cant:integer;
begin
	write('Ingrese un codigo: ');readln(cod);
	cant:=contarCodMenores(a,cod);
	write('cantidad de codigos menores: ',cant);
end;
{e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).}
Procedure montoEntreCodigos(a:arbol);
	Function contarMontos(a:arbol;cod1:integer;cod2:integer):real;
	begin
		if(a<>nil)then
		begin
			if((a^.dato.codP>cod1) and (a^.dato.codP<cod2))then
				contarMontos:=a^.dato.montoTotal+contarMontos(a^.hi,cod1,cod2)+contarMontos(a^.hd,cod1,cod2)
			else begin
				contarMontos:=contarMontos(a^.hi,cod1,cod2);
				contarMontos:=contarMontos(a^.hd,cod1,cod2);
			end;
		end
		else
			contarMontos:=0;
	end;

var cod1,cod2:integer; montoT:real;
begin
	write('Ingrese codigo 1: ');readln(cod1);
	write('Ingrese codigo 2: ');readln(cod2);
	montoT:=contarMontos(a,cod1,cod2);
	write('monto total entre codigos: ', montoT:2:2);
end;



var a:arbol;
begin
	cargarArbol(a);
	imprimir(a);
	writeln('////////////////////////////////');
	productoMasVendido(a);
	writeln('////////////////////////////////');
	codigosMenores(a);
	writeln('////////////////////////////////');
	montoEntreCodigos(a);
	writeln('////////////////////////////////');
END.

