# https://github.com/honkit/honkit
setup:
	npm install honkit --save-dev

build:
	npx honkit build . public --log=debug

pdf:
	npx honkit pdf . xv6-riscv-expanded-edition.pdf

epub:
	npx honkit epub . xv6-riscv-expanded-edition.epub

serve:
	npx honkit serve
