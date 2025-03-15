Return-Path: <linux-pm+bounces-24077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B4AA6232A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 01:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAE4421330
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0B028F4;
	Sat, 15 Mar 2025 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="VymMNzgT"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F842E3377;
	Sat, 15 Mar 2025 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741998722; cv=none; b=YP8lTucDicdJdPn3KYVPBi8ME2q098OnsHUiFdKr/tpj78HMbIArzcx51ldzKe2JUmIpuXE1Fjvs9fG62hWSe3GR7aNNHNyU4WwQIGn12fj98zk2lP8lywrcpuFoGBbfEDAMFLssi6ZJq1VOOS1uTeaYF/PUECKzfrcLjKhQ6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741998722; c=relaxed/simple;
	bh=Je8DBcuCNLQIuW9S+QysgJ0snPg8uIOECpzutgrWcBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQQkXgrlqxPqJblcy9YQ9BGJETj4XiFAMZ6aLFMTXREqYZlQ6Y9D6g5BmbgfjLOehlzvt99kHgJVpk+pnJKbS5NjFJ7YpUDVZYYP346xVBB/xrisi788n6xf2kxgYgni4eFH4mXl6WFcFj4ngB5TlLtweqNs3GxMCLiEKJz1i4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=VymMNzgT; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=t3ecUWY92S53odYjmM31lnI9pitPM2pM+xnXq3bFvsg=; b=VymMNzgTs1z8T84RIQQNiPfsqh
	hJdYDA8EHMUIcWNmq8x1krK7oyDwo5BqKErXIYBgz2CSaGclFUAtXzw/SglY/AxHy1ZulvME7cTCl
	bnPDFMSLw4q5kdezHuIRMQYwEiZaI6pIMQ4D5MWk6oJzNQkmuD3PHQ/Odx+A0VrZRGhhJlr3fZSRd
	Zuj61q+lI3CiDYm8mticZaygOlDElUr/j8StYvpJ3DfKM8ECDYC+PocWHZIqsAWHGdXeG2KKQSBGs
	wzjPHSuShtY3A5ZtW/NoQv7pAbA179WVdCuVBI/GDxS+5VOCenJqLZHc46HUsk4/aens9yLbLP7Tj
	DoSdk3tA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttFR8-006kEb-0B;
	Sat, 15 Mar 2025 08:31:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 08:31:34 +0800
Date: Sat, 15 Mar 2025 08:31:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: [PATCH] crypto: qat - Remove dead code related to null dst
Message-ID: <Z9TKZgYaVAerVVkU@gondor.apana.org.au>
References: <cover.1741954320.git.herbert@gondor.apana.org.au>
 <1e29b349410b0d9822c8c0b8f6e01386a3c44d66.1741954320.git.herbert@gondor.apana.org.au>
 <Z9Q1euXeBy7x8zZI@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Q1euXeBy7x8zZI@gcabiddu-mobl.ger.corp.intel.com>

On Fri, Mar 14, 2025 at 01:56:10PM +0000, Cabiddu, Giovanni wrote:
>
> The implementation of this function in qat/qat_common/qat_bl.c
> should be removed as well as. After this change, it is not getting
> called.

Thanks.  I'll fold this patch in if a rebase is needed.

---8<---
Remove dead code left behind after the dropping of null dst support.

Fix the areq->dst test so that a null dst is explicitly forbidden.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/intel/qat/qat_common/qat_bl.c  | 159 ------------------
 drivers/crypto/intel/qat/qat_common/qat_bl.h  |   6 -
 .../intel/qat/qat_common/qat_comp_algs.c      |   2 +-
 .../intel/qat/qat_common/qat_comp_req.h       |  10 --
 4 files changed, 1 insertion(+), 176 deletions(-)

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
index 9d5848e28ff8..a6e02405d402 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -183,7 +183,7 @@ static int qat_comp_alg_compress_decompress(struct acomp_req *areq, enum directi
 	if (!areq->src || !slen)
 		return -EINVAL;
 
-	if (areq->dst && !dlen)
+	if (!areq->dst || !dlen)
 		return -EINVAL;
 
 	if (dir == COMPRESSION) {
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

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

