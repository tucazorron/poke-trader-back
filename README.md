# Poke Trader - Backend

## Desenvolvedor

Artur Zorron

## Endereço

https://poke-trader-back.herokuapp.com

## Framework

Ruby on Rails

## Banco de Dados

MongoDB

## Modelo

| Coluna | Tipo | Dado |
|--------|------|------|
| player1 | string | concatenacao dos pokemons do player 1 |
| player2 | string | concatenacao dos pokemons do player 2 |
| baseexp1 | integer | soma dos "base_experience" dos pokemons do player 1 |
| baseexp2 | integer | soma dos "base_experience" dos pokemons do player 2 |
| fair | boolean | booleano indicando se a troca foi justa ou não

## Endpoints

| Requisição | Endereço | Método | Função |
|------------|----------|--------|--------|
| POST | "/trades" | trades#create | cria dentro banco de dados a troca realizada no frontend |
| GET | "/" | trades#index | lista todos trocas realizadas que estão salvas no banco de dados |

## Fluxo ( POST => "/trades" )

- Recebe requisição do frontend contendo duas listas de objetos no body. Cada objeto possui o id do pokemon e o nome do pokemon

Ex:
```json
{
	"player1": [{"value": 1, "label": "bulbasaur"}, {"value": 2, "label": "ivysaur"}],
	"player2": [{"value": 3, "label": "venusaur"}, {"value": 4, "label": "charmander"}]
}
```

- Repassa as duas listas recebidas para o serviço do backend para tratar os dados antes de salvar
- Concatena os pokemons de cada player e coloca em `player1` ou `player2`
- Calcula a soma dos `base_experience` de cada player e coloca em `baseexp1` ou `baseexp2`. Faz uma requisição a `http://pokeapi.co/api/v2/pokemon/{id}` onde {id} é o id do pokemon no momento. O retorno desta chamada são várias informações do pokemons e uma delas é o `base_experience`
- Calcula a diferença absoluta entre `baseexp1` e `baseexp2`. Caso seja menor que 16, `fair` recebe `True`. Caso contrário, `fair` recebe `False`
- Repassa pra controller um `json` com os dados tratados e no mesmo formato de como serão salvos no backend
- Envia para o frontend o objeto salvo no banco de dados

## Fluxo ( GET => "/" )

- Recebe a requisição do frontend pedindo a lista de todos os objetos do banco
- Cria uma instância da classe de trocas que recebe todos os elementos do banco de dados
- Envia para o frontend a instância dessa classa