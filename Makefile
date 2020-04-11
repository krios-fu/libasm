SRCS		= ft_write.s ft_read.s ft_strlen.s ft_strcmp.s ft_strcpy.s ft_strdup.s

OBJS		= ${SRCS:.s=.o}

NAME		= libsam.a

NA			= nasm

RM			= rm -f

FLAGS		= -f macho64

.s.o:
			${NA} ${FLAGS} -s $< -o ${<:.s=.o}

${NAME}:	${OBJS}
			ar rcs  ${NAME} ${OBJS}


all:		${NAME}

clean:
			${RM} ${OBJS}

fclean:		clean
			${RM} ${NAME}

re:			fclean all

.PHONY:		clean fclean re 