DevLogo = Classe:extend()

function DevLogo:new()

    intro_img1  = love.graphics.newImage("Assets/Screens/lordCube.png")
    intro_img2  = love.graphics.newImage("Assets/Screens/lordTesseract.png")
    schin       = love.audio.newSource("Assets/Sons/schin.ogg", "static")
    pop         = love.audio.newSource("Assets/Sons/pop.wav", "static")

    --getting Values to center logo images
    screen_width    = love.graphics.getWidth()
    screen_height   = love.graphics.getHeight()

    logo1_width     = intro_img1:getWidth()
    logo1_height    = intro_img1:getHeight()
    logo2_width     = intro_img2:getWidth()
    logo2_height    = intro_img2:getHeight()

    fonte = love.graphics.newFont("assets/fonte/fonte.ttf", 40)
    love.graphics.setFont(fonte)

    altura          = 0
    rotacao         = -1.5708
    altura_final    = screen_width/2 - logo2_height/2
    delayTime1      = 2 -- seconds
    delayTime2      = 2 -- seconds
    fadeRatio       = 0.9 -- 1 is 1 second
    fading          = false
    self.active     = true
    


    img = "1"
    alphaT = 1

end

function DevLogo:update(dt)

    
    if delayTime1 > -2 then
        delayTime1 = delayTime1 - dt
    end

    if delayTime1 < -2 then
        delayTime2 = delayTime2 - dt
    end

    if delayTime1 < 0 and delayTime1 > -1 then
        schin:play()
        img = "2"
        fading = true
    end

    if img == "2" and delayTime2 < 0 and fading then
        love.graphics.setColor(1,1,1, alphaT)
        alphaT = alphaT - fadeRatio*dt
    end 

    if alphaT > 255 then
        alphaT = 255
    end

    if alphaT < 0 and delayTime2 < -2 then
        fading = false
        love.graphics.setColor(1,1,1,1)
        self.active = false

    end

    if rotacao <= 0 then
        rotacao = rotacao + 1.5 * dt        
    end

    if altura <= altura_final then
        altura = altura + 160 * dt
    end

    if rotacao >= 0.01 then 
        pop:play()        
        rotacao = 0.001       
        
    end
end

function DevLogo:draw()   

    if img == "1" then
        love.graphics.draw(intro_img1, (screen_width/2) - (logo1_width/2) , altura-50, rotacao)
        
    end

    if img == "2" then
        love.graphics.draw(intro_img2,(screen_width/2) - (logo2_width/2), (screen_width/2) - logo2_height/2- 100)
        love.graphics.print("Lord Tesseract Games", 170, 20)
    end

end