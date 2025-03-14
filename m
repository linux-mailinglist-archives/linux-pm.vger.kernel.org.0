Return-Path: <linux-pm+bounces-24050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14DA610FB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E91B6216E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A51201266;
	Fri, 14 Mar 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="WtVuo5n8"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C81FECBD;
	Fri, 14 Mar 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954991; cv=none; b=Iuovxn5IJw7fCWclg7cuRpMeli/nvSHZ2I4VvKTd85ShbBA+CFgNjqr9eFIHvHGho7FBeX63gQTnQKHX158b2FMSNqHToA0cjMfa9Nzf9RSZYFMgMlY+PaQGtGTmemmmpBpQDrbax52c6KcNaHBwreZHbdAepsGS6hS5g6EcRJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954991; c=relaxed/simple;
	bh=tFRga1jJn4NTr4fnJjGRENmqepz52QRjDfO0encUxHM=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=HFEvIRctyNIGlFG/XwNP2MwnZcYlip78sccz5lRVhePjoPkeCX40ihs9I1BRuZ4zd1ErJ3DuFFmrH5w/KFavEMOsErhCaWiZNKoNzZqW1OVPHru0RaFUZpHBekCdLQgZIJRRh0gMLHPUqVlEEQ7FmiW6S75Y5aJMPNv+Z55FiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=WtVuo5n8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W/Lhx6iaHimRJlBONMl5q18ROWv3CbgOcjMkKXk02Wc=; b=WtVuo5n8JGTXSTt+ACJVny8SBv
	fuBDaL5XQEkYW8nHwEJ59Kp5RL7qxxLMO9hXxAtJBD+f/pADhpMt2A3O/sQtrQn39InusruGjky9T
	XjXfvEuiXUp4BiNFtScbM+CKz3HsN5ksz0ymAdmiTBFDpYOsxo2fQO3qMuYhlsGYKPRrSR/e/DHud
	le+UvzBO+LzU3p66A9G78pBWB6gOHRz3rvm4CvuRN4ZVpzahT59i2qVVbZtVFu+MSAiq5U4YjRV3v
	TLhPo9dkBFPqPj6noYwr64fvW45tOB/sdjOP0vRIKHyJ3M3thhGIZsTugaXzxb8NOaDoYc3u3ozkB
	LPV7kOfw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43t-006ZoX-1C;
	Fri, 14 Mar 2025 20:22:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:49 +0800
Date: Fri, 14 Mar 2025 20:22:49 +0800
Message-Id: <6e0f8f586af86dc5341a0d2c3e9f006377ac8378.1741954523.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741954523.git.herbert@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 11/13] ubifs: Pass folios to acomp
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

As the acomp interface supports folios, use that instead of mapping
the data in ubifs.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 fs/ubifs/compress.c | 105 +++++++++++++++++++++++++++++++++++++++++++-
 fs/ubifs/file.c     |  74 +++++++++++--------------------
 fs/ubifs/journal.c  |   9 ++--
 fs/ubifs/ubifs.h    |  11 ++++-
 4 files changed, 144 insertions(+), 55 deletions(-)

diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
index 9046e796876d..9973a2853de7 100644
--- a/fs/ubifs/compress.c
+++ b/fs/ubifs/compress.c
@@ -16,6 +16,7 @@
  */
 
 #include <crypto/acompress.h>
+#include <linux/highmem.h>
 #include "ubifs.h"
 
 /* Fake description object for the "none" compressor */
@@ -136,7 +137,7 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
 	{
 		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
 
-		acomp_request_set_src_nondma(req, in_buf, in_len);
+		acomp_request_set_src_dma(req, in_buf, in_len);
 		err = ubifs_compress_req(c, req, out_buf, out_len);
 	}
 
@@ -151,6 +152,58 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
 	*compr_type = UBIFS_COMPR_NONE;
 }
 
