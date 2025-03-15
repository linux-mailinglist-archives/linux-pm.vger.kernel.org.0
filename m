Return-Path: <linux-pm+bounces-24112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC2DA62B10
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 11:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFA27AAE49
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F7D1FC7F7;
	Sat, 15 Mar 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="mard5Rai"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4781F560B;
	Sat, 15 Mar 2025 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034663; cv=none; b=qob573qTWKUKCCD3OiDsXAG0HIj6x6OxSZFpmnpr9Vi7l/NvC/3TXxorOGSw1iIQcokD2u8LsWOk1TEOSx/NVqSTpqtb/xk9gzMOMCIMkLnFJcmP+b/cbgB5Upt/iH5ALiOMi84Bmm6WCvYz8j5w03uAKRzns3+DxP50QRT5IUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034663; c=relaxed/simple;
	bh=WFWYufyC2B1reaxQYjMBCNy5mcXbdY0CClen+AtFNJI=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=bfnGBINERFE42AmREgvelfbULWUZIkToZ3/Nyt/PJmfY5w9snjIIc7f2EufsB/y+TjAvNrWEA5USFPHslUsjGt82YVCgKq9kT5x3S41IjGqyNdRxzfgsLzPHtl9ERzcLwfIWd+frw4Dec6bOAOlQvd55CD0hDkrx3VXhmHlskMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=mard5Rai; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xKQt4Hlnj5e/HvykRuz+6r4zNwDvKhLAIlJI8TesC9s=; b=mard5RaiB53sgxHWGigmRyNu/z
	QVMxyNh0mBvl3eiSqd6xkjcGFuz9jYzWpqi1lE33QGmwKcUqNlDR6GZyjuz9SOoSlYWnHEnN19SDH
	4Hhm0HWXclbrIUk5L5kRTLmmXyu+4o7RKpUxOGQRLomxTvv0vehoJhET+vlFKWzgQfz9NzazMTx3k
	jfvW+i+fpJvWpcNP/nfYpXed93EBj2JVclEtW1HqR1zJSLyou3hqqS/eMrYxh4sknCTJsHEacaoQ1
	qm+Q48exqJFv3qThVhs4IgQAgHvk9t75jYofrhP4mDAZ9y9u7o3+SvlUy+Md6422xkzGBVtXq2PCl
	wqMAzkiA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttOmz-006pCh-1f;
	Sat, 15 Mar 2025 18:30:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 18:30:45 +0800
Date: Sat, 15 Mar 2025 18:30:45 +0800
Message-Id: <339411183892ccee27409f00e975ae09f88e01af.1742034499.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1742034499.git.herbert@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 12/14] PM: hibernate: Use crypto_acomp interface
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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 kernel/power/hibernate.c |  5 ++--
 kernel/power/swap.c      | 58 +++++++++++++++++++++++++++-------------
 2 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 10a01af63a80..12051ff00839 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) "PM: hibernation: " fmt
 
+#include <crypto/acompress.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
 #include <linux/suspend.h>
@@ -757,7 +758,7 @@ int hibernate(void)
 	 */
 	if (!nocompress) {
 		strscpy(hib_comp_algo, hibernate_compressor, sizeof(hib_comp_algo));
-		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
+		if (!crypto_has_acomp(hib_comp_algo, 0, CRYPTO_ALG_ASYNC)) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			return -EOPNOTSUPP;
 		}
@@ -1008,7 +1009,7 @@ static int software_resume(void)
 			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4, sizeof(hib_comp_algo));
 		else
 			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZO, sizeof(hib_comp_algo));
-		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
+		if (!crypto_has_acomp(hib_comp_algo, 0, CRYPTO_ALG_ASYNC)) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			error = -EOPNOTSUPP;
 			goto Unlock;
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


