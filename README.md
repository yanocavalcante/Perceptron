# Perceptron

Este repositório contém o código-fonte escrito em linguagem de descrição de Hardware (VHDL) para um Perceptron, bem como arquivos .tex para a compilação do relatório final referente ao desenvolvimento do mesmo.

## Clonando o repositório

Certifique-se de que o Git esteja instalado em seu sistema. Em seguida, clone o repositório com o seguinte comando:

Utilizando HTTPS:
```bash
git clone https://github.com/yanocavalcante/Perceptron.git
cd Perceptron
```

Utilizando SSH:
```bash
git clone git@github.com:yanocavalcante/Perceptron.git
cd Perceptron
```
## Código-Fonte

TODO

## Relatório LaTeX

### Requisitos

### 1. Compilador LaTeX

É necessário ter uma distribuição LaTeX completa instalada no sistema.

* Para usuários de Linux (Ubuntu, Debian, Linux Mint):

```bash
sudo apt update
sudo apt install texlive-full
```

* Para usuários de Windows:
  Instale o [MiKTeX](https://miktex.org/download) e habilite a instalação automática de pacotes opcionais.

* Para usuários de macOS:
  Instale o [MacTeX](https://www.tug.org/mactex/).

Certifique-se de que o comando `latexmk` esteja disponível no terminal após a instalação.

### 2. Editor Visual Studio Code

Para editar e compilar os arquivos .tex referentes ao projeto minha recomendação é a utilização do Visual Studio Code com a extensão **LaTeX Workshop**. Abaixo, estão algumas instruções simples de como fazê-lo. 

Instale o Visual Studio Code a partir do site oficial: [https://code.visualstudio.com/](https://code.visualstudio.com/)

Em seguida, instale a extensão **LaTeX Workshop** através da aba de extensões ou com o comando:

```bash
code --install-extension James-Yu.latex-workshop
```

## Compilação do projeto

1. Abra o repositório no Visual Studio Code:

```bash
code .
```

2. Abra o arquivo `main.tex`.

3. Utilize o atalho `Ctrl + Alt + B` (ou `Cmd + Alt + B` no macOS) para compilar o documento.

4. O resultado da compilação será exibido em uma visualização de PDF no próprio editor.

Caso prefira utilizar o terminal:

```bash
latexmk -pdf main.tex
```

Se estiver utilizando bibliografia:

```bash
latexmk -pdf main.tex
bibtex main
latexmk -pdf main.tex
```

## Troubleshooting

Abaixo estão alguns problemas que podem surgir durante a compilação do arquivo .tex dentro do ambiente do VSCode. (Apareceram na primeira vez em que testei). 

### Erro: `spawn latexmk ENOENT`

Significa que o compilador `latexmk` não está instalado ou não está no PATH do sistema.

**Solução (Linux):**

```bash
sudo apt install latexmk
```

**Solução (Windows):**

Abra o MiKTeX Console, procure por `latexmk` e instale o pacote correspondente.

### Erro: `File 'cite.sty' not found`

O pacote `cite` não está instalado.

**Solução (Linux):**

```bash
sudo apt install texlive-latex-extra
```

**Solução (Windows):**

Abra o MiKTeX Console e instale o pacote `cite`.

### Erro: `File 'algorithmic.sty' not found`

O pacote `algorithmic` não está instalado.

**Solução (Linux):**

```bash
sudo apt install texlive-science
```

**Solução (Windows):**

Abra o MiKTeX Console e instale o pacote `algorithms`.