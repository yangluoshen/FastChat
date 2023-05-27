
controller:
	python -m fastchat.serve.controller --host "127.0.0.1"

worker:
	python -m fastchat.serve.model_worker --model-path ./models/vicuna-13b-GPTQ-4bit-128g --model-name gpt-3.5-turbo --wbits 4 --groupsize 128 --host "127.0.0.1" --worker-address "http://127.0.0.1:21002" --controller-address "http://127.0.0.1:21001"

web_server:
	python3 -m fastchat.serve.gradio_web_server --controller-url "http://127.0.0.1:21001"

build-GPTQ-for-LLaMa:
	# inspire by https://medium.com/@martin-thissen/vicuna-13b-best-free-chatgpt-alternative-according-to-gpt-4-tutorial-gpu-ec6eb513a717
	mkdir repositories && cd repositories
	git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda && cd GPTQ-for-LLaMa
	python setup_cuda.py install
	# note:
	# 1. if failed with permission deny, then using python setup_cuda.py install --user 
	# 2. if torch version not match (cuda 12.1), then upgrade torch nightly: pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121 
