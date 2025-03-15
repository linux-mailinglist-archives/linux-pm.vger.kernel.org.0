Return-Path: <linux-pm+bounces-24105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA659A62AFC
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000D73BEE07
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CAE1FAC5C;
	Sat, 15 Mar 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="VXobMZ3Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB521F9F60;
	Sat, 15 Mar 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034647; cv=none; b=fHJZRFs1k/rEMfwN0Y3xfRbQCjfHwET2CWN6z/8dzOTlZDliHmS+Vc5PScHOumZ947+TSiq0SlKuiYC3bPeBDdoFwXenIBLJm3QiwvGfrTVZlBGf/qDyEG7QDsntXVA0k77jsGykdCzVNH/Zhf17NPtR85q1NaPz9bjc+Fc4r0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034647; c=relaxed/simple;
	bh=tVD4eQVgjQcDgU5VuVeqgx/xerr+2sWQUDkoICbKS+Q=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=kH4AVjti3yFlVOIAQTXhFp8EmEaT+1b5A7D7rbCOp0HiVoBvy60+cMEbL4ZNq0vGVt4zqjrUWFljaS2X/QyVem9fHGmt4zTMVtzlj4V7cwxnLRBHH6h3QLwBqgXXSLoLEqdVqqwhyOqNMJbYaIJu8lv/HRn8IcTar/xpPMdLLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=VXobMZ3Y; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KzUqiKmDfyVjOhBcGp1Btr2sYsGEx9by+Pr5sL1lV+M=; b=VXobMZ3Y8vATPC3L9UcX5S4rPg
	ZVam8+21N+E1rPwi2RSbsRdy5f5O/NF82tH02+tYuudbvUtnWr8ZrFuUE1XfHYbWwFkr7uyLiJvut
	ZDjpF4ZT4g1QOJZNKDPpqhzU6zntdUYnJ6vgYQRDunjPZePch15H1UrawNQycJoCFcRqZEYmcUYh0
	IurN51Y82e4eRN57k8j0fcEvqV3Kpk7KhH93jo5KBAYYkb3jV+G+M8iVJ9j/FmRKdvl8SvfmesY+F
	S13/JnvPAXS60aCGf48ZT4yih8cWXuq48sq5pzoavPUIeeFwp3clg8YouALoCppA4FefO3myBQvHP
	tOVbKL5Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttOmj-006pAI-1U;
	Sat, 15 Mar 2025 18:30:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 18:30:29 +0800
Date: Sat, 15 Mar 2025 18:30:29 +0800
Message-Id: <aabd036f637f60a9fa455b254eebe031da3a0ee0.1742034499.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1742034499.git.herbert@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 05/14] crypto: acomp - Remove dst_free
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


