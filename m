Return-Path: <linux-pm+bounces-24103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF938A62AF7
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 11:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65CF189E24A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308F61F8AD7;
	Sat, 15 Mar 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="cOljTaim"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86D1F4CB6;
	Sat, 15 Mar 2025 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034645; cv=none; b=QiCh/ASQj8Wx3Xo35mod5JLN3PUzx3XhJKWmvM71haThXsZMRqjhC8Hu+zjFRvmYYao06v0uorZCea5NQsH0aP3dKISWadgBJ2fnZ15RfPL4vZHxOODBvgPzgeE1DkrMhQmgpMW0XNxDvhLaGRLl/Z9FxTHFlj5cmGYvMnZXzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034645; c=relaxed/simple;
	bh=kvxn+qwCajywvI6I6ZdtIhFsQ4mSZfSkOCqeWWe5ZCk=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=sr8H18pgEUUKxCqaG26uFEuY2JGWb79mSGD+R4kE2uDt9ZRW1Pes+2Vr2bMO8fhe/3pFhOa5SvJgDedXkMwf+95JDlfPtN8eqk4YrMq06XI6SdpQkJ5U1BsEUvAriO4aO5mZMEB6rgKa/I7MrU91FKhSJeGMG9GCrAqjUpUIX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=cOljTaim; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+rZ9b9aXKSscZH+WNcQx7ugyPjUJh5b5Cu9YKRr/YOw=; b=cOljTaimvUQd2N1eJnlon61J65
	6HHxWmOazhgiIvq7XzQA88GGlBI4WLouMJJlwCqi5MEkpg/7hsuRM4Ukjm0hniO5bo2LvofvMQ1r3
	KNWtjmClxQcTv71LJVAntMc/w+lDqMog7xF4tYj5cXk6GkYnR8BtaNbBX50i3nbE2ivzX5k4KbQCX
	bjLKkZap94vblLpnCUy+PXzHKnI/7cVtMW3E6vRamDRJ5IE93yaL63TjwIcTHzngbFoFE7mcjcbnz
	yY/DpIMnPeuf0t6B/LhhscYCaK4LeiWr5UBB6sFQEi8ict0BlR5VH/y28ICuEu3txdgv/tw8bppCG
	Ib9ii07g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttOmc-006p9C-1P;
	Sat, 15 Mar 2025 18:30:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 18:30:22 +0800
Date: Sat, 15 Mar 2025 18:30:22 +0800
Message-Id: <c46a8e194b3da78a594a0d22eac786f45946108c.1742034499.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1742034499.git.herbert@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 02/14] crypto: scomp - Remove support for some non-trivial
 SG lists
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

As the only user of acomp/scomp uses a trivial single-page SG
list, remove support for everything else in preprataion for the
addition of virtual address support.

However, keep support for non-trivial source SG lists as that
user is currently jumping through hoops in order to linearise
the source data.

Limit the source SG linearisation buffer to a single page as
that user never goes over that.  The only other potential user
is also unlikely to exceed that (IPComp) and it can easily do
its own linearisation if necessary.

Also keep the destination SG linearisation for IPComp.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/acompress.c                  |   1 -
 crypto/scompress.c                  | 127 ++++++++++++++++------------
 include/crypto/acompress.h          |  17 +---
 include/crypto/internal/scompress.h |   2 -
 4 files changed, 76 insertions(+), 71 deletions(-)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index 45444e99a9db..194a4b36f97f 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -73,7 +73,6 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 
 	acomp->compress = alg->compress;
 	acomp->decompress = alg->decompress;
-	acomp->dst_free = alg->dst_free;
 	acomp->reqsize = alg->reqsize;
 
 	if (alg->exit)
diff --git a/crypto/scompress.c b/crypto/scompress.c
index a2ce481a10bb..4441c40f541f 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -12,8 +12,10 @@
 #include <crypto/scatterwalk.h>
 #include <linux/cryptouser.h>
 #include <linux/err.h>
+#include <linux/highmem.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/scatterlist.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -23,9 +25,14 @@
 
 #include "compress.h"
 
+#define SCOMP_SCRATCH_SIZE 65400
+
 struct scomp_scratch {
 	spinlock_t	lock;
-	void		*src;
+	union {
+		void	*src;
+		unsigned long saddr;
+	};
 	void		*dst;
 };
 
