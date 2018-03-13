# Desafio02 - STI

## Descrição

Seu objetivo é, para um dado endereço, informar quais são os bicicletários (BikeRio) mais próximos em ordem decrescente 
de distância. Para isso, você deve consumir a API do datario que contém a localização de cada bicicletário (latitute e longitute)
 e a API do OpenStreetMap, que retorna a latitute e longitude de um determinado endereço.
 
A API do BikeRio está disponível em: http://dadosabertos.rio.rj.gov.br/apiTransporte/apresentacao/rest/index.cfm/estacoesBikeRio

A API do OpenStreetMap está documentada em: http://wiki.openstreetmap.org/wiki/Nominatim

Exemplo de uso da API do OpenStreetMap: http://nominatim.openstreetmap.org/search?street=Avenida%20Bartolomeu%20Mitre&city=Rio%20de%20Janeiro&format=json&polygon=1&addressdetails=1

O software pode ser entregue na forma de script ou pode ser uma aplicação web e pode ser feito em qualquer linguagem. 
Opte pela que você tem maior domínio e que solucione o problema de forma mais simples.

```bash
Para resolver esse problema, você vai precisar:
1) Realizar uma requisição HTTP para as APIs
2) Realizar parse do JSON retornado pelas APIs
3) Calcular a distância entre dois pontos no mapa (existe uma equação pra isso!)
4) Verificar dentre as estações, qual está mais próxima do endereço passado
```

Será um *plus* caso você:

* Utilize TDD
* Faça o seu projeto rodar web
* Incluir um mapa plotando a localização do usuário e das estações
* Fizer no seu desafio utilizando a sua conta do GitHub

fonte: https://github.com/sti-uff/trabalhe-conosco/blob/master/Desafios.md

## Requisitos

Ter instalado rails

## Instalação

Na pasta do projeto, execute os seguintes comandos:

```shell
bundle install
```

## Para Rodar

Para usar o produto:

```shell
rails s
```

