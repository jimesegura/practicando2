program prueba3;
type
	subdia=1..31;
	envios=record
		cliente:integer;
		codPostal:integer;
		dia:subdia;
		peso:real;
	end;

	envioSinCP=record
		cliente:integer;
		dia:subdia;
		peso:real;
	end;
	
	listaC=^nodolista;
	nodolista=record
		dato:envioSinCP;
		sig:listaC;
	end;
		
	arbol=^nodoarbol;
	nodoarbol=record
		codigoP:integer;
		lista:listaC;
		hi:arbol;
		hd:arbol;
	end;
//('-------------Modulo B-----------')
	listaB=^nodolistab;
	nodolistab=record
		dato:envioSinCP;
		sig:listab;
	end;

	
Procedure cargarArbol(var a:arbol);
	Procedure leerEnvios(var e:envios; var e2:envioSinCP);
	begin
		e.peso:=random(2000)/(random(10)+1);
		if(e.peso<>0)then begin
			e.cliente:=random(100)+1;
			e.codpostal:=random(7500)+1;
			e.dia:=random(31)+1;
		end;
			
		e2.cliente:=e.cliente;
		e2.dia:=e.dia;
		e2.peso:=e.peso;
	end;
	Procedure agregarArbol(var a:arbol; e:envios; e2:envioSinCP);
		Procedure agregarLista(var l:listaC;e2:envioSinCP);
		var aux:listaC;
		begin
			new(aux);
			aux^.dato:=e2;
			aux^.sig:=l;
			l:=aux;
		end;
	begin
		if(a=nil)then
		begin
			new(a);
			a^.codigoP:=e.codPostal;
			a^.lista:=nil;
			agregarLista(a^.lista,e2);
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(e.codPostal=a^.codigoP)then
				agregarLista(a^.lista,e2)
			else
				if(e.codPostal<a^.codigoP)then
					agregarArbol(a^.hi,e,e2)
				else
					agregarArbol(a^.hd,e,e2);
	end;
	
var e:envios; e2:envioSinCP;
begin
	leerEnvios(e,e2);
	while(e.peso<>0)do begin
		agregarArbol(a,e,e2);
		leerEnvios(e,e2);
	end;
end;	

procedure imprimirArbol(a:arbol);
	Procedure imprimirLista(l:listaC);
	begin
		while(l<>nil)do begin
			writeln('cliente: ', l^.dato.cliente);
			writeln('dia: ', l^.dato.dia);
			writeln('peso: ',l^.dato.peso:2:2);
			l:=l^.sig;
		end;
	end;
		
begin
	if(a<>nil)then begin
		imprimirArbol(a^.hi);
		writeln('CODIGO POSTAL: ',a^.codigoP);
		imprimirLista(a^.lista);
		imprimirArbol(a^.hd);
	end;
end;
//-----------------------------------------------
Procedure buscarEnvios(a:arbol;var lb:listab; cp:integer);
	Procedure agregar(l:listaC; var lb:listab);
	var aux:listab;
	begin
		while (l<>nil)do begin
			new(aux);
			aux^.dato:=l^.dato;
			aux^.sig:=lb;
			lb:=aux;
			l:=l^.sig;
		end;
	end;

begin
	if(a<>nil)then begin
		if(cp=a^.codigoP)then
			agregar(a^.lista,lb)
		else 
			if(cp<a^.codigoP)then
				buscarEnvios(a^.hi,lb,cp)
			else
				buscarEnvios(a^.hd,lb,cp);
	end;
end;

Procedure imprimirListaB(lb:listab);
begin
	while(lb<>nil)do begin
		writeln('cliente: ', lb^.dato.cliente);
		writeln('dia: ', lb^.dato.dia);
		writeln('peso: ',lb^.dato.peso:2:2);
		lb:=lb^.sig;
	end;
end;
//------------------------------------------------
Procedure buscarMaxyMin(l:listab);
	Procedure buscar(l:listab; var max:real; var min:real; var maxCod:integer; var minCod:integer);
	begin
		if(l<>nil)then begin
			if(l^.dato.peso>max) then begin
				max:=l^.dato.peso;
				maxCod:=l^.dato.cliente;
				min:=max;
				minCod:=maxCod;
			end;
			if(l^.dato.peso<min) then begin
				min:=l^.dato.peso;
				minCod:=l^.dato.cliente;
			end;
			buscar(l^.sig,max,min,maxCod,minCod);
		end;
	end;
	
var max, min:real; maxCod,minCod:integer;
begin
	max:=-1;
	min:=999999;
	buscar(l,max,min,maxCod,minCod);
	writeln('Codigo maximo: ', maxCod);
	writeln('Codigo minimo: ', minCod);
end;
	
var a:arbol; lb:listab; cp:integer;
BEGIN
	writeln('-------------Modulo A-----------');
	randomize;
	a:=nil;
	cargarArbol(a);
	imprimirArbol(a);
	writeln('-------------Modulo B-----------');
	lb:=nil;
	write('Ingrese codigo postal a buscar: ');readln(cp);
	buscarEnvios(a,lb,cp);
	imprimirListaB(lb);
	writeln('-------------Modulo C-----------');
	buscarMaxyMin(lb);
END.