@@ -66,7 +73,7 @@ static void crypto_scomp_free_scratches(void)
 	for_each_possible_cpu(i) {
 		scratch = per_cpu_ptr(&scomp_scratch, i);
 
-		vfree(scratch->src);
+		free_page(scratch->saddr);
 		vfree(scratch->dst);
 		scratch->src = NULL;
 		scratch->dst = NULL;
@@ -79,14 +86,15 @@ static int crypto_scomp_alloc_scratches(void)
 	int i;
 
 	for_each_possible_cpu(i) {
+		struct page *page;
 		void *mem;
 
 		scratch = per_cpu_ptr(&scomp_scratch, i);
 
-		mem = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
-		if (!mem)
+		page = alloc_pages_node(cpu_to_node(i), GFP_KERNEL, 0);
+		if (!page)
 			goto error;
-		scratch->src = mem;
+		scratch->src = page_address(page);
 		mem = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
 		if (!mem)
 			goto error;
@@ -161,76 +169,88 @@ static int crypto_scomp_init_tfm(struct crypto_tfm *tfm)
 
 static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 {
+	struct scomp_scratch *scratch = raw_cpu_ptr(&scomp_scratch);
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
-	void **tfm_ctx = acomp_tfm_ctx(tfm);
+	struct crypto_scomp **tfm_ctx = acomp_tfm_ctx(tfm);
 	struct crypto_scomp *scomp = *tfm_ctx;
 	struct crypto_acomp_stream *stream;
-	struct scomp_scratch *scratch;
+	unsigned int slen = req->slen;
+	unsigned int dlen = req->dlen;
+	struct page *spage, *dpage;
+	unsigned int soff, doff;
 	void *src, *dst;
-	unsigned int dlen;
+	unsigned int n;
 	int ret;
 
-	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
+	if (!req->src || !slen)
 		return -EINVAL;
 
-	if (req->dst && !req->dlen)
+	if (!req->dst || !dlen)
 		return -EINVAL;
 
-	if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
-		req->dlen = SCOMP_SCRATCH_SIZE;
+	soff = req->src->offset;
+	spage = nth_page(sg_page(req->src), soff / PAGE_SIZE);
+	soff = offset_in_page(soff);
 
-	dlen = req->dlen;
-
-	scratch = raw_cpu_ptr(&scomp_scratch);
-	spin_lock_bh(&scratch->lock);
-
-	if (sg_nents(req->src) == 1 && !PageHighMem(sg_page(req->src))) {
-		src = page_to_virt(sg_page(req->src)) + req->src->offset;
-	} else {
-		scatterwalk_map_and_copy(scratch->src, req->src, 0,
-					 req->slen, 0);
+	n = slen / PAGE_SIZE;
+	n += (offset_in_page(slen) + soff - 1) / PAGE_SIZE;
+	if (slen <= req->src->length && (!PageHighMem(nth_page(spage, n)) ||
+					 size_add(soff, slen) <= PAGE_SIZE))
+		src = kmap_local_page(spage) + soff;
+	else
 		src = scratch->src;
+
+	doff = req->dst->offset;
+	dpage = nth_page(sg_page(req->dst), doff / PAGE_SIZE);
+	doff = offset_in_page(doff);
+
+	n = dlen / PAGE_SIZE;
+	n += (offset_in_page(dlen) + doff - 1) / PAGE_SIZE;
+	if (dlen <= req->dst->length && (!PageHighMem(nth_page(dpage, n)) ||
+					 size_add(doff, dlen) <= PAGE_SIZE))
+		dst = kmap_local_page(dpage) + doff;
+	else {
+		if (dlen > SCOMP_SCRATCH_SIZE)
+			dlen = SCOMP_SCRATCH_SIZE;
+		dst = scratch->dst;
 	}
 
-	if (req->dst && sg_nents(req->dst) == 1 && !PageHighMem(sg_page(req->dst)))
-		dst = page_to_virt(sg_page(req->dst)) + req->dst->offset;
-	else
-		dst = scratch->dst;
+	spin_lock_bh(&scratch->lock);
+
+	if (src == scratch->src)
+		memcpy_from_sglist(src, req->src, 0, slen);
 
 	stream = raw_cpu_ptr(crypto_scomp_alg(scomp)->stream);
 	spin_lock(&stream->lock);
 	if (dir)
-		ret = crypto_scomp_compress(scomp, src, req->slen,
-					    dst, &req->dlen, stream->ctx);
+		ret = crypto_scomp_compress(scomp, src, slen,
+					    dst, &dlen, stream->ctx);
 	else
-		ret = crypto_scomp_decompress(scomp, src, req->slen,
-					      dst, &req->dlen, stream->ctx);
-	spin_unlock(&stream->lock);
-	if (!ret) {
-		if (!req->dst) {
-			req->dst = sgl_alloc(req->dlen, GFP_ATOMIC, NULL);
-			if (!req->dst) {
-				ret = -ENOMEM;
-				goto out;
-			}
-		} else if (req->dlen > dlen) {
-			ret = -ENOSPC;
-			goto out;
-		}
-		if (dst == scratch->dst) {
-			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
-						 req->dlen, 1);
-		} else {
-			int nr_pages = DIV_ROUND_UP(req->dst->offset + req->dlen, PAGE_SIZE);
-			int i;
-			struct page *dst_page = sg_page(req->dst);
+		ret = crypto_scomp_decompress(scomp, src, slen,
+					      dst, &dlen, stream->ctx);
 
-			for (i = 0; i < nr_pages; i++)
-				flush_dcache_page(dst_page + i);
+	if (dst == scratch->dst)
+		memcpy_to_sglist(req->dst, 0, dst, dlen);
+
+	spin_unlock(&stream->lock);
+	spin_unlock_bh(&scratch->lock);
+
+	req->dlen = dlen;
+
+	if (dst != scratch->dst) {
+		kunmap_local(dst);
+		dlen += doff;
+		for (;;) {
+			flush_dcache_page(dpage);
+			if (dlen <= PAGE_SIZE)
+				break;
+			dlen -= PAGE_SIZE;
+			dpage = nth_page(dpage, 1);
 		}
 	}
-out:
-	spin_unlock_bh(&scratch->lock);
+	if (src != scratch->src)
+		kunmap_local(src);
+
 	return ret;
 }
 
@@ -277,7 +297,6 @@ int crypto_init_scomp_ops_async(struct crypto_tfm *tfm)
 
 	crt->compress = scomp_acomp_compress;
 	crt->decompress = scomp_acomp_decompress;
-	crt->dst_free = sgl_free;
 
 	return 0;
 }
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index c4d8a29274c6..53c9e632862b 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -18,8 +18,6 @@
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
 
-#define CRYPTO_ACOMP_ALLOC_OUTPUT	0x00000001
-
 /* Set this bit if source is virtual address instead of SG list. */
 #define CRYPTO_ACOMP_REQ_SRC_VIRT	0x00000002
 
@@ -84,15 +82,12 @@ struct acomp_req {
  *
  * @compress:		Function performs a compress operation
  * @decompress:		Function performs a de-compress operation
- * @dst_free:		Frees destination buffer if allocated inside the
- *			algorithm
  * @reqsize:		Context size for (de)compression requests
  * @base:		Common crypto API algorithm data structure
  */
 struct crypto_acomp {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
-	void (*dst_free)(struct scatterlist *dst);
 	unsigned int reqsize;
 	struct crypto_tfm base;
 };
@@ -261,9 +256,8 @@ static inline void acomp_request_set_callback(struct acomp_req *req,
 					      crypto_completion_t cmpl,
 					      void *data)
 {
-	u32 keep = CRYPTO_ACOMP_ALLOC_OUTPUT | CRYPTO_ACOMP_REQ_SRC_VIRT |
-		   CRYPTO_ACOMP_REQ_SRC_NONDMA | CRYPTO_ACOMP_REQ_DST_VIRT |
-		   CRYPTO_ACOMP_REQ_DST_NONDMA;
+	u32 keep = CRYPTO_ACOMP_REQ_SRC_VIRT | CRYPTO_ACOMP_REQ_SRC_NONDMA |
+		   CRYPTO_ACOMP_REQ_DST_VIRT | CRYPTO_ACOMP_REQ_DST_NONDMA;
 
 	req->base.complete = cmpl;
 	req->base.data = data;
@@ -297,13 +291,10 @@ static inline void acomp_request_set_params(struct acomp_req *req,
 	req->slen = slen;
 	req->dlen = dlen;
 
-	req->base.flags &= ~(CRYPTO_ACOMP_ALLOC_OUTPUT |
-			     CRYPTO_ACOMP_REQ_SRC_VIRT |
+	req->base.flags &= ~(CRYPTO_ACOMP_REQ_SRC_VIRT |
 			     CRYPTO_ACOMP_REQ_SRC_NONDMA |
 			     CRYPTO_ACOMP_REQ_DST_VIRT |
 			     CRYPTO_ACOMP_REQ_DST_NONDMA);
-	if (!req->dst)
-		req->base.flags |= CRYPTO_ACOMP_ALLOC_OUTPUT;
 }
 
 /**
@@ -403,7 +394,6 @@ static inline void acomp_request_set_dst_dma(struct acomp_req *req,
 	req->dvirt = dst;
 	req->dlen = dlen;
 
-	req->base.flags &= ~CRYPTO_ACOMP_ALLOC_OUTPUT;
 	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_NONDMA;
 	req->base.flags |= CRYPTO_ACOMP_REQ_DST_VIRT;
 }
@@ -424,7 +414,6 @@ static inline void acomp_request_set_dst_nondma(struct acomp_req *req,
 	req->dvirt = dst;
 	req->dlen = dlen;
 
-	req->base.flags &= ~CRYPTO_ACOMP_ALLOC_OUTPUT;
 	req->base.flags |= CRYPTO_ACOMP_REQ_DST_NONDMA;
 	req->base.flags |= CRYPTO_ACOMP_REQ_DST_VIRT;
 }
diff --git a/include/crypto/internal/scompress.h b/include/crypto/internal/scompress.h
index 88986ab8ce15..f25aa2ea3b48 100644
--- a/include/crypto/internal/scompress.h
+++ b/include/crypto/internal/scompress.h
@@ -12,8 +12,6 @@
 #include <crypto/acompress.h>
 #include <crypto/algapi.h>
 
-#define SCOMP_SCRATCH_SIZE	131072
-
 struct acomp_req;
 
 struct crypto_scomp {
-- 
2.39.5


