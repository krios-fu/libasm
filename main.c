/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: krios-fu <krios-fu@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/01/05 19:38:21 by krios-fu          #+#    #+#             */
/*   Updated: 2021/01/05 19:38:27 by krios-fu         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/errno.h>
#include <stdlib.h>

size_t	ft_strlen(char *);
char	*ft_strcpy(char *dst, const char *src);
int		ft_strcmp(const char *s1, const char *s2);
ssize_t	ft_write(int, const void *, size_t);
ssize_t	ft_read(int, void *, size_t);
char	*ft_strdup(const char *);

int main()
{
	/* STRLEN */

	printf("strlen ret: %4zu\n", strlen("holaaaa\n"));
	printf("ft_strlen ret: %zu\n", ft_strlen("holaaaa\n"));
	printf("strlen ret: %4zu\n", strlen(""));
	printf("ft_strlen ret: %zu\n\n", ft_strlen(""));


	/* STRCPY */
	char *src = "ktal";
	char dst1[5];
	char dst2[5];
//	char *ret = ft_strcpy(str2, src);
//	printf("str2 dir: %p\n", str2);
// 	printf("strcpy ret: %p\n", ret);
	
	printf("strcpy: %s\n", strcpy(dst1, "ho"));
	printf("ft_strcpy: %s\n", ft_strcpy(dst2, "ho"));
	printf("strcpy: %s\n", strcpy(dst1, src));
	printf("ft_strcpy: %s\n", ft_strcpy(dst2, src));
	printf("strcpy: %s\n", strcpy(dst1, "hola"));
	printf("ft_strcpy: %s\n", ft_strcpy(dst2, "hola"));
//	printf("strcpy: %s\n", strcpy(dst1, "holaa"));
//	printf("ft_strcpy: %s\n", ft_strcpy(dst2, "holaa"));
	char test[8] = "asdfghj";
	char test2[8] = "asdfghj";
	printf("strcpy: %s\n", strcpy(test2, "hola"));
	printf("ft_strcpy: %s\n\n", ft_strcpy(test, "hola"));
//	printf("strcpy: %s\n", strcpy("asl;fjl;asdjfjkasdl;fjadjsf", "asl;fjl;asdjfjkasdl;fjadjsf"));
//	printf("ft_strcpy: %s\n", ft_strcpy("asl;fjl;asdjfjkasdl;fjadjsf", "asl;fjl;asdjfjkasdl;fjadjsf"));


	/* STRCMP */
	char *uno = "hola";
	char *dos = "holaa";

	printf("strcmp: %d\n", strcmp("hola", "holaa"));
	printf("strcmp: %d\n", strcmp(uno, dos));
	printf("ft_strcmp: %d\n", ft_strcmp(uno, dos));
	printf("strcmp: %d\n", strcmp(uno, dos));
	printf("ft_strcmp: %d\n", ft_strcmp(uno, dos));
	printf("strcmp: %d\n", strcmp("hola", "hol"));
	printf("ft_strcmp: %d\n", ft_strcmp("hola", "hol"));
	printf("strcmp: %d\n", strcmp("hola", ""));
	printf("ft_strcmp: %d\n", ft_strcmp("hola", ""));
	printf("strcmp: %d\n", strcmp("hola", "hola"));
	printf("ft_strcmp: %d\n", ft_strcmp("hola", "hola"));
	printf("strcmp: %d\n", strcmp("", ""));
	printf("ft_strcmp: %d\n", ft_strcmp("", ""));
	printf("strcmp: %d\n", strcmp("hola", "adios"));
	printf("ft_strcmp: %d\n", ft_strcmp("hola", "adios"));
	//printf("\xff\xff\n\x31\n");
	printf("strcmp: %d\n", strcmp("\xff\xff", "\xff"));
	printf("ft_strcmp: %d\n", ft_strcmp("\xff\xff", "\xff"));
	printf("strcmp: %d\n", strcmp("\xff", ""));
	printf("ft_strcmp: %d\n\n", ft_strcmp("\xff", ""));


	/* FT_WRITE */
	printf("write: %zd\n", write(1, "hola\n", 5));
	printf("ft_write: %zd\n", ft_write(1, "hola\n", 5));
	printf("\nwrite: %zd\n", write(1, "hola\n", 3));
	printf("\nft_write: %zd\n", ft_write(1, "hola\n", 3));
	int a = write(FOPEN_MAX + 1, "abcdefghijklmnopqrstuvwxyz\n", 27);
	perror("write errno");
	errno = 100;
    int b = ft_write(FOPEN_MAX + 1, "abcdefghijklmnopqrstuvwxyz\n", 27);
	perror("ft_write errno");
    printf("return write = %d\nreturn ft_write = %d\n\n", a, b);


	/* FT_READ */
	char buf[10];
	char buf2[10];
	char buf3[10];
	char buf4[10];

	int fd = open("readthis", O_RDONLY);
	printf("read: %4zd\n", read(fd, buf, 9));
	printf("%s\n", buf);
	close(fd);
	fd = open("readthis", O_RDONLY);
	printf("ft_read: %zd\n", ft_read(fd, buf2, 9));
	printf("%s\n", buf2);
	close(fd);

	errno = 100;
	a = read(FOPEN_MAX, buf, 9);
	perror("read errno");
	errno = 100;
	b = ft_read(FOPEN_MAX, buf, 9);
	perror("ft_read errno");
	printf("return read = %d\nreturn ft_read = %d\n", a, b);

	errno = 100;
	fd = open("readths", O_RDONLY);
	a = read(fd, buf3, 9);
	perror("read errno");
	close(fd);
	errno = 100;
	fd = open("readths", O_RDONLY);
	b = ft_read(fd, buf4, 9);
	perror("ft_read errno");
	printf("return read = %d\nreturn ft_read = %d\n", a, b);
	printf("read: %s\nft_read: %s\n\n", buf3, buf4);


	/* FT_STRDUP */
	char src1[] = "hola";
	char *dst;

	dst = strdup(src1);
	printf("strdup: %s\n", dst);
	free(dst);
	dst = ft_strdup(src1);
	printf("ft_strdup: %s\n", dst);
	free(dst);
	dst = strdup("a");
	printf("strdup: %s\n", dst);
	free(dst);
	dst = ft_strdup("a");
	printf("ft_strdup: %s\n", dst);
	free(dst);
	dst = strdup("");
	printf("strdup: %s\n", dst);
	free(dst);
	dst = ft_strdup("");
	printf("ft_strdup: %s\n", dst);
	free(dst);

	return (0);
}