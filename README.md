# Guia de Pós-Instalação — Debian 12+ / 13 (Testing)

Este guia assume uma instalação do **Debian 12 ou superior**, incluindo **Debian 13 (Testing)**, com foco em uso **desktop moderno**, jogos, multimídia e produtividade.

---

## Pré-requisitos

Para o funcionamento correto dos comandos e pacotes descritos neste guia, é esperado que os seguintes repositórios estejam **ativos**:

* `main`
* `contrib`
* `non-free`
* `non-free-firmware`

---

## Observações sobre o stack gráfico e multimídia

Ao longo deste guia, alguns pacotes do **stack gráfico e multimídia** serão citados **apenas como referência e diagnóstico**.

> ⚠️ **Atenção**
>
> * Esses pacotes **não devem ser instalados manualmente**.
> * Eles fazem parte do stack base do Debian e são instalados automaticamente conforme:
>
>   * Hardware detectado
>   * Sessão gráfica (Wayland / Xwayland)
>   * Dependências do sistema
>
> A ausência de algum deles normalmente indica **problema de firmware, driver ou repositórios**, e não falta de comando `apt install`.

---

## Atualizar o sistema

```bash
sudo apt update
sudo apt full-upgrade
```

---

## Firewall (UFW)

```bash
sudo apt install ufw
sudo ufw enable
```

* O padrão do UFW em desktops é `outgoing = allow`
* A ativação **não bloqueia acesso à internet, Steam ou uso comum**

---

## Remoção de aplicativos não utilizados

```bash
sudo apt remove --purge \
  totem simple-scan gnome-connections \
  malcontent malcontent-control \
  gnome-maps gnome-weather gnome-tour

sudo apt autoremove --purge
```

---

## Verificação de firmware de GPU (AMD)

Em sistemas com GPU AMD, o pacote `firmware-amd-graphics` deve ser instalado automaticamente durante a instalação do Debian, desde que o repositório `non-free-firmware` esteja ativo.

Esse pacote é essencial para:

* Driver `amdgpu`
* Aceleração gráfica
* Vulkan
* Decodificação/encoding por hardware

### Verificação

```bash
apt policy firmware-amd-graphics
```

> ⚠️ Caso **não esteja instalado** e a GPU seja AMD:
>
> ```bash
> sudo apt install firmware-amd-graphics
> ```

---

## Stack gráfico (GPU / Wayland / X11) — Referência

Pacotes essenciais para renderização 3D, aceleração gráfica e compatibilidade:

* `mesa-vulkan-drivers` — Implementação Vulkan (jogos, Proton)
* `libgl1-mesa-dri` — OpenGL via Mesa
* `libglx-mesa0` — GLX para aplicações X11
* `libegl-mesa0` — EGL (Wayland e X11)
* `libvulkan1` — Loader Vulkan
* `libdrm2` — Comunicação direta com a GPU
* `xwayland` — Compatibilidade X11 em sessões Wayland

> Mesmo em sistemas **100% Wayland (GNOME padrão)**, o `xwayland` é necessário para Steam, jogos antigos e aplicações legadas.

---

## Flatpak e Flathub

```bash
sudo apt install flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

---

## Aceleração de vídeo (Referência)

* `mesa-va-drivers` — Backend VA-API (AMD / Intel)
* `libva-x11-2` — VA-API para aplicações X11

---

## Codecs multimídia

```bash
sudo apt install \
  ffmpeg \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-libav \
  libavcodec-extra
```

### Codecs para Flatpak (se necessário)

```bash
flatpak install flathub org.freedesktop.Platform.ffmpeg-full
```

---

## Áudio e sessão multimídia (Referência)

* `pipewire`
* `pipewire-pulse`
* `wireplumber`

---

## Aplicativos padrão Debian / GNOME

```bash
sudo apt install evolution seahorse file-roller
```

---

## LibreOffice

```bash
sudo apt install \
  libreoffice-writer \
  libreoffice-calc \
  libreoffice-impress \
  libreoffice-draw \
  libreoffice-gnome
