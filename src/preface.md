# Preface

MIT offers a top-tier operating systems course, and I’d like to share it with you. Their approach strikes a great balance between theory and hands-on practice.

- The practical part is based on the **teaching operating system xv6** — it's written in C and implements all the core concepts of modern OS design. In many ways, xv6 resembles early Linux.
- The theoretical part comes from a **guide on operating systems** in general and on xv6 in particular.

Both resources are freely available under one of the most permissive licenses out there — the MIT license. On the one hand, that creates fantastic opportunities for self-learning. On the other, the learning curve can be steep: the guide doesn't really explain how to build and run the OS, debug it, and so on. Which makes sense — it was written to accompany lectures by MIT professors, not to serve as a self-contained textbook.

My goal is to adapt this material for self-learning. To do that, I filled in the gaps in the guide, wrote missing chapters, and expanded existing ones. On top of that, I added a build and debugging environment to the xv6 codebase that runs in a Docker container. I've tested it on **Ubuntu 24.04**, **macOS 15.1**, and **Windows 11**.

### Who This Book Is For

This book is primarily intended for:

- students taking — and instructors teaching — an operating systems course at universities or technical colleges;
- systems programmers who want to get a hands-on understanding of how a Unix-like operating system works so they can make more deliberate engineering decisions in their your code;
- aspiring kernel hackers dreaming of contributing to Linux or the kernel of another operating system.

It assumes you already have some experience programming in C, that you work in a Unix-like environment (or are at least aware of WSL2), and that you're comfortable with the shell. I also expect you to be familiar with **Docker** and **Git**.

### License

I received the original text of the guide under the MIT license. I improved and extended it, and released my changes under the MIT license as well. It's one of the most permissive licenses humanity has come up with. It allows you to:

- **use** this material however you like — for personal or commercial purposes;
- **modify**, **copy**, **publish**, and **distribute** it without restrictions;
- **include** it in your own projects, even proprietary ones;
- and do all of that **without asking** for my **permission** or the permission of the original authors.

The only requirement is to give credit to all authors.

### Acknowledgments

This work would have been impossible without the contribution of my team. Many thanks to **Julia Babakova** for working with the English text, including portions originally written by Russ Cox, Frans Kaashoek, and Robert Morris. In true open-source spirit, all changes were submitted back to the authors for review. Special thanks also to **Polina Migel** for helping format the text for the web and PDF versions of the book. Thanks to her, you can choose the format that suits you best.

I'd like to extend special gratitude to the subscribers of my Telegram channel, **CusDeb Magazine Pro**. They helped me keep up a steady pace: since mid-October 2025, I’ve been publishing each new section of this book in the channel along with homework assignments. Subscribers carefully read the material and ask questions about it. I use this feedback to make the text even clearer and more accessible.

<div align="right">
    <div>Evgeny Golyshev</div>
    <div>October 2025</div>
</div>

### Acknowledgments from the Original Authors

We have used this text in 6.828 and 6.1810, the operating system classes at MIT. We thank the faculty, teaching assistants, and students of those classes who have all directly or indirectly contributed to xv6. In particular, we would like to thank Adam Belay, Austin Clements, and Nickolai Zeldovich. Finally, we would like to thank people who emailed us bugs in the text or suggestions for improvements: Abutalib Aghayev, Sebastian Boehm, brandb97, Anton Burtsev, Raphael Carvalho, Tej Chajed,Brendan Davidson, Rasit Eskicioglu, Color Fuzzy, Wojciech Gac, Giuseppe, Tao Guo, Haibo Hao, Naoki Hayama, Chris Henderson, Robert Hilderman, Eden Hochbaum, Wolfgang Keller, Paweł Kraszewski, Henry Laih, Jin Li, Austin Liew, lyazj@github.com, Pavan Maddamsetti, Jacek Masiulaniec, Michael McConville, m3hm00d, Mes0903, miguelgvieira, Mark Morrissey, Muhammed Mourad, Harry Pan, Harry Porter, Siyuan Qian, Zhefeng Qiao, Askar Safin, Salman Shah, Huang Sha, Vikram Shenoy, Adeodato Simó, Ruslan Savchenko, Pawel Szczurko, Warren Toomey, tyfkda, tzerbib, Vanush Vaswani, Chen Wang, Xi Wang, and Zou Chang Wei, Sam Whitlock, Qiongsi Wu, LucyShawYang, ykf1114@gmail.com, and Meng Zhou.
