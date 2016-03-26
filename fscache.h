#ifndef BACKFS_CACHE_WRF_H
#define BACKFS_CACHE_WRF_H
/*
 * BackFS Filesystem Cache
 * Copyright (c) 2010-2014 William R. Fraser
 */

#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <limits.h>
#include <sys/stat.h>

void cache_init(const char *cache_dir, uint64_t cache_size, uint64_t bucket_max_size);
int cache_fetch(const char *filename, uint32_t block, uint64_t offset,
        char *buf, uint64_t len, uint64_t *bytes_read, time_t mtime);
int cache_add(const char *filename, uint32_t block, const char *buf, 
        uint64_t len, const struct stat *stbuf);
int cache_stat(const char *filename, struct stat* stbuf);
int cache_invalidate_block(const char *filename, uint32_t block);
int cache_try_invalidate_block(const char *filename, uint32_t block);
int cache_invalidate_file(const char *filename);
int cache_try_invalidate_file(const char *filename);
int cache_free_orphan_buckets(void);
int cache_has_file(const char *filename, uint64_t *cached_byte_count);
int cache_try_invalidate_blocks_above(const char *filename, uint32_t block);
int cache_rename(const char *path, const char *path_new);

#endif //BACKFS_CACHE_WRF_H
