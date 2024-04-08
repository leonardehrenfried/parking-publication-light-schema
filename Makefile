
SRCS = $(shell find original -wholename 'original/*.json')

OBJS6 = $(patsubst original/%.json,draft6/%.json,$(SRCS))
OBJS7 = $(patsubst original/%.json,draft7/%.json,$(SRCS))

draft6/%.json: original/%.json
	mkdir -p draft6
	alterschema --from draft4 --to draft6 $< > $@

draft7/%.json: draft6/%.json
	mkdir -p draft7
	alterschema --from draft6 --to draft7 $< > $@

migrate: $(OBJS6) $(OBJS7)

deduplicate:
	node duplicate-allof.js

docs: deduplicate
	mkdir -p docs
	generate-schema-doc draft7 docs

clean:
	rm -rf draft6 draft7 combined

