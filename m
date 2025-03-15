Return-Path: <linux-pm+bounces-24104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DAFA62AFB
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 11:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39733189E7BE
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B46D1F940A;
	Sat, 15 Mar 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="QkrRlbZ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C11F5420;
	Sat, 15 Mar 2025 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034645; cv=none; b=VRT2nyEirVFQqVN31hRflTzCVHu11h0WyjFGs4Pxz5IxR9K1rlvVEfqULb89G8G9MWGF1WC8pK80Gq/Mzsf987R35gPEoiHpodVXEoSgbN5E5JZQ/gCyCoZodMMJMGtnEIF9ZaQT/RPZkHkum5/luJxCyc72bgb8XAwsz7/klCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034645; c=relaxed/simple;
	bh=40Mlx4e6yBDXNUgMyoNak53lr7Q6liwk5o5P0Qa2EoY=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=sabQ0knQRylJ/0srjZ44ptDazyog+9GWUfzIpIlI+k7zP0CaD7m3EebxOkl6t1+puqCTY3h6Y7rMiS21h5FFg4hX/rx90zLyCutmTxokY+2hxj/ANQwc/FjxXhUPYl1oppAfq/6JV8PnWTxZwA/XM0gt8YXfM+bXUbOmllRJJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=QkrRlbZ8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ayt9c9VcjdzGiGYnOCGmRVfzRz7oGOaoohPPJPGpvn4=; b=QkrRlbZ8QyuE5/CeNrCop+ohMu
	tPZEVciX5Qfm8Fq+DkbhrRTkiv+VrMN6hBqxvWoTrjhCRHl29Y8NAcgmhGqsxz3rWA+YK/7COuBt9
	fCHdrNJ92ezMTuVviacr76sDOeg86huI43qiogTuzq9KqH2GohDSOm0nYpDGwvF2Hj008M5AtYY3s
	+JrcpLsLiNr4HiunkdvuPX9kha7bNh914kIwi5bpvLvvWLDEgTqAS0Cszh0XV14XDFIcaEDhXWYSo
	2kOgsI75/zTP1/zYIuFCjPoVTKhrib3YT358anlEyQyG+hCc8DgYr1UQjIAUCV0qjN0dUA6ikx2pr
	K3bY48sw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttOmZ-006p8x-3B;
	Sat, 15 Mar 2025 18:30:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 18:30:19 +0800
Date: Sat, 15 Mar 2025 18:30:19 +0800
Message-Id: <5360493c41a4ebc12ba2a8a0908cde53117a06fb.1742034499.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1742034499.git.herbert@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 01/14] xfrm: ipcomp: Call pskb_may_pull in ipcomp_input
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

If a malformed packet is received there may not be enough data
to pull.  This isn't a problem in practice because the caller
has already done xfrm_parse_spi which in effect does the same
thing.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_ipcomp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 9c0fa0e1786a..43eae94e4b0e 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -97,6 +97,9 @@ int ipcomp_input(struct xfrm_state *x, struct sk_buff *skb)
 	int err = -ENOMEM;
 	struct ip_comp_hdr *ipch;
 
+	if (!pskb_may_pull(skb, sizeof(*ipch)))
+		return -EINVAL;
+
 	if (skb_linearize_cow(skb))
 		goto out;
 
-- 
2.39.5


