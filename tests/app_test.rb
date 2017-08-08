# encoding: UTF-8
require_relative '../app'
require 'minitest/autorun'
require 'rack/test'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_home_busca_de_endereco
    get '/'
    assert_match /Busca de Endereço/, last_response.body
  end
  
  
  def test_busca_padrao
    get '/?url=Avenida+Rudge+365'
    assert_match /Avenida Rudge/, last_response.body  
  end
  
  def test_endereco_invalido
    get '/?url='
    assert_match //, last_response.body  
  end
  
  def test_cep_busca_formatacao_cep
    get '/?url=13032385'
    assert_match /13032-385/, last_response.body
  end
  
  def test_cep_busca_formatacao_bairro
    get '/?url=13032385'
    assert_match /Vila Teixeira/, last_response.body
  end
  
  def test_cep_busca_formatacao_cidade
    get '/?url=13032385'
    assert_match /Campinas/, last_response.body
  end
  
  def test_cep_busca_endereco_formatado
    get '/?url=13032385'
    assert_match /Vila Teixeira, Campinas - SP, 13032-385, Brazil/, last_response.body
  end
  
  def test_cep_invalido
    get '/?url=1303233385'
    assert_match //, last_response.body
  end

end
