text = "TEST DE MOUSE :3"
block = 1
angul = 0
gato_valores = {
    xcor = 260,
    ycor = 200,
    scalex = 1,
    scaley = 1,
    red = 255,
    blue = 255,
    green = 255,
}
ANCHO_JUEGO = 500
ALTO_JUEGO = 400
entradas_escenas = {
    [1] = {entrada1X = 25, entrada1Y1 = 752, entrada1Y2 = 706, escena = 2, nuevaXcat = 1006, nuevaYcat = 772},
}
dtt = 0
anim = 12
accion = 0
tiempo = 0
minutos = 0
segundos = 0
dial = 0
dialDT = 0
--maps
mapa_test = require('maps/mapa_test')
mapa1 = require('maps/map1')
city = require('maps/city')

TILE = 32  -- tamaño de cada casillero en píxeles

tile_solido = {
    [2] = true,
    [4] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [16] = true,
    [17] = true,
    [18] = true,
    [19] = true,
    [20] = true,
    [21] = true,
    [22] = true,
    [23] = true,
    [24] = true,
    [45] = true,
    [50] = true,
    [51] = true,
    [52] = true,
}
tile_pescable = {
    [9] = true,
}

-- Ajustá estos 4 números mirando cómo queda visualmente
hitbox_ancho = 40
hitbox_alto = 20
hitbox_offset_x = -23   -- cuánto mover en X para centrar (normalmente -ancho/2)
hitbox_offset_y = 28    -- cuánto mover en Y para que quede a la altura de los pies

function getHitbox()
    local x = gato_valores.xcor + hitbox_offset_x
    local y = gato_valores.ycor + hitbox_offset_y
    return x, y, hitbox_ancho, hitbox_alto
end

camara = {x = 0, y = 0}
--pica de la pesca
tirar_caña = {
    tirar_valor = 0,
    tiempo_de_empuje = 1.5,
    tiempo_de_empuje_orig = 1.5,
    cant_bottom = 0,
    veces_bottom = 0,
}

--peces valores
pez = 0
nemo = 0
furry = 0
salmon = 0
peru = 0
test = 255
pezitem = 0
xpez = 290
ypez = 350
dtpez = 0
pezmode = 0
pezdt = 0
textward = "NO PUEDES PESCAR SIN CARNADA"
peces_valor = {
    nemo = 10,
    furry = 12,
    salmon = 40,
    peru = 20,
    test = 255,
}

tienda = require('librery/tienda')
dialogo = require('librery/dialogo')
--obj
gusano = 10
cañatipy = 1
--bool
debug = false
patf = false

--mapas
escenas = 0
UI_obj_visible = {
    [0] = {bolsa = false, dinero = false, ui_obj = false, jugador = true, camara = false, movimiento = false, escena = mapa1},
    [1] = {bolsa = true, dinero = true, ui_obj = true, jugador = true, camara = true, movimiento = true, escena = mapa1},
    [2] = {bolsa = true, dinero = true, ui_obj = true, jugador = true, camara = true, movimiento = true, escena = city},
    [3] = {bolsa = false, dinero = true, ui_obj = false, jugador = false, camara = false, movimiento = false, escena = nill},
    [4] = {bolsa = false, dinero = true, ui_obj = false, jugador = false, camara = false, movimiento = false, escena = nill},
    [5] = {bolsa = true, dinero = true, ui_obj = true, jugador = true, camara = true, movimiento = true, escena = mapa_test},
}
-- metatable que hace que cualquier campo faltante devuelva false
local mt_flags = {__index = function(_, clave) return false end}

-- aplicarla a cada entrada existente de UI_obj_visible
for _, datos in pairs(UI_obj_visible) do
    setmetatable(datos, mt_flags)
end

-- y aplicar otra metatable a UI_obj_visible para que, si "escenas"
-- no tiene entrada, devuelva una tabla vacía (que a su vez también
-- devuelve false en cualquier campo gracias a mt_flags)
setmetatable(UI_obj_visible, {
    __index = function(_, clave)
        return setmetatable({}, mt_flags)
    end
})

