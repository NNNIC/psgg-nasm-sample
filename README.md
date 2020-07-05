# psgg-nasm-sample
Visual Programming Tool StateGo's NASM sample.

# sample

## Environment

- Windows 10
- [StateGo](https://statego.programanic.com/)
- [SASM](https://dman95.github.io/SASM/english.html)


## Charts

![](https://raw.githubusercontent.com/NNNIC/psgg-nasm-sample/master/wiki/sample.png)

1) Hello World と You are the sunshine　をprintfを使い表示

2) Gosub サンプル

3) Waitサンプル　(CountDown)
カウントが０になるまで、同ステートを繰り返す

4) ループサンプル
サブルーチンを規定回数繰り返す

5) 分岐サンプル

## Hello World

printfを使い表示。
メッセージはデータセクションに再配置されます。

![](https://raw.githubusercontent.com/NNNIC/psgg-nasm-sample/master/wiki/helloworld.png)


## Branch

分岐は eaxの値のみ対象となります。

![](https://raw.githubusercontent.com/NNNIC/psgg-nasm-sample/master/wiki/branch.png)

## Loop

ループアイテム用にマクロが用意されています。

![](https://raw.githubusercontent.com/NNNIC/psgg-nasm-sample/master/wiki/loop.png)

## Output

SASMでの実行結果。

![](https://raw.githubusercontent.com/NNNIC/psgg-nasm-sample/master/wiki/sasm.png)


