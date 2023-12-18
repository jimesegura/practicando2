{a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.
}


program Ejercicio3;

type
	lista=^datosNum;
	datosNum=record
		dato:integer;
		sig:lista;
	end;

Procedure cargarLista(var l:lista);
	Procedure agregarLista(var l:lista; n:integer);
	var nuevo:lista;
	begin
		new(nuevo);
		nuevo^.dato:=n;
		nuevo^.sig:=nil;
		
		if(l=nil) then
			l:=nuevo
		else begin
			nuevo^.sig:=l;
			l:=nuevo;
		end;
	end;

var n:integer;
begin
	n:=random(10);
	if(n<>0)then begin
		agregarLista(l,n);
		cargarLista(l);
	end;
end;

procedure imprimirLista(l:lista);
begin
	if(l<>nil) then begin
		write(l^.dato,' ');
		imprimirLista(l^.sig);
	end;
end;

procedure buscarMin(l:lista; var min:integer);
begin	
	if(l<>nil) then begin
		if(l^.dato<min)then
			min:=l^.dato;
		buscarMin(l^.sig, min);
	end;
end;

procedure buscarMax(l:lista; var max:integer);
begin
	if(l<>nil) then begin
		if(l^.dato>max)then
			max:=l^.dato;
		buscarMax(l^.sig, max);
	end;
end;

function buscarElemento(l:lista; num:integer; var esta:boolean):boolean;
begin
	if(l<>nil) then begin
		if(l^.dato=num)then
		begin
			esta:=true;
		end
		else
			buscarElemento(l^.sig,num,esta);
	end;
	buscarElemento:=esta;
end;

var l:lista; min, max, num:integer; esta:boolean;
BEGIN
	l:=nil;
	min:= 9999;
	max:=-1;
	esta:=false;
	randomize;
	cargarLista(l);
	imprimirLista(l);
	buscarMin(l, min);
	buscarMax(l,max);
	write('Ingrese numero a buscar'); readln(num);
	writeln('----------------');
	writeln('minumo ',min);
	writeln('maximo ',max);
	writeln('----------------');
	writeln(buscarElemento(l, num, esta));
END. 
