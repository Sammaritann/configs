FROM archlinux

RUN pacman -Syu --noconfirm --disable-download-timeout \
	base-devel cmake unzip ninja curl \
	gcc cmake git

ENV DEFAULT_INSTALL_DIR=/mnt/build_output
ENV DEFAULT_BUILD_TYPE=Release
ENV SOURCE_LOCATION=/usr/src/neovim

RUN git clone --depth 1 --branch stable \
	https://github.com/neovim/neovim.git \
	$SOURCE_LOCATION

COPY --chmod=777 entrypoint.sh /usr/bin/entrypoint.sh

VOLUME [ "/mnt/build_output" ]
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
CMD [ "build", "$DEFAULT_BUILD_TYPE" ]

