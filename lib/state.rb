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
themes = create_dictionary,
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
    @word = word_list.delete(random_word).downcase
    @secret_word = Array.new(@word.length,'_')
  end

  def check_guess(guess)
    return if guess == 'sair'
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

  def get_line(line)
    File.readlines('lib/words.txt')[line].chomp.split(' ')
  end

  def create_dictionary
    {'animais' => get_line(0), 'objetos' => get_line(1), 'espaço' => get_line(2)}
  end
end 