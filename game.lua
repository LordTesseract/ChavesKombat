Game = Classe:extend()

function Game:new()

    -- Atalhos
    print     = love.graphics.print
    rect      = love.graphics.rectangle
    draw      = love.graphics.draw
    key       = love.keyboard.down


    largura_tela    = love.graphics.getWidth()
    altura_tela     = love.graphics.getHeight()
    actual_screen   = "DevLogo"

    --Rotinas de Leitura de Fontes externas
    start       = DevLogo()
    credits     = Credits()
    options     = Options()
    sAnim1      = sAnimacao()
    sAnim2      = sAnimacao()
    scenarios   = {}
    rostos      = {} -- Vetor com os rostos apenas da seleção de personagens.
    bckgd       = {}
    lutadores   = {"Chaves", "Madruga", "Chiquinha", "Quico", "Florinda"}
    load_all_images()
    load_all_sounds()
    

    fonte = love.graphics.newFont("assets/fonte/fonte.ttf", 40)
    love.graphics.setFont(fonte)

    --Variáveis de Fluxo de Interface
    max_options         = 4
    menu_option_set     = {350, 400, 450, 500}
    menu_option         = 1 -- Start Option
    menu_bola_pos       = menu_option_set[1]
    rostos_x_pos        = {120, 240, 360, 480, 600}
    mkCenter            = largura_tela/2 - MK_Screen:getWidth()/2
    backgroundScroll    = 0
    backgroundSize      = 0
    winner              = 0

    -- bgmVolume = 1
    -- voiceVOlume = 2
    -- soundVolume = 3
    options_option_values = {0.1,1,1}
    menuBGM:setVolume(options_option_values[1])
    selectBGM:setVolume(options_option_values[1])
    
    
    options_set         = {350, 400, 450, 500}
    options_option      = 1 -- Start Option
    max_options_option  = 4


    -- Opções de Player
    --player1     = nil
    --player2     = nil
    p1Select    = 1
    p2Select    = 5
    local flckr = 1
    
    
end

