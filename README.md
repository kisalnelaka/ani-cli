<p align="center">
<img src="https://img.shields.io/badge/status-unsalvageable-red">
<img src="https://img.shields.io/badge/maintained_by-kisalnelaka-blueviolet">
<img src="https://img.shields.io/badge/os-yes-brightgreen">
<img src="https://img.shields.io/badge/tested_at-4am-black">
<img src="https://img.shields.io/badge/mental_state-send_a_priest-orange">
<img src="https://img.shields.io/badge/dub_watchers-i_see_you-darkred">
<img src="https://img.shields.io/badge/sleep-a_government_conspiracy-darkgray">
<img src="https://img.shields.io/badge/chafa-install_it_or_leave-blue">
</p>

<h1 align="center">ani-cli</h1>

<p align="center">
  <b>watch anime from the terminal</b><br>
  <i>fork of <a href="https://github.com/pystardust/ani-cli">pystardust/ani-cli</a> — the extended, bloated, unsalvageable, fully functional cut</i><br><br>
  <sub>crafted at 4am by someone who started by "just adding a small feature" and did not stop for six hours</sub>
</p>

---

## what is this

a shell script that watches anime. also it now has:

- an **interactive home dashboard** that opens when you type literally nothing
- a **live fzf metadata preview pane** that fetches synopsis, score, genres, MAL ID, and cover art in real time as you hover
- **cover art. in the terminal. rendered in unicode half-block characters with 24-bit TrueColor.** yes i know. yes it works. no i won't apologize.
- a **seasonal anime browser** because apparently that was important to me at 2am
- a **fuzzy release countdown picker** for when you are clinically incapable of just checking MAL like a normal person
- **instant preview caching** so the second hover is instant and the first hover is fast enough
- **ctrl-key preview scrolling** because synopses are long and scroll wheels are for cowards

it is a lot. the original was 700 lines. i have done things to it. it still works. i checked. multiple times. at increasingly unhinged hours.

---

## features (honest edition)

| feature | status | notes |
|---------|--------|-------|
| watching anime | yes | this is the whole point |
| zero-arg dashboard | yes | just type `ani-cli`. that's it. |
| fzf preview pane | yes | hover and it loads. like magic except it's curl |
| terminal cover art | yes | looks unreal. actually real. |
| seasonal browser | yes | `-S` |
| next episode countdown | yes | `-c` |
| trending | yes | `-t` |
| sub | yes | as god intended |
| dub | unfortunately yes | you're on your own spiritually |
| sanity | no | filed under "future work" |
| minimalism | absolutely not | i tried. i failed. i added more features. |
| knowing when to stop | still no | look at this readme |

---

## install

**linux / mac:**
```sh
git clone https://github.com/kisalnelaka/ani-cli.git
sudo cp ani-cli/ani-cli /usr/local/bin/ani-cli
chmod +x /usr/local/bin/ani-cli
```

**windows:**

open git bash. inside windows terminal. not mintty. i know you know what mintty is. i know you're considering it. please. for both of us. do not.

```sh
git clone https://github.com/kisalnelaka/ani-cli.git
cp ani-cli/ani-cli /usr/bin/ani-cli
chmod +x /usr/bin/ani-cli
```

---

## dependencies. all of them. i'm watching.

| thing | why | how required |
|-------|-----|-------------|
| `mpv` | plays the actual video | required. obviously. |
| `fzf` | the entire user interface is fzf. fzf is the ui. fzf is life. fzf is the reason any of this exists. praise fzf. | REQUIRED. non-negotiable. |
| `chafa` | renders cover art inside your terminal using unicode. it's completely unhinged technology and i am in love with it. if you don't install this we are not friends. | install it RIGHT NOW |
| `curl` `grep` `sed` | the skeleton of the universe | already on your machine probably |
| `yt-dlp` `ffmpeg` | downloading stuff | optional but why wouldn't you |
| `patch` | self-updating | yes |

**windows (scoop). run the whole line. do not make choices.**
```sh
scoop install fzf mpv ffmpeg chafa yt-dlp
```

---

## how to use this thing

```
ani-cli                                   opens the dashboard. zero args. just enter. that's the feature.
ani-cli "cowboy bebop"                    search. direct. no dashboard.
ani-cli "cowboy bebop" --dub              dub. i'm not going to argue. you've made your choice.
ani-cli -S                                seasonal browser. what's airing right now.
ani-cli -c                                fuzzy countdown. when does it drop.
ani-cli -t                                trending. curated by the algorithm and the void.
ani-cli -d "hunter x hunter"             download mode. hxh has 148 episodes. plan accordingly.
ani-cli -e 1-148 "hunter x hunter"       all of them. no hesitation. this is character.
ani-cli -q 1080 "made in abyss"          1080p. for the art direction. it deserves it.
ani-cli -U                               update. please. do this sometimes.
ani-cli -h                               all the flags. there are many. you probably won't read them.
```

**when you're in the fzf picker hovering over things:**

the right panel is alive. it's fetching. cover art loads. synopsis appears. genres, score, MAL ID. all of it.

| key | what happens |
|-----|-------------|
| `ctrl-d` / `ctrl-f` | scroll preview down. synopses are long. |
| `ctrl-u` / `ctrl-b` | scroll preview up. you overshot. |
| `enter` | you've decided. respect. it plays. |

**env vars for the neurotically customizable:**

| variable | default | explanation |
|----------|---------|-------------|
| `ANI_CLI_THUMBNAILS` | `1` | `0` if you want to watch anime like you hate yourself |
| `ANI_CLI_CHAFA_ARGS` | sane defaults | override chafa rendering. go absolutely feral. |
| `ANI_CLI_PREVIEW_WINDOW` | `right:40%:wrap:border-left` | if the preview placement offends your sensibilities |
| `ANI_CLI_DOWNLOAD_DIR` | wherever you ran the command | set this. trust me. set this. |
| `ANI_CLI_PLAYER` | `mpv` | `vlc` is right there if you need it. i won't judge. i will be disappointed but i won't judge. |

---

## troubleshooting

**thumbnails not showing up**
you don't have chafa. i said install chafa. it's in the dependencies table. with emphasis. `scoop install chafa`. do it. then delete the cache with `rm -rf ~/.cache/ani-cli` and try again.

**first result shows a blank preview panel**
scroll to the second result and back. fzf has a startup race condition on windows. it is known. it is fine. it will not be fixed. we live with it.

**you're using mintty**
i have so much love for you as a person. please open windows terminal. add the git bash profile. come back. it'll work.

**it crashed or something is broken**
`rm -rf ~/.cache/ani-cli` — clears everything. regenerates clean on next run. if this doesn't fix it check that ALL your dependencies are installed. every single one. yes including the ones you thought were optional. they're not optional.

**you watched dub and now feel weird about it**
that's between you and your conscience.

---

## credit

[pystardust](https://github.com/pystardust) [port19x](https://github.com/port19x) [justchokingaround](https://github.com/justchokingaround) [Derisis13](https://github.com/Derisis13) and everyone who touched the original codebase. solid foundation. i built something inadvisable on top of it. that's on me.

---

## license

GPL v3 — [LICENSE](./LICENSE) — fork by [kisalnelaka](https://github.com/kisalnelaka)

it's almost 4am. the thumbnail renderer renders thumbnails. the preview pane previews. the countdown counts down. go watch something. in sub.
