require_relative 'input'
require 'msgpack'
class State
  attr_accessor :rope, :hang_man, :word, :theme, :themes, :secret_word, :mistakes
  include Input
  def initialize(hang_man = [
' =======
|      (o o)
|       
|      
|       
|      
|',
' =======
|      (o o)
|        |
|        |
|       
|      
|',
' =======
|      (o o)
|       /|
|      / |
|       
|      
|',
' =======
|      (o o)
|       /|\
|      / | \     
|      
|
|',
' =======
|      (o o)
|       /|\
|      / | \
|       /
|      /
|',

' =======
|      (o o)
|       /|\
|      / | \
|       / \
|      /   \
|'],
rope = 
' =======
|      
|       
|      
|       
|      
|',
themes = {'animais' => %w[gato cachorro leão tigre elefante girafa zebra cavalo vaca porco ovelha cabra lobo raposa urso panda canguru coala tamanduá tatu anta onça jaguar guepardo pantera rinoceronte hipopótamo crocodilo jacaré cobra píton sucuri cascavel jararaca coral lagarto iguana camaleão dragão-de-komodo rã sapo perereca salamandra tubarão baleia golfinho orca peixe-palhaço peixe-espada peixe-boi polvo lula água-viva estrela-do-mar cavalo-marinho caranguejo siri lagosta camarão marisco ostra mexilhão coruja águia falcão gavião urubu pomba pombo andorinha beija-flor tucano arara papagaio periquito calopsita canário pardal galo galinha pato marreco cisne ganso avestruz ema flamingo pinguim gaivota pelicano albatroz corvo gralha pavão faisão codorna suricata esquilo castor texugo guaxinim doninha furão hamster rato camundongo morcego toupeira javali alce veado rena antílope gnu búfalo bisão camelo dromedário lhama alpaca siamês persa angorá sphynx maine-coon ragdoll papillon tritão axolote bagre tilápia traíra dourado pirarucu tambaqui pacu piranha lambari curimatã surubim jaú pintado peixe-elétrico enguia-elétrica carpa salmão atum bacalhau sardinha linguado robalo pescada cavala anchova garoupa mero tainha badejo peixe-lua peixe-borboleta peixe-voador peixe-agulha cavalo-do-cão dragão-barbudo cavalo-andaluz cão-lobo cão-d’água cão-salsicha dálmata poodle labrador golden-retriever pastor-alemão husky rottweiler chihuahua pug boxer beagle bulldog beluga narval boto boto-cor-de-rosa boto-tucuxi foca leão-marinho morsa urso-pardo urso-polar anta-mirim cachorro-do-mato cachorro-vinagre cervo-do-pantanal cervo-nobre jacaré-açu jacaré-do-papo-amarelo jacaré-anão morcego-pescador morcego-frugívoro rato-do-banhado gato-maracajá gato-do-mato jaguatirica lobo-guará tamanduá-bandeira tamanduá-mirim tatu-bola tatu-galinha tatu-canastra bicho-preguiça peixe-rei peixe-serra peixe-espinho tartaruga-verde tartaruga-de-pente tartaruga-cabeçuda cágado-pescoçudo perereca-de-banheiro sapo-cururu rã-verde rã-pimenta periquito-rei arara-vermelha arara-azul arara-canindé papagaio-verdadeiro papagaio-do-mangue papagaio-de-peito-roxo tucano-de-bico-preto tucano-toco galo-da-serra curió azulão sabiá-laranjeira sabiá-do-campo canário-da-terra tiê-sangue tiê-preto coleirinho tico-tico jacu mutum jacutinga jacupemba inhambu nambu urutau joão-de-barro quero-quero seriema arapapá araçari araçari-poca araçari-mulato araçari-banana biguá biguatinga martim-pescador uirapuru sanhaçu gavião-real coruja-buraqueira mocho-diabo coruja-das-torres suindara jacurutu corujinha-do-mato meerkat wallaby wombat koala-red kangaroo red-fox lynx caracal serval snow-leopard cheetah lemur aye-aye tarsier galago platypus echidna dugongo manatee clownfish lionfish seahorse blue-whale humpback-whale killer-whale dolphin sea-lion walrus black-bear grizzly-bear honey-badger springbok wildebeest okapi emu kiwi kakapo ibis ibis-sagrado cassowary hornbill binturong pangolin chital markhor saiga dik-dik gaur dhole quokka ibex yak langur macaque orangotango chimpanzé gorila bonobo tamarino mico sagui],
'objetos' => %w[cadeira mesa sofá cama armário guarda-roupa televisão geladeira fogão micro-ondas liquidificador batedeira ventilador ar-condicionado computador notebook celular telefone rádio relógio espelho lâmpada abajur chuveiro torneira panela frigideira prato copo xícara colher garfo faca tigela balde vassoura rodo pá escova espanador sabão detergente esponja toalha lençol cobertor travesseiro colchão edredom almofada cortina persiana tapete carpete quadro pintura fotografia estante prateleira livro caderno agenda lápis caneta borracha apontador régua tesoura grampeador clipe grampos cola pincel tinta teclado mouse monitor caixa-de-som impressora papel envelope pasta mochila bolsa carteira óculos guarda-chuva chave cadeado fechadura campainha interruptor tomada adaptador carregador controle-remoto pen-drive disco-rígido fone-de-ouvido alto-falante microfone escada ferro-de-passar tábua-de-passar aspirador-de-pó máquina-de-lavar secadora fogão-elétrico forno-elétrico sanduicheira torradeira cafeteira chaleira panela-de-pressão pano-de-prato pano-de-chão lixeira cesta cesto cabide varal pregador ventilador-de-teto luminária lanterna pilha bateria isqueiro fósforo balança espremedor ralador abridor-de-latas abridor-de-garrafas funil peneira tábua-de-corte rolo-de-massa saleiro pimenteiro moedor saleiro-pimenteiro garrafa-térmica jarra filtro-de-água copo-medidor cronômetro despertador aquecedor termômetro escorredor escorredor-de-macarrão escorredor-de-pratos rodo-mágico pano-multiuso capa-de-chuva caixa-de-ferramentas caixa-de-correspondência caixa-de-correio pano-de-limpeza pano-de-pó saco-de-lixo saco-plástico pano-de-prato-reserva tábua-de-carne caixa-de-remédios armário-de-cozinha armário-de-banheiro]},
theme = get_theme,
word = nil,
secret_word = nil,
mistakes = '')
    @hang_man = hang_man
    @rope = rope
    @themes = themes
    @theme = theme
    @word = word
    @secret_word = secret_word
    @mistakes = mistakes
  end

  def render_state
    display = [rope,mistakes,secret_word.join(' ')]
    puts display
  end

  def get_random_word
    word_list = @themes[@theme]
    random_word = word_list[rand(word_list.length)]
    @word = word_list.delete(random_word)
    @secret_word = Array.new(@word.length,'_')
  end

  def check_guess(guess)
    if word.include?(guess)
      word.split('').each_with_index do |val,i|
        @secret_word[i] = guess if val == guess
      end
    else
      @rope = hang_man.shift
      @mistakes = mistakes + ' ' + guess
    end
  end

  def win?
    true if secret_word.join == word
  end

end 