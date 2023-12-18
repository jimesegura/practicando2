{
   1.- Implementar un programa que procese la información de los alumnos de la Facultad de
Informática.
a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de
todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso,
cantidad de materias aprobadas (a lo sumo 36) y nota obtenida (sin contar los aplazos) en cada
una de las materias aprobadas. La lectura finaliza cuando se ingresa el número de alumno
11111, el cual debe procesarse.
b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne número
de alumno y promedio de cada alumno.
c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de
materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?
}


program Ejercicio1;
const
		dimF =36;

type 
	vectorNotas= array[1..dimF] of integer;
	
	alumnos=record
		apellido:String;
		numeroAlu:integer;
		anioIngreso:integer;
		materiasAp:integer;
		nota:vectorNotas;
	end;
		
	listaAlu= ^datosAlumnos;
		datosAlumnos=record
			datos:alumnos;
			sig:listaAlu;
		end;
//--------------------------------------------------
Procedure cargarVectorNotas(var vec:vectorNotas; materiasAp:integer);
var i:integer; nota:integer;
begin
	nota:=0;
	i:=0;
	for i:= 1 to materiasAp do
	begin
		writeln('Ingrese nota de la materia ', i);
		readln(nota);
		vec[i]:=nota;
	end;
	
end;

//---------------------------------------------------
Procedure agregarAdelante(a: alumnos; var listaA:listaAlu);
var nuevo: listaAlu;
begin
	
	new(nuevo);
	nuevo^.datos:=a;
	nuevo^.sig:=nil;
	
	if(listaA=nil) then
		listaA:=nuevo
	else begin
		nuevo^.sig:=listaA;
		listaA:=nuevo;
	end;
end;
//----------------------------------------------------
Procedure cargarAlumnos(var a:alumnos; var listaA:listaAlu);
begin
		writeln('Ingrese numero de alumno');
		readln(a.numeroAlu);
		while(a.numeroAlu<>11111) do 
		begin
			writeln('Ingrese apellido');
			readln(a.apellido);
			writeln('Ingrse anio de ingreso');
			readln(a.anioIngreso);
			writeln('Ingrese cantidad de materia aprobadas');
			readln(a.materiasAp);
			
			cargarVectorNotas(a.nota, a.materiasAp);
			agregarAdelante(a, listaA);
			
			writeln('Ingrese numero de alumno');
			readln(a.numeroAlu);
		end;
end;		
//-------------------------------------------------------	
Procedure imprimirLista(listaA:listaAlu);
var aux:listaAlu; sumaNotas, prom,dimL,i:integer;
begin
	aux:=listaA;
	while(aux<>nil) do
	begin
		sumaNotas:=0;
		prom:=0;
		dimL:=0;
		i:=0;
		dimL:=aux^.datos.materiasAp;
		for i:= 1 to dimL do
		begin
			sumaNotas:=sumaNotas+aux^.datos.nota[i];
		end;
		prom:=sumaNotas div dimL;
		writeln('Numero de alumno: ',aux^.datos.numeroAlu);
		//writeln('Numero de alumno: ',aux^.datos.materiasAp);
		writeln('Promedio: ',prom);
		aux:=aux^.sig;
		
	end;
end;

var a:alumnos; listaA:listaAlu;
BEGIN
	listaA:=nil;
	cargarAlumnos(a, listaA);
	imprimirLista(listaA);
	
END.