inv = 0
circulos = {}
cubos = {}
fishes = {}
Xmou=love.mouse.getCursor()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(500, 400, {resizable = true})
    
    love.window.setTitle("fishing cat (0.6 Ver. DEV, Nueva tienda de personalizacion!)")
    local iconoData = love.image.newImageData('icon/icono.png')
    love.window.setIcon(iconoData)
    --FONT
    monoft = love.graphics.newFont('font/mono.ttf', 12)
    monoftlong = love.graphics.newFont('font/mono.ttf', 18)
    monoftlonglong = love.graphics.newFont('font/mono.ttf', 30)
    -- cat sprite -- normal
    cat = love.graphics.newImage('assets/player/cat1.png')
    cat1 = love.graphics.newImage('assets/player/cat2.png')
    --sacar caña
    cat2 = love.graphics.newImage('assets/player/cat3.png')
    cat3 = love.graphics.newImage('assets/player/cat4.png')
    cat4 = love.graphics.newImage('assets/player/cat5.png')
    cat5 = love.graphics.newImage('assets/player/cat6.png')
    -- normal con caña
    cat6 = love.graphics.newImage('assets/player/cat7.png')
    cat7 = love.graphics.newImage('assets/player/cat8.png')
    --pescar
    cat8 = love.graphics.newImage('assets/player/cat9.png')
    cat9 = love.graphics.newImage('assets/player/cat10.png')
    cat10 = love.graphics.newImage('assets/player/cat11.png')
    cat11 = love.graphics.newImage('assets/player/cat12.png')
    cat12 = love.graphics.newImage('assets/player/cat13.png')
    cat13 = love.graphics.newImage('assets/player/cat14.png')
    cat14 = love.graphics.newImage('assets/player/cat15.png')
    cat15 = love.graphics.newImage('assets/player/cat16.png')
    cat16 = love.graphics.newImage('assets/player/cat17.png')
    --peces sprite
    pezind = love.graphics.newImage('assets/peces/mini_pez.png')
    pez1 = love.graphics.newImage('assets/peces/pez.png')
    pez2 = love.graphics.newImage('assets/peces/pez1.png')
    pez3 = love.graphics.newImage('assets/peces/pez2.png')
    pez4 = love.graphics.newImage('assets/peces/pez3.png')
    nada = love.graphics.newImage('assets/peces/nada_1.png')
    nada1 = love.graphics.newImage('assets/peces/nada_2.png')
    nada2 = love.graphics.newImage('assets/peces/nada_3.png')
    nada3 = love.graphics.newImage('assets/peces/nada_4.png')
    --algo plus
    oneplus = love.graphics.newImage('assets/inv/1.png')
    twoplus = love.graphics.newImage('assets/inv/2.png')
    --inv
    bolsC = love.graphics.newImage('assets/inv/bolsa1.png')
    bolsA = love.graphics.newImage('assets/inv/bolsa2.png')
    bolsM = love.graphics.newImage('assets/inv/bolsa_money.png')
    usar = love.graphics.newImage('assets/inv/usar.png')
    dejar = love.graphics.newImage('assets/inv/dejar.png')
    cbootom = love.graphics.newImage('assets/inv/C_bottom.png')
    pescar = love.graphics.newImage('assets/inv/pesca_X.png')
    caña = love.graphics.newImage('assets/inv/caña.png')
    pescando = love.graphics.newImage('assets/inv/pescando.png')
    puerta = love.graphics.newImage('assets/inv/puerta.png')
    bottom_x_1 = love.graphics.newImage('assets/inv/bottom_x_1.png')
    bottom_x_2 = love.graphics.newImage('assets/inv/bottom_x_2.png')
    --obj
    gusanospr = love.graphics.newImage('assets/obj/gusano2.png')
    barra = love.graphics.newImage('assets/obj/barra.png')
    one = love.graphics.newImage('assets/obj/1.png')
    two = love.graphics.newImage('assets/obj/2.png')
    three = love.graphics.newImage('assets/obj/3.png')
    four = love.graphics.newImage('assets/obj/4.png')
    five = love.graphics.newImage('assets/obj/5.png')
    six = love.graphics.newImage('assets/obj/6.png')
    seven = love.graphics.newImage('assets/obj/7.png')
    eight = love.graphics.newImage('assets/obj/8.png')
    nine = love.graphics.newImage('assets/obj/9.png')
    zero = love.graphics.newImage('assets/obj/0.png')
    --fondos
    testf = love.graphics.newImage('assets/fondos/test.png')
    testcity = love.graphics.newImage('assets/fondos/citytest.png')
    fontshop = love.graphics.newImage('assets/fondos/fondo_shop.png')
    fontshop2 = love.graphics.newImage('assets/fondos/fondo_shop2_1.png')
    fontshop3 = love.graphics.newImage('assets/fondos/fondo_shop2.png')
    fontcustom = love.graphics.newImage('assets/fondos/fondo_custom.png')
    foco_spr = love.graphics.newImage('assets/fondos/spotlight.png')
    --tienda
    faceshop1 = love.graphics.newImage('assets/shop/shop_face1.png')
    selec = love.graphics.newImage('assets/shop/selec.png')
    --musica
    coin = love.audio.newSource('music/CoinToss.mp3', "static")
    nopesound = love.audio.newSource('music/SFX_DENIED.wav', "static")
    comprasound = love.audio.newSource('music/SFX_PRESS_AB.wav', "static")
    --tiles
    tileset = love.graphics.newImage('assets/tiles/tiles_map1.png')
    --mapa
    maptienda = love.graphics.newImage('assets/npc/vendedora.png')
    coin:setLooping(true)
    nopesound:setLooping(false)
    comprasound:setLooping(false)
    coin:play()
    tiburocin = love.graphics.newImage('assets/tiburon.png')

vendedora_cord = {
    [2] = {xcor = 650, ycor = 740, margen = 40, xcor2 = 368, ycor2 = 676, margen2 = 40,}
}
TILE_SRC = 32  -- tamaño de cada tile DENTRO de la imagen

tile_quads = {}

for id = 1, 56 do
    local columna = (id - 1) % 8
    local fila = math.floor((id - 1) / 8)

    tile_quads[id] = love.graphics.newQuad(
        columna * TILE_SRC,
        fila * TILE_SRC,
        TILE_SRC,
        TILE_SRC,
        tileset:getDimensions()
    )
end

sprites_anim = {
    [0] = cat,
    [1] = cat1,
    [2] = cat2,
    [3] = cat3,
    [4] = cat4,
    [5] = cat5,
    [6] = cat6,
    [7] = cat7,
    [8] = cat7,
    [9] = cat8,
    [10] = cat9,
    [11] = cat10,
    [12] = cat11,
    [13] = cat12,
    [14] = cat13,
    [15] = cat14,
    [16] = cat15,
    [17] = cat16,
}
peces_sprite = {
    [0] = {nombre = cat10, scale = 1},
    [1] = {nombre = pez1, scale = 1},
    [2] = {nombre = pez2, scale = 1},
    [3] = {nombre = pez4, scale = 2.2},
    [4] = {nombre = pez3, scale = 1},
    [5] = {nombre = nada3, scale = 1},
}
end