function Game:update(dt)

    -- Rotinas mostrando a logo inicial.
    -- Garante que ela será mostrada apenas uma vez.
    if actual_screen == "DevLogo" then
        if start.active then
            start:update(dt)
        else
            menuBGM:play()
            actual_screen = "Menu"
        end
    end

    
    -- Rotinas de BGM. Mantém as músicas tocando apenas nos locais devidos.
    -- Menu e Opções
    if actual_screen == "Menu" or actual_screen == "Options" then menuBGM:play() else menuBGM:stop() end
    -- Seleção de Personagens
    if actual_screen == "SelecionarPersonagem" then selectBGM:play() else selectBGM:stop() end

    -- Rotinas de Comportamento do Menu
    -- Cicla as opções de Menu.
    if menu_option < 1 then
        menu_option = max_options
    end

    if menu_option > max_options then
        menu_option = 1
    end


    -- Pre-Luta é a rotina de montar a luta. Toda luta é precedida de uma pré-luta.
    if actual_screen == "Pre-Luta" then

        background      = scenarios[ranGen(9)] -- Escolhe um dos 12 Cenários de Jogo possíveis.
        player1         = Player(50, 400, lutadores[p1Select], "um")
        player2         = Player(600, 400, lutadores[p2Select], "dois")
        
        -- Por fim,
        actual_screen   = "Luta"

    end

    -- Fluxo do Esquema de Luta
    if actual_screen == "Luta" then

        if not player1:isDead() and not player2:isDead() then
            
            if player1:getX() < player2:getX() then
                p1faceRight = true
                p2faceRight = false
            else
                p1faceRight = false
                p2faceRight = true
            end

            if checarColisao(player1, player1) then
                if player1:attack() then
                    player2:getHit(player1:getAttack(), dt)
                elseif player2:attack() then
                    player1:getHit(player2:getAttack(), dt)
                end
            end

            player1:update(dt)
            player2:update(dt)
            
        
        else
            if player1:isDead() then
                winner = 2
            elseif player2:isDead() then
                 winner = 1
            end
        end


        
    
    end

        

    --Fluxo do menu de Opções

    if actual_screen == "Options" then
        
        -- Ciclar entre as opções
        if menu_option < 1 then
            menu_option = max_options
        end
    
        if menu_option > max_options then
            menu_option = 1
        end
    
        -- Define o comportamento das barras: aumentar e diminuir os volumes
        if options_option == 1 and love.keyboard.isDown("right") then 
            options_option_values[1] = options_option_values[1] + 0.1 * dt  
        elseif options_option == 1 and love.keyboard.isDown("left") then
            options_option_values[1] = options_option_values[1] - 0.1 * dt  
        end
    
        if options_option == 2 and love.keyboard.isDown("right") then 
            options_option_values[2] = options_option_values[2] + 0.1 * dt  
        elseif options_option == 2 and love.keyboard.isDown("left") then
            options_option_values[2] = options_option_values[2] - 0.1 * dt  
        end
    
        if options_option == 3 and love.keyboard.isDown("right") then 
            options_option_values[3] = options_option_values[3] + 0.1 * dt  
        elseif options_option == 3 and love.keyboard.isDown("left") then
            options_option_values[3] = options_option_values[3] - 0.1 * dt  
        end

        if options_option_values[1] < 0 then options_option_values[1] = 0 end
        if options_option_values[2] < 0 then options_option_values[2] = 0 end
        if options_option_values[3] < 0 then options_option_values[3] = 0 end

        if options_option_values[1] > 1 then options_option_values[1] = 1 end
        if options_option_values[2] > 1 then options_option_values[2] = 1 end
        if options_option_values[3] > 1 then options_option_values[3] = 1 end

    
        if options_option == max_options and love.keyboard.isDown("return") then actual_screen = "Menu" end
    

        -- Aplica os volumes definidos.
        menuBGM:setVolume(options_option_values[1])
        selectBGM:setVolume(options_option_values[1])

    end


    if actual_screen == "Credits" then
    end


    -- Tela de Seleção de Personagens

    if actual_screen == "SelecionarPersonagem" then
        
        sAnim1:update(dt)
        sAnim2:update(dt)
        --[[
        if love.keyboard.isDown("return") then
            actual_screen = "Pre-Luta"
        end]]

        --coreção de posição do quadrado de seleção
        if p1Select > 5 then p1Select = 1 end
        if p2Select > 5 then p2Select = 1 end
        if p1Select < 1 then p1Select = 5 end
        if p2Select < 1 then p2Select = 5 end

        if sAnim1:getAnimate() and sAnim2:getAnimate() then
            actual_screen = "Pre-Luta"
        end

    end



end

function Game:draw()

    print(actual_screen, 0,0)
    
    if actual_screen == "DevLogo" then
        if start.active then
            start:draw()
        end
    end

    if actual_screen == "Menu" then
        love.graphics.setFont(fonte)
        love.graphics.draw(MK_Screen, mkCenter, 50)
        love.graphics.print("FIGHT!", mkCenter+150, menu_option_set[1])
        love.graphics.print("Options", mkCenter+150, menu_option_set[2])
        love.graphics.print("Credits", mkCenter+150, menu_option_set[3])
        love.graphics.print("Exit", mkCenter+150, menu_option_set[max_options])
        love.graphics.draw(bola, mkCenter+110, menu_option_set[menu_option], 0, 0.7, 0.7 )
        
    
    end

    if actual_screen == "Luta" then

        love.graphics.draw(background, 0, 0, 0,1.8, 1.8 )
        love.graphics.setColor(1,0,0)
        rect("fill", 20, 20, 300,20)
        rect("fill", 450, 20, 300,20)
        love.graphics.setColor(1,1,0)
        rect("fill", 20, 20, player1:getVida() * 3, 20)
        rect("fill", 450, 20, player2:getVida() * 3, 20)
        love.graphics.setColor(1,1,1)
        --love.graphics.print(player1.velocidadeX, mkCenter+20, 400)
        player1:draw(p1faceRight)
        player2:draw(p2faceRight)

        if winner == 1 then
            
            print("Jogador 1 venceu!", 200, altura_tela/2)
            
        elseif winner == 2 then
            
            print("Jogador 2 venceu!", 200, altura_tela/2)
            
        end

    end

    if actual_screen == "Credits" then
        credits:draw()
    end

    if actual_screen == "Options" then
        love.graphics.setFont(fonte)
        draw(MK_Screen, mkCenter, 50)

        print("BGM", mkCenter+50, 350)
        rect("fill", mkCenter+200, 350, options_option_values[1] * 300,  40)
        
        print("Vozes", mkCenter+50, 400)
        rect("fill", mkCenter+200, 400, options_option_values[2] * 300, 40)
        
        print("Sons", mkCenter+50, 450)
        rect("fill", mkCenter+200, 450, options_option_values[3] * 300, 40)
        
        print("Voltar", mkCenter+50, 500)
        
        draw(bola, mkCenter+10, menu_option_set[options_option], 0, 0.7, 0.7 )
    end

    if actual_screen == "SelecionarPersonagem" then        

        draw(Choose_Screen, 0, 0)
        for i=1,5 do
            draw(rostos[i], rostos_x_pos[i], 90)
        end

        -- Desenhando as caixas de seleção
        love.graphics.setLineWidth(5)
        if p1Select ~= p2Select then
            love.graphics.setColor(1,0,0,1)
            rect("line", rostos_x_pos[p1Select], 90, 96, 126)
            love.graphics.setColor(0,1,0,1)
            rect("line", rostos_x_pos[p2Select], 90, 96, 126)

        else -- A caixa pisca nas duas cores, quando ambos estão sobre o mesmo personagem
            if flckr == 1 then
                love.graphics.setColor(1,0,0,1)
                rect("line", rostos_x_pos[p1Select], 90, 96, 126)
                flckr = 2
            else
                love.graphics.setColor(0,1,0,1)
                rect("line", rostos_x_pos[p2Select], 90, 96, 126)
                flckr = 1
            end
            
        end        
        -- As cores e linhas devem ser reiniciadas após alteradas, 
        -- pare evitar comportamento estranho das cores após essa tela.
        love.graphics.setColor(1,1,1,1)
        love.graphics.setLineWidth(1)

        --Desenhando os personagens:

        sAnim1:draw(p1Select, true)
        sAnim2:draw(p2Select, false)
        

    end

