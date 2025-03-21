```c
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   README.md                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hamorim- <hamorim-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/21 14:26:51 by hamorim-          #+#    #+#             */
/*   Updated: 2025/03/21 14:26:51 by hamorim-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
```

> [!IMPORTANT]
> Importante: Leia os Warnings(blocos que nem esse) eles salvam vidas, evitam boatos, e previnem interpretações muito criativas (famoso viajar)

> [!WARNING]
> Aviso: Esse documento foi feito com base nas últimas duas prova Exam00 e Exam01, **não sei** como serão no futuro, esse documento só é útil se as provas continuarem com o mesmo ambiente

## A Estrutura de Diretórios
> [!TIP]
> Dica: Diretório é como chamamos as pastas no linux, se você está acostumado com pastas, quando estiver escrito diretório leia pastas
> 
Em uma prova realizada em um computador, o espaço de armazenamento é compartilhado entre você e o sistema operacional. Os diretórios importantes para você são:

- rendu
  - Nesse diretório você escreverá seu código, e, assim como você coloca nos exercícos, é importante colocar o nome do diretório e do arquivo que a moulinette está esperando.
  - O rendu **é um repositório git**, do mesmo jeito que sua pasta de exercícios, é importante usar a sequencia de comandos do git para que a moulinette possa avaliar seus exercícios
```sh
git add . #Ou especifique o nome do diretório e arquivo
git commit -m "Mensagem descritiva"
git push
```
- subjects
  - Nesse diretório vão ficar os enunciados do exercício que você está fazendo no momento, em diversas liguas disponíveis, para o enunciado em português por exemplo procure pelo arquivo com final ``_pt.txt`` 

- trace
  - Uma vez que a moulinette já testou seu código, e ele não passou na avaliação que ela fez, a diferença do resultado que seu código gerou com o que a moulinette esperava é enviada para essa pasta, até onde sei ela usa o comando ``diff -U 3`` comparando dois arquivos, um com o seu resultado, um com o esperado.

> [!CAUTION]
> Cuidado: O trace engana e não é consistente, escreva seus prórpios testes, não dependa dele. (Fiquei 30min na última prova tentando entender um erro que não existia)

## Os Comandos

Lembre que a moulinette compila seu código com ``cc -Wall -Wextra - Werror``, chamamos isso de flags do compilador, teste pelo menos a última versão do seu código com isso, afinal, estamos tentando agradar a moulinette :>

Você pode usar ``alias`` na prova se já tiver decorado os comandos, com o ``alias`` você pode definir um comando como uma sequência de outros ou como um comando já com suas flags, o comando de compilar por exemplo ficaria como `alias compilar='cc -Wall -Wextra - Werror'` e para compilar com todas as flags você escreveria ``compilar <nome_do_arquivo.c>``.

> [!WARNING]
> Aviso: Antes de usar alias, decore o comando, o documento não adianta nada se você esquecer como compilar na prova

Os comandos específicos do ambiente da prova são:

- grademe
  - Serve para pedir para a moulinette avaliar o seu código **depois que você tiver feito o commit**
- finish
  - Termina a prova
- status
  - Te mostra quanto tempo você ainda tem para fazer a prova, quais questões você já fez e em qual exercício você está atualmente