function love.update(dt)
    --tiempo del juego

    tiempo = tiempo + dt

    if tiempo >= 1 then
        tiempo = 0
        segundos = segundos + 1
    end

    if segundos == 60 then
        segundos = 0
        minutos = minutos + 1
    end

    --SISTEMA DE MOVIMIENTO

    dtt = dtt + dt

    if dtt >= 0.2 and anim == 0 and accion == 0 then
        dtt = 0
        anim = 1
    end

    if dtt >= 0.2 and anim == 1 and accion == 0 then
        dtt = 0
        anim = 0
    end

    --sistema de movimiento con caña

    if dtt >= 0.2 and anim == 6 and accion == 0 then
        dtt = 0
        anim = 7
    end

    if dtt >= 0.2 and anim == 7 and accion == 0 then
        dtt = 0
        anim = 6
    end

    --sacar y meter caña

    if dtt >= 0.2 and dtt <= 0.8 and anim <= 1 and accion == 1 then
        anim = 2
    end

    if dtt >= 0.8 and dtt <= 1.9 and accion == 1 then
        anim = 3
    end

    if dtt >= 1.9 and dtt <= 1.95 and accion == 1 then
        anim = 4
    end

    if dtt >= 2.0 and dtt <= 2.05 and accion == 1 then
        anim = 5
    end

    if dtt >= 2.1 and dtt <= 2.3 and accion == 1 then
        anim = 6
    end

    if dtt >= 2.3 and dtt <= 2.5 and accion == 1 then
        anim = 6
        accion = 0
    end

    --parte meter, la caña >:3

    if dtt >= 0.5 and dtt <= 1.2 and accion == 2 then
        anim = 0
        accion = 0
    end

    --Pescar

    if dtt >= 0.5 and dtt <= 0.8 and accion == 3 then
        anim = 10
    end

    if dtt >= 0.8 and dtt <= 1.0 and accion == 3 then
        anim = 11
    end

    if dtt >= 1.0 and dtt <= 2.5 and accion == 3 then
        anim = 12
    end

    if dtt >= 4.5 and dtt <= 4.7 and accion == 3 then
        anim = 14
        tirar_caña.tirar_valor = love.math.random(1, 7)
        tirar_caña.tiempo_de_empuje = love.math.random(2, 5)
        tirar_caña.cant_bottom = love.math.random(5, 16)
        if tirar_caña.tirar_valor >= 4 then
            accion = 4
            tirar_caña.tiempo_de_empuje_orig = tirar_caña.tiempo_de_empuje
        elseif tirar_caña.tirar_valor <= 3 then
            accion = 3
            dtt = 4.7
            tirar_caña.tiempo_de_empuje = 1.5
            tirar_caña.tirar_valor = 0
        end
    end

    if dtt >= 4.7 and dtt <= 5.0 and accion == 3 then
        anim = 14
    end

    if dtt >= 5.0 and dtt <= 5.2 and accion == 3 then
        anim = 9
    end

    if dtt >= 5.2 and dtt <= 5.6 and accion == 3 then
        if tirar_caña.cant_bottom ~= tirar_caña.veces_bottom then
            anim = 17
        elseif tirar_caña.cant_bottom == tirar_caña.veces_bottom then
            anim = 7
            accion = 0
            pez = love.math.random(4, 15)
        end
        tirar_caña.veces_bottom = 0  -- acá sí, ya usamos el valor, ahora lo limpiamos
    end

    if dtt >= 5.6 and dtt <= 6.4 and accion == 3 then
        anim = 7
        accion = 0
        pez = 1
    end

    --empuje de la caña
    if dtt >= 0.2 and anim == 14 and accion == 4 then
        dtt = 0
        anim = 16
    end

    if dtt >= 0.2 and anim == 16 and accion == 4 then
        dtt = 0
        anim = 14
    end

    -- 1) Restar tiempo, SIN el freno de >= 0 (dejalo bajar hasta el timeout real)
    if accion == 4 then
        tirar_caña.tiempo_de_empuje = tirar_caña.tiempo_de_empuje - 0.01
    end

    -- 2) Timeout: se escapó porque no llegaste a tiempo
    if tirar_caña.tiempo_de_empuje < 0 and tirar_caña.veces_bottom ~= tirar_caña.cant_bottom and accion == 4 then
        accion = 3
        dtt = 4.7
        tirar_caña.tiempo_de_empuje = 1.5
        tirar_caña.tirar_valor = 0
        tirar_caña.veces_bottom = 0
    end

    -- 3) Éxito: ya apretaste las veces necesarias, sin importar el tiempo restante
    if tirar_caña.veces_bottom == tirar_caña.cant_bottom and accion == 4 then
        accion = 3
        dtt = 4.7
        tirar_caña.tiempo_de_empuje = 1.5
        tirar_caña.tirar_valor = 0
        -- OJO: sacamos el reset de veces_bottom de acá
    end

    function getHitboxEn(px, py)
        return px + hitbox_offset_x, py + hitbox_offset_y, hitbox_ancho, hitbox_alto
    end
    
        local jugador_ancho, jugador_alto = 80, 40  -- ajustable según tu sprite
        local movevalor = UI_obj_visible[escena]

    if movevalor then
        if movevalor.movimiento == true then

            if love.keyboard.isDown("left") and accion <= 0 then
                local nuevoX = gato_valores.xcor - 2.0
                local hx, hy, hw, hh = getHitboxEn(nuevoX, gato_valores.ycor)
                if not colisionaMapa(hx, hy, hw, hh) then
                    gato_valores.xcor = nuevoX
                    gato_valores.scalex = 1
                end
            end

            if love.keyboard.isDown("right") and accion <= 0 then
                local nuevoX = gato_valores.xcor + 2.0
                local hx, hy, hw, hh = getHitboxEn(nuevoX, gato_valores.ycor)
                if not colisionaMapa(hx, hy, hw, hh) then
                    gato_valores.xcor = nuevoX
                    gato_valores.scalex = -1
                end
            end

            if love.keyboard.isDown("up") and accion <= 0 then
                local nuevoY = gato_valores.ycor - 2.0
                local hx, hy, hw, hh = getHitboxEn(gato_valores.xcor, nuevoY)
                if not colisionaMapa(hx, hy, hw, hh) then
                    gato_valores.ycor = nuevoY
                end
            end

            if love.keyboard.isDown("down") and accion <= 0 then
                local nuevoY = gato_valores.ycor + 2.0
                local hx, hy, hw, hh = getHitboxEn(gato_valores.xcor, nuevoY)
                if not colisionaMapa(hx, hy, hw, hh) then
                    gato_valores.ycor = nuevoY
                end
            end
        end
    end

    local camaravalida = UI_obj_visible[escenas]

    if camaravalida.camara == true then

        local mapa_actual = camaravalida.escena
        if mapa_actual then
            local anchoMapa = #mapa_actual[1] * TILE
            local altoMapa = #mapa_actual * TILE

            camara.x = gato_valores.xcor - ANCHO_JUEGO / 2
            camara.y = gato_valores.ycor - ALTO_JUEGO / 2

            if camara.x < 0 then
                camara.x = 0
            end

            if camara.y < 0 then
                camara.y = 0
            end

            if camara.x > anchoMapa - ANCHO_JUEGO then
                camara.x = anchoMapa - ANCHO_JUEGO
            end

            if camara.y > altoMapa - ALTO_JUEGO then
                camara.y = altoMapa - ALTO_JUEGO
            end
        end
    end

    --PEZ sistema
    if pez <= 4 and pez >= 1 then -- nada
        pez = 0
        pezitem = 5
    end

    if pez >= 5 and pez <= 8 then -- nemo
        nemo = nemo + 1
        pez = 0
        pezitem = 1
    end

    if pez >= 9 and pez <= 11 then -- furry
        furry = furry + 1
        pez = 0
        pezitem = 2
    end

    if pez == 12 then --salmon
        salmon = salmon + 1
        pez = 0
        pezitem = 3
    end

    if pez >= 13 and pez <= 15 then --peru
        peru = peru + 1
        pez = 0
        pezitem = 4
    end

    if pezitem >= 1 and dtpez <= 2.0 then
        ypez = ypez - 2
        dtpez = dtpez + dt
    end

    if dtpez >= 0.5 and dtpez <= 2.0 then
        ypez = 290
    end

    if dtpez >= 2.0 then
        ypez = ypez + 2
        dtpez = dtpez + dt
    end

    if dtpez >= 3.0 then
        dtpez = 0
        pezitem = 0
        ypez = 350
    end

    pezdt = pezdt + dt

    

    for i, fish in ipairs(fishes) do
        if pezdt >= 1.0 then
            pezdt = 0
            fish.pezmode = love.math.random(1,6)
        end

        if fish.pezmode <= 3 then
            fish.x = fish.x + fish.speed * dt
        end

        if fish.pezmode >= 4 then
            fish.x = fish.x - fish.speed * dt
        end
    
        if fish.x >= 130 then
            table.remove(fishes, i)
            break
        end
    end

    --dialogo

    dialDT = dialDT + dt

    if dialDT >= 1 then
        dialDT = 0
    end

    local nombre_actual = nil
    for _, info in pairs(tienda.peces_info) do
        if info.estashop == tienda.estashop then
            nombre_actual = info.nombre
            break
        end
    end

    if nombre_actual and tienda.cantp >= _G[nombre_actual] then
        tienda.cantp = _G[nombre_actual]
    end

    if tienda.cantp <= 0 then
        tienda.cantp = 0
    end

    if dial <= 1 then
        dial = 1
    end

    if type(dialogo[dial]) == "function" then
        text = dialogo[dial]()
    else
        text = dialogo[dial] or ""
    end

    --tienda.dinero y obj, litmites
    if tienda.dinero <= 0 then
        tienda.dinero = 0
    end

    if gusano >= tienda.mejoras.cap_pez then
        gusano = tienda.mejoras.cap_pez
    end

    local entrada = entradas_escenas[escenas]
    if entrada then
        if gato_valores.xcor <= entrada.entrada1X and gato_valores.ycor <= entrada.entrada1Y1 and gato_valores.ycor >= entrada.entrada1Y2 then
            escenas = entrada.escena
            gato_valores.xcor = entrada.nuevaXcat
            gato_valores.ycor = entrada.nuevaYcat
        end
    end
