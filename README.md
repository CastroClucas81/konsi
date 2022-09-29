## INTRODUÇÃO
Carlos é um servidor público de 48 anos que trabalha organizando documentos por
localidade. Ele precisa rotineiramente pesquisar endereços de CEP na internet para saber
qual o bairro correspondente e ter uma visão no mapa de onde fica esse bairro na cidade.
Além disso, Carlos precisa anotar todos os CEPs e endereços correspondentes numa
caderneta para ter o registro dos locais que ele já pesquisou a fim de futuramente utilizar
em relatórios da repartição na qual trabalha.

## PROBLEMA
Carlos reclama que o tempo de anotar o CEP e o endereço na caderneta atrasa o
seu fluxo de trabalho, ele também tem dificuldade em procurar na caderneta um endereço
que ele já anotou.
O Carlos não é muito chegado com tecnologia então, rotineiramente, tem
dificuldades em pesquisar os CEPs nos sites da internet e de visualizar no mapa,
principalmente quando o documento que ele está analisando está com um CEP inválido.

## SOLUÇÃO
Desenvolva um aplicativo utilizando Flutter, que ajude o Carlos a melhorar o seu
fluxo de trabalho.

## DETALHES DO PROJETO
- Gerenciador de estado: BloC e Cubit;
- Persistência dos dados: SQLite.
- Diagrama: 

![alt text](https://github.com/CastroClucas81/konsi/blob/master/diagrama.png)

## OBSERVAÇÕES
Utilizei o package GEOCODE para localizar as cordernadas do endereço e plotar no mapa. Porém o seu tempo de resposta é demasiadamente demorado.

Como possível melhoria, trocar a GEOCODE pelo servido da Google - GEOCODING API, por oferecer melhores resultados de pesquisa e um tempo de latência menor.

Para esse teste, decidi não utilizar ele por ser um serviço PAGO da Google. Além disso, meu plano gratis do Google Cloud já esgotou.