+/**
+ * ubifs_compress_folio - compress folio.
+ * @c: UBIFS file-system description object
+ * @in_folio: data to compress
+ * @in_offset: offset into @in_folio
+ * @in_len: length of the data to compress
+ * @out_buf: output buffer where compressed data should be stored
+ * @out_len: output buffer length is returned here
+ * @compr_type: type of compression to use on enter, actually used compression
+ *              type on exit
+ *
+ * This function compresses input folio @in_folio of length @in_len and
+ * stores the result in the output buffer @out_buf and the resulting length
+ * in @out_len. If the input buffer does not compress, it is just copied
+ * to the @out_buf. The same happens if @compr_type is %UBIFS_COMPR_NONE
+ * or if compression error occurred.
+ *
+ * Note, if the input buffer was not compressed, it is copied to the output
+ * buffer and %UBIFS_COMPR_NONE is returned in @compr_type.
+ */
+void ubifs_compress_folio(const struct ubifs_info *c, struct folio *in_folio,
+			  size_t in_offset, int in_len, void *out_buf,
+			  int *out_len, int *compr_type)
+{
+	int err;
+	struct ubifs_compressor *compr = ubifs_compressors[*compr_type];
+
+	if (*compr_type == UBIFS_COMPR_NONE)
+		goto no_compr;
+
+	/* If the input data is small, do not even try to compress it */
+	if (in_len < UBIFS_MIN_COMPR_LEN)
+		goto no_compr;
+
+	{
+		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
+
+		acomp_request_set_src_folio(req, in_folio, in_offset, in_len);
+		err = ubifs_compress_req(c, req, out_buf, out_len);
+	}
+
+	if (err)
+		goto no_compr;
+
+	return;
+
+no_compr:
+	memcpy_from_folio(out_buf, in_folio, in_offset, in_len);
+	*out_len = in_len;
+	*compr_type = UBIFS_COMPR_NONE;
+}
+
 static int ubifs_decompress_req(const struct ubifs_info *c,
 				struct acomp_req *req,
 				const void *in_buf, int in_len, int *out_len)
@@ -216,7 +269,55 @@ int ubifs_decompress(const struct ubifs_info *c, const void *in_buf,
 	{
 		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
 
-		acomp_request_set_dst_nondma(req, out_buf, *out_len);
+		acomp_request_set_dst_dma(req, out_buf, *out_len);
+		return ubifs_decompress_req(c, req, in_buf, in_len, out_len);
+	}
+}
+
+/**
+ * ubifs_decompress_folio - decompress folio.
+ * @c: UBIFS file-system description object
+ * @in_buf: data to decompress
+ * @in_len: length of the data to decompress
+ * @out_folio: output folio where decompressed data should
+ * @out_offset: offset into @out_folio
+ * @out_len: output length is returned here
+ * @compr_type: type of compression
+ *
+ * This function decompresses data from buffer @in_buf into folio
+ * @out_folio.  The length of the uncompressed data is returned in
+ * @out_len.  This functions returns %0 on success or a negative error
+ * code on failure.
+ */
+int ubifs_decompress_folio(const struct ubifs_info *c, const void *in_buf,
+			   int in_len, struct folio *out_folio,
+			   size_t out_offset, int *out_len, int compr_type)
+{
+	struct ubifs_compressor *compr;
+
+	if (unlikely(compr_type < 0 || compr_type >= UBIFS_COMPR_TYPES_CNT)) {
+		ubifs_err(c, "invalid compression type %d", compr_type);
+		return -EINVAL;
+	}
+
+	compr = ubifs_compressors[compr_type];
+
+	if (unlikely(!compr->capi_name)) {
+		ubifs_err(c, "%s compression is not compiled in", compr->name);
+		return -EINVAL;
+	}
+
+	if (compr_type == UBIFS_COMPR_NONE) {
+		memcpy_to_folio(out_folio, out_offset, in_buf, in_len);
+		*out_len = in_len;
+		return 0;
+	}
+
+	{
+		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
+
+		acomp_request_set_dst_folio(req, out_folio, out_offset,
+					    *out_len);
 		return ubifs_decompress_req(c, req, in_buf, in_len, out_len);
 	}
 }
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5130123005e4..bf311c38d9a8 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -42,8 +42,8 @@
 #include <linux/slab.h>
 #include <linux/migrate.h>
 
