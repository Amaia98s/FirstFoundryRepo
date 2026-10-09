# Calculadora en Solidity

Mi primer proyecto con [Foundry](https://getfoundry.sh): un contrato de calculadora con control de acceso, probado con tests unitarios y *fuzzing*.

## El contrato: `Calculadora.sol`

Guarda el último resultado calculado en la blockchain y solo permite operar a una dirección administradora.

| Función | Qué hace |
|---|---|
| `addition(a, b)` | Devuelve y guarda `a + b` |
| `substraction(a, b)` | Devuelve y guarda `a - b` |
| `multiplier(a, b)` | Devuelve y guarda `a * b` |
| `division(a, b)` | Devuelve y guarda `a / b` (división entera) |
| `resultado()` | Lee el último resultado guardado |
| `admin()` | Lee la dirección administradora |

- **Constructor:** recibe el resultado inicial y la dirección del `admin`.
- **Control de acceso:** las cuatro operaciones usan el modificador `onlyAdmin`. Si las llama otra cuenta, revierten con `"Not allowed"`.
- **Eventos:** cada operación emite un evento (`Addition`, `Substraction`, `Multiplier`, `Division`) con los operandos y el resultado.
- **Seguridad aritmética:** desde Solidity 0.8 los desbordamientos revierten automáticamente. Lo mismo ocurre con una resta con resultado negativo o una división entre cero.

## Tests

`test/CalculadoraTest.t.sol` incluye 10 tests:

- **Unitarios:** valor inicial, cada operación, desbordamiento en la multiplicación, división entre cero y llamada desde una cuenta que no es admin.
- **Fuzzing:** `testFuzzingDivision` prueba `division` con cientos de pares de números aleatorios (excluyendo el divisor 0).

## Uso

Requiere [Foundry](https://book.getfoundry.sh/getting-started/installation).

```bash
git clone --recursive https://github.com/Amaia98s/FirstFoundryRepo.git
cd FirstFoundryRepo
forge build
forge test -vvv
```

## Tecnologías

Solidity 0.8.24 · Foundry (forge, forge-std)
