# config.ru
require 'json'
require 'uri'
require 'time'

# Nossa "função" serverless, no formato de um Rack app
Handler = proc do |env|
  params = URI.decode_www_form(env['QUERY_STRING']).to_h
  nome = params['nome'] || 'Docker'

  body = {
    message: "Olá, #{nome}!",
    conceito: 'Esta função Ruby está rodando dentro de um container Docker.',
    conceito_serverless: 'Uma plataforma como o Google Cloud Run pegaria este container e o escalaria de 0 a N instâncias.'
  }.to_json

  [
    200,
    { 'Content-Type' => 'application/json' },
    [body]
  ]
end

# Diz ao Rack para executar nosso Handler
run Handler
