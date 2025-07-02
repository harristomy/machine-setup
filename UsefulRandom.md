# Put anything useful and random here

## Debugging

[Displaying arrays in watch window]

## Opening browser from python script

```python
import webbrowser
def open_browser(host, port):
    webbrowser.open("http://{}:{}/".format(host, port))
```

Debugging containers: https://www.reddit.com/r/devops/comments/xcrv9p/how_do_you_debug_a_docker_container_of_a_minimal/?tabId=related

## Memory analysis
[Measuring stack usage statically and at runtime]

## Containers

- Most comprehensive docker clean command I know so far: `docker system prune --volumes -a -f`

## Repos of interest

- [Control] - Embedded Firmware Control Systems Toolbox (Pure C and GNU Octave)
- [czkawka] - Multi functional app to find duplicates, empty folders, similar images etc.

## Reading

### Programming Languages

- [C++ recommended books]
- [SystemVerilog recommendations]
- [Rayon - Rust parallel iterator]

## Links

[C++ recommended books]: https://stackoverflow.com/questions/388242/the-definitive-c-book-guide-and-list/388282#388282
[czkawka]: https://github.com/qarmin/czkawka
[Control]: https://github.com/swedishembedded/control
[Displaying arrays in watch window]: https://github.com/microsoft/vscode-cpptools/issues/172#issuecomment-280520910
[Measuring stack usage statically and at runtime]: https://interrupt.memfault.com/blog/measuring-stack-usage
[SystemVerilog recommendations]: https://www.reddit.com/r/FPGA/comments/suc289/how_can_i_properly_learn_system_verilog/
[Rayon - Rust parallel iterator]: https://crates.io/crates/rayon
