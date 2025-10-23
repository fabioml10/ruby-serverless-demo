require 'json'
require 'uri'

Handler = proc do |env|
  params = URI.decode_www_form(env['QUERY_STRING']).to_h
  nome = params['nome'] || 'Vercel'

  body = {
    message: "Olá, #{nome}!",
    conceito: 'Esta função Ruby está rodando na Vercel.',
    conceito_serverless: 'Vercel escala automaticamente as funções serverless.'
  }.to_json

  [200, {'Content-Type' => 'application/json'}, [body]]
end
