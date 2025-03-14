Return-Path: <linux-pm+bounces-24049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5358A610F4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC93462FA3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313FB2010EF;
	Fri, 14 Mar 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="RzXEf6Qn"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107E1FECAB;
	Fri, 14 Mar 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954991; cv=none; b=l5+ckWX2tJalGSYapgDFXKjRFfgAZ1jsd8bbmL+LXQ4hhY/QkTuFtLIRql5mCEaJgpTXW18m1Ghd2btueA+uUPhnbgGisaO2DP8Vmqx0qHX7gcKYJhfjBCP6103Jphejuttg+DjN3QZ5bGpgM8roWerlxWxQjphtIfbIyQUm4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954991; c=relaxed/simple;
	bh=IOqcbcSyIMPkljBgvP6atjQQPggxoxOzt9hxbvb7/uU=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=NPRhq+I2XQq/PYPpkv0b5YlTfprHR/TXJ68fBdv4lRSk3PBbYMpV3wn+rJPL5sWB6Ocm5YZw/fZ542yVTWVLi2It8FloWJWiB5i+A5SBmXsh8F4jyw0HvtBtk9l7W/ID9A5C4L80IVQAe0udLZbiL9cYA5g/8zKFcaxEOr0dXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=RzXEf6Qn; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=avLv1kIH8yNek3R4MB5SP5S6/ORyKKw5wrgNAuoZdZU=; b=RzXEf6Qn+9pV5rjrmq+XBvmzn5
	9RWfQLwnbKWX/XEJmqNQqNBEAIXUX45TSU764e/PSBWHfr4Orn/WFmu7uh+SwdQ6bXs4liXR6Y7QR
	hIlBtH3hZceTxzhVQajqzs9EAAGnhGciLXoLh+4pZNIoLrvn6hVv1wn1kmBSjlkcrGYvTYg1CHo+6
	CIWR0gm2TxZn5asU5fnXrppSuABsaV7B0WOJMZDpFfrAN3SVV+viNe9jmuvelyqZjmbCGb2wcL959
	RFZ4gim2RE4eOJreaSWtvV9AUHrl3t4gFFXrIVrQWHoG9IfAOtse3X3b1y0TbN0Lfed3jT3EINlN9
	+61CRThQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43v-006Zou-2J;
	Fri, 14 Mar 2025 20:22:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:51 +0800
Date: Fri, 14 Mar 2025 20:22:51 +0800
Message-Id: <785c7858e03ad03a56ffaee0e413c72e0a307a63.1741954523.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741954523.git.herbert@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 12/13] PM: hibernate: Use crypto_acomp interface
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Replace the legacy crypto compression interface with the new acomp
interface.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 kernel/power/swap.c | 58 ++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 82b884b67152..80ff5f933a62 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) "PM: " fmt
 
+#include <crypto/acompress.h>
 #include <linux/module.h>
 #include <linux/file.h>
 #include <linux/delay.h>
@@ -635,7 +636,8 @@ static int crc32_threadfn(void *data)
  */
 struct cmp_data {
 	struct task_struct *thr;                  /* thread */
-	struct crypto_comp *cc;                   /* crypto compressor stream */
+	struct crypto_acomp *cc;		  /* crypto compressor */
+	struct acomp_req *cr;			  /* crypto request */
 	atomic_t ready;                           /* ready to start flag */
 	atomic_t stop;                            /* ready to stop flag */
 	int ret;                                  /* return code */
@@ -656,7 +658,6 @@ static atomic_t compressed_size = ATOMIC_INIT(0);
 static int compress_threadfn(void *data)
 {
 	struct cmp_data *d = data;
-	unsigned int cmp_len = 0;
 
 	while (1) {
 		wait_event(d->go, atomic_read_acquire(&d->ready) ||
@@ -670,11 +671,13 @@ static int compress_threadfn(void *data)
 		}
 		atomic_set(&d->ready, 0);
 
-		cmp_len = CMP_SIZE - CMP_HEADER;
-		d->ret = crypto_comp_compress(d->cc, d->unc, d->unc_len,
-					      d->cmp + CMP_HEADER,
-					      &cmp_len);
-		d->cmp_len = cmp_len;
+		acomp_request_set_callback(d->cr, CRYPTO_TFM_REQ_MAY_SLEEP,
+					   NULL, NULL);
+		acomp_request_set_src_nondma(d->cr, d->unc, d->unc_len);
+		acomp_request_set_dst_nondma(d->cr, d->cmp + CMP_HEADER,
+					     CMP_SIZE - CMP_HEADER);
+		d->ret = crypto_acomp_compress(d->cr);
+		d->cmp_len = d->cr->dlen;
 
 		atomic_set(&compressed_size, atomic_read(&compressed_size) + d->cmp_len);
 		atomic_set_release(&d->stop, 1);
@@ -745,13 +748,20 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		init_waitqueue_head(&data[thr].go);
 		init_waitqueue_head(&data[thr].done);
 
-		data[thr].cc = crypto_alloc_comp(hib_comp_algo, 0, 0);
+		data[thr].cc = crypto_alloc_acomp(hib_comp_algo, 0, CRYPTO_ALG_ASYNC);
 		if (IS_ERR_OR_NULL(data[thr].cc)) {
 			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));
 			ret = -EFAULT;
 			goto out_clean;
 		}
 
+		data[thr].cr = acomp_request_alloc(data[thr].cc);
+		if (!data[thr].cr) {
+			pr_err("Could not allocate comp request\n");
+			ret = -ENOMEM;
+			goto out_clean;
+		}
+
 		data[thr].thr = kthread_run(compress_threadfn,
 		                            &data[thr],
 		                            "image_compress/%u", thr);
@@ -899,8 +909,8 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
 				kthread_stop(data[thr].thr);
-			if (data[thr].cc)
-				crypto_free_comp(data[thr].cc);
+			acomp_request_free(data[thr].cr);
+			crypto_free_acomp(data[thr].cc);
 		}
 		vfree(data);
 	}
