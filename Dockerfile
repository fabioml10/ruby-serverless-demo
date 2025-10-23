# 1. Imagem Base
FROM ruby:3.3-slim

# 2. Define o diretório de trabalho
WORKDIR /usr/src/app

# 3. Copia os arquivos de dependência
COPY Gemfile Gemfile.lock ./

# 4. Instala dependências (COM A CORREÇÃO FINAL)
#    - Adiciona 'build-essential' (compiladores) E 'ruby-dev' (cabeçalhos C do Ruby)
#    - Roda o 'bundle install'
#    - Limpa TUDO para manter a imagem pequena
RUN apt-get update -qq && \
    apt-get install -y build-essential ruby-dev libssl-dev && \
    bundle install --jobs 4 --retry 3 && \
    apt-get purge -y --auto-remove build-essential ruby-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# 5. Copia o código da aplicação
COPY . .

# 6. Expõe a porta
EXPOSE 3000

# 7. O comando para iniciar a aplicação
CMD ["sh", "-c", "bundle exec puma --bind tcp://0.0.0.0:${PORT:-3000} config.ru"]


# docker run --rm -v "$(pwd)":/usr/src/app -w /usr/src/app ruby:3.3-slim sh -c "apt-get update -qq && apt-get install -y build-essential ruby-dev libssl-dev && bundle install"
# docker build -t demo-serverless-ruby .
# docker run -p 3000:3000 demo-serverless-ruby
# http://localhost:3000/?nome=Teste
