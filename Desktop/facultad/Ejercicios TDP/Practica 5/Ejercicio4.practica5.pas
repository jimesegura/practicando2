{Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
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
		sig:listaR;
	end;
	
	arbol=^nodoarbol;
	nodoarbol=record
		dni:integer;
		cantR:integer;
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
		Procedure AgregarLista(var l:listaR; r2:reclamosSinDNI);
		var aux:listaR;
		begin
			new(aux);
			aux^.dato:=r2;
			//aux^.cantR:=aux^.cantR+1;
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
			a^.cantR:=1;
			a^.lista:=nil;
			agregarLista(a^.lista,r2);
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(r.dni=a^.dni)then begin
				a^.cantR:=a^.cantR+1;
				agregarLista(a^.lista,r2);
			end
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
		end;
	end;
begin
	if(a<>nil)then begin
		imprimir(a^.hi);
		writeln('lista dni: ',a^.dni);
		imprimirLista(a^.lista);
		writeln('Cantidade de reclamos: ',a^.cantR);
		imprimir(a^.hd);
	end;
end;
{Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
reclamos efectuados por ese DNI.}
procedure buscarReclamosDNI(a:arbol;dni:integer);
	function buscar(a:arbol; ani:integer):integer;
	begin
		if(a<>nil)then
		begin
			if(dni=a^.dni)then
				buscar:=a^.cantR
			else
				if(dni<a^.dni)then
					buscar:=buscar(a^.hi,dni)
				else
					buscar:=buscar(a^.hi,dni);
		end
		else
			buscar:=0;
	end;

var cant:integer;
begin
	cant:=buscar(a,dni);
	if(cant=0)then
		writeln('No se encontro dni')
	else 	
		writeln(' cantidad de reclamos: ', cant);
end;
{Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.}
procedure contarReclamos(a:arbol;dni1:integer;dni2:integer);
	function contar(a:arbol;dni1,dni2:integer):integer;
	begin
		if(a<>nil)then
		begin
			if(a^.dni>dni1) and(a^.dni<dni2)then
				contar:=a^.cantR+contar(a^.hi,dni1,dni2)+contar(a^.hd,dni1,dni2)
			else if(a^.dni<dni1)then
				contar:=contar(a^.hd,dni1,dni2)
			else
				contar:=contar(a^.hi,dni1,dni2);
		end
		else
			contar:=0;
	end;

var cant:integer;
begin
	cant:=contar(a,dni1,dni2);
	if(cant=0)then
		writeln('No se encontro dni')
	else 	
		writeln(' cantidad de reclamos: ', cant);
end;
{ Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
los reclamos realizados en el año recibido.}


var a:arbol; dni, dni1,dni2:integer; 
begin
	a:=nil;
	cargarArbol(a);
	imprimir(a);
	writeln('------modulo b---------');
	write('Ingrese dni: '); readln(dni);
	buscarReclamosDNI(a,dni);
	writeln('------modulo c---------');
	write('Ingrese dni1: '); readln(dni1);
	write('Ingrese dni2: '); readln(dni2);
	contarReclamos(a,dni1,dni2);
end.

