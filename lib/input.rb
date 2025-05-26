
module  Input
  def get_theme
    puts 'Escolha um tema'
    puts 'Temas: animais, objetos.'
    verify(gets.chomp,%w[animais objetos],:get_theme)
  end

  def get_guess
    puts 'Escolha uma letra'
    letter = verify(gets.chomp.downcase,%w[a b c d e f g h i j k l m n o p q r s t u v w x y z ç ã á ú é í õ -],:get_guess)
    if @mistakes.include?(letter)
      puts 'Você já tentou essa letra'
      letter = get_guess
    end
    letter
  end

  def play_again?
    puts 'Você quer jogar novamente?,reponda com s ou n'
    verify(gets.chomp,%w[s n],:play_again?)
  end

  def verify(input,available,get_input)
    while !available.include?(input)
      puts 'Você digitou errado, tente de novo'
      input = method(get_input).call
    end
    input
  end   

end