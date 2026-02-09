#!/usr/bin/env bash
#
# commands-ref.sh
#
# ⚠️ ESTE ARQUIVO NÃO É UM SCRIPT DE INSTALAÇÃO
#
# Este arquivo contém comandos de REFERÊNCIA.
# Eles NÃO devem ser executados em sequência nem copiados às cegas.
# Use apenas para consulta, aprendizado e verificação pontual.
#
# Execute comandos individualmente e apenas se souber o que está fazendo.
#
# O presente guia assume que a instalação do Debian se trata de Debian 12+ / 13 (Testing).
#
# Observação, para o perfeito funcionamento dos comandos no presente guia, é esperado que os 
# repositorios abaixo estejam ativos: 
# main
# contrib
# non-free
# non-free-firmware
#
# As referências do stack gráfico e multimídia (diagnóstico) ao longo deste guia.
# Atenção: os pacotes referênciados não devem ser instalados manualmente.
# Eles fazem parte do stack gráfico e multimídia do Debian e são instalados automaticamente
# conforme o perfil de hardware, sessão gráfica (Wayland/Xwayland) e dependências do sistema.
#
# A ausência de algum deles indica problema de instalação, firmware ou repositórios, e não falta
# de comando apt install.

# Atualizar o sistema

sudo apt update
sudo apt full-upgrade

# Instalar e ativar firewall

sudo apt install ufw
sudo ufw enable
# O padrão para o ufw no desktop é outgoing = allow
# A ativação dele não irá bloquear internet, Steam ou uso comum.

# Remoção de aplicativos

sudo apt remove --purge totem simple-scan gnome-connections malcontent malcontent-control gnome-maps gnome-weather gnome-tour
sudo apt autoremove --purge

# Verificação de firmware de GPU (AMD)
# Em sistemas com GPU AMD, o pacote firmware-amd-graphics deve ser instalado automaticamente
# durante a instalação do Debian, desde que o repositório non-free-firmware esteja ativo.
# Este pacote é essencial para o funcionamento correto do driver amdgpu,
# aceleração gráfica, Vulkan e vídeo por hardware.

apt policy firmware-amd-graphics

# Atenção! Caso o pacote não esteja instalado e a GPU seja AMD:
# sudo apt install firmware-amd-graphics

# Stack gráfico (GPU / Wayland / X11)
# Essenciais para renderização 3D, aceleração gráfica e compatibilidade com aplicações legadas:

# mesa-vulkan-drivers — implementação Vulkan (necessário para jogos e Proton)
# libgl1-mesa-dri — aceleração OpenGL via Mesa
# libglx-mesa0 — suporte GLX para aplicações X11
# libegl-mesa0 — interface EGL (Wayland e X11)
# libvulkan1 — loader Vulkan
# libdrm2 — comunicação direta com o driver da GPU
# xwayland — compatibilidade com aplicações X11 em sessões Wayland

# Observação: Mesmo em sistemas 100% Wayland (GNOME padrão), o xwayland é necessário para Steam, jogos
# antigos e aplicações que ainda dependem de X11.

# Instalando Flatpak e ativando o repositório do Flathub

sudo apt install flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Aceleração de vídeo (multimídia)
# Responsáveis por decodificação e encoding acelerado por hardware:
# mesa-va-drivers — backend VA-API para GPUs AMD/Intel
# libva-x11-2 — suporte VA-API em aplicações X11

# Instalando suporte maior a codecs multimedia

sudo apt install ffmpeg gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav libavcodec-extra

# Instalar codecs para Flatpak apenas se algum app não reproduzir mídia corretamente.

flatpak install flathub org.freedesktop.Platform.ffmpeg-full

# Áudio e sessão multimídia
# Infraestrutura moderna de áudio e vídeo no desktop Linux:
# pipewire — servidor multimídia unificado
# pipewire-pulse — compatibilidade com aplicações PulseAudio
# wireplumber — gerenciador de sessão do PipeWire

# Instalar aplicativos padrão do Debian|Gnome

sudo apt install evolution seahorse file-roller

# Instalando o LibreOffice

sudo apt install libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-draw libreoffice-gnome

# Instalando aplicativos para configurações do Gnome 

sudo apt install gnome-tweaks gnome-shell-extension-manager

# Instalando aplicativos de terminal/suportes

sudo apt install curl wget fastfetch p7zip-full unrar

