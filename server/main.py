import os
from fastapi import FastAPI, HTTPException
import subprocess

app = FastAPI()
folder_name=sample_folder
subprocess.run(f"echo 'echo Started!' > ./exec-cicd-pipe", shell=True, check=True)

@app.post("/pull/{name}")
def read_root(name: str):
    dir_path = os.path.join(f'~/{folder_name}', f'{name}/')
    
    subprocess.run(
        f"echo 'cd {dir_path} && docker-compose pull && docker-compose up -d' > ./exec-cicd-pipe", 
        shell=True, check=True)
    return {"status": "Success"}
