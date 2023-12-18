{n supermercado requiere el procesamiento de sus productos. De cada producto se
conoce código, rubro (1..10), stock y precio unitario. Se pide:
Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. La lectura finaliza con el código de producto igual a -1.
}


program Ejercicio3;
type
	dimF=1..10;
	rubros=1..10;
	
	productoSinRubro=record
		codigo:integer;
		stock:integer;
		precioUni:real;
	end;
	
	producto=record
		codigo:integer;
		stock:integer;
		precioUni:real;
		rubro:rubros;
	end;
	
	arbol=^nodoProductos;
	nodoProductos=record
		dato:productoSinRubro;
		hi:arbol;
		hd:arbol;
	end;
	
	vectorP=array[rubros]of arbol;
//---------------------------------------
Procedure cargarVector(var a:arbol; var v:vectorP; var dimL:integer);
	Procedure leerProducto(var p:producto; var p2:ProductoSinRubro);
	begin
		writeln('ingrese codigo');readln(p.codigo);
		if(p.codigo<>-1)then begin
			writeln('ingrese rubro');readln(p.rubro);
			writeln('ingrese stock');readln(p.stock);
			writeln('ingrese precio unitario');readln(p.precioUni);
		end;
		
		p2.codigo:=p.codigo;
		p2.stock:=p.stock;
		p2.precioUni:=p.precioUni;
	end;
	
	Procedure crearNodo(var a:arbol;p:productoSinRubro);
	begin
		new(a);
		a^.dato:=p;
		a^.hi:=nil;
		a^.hd:=nil;
		writeln('agregadoNuevo');
	end;
	
	Procedure agregarVector(var a:arbol; p:productoSinRubro);
	begin
		if(a=nil)then begin
			new(a);
			a^.dato:=p;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(p.codigo<a^.dato.codigo)then
				agregarVector(a^.hi,p)
			else
				agregarVector(a^.hd,p);
		//writeln('agregadoalalista');
	end;

var p:producto; p2:productoSinRubro;
begin
	dimL:=0;
	leerProducto(p,p2);
	while(p.codigo<>-1)do begin
		//writeln(p.rubro);	
		if(v[p.rubro]=nil)then begin
			crearNodo(v[p.rubro],p2);
			dimL:=dimL+1;
			//writeln('vacio');
		end
		else begin
			agregarVector(v[p.rubro],p2);
			//writeln('agregar');
		end;
		//writeln('leo');
		leerProducto(p,p2);
	end;
end;
Procedure inicializarV(var v:vectorP);
var i:integer;
begin
	for i:=1 to 10 do begin
		v[i]:=nil;
{
		if (v[i]=nil)then
			writeln('nil ')
		else
			writeln(v[i]^.dato.codigo);	
}
	end;
end;

Procedure imprimirV(v:vectorP; dimL:integer);
	Procedure imprimir(a:arbol);
	begin
		if (a<>nil)then 
		begin
			imprimir(a^.hi);
			writeln('codigo: ',a^.dato.codigo);
			imprimir(a^.hd);
		end
		else
end;
var i:integer;
begin
	for i:=1 to dimL do begin
		writeln('arbol rubro : ',i);
		imprimir(v[i]);
	end;
end;
{Implementar un módulo que reciba la estructura generada en a), un rubro y un código
de producto y retorne si dicho código existe o no para ese rubro.}
Procedure buscarCodigoXrubro(v:vectorP);
	function buscarCod(a:arbol;c:integer):boolean;
	begin
		if(a=nil)then
			buscarCod:=false
		else
			if(c=a^.dato.codigo)then
				buscarCod:=true
			else
				if(c<a^.dato.codigo)then
					buscarCod:=buscarCod(a^.hi,c)
				else
					buscarCod:=buscarCod(a^.hd,c);
	end;

var r:rubros;c:integer; existe:boolean;
begin
	write('Ingrese rubro a buscar: ');readln(r);
	write('Ingrese codigo a buscar: ');readln(c);
	existe:=buscarCod(v[r],c);
	writeln(existe);
end;
{Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.}
Procedure buscarCodigoMayor(v:vectorP;dimL:integer);
	Procedure buscar(a:arbol;var maxcod:integer; var maxstock:integer);
	begin
		if(a<>nil)then
		begin
			if(a^.dato.codigo>maxcod)then
			begin
				maxcod:=a^.dato.codigo;
				maxstock:=a^.dato.stock;
			end;
				buscar(a^.hd,maxcod,maxstock);
		end;
	end;

var maxcod,maxstock,i:integer;
begin
	maxcod:=-1;
	for i:=1 to dimL do begin
		buscar(v[i],maxcod,maxstock);
		write(' codigo mayor arbol : ',i,' : ',maxcod, ' Stock: ',maxstock);
	end;
end;
{Implementar un módulo que reciba la estructura generada en a), dos códigos y
retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
ingresados.}
Procedure buscarProductosEntreCodigos(v:vectorP; cod1:integer; cod2:integer;dimL:integer);
	Function buscar(a:arbol; cod1,co2:integer):integer;
	begin
		if(a=nil)then
			buscar:=0
		else
			if(a<>nil)then
				if(a^.dato.codigo>cod1) and(a^.dato.codigo<cod2) then
					buscar:=1+ buscar(a^.hi,cod1,cod2)+buscar(a^.hd,cod1,cod2)
				else begin
				buscar:=buscar(a^.hi,cod1,cod2);
				buscar:=buscar(a^.hd,cod1,cod2);
				end;
	end;

var cant,i:integer;
begin
	for i:=1 to dimL do begin
		cant:=buscar(v[i],cod1,cod2);
		writeln('cantidad de preductos entre esos codigos: ', cant);
	end;
end;	

var a:arbol;v:vectorP; dimL,cod1,cod2:integer;
BEGIN
	a:=nil;
	inicializarV(v);
	cargarVector(a,v, dimL);
	writeln('dimL: ', dimL);	
	imprimirV(v, dimL);
	buscarCodigoXrubro(v);
	buscarCodigoMayor(v,dimL);
	write('Ingrese codigo1: '); readln(cod1);
	write('Ingrese codigo2: '); readln(cod2);
	buscarProductosEntreCodigos(v,cod1,cod2,dimL);
END.
