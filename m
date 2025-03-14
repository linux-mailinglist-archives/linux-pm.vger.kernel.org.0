Return-Path: <linux-pm+bounces-24048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14191A610FA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918A57AF4C0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0B20102C;
	Fri, 14 Mar 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LxjrBmDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED71FECAA;
	Fri, 14 Mar 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954990; cv=none; b=Br1t8r1yXwWfwgI/tuomkRbJDa71R2dxlCmQ+fIeen6cXOTaNUaYj1y0E9AcHWxAPrkMMXhJnRlV5M3qBphNBftwBkCcGPi7J17ZQsqqA8vR9z5Tt4o9EEwfII+oWvotB6xIDhYF3ATUMBB0jLrL9D/D4Na0tw+Idtofe3uXVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954990; c=relaxed/simple;
	bh=Ytw2m7sDqhddLR3kuWQDrcpgCQy5SNX9aFLD4DY3eNo=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=e/MJ7YehjP7roYXR89kYKQDm/tcNehgqoKJUb37rDbFE8uh2AD0H+m8Z+k4tD5hX/alRQRZQpy0Q8Xfkpgn71uFYfTa4PnDQERkrYtLyjgzWxxCY0w+W9Xa1hJVIMAZcWBwW456qAEOM2XBkBBRJoTa7wiyDGyPpedIOW5H086k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LxjrBmDS; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a3l+91BKzsddVZxNXDZKRTkrBuBQtx6ec/a2AoHM33E=; b=LxjrBmDSAXMe+8IS1JLRtghsGp
	jZKHna+O2ddic/kb2ui4Rxa0/iaH4uvKACQVEZ9/qkqsD9U8Z8TW9XA30oLfPX5Ly+QUBTYJ7Ex5Z
	HYj+PlZeQnAoPRSnvD31J1kUhyQXvXXWL+MJWU7kYCFkL8LY8VrIBUZl9v45BFdpZsN/AO9PQEuFc
	UZFBVObwQgp++RmIRPtb+fR1FSz+tF8u7bHHx0JQxzYoAXMpUcNm74ov1psVFH+pE/d+EGJSO/N9t
	BLt5q4jWmqt6aNvC9tUjvCIJ1ZpMkc6j+k3gPGOTfJAk++4NEtDiADmyBpcil47IkA3o/pG7UXxdO
	20GhADSw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43W-006Zlr-1D;
	Fri, 14 Mar 2025 20:22:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:26 +0800
Date: Fri, 14 Mar 2025 20:22:26 +0800
Message-Id: <1e29b349410b0d9822c8c0b8f6e01386a3c44d66.1741954320.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741954320.git.herbert@gondor.apana.org.au>
References: <cover.1741954320.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 02/13] crypto: qat - Remove dst_null support
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
 .../intel/qat/qat_common/qat_comp_algs.c      | 83 -------------------
 1 file changed, 83 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index 2ba4aa22e092..9d5848e28ff8 100644
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
 
@@ -248,26 +186,6 @@ static int qat_comp_alg_compress_decompress(struct acomp_req *areq, enum directi
 	if (areq->dst && !dlen)
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
 
-- 
2.39.5


