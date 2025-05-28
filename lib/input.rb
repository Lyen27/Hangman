
module  Input
  def get_theme
    puts 'Escolha um tema, quando quiser salvar o jogo, digite "salvar", quando quiser sair, digite "sair"'
    puts 'Temas: animais, objetos.'
    verify(gets.chomp,%w[animais objetos],:get_theme)
  end

  def get_guess
    puts 'Escolha uma letra'
    letter = verify(gets.chomp.downcase,%w[a b c d e f g h i j k l m n o p q r s t u v w x y z ç ã á ú é í õ - salvar sair],:get_guess)
    if @mistakes.include?(letter)
      puts 'Você já tentou essa letra'
      letter = get_guess
    end
    if letter == 'salvar'
      f = File.new('save.msgpack', 'w')
      f.write(to_msgpack)
      f.close
      puts 'jogo salvo'
      letter = get_guess
    end
    letter
  end

  def play_again?
    puts 'Você quer jogar novamente?[s/n]'
    verify(gets.chomp,%w[s n],:play_again?)
  end

  def verify(input,available,get_input)
    while !available.include?(input)
      puts 'Você digitou errado, tente de novo'
      input = method(get_input).call
    end
    input
  end

  def play_saved_game?
   puts 'Você quer carregar um jogo salvo?[s/n]'
   verify(gets.chomp,%w[s n],:play_saved_game?)
  end

  def to_msgpack
    MessagePack.dump({
      :hang_man => self.hang_man,
      :rope => self.rope,
      :themes => self.themes,
      :theme => self.theme,
      :word => self.word,
      :secret_word => self.secret_word,
      :mistakes => self.mistakes
    })
  end

  def clear_display
    system('clear')
  end
end