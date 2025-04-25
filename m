Return-Path: <linux-pm+bounces-26217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB0A9C8DD
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 14:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC3D3ADE8F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF02451F0;
	Fri, 25 Apr 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="IsQT5opm"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFCC1DB127;
	Fri, 25 Apr 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583683; cv=none; b=dWGMQzIon8mYJ2F72c9RmTY4fe9PzRRjLrDQapxh3ekW2kS6MgmB36jyKsgVfrfXjN6zRYd3T93mMfRt8VF+V1XDBICPUImDdLZvDoA3sE5O2YbVOV9uoM5YeKtg1rR7wOX/DmE1DmknyxFhdjFUiRi8Tf1YMN/zwfVfpbXxblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583683; c=relaxed/simple;
	bh=b3Tu7R1v0lHpW0CDNzr1zDMsUI38BpLJRRp4F83LuBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyYG08g8d5zdFXbeOZi3w9nyaGPUZyiR6TdJmo9v+YSq3pgLirzygsvgTOxuLhH0GzxjBhe/9isp13Sp9PNidaCyh8ut4gUHCuhdA7IOWnSDRGcLZ5qd9HcuLXDXFf8dgD48dG6LZs5zYoNaKEMFLJuuRF8wcps9kzZxBix59X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=IsQT5opm; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Fc/25MkrpBeQ5N+c0EPmb7zcVe24kUxWCCXYa4mSP68=; b=IsQT5opmNOuSSThUWcBeGkcobG
	5ycosMTSABz34FQRjWDlNnTSeHToSWXB0JM9EtXW9pzXugp13H0IskALZaPk3fZ9AOJfUefig2HeD
	ZDMXepl4UZPl/HO0IfLCiJ0MLfu1Kk2L735q3wLzTZwNxiZ9iJZ6rSxMM6Hvw9MTONkOV/BzPgOuq
	QoVkoym3vz2kWlyKi0OpbZkokU+xKkbCJ7ieZrjCMMYKuLrsXSDkX8E9i/794shaBTs42eMiO1wF+
	DqLJz4DA3WKZFYrQGwu0mEuIVmaaugRNzruZ1mwHfeAT3m+zklb56qRZSGYS958oTX58wH11c/lQk
	zGbKZyaw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8I2s-000yzT-25;
	Fri, 25 Apr 2025 20:20:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Apr 2025 20:20:42 +0800
Date: Fri, 25 Apr 2025 20:20:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v5 PATCH 11/14] xfrm: ipcomp: Use crypto_acomp interface
Message-ID: <aAt-GiUloeLEfu7O@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <d7bccafdf38259c2b820be79763f66bfaad1497e.1742034499.git.herbert@gondor.apana.org.au>
 <aAt8AIiFWZZwgCyj@krikkit>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAt8AIiFWZZwgCyj@krikkit>

On Fri, Apr 25, 2025 at 02:11:44PM +0200, Sabrina Dubroca wrote:
>
> The splat goes away with
> 
>  	/* Only update truesize on input. */
>  	if (!hlen)
> -		skb->truesize += dlen - plen;
> +		skb->truesize += dlen;
>  	skb->data_len = dlen;
>  	skb->len += dlen;
> 
> pskb_trim_unique ends up calling skb_condense, which seems to adjust
> the truesize to account for all frags being dropped.
> 
> Does that look like the right fix to you?

You're right.  I must've missed the truesize update in skb_condense
when writing this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

