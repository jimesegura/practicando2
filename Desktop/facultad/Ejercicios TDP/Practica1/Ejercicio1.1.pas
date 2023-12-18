{
   uEl administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina. 
}


program Ejercicio2;
type 
	oficina= record
		codigo:integer;
		DNI:integer;
		valorExp:real;
	end;
	
	vectorOficinas=array[1..300] of oficina;
	
	
Procedure leerOficinas(var o:oficina);
begin
	writeln('Ingrese codigo');
	readln(o.codigo);
	if(o.codigo<>-1) then
	begin
		writeln('Ingrese DNI');
		readln(o.DNI);
		writeln('Ingrese valor de las expesas');
		readln(o.valorExp);
	end;
end;

Procedure cargarVector(var o:oficina; var v:vectorOficinas; var dimL:integer);
var i:integer;
begin
	i:=1;
	leerOficinas(o);
	while(o.codigo<>-1) do
	begin
		v[i]:=o;
		i:=i+1;
		leerOficinas(o);
	end;
	dimL:=i;
end;

Procedure insercion(var v:vectorOficinas; dimL:integer);
var i,j:integer; actual:oficina;
begin
	for i:=2 to dimL do begin
		actual:=v[i];
		j:=i-1;
		while((j > 0) and (v[j].codigo > actual.codigo)) do 
		begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=actual;
	end;
end;

Procedure seleccion(var v:vectorOficinas; dimL:integer);
var	i, j, pos:integer; item:oficina;
begin
	for i:=1 to dimL-1 do begin
		pos:=i;
		for j:=i+1 to dimL do
			if (v[j].codigo < v[pos].codigo) then
				pos:=j;
		item:=v[pos];
		v[pos]:=v[i];
		v[i]:=item;
	end;
end;

Procedure imprimir(v:vectorOficinas; dimL:integer);
var i:integer;
begin
	for i:=1 to dimL do
	begin
		writeln(v[i].codigo);
	end;
end;

var
	o:oficina; v:vectorOficinas; dimL:integer;
BEGIN
	dimL:=0;
	cargarVector(o,v,dimL);
	writeln(dimL);
	insercion(v,dimL);
	imprimir(v,dimL);
	seleccion(v,dimL);
	imprimir(v,dimL);
END.

