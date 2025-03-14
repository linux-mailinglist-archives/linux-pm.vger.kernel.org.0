Return-Path: <linux-pm+bounces-24036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F5BA610CC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D41880824
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A51FF1AF;
	Fri, 14 Mar 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="nbVSDLsN"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B51FECD9;
	Fri, 14 Mar 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954974; cv=none; b=bT2u0hoJc8e4TgdNic413wmyPVGWVOo48RzITQ6KRkT4Jk7uPBTXFaoFjQg0DlqYXI2DrVdzgY1VudnGxUQqpj++nC13R9Y8YPjficTYEhelM1T2sd4u/KNclOmkmL9YfBOQ6KtfkqBZ1FfFLTGBJDNfyvLoK2/crkwf5QBgEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954974; c=relaxed/simple;
	bh=33TF7qV3MJNup+WUJRFG6X8MWWHfFANR2Z4zq3ZTZls=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=jWpfjOPhZGA1l2oWZ4O/XLrG8ULOmRtUYp2UviJeDl13nuni/0JHcLNrGwY++PqojkVC49dHMvc2bx9rd/iveWBo683K4rGJG1AvtM4P5beKRBLmgUPuj2TcfL7BXt9zh32Qdpwc1GGLuY6XnSOH3C2+f8BsWYtfJNtdQMNtuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=nbVSDLsN; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c5J7R93VbWY8eXPMwB3c29c2QRrhSxoIY0/VZKY8uW4=; b=nbVSDLsNXS3k9izGeAltD7taRP
	p+W5TwgAxmMMug3atin5rPRLU+oP/KJYIGab4C36TQaLtmGLCbXEeNoZOl2P/hSJWwpFAyJVankWd
	VZ4F11hcl5MgKBZ4kPqOhJ4fVBcmqdsGjxiSv3ISZh/j61UzVY+aYaooMsWd6yynL06C5wttYPafI
	L5baQZ3hMpVPSrQyn/bNThT6Lu1eka0ZH8yyndjgqXJuTKuwESLIBEi/SSWO0qzhfKaAQRh/636BX
	N27nqvJaHYDmUNHab6OQbxxJXGHC8wbJLhdAoNKo4VXSQOPpd4Bu00ajtnCkgNi7tfcS59TnDZBfF
	APCsup4g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43Y-006Zm6-2D;
	Fri, 14 Mar 2025 20:22:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:28 +0800
Date: Fri, 14 Mar 2025 20:22:28 +0800
Message-Id: <11128811057de7bb7e8d9ce9fe56bf9ee64ad143.1741954320.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741954320.git.herbert@gondor.apana.org.au>
References: <cover.1741954320.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 03/13] crypto: iaa - Remove dst_null support
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Remove the unused dst_null support.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 136 +--------------------
 1 file changed, 6 insertions(+), 130 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 990ea46955bb..50cb100bf1c8 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1136,8 +1136,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			struct idxd_wq *wq,
 			dma_addr_t src_addr, unsigned int slen,
 			dma_addr_t dst_addr, unsigned int *dlen,