end

function love.draw(screen)
    local ancho = love.graphics.getWidth()
    local alto = love.graphics.getHeight()

    local escala = math.min(
        ancho / ANCHO_JUEGO,
        alto / ALTO_JUEGO
    )

    local offsetX = (ancho - ANCHO_JUEGO * escala) / 2
    local offsetY = (alto - ALTO_JUEGO * escala) / 2

    love.graphics.setScissor(
        offsetX,
        offsetY,
        ANCHO_JUEGO * escala,
        ALTO_JUEGO * escala
    )

    love.graphics.push()

    love.graphics.translate(offsetX, offsetY)
    love.graphics.scale(escala, escala)

    local vible_sprite = UI_obj_visible[escenas]
    local mapa_actual = vible_sprite.escena
    
    if mapa_actual then
    love.graphics.push()
    love.graphics.translate(-math.floor(camara.x), -math.floor(camara.y))
        for fila = 1, #mapa_actual do
            for col = 1, #mapa_actual[fila] do
                local tipo = mapa_actual[fila][col]
                local quad = tile_quads[tipo]

                if quad then
                    love.graphics.draw(
                        tileset,
                        quad,
                        (col - 1) * TILE,
                        (fila - 1) * TILE
                    )
                end
            end
        end
        
        
        love.graphics.setFont(monoft)

        local tiendacord = vendedora_cord[escenas]
        if tiendacord then
            --love.graphics.draw(maptienda, tiendacord.xcor, tiendacord.ycor, 0, 1.5, 1.5,maptienda:getWidth() / 2, maptienda:getHeight() / 2)
        end

        if vible_sprite.jugador == true then
            local sprite_actual = sprites_anim[anim]
            if sprite_actual then
                love.graphics.setColor(gato_valores.red / 255, gato_valores.green / 255, gato_valores.blue / 255, 1)
                love.graphics.draw(sprites_anim[anim], gato_valores.xcor, gato_valores.ycor, 0, gato_valores.scalex, gato_valores.scaley, 64, 64) -- jugador
                love.graphics.setColor(1, 1, 1, 1)

                if anim == 14 and accion == 4 then
                    love.graphics.draw(bottom_x_1, gato_valores.xcor, gato_valores.ycor - 45, 0, 1, 1, 64, 64)
                end

                if anim == 16 and accion == 4 then
                    love.graphics.draw(bottom_x_2, gato_valores.xcor, gato_valores.ycor - 45, 0, 1, 1, 64, 64)
                end
            else
                love.graphics.draw(tiburocin, gato_valores.xcor, gato_valores.ycor, 0, gato_valores.scalex, gato_valores.scaley, 35, 35)
            end
        end

        if debug == true then
            local hx, hy, hw, hh = getHitbox()
            love.graphics.setColor(1, 0, 0, 0.5)
            love.graphics.rectangle("line", hx, hy, hw, hh)
            love.graphics.setColor(1, 1, 1, 1)
        end
        love.graphics.pop()
    end

    if escenas == 1 then
            --love.graphics.draw(testf, 0, 0, 0, 1, 1)
        end

        if escenas == 2 then
            --love.graphics.draw(testcity, 0, 0, 0, 1, 1)
        end

        if escenas == 3 then
            if dial == 3 then
                love.graphics.draw(fontshop2, 0, 0, 0, 1, 1)
            end

            if dial == 5 then
                love.graphics.draw(fontshop3, 0, 0, 0, 1, 1)
            end

            if dial ~= 3 and dial ~= 5 then
                love.graphics.draw(fontshop, 0, 0, 0, 1, 1)
            end
            love.graphics.draw(faceshop1, 250, 80, 0, 1, 1)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print(text, 25, 50)
            love.graphics.setColor(1, 1, 1, 1)
            local visible = tienda.visible_selec[dial]
            if visible == true then
                love.graphics.draw(selec, 25, tienda.ysel, 0, 0.2, 0.2)
            end
        end

        if escenas == 4 then
            love.graphics.draw(fontcustom, 0, 0, 0, 1, 1)
            love.graphics.draw(foco_spr, 0, 0, 0, 1, 1)
            love.graphics.print(text, 25, 50)
            local visible = tienda.visible_selec[dial]
            if visible == true then
                love.graphics.draw(selec, 25, tienda.ysel, 0, 0.2, 0.2)
            end
        end

    if pezitem >= 1 then
        local spritepez = peces_sprite[pezitem]
        if spritepez then
            love.graphics.draw(spritepez.nombre, xpez, ypez, 0, spritepez.scale, spritepez.scale)
        else
            love.graphics.draw(tiburocin, xpez, ypez, 0, 1.5, 1.5)
        end
    end

    if pezitem >= 1 and pezitem <= 4 then
        love.graphics.draw(oneplus, xpez - 64, ypez, 0, 0.5, 0.5)
    end
    love.graphics.print("Tiempo jugando: (min)" ..minutos, 10, 0)
    love.graphics.print("(seg) " ..segundos, 115, 10)
    if debug == true then
        love.graphics.print("DT "..dtt, 10, 10)
        love.graphics.print("anim: "..anim, 10, 20)
        love.graphics.print("Accion: "..accion, 10, 30)
        love.graphics.print("T:" ..tiempo, 10, 40)
        love.graphics.print("X:" ..gato_valores.xcor, 10, 50)
        love.graphics.print("Y:" ..gato_valores.ycor, 10, 60)
        love.graphics.print("INV:" ..inv, 10, 70)
        love.graphics.print("nemo:" ..nemo, 10, 80)
        love.graphics.print("furry:" ..furry, 10, 90)
        love.graphics.print("salmon:" ..salmon, 10, 100)
        love.graphics.print("peru:" ..peru, 10, 110)
        love.graphics.print("pez:" ..pez, 10, 120)
        love.graphics.print("pezitem:" ..pezitem, 10, 130)
        love.graphics.print("xpez:" ..xpez, 10, 140)
        love.graphics.print("ypez:" ..ypez, 10, 150)
        love.graphics.print("dtpez:" ..dtpez, 10, 160)
        love.graphics.print("escenas:" ..escenas, 10, 170)
        love.graphics.print("dial:" ..dial, 10, 180)
        love.graphics.print("tienda.ysel:" ..tienda.ysel, 10, 190)
        love.graphics.print("dialDT:" ..dialDT, 10, 200)
        love.graphics.print("tienda.cantp:" ..tienda.cantp, 10, 210)
        love.graphics.print("tienda.dinero:" ..tienda.dinero, 10, 220)
        love.graphics.print("tienda.estashop:" ..tienda.estashop, 10, 230)
        love.graphics.print("tirar_valor:" ..tirar_caña.tirar_valor, 10, 240)
        love.graphics.print("tiempo_de_empuje:" ..tirar_caña.tiempo_de_empuje, 10, 250)
        love.graphics.print("tiempo_de_empuje_orig:" ..tirar_caña.tiempo_de_empuje_orig, 10, 260)
        love.graphics.print("cant_bottom:" ..tirar_caña.cant_bottom, 10, 270)
        love.graphics.print("veces_bottom:" ..tirar_caña.veces_bottom, 10, 280)
        love.graphics.print("cap_pez:" ..tienda.mejoras.cap_pez, 10, 290)
    end
    if vible_sprite.ui_obj == true then
        local tiendacord = vendedora_cord[escenas]   -- agregar esta línea acá arriba
        if tiendacord then
            if anim <= 1  and not (gato_valores.xcor >= tiendacord.xcor - tiendacord.margen and gato_valores.xcor <= tiendacord.xcor + tiendacord.margen and gato_valores.ycor >= tiendacord.ycor - tiendacord.margen and gato_valores.ycor <= tiendacord.ycor + tiendacord.margen or gato_valores.xcor >= tiendacord.xcor2 - tiendacord.margen2 and gato_valores.xcor <= tiendacord.xcor2 + tiendacord.margen2 and gato_valores.ycor >= tiendacord.ycor2 - tiendacord.margen2 and gato_valores.ycor <= tiendacord.ycor2 + tiendacord.margen2) then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(usar, 10, 324, 0, 0.6, 0.6)
                love.graphics.draw(caña, 10, 278, 0, 0.7, 0.7)
                love.graphics.setColor(1, 1, 1, 0.5)
                love.graphics.draw(pescar, 94, 324, 0, 0.6, 0.6)
                love.graphics.draw(pescando, 94, 278, 0, 0.7, 0.7)
                love.graphics.setColor(1, 1, 1, 1)
            end

            if anim >= 2 and not (gato_valores.xcor >= tiendacord.xcor - tiendacord.margen and gato_valores.xcor <= tiendacord.xcor + tiendacord.margen and gato_valores.ycor >= tiendacord.ycor - tiendacord.margen and gato_valores.ycor <= tiendacord.ycor + tiendacord.margen or gato_valores.xcor >= tiendacord.xcor2 - tiendacord.margen2 and gato_valores.xcor <= tiendacord.xcor2 + tiendacord.margen2 and gato_valores.ycor >= tiendacord.ycor2 - tiendacord.margen2 and gato_valores.ycor <= tiendacord.ycor2 + tiendacord.margen2) then
                love.graphics.setColor(1, 1, 1, 0.5)
                love.graphics.draw(caña, 10, 278, 0, 0.7, 0.7)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(dejar, 10, 324, 0, 0.6, 0.6)
                love.graphics.draw(pescando, 94, 278, 0, 0.7, 0.7)
                love.graphics.draw(pescar, 94, 324, 0, 0.6, 0.6)
            end

            if gato_valores.xcor >= tiendacord.xcor - tiendacord.margen and gato_valores.xcor <= tiendacord.xcor + tiendacord.margen and gato_valores.ycor >= tiendacord.ycor - tiendacord.margen and gato_valores.ycor <= tiendacord.ycor + tiendacord.margen or gato_valores.xcor >= tiendacord.xcor2 - tiendacord.margen2 and gato_valores.xcor <= tiendacord.xcor2 + tiendacord.margen2 and gato_valores.ycor >= tiendacord.ycor2 - tiendacord.margen2 and gato_valores.ycor <= tiendacord.ycor2 + tiendacord.margen2 then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(usar, 10, 324, 0, 0.6, 0.6)
                love.graphics.draw(puerta, 10, 278, 0, 0.7, 0.7)
                love.graphics.setColor(1, 1, 1, 0.5)
                love.graphics.draw(pescar, 94, 324, 0, 0.6, 0.6)
                love.graphics.draw(pescando, 94, 278, 0, 0.7, 0.7)
                love.graphics.setColor(1, 1, 1, 1)
            end
        else
            if anim <= 1 then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(usar, 10, 324, 0, 0.6, 0.6)
                love.graphics.draw(caña, 10, 278, 0, 0.7, 0.7)
                love.graphics.setColor(1, 1, 1, 0.5)
                love.graphics.draw(pescar, 94, 324, 0, 0.6, 0.6)
                love.graphics.draw(pescando, 94, 278, 0, 0.7, 0.7)
                love.graphics.setColor(1, 1, 1, 1)
            end

            if anim >= 2 then
                love.graphics.setColor(1, 1, 1, 0.5)
                love.graphics.draw(caña, 10, 278, 0, 0.7, 0.7)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(dejar, 10, 324, 0, 0.6, 0.6)
                love.graphics.draw(pescando, 94, 278, 0, 0.7, 0.7)
                love.graphics.draw(pescar, 94, 324, 0, 0.6, 0.6)
            end
        end

        if gusano >= 0 then
            love.graphics.setFont(monoftlonglong)
            love.graphics.draw(gusanospr, 30, 260, 0, 1, 1)
            love.graphics.draw(barra, 50, 260, 0, 1, 1)
            love.graphics.print(gusano, 80, 260)
            love.graphics.setFont(monoft)
        end
    end

    if vible_sprite.bolsa == true then
        if inv == 0 then
            love.graphics.draw(bolsC, 410, 5, 0, 4, 4)
            love.graphics.draw(cbootom, 398, -25, 0, 1, 1)
        end
        

        if inv == 1 then
            love.graphics.draw(bolsA, 410, 5, 0, 4, 4)
            love.graphics.draw(cbootom, 398, -25, 0, 1, 1)
            love.graphics.draw(pez1, 346, 0, 0, 0.5, 0.5)
            love.graphics.print(nemo, 356, 64)
            love.graphics.draw(pez2, 282, 0, 0, 0.5, 0.5)
            love.graphics.print(furry, 292, 64)
            love.graphics.draw(pez3, 218, 0, 0, 0.5, 0.5)
            love.graphics.print(peru, 228, 64)
            love.graphics.draw(pez4, 154, -20, 0, 1.5, 1.5)
            love.graphics.print(salmon, 164, 64)
        end
    end

    if vible_sprite.dinero == true then
        love.graphics.setFont(monoftlong)
        love.graphics.draw(bolsM, 405, 290, 0, 0.8, 0.8)
        love.graphics.print(tienda.dinero, 420, 380)
        love.graphics.setFont(monoft)
    end

    for _, fish in ipairs(fishes) do
        love.graphics.draw(fish.image, fish.x, fish.y)
    end
    love.graphics.pop()
    love.graphics.setScissor()
