Return-Path: <linux-pm+bounces-24106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F2A62B00
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 11:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D0C189F128
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6D1FBC98;
	Sat, 15 Mar 2025 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Sx/gaa19"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9471F8BDC;
	Sat, 15 Mar 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034648; cv=none; b=S9xOGYm2YFSeqMuDg5bKoFBAMWseBVl6+m5BBwVo5j2KIgqbVwQSmxm/Cr6U3k7kivXvKXjAPcbA2mZ8m4VF8vKoKkxNUSu99QkMpvW671qL3bl5vg02CQDEpTDktb1tA/DvkClJLHuwRfIDJqtz29zRiGIq9YeJHNi6YuOHS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034648; c=relaxed/simple;
	bh=UXjRIjF5D3jQl+oTD6XlHoU1bXUKrShNzAVBvlJh95Q=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=Y9FuHJx/ygcEVOgSGn0zOjpIyTcmBd5pmCKCEYLhf1KdBRf4oIjIT1rD6KGfKq+pIpxwn+ZoogBks2xNFAfiBShx85qu7sqoUB0BIAbYDy7UXVJ3bY1KoFuU/0/2S8zoxwmTGHT4uts4N4bqcDEVwPwiQVHAUQcmMBygzYxJ4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Sx/gaa19; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z4xkzlMtK/6yjn5/EQXtBq0om0TwKNc46SpKkDh7GOM=; b=Sx/gaa19wPReME6iTnQ5xJzsi7
	L2Rms6o4jKi4rVGXSUjqzzv3522o8T2CJ+Za9re362i7Zv9g/EXHHghw5d4WQGogUnzHmJqh73Hoz
	1s3OCaStL9GkNMY/bTjQnFMw4IuvtDHaSiabtL+jKbwdz4iBkyDgmUr+xAnRoHBTsAnohGtYMpyeo
	IPGNDhAEY47EUEAmGsyRlJsBBIlCj9V/kH2DSspxKbk9+Ako2RwyApfngMmzTS67SCee2Y3mOd3ab
	zBKdWE8KWV4W+6hupIfiFBiPlvsouFdD1EtMW52xTw3PKCGnqAQFJI2Y0Ly9xauj8+45gvTcNlk+B
	sE74U/VA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttOmh-006pA2-0a;
	Sat, 15 Mar 2025 18:30:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 18:30:27 +0800
Date: Sat, 15 Mar 2025 18:30:27 +0800
Message-Id: <bdca061fb5739a817889e0a2abfc1907ed7219f4.1742034499.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1742034499.git.herbert@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 04/14] crypto: qat - Remove dst_null support
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
 drivers/crypto/intel/qat/qat_common/qat_bl.c  | 159 ------------------
 drivers/crypto/intel/qat/qat_common/qat_bl.h  |   6 -
 .../intel/qat/qat_common/qat_comp_algs.c      |  85 +---------
 .../intel/qat/qat_common/qat_comp_req.h       |  10 --
 4 files changed, 1 insertion(+), 259 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_bl.c b/drivers/crypto/intel/qat/qat_common/qat_bl.c
index 338acf29c487..5e4dad4693ca 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_bl.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_bl.c
@@ -251,162 +251,3 @@ int qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 				    extra_dst_buff, sz_extra_dst_buff,
 				    sskip, dskip, flags);
 }
