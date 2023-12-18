{- Se desea procesar la información de las ventas de productos de un comercio (como máximo
50).
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el
día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99
unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El
ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos
valores que se ingresan como parámetros.
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a
mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).  
}


program Ejercicio1;
type 
	dimF=1..50;
	subC=1..15;
	subV=1..99;
	ventas=record
		dia:integer;
		codigo: subC;
		cantVendidas: subV
	end;
	
	ventasP=record
		codigo:subC;
		cantVendidas:subV;
	end;
	
	vectorVentas=array[dimF] of ventas;
	
	vectorP=array[dimF] of ventasP;
	
	
Procedure leerVentas(var v:ventas);
begin
	write('Ingrese dia'); readln(v.dia);
	if (v.dia<>0) then begin
		v.codigo:=random(15);
		write('Ingrese cantidad de ventas '); readln(v.cantVendidas);
	end;
end;

Procedure cargarVector (var vv:vectorVentas; var v: ventas; var dimL:integer);
var i:integer;
begin	
		i:=1;
		leerVentas(v);
		while(v.dia<>0) do
		begin
			vv[i]:=v;
			i:=i+1;
			leerVentas(v);
		end;
		dimL:=i;
end;

Procedure imprimirVector(v:vectorVentas; dimL: integer);
var i:integer;
begin
	for i:=1 to dimL do 
	begin
		writeln(v[i].codigo);
	end;
	writeln('----------------------------');
end;

Procedure ordenarVector(var v:vectorVentas; dimL:integer);
var i,j,pos: integer; item:ventas;
begin
	for i:= 1 to dimL-1 do begin
		pos:=i;
		for j:=i+1 to dimL do 
			if (v[j].codigo < v[pos].codigo)then
				pos:=j;
		item:= v[pos];
		v[pos]:=v[i];
		v[i]:=item;
	end;
end;

Procedure eliminarProductos(var v:vectorVentas; var dimL: integer; num1, num2:integer);
var i:integer;
begin
	for i:=1 to dimL do 
	begin
		if((v[i].codigo>num1) and (v[i].codigo<num2)) then
		begin
			v[i]:=v[i+1];
			dimL:=dimL-1;
		end;
	end;
end;

Procedure cargarVP(vv:vectorVentas; var vp:vectorP; dimL:integer; var venP:ventasP);
var i:integer;
begin
	for i:=1 to dimL do begin
		if (vv[i].codigo mod 2 = 0)then
		begin
			venp.codigo:=vv[i].codigo;
			venp.cantVendidas:=vv[i].cantVendidas;
			vp[i]:=venP;
		end;
	end;
end;


Procedure imprimirVP(vp:vectorP; dimL:integer);
var i:integer;
begin
	writeln('Vector par ');
	for i:=1 to dimL do 
	begin
		writeln(vp[i].codigo);
		writeln(vp[i].cantVendidas);
	end;
end;

var vv:vectorVentas; v:ventas; dimL:integer; num1,num2:integer; vp:vectorP; venP:ventasP;
BEGIN
	num1:=0;
	num2:=0;
	randomize;
	cargarVector(vv, v,dimL);
	imprimirVector(vv, dimL);
	ordenarVector(vv, dimL);
	imprimirVector(vv, dimL);
	write('Ingrese num1'); readln(num1);
	write('Ingrese num2'); readln(num2);
	eliminarProductos(vv, dimL, num1, num2);
	writeln(dimL);
	imprimirVector(vv, dimL);
	cargarVP(vv,vp, dimL, venP);
	imprimirVP(vp, dimL);
END.

