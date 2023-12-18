program prueba4;
type
	dias=0..31;
	meses=1..12;
	rangoHoras=1..8;
	registro=record
		numero:integer;
		dia:dias;
		mes:meses;
		horas:rangoHoras;
	end;

	registroSN=record
		dia:dias;
		mes:meses;
		horas:rangoHoras;
	end;
	
	listaRegistros=^nodolista;
	nodolista=record
		dato:registroSN;
		sig:listaRegistros;
	end;
	
{
	registroArboles=record
		numero:integer;
		lista:listaRegistros;
	end;
}
	
	arbol1=^nodoarbol1;
	nodoarbol1=record
		numero:integer;
		lista:listaRegistros;
		hi:arbol1;
		hd:arbol1;
	end;
	{-------------Modulo b-----------}
	
{
	arbol2=^nodoarbol2;
	nodoarbol2=record
		dato:registroArboles;
		hi:arbol2;
		hd:arbol2;
	end;
}
{---------------------------------------------}

Procedure cargarArbol1(var a:arbol1);
	Procedure leerRegistro(var r:registro;var r2:registroSN);
	begin
		r.dia:=random(31);
		if(r.dia<>0)then begin
			r.numero:=random(500)+1;
			r.mes:=random(12)+1;
			r.horas:=random(8)+1;
		end;
		
		r2.dia:=r.dia;
		r2.mes:=r.mes;
		r2.horas:=r.horas;	
	end;
	
	Procedure agregarArbol1(var a:arbol1; r:registro;r2:registroSN);
		Procedure agregarLista(var l:listaRegistros; r2:registroSN);
		var aux:listaRegistros;
		begin
			new(aux);
			aux^.dato:=r2;
			aux^.sig:=l;
			l:=aux;
		end;
	begin
		if(a=nil)then
		begin
			a^.numero:=r.numero;
			writeln('a');
			a^.lista:=nil;
			agregarLista(a^.lista,r2);
			a^.hi:=nil;
			a^.hd:=nil;	
		end
		else
			if(r.numero=a^.numero)then
				agregarLista(a^.lista,r2)
			else
				if(r.numero<a^.numero)then
					agregarArbol1(a^.hi,r,r2)
				else
					agregarArbol1(a^.hd,r,r2);
	end;
var r:registro; r2:registroSN;
begin
	leerRegistro(r,r2);
	while(r.dia<>0)do begin
		agregarArbol1(a,r,r2);
		leerRegistro(r,r2);
	end;
end;	

Procedure imprimirArbol1(a:arbol1);
	Procedure imprimirLista(l:listaRegistros);
	begin
		while (l<>nil)do begin
			writeln('dia: ',l^.dato.dia);
			writeln('mes: ',l^.dato.mes);
			writeln('horas: ',l^.dato.horas);
			l:=l^.sig;
		end;
	end;
begin
	if(a<>nil)then
	begin
		imprimirArbol1(a^.hi);
		writeln('numero: ', a^.numero);
		imprimirLista(a^.lista);
		imprimirArbol1(a^.hd);
	end;
		
end;
	
var a1:arbol1; //a2:arbol2;	
BEGIN
	randomize;
	a1:=nil;
	//a2:nil;
	writeln('--------------Modulo A--------------');
	cargarArbol1(a1);
	imprimirArbol1(a1);
	
END.

