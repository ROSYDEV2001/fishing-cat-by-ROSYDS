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

dialogo[9] = "\n \n  Nueva pertida \n  Cargar partida \n  Opciones \n  Salir "

dialogo[10] = "Personaliza a tu gato!\n \n  Color \n  Accesorios \n  Salir "

return dialogo

--[[
    \n	salto de línea (nueva línea)
    \t	tabulación (espacio grande, como al apretar Tab)
    \"	comillas dobles dentro de un string que también usa comillas dobles
    \'  comilla simple, útil si el string usa '...'
    \\	una barra invertida literal (porque \ solo es "barra invertida" si escribís \\)
]]