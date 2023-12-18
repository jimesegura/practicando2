program prueba2Otrasolucion;
const
	dimF=12;

type
	submes=1..12;
	
	compra=record
		cliente:integer;
		mes:submes;
		monto:real;
	end;
		
	vectorC=array[subMes]of real;
	
	datoArbol=record
		cliente:integer;
		vectorCliente:vectorC;
	end;
		
	arbol=^nodoArbol;
	nodoArbol=record
		dato:datoArbol;
		hi:arbol;
		hd:arbol;
	end;


Procedure cargarArbol(var a:arbol);

	Procedure leerCompra(var c:compra);
	begin
		c.cliente:=random(100);
		if(c.cliente<>0)then begin
			c.monto:=random(20000)/(random(10)+1);
			c.mes:=random(12)+1;
		end;
	end;
	
	Procedure agregarArbol(var a:arbol; c:compra);
	
		Procedure inicializarV(var v:vectorC);
		var i:integer;
		begin
			for i:=1 to dimF do begin
				v[i]:=0;
			end;
		end;
		
	begin
		if(a=nil)then
		begin
			new(a);
			a^.dato.cliente:=c.cliente;
			inicializarV(a^.dato.vectorCliente);
			a^.dato.vectorCliente[c.mes]:=c.monto;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(c.cliente=a^.dato.cliente)then
				a^.dato.vectorCliente[c.mes]:=a^.dato.vectorCliente[c.mes]+c.monto
			else 
				if(c.cliente<a^.dato.cliente)then
					agregarArbol(a^.hi,c)
				else
					agregarArbol(a^.hd,c);
	end;

var c:compra;
begin
	leerCompra(c);
	while (c.cliente<>0)do begin
		agregarArbol(a,c);
		leerCompra(c);
	end;
end;

Procedure imprimirA(a:arbol);
	Procedure imprimirV(v:vectorC);
	var i:integer;
	begin
		for i:=1 to dimF do begin
			writeln('mes ',i,' :',v[i]:2:2);
		end;
	end;
begin
	if(a<>nil)then begin
		imprimirA(a^.hi);
		writeln('Cliente: ',a^.dato.cliente);
		imprimirV(a^.dato.vectorCliente);
		imprimirA(a^.hd);
	end;
end;
{-----------------Modulo B---------------------}
Procedure buscarCliente(a:arbol; c:integer);
	Function buscarMes(v:vectorC):subMes;
	var max:real; m:subMes; i:integer;
	begin
		max:=-1;
		for i:=1 to dimF do begin
			if(v[i]>max)then begin
				max:=v[i];
				m:=i;
			end;
		end;
		buscarMes:=m;
	end;

var mes:subMes;
begin
	if(a=nil)then
		writeln('No se encontro cliente')
	else
		if(a<>nil)then begin
			if(a^.dato.cliente=c)then begin
				mes:=buscarMes(a^.dato.vectorCliente);
				writeln('El mes con ma compra fue: ', mes);
			end
			else
				if(c<a^.dato.cliente)then
					buscarCliente(a^.hi,c)
				else
					buscarCliente(a^.hd,c);
		end;
end;
{----------------Modulo C-------------------------}
Procedure contar(a:arbol;m:subMes);
	Function contarClientesSinGasto(a:arbol; m:SubMes):integer;
	begin
		if(a=nil)then
			contarClientesSinGasto:=0
		else
			if(a^.dato.vectorCliente[m]=0)then
				contarClientesSinGasto:=1+ contarClientesSinGasto(a^.hi,m)+contarClientesSinGasto(a^.hd,m)
			else
				contarClientesSinGasto:= contarClientesSinGasto(a^.hi,m)+contarClientesSinGasto(a^.hd,m);
		
	end;
var cant:integer;
begin
	cant:=contarClientesSinGasto(a,m);
	writeln('Cantidad de clientes sin compras en el mes ',m,': ', cant);
end;


var a:arbol; c:integer; m:subMes;
BEGIN
	writeln('------------Modulo A-------------');
	randomize;
	cargarArbol(a);
	imprimirA(a);
	writeln('------------Modulo B-------------');
	write('Ingrese cliente a buscar: ');readln(c);
	buscarCliente(a,c);
	writeln('------------Modulo B-------------');
	write('Ingrese mes a buscar: ');readln(m);
	contar(a,m);
END.