```

---

## Ferramentas de configuração do GNOME

```bash
sudo apt install gnome-tweaks gnome-shell-extension-manager
```

---

## Terminal e utilitários básicos

```bash
sudo apt install curl wget fastfetch p7zip-full unrar
```

---

## ZRAM

```bash
sudo apt install zram-tools
sudo systemctl enable --now zramswap
```

---

## Ativar arquitetura i386

```bash
sudo dpkg --add-architecture i386
sudo apt update
```

### Bibliotecas i386 para jogos (Steam / Proton)

```bash
sudo apt install \
  mesa-vulkan-drivers:i386 \
  libgl1-mesa-dri:i386 \
  libglx-mesa0:i386 \
  libegl-mesa0:i386 \
  libvulkan1:i386
```

---

## GameMode

```bash
sudo apt install gamemode
```

---

## Google Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

> O `.deb` adiciona o repositório automaticamente.

---

## Organização pessoal

```bash
flatpak install flathub \
  com.bitwarden.desktop \
  md.obsidian.Obsidian
```

---

## Spotify (repositório moderno com signed-by)

```bash
curl -fsSL https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | \
  sudo gpg --dearmor -o /usr/share/keyrings/spotify-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/spotify-archive-keyring.gpg] https://repository.spotify.com stable non-free" | \
  sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update
sudo apt install spotify-client
```

---

## Produtividade

```bash
flatpak install flathub \
  io.github.diegopvlk.Tomatillo \
  com.rafaelmardojai.Blanket \
  io.gitlab.guillermop.Counters \
  com.github.johnfactotum.Foliate \
  info.febvre.Komikku
```

---

## Gestão e configuração

```bash
sudo apt install corectrl

flatpak install flathub \
  com.github.tchx84.Flatseal \
  io.github.flattool.Warehouse \
  io.github.giantpinkrobots.flatsweep \
  io.github.kolunmi.Bazaar \
  it.mijorus.gearlever
```

---

## Multimídia

```bash
flatpak install flathub io.github.diegopvlk.Cine
sudo apt install lollypop
```

---

## Desenvolvimento

```bash
sudo apt install default-jdk git
flatpak install flathub com.vscodium.codium
```

---

## Jogos

```bash
sudo apt install steam

flatpak install flathub \
  com.heroicgameslauncher.hgl \
  com.usebottles.bottles \
  net.davidotek.pupgui2 \
  com.github.Matoking.protontricks \
  com.discordapp.Discord
```

---

## Minecraft

```bash
wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install ./Minecraft.deb
```

---

## Emulação

```bash
flatpak install flathub org.libretro.RetroArch net.kuribo64.melonDS
```

---

## Monitoramento e desempenho

```bash
sudo apt install lm-sensors psensor mangohud

flatpak install flathub \
  io.missioncenter.MissionCenter \
  io.github.radiolamp.mangojuice
```

---

## Utilitários

```bash
sudo apt install gnome-boxes transmission

flatpak install flathub \
  org.flameshot.Flameshot \
  io.gitlab.adhami3310.Impression \
  org.localsend.localsend_app \
  dev.geopjr.Collision \
  dev.bragefuglseth.Keypunch
```

---

## Produção de conteúdo

```bash
flatpak install flathub \
  com.obsproject.Studio \
  com.github.wwmm.easyeffects \
  org.kde.kdenlive \
  org.shotcut.Shotcut \
  org.gimp.GIMP \
  org.kde.krita \
  org.inkscape.Inkscape \
  io.gitlab.adhami3310.Converter \
  fr.handbrake.ghb
```

---

## Snapshot e backup

```bash
sudo apt install timeshift pika-backup
```

---

## RPG

```bash
flatpak install flathub io.github.kriptolix.Poliedros de.hummdudel.Libellus
```
