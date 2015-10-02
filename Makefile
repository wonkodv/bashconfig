all: setup_done generated/bashrc generated/bash_profile

setup_done:
	@test -d enabled || { echo "use enableall first, then select what to enable, then run install"; false ; }

install: all
	ln -i -s $(PWD)/generated/bashrc $(HOME)/.bashrc
	ln -i -s $(PWD)/generated/bash_profile $(HOME)/.bash_profile

generated/%: enabled/%.d/*.bash
	mkdir -p generated && { echo "### DO NOT EDIT THIS FILE###"; for f in $(sort $^) ; do echo "source $(PWD)/$$f";  done ; }  > $@

enableall:
	for f in available/*/*; do x="enabled/$${f#available/}"; mkdir -p `dirname $$x` && ln -s "../../$$f" $$x; done

clean:
	rm -rf generated/*
