import oloren as olo
import os

@olo.register()
def hello():
    return "Hello World!"

if __name__ == "__main__":
    if "MODE" not in os.environ or os.environ["MODE"] == "DEV":
        cmd = f"jupyter notebook --no-browser --ip 0.0.0.0 --port={os.environ['JUPYTER_PORT']} --allow-root"
        os.system(cmd)
    
    olo.run(os.environ["EXTENSION_NAME"], port=80)
