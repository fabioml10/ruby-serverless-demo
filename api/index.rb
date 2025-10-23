require 'json'

def handler(request)
  params = request.query || {}
  nome = params['nome'] || 'Vercel'

  body = {
    message: "Olá, #{nome}!",
    conceito: 'Esta função Ruby está rodando na Vercel.',
    conceito_serverless: 'Vercel escala automaticamente as funções serverless.'
  }.to_json

  {
    statusCode: 200,
    headers: { 'Content-Type' => 'application/json' },
    body: body
  }
end
