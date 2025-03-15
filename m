Return-Path: <linux-pm+bounces-24107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A58A62B05
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 11:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C47189E878
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0C1FAC45;
	Sat, 15 Mar 2025 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Lz26nHkY"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B81F866B;
	Sat, 15 Mar 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034652; cv=none; b=MqFRhb87IwtTlGsszPCfrWc4MyT2ZK9r/CsqKOHBRtFDxoIIj9Iak8iWNRjKgiFbtdCZQaNigyWZc9NCwB4EFje7tQ/eQFQgWfEMZtAI/6959VFpo531XOnOHu0yxMVazqcCKZ/qR9xDwt6/fFWCHZW+f3OYPaQyFLOThOWL7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034652; c=relaxed/simple;
	bh=xAQ0BTMgK7AQGFf36tAnZ7Vq30HXZFNQx9+vON+gJ/4=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=MJXo7drW/k4RI9+KvpsphaMzNc6g0fKsRFaV5jXkkz+HRxEkR+yzdJsMOezlJzZwVdJmwh3LZhbNov8cByC8tkisYlWDm85SZWWTVmMRIStNtOhzZeeMflOiPA1cmLjY32/sHl6RXCjxLhSzQvJXVdB/IMVo65ImhtGuORprD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Lz26nHkY; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TnJxSbbE+YJ2uAsOZ9Ozioiuc9CHKwZc8r1aAkL68hE=; b=Lz26nHkYWSsjtZ/Jdmxyq32JvL
	iDPP4x39Ch8Vdg3RebaJ+YFQxMNEtQurBq2qLb89VA+8MC1VYFpVla82UKj9OUk4kOF5vQxo5PTiJ
	RPiSgySohNCzLruTAVijd4CjjKxLLVtg90DaICMIBM+GaP4Plwh1wby2bSsednu+B2l+/NxkkEntV
	IJNSaTbPTGZ4ttku06pwqIRkdeKQ1S9qJ3iFmajfGbexPcfPr/rlhmkBM/I2v3TS/3SQI82AB5FU2
	FlK/9Mts9SThDUVW8oweLozBTGh8uEfEyQXvzK/tboZqJCWyeHKMjxhAOvC3AHlrZ3X856ZD/1FbI
	3VmO3eJw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttOml-006pAX-2N;
	Sat, 15 Mar 2025 18:30:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 18:30:31 +0800
Date: Sat, 15 Mar 2025 18:30:31 +0800
Message-Id: <859e561460411d2203d1f9da341472f9bc2f5686.1742034499.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1742034499.git.herbert@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 06/14] crypto: scomp - Add chaining and virtual address
 support
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add chaining and virtual address support to all scomp algorithms.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/scompress.c | 96 +++++++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 4441c40f541f..ba9b22ba53fe 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -178,8 +178,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	unsigned int dlen = req->dlen;
 	struct page *spage, *dpage;
 	unsigned int soff, doff;
-	void *src, *dst;
 	unsigned int n;
+	const u8 *src;
+	u8 *dst;
 	int ret;
 
 	if (!req->src || !slen)
@@ -188,37 +189,47 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	if (!req->dst || !dlen)
 		return -EINVAL;
 
