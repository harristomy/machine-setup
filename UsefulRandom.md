# Put anything useful and random here

## Opening browser from python script

```python
import webbrowser
def open_browser(host, port):
    webbrowser.open("http://{}:{}/".format(host, port))
```

