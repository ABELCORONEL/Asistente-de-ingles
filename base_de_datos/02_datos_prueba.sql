INSERT INTO usuario (nombre, correo, contrasena_hash, rol, fecha_registro) VALUES
    ('Carla Mendoza',   'admin@asistente.test',      'hash_de_prueba', 'administrador', '2026-08-01'),
    ('Luis Quispe',     'lquispe@asistente.test',    'hash_de_prueba', 'docente',       '2026-08-01'),
    ('Ana Flores',      'aflores@asistente.test',    'hash_de_prueba', 'estudiante',    '2026-08-05'),
    ('Diego Mamani',    'dmamani@asistente.test',    'hash_de_prueba', 'estudiante',    '2026-08-05'),
    ('Sofía Rojas',     'srojas@asistente.test',     'hash_de_prueba', 'estudiante',    '2026-08-06'),
    ('Marco Choque',    'mchoque@asistente.test',    'hash_de_prueba', 'estudiante',    '2026-08-06');

INSERT INTO administrador (id_usuario) VALUES (1);

INSERT INTO docente (id_usuario, especialidad) VALUES (2, 'Inglés como lengua extranjera');

INSERT INTO estudiante (id_usuario, codigo_universitario, semestre, nivel_actual) VALUES
    (3, 'SIS-2026-001', 1, 'A1'),
    (4, 'SIS-2026-002', 1, 'A2'),
    (5, 'SIS-2026-003', 1, 'A1'),
    (6, 'SIS-2026-004', 1, 'A1');

INSERT INTO grupo (nombre, gestion, id_docente) VALUES ('Inglés I - Grupo A', '2-2026', 2);

INSERT INTO grupo_estudiante (id_grupo, id_estudiante) VALUES (1, 3), (1, 4), (1, 5), (1, 6);

INSERT INTO categoria (nombre) VALUES ('Saludos y presentaciones'), ('Vida universitaria'), ('Tecnología');

INSERT INTO palabra (termino, traduccion, transcripcion_fonetica, ejemplo_uso, nivel, audio_referencia, id_categoria) VALUES
    ('greeting',   'saludo',        '/ˈɡriːtɪŋ/',    'A friendly greeting starts the class.',   'A1', 'audios/greeting.mp3',   1),
    ('through',    'a través de',   '/θruː/',        'We walk through the campus.',             'A2', 'audios/through.mp3',    1),
    ('schedule',   'horario',       '/ˈskedʒuːl/',   'Check your class schedule.',              'A2', 'audios/schedule.mp3',   2),
    ('vegetable',  'verdura',       '/ˈvedʒtəbəl/',  'The cafeteria serves vegetable soup.',    'A1', 'audios/vegetable.mp3',  2),
    ('thought',    'pensamiento',   '/θɔːt/',        'I thought the exam was easy.',            'A2', 'audios/thought.mp3',    2),
    ('keyboard',   'teclado',       '/ˈkiːbɔːrd/',   'Type your name on the keyboard.',         'A1', 'audios/keyboard.mp3',   3),
    ('software',   'programa',      '/ˈsɔːftwer/',   'This software helps you practice.',       'A1', 'audios/software.mp3',   3),
    ('algorithm',  'algoritmo',     '/ˈælɡərɪðəm/',  'The algorithm recommends new words.',     'B1', 'audios/algorithm.mp3',  3);

INSERT INTO sesion_practica (id_estudiante, tipo, fecha_inicio, fecha_fin, puntaje_promedio) VALUES
    (3, 'pronunciacion', '2026-10-20 10:00', '2026-10-20 10:15', 61.25),
    (4, 'pronunciacion', '2026-10-20 11:00', '2026-10-20 11:12', 78.33),
    (5, 'pronunciacion', '2026-10-21 09:30', '2026-10-21 09:45', 55.00),
    (6, 'vocabulario',   '2026-10-21 16:00', '2026-10-21 16:20', 85.00),
    (3, 'pronunciacion', '2026-10-22 10:00', '2026-10-22 10:10', 72.50);

INSERT INTO intento (id_sesion, id_palabra, texto_reconocido, puntaje, es_correcto, fecha_hora) VALUES
    (1, 2, 'true',       35.00, FALSE, '2026-10-20 10:02'),
    (1, 5, 'taught',     45.00, FALSE, '2026-10-20 10:05'),
    (1, 4, 'vegetable',  90.00, TRUE,  '2026-10-20 10:08'),
    (1, 8, 'algorithm',  75.00, TRUE,  '2026-10-20 10:12'),
    (2, 2, 'through',    80.00, TRUE,  '2026-10-20 11:03'),
    (2, 3, 'school',     55.00, FALSE, '2026-10-20 11:06'),
    (2, 8, 'algorithm', 100.00, TRUE,  '2026-10-20 11:10'),
    (3, 2, 'drew',       30.00, FALSE, '2026-10-21 09:33'),
    (3, 5, 'thought',    70.00, TRUE,  '2026-10-21 09:37'),
    (3, 3, 'skedule',    65.00, FALSE, '2026-10-21 09:41'),
    (4, 6, 'keyboard',   85.00, TRUE,  '2026-10-21 16:05'),
    (5, 2, 'thru',       60.00, FALSE, '2026-10-22 10:03'),
    (5, 5, 'thought',    85.00, TRUE,  '2026-10-22 10:07');

INSERT INTO progreso (id_estudiante, id_palabra, aciertos, fallos, nivel_dominio, proximo_repaso) VALUES
    (3, 2, 0, 2, 0.10, '2026-10-23'),
    (3, 5, 1, 1, 0.50, '2026-10-24'),
    (3, 4, 1, 0, 0.80, '2026-10-30'),
    (3, 8, 1, 0, 0.70, '2026-10-28'),
    (4, 2, 1, 0, 0.75, '2026-10-29'),
    (4, 3, 0, 1, 0.20, '2026-10-22'),
    (4, 8, 1, 0, 0.90, '2026-11-05'),
    (5, 2, 0, 1, 0.15, '2026-10-22'),
    (5, 5, 1, 0, 0.60, '2026-10-27'),
    (5, 3, 0, 1, 0.25, '2026-10-23'),
    (6, 6, 1, 0, 0.80, '2026-10-31');
