{Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee
código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de
producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendida.
Nota: El módulo debe retornar los dos árboles.

b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.
}


program Ejercicio2;
type 
	ventas=record
		codigo:integer;
		fecha:integer;
		cantUnidadesVendidas:integer;
	end;
	
	productos=record
		codProducto:integer;
		cantuniTotales:integer;
	end;
	
	arbol=^datosVentas;
	datosVentas=record
		elem:ventas;
		hi:arbol;
		hd:arbol;
	end;
	
	arbol2=^datosproductos;
	datosProductos=record
		elem:productos;
		hi:arbol2;
		hd:arbol2;
	end;
	
	
//------------------------------------------
Procedure cargarArbol(var a:arbol; var a2:arbol2);//punto1

	Procedure leerVentas(var v:ventas);
	begin
		write('Ingrese codigo'); readln(v.codigo);
		if(v.codigo<>0)then 
		begin
			write('Ingrese fecha'); readln(v.fecha);
			write('Ingrese unidades vendidas'); readln(v.cantUnidadesVendidas);
		end;
	end;	
	
	Procedure agregar(var a:arbol; v:ventas);
	begin
		if(a=nil)then 
		begin
			new(a);
			a^.elem:=v;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(v.codigo<=a^.elem.codigo)then
				agregar(a^.hi,v)
			else
				agregar(a^.hd,v);
	end;
	
//---------------------------------------------------- punto2
	Procedure agregarArbol2(var a2:arbol2; v:ventas);
	
		Procedure ventasyproductos(v:ventas; var p:productos);
		begin
			p.codProducto:=v.codigo;
			p.cantUniTotales:=v.cantUnidadesVendidas;
		end;
		
		
	var p:productos;
	begin
		if(a2=nil)then
		begin
			new(a2);
			ventasyproductos(v,p);
			a2^.elem:=p;
			a2^.hi:=nil;
			a2^.hd:=nil;
		end
		else
		
		if(a2^.elem.codProducto=v.codigo)then
			a2^.elem.cantUniTotales:=a2^.elem.cantUniTotales+v.cantUnidadesVendidas
		else 
			if(v.codigo<a2^.elem.codProducto)then
				agregarArbol2(a2^.hi,v)
			else
				agregarArbol2(a2^.hd,v);
	end;

var v:ventas; 	
begin
	leerVentas(v);
	while (v.codigo<>0) do 
	begin
		agregar(a,v);
		agregarArbol2(a2,v);//MODULO IMPORTATE PARA ESTUDIAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		leerVentas(v);
	end;
end;
//--------------------------------------------
Procedure imprimir(a:arbol);
begin
	if(a<>nil)then
	begin
		imprimir(a^.hi);
		write(a^.elem.codigo);
		write('/');
		imprimir(a^.hd);
	end;
end;
//---------------------------------------------
Procedure imprimira2(a2:arbol2);
begin
	if(a2<>nil)then
	begin
		imprimira2(a2^.hi);
		write('codigo: ',a2^.elem.codProducto);
		write('cant unidades: ',a2^.elem.cantUniTotales);
		write('/');
		imprimira2(a2^.hd);
	end;
end;

{b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.}
Procedure buscarEnArbol1(a:arbol);
	Function buscar(a:arbol;cod:integer):integer;
	begin
		if(a<>nil)then
		begin
			if(a^.elem.codigo=cod)then
				buscar:=a^.elem.cantUnidadesVendidas+buscar(a^.hi,cod)+buscar(a^.hd,cod)
			else
				if(cod<=a^.elem.codigo)then
					buscar:=buscar(a^.hi,cod)
				else
					buscar(a^.hd,cod);
		end
		else
			buscar:=0;
	end;

var cod:integer; cantUnidades:integer;
begin
	write('Ingrese codigo a buscar: '); readln(cod);
	cantUnidades:=buscar(a,cod);
	if(cantUnidades=0)then
		write('no se encontro el codigo')
	else
		writeln('cantidad de unidades: ', cantUnidades);
end;
//----------------------------------------------------------
Procedure buscarEnArbol2(a2:arbol2);
	Function buscarA2(a2:arbol2; cod:integer):integer;
	begin
		if(a2<>nil)then
		begin
			if(a2^.elem.codProducto=cod)then
				buscarA2:=a2^.elem.cantuniTotales
			else
				if(cod<a2^.elem.codProducto)then
					buscarA2:=buscarA2(a2^.hi,cod)
				else
					buscarA2:=buscarA2(a2^.hd,cod);
		end
		else
			buscarA2:=0;
	end;

var cantUni,cod:integer;
begin
	Write('iNGRESE CODIGO A BUSCAR '); readln(cod);
	cantUni:=buscarA2(a2,cod);
	if(cantUni=0)then
		writeln('No se encontro el codigo')
	else
		writeln('Cantidad de unidades vendidas: ', cantUni);
end;

		
var a:arbol; a2:arbol2;
BEGIN
	cargarArbol(a,a2);
	imprimir(a);
	writeln('arbol2');
	imprimira2(a2);
	writeln('-------------------');
	buscarEnArbol1(a);
	writeln('--------------------');
	buscarEnArbol2(a2);
END.

