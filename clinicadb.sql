-- Creacion de Base de Datos

CREATE SCHEMA clinica;
USE clinica;

-- Creacion de las Tablas

CREATE TABLE pacientes (
  id_paciente int NOT NULL,
  nombre_paciente varchar(60) NOT NULL,
  apellido_paciente varchar(50) NOT NULL,
  fecha_de_nacimiento date NOT NULL,
  ocupacion varchar(150) NULL,
  domicilio varchar(150) NOT NULL,
  telefono varchar(20) NOT NULL,
  estado_civil varchar(30) NULL,
  antecedentes text NULL,
  alergias text NULL,
  tipo_sangre varchar(20) NOT NULL,
  id_hc int NOT NULL,
  PRIMARY KEY (id_paciente)
);

CREATE TABLE historias_clinicas (
  id_hc int NOT NULL,
  fecha_alta date NOT NULL,
  documentos blob NULL,
  PRIMARY KEY (id_hc)
);

CREATE TABLE actividades_hc (
  id_actividad_hc int NOT NULL,
  hora_actividad time NOT NULL,
  fecha_actividad date NOT NULL,
  descripcion_act text NOT NULL,
  tipo_actividad varchar(50) NOT NULL,
  id_medico int NOT NULL,
  id_hc int NOT NULL,
  PRIMARY KEY (id_actividad_hc)
);


CREATE TABLE turnos (
  id_turno int NOT NULL,
  hora_inicio time NOT NULL,
  hora_fin time NOT NULL,
  estado_turno varchar(25) NOT NULL,
  fecha date NOT NULL,
  observaciones varchar(200) NOT NULL,
  id_paciente int NOT NULL,
  id_medico int NOT NULL,
  PRIMARY KEY (id_turno)
 );

CREATE TABLE medicos (
  id_medico int NOT NULL,
  nombre_medico varchar(100) NOT NULL,
  matricula varchar(20) NOT NULL,
  especialidad varchar(60) NOT NULL,
  PRIMARY KEY (id_medico)
 );

CREATE TABLE prestadoras (
  id_prestadora int NOT NULL,
  nombre_prestadora varchar(200) NOT NULL,
  id_paciente int NOT NULL,
  PRIMARY KEY (id_prestadora)
 );

CREATE TABLE planes (
  id_plan int NOT NULL,
  nombre_plan varchar(200) NOT NULL,
  descripcion_plan text NULL,
  id_prestadora int NOT NULL,
  PRIMARY KEY (id_plan)
 );

CREATE TABLE medico_plan (
  id_medico_plan int NOT NULL,
  id_medico int NOT NULL,
  id_plan int NOT NULL,
  PRIMARY KEY (id_medico_plan)
 );

#Creacion de Relaciones (FK)

ALTER TABLE pacientes ADD CONSTRAINT fk_id_hc_paciente FOREIGN KEY (id_hc) REFERENCES historias_clinicas(id_hc);
ALTER TABLE actividades_hc ADD CONSTRAINT fk_id_medico_actividad_hc FOREIGN KEY (id_medico) REFERENCES medicos(id_medico);
ALTER TABLE actividades_hc ADD CONSTRAINT fk_id_hc_actividad FOREIGN KEY (id_hc) REFERENCES historias_clinicas(id_hc);
ALTER TABLE turnos ADD CONSTRAINT fk_id_paciente_turno FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente);
ALTER TABLE turnos ADD CONSTRAINT fk_id_medico_turno FOREIGN KEY (id_medico) REFERENCES medicos(id_medico);
ALTER TABLE prestadoras ADD CONSTRAINT fk_id_paciente_prestadora FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente);
ALTER TABLE planes ADD CONSTRAINT fk_id_prestadora_plan FOREIGN KEY (id_prestadora) REFERENCES prestadoras(id_prestadora);
ALTER TABLE medico_plan ADD CONSTRAINT fk_id_medico_plan FOREIGN KEY (id_medico) REFERENCES medicos(id_medico);
ALTER TABLE medico_plan ADD CONSTRAINT fk_id_plan_medico FOREIGN KEY (id_plan) REFERENCES planes(id_plan);
