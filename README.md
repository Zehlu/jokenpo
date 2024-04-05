# Game (Pedra, Papel ou Tesoura)

## Descrição
O projeto Game é uma implementação simples do clássico jogo Pedra, Papel ou Tesoura, onde o jogador joga contra o computador. O objetivo é criar uma aplicação distribuída usando Elixir e OTP que permita ao jogador enviar sua escolha via uma conexão TCP e receber o resultado da jogada.

## Setup Inicial de Desenvolvimento

Para iniciar o projeto:

1. Crie um novo projeto Mix com um supervisor:

```bash
mix new game --sup
```

2. Navegue para o diretório do projeto:

```bash
cd game
```

3. Abra o projeto em seu editor de texto favorito para começar a desenvolver.

## Requisitos Mínimos

- O jogo deve iniciar um servidor TCP que aceita conexões dos jogadores.
- Os jogadores enviam suas escolhas ("pedra", "papel" ou "tesoura") como strings pela conexão TCP.
- O computador escolhe aleatoriamente entre as mesmas opções.
- Após cada jogada, o servidor deve enviar o resultado (vitória, derrota ou empate) de volta ao jogador.
- O servidor deve ser capaz de lidar com múltiplas conexões simultâneas sem bloqueio.
- Use um GenServer para manter o estado do jogo, incluindo contagem de vitórias, derrotas e empates para o jogador.

## Estrutura Sugerida

- **lib/game.ex**: Define o GenServer do jogo, incluindo a lógica para iniciar o servidor TCP, aceitar conexões e processar as jogadas.
- **lib/game/server.ex**: Implementa a lógica específica do servidor TCP, incluindo a lógica para escolher aleatoriamente a jogada do computador.
- **lib/game/player.ex**: (Opcional) Pode ser usado para modelar o jogador, mantendo seu estado entre jogadas.

## Dicas

- Explore o módulo [GenServer](https://hexdocs.pm/elixir/GenServer.html) para gerenciar o estado e a lógica do jogo.
- Utilize o módulo [:gen_tcp](https://erlang.org/doc/man/gen_tcp.html) do Erlang para criar o servidor TCP.
- Use pattern matching para determinar o resultado de cada jogada.

## Testes

- Inclua testes que verifiquem se as jogadas são recebidas e processadas corretamente.
- Teste a lógica de determinação do vencedor de cada rodada.
- Considere testar a capacidade do servidor de lidar com múltiplas conexões usando [Task.async](https://hexdocs.pm/elixir/Task.html#async/1).

## Execução

Para iniciar o servidor do jogo:

```bash
mix run --no-halt
```

## Conexão ao Jogo

Use `telnet` ou qualquer cliente TCP para se conectar ao servidor e jogar:

```bash
telnet localhost 4040
```

Envie sua jogada ("PEDRA", "PAPEL" ou "TESSOURA") seguida por ENTER.

## Referências

- [Documentação do GenServer](https://hexdocs.pm/elixir/GenServer.html)
- [Erlang :gen_tcp](https://erlang.org/doc/man/gen_tcp.html)
- [Elixir School: GenServer](https://elixirschool.com/en/lessons/advanced/gen-stage)
