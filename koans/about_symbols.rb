require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSymbols < Neo::Koan
  def test_symbols_are_symbols
    symbol = :ruby
    assert_equal true, symbol.is_a?(Symbol)
  end

  def test_symbols_can_be_compared
    symbol1 = :a_symbol
    symbol2 = :a_symbol
    symbol3 = :something_else

    assert_equal true, symbol1 == symbol2
    assert_equal false, symbol1 == symbol3
  end

  def test_identical_symbols_are_a_single_internal_object
    symbol1 = :a_symbol
    symbol2 = :a_symbol

    assert_equal true, symbol1           == symbol2
    assert_equal true, symbol1.object_id == symbol2.object_id
  end

  def test_method_names_become_symbols
    symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }
    assert_equal true, symbols_as_strings.include?("test_method_names_become_symbols")
  end

  # THINK ABOUT IT:
  #
  # Why do we convert the list of symbols to strings and then compare
  # against the string value rather than against symbols?
  # 
  # https://stackoverflow.com/questions/4686097/ruby-koans-why-convert-list-of-symbols-to-strings#:~:text=By%20converting%20all_symbols%20to%20strings,existed%20prior%20to%20the%20comparison.
  # Its pretty convoluted but basically if we compared against symbols it would be guarenteed to exist because symbol used for comparision would result in it being in the list
  
  # # Skipped because of following error
  # # /workspace/ruby-koans/koans/about_symbols.rb:42: [BUG] Segmentation fault at 0x00000000000001a0
  # # ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]
  # in_ruby_version("mri") do
  #   RubyConstant = "What is the sound of one hand clapping?"
  #   def test_constants_become_symbols
  #     all_symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }

  #     assert_equal "What is the sound of one hand clapping?", all_symbols_as_strings.include?("What is the sound of one hand clapping?")
  #   end
  # end

  def test_symbols_can_be_made_from_strings
    string = "catsAndDogs"
    assert_equal :catsAndDogs, string.to_sym
  end

  def test_symbols_with_spaces_can_be_built
    symbol = :"cats and dogs"

    assert_equal "cats and dogs".to_sym, symbol
    assert_equal :"cats and dogs", symbol
  end

  def test_symbols_with_interpolation_can_be_built
    value = "and"
    symbol = :"cats #{value} dogs"

    assert_equal "cats and dogs".to_sym, symbol
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    assert_equal "It is raining cats and dogs.", string
  end

  def test_symbols_are_not_strings
    symbol = :ruby
    assert_equal false, symbol.is_a?(String)
    assert_equal false, symbol.eql?("ruby")
  end

  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string
    assert_equal false, symbol.respond_to?(:each_char)
    assert_equal false, symbol.respond_to?(:reverse)
  end

  # It's important to realize that symbols are not "immutable
  # strings", though they are immutable. None of the
  # interesting string operations are available on symbols.

  def test_symbols_cannot_be_concatenated
    # Exceptions will be pondered further down the path
    assert_raise(NoMethodError) do
      :cats + :dogs
    end
  end

  def test_symbols_can_be_dynamically_created
    assert_equal :catsdogs, ("cats" + "dogs").to_sym
  end

  # THINK ABOUT IT:
  #
  # Why is it not a good idea to dynamically create a lot of symbols?
  #
  # Symbols are globally scoped so it would pollute the global namespace perhaps?
  # Seems like its a memory issue, as symbols are not garbage collected, the memory will just keep rising.
end