end

-- Checagem simples de colisão
function checarColisao(A, B)
    if A:getX() < B:getX() + B.posY and
        A.posX + A.largura > B.posX and
        A.posY < B.posY + B.altura and
        A.posY + A.altura > B.posY then
        return true
    end
end


-- Todas as imagens devem ser carregadas usando esta função
function load_all_images()

    --Carregando os Cenários
    for i=1,9 do
        local imageScenario = love.graphics.newImage("Assets/Cenarios/Cenario-"..i..".bmp")
        table.insert(scenarios, imageScenario)
    end

    --Carreganso rostos da Seleção
    for i=1,5 do
        local imageRosto = love.graphics.newImage("Assets/Rostos/R0"..i.."-c.bmp")
        table.insert(rostos, imageRosto)
    end
    
    -- Telas e itens de seleção
    MK_Screen = love.graphics.newImage("Assets/Screens/MenuLogo.png")
    Choose_Screen = love.graphics.newImage("Assets/Screens/Choose.jpg")
    bola = love.graphics.newImage("Assets/Screens/bolaquadrada.png")

end

function load_players()

    --player1 = Player(50, 500, nil, "um")

end

-- Todos os sons devem ser carregados usando esta função.
function load_all_sounds()
    
    local audio = love.audio.newSource
    
    --Musicas
    menuBGM     = audio("assets/Musicas/Menu(Abertura).ogg", "stream")
    selectBGM   = audio("assets/Musicas/Selecao(Coloured-Candles).mp3", "stream") 

    --Sons

end


-- Funções de Apoio a rotinas

function ranGen (limite)        return love.math.random(1,limite) end

function Game:getMenuOpt()      return menu_option end

function Game:setMenuOpt(opt)   menu_option = opt end

function Game:getOptionOpt()    return options_option end
    
function Game:setOptionOpt(opt) options_option = opt end

function Game:getAnimate(wich)
    if wich == 1 then
        return sAnim1:getAnimate()
    else
        return sAnim2:getAnimate()
    end
end

function Game:selectOpt(opt)

    if opt == 1 then actual_screen = "SelecionarPersonagem" end
    if opt == 2 then actual_screen = "Options" end
    if opt == 3 then actual_screen = "Credits" end
    if opt == max_options then love.event.quit(0) end
    
end

-- Esta função é apenas uma interface simples, para ser passada para
-- a função main de forma correta.
function Game:animateChar(who)
    if who == 1 then
        sAnim1:animate()
    elseif who == 2 then
        sAnim2:animate()
    end
end