end

function love.keypressed(key)
    if key == "f1" then
        nemo = nemo + 9999
        furry = furry + 9999
        salmon = salmon + 9999
        peru = peru + 9999
        tienda.cantp = tienda.cantp + 9999
        tienda.dinero = tienda.dinero + 999999999999
    end
    
    if key == "f5" then
        crearPez(love.math.random(190, -20), love.math.random(200, 400))
    end

    if key == "z" and escenas == 3 and dial <= 1 then
        dial = dial + 1
    end

    if key == "x" and escenas == 3 and dial == 3 or key == "x" and escenas == 3 and dial == 8 then
        dial = 2
    end

    if key == "x" and escenas == 3 and dial == 7 then
        dial = 2
    end

    if key == "c" and escenas == 3 and dial == 5 then
        dial = 3
    end


    if key == "up" and dial >= 2 and dial ~= 4 and dial ~= 5 then
        tienda.ysel = tienda.ysel - 12
    end

    if key == "down" and dial >= 2 and dial ~= 4 and dial ~= 5 then
        tienda.ysel = tienda.ysel + 12
    end

    if key == "left" and dial == 5 then
        tienda.cantp = tienda.cantp - 1
    end

    if key == "right" and dial == 5 then
        tienda.cantp = tienda.cantp + 1
    end

    if key == "x" and dial == 5 and escenas == 3 then
        tienda.cantp = 9999999999999
    end
    local limits = tienda.limit_shop[dial]

    if limits then
        local inicio = limits.inicio
        local final = limits.limit
        
        if tienda.ysel >= limits.limit then
            tienda.ysel = limits.limit
        end

        if tienda.ysel <= limits.inicio then
            tienda.ysel = limits.inicio
        end
    end

    if key == "z" and dial == 2 and escenas == 3 then
        local destino = tienda.seccion_shop[tienda.ysel]
        if destino then
            dial = destino --compra
            tienda.ysel = 62
        end
    end

    if key == "z" then
        local actual = tienda.peces_info[tienda.ysel]

        if actual then
            local disponible = _G[actual.nombre]
            local precio = peces_valor[actual.nombre]
        

            if dial == 3 then
                if disponible <= 0 then
                    nopesound:play()
                else
                    dial = 5
                    tienda.estashop = actual.estashop
                end
            elseif dial == 5 and tienda.estashop == actual.estashop then
                if tienda.cantp >= 1 then
                    tienda.ganancias = tienda.cantp * precio
                    dial = 6
                else
                    nopesound:play()
                end
            elseif dial == 6 and tienda.estashop == actual.estashop then
                dial = 3
                tienda.estashop = 0
                tienda.ysel = 62
                _G[actual.nombre] = disponible - tienda.cantp
                tienda.dinero = tienda.dinero + tienda.ganancias
                tienda.cantp = 0
                tienda.ganancias = 0
            end
        end
    end

    --compra

    if key == "z" and dial == 7 and escenas == 3 then
        local item = tienda.compra_info[tienda.ysel]

        if item then
            local cantidad_actual = _G[item.nombre]

            if cantidad_actual >= tienda.mejoras.cap_pez then
                nopesound:play()
            elseif tienda.dinero < item.costo then
                nopesound:play()
            else
                _G[item.nombre] = cantidad_actual + 1
                tienda.dinero = tienda.dinero - item.costo
                comprasound:play()
            end
        end
    end

    --tienda.mejoras
    if key == "z" and dial == 8 and escenas == 3 then
        local itemplus = tienda.mejoras_info[tienda.ysel]

        if itemplus then
            if tienda.dinero < itemplus.costo * itemplus.cant_mejoras then
                nopesound:play()
            else
                tienda.mejoras[itemplus.campo] = tienda.mejoras[itemplus.campo] + 1
                tienda.dinero = tienda.dinero - itemplus.costo * itemplus.cant_mejoras
                itemplus.cant_mejoras = itemplus.cant_mejoras + 1
                comprasound:play()
            end
        end
    end

    if key == "c" then
        if inv == 0 then
            inv = 1
        elseif inv == 1 then
            inv = 0
        end
    end

    if key == "f3" then
        if debug == false then
            debug = true
        elseif debug == true then
            debug = false
        end
    end

    local tiendacord = vendedora_cord[escenas]
    if key == "z" and accion == 0 and anim <= 1 and (not tiendacord or not (gato_valores.xcor >= tiendacord.xcor - tiendacord.margen and gato_valores.xcor <= tiendacord.xcor + tiendacord.margen and gato_valores.ycor >= tiendacord.ycor - tiendacord.margen and gato_valores.ycor <= tiendacord.ycor + tiendacord.margen)) then
        accion = 1
        dtt = 0
    end

    if key == "f6" then
        tienda.ysel = 122
    end
    local entrada = vendedora_cord[escenas]
    if entrada then
        if key == "z" and gato_valores.xcor >= entrada.xcor - entrada.margen and gato_valores.xcor <= entrada.xcor + entrada.margen and gato_valores.ycor >= entrada.ycor - entrada.margen and gato_valores.ycor <= entrada.ycor + entrada.margen and escenas == 2 then
            escenas = 3
            accion = 0
            dial = 1
        end   
        if key == "z" and gato_valores.xcor >= entrada.xcor2 - entrada.margen2 and gato_valores.xcor <= entrada.xcor2 + entrada.margen2 and gato_valores.ycor >= entrada.ycor2 - entrada.margen2 and gato_valores.ycor <= entrada.ycor2 + entrada.margen2 and escenas == 2 then
            escenas = 4
            accion = 0
            dial = 1
        end      
    end

        if key == "z" and tienda.ysel == 110 and dial == 2 and escenas == 3 then
            escenas = 2
            dial = 1
            tienda.ysel = 62
        end

        --[[if key == "z" and xcor >= 270 and xcor <= 314 and ycor >= 180 and ycor <= 200 then
            escenas = 4
            accion = 0
            dial = 1
        end]]
    

    if key == "z" and accion == 0 and anim >= 6 and anim <= 7 then
            anim = 2
            accion = 2
            dtt = 0
        end

        if key == "x" and accion == 4 and tirar_caña.cant_bottom > tirar_caña.veces_bottom then
            tirar_caña.veces_bottom = tirar_caña.veces_bottom + 1
        end

        if key == "x" and accion == 0 and anim >= 6 and anim <= 7 and gusano >= 1 then
            local filaFrente, colFrente = tileEnFrente()
            local mapa_actual = UI_obj_visible[escenas].escena

            if mapa_actual then
                local tipoFrente = mapa_actual[filaFrente] and mapa_actual[filaFrente][colFrente]
                local esAgua = tile_pescable[tipoFrente] == true

                if esAgua then
                    anim = 9
                    accion = 3
                    dtt = 0
                    gusano = gusano - 1
                end
            end
        elseif key == "x" and accion == 0 and anim >= 6 and anim <= 7 and gusano <= 0 then
            nopesound:play()
        
    end

    if key == "f2" then
            anim = 9
            accion = 3
            dtt = 0
            gusano = gusano + 1
    end

    if key == "f6" then
            escenas = 5
    end

    if key == "f4" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
