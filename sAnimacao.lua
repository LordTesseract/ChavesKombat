sAnimacao = Classe:extend()


function sAnimacao:new()

    local draw      = love.graphics.draw
    local ldImg     = love.graphics.newImage
    self.set_animate     = false     
    
    Chaves      = ldImg("assets/Selecao/C01.png")
    Madruga     = ldImg("assets/Selecao/C02.png")
    Chiquinha   = ldImg("assets/Selecao/C03.png")
    Quico       = ldImg("assets/Selecao/C04.png")
    Florinda    = ldImg("assets/Selecao/C05.png")

    
    qChaves     = {} -- 4 Frames: 1 Idle, 3 Moving
    qMadruga    = {} -- 3 Frames: 1 Idle, 2 Moving
    qChiquinha  = {} -- 4 frames: 1 Idle, 3 Moving
    qQuico      = {} -- 3 Frames: 1 Idle, 2 Moving
    qFlorinda   = {} -- 4 Frames: 1 Idle, 3 Moving
    
    --Variáveis de Fluxo de Animação
    chavesDesiredDelayBetweenFrameChanges = 0.3
    chavesTimePassedSinceLastFrameChange = 0
    chavesCurrentFrame = 1    
    chavesTotalNumberOfFrames = 4
    chavesFrameWidth = 94
    chavesFrameHeight = 150

    madrugaDesiredDelayBetweenFrameChanges = 0.05
    madrugaTimePassedSinceLastFrameChange = 0
    madrugaCurrentFrame = 1    
    madrugaTotalNumberOfFrames = 3
    madrugaFrameWidth = 59
    madrugaFrameHeight = 160

    chiquinhaDesiredDelayBetweenFrameChanges = 0.3
    chiquinhaTimePassedSinceLastFrameChange = 0
    chiquinhaCurrentFrame = 1    
    chiquinhaTotalNumberOfFrames = 4
    chiquinhaFrameWidth = 87
    chiquinhaFrameHeight = 144

    quicoDesiredDelayBetweenFrameChanges = 0.15
    quicoTimePassedSinceLastFrameChange = 0
    quicoCurrentFrame = 1    
    quicoTotalNumberOfFrames = 3
    quicoFrameWidth = 108
    quicoFrameHeight = 151

    florindaDesiredDelayBetweenFrameChanges = 0.18
    florindaTimePassedSinceLastFrameChange = 0
    florindaCurrentFrame = 1    
    florindaTotalNumberOfFrames = 4
    florindaFrameWidth = 90
    florindaFrameHeight = 146

    fillFrames()

end

function sAnimacao:update(dt)

    if self.set_animate then

        chavesTimePassedSinceLastFrameChange = chavesTimePassedSinceLastFrameChange + dt

        if chavesTimePassedSinceLastFrameChange > chavesDesiredDelayBetweenFrameChanges then
            chavesTimePassedSinceLastFrameChange = chavesTimePassedSinceLastFrameChange - chavesDesiredDelayBetweenFrameChanges
            chavesCurrentFrame = chavesCurrentFrame % chavesTotalNumberOfFrames + 1
            if chavesCurrentFrame == 1 then
                chavesCurrentFrame = 2
            end
        end

        madrugaTimePassedSinceLastFrameChange = madrugaTimePassedSinceLastFrameChange + dt

        if madrugaTimePassedSinceLastFrameChange >= madrugaDesiredDelayBetweenFrameChanges then
            madrugaTimePassedSinceLastFrameChange = madrugaTimePassedSinceLastFrameChange - madrugaDesiredDelayBetweenFrameChanges
            madrugaCurrentFrame = madrugaCurrentFrame % madrugaTotalNumberOfFrames + 1            
            if madrugaCurrentFrame == 1 then
                madrugaCurrentFrame = 2
            end
        end

        chiquinhaTimePassedSinceLastFrameChange = chiquinhaTimePassedSinceLastFrameChange + dt

        if chiquinhaTimePassedSinceLastFrameChange > chiquinhaDesiredDelayBetweenFrameChanges then
            chiquinhaTimePassedSinceLastFrameChange = chiquinhaTimePassedSinceLastFrameChange - chiquinhaDesiredDelayBetweenFrameChanges
            chiquinhaCurrentFrame = chiquinhaCurrentFrame % chiquinhaTotalNumberOfFrames + 1
            if chiquinhaCurrentFrame == 1 then
                chiquinhaCurrentFrame = 2
            end
        end

        quicoTimePassedSinceLastFrameChange = quicoTimePassedSinceLastFrameChange + dt

        if quicoTimePassedSinceLastFrameChange > quicoDesiredDelayBetweenFrameChanges then
            quicoTimePassedSinceLastFrameChange = quicoTimePassedSinceLastFrameChange - quicoDesiredDelayBetweenFrameChanges
            quicoCurrentFrame = quicoCurrentFrame % quicoTotalNumberOfFrames + 1
            if quicoCurrentFrame == 1 then
                quicoCurrentFrame = 2
            end
        end

        florindaTimePassedSinceLastFrameChange = florindaTimePassedSinceLastFrameChange + dt

        if florindaTimePassedSinceLastFrameChange > florindaDesiredDelayBetweenFrameChanges then
            florindaTimePassedSinceLastFrameChange = florindaTimePassedSinceLastFrameChange - florindaDesiredDelayBetweenFrameChanges
            if florindaCurrentFrame < florindaTotalNumberOfFrames then
                florindaCurrentFrame = florindaCurrentFrame + 1
            else
                florindaCurrentFrame = 2
            end
        end
    end

    
