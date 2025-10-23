require 'net/http'
require 'json'

class PokemonService
  BASE_URL = 'https://pokeapi.co/api/v2'

  # Método para construir a URL com filtros
  def self.build_url(endpoint, filters = {})
    query_string = filters.map { |k, v| "#{k}=#{URI.encode_www_form_component(v)}" }.join('&')
    query_string = "?#{query_string}" unless query_string.empty?
    "#{BASE_URL}/#{endpoint}#{query_string}"
  end

  # Método para fazer a requisição HTTP e retornar a resposta bruta
  def self.get_data(url)
    uri = URI(url)
    Net::HTTP.get(uri)
  rescue StandardError => e
    puts "Erro ao acessar API: #{e.message}"
    '{}'
  end

  # Método específico para buscar Pokémon com filtros
  def self.get_pokemon(filters = {})
    url = build_url('pokemon', filters)
    get_data(url)
  end
end
