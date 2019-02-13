install:
	docker run \
		--user $(id -u):$(id -g) \
		-v $(PWD)/generate-certs.sh:/generate-certs.sh \
		-v $(PWD)/lb/certs:/certs \
		-v $(PWD)/ca:/ca \
		ubuntu bash /generate-certs.sh

.PHONY: install

