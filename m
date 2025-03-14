Return-Path: <linux-pm+bounces-24041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97725A610DC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB1F8817BE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E551FFC42;
	Fri, 14 Mar 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="UIesLuOk"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7571FF1CE;
	Fri, 14 Mar 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954977; cv=none; b=obG2h+hN7Mkp5NVQTXSNFhDIQeS17bLa5S9sU/R43IK2zVVGtiFWuJmnxbwV/KDThJtDjGgWk8UDwntJ0v8W++gaQot0z2K7dCtZYNbSat3SnhcH1XDk2wGIfJg755eoFV00ifo5C9F8VWwQMGPq9jPqcPLB4ogwpC1+l95q2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954977; c=relaxed/simple;
	bh=+uuxJaOeVr3jZTRaC2FAbtdc5dJBjxropLllTH5FOcQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=gSi5KclHO0b3D9CnabQ9DU1fEMQKduxyyFek9W6ZQ4WqT2HR3L+Av+v2YceHVb/QVlkop4kbh+rjGhde8qgz+HOOc0+b2pTeNxmFRFGliTOMbk4oGquUUz0g6sTU9af77WTrx1t5JHdnCRoiPJsWaUUI/MgPnpXGdaMMSLwrGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=UIesLuOk; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zIb0wSG71Ygj2H3jMgCe2Okz2AI9eV57QCfyyCpN7fc=; b=UIesLuOkOKkXi6wOEUTzd8PLUa
	xc77yNRZ84G492gM0yD5b2fCNAUd92yIdOAEjzDcY9qJfxGqIaI/GQMoh+NAEwN68XTFkTDyFe/9V
	Ec49HFWezk6LFLaJAyGFYive0u7KYruVUi0Z/OlOzJV1gyJVAKuzDthWxNoiaesG6dp7er+IQrGwH
	FZ2QKx8L+hxO47Bv9cVhwXGp3+S9KV+a1FIQxkqD2IB3kT0cPAG0yKqeJLov66/sADzg8Pj0Wgopu
	uCxFTE+YtZc4+tXRG93Yh/Sv8Vy54O8CorJ01niKH4j/VbhhfcaBtQC9qm1ti8l9QBlNZOS1nqyA8
	Gfg+9dXA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43k-006ZnL-0c;
	Fri, 14 Mar 2025 20:22:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:40 +0800
Date: Fri, 14 Mar 2025 20:22:40 +0800
Message-Id: <96c3973e2ef9cd6762071a6dc5d6b34c660f9fa7.1741954523.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741954523.git.herbert@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 07/13] crypto: iaa - Use acomp stack fallback
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Use ACOMP_REQUEST_ON_STACK instead of allocating legacy fallback
compression transform.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 28 +++++-----------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 50cb100bf1c8..09d9589f2d68 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -33,8 +33,6 @@ static unsigned int nr_cpus_per_node;
 /* Number of physical cpus sharing each iaa instance */
 static unsigned int cpus_per_iaa;
 
-static struct crypto_comp *deflate_generic_tfm;
-
 /* Per-cpu lookup table for balanced wqs */
 static struct wq_table_entry __percpu *wq_table;
 
@@ -1001,17 +999,14 @@ static inline int check_completion(struct device *dev,
 
 static int deflate_generic_decompress(struct acomp_req *req)
 {
-	void *src, *dst;
+	ACOMP_REQUEST_ON_STACK(fbreq, crypto_acomp_reqtfm(req));
 	int ret;
 
-	src = kmap_local_page(sg_page(req->src)) + req->src->offset;
-	dst = kmap_local_page(sg_page(req->dst)) + req->dst->offset;
-
-	ret = crypto_comp_decompress(deflate_generic_tfm,
-				     src, req->slen, dst, &req->dlen);
-
-	kunmap_local(src);
-	kunmap_local(dst);
+	acomp_request_set_callback(fbreq, 0, NULL, NULL);
+	acomp_request_set_params(fbreq, req->src, req->dst, req->slen,
+				 req->dlen);
+	ret = crypto_acomp_decompress(fbreq);
+	req->dlen = fbreq->dlen;
 
 	update_total_sw_decomp_calls();
 
@@ -1898,15 +1893,6 @@ static int __init iaa_crypto_init_module(void)
 	}
 	nr_cpus_per_node = nr_cpus / nr_nodes;
 
-	if (crypto_has_comp("deflate-generic", 0, 0))
-		deflate_generic_tfm = crypto_alloc_comp("deflate-generic", 0, 0);
-
-	if (IS_ERR_OR_NULL(deflate_generic_tfm)) {
-		pr_err("IAA could not alloc %s tfm: errcode = %ld\n",
-		       "deflate-generic", PTR_ERR(deflate_generic_tfm));
-		return -ENOMEM;
-	}
-
 	ret = iaa_aecs_init_fixed();
 	if (ret < 0) {
 		pr_debug("IAA fixed compression mode init failed\n");
@@ -1948,7 +1934,6 @@ static int __init iaa_crypto_init_module(void)
 err_driver_reg:
 	iaa_aecs_cleanup_fixed();
 err_aecs_init:
-	crypto_free_comp(deflate_generic_tfm);
 
 	goto out;
 }
@@ -1965,7 +1950,6 @@ static void __exit iaa_crypto_cleanup_module(void)
 			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
 	iaa_aecs_cleanup_fixed();
-	crypto_free_comp(deflate_generic_tfm);
 
 	pr_debug("cleaned up\n");
 }
-- 
2.39.5