end

function crearPez(x, y)
    table.insert(fishes, {
        image = pezind,
        x = x,
        y = y,
        pezmode = love.math.random(1, 6),
        speed = love.math.random(1, 40)
    })
end

function tileEsSolido(fila, columna)
    local mapa_actual = UI_obj_visible[escenas].escena

    if not mapa_actual then
        return true  -- sin mapa válido, lo tratamos como sólido para no romper colisiones
    end

    local filaData = mapa_actual[fila]

    if not filaData then
        return true
    end

    local tipo = filaData[columna]

    if tipo == nil then
        return true
    end

    return tile_solido[tipo] == true
end

function colisionaMapa(px, py, ancho, alto)
    local colIzq = math.floor(px / TILE) + 1
    local colDer = math.floor((px + ancho - 0.01) / TILE) + 1
    local filaArriba = math.floor(py / TILE) + 1
    local filaAbajo = math.floor((py + alto - 0.01) / TILE) + 1


    for fila = filaArriba, filaAbajo do
        for col = colIzq, colDer do
            if tileEsSolido(fila, col) then
                return true
            end
        end
    end
    return false
end

function tileDelJugador()
    local hx, hy, hw, hh = getHitboxEn(gato_valores.xcor, gato_valores.ycor)
    local centroX = hx + hw/2
    local centroY = hy + hh/2
    local col = math.floor(centroX / TILE) + 1
    local fila = math.floor(centroY / TILE) + 1
    return fila, col
end

function tileEnFrente()
    local fila, col = tileDelJugador()
    if gato_valores.scalex == 1 then
        col = col - 1
    elseif gato_valores.scalex == -1 then
        col = col + 1
    end
    return fila, col
end