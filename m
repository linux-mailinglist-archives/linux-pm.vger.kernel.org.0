Return-Path: <linux-pm+bounces-24333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5120A6A2B9
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 10:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F64462EF9
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D0214A98;
	Thu, 20 Mar 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="AXLjn6h3"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2594154C15;
	Thu, 20 Mar 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463271; cv=none; b=lLxDJvj/Qwx6vt/sSA+pd51AjBdX2/mC2tjoLjk+XgEeurOQAbBWZ+aSS9yEVSESnWc66xUw0qQO+KVg1Wnzh6wq8drVfnW34KMiokN+iKtatQY3YQjSxKC9rlWm3zdk9JGddptyiQR+GxqLoxk8c2DYd7VqIKZ3Bd0FFqTYYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463271; c=relaxed/simple;
	bh=bt+N5kQLJxvGgIO4NgUP/iL4oA4vaOGmqFvBCJSbhtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtlU3T8rimtORHwLkzSREdbLeknp16gOfga1IfJw4xGX7coH5EI0vDYQOm00Y0R7TeWCt+UMXspI6QpD6+SrL/FBfuHq2a4R6rak7iam+MSOQao3+ZoQeHsSrLrpKXVdk+iBSbb/6D9ApWelURBtFyzLdxI/hM5BqRnSDoL1lkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=AXLjn6h3; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NgDHGEQEM91sirkF0AfoRwO3nj0yC7YqaxjyVS0vZ7A=; b=AXLjn6h3p+ptU90LFBXmrST3qQ
	3Uh9x6yofzozBU9OGkrnqfJmYis+jGw+KswC8ZzAAS7BwOMjVlx1psug331Rpohj6oy1o42tV/k7X
	hRTiPUowHypiiNaxT6mupCE7AJlGz4sgBjDhp8U5DMHRfTjzRW9oOMz+YJXIpKtRhC7gsUqwCO56v
	q4sfFzB4wUNPx29wl+iBmiFnT5iCOvJF07avkO/faIN2OITJJdrJMfJo+Orkv6scMAV74iHmK+rUQ
	4Iyy6kktqUsFMtK1yu8cg2vRcOlU3KGctyn53lnYWfJkYkJxyYORZHQU+14rNrXxfk07v/Kg7uKmo
	+30tTLFA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tvCHm-008fU1-0b;
	Thu, 20 Mar 2025 17:33:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 20 Mar 2025 17:33:58 +0800
Date: Thu, 20 Mar 2025 17:33:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v5 PATCH 11/14] xfrm: ipcomp: Use crypto_acomp interface
Message-ID: <Z9vhBv2Jp0ABpZas@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <d7bccafdf38259c2b820be79763f66bfaad1497e.1742034499.git.herbert@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7bccafdf38259c2b820be79763f66bfaad1497e.1742034499.git.herbert@gondor.apana.org.au>

On Sat, Mar 15, 2025 at 06:30:43PM +0800, Herbert Xu wrote:
>
> +	sg_init_table(dsg, dnfrags);
> +	total = 0;
> +	for (i = 0; i < dnfrags && total < dlen; i++) {
> +		struct page *page;
> +
> +		page = alloc_page(GFP_ATOMIC);
> +		if (!page)
> +			break;
> +		sg_set_page(dsg + i, page, PAGE_SIZE, 0);
> +		total += PAGE_SIZE;
> +	}
> +	if (!i)
> +		return ERR_PTR(-ENOMEM);
> +	sg_mark_end(dsg + i - 1);

This is missing a

	dlen = min(dlen, total);

> +
> +	acomp_request_set_params(req, sg, dsg, plen, dlen);

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