-			u32 *compression_crc,
-			bool disable_async)
+			u32 *compression_crc)
 {
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -1180,7 +1179,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	desc->src2_size = sizeof(struct aecs_comp_table_record);
 	desc->completion_addr = idxd_desc->compl_dma;
 
-	if (ctx->use_irq && !disable_async) {
+	if (ctx->use_irq) {
 		desc->flags |= IDXD_OP_FLAG_RCI;
 
 		idxd_desc->crypto.req = req;
@@ -1193,7 +1192,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			" src_addr %llx, dst_addr %llx\n", __func__,
 			active_compression_mode->name,
 			src_addr, dst_addr);
-	} else if (ctx->async_mode && !disable_async)
+	} else if (ctx->async_mode)
 		req->base.data = idxd_desc;
 
 	dev_dbg(dev, "%s: compression mode %s,"
@@ -1214,7 +1213,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	update_total_comp_calls();
 	update_wq_comp_calls(wq);
 
-	if (ctx->async_mode && !disable_async) {
+	if (ctx->async_mode) {
 		ret = -EINPROGRESS;
 		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
 		goto out;
@@ -1234,7 +1233,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	if (!ctx->async_mode || disable_async)
+	if (!ctx->async_mode)
 		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
@@ -1500,13 +1499,11 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	struct iaa_compression_ctx *compression_ctx;
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
-	bool disable_async = false;
 	int nr_sgs, cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	u32 compression_crc;
 	struct idxd_wq *wq;
 	struct device *dev;
-	int order = -1;
 
 	compression_ctx = crypto_tfm_ctx(tfm);
 
@@ -1536,21 +1533,6 @@ static int iaa_comp_acompress(struct acomp_req *req)
 
 	iaa_wq = idxd_wq_get_private(wq);
 
-	if (!req->dst) {
-		gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
-
-		/* incompressible data will always be < 2 * slen */
-		req->dlen = 2 * req->slen;
-		order = order_base_2(round_up(req->dlen, PAGE_SIZE) / PAGE_SIZE);
-		req->dst = sgl_alloc_order(req->dlen, order, false, flags, NULL);
-		if (!req->dst) {
-			ret = -ENOMEM;
-			order = -1;
-			goto out;
-		}
-		disable_async = true;
-	}
-
 	dev = &wq->idxd->pdev->dev;
 
 	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
@@ -1580,7 +1562,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
 	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
-			   &req->dlen, &compression_crc, disable_async);
+			   &req->dlen, &compression_crc);
 	if (ret == -EINPROGRESS)
 		return ret;
 
@@ -1611,100 +1593,6 @@ static int iaa_comp_acompress(struct acomp_req *req)
 out:
 	iaa_wq_put(wq);
 
-	if (order >= 0)
-		sgl_free_order(req->dst, order);
-
-	return ret;
-}
-
-static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
-{
-	gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
-		GFP_KERNEL : GFP_ATOMIC;
-	struct crypto_tfm *tfm = req->base.tfm;
-	dma_addr_t src_addr, dst_addr;
-	int nr_sgs, cpu, ret = 0;
-	struct iaa_wq *iaa_wq;
-	struct device *dev;
-	struct idxd_wq *wq;
-	int order = -1;
-
-	cpu = get_cpu();
-	wq = wq_table_next_wq(cpu);
-	put_cpu();
-	if (!wq) {
-		pr_debug("no wq configured for cpu=%d\n", cpu);
-		return -ENODEV;
-	}
-
-	ret = iaa_wq_get(wq);
-	if (ret) {
-		pr_debug("no wq available for cpu=%d\n", cpu);
-		return -ENODEV;
-	}
-
-	iaa_wq = idxd_wq_get_private(wq);
-
-	dev = &wq->idxd->pdev->dev;
-
-	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto out;
-	}
-	src_addr = sg_dma_address(req->src);
-	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
-		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
-		req->src, req->slen, sg_dma_len(req->src));
-
-	req->dlen = 4 * req->slen; /* start with ~avg comp rato */
-alloc_dest:
-	order = order_base_2(round_up(req->dlen, PAGE_SIZE) / PAGE_SIZE);
-	req->dst = sgl_alloc_order(req->dlen, order, false, flags, NULL);
-	if (!req->dst) {
-		ret = -ENOMEM;
-		order = -1;
-		goto out;
-	}
-
-	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto err_map_dst;
-	}
-
-	dst_addr = sg_dma_address(req->dst);
-	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
-		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
-		req->dst, req->dlen, sg_dma_len(req->dst));
-	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
-			     dst_addr, &req->dlen, true);
-	if (ret == -EOVERFLOW) {
-		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-		req->dlen *= 2;
-		if (req->dlen > CRYPTO_ACOMP_DST_MAX)
-			goto err_map_dst;
-		goto alloc_dest;
-	}
-
-	if (ret != 0)
-		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
-
-	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-err_map_dst:
-	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-out:
-	iaa_wq_put(wq);
-
-	if (order >= 0)
-		sgl_free_order(req->dst, order);
-
 	return ret;
 }
 
@@ -1727,9 +1615,6 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		return -EINVAL;
 	}
 
-	if (!req->dst)
-		return iaa_comp_adecompress_alloc_dest(req);
-
 	cpu = get_cpu();
 	wq = wq_table_next_wq(cpu);
 	put_cpu();
@@ -1810,19 +1695,10 @@ static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
 	return 0;
 }
 
-static void dst_free(struct scatterlist *sgl)
-{
-	/*
-	 * Called for req->dst = NULL cases but we free elsewhere
-	 * using sgl_free_order().
-	 */
-}
-
 static struct acomp_alg iaa_acomp_fixed_deflate = {
 	.init			= iaa_comp_init_fixed,
 	.compress		= iaa_comp_acompress,
 	.decompress		= iaa_comp_adecompress,
-	.dst_free               = dst_free,
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "deflate-iaa",
-- 
2.39.5


