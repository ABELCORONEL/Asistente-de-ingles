CREATE TABLE usuario (
    id_usuario       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre           VARCHAR(100) NOT NULL,
    correo           VARCHAR(120) NOT NULL UNIQUE,
    contrasena_hash  VARCHAR(255) NOT NULL,
    rol              VARCHAR(20)  NOT NULL CHECK (rol IN ('estudiante', 'docente', 'administrador')),
    fecha_registro   DATE         NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE estudiante (
    id_usuario            INTEGER PRIMARY KEY REFERENCES usuario (id_usuario) ON DELETE CASCADE,
    codigo_universitario  VARCHAR(20) NOT NULL UNIQUE,
    semestre              SMALLINT    NOT NULL CHECK (semestre BETWEEN 1 AND 10),
    nivel_actual          VARCHAR(2)  NOT NULL DEFAULT 'A1' CHECK (nivel_actual IN ('A1', 'A2', 'B1', 'B2', 'C1', 'C2'))
);

CREATE TABLE docente (
    id_usuario    INTEGER PRIMARY KEY REFERENCES usuario (id_usuario) ON DELETE CASCADE,
    especialidad  VARCHAR(100) NOT NULL
);

CREATE TABLE administrador (
    id_usuario  INTEGER PRIMARY KEY REFERENCES usuario (id_usuario) ON DELETE CASCADE
);

CREATE TABLE grupo (
    id_grupo    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre      VARCHAR(60) NOT NULL,
    gestion     VARCHAR(10) NOT NULL,
    id_docente  INTEGER     NOT NULL REFERENCES docente (id_usuario),
    UNIQUE (nombre, gestion)
);

CREATE TABLE grupo_estudiante (
    id_grupo       INTEGER NOT NULL REFERENCES grupo (id_grupo) ON DELETE CASCADE,
    id_estudiante  INTEGER NOT NULL REFERENCES estudiante (id_usuario) ON DELETE CASCADE,
    PRIMARY KEY (id_grupo, id_estudiante)
);

CREATE TABLE categoria (
    id_categoria  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre        VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE palabra (
    id_palabra              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    termino                 VARCHAR(80)  NOT NULL UNIQUE,
    traduccion              VARCHAR(120) NOT NULL,
    transcripcion_fonetica  VARCHAR(80),
    ejemplo_uso             VARCHAR(255),
    nivel                   VARCHAR(2)   NOT NULL CHECK (nivel IN ('A1', 'A2', 'B1', 'B2', 'C1', 'C2')),
    audio_referencia        VARCHAR(255),
    id_categoria            INTEGER      NOT NULL REFERENCES categoria (id_categoria)
);

CREATE TABLE sesion_practica (
    id_sesion         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_estudiante     INTEGER     NOT NULL REFERENCES estudiante (id_usuario) ON DELETE CASCADE,
    tipo              VARCHAR(15) NOT NULL CHECK (tipo IN ('vocabulario', 'pronunciacion')),
    fecha_inicio      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin         TIMESTAMP,
    puntaje_promedio  NUMERIC(5,2) CHECK (puntaje_promedio BETWEEN 0 AND 100),
    CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE intento (
    id_intento        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_sesion         INTEGER      NOT NULL REFERENCES sesion_practica (id_sesion) ON DELETE CASCADE,
    id_palabra        INTEGER      NOT NULL REFERENCES palabra (id_palabra),
    texto_reconocido  VARCHAR(255),
    puntaje           NUMERIC(5,2) NOT NULL CHECK (puntaje BETWEEN 0 AND 100),
    es_correcto       BOOLEAN      NOT NULL,
    fecha_hora        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE progreso (
    id_estudiante   INTEGER      NOT NULL REFERENCES estudiante (id_usuario) ON DELETE CASCADE,
    id_palabra      INTEGER      NOT NULL REFERENCES palabra (id_palabra),
    aciertos        INTEGER      NOT NULL DEFAULT 0 CHECK (aciertos >= 0),
    fallos          INTEGER      NOT NULL DEFAULT 0 CHECK (fallos >= 0),
    nivel_dominio   NUMERIC(3,2) NOT NULL DEFAULT 0 CHECK (nivel_dominio BETWEEN 0 AND 1),
    proximo_repaso  DATE         NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_estudiante, id_palabra)
);

CREATE INDEX idx_intento_sesion ON intento (id_sesion);
CREATE INDEX idx_intento_palabra ON intento (id_palabra);
CREATE INDEX idx_sesion_estudiante ON sesion_practica (id_estudiante);
CREATE INDEX idx_progreso_repaso ON progreso (proximo_repaso);
