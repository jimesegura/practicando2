{Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
reclamos efectuados por ese DNI.
c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
los reclamos realizados en el año recibido.
}


program ejercicio4;
type
	reclamo=record
		codigo:integer;
		dni:integer;
		anio:integer;
		tipo:integer;
	end;
	
	reclamosSinDNI=record
		codigo:integer;
		anio:integer;
		tipo:integer;
	end;
	
	listaR=^nodoreclamos;
	nodoreclamos=record
		dato:reclamosSinDNI;
		cantR:integer;
		sig:listaR;
	end;
	
	arbol=^nodoarbol;
	nodoarbol=record
		dni:integer;
		lista:listaR;
		hi:arbol;
		hd:arbol;
	end;
	
Procedure cargarArbol(var a:arbol);
	Procedure leerReclamo(var r:reclamo; var r2:reclamosSinDNI);
	begin
		write('Ingrese codigo: ');readln(r.codigo);
		if(r.codigo<>-1)then
		begin
			write('Ingrese dni: ');readln(r.dni);
			write('Ingrese anio: ');readln(r.anio);
			write('Ingrese tipo: ');readln(r.tipo);
		end;
		
		r2.codigo:=r.codigo;
		r2.anio:=r.anio;
		r2.tipo:=r.tipo;
	end;
	
	Procedure agregarAlArbol(var a:arbol; r2:reclamosSinDNI; r:reclamo);
		Procedure AgregarLista(l:listaR; r2:reclamosSinDNI);
		var aux:listaR;
		begin
			new(aux);
			aux^.dato:=r2;
			aux^.cantR:=aux^.cantR+1;
			aux^.sig:=l;
			l:=aux;
			writeln('agregado a la lista');
		end;
	begin
		if(a=nil)then 
		begin
			writeln('nodo agregado');
			new(a);
			a^.dni:=r.dni;
			a^.lista:=nil;
			agregarLista(a^.lista,r2);
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(r.dni=a^.dni)then
				agregarLista(a^.lista,r2)
			else
				if(r.dni<a^.dni)then
					agregarAlArbol(a^.hi,r2,r)
				else
					agregarAlArbol(a^.hi,r2,r);
	end;
var r:reclamo; r2:reclamosSinDNI;
begin
	leerReclamo(r,r2);
	while(r.codigo<>-1)do begin
		agregarAlArbol(a,r2,r);
		leerReclamo(r,r2);
	end;
end;


Procedure imprimir(a:arbol);
	Procedure imprimirLista(l:listaR);
	begin
		while(l<>nil)do begin
			writeln('codigo: ',l^.dato.codigo);
			l:=l^.sig;
			writeln('entro a imprimir l');
		end;
	end;
begin
	if(a<>nil)then begin
		imprimir(a^.hi);
		writeln('lista dni: ',a^.dni);
		imprimirLista(a^.lista);
		imprimir(a^.hd);
	end;
end;
	
var a:arbol;
begin
	a:=nil;
	cargarArbol(a);
	imprimir(a);
end.

