{Un supermercado requiere el procesamiento de sus productos. De cada producto se
conoce código, rubro (1..10), stock y precio unitario. Se pide:
Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. La lectura finaliza con el código de producto igual a -1.
}


program Ejercicio3;
type
	dimF=1..10;
	rubros=1..10;
	
	producto=record
		codigo:integer;
		rubro:rubros;
		stock:integer;
		precioUni:real;
	end;
	
	arbol=^nodoProductos;
	nodoProductos=record
		dato:producto;
		hi:arbol;
		hd:arbol;
	end;
	
	vectorP=array[rubros]of arbol;
//---------------------------------------
Procedure cargarVector(var a:arbol; v:vectorP; var dimL:integer);
	Procedure leerProducto(var p:producto);
	begin
		writeln('ingrese codigo');readln(p.codigo);
		if(p.codigo<>-1)then begin
			writeln('ingrese rubro');readln(p.stock);
			writeln('ingrese stock');readln(p.codigo);
			writeln('ingrese precio unitario');readln(p.precioUni);
		end;
	end;
	
	Procedure agregarVector(var a:arbol; var v:vectorP; p:producto; var dimL:integer);
	begin
		if(v[p.rubro]=nil)then begin
			new(a);
			a^.dato:=p;
			a^.hi:=nil;
			a^.hd:=nil;
			v[p.rubro]:=a;
			dimL:=dimL+1;
			writeln('dimL: ', dimL);	
		end
		else if(a=nil)then begin
			new(a);
			a^.dato:=p;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(p.codigo<a^.dato.codigo)then
				agregarVector(a^.hi,v,p,dimL)
			else
				agregarVector(a^.hd,v,p,dimL);
	end;

var p:producto;
begin
	dimL:=1;
	leerProducto(p);
	while(p.codigo<>-1)do begin
		agregarVector(a,v,p,dimL);
		//writeln('dimL: ', dimL);	
		leerProducto(p);
	end;
end;
Procedure inicializarV(var v:vectorP);
var i:integer;
begin
	for i:=1 to 10 do begin
		v[i]:=nil;
		if (v[i]=nil)then
			writeln('nil ')
		else
			writeln(v[i]^.dato.codigo);	
	end;
end;

Procedure imprimirV(v:vectorP; dimL:integer);
	Procedure imprimir(a:arbol);
	begin
		if (a<>nil)then 
		begin
			imprimir(a^.hi);
			writeln(a^.dato.codigo);
			writeln('aaaaaaaaaaaaaa');
			imprimir(a^.hd);
		end;
	end;
var i:integer;
begin
	for i:=1 to dimL do begin
		imprimir(v[i]);
		writeln('aaaaaaaaaaaaaa');
	end;
end;

var a:arbol;v:vectorP; dimL:integer;
BEGIN
	a:=nil;
	inicializarV(v);
	cargarVector(a,v, dimL);
	writeln('dimL: ', dimL);	
	imprimirV(v, dimL);
END.