-	soff = req->src->offset;
-	spage = nth_page(sg_page(req->src), soff / PAGE_SIZE);
-	soff = offset_in_page(soff);
-
-	n = slen / PAGE_SIZE;
-	n += (offset_in_page(slen) + soff - 1) / PAGE_SIZE;
-	if (slen <= req->src->length && (!PageHighMem(nth_page(spage, n)) ||
-					 size_add(soff, slen) <= PAGE_SIZE))
-		src = kmap_local_page(spage) + soff;
-	else
-		src = scratch->src;
-
-	doff = req->dst->offset;
-	dpage = nth_page(sg_page(req->dst), doff / PAGE_SIZE);
-	doff = offset_in_page(doff);
-
-	n = dlen / PAGE_SIZE;
-	n += (offset_in_page(dlen) + doff - 1) / PAGE_SIZE;
-	if (dlen <= req->dst->length && (!PageHighMem(nth_page(dpage, n)) ||
-					 size_add(doff, dlen) <= PAGE_SIZE))
-		dst = kmap_local_page(dpage) + doff;
+	if (acomp_request_src_isvirt(req))
+		src = req->svirt;
 	else {
-		if (dlen > SCOMP_SCRATCH_SIZE)
-			dlen = SCOMP_SCRATCH_SIZE;
-		dst = scratch->dst;
+		soff = req->src->offset;
+		spage = nth_page(sg_page(req->src), soff / PAGE_SIZE);
+		soff = offset_in_page(soff);
+
+		n = slen / PAGE_SIZE;
+		n += (offset_in_page(slen) + soff - 1) / PAGE_SIZE;
+		if (slen <= req->src->length &&
+		    (!PageHighMem(nth_page(spage, n)) ||
+		     size_add(soff, slen) <= PAGE_SIZE))
+			src = kmap_local_page(spage) + soff;
+		else
+			src = scratch->src;
+	}
+
+	if (acomp_request_dst_isvirt(req))
+		dst = req->dvirt;
+	else {
+		doff = req->dst->offset;
+		dpage = nth_page(sg_page(req->dst), doff / PAGE_SIZE);
+		doff = offset_in_page(doff);
+
+		n = dlen / PAGE_SIZE;
+		n += (offset_in_page(dlen) + doff - 1) / PAGE_SIZE;
+		if (dlen <= req->dst->length &&
+		    (!PageHighMem(nth_page(dpage, n)) ||
+		     size_add(doff, dlen) <= PAGE_SIZE))
+			dst = kmap_local_page(dpage) + doff;
+		else {
+			if (dlen > SCOMP_SCRATCH_SIZE)
+				dlen = SCOMP_SCRATCH_SIZE;
+			dst = scratch->dst;
+		}
 	}
 
 	spin_lock_bh(&scratch->lock);
 
 	if (src == scratch->src)
-		memcpy_from_sglist(src, req->src, 0, slen);
+		memcpy_from_sglist(scratch->src, req->src, 0, slen);
 
 	stream = raw_cpu_ptr(crypto_scomp_alg(scomp)->stream);
 	spin_lock(&stream->lock);
@@ -237,7 +248,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 
 	req->dlen = dlen;
 
-	if (dst != scratch->dst) {
+	if (!acomp_request_dst_isvirt(req) && dst != scratch->dst) {
 		kunmap_local(dst);
 		dlen += doff;
 		for (;;) {
@@ -248,20 +259,34 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 			dpage = nth_page(dpage, 1);
 		}
 	}
-	if (src != scratch->src)
+	if (!acomp_request_src_isvirt(req) && src != scratch->src)
 		kunmap_local(src);
 
 	return ret;
 }
 
+static int scomp_acomp_chain(struct acomp_req *req, int dir)
+{
+	struct acomp_req *r2;
+	int err;
+
+	err = scomp_acomp_comp_decomp(req, dir);
+	req->base.err = err;
+
+	list_for_each_entry(r2, &req->base.list, base.list)
+		r2->base.err = scomp_acomp_comp_decomp(r2, dir);
+
+	return err;
+}
+
 static int scomp_acomp_compress(struct acomp_req *req)
 {
-	return scomp_acomp_comp_decomp(req, 1);
+	return scomp_acomp_chain(req, 1);
 }
 
 static int scomp_acomp_decompress(struct acomp_req *req)
 {
-	return scomp_acomp_comp_decomp(req, 0);
+	return scomp_acomp_chain(req, 0);
 }
 
 static void crypto_exit_scomp_ops_async(struct crypto_tfm *tfm)
@@ -322,12 +347,21 @@ static const struct crypto_type crypto_scomp_type = {
 	.tfmsize = offsetof(struct crypto_scomp, base),
 };
 
-int crypto_register_scomp(struct scomp_alg *alg)
+static void scomp_prepare_alg(struct scomp_alg *alg)
 {
 	struct crypto_alg *base = &alg->calg.base;
 
 	comp_prepare_alg(&alg->calg);
 
+	base->cra_flags |= CRYPTO_ALG_REQ_CHAIN;
+}
+
+int crypto_register_scomp(struct scomp_alg *alg)
+{
+	struct crypto_alg *base = &alg->calg.base;
+
+	scomp_prepare_alg(alg);
+
 	base->cra_type = &crypto_scomp_type;
 	base->cra_flags |= CRYPTO_ALG_TYPE_SCOMPRESS;
 
-- 
2.39.5


