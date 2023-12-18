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
			writeln('ingrese rubro');readln(p.stock);
			writeln('ingrese stock');readln(p.codigo);
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
		writeln('agregadoalalista');
	end;

var p:producto; p2:productoSinRubro;
begin
	dimL:=1;
	leerProducto(p,p2);
	while(p.codigo<>-1)do begin
		if(v[p.rubro]=nil)then begin
			crearNodo(v[p.rubro],p2);
			dimL:=dimL+1;
			writeln('vacio');
		end
		else begin
			agregarVector(v[p.rubro],p2);
			writeln('agregar');
		end;
		writeln('leo');
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
			writeln('dato: ',a^.dato.codigo);
			imprimir(a^.hd);
		end
		else
end;
var i:integer;
begin
	for i:=1 to dimL do begin
		imprimir(v[i]);
		writeln('Lista: ');
	end;
end;

var a:arbol;v:vectorP; dimL:integer;
BEGIN
	a:=nil;
	inicializarV(v);
	cargarVector(a,v, dimL);
	//writeln('dimL: ', dimL);	
	imprimirV(v, dimL);
END.


