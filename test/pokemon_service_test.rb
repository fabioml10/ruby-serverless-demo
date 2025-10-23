require 'minitest/autorun'
require 'webmock/minitest'
require_relative '../lib/pokemon_service'

class PokemonServiceTest < Minitest::Test
  def test_build_url_without_filters
    url = PokemonService.build_url('pokemon')
    assert_equal 'https://pokeapi.co/api/v2/pokemon', url
  end

  def test_build_url_with_filters
    filters = { 'limit' => '10', 'offset' => '5' }
    url = PokemonService.build_url('pokemon', filters)
    assert_equal 'https://pokeapi.co/api/v2/pokemon?limit=10&offset=5', url
  end

  def test_get_data_success
    stub_request(:get, 'http://example.com').to_return(body: '{"test": "data"}')
    response = PokemonService.get_data('http://example.com')
    assert_equal '{"test": "data"}', response
  end

  def test_get_data_error
    stub_request(:get, 'http://example.com').to_raise(StandardError.new('Network error'))
    response = PokemonService.get_data('http://example.com')
    assert_equal '{}', response
  end

  def test_get_pokemon
    stub_request(:get, 'https://pokeapi.co/api/v2/pokemon?limit=5').
      to_return(body: '{"results": []}')
    response = PokemonService.get_pokemon({ 'limit' => '5' })
    assert_equal '{"results": []}', response
  end
end
