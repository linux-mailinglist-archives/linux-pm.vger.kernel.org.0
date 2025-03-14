Return-Path: <linux-pm+bounces-24042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13330A610DF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50E2880978
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D791FFC59;
	Fri, 14 Mar 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="gPK3uH1i"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D091FFC46;
	Fri, 14 Mar 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954979; cv=none; b=j1Kyvf/ZXTROui6GnaEMEIfJF5GbolzklVBlh0JcZnUT4y06i72EVi7CGBylg3w3JFSEyZrA3OZlFaPsvNdM747k+cP1MKi1+vQLIxnuGdZFh6edKj1AHmsbxHI2g97kK0lWX7efu5sKFVAuH004xtIRpIsGIwF9ONgiJJ+VaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954979; c=relaxed/simple;
	bh=tVD4eQVgjQcDgU5VuVeqgx/xerr+2sWQUDkoICbKS+Q=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=GKoOQuNdTi3DaoU2pM+Z+MxO/HVk8JuIEuDRdEs+IhrVOe0Bo9osLjx0ZdD2F2PsaGJxOUG19ZJ/K/BwmrK4JIZnxs93EJW1AwJEGsmQahOoO/7z82j6dtzkACJ66XzLuTRUzk/E+pj3n5S1/zzgl55v0zNxbPXrFje90L0wbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=gPK3uH1i; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KzUqiKmDfyVjOhBcGp1Btr2sYsGEx9by+Pr5sL1lV+M=; b=gPK3uH1ikN6akg09KidJxxGFn5
	xAOypABetxoD/9lmYtVB5pml1tAFdm25RGxHNZIJdAm2JHNMY9+IMeN7GIotcledlgjVS+iQ5/g0J
	GBXoOoEzt3+1qsz/v8FtrgpA0dHlNG+Qnfk7nswCjQzQ5GFMNom3AIl/YETJCGyqNdcnLcOTGBZVQ
	nI2tJsAWMgcu2SvcZI+Lq7cbgeKYMC08f6egjvRvbOgF4nxlozEq6eFutBFp+GNdmET0wx7IrRZM6
	hqn9J9M9XnMRVzCHk+wwYgxtGWkJNh7c2lO6yV9GaiK0z5aIKTwcbnLjB5BRD/YFQZlvBMu/z1KCK
	BcXPaO1w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43d-006ZmX-0u;
	Fri, 14 Mar 2025 20:22:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:33 +0800
Date: Fri, 14 Mar 2025 20:22:33 +0800
Message-Id: <17787b6b8f00b2ad067e31b8eb1fe8b339da6856.1741954523.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741954523.git.herbert@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 04/13] crypto: acomp - Remove dst_free
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Remove the unused dst_free hook.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/internal/acompress.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index 957a5ed7c7f1..575dbcbc0df4 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -17,7 +17,6 @@
  *
  * @compress:	Function performs a compress operation
  * @decompress:	Function performs a de-compress operation
- * @dst_free:	Frees destination buffer if allocated inside the algorithm
  * @init:	Initialize the cryptographic transformation object.
  *		This function is used to initialize the cryptographic
  *		transformation object. This function is called only once at
@@ -38,7 +37,6 @@
 struct acomp_alg {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
-	void (*dst_free)(struct scatterlist *dst);
 	int (*init)(struct crypto_acomp *tfm);
 	void (*exit)(struct crypto_acomp *tfm);
 
-- 
2.39.5


