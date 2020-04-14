SRCS		= ft_write.s ft_read.s ft_strlen.s ft_strcmp.s ft_strcpy.s ft_strdup.s

SRCS_BONUS	= ft_atoi_base_bonus.s

OBJS		= ${SRCS:.s=.o}

OBJS_BONUS	= ${SRCS_BONUS:.s=.o}

NAME		= libsam.a

NA			= nasm

RM			= rm -f

FLAGS		= -f macho64

.s.o:
			${NA} ${FLAGS} -s $< -o ${<:.s=.o}

${NAME}:	${OBJS}
			ar rcs  ${NAME} ${OBJS}


bonus:		${OBJS} ${OBJS_BONUS}
			ar rcs  ${NAME} $(OBJS) ${OBJS_BONUS}

all:		${NAME}

clean:
			${RM} ${OBJS} ${OBJS_BONUS}

fclean:		clean
			${RM} ${NAME}

re:			fclean all bonus

.PHONY:		clean fclean re 