dotenv rules demo
=================

I want to be sure that defined variables are loaded in the right order.   
In short, real environment variables > `.env` > `Makefile` > `docker-compose.yml`.

When running the script `execute.sh`, all the combinations are executed and each value
is printed in the console.

## Examples

For the examples, the variable `ORIGIN` is used with the following values, when set:
- `cmd` when exported in bash
- `dotenv` in `.env`
- `make` in `Makefile`
- `docker` in `docker-compose.yml`

```
docker-compose up --no-log-prefix 2>/dev/null | grep "ORIGIN" | sed -E "s/^.*=//g"
```
Without a `.env`, it will return `docker` since the Makefile is bypassed.
With a `.env`, it will return `dotenv` because `.env` have precedence over default values.

```
make docker
```
Without a `.env`, it will return `make` because it's the makefile default value.
With a `.env`, it will return `dotenv` because `.env` have precedence over default values.

```
ORIGIN=cmd make docker
```
Always `cmd`, with or without a `.env`, because the real environment must have
precedence over other values.