-static int read_block(struct inode *inode, void *addr, unsigned int block,
-		      struct ubifs_data_node *dn)
+static int read_block(struct inode *inode, struct folio *folio, size_t offset,
+		      unsigned int block, struct ubifs_data_node *dn)
 {
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	int err, len, out_len;
@@ -55,7 +55,7 @@ static int read_block(struct inode *inode, void *addr, unsigned int block,
 	if (err) {
 		if (err == -ENOENT)
 			/* Not found, so it must be a hole */
-			memset(addr, 0, UBIFS_BLOCK_SIZE);
+			folio_zero_range(folio, offset, UBIFS_BLOCK_SIZE);
 		return err;
 	}
 
@@ -74,8 +74,8 @@ static int read_block(struct inode *inode, void *addr, unsigned int block,
 	}
 
 	out_len = UBIFS_BLOCK_SIZE;
-	err = ubifs_decompress(c, &dn->data, dlen, addr, &out_len,
-			       le16_to_cpu(dn->compr_type));
+	err = ubifs_decompress_folio(c, &dn->data, dlen, folio, offset,
+				     &out_len, le16_to_cpu(dn->compr_type));
 	if (err || len != out_len)
 		goto dump;
 
@@ -85,7 +85,7 @@ static int read_block(struct inode *inode, void *addr, unsigned int block,
 	 * appending data). Ensure that the remainder is zeroed out.
 	 */
 	if (len < UBIFS_BLOCK_SIZE)
-		memset(addr + len, 0, UBIFS_BLOCK_SIZE - len);
+		folio_zero_range(folio, offset + len, UBIFS_BLOCK_SIZE - len);
 
 	return 0;
 
@@ -98,27 +98,25 @@ static int read_block(struct inode *inode, void *addr, unsigned int block,
 
 static int do_readpage(struct folio *folio)
 {
-	void *addr;
 	int err = 0, i;
 	unsigned int block, beyond;
 	struct ubifs_data_node *dn = NULL;
 	struct inode *inode = folio->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	loff_t i_size = i_size_read(inode);
+	size_t offset = 0;
 
 	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
 		inode->i_ino, folio->index, i_size, folio->flags);
 	ubifs_assert(c, !folio_test_checked(folio));
 	ubifs_assert(c, !folio->private);
 
-	addr = kmap_local_folio(folio, 0);
-
 	block = folio->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
 	beyond = (i_size + UBIFS_BLOCK_SIZE - 1) >> UBIFS_BLOCK_SHIFT;
 	if (block >= beyond) {
 		/* Reading beyond inode */
 		folio_set_checked(folio);
-		addr = folio_zero_tail(folio, 0, addr);
+		folio_zero_range(folio, 0, folio_size(folio));
 		goto out;
 	}
 
@@ -135,9 +133,9 @@ static int do_readpage(struct folio *folio)
 		if (block >= beyond) {
 			/* Reading beyond inode */
 			err = -ENOENT;
-			memset(addr, 0, UBIFS_BLOCK_SIZE);
+			folio_zero_range(folio, offset, UBIFS_BLOCK_SIZE);
 		} else {
-			ret = read_block(inode, addr, block, dn);
+			ret = read_block(inode, folio, offset, block, dn);
 			if (ret) {
 				err = ret;
 				if (err != -ENOENT)
@@ -147,17 +145,13 @@ static int do_readpage(struct folio *folio)
 				int ilen = i_size & (UBIFS_BLOCK_SIZE - 1);
 
 				if (ilen && ilen < dlen)
-					memset(addr + ilen, 0, dlen - ilen);
+					folio_zero_range(folio, offset + ilen, dlen - ilen);
 			}
 		}
 		if (++i >= (UBIFS_BLOCKS_PER_PAGE << folio_order(folio)))
 			break;
 		block += 1;
-		addr += UBIFS_BLOCK_SIZE;
-		if (folio_test_highmem(folio) && (offset_in_page(addr) == 0)) {
-			kunmap_local(addr - UBIFS_BLOCK_SIZE);
-			addr = kmap_local_folio(folio, i * UBIFS_BLOCK_SIZE);
-		}
+		offset += UBIFS_BLOCK_SIZE;
 	}
 
 	if (err) {
@@ -177,8 +171,6 @@ static int do_readpage(struct folio *folio)
 	kfree(dn);
 	if (!err)
 		folio_mark_uptodate(folio);
-	flush_dcache_folio(folio);
-	kunmap_local(addr);
 	return err;
 }
 
@@ -602,18 +594,16 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
 	struct inode *inode = folio->mapping->host;
 	loff_t i_size = i_size_read(inode);
 	unsigned int page_block;
-	void *addr, *zaddr;
+	size_t offset = 0;
 	pgoff_t end_index;
 
 	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
 		inode->i_ino, folio->index, i_size, folio->flags);
 
-	addr = zaddr = kmap_local_folio(folio, 0);
-
 	end_index = (i_size - 1) >> PAGE_SHIFT;
 	if (!i_size || folio->index > end_index) {
 		hole = 1;
-		addr = folio_zero_tail(folio, 0, addr);
+		folio_zero_range(folio, 0, folio_size(folio));
 		goto out_hole;
 	}
 
@@ -623,7 +613,7 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
 
 		if (nn >= bu->cnt) {
 			hole = 1;
-			memset(addr, 0, UBIFS_BLOCK_SIZE);
+			folio_zero_range(folio, offset, UBIFS_BLOCK_SIZE);
 		} else if (key_block(c, &bu->zbranch[nn].key) == page_block) {
 			struct ubifs_data_node *dn;
 
@@ -645,13 +635,15 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
 					goto out_err;
 			}
 
-			err = ubifs_decompress(c, &dn->data, dlen, addr, &out_len,
-					       le16_to_cpu(dn->compr_type));
+			err = ubifs_decompress_folio(
+				c, &dn->data, dlen, folio, offset, &out_len,
+				le16_to_cpu(dn->compr_type));
 			if (err || len != out_len)
 				goto out_err;
 
 			if (len < UBIFS_BLOCK_SIZE)
-				memset(addr + len, 0, UBIFS_BLOCK_SIZE - len);
+				folio_zero_range(folio, offset + len,
+						 UBIFS_BLOCK_SIZE - len);
 
 			nn += 1;
 			read = (i << UBIFS_BLOCK_SHIFT) + len;
@@ -660,23 +652,19 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
 			continue;
 		} else {
 			hole = 1;
-			memset(addr, 0, UBIFS_BLOCK_SIZE);
+			folio_zero_range(folio, offset, UBIFS_BLOCK_SIZE);
 		}
 		if (++i >= UBIFS_BLOCKS_PER_PAGE)
 			break;