-
-static void qat_bl_sgl_unmap(struct adf_accel_dev *accel_dev,
-			     struct qat_alg_buf_list *bl)
-{
-	struct device *dev = &GET_DEV(accel_dev);
-	int n = bl->num_bufs;
-	int i;
-
-	for (i = 0; i < n; i++)
-		if (!dma_mapping_error(dev, bl->buffers[i].addr))
-			dma_unmap_single(dev, bl->buffers[i].addr,
-					 bl->buffers[i].len, DMA_FROM_DEVICE);
-}
-
-static int qat_bl_sgl_map(struct adf_accel_dev *accel_dev,
-			  struct scatterlist *sgl,
-			  struct qat_alg_buf_list **bl)
-{
-	struct device *dev = &GET_DEV(accel_dev);
-	struct qat_alg_buf_list *bufl;
-	int node = dev_to_node(dev);
-	struct scatterlist *sg;
-	int n, i, sg_nctr;
-	size_t sz;
-
-	n = sg_nents(sgl);
-	sz = struct_size(bufl, buffers, n);
-	bufl = kzalloc_node(sz, GFP_KERNEL, node);
-	if (unlikely(!bufl))
-		return -ENOMEM;
-
-	for (i = 0; i < n; i++)
-		bufl->buffers[i].addr = DMA_MAPPING_ERROR;
-
-	sg_nctr = 0;
-	for_each_sg(sgl, sg, n, i) {
-		int y = sg_nctr;
-
-		if (!sg->length)
-			continue;
-
-		bufl->buffers[y].addr = dma_map_single(dev, sg_virt(sg),
-						       sg->length,
-						       DMA_FROM_DEVICE);
-		bufl->buffers[y].len = sg->length;
-		if (unlikely(dma_mapping_error(dev, bufl->buffers[y].addr)))
-			goto err_map;
-		sg_nctr++;
-	}
-	bufl->num_bufs = sg_nctr;
-	bufl->num_mapped_bufs = sg_nctr;
-
-	*bl = bufl;
-
-	return 0;
-
-err_map:
-	for (i = 0; i < n; i++)
-		if (!dma_mapping_error(dev, bufl->buffers[i].addr))
-			dma_unmap_single(dev, bufl->buffers[i].addr,
-					 bufl->buffers[i].len,
-					 DMA_FROM_DEVICE);
-	kfree(bufl);
-	*bl = NULL;
-
-	return -ENOMEM;
-}
-
-static void qat_bl_sgl_free_unmap(struct adf_accel_dev *accel_dev,
-				  struct scatterlist *sgl,
-				  struct qat_alg_buf_list *bl,
-				  bool free_bl)
-{
-	if (bl) {
-		qat_bl_sgl_unmap(accel_dev, bl);
-
-		if (free_bl)
-			kfree(bl);
-	}
-	if (sgl)
-		sgl_free(sgl);
-}
-
-static int qat_bl_sgl_alloc_map(struct adf_accel_dev *accel_dev,
-				struct scatterlist **sgl,
-				struct qat_alg_buf_list **bl,
-				unsigned int dlen,
-				gfp_t gfp)
-{
-	struct scatterlist *dst;
-	int ret;
-
-	dst = sgl_alloc(dlen, gfp, NULL);
-	if (!dst) {
-		dev_err(&GET_DEV(accel_dev), "sg_alloc failed\n");
-		return -ENOMEM;
-	}
-
-	ret = qat_bl_sgl_map(accel_dev, dst, bl);
-	if (ret)
-		goto err;
-
-	*sgl = dst;
-
-	return 0;
-
-err:
-	sgl_free(dst);
-	*sgl = NULL;
-	return ret;
-}
-
-int qat_bl_realloc_map_new_dst(struct adf_accel_dev *accel_dev,
-			       struct scatterlist **sg,
-			       unsigned int dlen,
-			       struct qat_request_buffs *qat_bufs,
-			       gfp_t gfp)
-{
-	struct device *dev = &GET_DEV(accel_dev);
-	dma_addr_t new_blp = DMA_MAPPING_ERROR;
-	struct qat_alg_buf_list *new_bl;
-	struct scatterlist *new_sg;
-	size_t new_bl_size;
-	int ret;
-
-	ret = qat_bl_sgl_alloc_map(accel_dev, &new_sg, &new_bl, dlen, gfp);
-	if (ret)
-		return ret;
-
-	new_bl_size = struct_size(new_bl, buffers, new_bl->num_bufs);
-
-	/* Map new firmware SGL descriptor */
-	new_blp = dma_map_single(dev, new_bl, new_bl_size, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev, new_blp)))
-		goto err;
-
-	/* Unmap old firmware SGL descriptor */
-	dma_unmap_single(dev, qat_bufs->bloutp, qat_bufs->sz_out, DMA_TO_DEVICE);
-
-	/* Free and unmap old scatterlist */
-	qat_bl_sgl_free_unmap(accel_dev, *sg, qat_bufs->blout,
-			      !qat_bufs->sgl_dst_valid);
-
-	qat_bufs->sgl_dst_valid = false;
-	qat_bufs->blout = new_bl;
-	qat_bufs->bloutp = new_blp;
-	qat_bufs->sz_out = new_bl_size;
-
-	*sg = new_sg;
-
-	return 0;
-err:
-	qat_bl_sgl_free_unmap(accel_dev, new_sg, new_bl, true);
-
-	if (!dma_mapping_error(dev, new_blp))
-		dma_unmap_single(dev, new_blp, new_bl_size, DMA_TO_DEVICE);
-
-	return -ENOMEM;
-}
diff --git a/drivers/crypto/intel/qat/qat_common/qat_bl.h b/drivers/crypto/intel/qat/qat_common/qat_bl.h
index 3f5b79015400..2827d5055d3c 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_bl.h
+++ b/drivers/crypto/intel/qat/qat_common/qat_bl.h
@@ -65,10 +65,4 @@ static inline gfp_t qat_algs_alloc_flags(struct crypto_async_request *req)
 	return req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
 }
 
