-- tienda

local tienda = {}

tienda.ysel = 0
tienda.cantp = 0
tienda.estashop = 0
tienda.ganancias = 0
tienda.dinero = 250

--[[la tienda queda con cuatro sistemas: peces_info (qué pez es cada posición), limit_shop (límites del cursor),
visible_selec (cuándo se ve el cursor), y dialogo (qué texto mostrar)]]

tienda.peces_info = {
    [74]  = {nombre = "nemo",   estashop = 1},
    [86]  = {nombre = "furry",  estashop = 2},
    [98]  = {nombre = "peru",   estashop = 3},
    [110] = {nombre = "salmon", estashop = 4},
    [122] = {nombre = "test",   estashop = 5},
}

tienda.limit_shop = {
    [1] = {inicio = 62, limit = 62},
    [2] = {inicio = 62, limit = 110},
    [3] = {inicio = 62, limit = 110},
    [7] = {inicio = 62, limit = 74},
    [8] = {inicio = 62, limit = 74},
}

tienda.seccion_shop = {
    [74] = 3,
    [86] = 7,
    [98] = 8,
}

tienda.visible_selec = {
    [1] = false,
    [2] = true,
    [3] = true,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = true,
    [8] = true,
}

tienda.mejoras = {
    cap_pez = 15,
}

tienda.compra_info = {
    [74] = {
        nombre = "gusano",
        costo = 5,
        cap = tienda.mejoras.cap_pez,
    },
}

tienda.mejoras_info = {
    [74] = {
        campo = "cap_pez",
        costo = 15,
        cant_mejoras = 1,
    },
}

return tienda
