# ~/.bashrc - Configuração Bash Minimalista para Hyprland

# ============================================
# CONFIGURAÇÕES BÁSICAS
# ============================================

# Se não estiver rodando interativamente, não fazer nada
[[ $- != *i* ]] && return

# Histórico
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s checkwinsize

# ============================================
# CORES E TEMA
# ============================================

# Habilitar cores
export TERM=xterm-256color
export COLORTERM=truecolor

# Cores para ls (esquema moderno)
export LS_COLORS='di=1;36:ln=1;35:so=1;33:pi=1;33:ex=1;32:bd=1;34:cd=1;34:su=1;31:sg=1;31:tw=1;36:ow=1;36'

# Cores para grep
export GREP_COLORS='ms=01;36:mc=01;36:sl=:cx=:fn=35:ln=32:bn=32:se=36'

# ============================================
# PROMPT MINIMALISTA COM GIT
# ============================================

# Função para status do git
git_branch() {
    git branch 2>/dev/null | grep '^*' | colrm 1 2
}

git_status() {
    local branch=$(git_branch)
    
    if [[ -n $branch ]]; then
        local git_status="$(git status 2>/dev/null)"
        
        if [[ $git_status =~ "nothing to commit" ]]; then
            echo -e " \[\e[38;5;42m\]($branch)\[\e[0m\]"
        elif [[ $git_status =~ "Changes to be committed" ]]; then
            echo -e " \[\e[38;5;214m\]($branch)\[\e[0m\]"
        else
            echo -e " \[\e[38;5;203m\]($branch)\[\e[0m\]"
        fi
    fi
}

# Prompt moderno e minimalista
PS1='\[\e[38;5;147m\]❯\[\e[0m\] \[\e[38;5;111m\]\w\[\e[0m\]$(git_status) '

# ============================================
# ALIASES ESSENCIAIS
# ============================================

# Navegação
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls moderno
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lAh'
alias la='ls -A'
alias lt='ls -lAht'

# Comandos coloridos
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Segurança
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Utilitários
alias df='df -h'
alias free='free -h'
alias mkdir='mkdir -pv'

# Hyprland
alias hyprconf='$EDITOR ~/.config/hypr/hyprland.conf'
alias kittyconf='$EDITOR ~/.config/kitty/kitty.conf'
alias waybarconf='$EDITOR ~/.config/waybar/config.jsonc'
alias reload='hyprctl reload'

# Git simplificado
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate -10'

# Sistema (Arch/Manjaro)
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'

# ============================================
# FUNÇÕES ÚTEIS
# ============================================

# Criar e entrar em diretório
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extrair arquivos comprimidos
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.tar.xz) tar xJf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.zip) unzip "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "Formato não suportado: '$1'" ;;
        esac
    else
        echo "'$1' não é um arquivo válido"
    fi
}

# Backup rápido
backup() {
    cp "$1"{,.bak}
}

# ============================================
# FZF - BUSCA FUZZY
# ============================================

if [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
fi

if [ -f /usr/share/fzf/completion.bash ]; then
    source /usr/share/fzf/completion.bash
fi

# Tema FZF minimalista
export FZF_DEFAULT_OPTS="
    --height 50% 
    --layout=reverse 
    --border rounded
    --prompt '❯ '
    --pointer '▶'
    --marker '✓'
    --color=fg:#a8b5d1,bg:#0a0e14,hl:#59c2ff
    --color=fg+:#ffffff,bg+:#161e27,hl+:#73d0ff
    --color=info:#95e6cb,prompt:#f29e74,pointer:#ffcc66
    --color=marker:#a6cc70,spinner:#f29e74,header:#5ccfe6"

# ============================================
# AUTOCOMPLETION
# ============================================

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set colored-stats on'
bind 'set visible-stats on'
bind 'set mark-symlinked-directories on'
bind 'set colored-completion-prefix on'

# ============================================
# EXPORTS
# ============================================

export EDITOR='nano'
export VISUAL='nano'
export BROWSER='firefox'
export TERMINAL='kitty'

# ============================================
# MENSAGEM INICIAL
# ============================================

# Mostrar apenas info essencial
echo ""
echo -e "\e[38;5;147m╭─\e[0m \e[38;5;111m$(whoami)\e[0m@\e[38;5;147m$(hostname)\e[0m"
echo -e "\e[38;5;147m╰─\e[0m \e[38;5;180m$(date '+%H:%M')\e[0m • \e[38;5;150m$(uptime -p | sed 's/up //')\e[0m"
echo ""
