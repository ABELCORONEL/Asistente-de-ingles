SELECT p.termino,
       p.transcripcion_fonetica,
       COUNT(*)                                                        AS total_intentos,
       SUM(CASE WHEN i.es_correcto THEN 0 ELSE 1 END)                  AS intentos_fallidos,
       ROUND(100.0 * SUM(CASE WHEN i.es_correcto THEN 0 ELSE 1 END) / COUNT(*), 1) AS porcentaje_error,
       ROUND(AVG(i.puntaje), 1)                                        AS puntaje_promedio
FROM intento i
JOIN sesion_practica s  ON s.id_sesion = i.id_sesion
JOIN palabra p          ON p.id_palabra = i.id_palabra
JOIN grupo_estudiante ge ON ge.id_estudiante = s.id_estudiante
WHERE s.tipo = 'pronunciacion'
  AND ge.id_grupo = 1
GROUP BY p.id_palabra, p.termino, p.transcripcion_fonetica
HAVING SUM(CASE WHEN i.es_correcto THEN 0 ELSE 1 END) > 0
ORDER BY porcentaje_error DESC, puntaje_promedio ASC;

SELECT u.nombre               AS estudiante,
       p.termino,
       p.traduccion,
       pr.nivel_dominio,
       pr.proximo_repaso
FROM progreso pr
JOIN usuario u ON u.id_usuario = pr.id_estudiante
JOIN palabra p ON p.id_palabra = pr.id_palabra
WHERE pr.proximo_repaso <= CURRENT_DATE
ORDER BY u.nombre, pr.nivel_dominio ASC;

SELECT u.nombre                                                      AS estudiante,
       e.codigo_universitario,
       COUNT(i.id_intento)                                           AS total_intentos,
       ROUND(AVG(i.puntaje), 1)                                      AS puntaje_promedio,
       ROUND(100.0 * AVG(CASE WHEN i.es_correcto THEN 1 ELSE 0 END), 1) AS porcentaje_aciertos
FROM grupo_estudiante ge
JOIN estudiante e            ON e.id_usuario = ge.id_estudiante
JOIN usuario u               ON u.id_usuario = e.id_usuario
LEFT JOIN sesion_practica s  ON s.id_estudiante = e.id_usuario
LEFT JOIN intento i          ON i.id_sesion = s.id_sesion
WHERE ge.id_grupo = 1
GROUP BY u.nombre, e.codigo_universitario
ORDER BY puntaje_promedio ASC NULLS FIRST;
