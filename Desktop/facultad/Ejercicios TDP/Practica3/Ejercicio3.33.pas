{Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y los almacene en
una estructura de datos. De cada alumno se lee legajo, DNI, año de ingreso y los códigos y
notas de los finales rendidos. La estructura generada debe ser eficiente para la búsqueda por
número de legajo. La lectura de los alumnos finaliza con legajo 0 y para cada alumno el ingreso
de las materias finaliza con el código de materia -1.
b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso de
aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande.
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
e. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.
f. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.
}


program untitled;

type
	materias=record
		codigoFinal:integer;
		notaFinal:integer;
	end;
	listaM=^datosmaterias;
		datosMaterias=record
		elem:materias;
		sig:listaM;
	end;
	
	alumno=record
		legajo:integer;
		dni:integer;
		anioIngreso:integer;
		finales:listaM;
	end;
	
	arbol=^datosAlumnos;
		datosAlumnos=record
			elem:alumno;
			hi:arbol;
			hd:arbol;
		end;

Procedure cargarArbol(var a:arbol);

	Procedure agregarListaF(var l:listaM; m:materias);
	var nuevo:listaM;
		begin
			if(l=nil)then
			begin
				new (nuevo);
				nuevo^.elem:=m;
				nuevo^.sig:=nil;
				l:=nuevo;
			end;
		end;	
			
	Procedure leerAlumno(var alu:alumno;var m:materias);					
	begin
		write('Ingrese legajo'); readln(alu.legajo);
		if(alu.legajo<>0)then
		begin
			write('Ingrese dni'); readln(alu.dni);
			write('Ingrese anio de ingreso'); readln(alu.anioIngreso);
			write('Ingrese finales');
			write('Ingrese codigo del final');readln(m.codigofinal);
			while (m.codigoFinal<>-1)do begin
				write('Ingrese nota del final');readln(m.notaFinal);
				agregarListaF(alu.finales, m);
				write('Ingrese codigo del final');readln(m.codigofinal);
			end;
		end;
	end;
	
	Procedure agregarA(var a:arbol; alu:alumno);
	begin
		if(a=nil)then
		begin
			new(a);
			a^.elem:=alu;
			a^.hi:=nil;
			a^.hd:=nil
		end
		else
			if(alu.legajo<a^.elem.legajo)then
				agregarA(a^.hi,alu)
			else
				agregarA(a^.hd,alu);
	end;

var alu:alumno; m:materias;
begin
	leerAlumno(alu,m);
	while(alu.legajo<>0)do
	begin
		agregarA(a,alu);
		leerAlumno(alu,m);
	end;
end;

Procedure imprimir(a:arbol);
	Procedure imprimirLista(l:listaM);
	begin
		while (l<>nil)do
		begin
			writeln('codigo materia:', l^.elem.codigoFinal);
			writeln('nota final:', l^.elem.notaFinal);
			l:=l^.sig;
		end;
	end;
begin
	if(a<>nil)then
	begin
		imprimir(a^.hi);
		writeln(a^.elem.legajo);
		imprimirLista(a^.elem.finales);
		imprimir(a^.hd);
	end;
end;
Function buscarLegajoMayor(a:arbol):integer;
begin
	if(a<>nil)then
	begin
		writeln('1');
		if(buscarLegajoMayor(a)<a^.elem.legajo)then
			buscarLegajoMayor:=a^.elem.legajo
		else
			buscarLegajoMayor:=buscarLegajoMayor(a^.hd);
	end
	else
		buscarLegajoMayor:=0;
end;	


var a:arbol; legajoMayor:integer;
BEGIN
	cargarArbol(a);
	//imprimir(a);
	writeln('hfhjhbkj');
	legajoMayor:=buscarLegajoMayor(a);
	writeln('hfhjhbkj');
	writeln('Legajo mayor: ', legajoMayor);
END.

