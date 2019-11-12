Credits = Classe:extend()

function Credits:new()
    print   = love.graphics.print
    draw    = love.graphics.draw
    fonteC  = love.graphics.newFont("assets/fonte/fonte.ttf", 20)
    love.graphics.setFont(fonteC)
end

function Credits:draw()

    love.graphics.setFont(fonteC)
    print("Jogo criado e codificado por Lord Tesseract", 20, 50)
    print("Idealizado a partir da Ideia de CyberGamba: Street Chaves", 20, 100)
    print("Imagens, sons e sprites adaptados ou retirados de STREET CHAVES ", 20, 150)
    print("Agradecimento a TALOSPCR por trechos do codigo.", 20, 200)
    draw(intro_img2, love.graphics.getWidth()/2, 250, 0 , 0.7, 0.7)
    print("Pressione ESC para retornar ao Menu", 20, love.graphics.getHeight()-30)
    
end
    