# Instalar zram

sudo apt install zram-tools
sudo systemctl enable --now zramswap

# Ativando suporte a arqutetura i386

sudo dpkg --add-architecture i386
sudo apt update

# Instalando pacotes i386 importantes para suporte completo em jogos [Steam], [Proton] e outros

sudo apt install mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 libglx-mesa0:i386 libegl-mesa0:i386 libvulkan1:i386

# Instalar o gamemode

sudo apt install gamemode

# Instalar o [Chrome]

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
# Caso prefira pode baixar e instalar o .deb pelo site oficial,
# por ele já adiciona o repositório automaticamente.

# Ferramentas de organização pessoal

flatpak install flathub com.bitwarden.desktop md.obsidian.Obsidian

# Instalar [Spotify]

curl -fsSL https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | sudo gpg --dearmor -o /usr/share/keyrings/spotify-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/spotify-archive-keyring.gpg] https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update
sudo apt install spotify-client

# Ferramentas de produtividade

flatpak install flathub io.github.diegopvlk.Tomatillo com.rafaelmardojai.Blanket io.gitlab.guillermop.Counters
flatpak install flathub com.github.johnfactotum.Foliate info.febvre.Komikku
# Baixar o [MarkText] (AppImage) GitHub do MarkText*
# Criar Web App para as seguintes ferramentas:
# [Trello], [Feedly], [WhatsApp].

# Ferramentas de gestão e configuração

sudo apt install corectrl
flatpak install flathub com.github.tchx84.Flatseal io.github.flattool.Warehouse io.github.giantpinkrobots.flatsweep io.github.kolunmi.Bazaar
flatpak install flathub it.mijorus.gearlever

# Ferramentas de multimedia

flatpak install flathub io.github.diegopvlk.Cine
sudo apt install lollypop

# Ferramentas de desenvolvimento

sudo apt install default-jdk git
flatpak install flathub com.vscodium.codium
# [IntelliJ] & [PyCharm] (Toolbox App) Site da JetBrains*

# Wine e compatibilidade (jogos)
# Camada de compatibilidade para aplicações Windows:
# wine
# wine64
# wine32

# Ferramentas de jogos.

sudo apt install steam
flatpak install flathub com.heroicgameslauncher.hgl com.usebottles.bottles
flatpak install flathub net.davidotek.pupgui2 com.github.Matoking.protontricks
flatpak install flathub com.discordapp.Discord
# Desativar o autodownload de arquivos pelo no app do [Discord].
# Revisar as permissões do [Discord] pelo [Flatseal] são elas: Arquivos do sistema; Dispositivos; Captura de Tela.

# Instalar o launcher do [Minecraft]

wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install ./Minecraft.deb
# Caso prefira pode baixar e instalar o .deb pelo site oficial.

# Ferramentas de emulação de jogos.

flatpak install flathub org.libretro.RetroArch net.kuribo64.melonDS

# Ferramentas de analise de desempenho.

sudo apt install lm-sensors psensor mangohud
flatpak install flathub io.missioncenter.MissionCenter io.github.radiolamp.mangojuice

# Ferramentas de diagnóstico (opcional)
# Pacotes seguros para verificação e debug, sem alterar o sistema:
# vulkan-tools — inclui vulkaninfo
# mesa-utils — inclui glxinfo

# Utilitarios
sudo apt install gnome-boxes transmission
flatpak install flathub org.flameshot.Flameshot io.gitlab.adhami3310.Impression
flatpak install flathub org.localsend.localsend_app dev.geopjr.Collision dev.bragefuglseth.Keypunch

# Ferramentas para streamer e produção de conteúdo.

flatpak install flathub com.obsproject.Studio
flatpak install flathub com.github.wwmm.easyeffects
flatpak install flathub org.kde.kdenlive
flatpak install flathub org.shotcut.Shotcut
flatpak install flathub org.gimp.GIMP
flatpak install flathub org.kde.krita
flatpak install flathub org.inkscape.Inkscape
flatpak install flathub io.gitlab.adhami3310.Converter
flatpak install flathub fr.handbrake.ghb
# Baixar o [Audacity] (AppImage) Site do Audacity*

# Instalando ferramentas de snapshot e backup

sudo apt install timeshift pika-backup

# Ferramentas de RPG

flatpak install flathub io.github.kriptolix.Poliedros de.hummdudel.Libellus
