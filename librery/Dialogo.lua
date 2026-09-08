local tienda = require("librery/tienda")

dialogo = {}

dialogo[1] = "Hola soy la vendedora"

dialogo[2] = "Que quieres :3 \n \n  vender \n  comprar \n  mejoras \n  nada "

dialogo[3] = function() 
    return "Que tienes para \nvender?  \n  Nemos("..
        peces_valor.nemo.."$): " .. nemo ..
        "\n  PecesFurrys("..peces_valor.furry.."$): " .. furry ..
        "\n  PecesPeruanos("..peces_valor.peru.."$): " .. peru ..
        "\n  salmones("..peces_valor.salmon.."$): " .. salmon
end

dialogo[4] = "Oooo lo siento,\nno tienes para \nvenderme eso :P"

dialogo[5] = function() 
    return "Genial,cuanto quiere \nvender? \n \n Cant:" ..
        tienda.cantp ..
        "\n\n(usa izq y der para\nsubir o bajar la\n cant.y usa X para\nir directo a lo que\nmax que pueda\nvender, usa Z para\nseguir\n,sali con C)"
end

dialogo[6] = function()
    return "Gracias ;3,\n serian: \n " ..
        tienda.ganancias .. "$"
end

dialogo[7] = function()
    return "Que quieres comprar?  \n\n  Gusano (5$): " .. gusano
end

dialogo[8] = function() 
    local cap_gusanos = tienda.mejoras_info[74]

    return "Genial, que quieres mejorar?\n \n  cap. de gusanos(" ..
        cap_gusanos.costo * cap_gusanos.cant_mejoras .. "):"
end

dialogo[9] = "\n \n  Nueva pertida \n  Cargar partida(aun no) \n  Opciones(aun no) \n  Salir(aun no) "

dialogo[10] = "Personaliza a tu gato!\n \n  Color \n  Accesorios(aun no) \n  Salir "

dialogo[11] = function ()
    return "Cambia del gato :D (usa izq, y der :3)\n \n  R:" .. gato_valores.red .. "\n  G:" .. gato_valores.green .."\n  B:" .. gato_valores.blue
end

dialogo[12] = function () -- npc dial
    faces = facesnpc1
    aprox_dial = 13
    dtt_dial_aprox = 0.5
    return "HOLISSSS, a Fishing cat!"
end

dialogo[13] = function () -- npc dial2
    faces = facesnpc2
    aprox_dial = 15
    dtt_dial_aprox = 1
    return "Esto ni es una demo lol, pero espero que lo disfrute,\ndisfruta esta version DEV :D"
end

dialogo[14] = function () -- salir de dialogo
    dtt_dial_aprox = 1
    return " "
end

dialogo[15] = function () -- npc dial2
    faces = facesnpc3
    aprox_dial = 16
    dtt_dial_aprox = 0.5
    return "Muevete con las flecha, la C para ver los pecez\ncon Z sacas la caña X pescas"
end

dialogo[16] = function () -- npc dial2
    faces = facesnpc3
    aprox_dial = 17
    dtt_dial_aprox = 0.5
    return "ve a la izquierda-bajo para ir a la cuidad,\ncompra y custumiza al gato :3"
end

dialogo[17] = function () -- npc dial2
    faces = facesnpc2
    aprox_dial = 14 --final
    dtt_dial_aprox = 0.5
    return "Me llamo Testela y espero que disfrutes bye!"
end

return dialogo

--[[
    \n	salto de línea (nueva línea)
    \t	tabulación (espacio grande, como al apretar Tab)
    \"	comillas dobles dentro de un string que también usa comillas dobles
    \'  comilla simple, útil si el string usa '...'
    \\	una barra invertida literal (porque \ solo es "barra invertida" si escribís \\)
]]