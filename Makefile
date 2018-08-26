SIZE=512

NAME	= drive.img

all	:
	nasm mbr.s
	nasm kernel.s
	cat mbr kernel /dev/zero | dd of=$(NAME) bs=512 count=2280

sdb	:
	sudo dd bs=512 if=$(NAME) of=/dev/sdb

dis	:
	ndisasm -b 16 $(NAME)

fclean clean	:
	rm -f $(NAME) mbr kernel

re	: fclean all

