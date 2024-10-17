default:
	echo "use make install"

install: generated/bashrc generated/bash_profile
	ln -i -s $(PWD)/generated/bashrc ~/.bashrc
	ln -i -s $(PWD)/generated/bash_profile ~/.bash_profile
	ln -i -s $(PWD)/ssh-config ~/.ssh/config
	ln -i -s $(PWD)/gitconfig ~/.gitconfig
	touch ~/.bashrc_local
	touch ~/.bash_profile_local

generated/%:
	mkdir -p generated
	{ echo "### Generated by $(PWD)/Makefile";                 \
		for f in $(@F).d/*.bash ;                              \
		do                                                     \
			echo "source $(PWD)/$$f";                          \
		done ;                                                 \
	}  > $@

clean:
	rm -rf generated/

.PHONY: clean install default diff
