require 'json'
require_relative '../lib/pokemon_service'

Handler = proc do |request, response|
  params = request.query || {}
  nome = params.delete('nome') || 'Vercel'

  # Filtros para a API (todos os params exceto 'nome')
  filters = params

  # Chama a API com filtros
  raw_data = PokemonService.get_pokemon(filters)
  result = JSON.parse(raw_data)

  response.status = 200
  response['Content-Type'] = 'application/json'
  response.body = JSON.dump({
    conceito: 'Esta função Ruby está rodando na Vercel.',
    data: result
  })
end
