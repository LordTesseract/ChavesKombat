Player = Classe:extend()


function Player:new(x, y, personagem, umOuDois)

    self.key               = love.keyboard.isDown

    --personagemFile = "assets/lutadores/"..personagem..".ckombat"

    personagemTeste   = love.graphics.newImage("assets/animacoes/Anim-01.bmp")
    
    self.posX               = x
    self.posY               = y  
    self.largura            = personagemTeste:getWidth()
    self.altura             = personagemTeste:getHeight()
    self.largura_tela       = love.graphics.getWidth()
    self.aceleracao         = 1000
    self.atrito             = 0.07 
    self.velocidadeX        = 0
    self.velocidadeY        = 0

    self.vida               = 100
    self.morto              = false
    self.timeHit            = 2

    --[[
    self.Hk                 = 0
    self.Lk                 = 0
    self.Hp                 = 0
    self.Lp                 = 0
    self.Cima               = 0
    self.Baixo              = 0
    self.Esquerda           = 0
    self.Direita            = 0]]


    -- Definição de conjunto de controles
   self:defineControles(umOuDois)   

end

function Player:update(dt)

    if self.isHit then
        if self.timeHit > 0 then
            self.timeHit = self.timeHit - 1
        else
            timeHit = love.math.random(1,3)
            self.isZapped = false
        end
        
    else

        -- Movimento e posicionamento
        self.posX = self.posX + self.velocidadeX * dt
        self.posY = self.posY + self.velocidadeY * dt

        if self.posX < 0 then

            self.posX = 0
            
            self.velocidadeX = 0

        elseif self.posX + self.largura > largura_tela then
            self.posX = largura_tela - self.largura
            self.velocidadeX = 0
        end

        if self.velocidadeX < 1 and self.velocidadeX > -1 then
            self.velocidadeX = 0
        else
            self.velocidadeX = self.velocidadeX*(1-self.atrito)
        end

        if self.velocidadeY < 1 and self.velocidadeY > -1 then
            self.velocidadeY = 0
        else
            self.velocidadeY = self.velocidadeY*(1-self.atrito)
        end
        

        if self.key(self.Esquerda) then
            self.velocidadeX = self.velocidadeX - self.aceleracao*dt
        end

        if self.key(self.Direita) then
            self.velocidadeX = self.velocidadeX + self.aceleracao*dt
        end

        if self.key(self.Cima) then
            self.velocidadeY = self.velocidadeY - self.aceleracao*dt

            if self.key(self.Esquerda) then
                self.velocidadeX = self.velocidadeX - self.aceleracao*dt
            elseif self.key(self.Direita) then
                self.velocidadeX = self.velocidadeX + self.aceleracao*dt
            end
        end
    end

    if vida == 0 then
        self.morto = true
    end



    
end

-- A rotação do personagem e medida no Game Update, que apenas altera como os personagens
-- são desenhados.

function Player:draw(facingRight)

    if facingRight then
        love.graphics.draw(personagemTeste, self.posX, self.posY)
    else
        love.graphics.draw(personagemTeste, self.posX, self.posY, 0, -1, 1, self.largura)
    end
end


-- Define os controles do jogador 1 e do jogador 2.
function Player:defineControles(umOuDois)
    
    -- Controles do Jogador 1
    if umOuDois == "um" then
        self.Hk = "a"
        self.Lk = "s"
        self.Hp = "d"
        self.Lp = "f"
        self.Cima = "i"
        self.Baixo = "k"
        self.Esquerda = "j"
        self.Direita = "l"
    -- Controles do Jogador 2
    else
        self.Hk = "pageup"
        self.Lk = "insert"
        self.Hp = "pagedown"
        self.Lp = "home"
        self.Cima = "kp8"
        self.Baixo = "kp5"
        self.Esquerda = "kp4"
        self.Direita = "kp6"
    end


end

function Player:getX() return self.posX end

function Player:getY() return self.posY end

function Player:getName() return personagem end

function Player:getVida() return self.vida end

function Player:isDead() 
    if self.vida < 0 then return true
    else return false
    end
end


function Player:getHit(wichHit, dt)
    
    self.isHit = true   
    if wichHit == 1 then
        self.vida = self.vida - 15 * dt
    elseif wichHit == 2 then
        self.vida = self.vida - 12 * dt
    elseif wichHit == 3 then
        self.vida = self.vida - 10 * dt
    elseif witchHit == 4 then
        self.vida = self.vida - 7 * dt
    end
end

function Player:attack()
    if self.key(self.Hk) or self.key(self.Lk) or self.key(self.Hp) or self.key(self.Lp) then
        return true
    else
        return false
    end
end

function Player:getAttack()
    if self.key(self.Hk) then
        return 1
    elseif self.key(self.Lk) then
        return 2
    elseif self.key(self.Hp) then
        return 3
    elseif self.key(self.Lp) then
        return 4
    end
end