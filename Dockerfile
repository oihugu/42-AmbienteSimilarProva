# Imagem base: Debian, pois é leve e comum em ambientes de desenvolvimento
FROM debian:latest

# Define variáveis de ambiente para evitar prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza os repositórios e instala as ferramentas necessárias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential gcc g++ make git vim wget curl valgrind gdb \
        libc6-dbg ncurses-dev bsdmainutils python3 python3-pip clang figlet && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#  Instalação do Norminette (versão v3, se disponível, caso contrário, tenta a v2)
RUN pip3 install --break-system-packages norminette || (pip3 install --upgrade pip && pip3 install --break-system-packages norminette==2.*)
# if both fails, we don't fail the build, as norminette is not mandatory

# (Opcional, mas recomendado) Instala um tema para o Vim para melhor visualização
RUN git clone --depth 1 https://github.com/morhetz/gruvbox.git ~/.vim/pack/themes/start/gruvbox \
    && echo "set background=dark" >> ~/.vimrc \
    && echo "colorscheme gruvbox" >> ~/.vimrc

# (Opcional) Configuração básica do Vim para C
RUN echo "syntax on" >> ~/.vimrc \
    && echo "set tabstop=4" >> ~/.vimrc \
    && echo "set shiftwidth=4" >> ~/.vimrc \
    && echo "set expandtab" >> ~/.vimrc \
    && echo "set number" >> ~/.vimrc \
    && echo "set autoindent" >> ~/.vimrc \
    && echo "set showmatch" >> ~/.vimrc \
    # auto-indent on new lines
    && echo "set smartindent" >> ~/.vimrc

# Define o diretório de trabalho dentro do container.  Changed to /home
WORKDIR /home

# Cria as pastas "rendu" e "subjects" diretamente em /home e inicializa o repositório Git em "rendu"
RUN mkdir -p /home/rendu /home/subjects \
    && git init /home/rendu

#  (Opcional) Configuração do bash para melhor usabilidade.
RUN echo 'alias la="ls -la"' >> ~/.bashrc \
    && echo 'alias ..="cd .."' >> ~/.bashrc \
    # Add PS1 for a more useful prompt.  Example:  [user@hostname:directory]$
    && echo 'export PS1="[\u@\h:\w]\$ "' >> ~/.bashrc

# Cria o script "grademe" (em português)
RUN echo '#!/bin/bash' > /usr/local/bin/grademe \
    && echo 'figlet "AVALIACAO"' >> /usr/local/bin/grademe \
    && echo 'echo "Você fez o push do seu código para o repositório '\''rendu'\''? (s/n)"' >> /usr/local/bin/grademe \
    && chmod +x /usr/local/bin/grademe

# Cria o script "finish" (em português)
RUN echo '#!/bin/bash' > /usr/local/bin/finish \
    && echo 'echo "Prova finalizada! Boa sorte!"' >> /usr/local/bin/finish \
    && chmod +x /usr/local/bin/finish

# Cria um diretório "trace" diretamente em /home e adiciona um arquivo de exemplo com diff (em português)
RUN mkdir -p /home/trace
RUN echo '#!/bin/bash\n\
echo "Exemplo de uso de diff -U 3 | cat -e"\n\
echo "Criando arquivos de exemplo..."\n\
echo "Conteúdo do Arquivo 1:\nLinha 1\nLinha 2\nLinha 3" > /home/trace/file1.txt\n\
echo "Conteúdo do Arquivo 2:\nLinha 1\nLinha Diferente\nLinha 3" > /home/trace/file2.txt\n\
echo "Executando diff -U 3 file1.txt file2.txt | cat -e"\n\
diff -U 3 /home/trace/file1.txt /home/trace/file2.txt | cat -e' > /home/trace/example_diff.sh \
    && chmod +x /home/trace/example_diff.sh

# Adiciona um script simples para simular a funcionalidade do "trace" (opcional, customizável) (em português)
RUN echo '#!/bin/bash' > /usr/local/bin/trace \
    && echo 'echo "Trace: $@" ' >> /usr/local/bin/trace \
    && chmod +x /usr/local/bin/trace

# Comando padrão para iniciar um shell interativo
CMD ["/bin/bash"]