-		addr += UBIFS_BLOCK_SIZE;
+		offset += UBIFS_BLOCK_SIZE;
 		page_block += 1;
-		if (folio_test_highmem(folio) && (offset_in_page(addr) == 0)) {
-			kunmap_local(addr - UBIFS_BLOCK_SIZE);
-			addr = kmap_local_folio(folio, i * UBIFS_BLOCK_SIZE);
-		}
 	}
 
 	if (end_index == folio->index) {
 		int len = i_size & (PAGE_SIZE - 1);
 
 		if (len && len < read)
-			memset(zaddr + len, 0, read - len);
+			folio_zero_range(folio, len, read - len);
 	}
 
 out_hole:
@@ -686,14 +674,10 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
 	}
 
 	folio_mark_uptodate(folio);
-	flush_dcache_folio(folio);
-	kunmap_local(addr);
 	*n = nn;
 	return 0;
 
 out_err:
-	flush_dcache_folio(folio);
-	kunmap_local(addr);
 	ubifs_err(c, "bad data node (block %u, inode %lu)",
 		  page_block, inode->i_ino);
 	return -EINVAL;
@@ -898,7 +882,6 @@ static int do_writepage(struct folio *folio, size_t len)
 {
 	int err = 0, blen;
 	unsigned int block;
-	void *addr;
 	size_t offset = 0;
 	union ubifs_key key;
 	struct inode *inode = folio->mapping->host;
@@ -913,26 +896,19 @@ static int do_writepage(struct folio *folio, size_t len)
 
 	folio_start_writeback(folio);
 
-	addr = kmap_local_folio(folio, offset);
 	block = folio->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
 	for (;;) {
 		blen = min_t(size_t, len, UBIFS_BLOCK_SIZE);
 		data_key_init(c, &key, inode->i_ino, block);
-		err = ubifs_jnl_write_data(c, inode, &key, addr, blen);
+		err = ubifs_jnl_write_data(c, inode, &key, folio, offset, blen);
 		if (err)
 			break;
 		len -= blen;
 		if (!len)
 			break;
 		block += 1;
-		addr += blen;
-		if (folio_test_highmem(folio) && !offset_in_page(addr)) {
-			kunmap_local(addr - blen);
-			offset += PAGE_SIZE;
-			addr = kmap_local_folio(folio, offset);
-		}
+		offset += blen;
 	}
-	kunmap_local(addr);
 	if (err) {
 		mapping_set_error(folio->mapping, err);
 		ubifs_err(c, "cannot write folio %lu of inode %lu, error %d",
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 7629ca9ecfe8..ee954e64ce7f 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -845,14 +845,16 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
  * @c: UBIFS file-system description object
  * @inode: inode the data node belongs to
  * @key: node key
- * @buf: buffer to write
+ * @folio: buffer to write
+ * @offset: offset to write at
  * @len: data length (must not exceed %UBIFS_BLOCK_SIZE)
  *
  * This function writes a data node to the journal. Returns %0 if the data node
  * was successfully written, and a negative error code in case of failure.
  */
 int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
-			 const union ubifs_key *key, const void *buf, int len)
+			 const union ubifs_key *key, struct folio *folio,
+			 size_t offset, int len)
 {
 	struct ubifs_data_node *data;
 	int err, lnum, offs, compr_type, out_len, compr_len, auth_len;
@@ -896,7 +898,8 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 		compr_type = ui->compr_type;
 
 	out_len = compr_len = dlen - UBIFS_DATA_NODE_SZ;
-	ubifs_compress(c, buf, len, &data->data, &compr_len, &compr_type);
+	ubifs_compress_folio(c, folio, offset, len, &data->data, &compr_len,
+			     &compr_type);
 	ubifs_assert(c, compr_len <= UBIFS_BLOCK_SIZE);
 
 	if (encrypted) {
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 7d0aaf5d2e23..256dbaeeb0de 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -263,6 +263,8 @@ enum {
 	ASSACT_PANIC,
 };
 
+struct folio;
+
 /**
  * struct ubifs_old_idx - index node obsoleted since last commit start.
  * @rb: rb-tree node
@@ -1784,7 +1786,8 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 		     const struct fscrypt_name *nm, const struct inode *inode,
 		     int deletion, int xent, int in_orphan);
 int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
-			 const union ubifs_key *key, const void *buf, int len);
+			 const union ubifs_key *key, struct folio *folio,
+			 size_t offset, int len);
 int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode);
 int ubifs_jnl_delete_inode(struct ubifs_info *c, const struct inode *inode);
 int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
@@ -2084,8 +2087,14 @@ int __init ubifs_compressors_init(void);
 void ubifs_compressors_exit(void);
 void ubifs_compress(const struct ubifs_info *c, const void *in_buf, int in_len,
 		    void *out_buf, int *out_len, int *compr_type);
+void ubifs_compress_folio(const struct ubifs_info *c, struct folio *folio,
+			 size_t offset, int in_len, void *out_buf,
+			 int *out_len, int *compr_type);
 int ubifs_decompress(const struct ubifs_info *c, const void *buf, int len,
 		     void *out, int *out_len, int compr_type);
+int ubifs_decompress_folio(const struct ubifs_info *c, const void *buf,
+			   int len, struct folio *folio, size_t offset,
+			   int *out_len, int compr_type);
 
 /* sysfs.c */
 int ubifs_sysfs_init(void);
-- 
2.39.5


