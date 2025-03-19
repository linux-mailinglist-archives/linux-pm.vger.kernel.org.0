Return-Path: <linux-pm+bounces-24277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA977A688EE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 10:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5545718835B6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FA72505CA;
	Wed, 19 Mar 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="CvxxG/ey"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676E30100;
	Wed, 19 Mar 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378277; cv=none; b=abF/NOwCkO1WjM5GICcMINwOCkhUcbzRfF5RKOK1OTHbLtCHvtNfsv/B1zlj3NgMSqpW4ZfJ1iTGqxLpqXQIYXDYAl27ITWn1V34D1yzYCL0jNsqpjTaaKoGxxSkCWEo6xlra2RMc8TbOVqG8XJfLTSJWFJf6QXCgDQObyDPpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378277; c=relaxed/simple;
	bh=EDcNa8pK8yvc65/nE00YXl8sQ93rzcTZs/QoZCG+gQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQq/4TTyZXg5h5nD6TDVXT+Hfk5LXF2PVcXghz41VqdMsw+CYPYpeEu5KqGHgJu6uZ2gKCSipWR+92yI247j8Y/sviVjs15ThuBh9CFSELLGG7ztWjICakxHCxxNrlwvKxqtibg+jt3HKRrBFvW4OeihXu2B/vxbT+4Wa8//ioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=CvxxG/ey; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=soZjkWmnxzqoseqLHBteHQrecOxj2rcgJpWAd/MQWSw=; b=CvxxG/eyewwJvyAZXaUOdQOndl
	dPKTxPdgPfY/0NRpPiisMELtLDbUeB0vdhyo0lmJkLaC6L7RHoge1S+gQf99Di1uGEOl61jmR96LW
	nWCXuiF31cKw2pvW/he2hq8aaizHtVlEXIBh/lsA18cuWCY/ZYDKYiMYmKeNzwNP+0uMuJgoufnaC
	MCB7+EcY2Jenq9G3HVYX7RqY2iExTkKmCaZIGgfl4UZKX43XgiKXdE7mBUMfDov4/I6muJ2xIyIV7
	7jn6z2rVncpR/OnSDEmTSjvJSP5/VNj5UFnLi+2H11U7I0m6kXnS+jcVBh57CwvpBxl/hPl3NMQyR
	2sfc2gOw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tuqB2-008My9-1x;
	Wed, 19 Mar 2025 17:57:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 19 Mar 2025 17:57:32 +0800
Date: Wed, 19 Mar 2025 17:57:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v5 PATCH 10/14] crypto: acomp - Add support for folios
Message-ID: <Z9qVDFAzse7y3zLa@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <aa5ce234573d4916ca7a2accf4297cea6f750437.1742034499.git.herbert@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5ce234573d4916ca7a2accf4297cea6f750437.1742034499.git.herbert@gondor.apana.org.au>

On Sat, Mar 15, 2025 at 06:30:40PM +0800, Herbert Xu wrote:
>
> -		n = slen / PAGE_SIZE;
> -		n += (offset_in_page(slen) + soff - 1) / PAGE_SIZE;
> -		if (slen <= req->src->length &&
> -		    (!PageHighMem(nth_page(spage, n)) ||
> -		     size_add(soff, slen) <= PAGE_SIZE))
> +			spage = nth_page(spage, soff / PAGE_SIZE);
> +			soff = offset_in_page(soff);
> +
> +			n = slen / PAGE_SIZE;
> +			n += (offset_in_page(slen) + soff - 1) / PAGE_SIZE;
> +			if (PageHighMem(nth_page(spage, n)) &&
> +			    size_add(soff, slen) <= PAGE_SIZE)
> +				break;

This should of course be

			size_add(soff, slen) > PAGE_SIZE

> +			if (PageHighMem(dpage + n) &&
> +			    size_add(doff, dlen) <= PAGE_SIZE)

Ditto.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

