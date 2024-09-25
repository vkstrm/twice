import std/strformat
import std/random
import std/osproc
import std/tables
import std/cmdline
import std/json

type
  Video = object
    url: string
    name: string
    alias: seq[string]

let
  videos: Table[string, Video] = {
    "fancy": Video(name: "FANCY", alias: @["fncy"],
        url: "https://www.youtube.com/watch?v=kOHB85vDuow"),
    "kura kura": Video(name: "Kura Kura", alias: @["kura"],
        url: "https://www.youtube.com/watch?v=BSS8Y-0hOlY"),
    "better": Video(name: "Better", alias: @[],
        url: "https://www.youtube.com/watch?v=sLmLwgxnPUE"),
    "i cant stop me": Video(name: "I CAN'T STOP ME", alias: @["cantstop"],
        url: "https://www.youtube.com/watch?v=CM4CkVFmTds"),
    "yes or yes": Video(name: "Yes or Yes", alias: @["yes"],
        url: "https://www.youtube.com/watch?v=mAKsZ26SabQ"),
    "what is love": Video(name: "What is love?", alias: @["whatislove"],
        url: "https://www.youtube.com/watch?v=i0p1bmr0EmE"),
    "switch to me": Video(name: "Switch to me", alias: @["switch"],
        url: "https://www.youtube.com/watch?v=5UMgw3V-Q5I"),
    "more and more": Video(name: "MORE & MORE", alias: @["more"],
        url: "https://www.youtube.com/watch?v=mH0_XpSHkZo"),
    "likey": Video(name: "Likey", alias: @[],
        url: "https://www.youtube.com/watch?v=V2hlQkVJZhE"),
    "feel special": Video(name: "Feel Special", alias: @["feelspecial"],
        url: "https://www.youtube.com/watch?v=3ymwOvzhwHs"),
    "tt": Video(name: "TT", alias: @[], url: "https://www.youtube.com/watch?v=ePpPVE-GGJw"),
    "cheer up": Video(name: "Cheer Up", alias: @["cheer"],
        url: "https://www.youtube.com/watch?v=c7rCyll5AeY"),
    "like ooh-aah": Video(name: "Like OOH-AHH(OOH-AHH하게)", alias: @[
        "likeooh"], url: "https://www.youtube.com/watch?v=0rtV5esQT6I"),
    "knock knock": Video(name: "Knock Knock", alias: @["knock"],
        url: "https://www.youtube.com/watch?v=8A2t_tAjMz8"),
    "i want you back": Video(name: "I Want You Back", alias: @["wantback"],
        url: "https://www.youtube.com/watch?v=X3H-4crGD6k"),
    "heart shaker": Video(name: "Heart Shaker", alias: @["heartshaker"],
        url: "https://www.youtube.com/watch?v=rRzxEiBLQCA"),
    "signal": Video(name: "Signal", alias: @[],
        url: "https://www.youtube.com/watch?v=VQtonf1fv_s"),
    "bdz": Video(name: "BDZ", alias: @[],
        url: "https://www.youtube.com/watch?v=CMNahhgR_ss"),
    "brand new girl": Video(name: "Brand New Girl", alias: @["brandnew"],
        url: "https://www.youtube.com/watch?v=r1CMjQ0QJ1E"),
    "one more time": Video(name: "One More Time", alias: @["onemore"],
        url: "https://www.youtube.com/watch?v=HuoOEry-Yc4"),
    "merry and happy": Video(name: "Merry & Happy", alias: @["merryhappy"],
        url: "https://www.youtube.com/watch?v=zi_6oaQyckM"),
    "candy pop": Video(name: "Candy Pop", alias: @["candypop"],
        url: "https://www.youtube.com/watch?v=wQ_POfToaVY"),
    "alcohol-free": Video(name: "Alcohol-Free", alias: @["alcoholfree"],
        url: "https://www.youtube.com/watch?v=XA2YEHn-A8Q"),
    "breakthrough": Video(name: "Breakthrough", alias: @["break"],
        url: "https://www.youtube.com/watch?v=ZdKYi5ekshM"),
    "perfect world": Video(name: "Perfect World", alias: @["perfectworld"],
        url: "https://www.youtube.com/watch?v=fmOEKOjyDxU"),
    "the feels": Video(name: "The Feels", alias: @["feels"],
        url: "https://www.youtube.com/watch?v=f5_wn8mexmM")
  }.toTable()


proc list (full: bool) =
  if full:
    echo %videos
  else:
    for key in videos.keys:
      echo key

proc keysToSeq[T] (t: Table): seq[T] =
  for k in t.keys:
    result.add(k)

proc random (): Video =
  let keys = keysToSeq[string](videos)
  let index = rand(len(keys))
  let key = keys[index]
  videos[key]

proc getAlias (name: string): string =
  result = name
  for k, v in videos.pairs:
    if name in v.alias:
      result = k

proc play (video: Video) =
  let url = video.url
  discard execCmd fmt"firefox {url}"

when isMainModule:
  let commands = commandLineParams()
  if len(commands) == 0:
    echo "missing input"
    quit(QuitFailure)

  let command = commands[0]
  if command == "list":
    var full = false
    if commands.len() > 1 and commands[1] == "full":
      full = true
    list(full)
    quit(QuitSuccess)

  if command == "random":
    randomize()
    play(random())
    quit(QuitSuccess)

  let name = getAlias(command)
  if videos.hasKey(name):
    play(videos[name])
  else:
    echo "no such video"
    quit(QuitFailure)