end

function sAnimacao:draw(personagem, p1)
    
    if self.set_animate == false then
        -- Player 1 Idle
        if p1 and personagem == 1 then
            draw(Chaves, qChaves[1], 120, 300, 0, 1.5, 1.5)
        elseif p1 and personagem == 2 then
            draw(Madruga, qMadruga[1], 120, 300, 0, 1.5, 1.5, -20 , 10)
        elseif p1 and personagem == 3 then
            draw(Chiquinha, qChiquinha[1], 120, 300, 0, 1.5, 1.5, 0, -6)
        elseif p1 and personagem == 4 then
            draw(Quico, qQuico[1], 120, 300, 0, 1.5, 1.5, 1)
        elseif p1 and personagem == 5 then
            draw(Florinda, qFlorinda[1], 120, 300, 0, 1.5, 1.5, -4)
        -- Player 2 Idle
        elseif not p1 and personagem == 1 then
                draw(Chaves, qChaves[1], 694, 300, 0, -1.5, 1.5)
        elseif not p1 and personagem == 2 then
            draw(Madruga, qMadruga[1], 694, 300, 0, -1.5, 1.5, -20 , 10)
        elseif not p1 and personagem == 3 then
            draw(Chiquinha, qChiquinha[1], 694, 300, 0, -1.5, 1.5, 0, -6)
        elseif not p1 and personagem == 4 then
            draw(Quico, qQuico[1], 694, 300, 0, -1.5, 1.5, 1)
        elseif not p1 and personagem == 5 then
            draw(Florinda, qFlorinda[1], 694, 300, 0, -1.5 , 1.5, -4)
        end
    else
          if p1 and personagem == 1 then
            draw(Chaves, qChaves[chavesCurrentFrame], 120, 300, 0, 1.5, 1.5)
        elseif p1 and personagem == 2 then
            draw(Madruga, qMadruga[madrugaCurrentFrame], 120, 300, 0, 1.5, 1.5, -20 , 10)
        elseif p1 and personagem == 3 then
            draw(Chiquinha, qChiquinha[chiquinhaCurrentFrame], 120, 300, 0, 1.5, 1.5, 0, -6)
        elseif p1 and personagem == 4 then
            draw(Quico, qQuico[quicoCurrentFrame], 120, 300, 0, 1.5, 1.5, 1)
        elseif p1 and personagem == 5 then
            draw(Florinda, qFlorinda[florindaCurrentFrame], 120, 300, 0, 1.5, 1.5, -4)
        -- Player 2 Idle
        elseif not p1 and personagem == 1 then
                draw(Chaves, qChaves[chavesCurrentFrame], 694, 300, 0, -1.5, 1.5)
        elseif not p1 and personagem == 2 then
            draw(Madruga, qMadruga[madrugaCurrentFrame], 694, 300, 0, -1.5, 1.5, -20 , 10)
        elseif not p1 and personagem == 3 then
            draw(Chiquinha, qChiquinha[chiquinhaCurrentFrame], 694, 300, 0, -1.5, 1.5, 0, -6)
        elseif not p1 and personagem == 4 then
            draw(Quico, qQuico[quicoCurrentFrame], 694, 300, 0, -1.5, 1.5, 1)
        elseif not p1 and personagem == 5 then
            draw(Florinda, qFlorinda[florindaCurrentFrame], 694, 300, 0, -1.5 , 1.5, -4)
        end 
    
    end            
        
end

function fillFrames()
    
    for frameB = 1,chavesTotalNumberOfFrames do
		qChaves[frameB] = love.graphics.newQuad((frameB-1) * chavesFrameWidth, 0, chavesFrameWidth, chavesFrameHeight, Chaves:getDimensions())
    end

    for frameB = 1,madrugaTotalNumberOfFrames do
		qMadruga[frameB] = love.graphics.newQuad((frameB-1) * madrugaFrameWidth, 0, madrugaFrameWidth, madrugaFrameHeight, Madruga:getDimensions())
    end

    for frameB = 1,chiquinhaTotalNumberOfFrames do
		qChiquinha[frameB] = love.graphics.newQuad((frameB-1) * chiquinhaFrameWidth, 0, chiquinhaFrameWidth, chiquinhaFrameHeight, Chiquinha:getDimensions())
    end

    for frameB = 1,quicoTotalNumberOfFrames do
		qQuico[frameB] = love.graphics.newQuad((frameB-1) * quicoFrameWidth, 0, quicoFrameWidth, quicoFrameHeight, Quico:getDimensions())
    end

    for frameB = 1,florindaTotalNumberOfFrames do
		qFlorinda[frameB] = love.graphics.newQuad((frameB-1) * florindaFrameWidth, 0, florindaFrameWidth, florindaFrameHeight, Florinda:getDimensions())
    end

end

function sAnimacao:animate()
    if self.set_animate == true then
        self.set_animate = false
    else
        self.set_animate = true
    end
end

function sAnimacao:getAnimate() return self.set_animate end