@@ -1142,7 +1152,8 @@ static int load_image(struct swap_map_handle *handle,
  */
 struct dec_data {
 	struct task_struct *thr;                  /* thread */
-	struct crypto_comp *cc;                   /* crypto compressor stream */
+	struct crypto_acomp *cc;		  /* crypto compressor */
+	struct acomp_req *cr;			  /* crypto request */
 	atomic_t ready;                           /* ready to start flag */
 	atomic_t stop;                            /* ready to stop flag */
 	int ret;                                  /* return code */
@@ -1160,7 +1171,6 @@ struct dec_data {
 static int decompress_threadfn(void *data)
 {
 	struct dec_data *d = data;
-	unsigned int unc_len = 0;
 
 	while (1) {
 		wait_event(d->go, atomic_read_acquire(&d->ready) ||
@@ -1174,10 +1184,13 @@ static int decompress_threadfn(void *data)
 		}
 		atomic_set(&d->ready, 0);
 
-		unc_len = UNC_SIZE;
-		d->ret = crypto_comp_decompress(d->cc, d->cmp + CMP_HEADER, d->cmp_len,
-						d->unc, &unc_len);
-		d->unc_len = unc_len;
+		acomp_request_set_callback(d->cr, CRYPTO_TFM_REQ_MAY_SLEEP,
+					   NULL, NULL);
+		acomp_request_set_src_nondma(d->cr, d->cmp + CMP_HEADER,
+					     d->cmp_len);
+		acomp_request_set_dst_nondma(d->cr, d->unc, UNC_SIZE);
+		d->ret = crypto_acomp_decompress(d->cr);
+		d->unc_len = d->cr->dlen;
 
 		if (clean_pages_on_decompress)
 			flush_icache_range((unsigned long)d->unc,
@@ -1254,13 +1267,20 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		init_waitqueue_head(&data[thr].go);
 		init_waitqueue_head(&data[thr].done);
 
-		data[thr].cc = crypto_alloc_comp(hib_comp_algo, 0, 0);
+		data[thr].cc = crypto_alloc_acomp(hib_comp_algo, 0, CRYPTO_ALG_ASYNC);
 		if (IS_ERR_OR_NULL(data[thr].cc)) {
 			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));
 			ret = -EFAULT;
 			goto out_clean;
 		}
 
+		data[thr].cr = acomp_request_alloc(data[thr].cc);
+		if (!data[thr].cr) {
+			pr_err("Could not allocate comp request\n");
+			ret = -ENOMEM;
+			goto out_clean;
+		}
+
 		data[thr].thr = kthread_run(decompress_threadfn,
 		                            &data[thr],
 		                            "image_decompress/%u", thr);
@@ -1507,8 +1527,8 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
 				kthread_stop(data[thr].thr);
-			if (data[thr].cc)
-				crypto_free_comp(data[thr].cc);
+			acomp_request_free(data[thr].cr);
+			crypto_free_acomp(data[thr].cc);
 		}
 		vfree(data);
 	}
-- 
2.39.5


