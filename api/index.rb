require 'json'

Handler = proc do |request, response|
  params = request.query || {}
  nome = params['nome'] || 'Vercel'

  response.status = 200
  response['Content-Type'] = 'application/json'
  response.body = JSON.dump({
    message: "Olá, #{nome}!",
    conceito: 'Esta função Ruby está rodando na Vercel.',
    conceito_serverless: 'Vercel escala automaticamente as funções serverless.'
  })
end
