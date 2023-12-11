-- 1. ¿Cuántos usuarios tenemos?
--     130.
-- 2. En promedio, ¿cuánto tiempo tarda un pedido desde que se realiza hasta que se entrega?
-- 3. ¿Cuántos usuarios han realizado una sola compra? ¿Dos compras? ¿Tres o más compras?
-- - *Nota: debe considerar una compra como un solo pedido. En otras palabras, si un usuario realiza un pedido de 3 productos, se considera que ha realizado 1 compra.*
-- 4. En promedio, ¿Cuántas sesiones únicas tenemos por hora?


-- No funciona.


WITH sesion as (
    SELECT 
        count (*) as numero,
        session_id,
        MIN(created_at) as hora
    FROM stg_events

    GROUP BY session_id
),

promedio as (
    SELECT
        numero,
        count (session_id),
        hora
    FROM sesion
    WHERE numero = 1
    GROUP BY hora, numero
    ORDER BY hora
)

SELECT * FROM promedio