-int qat_bl_realloc_map_new_dst(struct adf_accel_dev *accel_dev,
-			       struct scatterlist **newd,
-			       unsigned int dlen,
-			       struct qat_request_buffs *qat_bufs,
-			       gfp_t gfp);
-
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index 2ba4aa22e092..a6e02405d402 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -29,11 +29,6 @@ struct qat_compression_ctx {
 	int (*qat_comp_callback)(struct qat_compression_req *qat_req, void *resp);
 };
 
-struct qat_dst {
-	bool is_null;
-	int resubmitted;
-};
-
 struct qat_compression_req {
 	u8 req[QAT_COMP_REQ_SIZE];
 	struct qat_compression_ctx *qat_compression_ctx;
@@ -42,8 +37,6 @@ struct qat_compression_req {
 	enum direction dir;
 	int actual_dlen;
 	struct qat_alg_req alg_req;
-	struct work_struct resubmit;
-	struct qat_dst dst;
 };
 
 static int qat_alg_send_dc_message(struct qat_compression_req *qat_req,
@@ -60,46 +53,6 @@ static int qat_alg_send_dc_message(struct qat_compression_req *qat_req,
 	return qat_alg_send_message(alg_req);
 }
 
-static void qat_comp_resubmit(struct work_struct *work)
-{
-	struct qat_compression_req *qat_req =
-		container_of(work, struct qat_compression_req, resubmit);
-	struct qat_compression_ctx *ctx = qat_req->qat_compression_ctx;
-	struct adf_accel_dev *accel_dev = ctx->inst->accel_dev;
-	struct qat_request_buffs *qat_bufs = &qat_req->buf;
-	struct qat_compression_instance *inst = ctx->inst;
-	struct acomp_req *areq = qat_req->acompress_req;
-	struct crypto_acomp *tfm = crypto_acomp_reqtfm(areq);
-	unsigned int dlen = CRYPTO_ACOMP_DST_MAX;
-	u8 *req = qat_req->req;
-	dma_addr_t dfbuf;
-	int ret;
-
-	areq->dlen = dlen;
-
-	dev_dbg(&GET_DEV(accel_dev), "[%s][%s] retry NULL dst request - dlen = %d\n",
-		crypto_tfm_alg_driver_name(crypto_acomp_tfm(tfm)),
-		qat_req->dir == COMPRESSION ? "comp" : "decomp", dlen);
-
-	ret = qat_bl_realloc_map_new_dst(accel_dev, &areq->dst, dlen, qat_bufs,
-					 qat_algs_alloc_flags(&areq->base));
-	if (ret)
-		goto err;
-
-	qat_req->dst.resubmitted = true;
-
-	dfbuf = qat_req->buf.bloutp;
-	qat_comp_override_dst(req, dfbuf, dlen);
-
-	ret = qat_alg_send_dc_message(qat_req, inst, &areq->base);
-	if (ret != -ENOSPC)
-		return;
-
-err:
-	qat_bl_free_bufl(accel_dev, qat_bufs);
-	acomp_request_complete(areq, ret);
-}
-
 static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 				      void *resp)
 {
@@ -131,21 +84,6 @@ static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 
 	areq->dlen = 0;
 
-	if (qat_req->dir == DECOMPRESSION && qat_req->dst.is_null) {
-		if (cmp_err == ERR_CODE_OVERFLOW_ERROR) {
-			if (qat_req->dst.resubmitted) {
-				dev_dbg(&GET_DEV(accel_dev),
-					"Output does not fit destination buffer\n");
-				res = -EOVERFLOW;
-				goto end;
-			}
-
-			INIT_WORK(&qat_req->resubmit, qat_comp_resubmit);
-			adf_misc_wq_queue_work(&qat_req->resubmit);
-			return;
-		}
-	}
-
 	if (unlikely(status != ICP_QAT_FW_COMN_STATUS_FLAG_OK))
 		goto end;
 
@@ -245,29 +183,9 @@ static int qat_comp_alg_compress_decompress(struct acomp_req *areq, enum directi
 	if (!areq->src || !slen)
 		return -EINVAL;
 
-	if (areq->dst && !dlen)
+	if (!areq->dst || !dlen)
 		return -EINVAL;
 
-	qat_req->dst.is_null = false;
-
-	/* Handle acomp requests that require the allocation of a destination
-	 * buffer. The size of the destination buffer is double the source
-	 * buffer (rounded up to the size of a page) to fit the decompressed
-	 * output or an expansion on the data for compression.
-	 */
-	if (!areq->dst) {
-		qat_req->dst.is_null = true;
-
-		dlen = round_up(2 * slen, PAGE_SIZE);
-		areq->dst = sgl_alloc(dlen, f, NULL);
-		if (!areq->dst)
-			return -ENOMEM;
-
-		dlen -= dhdr + dftr;
-		areq->dlen = dlen;
-		qat_req->dst.resubmitted = false;
-	}
-
 	if (dir == COMPRESSION) {
 		params.extra_dst_buff = inst->dc_data->ovf_buff_p;
 		ovf_buff_sz = inst->dc_data->ovf_buff_sz;
@@ -329,7 +247,6 @@ static struct acomp_alg qat_acomp[] = { {
 	.exit = qat_comp_alg_exit_tfm,
 	.compress = qat_comp_alg_compress,
 	.decompress = qat_comp_alg_decompress,
-	.dst_free = sgl_free,
 	.reqsize = sizeof(struct qat_compression_req),
 }};
 
diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_req.h b/drivers/crypto/intel/qat/qat_common/qat_comp_req.h
index 404e32c5e778..18a1f33a6db9 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_req.h
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_req.h
@@ -25,16 +25,6 @@ static inline void qat_comp_create_req(void *ctx, void *req, u64 src, u32 slen,
 	req_pars->out_buffer_sz = dlen;
 }
 
-static inline void qat_comp_override_dst(void *req, u64 dst, u32 dlen)
-{
-	struct icp_qat_fw_comp_req *fw_req = req;
-	struct icp_qat_fw_comp_req_params *req_pars = &fw_req->comp_pars;
-
-	fw_req->comn_mid.dest_data_addr = dst;
-	fw_req->comn_mid.dst_length = dlen;
-	req_pars->out_buffer_sz = dlen;
-}
-
 static inline void qat_comp_create_compression_req(void *ctx, void *req,
 						   u64 src, u32 slen,
 						   u64 dst, u32 dlen,
-- 
2.39.5


