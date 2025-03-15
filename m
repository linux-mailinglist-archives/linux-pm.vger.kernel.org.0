Return-Path: <linux-pm+bounces-24085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD57A626B6
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 06:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DCD7A91BF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 05:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50B18FDB2;
	Sat, 15 Mar 2025 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="PYNz1Jfv"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7315D1;
	Sat, 15 Mar 2025 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742017492; cv=none; b=LedHV9XBG2YvHahooHzzvrK16ZPDniqniHuFTl7IPGPSjRVJe0Fmtk+zifsDqmTQA1UBAoi6UkcOT8SzqhTqX+vsJ3qFa44XjhxDEsYLPzc+4An9xavjLQBT+Bf9Yuf0qTeEgmzCqEqhNjkwnumhJJHu1U9lUL1/Lu2ExpMKpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742017492; c=relaxed/simple;
	bh=Gn1M0TWmAcWZ9nKCuJ0Rz5lxFZMx2BIFmvRqdmztQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMP77/bdW3PzYlhFostY1S4tdljZpwE6nSyXq1D2kPypPXtPX3/zgB8wI+ID1Bt/jalQnjPRBhIl4kce13ZuWR5+Y1elwdTxc5TXG4oVaKWaT9t5a8mWZ6S+h4qaifGLqtNryRnQ4RJy8YJlpdTY8Dyf94/BP48ZwRbmoeCvNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=PYNz1Jfv; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=n6QHrjG4xFS2Vtdhn1I1SCFpoNnj0smpLOP3Qx1bE2M=; b=PYNz1Jfvpn7ZeUZP+ouqYIETKV
	pU2XnfrPc+hKM7rw3d62FRphdrkhBTpWTNCc/PkWML+/n4IumwNtpQ7CLQIWGaxTSj5DAXpvk7Ura
	cUBLLCmSsoyiAjIdJ1psFRdb5OFp7W11Bvgf1ksnKeF26yEs2GieL4sVxsdhwXyTF8UYys5bZCRFk
	tfU63E9Rbca3ZHm53zYL/UQdQaOfKqFn5Lmpj1/MHVKEGu0HUijPgTUTvvf2PcH+OTrGGoZGzELie
	nWzHUeExRqwbbBM44goGCPcrXoxe69kOKv7COYL6lxH5xr5powwbv5oU+8s+T4S3kDv5OwgW32eLa
	FObTjY4Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttKJy-006mGR-0v;
	Sat, 15 Mar 2025 13:44:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 13:44:30 +0800
Date: Sat, 15 Mar 2025 13:44:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
Message-ID: <Z9UTvkmx_InPeqEB@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <02dd5000-7ced-df02-d9d0-a3c1a410d062@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02dd5000-7ced-df02-d9d0-a3c1a410d062@huawei.com>

On Sat, Mar 15, 2025 at 01:15:09PM +0800, Zhihao Cheng wrote:
>
> Hi, Herbert. Can you show me which patch fixed the problem in LZO?

https://web.git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=cc47f07234f72cbd8e2c973cdbf2a6730660a463
 
> Does LZO guarantee the output data length smaller than input buffer length?
> Which commit fixed the issue?

The guarantee is that the algorithm will not write to the output
buffer beyond the specific buffer length.

For compression, you may specify a desired output length that is
smaller than the input buffer, automatically stopping the compression
if the input is incompressible.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

