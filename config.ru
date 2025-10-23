# config.ru
require 'json'
require 'uri'
require 'time'
require_relative 'lib/pokemon_service'

# Nossa "função" serverless, no formato de um Rack app
Handler = proc do |env|
  params = URI.decode_www_form(env['QUERY_STRING']).to_h

  # Filtros para a API (todos os params exceto 'nome')
  filters = params

  # Chama a API com filtros
  raw_data = PokemonService.get_pokemon(filters)
  characters = JSON.parse(raw_data)

  body = {
    conceito: 'Esta função Ruby está rodando na Vercel.',
    data: characters
  }.to_json

  [
    200,
    { 'Content-Type' => 'application/json' },
    [body]
  ]
end

# Diz ao Rack para executar nosso Handler
run Handler
