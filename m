Return-Path: <linux-pm+bounces-24043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2221A610E1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3193B9F3D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409CC1FFC60;
	Fri, 14 Mar 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="jwJ7Fof4"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648871FFC4B;
	Fri, 14 Mar 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954979; cv=none; b=qMkeIiX7ApS2K3VJNUV4ezcjCDS8Dc+1DQYxHGjTg48T7L2QYOGA5unXANUGvSDuNfvUzVV/o34GSbx+jAdy8KUKzlo2Tych2kt+4nHfFiYkypmxaPlk9dmD4EBjUfmgyPusNRN7B+PDH/92iyudElw8/fyUXZJ+X4L9p7iuSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954979; c=relaxed/simple;
	bh=GXurj3eAr/J1gshDakXdzCLgyyNpUUNRDhIyf2JgK+4=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=FB3tPmvyVNpDBAzS+sg2REIqkJb7pcZjt6ES6U21sXuTm6hV5w/r4kil4M0BJkC8lBz8wVINQvA7sh/Naf5PNlZwQmUFr+8Uc5XoffbbGlMORKhclJu7ttA/NUfvou+1ByaOWwFZSnkoEBJ48n4r4leCSeTUSdvfcVDnxXohea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=jwJ7Fof4; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l+ZShRAgEc0yiVA0reyVkATRhc0SDpPkUxK/Z/PM0O0=; b=jwJ7Fof4b1Tzltln/IGPTWMw5i
	kPmCIbqsknsU4xX/ar4lrxeqPLO+en1QzXM6v8LLKpDEwwTJdqpmt7uVByRTR3zAfdb48rWT6kV18
	oaTomOWKXoN/NLggIn9klOilJVaFe0zwPIKOin1BvDuac+crTbVjeGeI9yScdCjdk0lMMMr/Powpd
	DT31k2144ROwP7bYG4odOK3Iok+5IDC09lWgyhTf7HwzeXqT0c4oc+D5cM/SDeI7ejyGlJOYFZSO1
	hEXfy5zAQ1B95RtOE0hKu9R/FtD/YZvk5pc6UotsE9xDto7E6KydwvIXqxJQnlVsCYtsCaCHVHnf/
	VWMRUo5g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43m-006Znb-1X;
	Fri, 14 Mar 2025 20:22:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:42 +0800
Date: Fri, 14 Mar 2025 20:22:42 +0800
Message-Id: <5498a27375e1f8a7451435195ae7a01fd670fe19.1741954523.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741954523.git.herbert@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 08/13] crypto: acomp - Add async nondma fallback
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add support for passing non-DMA virtual addresses to async drivers
by passing them along to the fallback software algorithm.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/acompress.c | 69 +++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index 9da033ded193..d54abc27330f 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -152,20 +152,6 @@ struct crypto_acomp *crypto_alloc_acomp_node(const char *alg_name, u32 type,
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
 
-static bool acomp_request_has_nondma(struct acomp_req *req)
-{
-	struct acomp_req *r2;
-
-	if (acomp_request_isnondma(req))
-		return true;
-
-	list_for_each_entry(r2, &req->base.list, base.list)
-		if (acomp_request_isnondma(r2))
-			return true;
-
-	return false;
-}
-
 static void acomp_save_req(struct acomp_req *req, crypto_completion_t cplt)
 {
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
@@ -234,6 +220,45 @@ static void acomp_virt_to_sg(struct acomp_req *req)
 	}
 }
 
+static int acomp_do_nondma(struct acomp_req_chain *state,
+			   struct acomp_req *req)
+{
+	u32 keep = CRYPTO_ACOMP_REQ_SRC_VIRT |
+		   CRYPTO_ACOMP_REQ_SRC_NONDMA |
+		   CRYPTO_ACOMP_REQ_DST_VIRT |
+		   CRYPTO_ACOMP_REQ_DST_NONDMA;
+	ACOMP_REQUEST_ON_STACK(fbreq, crypto_acomp_reqtfm(req));
+	int err;
+
+	acomp_request_set_callback(fbreq, req->base.flags, NULL, NULL);
+	fbreq->base.flags &= ~keep;
+	fbreq->base.flags |= req->base.flags & keep;
+	fbreq->src = req->src;
+	fbreq->dst = req->dst;
+	fbreq->slen = req->slen;
+	fbreq->dlen = req->dlen;
+
+	if (state->op == crypto_acomp_reqtfm(req)->compress)
+		err = crypto_acomp_compress(fbreq);
+	else
+		err = crypto_acomp_decompress(fbreq);
+
+	req->dlen = fbreq->dlen;
+	return err;
+}
+
+static int acomp_do_one_req(struct acomp_req_chain *state,
+			    struct acomp_req *req)
+{
+	state->cur = req;
+
+	if (acomp_request_isnondma(req))
+		return acomp_do_nondma(state, req);
+
+	acomp_virt_to_sg(req);
+	return state->op(req);
+}
+
 static int acomp_reqchain_finish(struct acomp_req_chain *state,
 				 int err, u32 mask)
 {
@@ -252,10 +277,8 @@ static int acomp_reqchain_finish(struct acomp_req_chain *state,
 		req->base.flags &= mask;
 		req->base.complete = acomp_reqchain_done;
 		req->base.data = state;
-		state->cur = req;
 
-		acomp_virt_to_sg(req);
-		err = state->op(req);
+		err = acomp_do_one_req(state, req);
 
 		if (err == -EINPROGRESS) {
 			if (!list_empty(&state->head))
@@ -308,27 +331,17 @@ static int acomp_do_req_chain(struct acomp_req *req,
 	    (!acomp_request_chained(req) && !acomp_request_isvirt(req)))
 		return op(req);
 
-	/*
-	 * There are no in-kernel users that do this.  If and ever
-	 * such users come into being then we could add a fall-back
-	 * path.
-	 */
-	if (acomp_request_has_nondma(req))
-		return -EINVAL;
-
 	if (acomp_is_async(tfm)) {
 		acomp_save_req(req, acomp_reqchain_done);
 		state = req->base.data;
 	}
 
 	state->op = op;
-	state->cur = req;
 	state->src = NULL;
 	INIT_LIST_HEAD(&state->head);
 	list_splice_init(&req->base.list, &state->head);
 
-	acomp_virt_to_sg(req);
-	err = op(req);
+	err = acomp_do_one_req(state, req);
 	if (err == -EBUSY || err == -EINPROGRESS)
 		return -EBUSY;
 
-- 
2.39.5


