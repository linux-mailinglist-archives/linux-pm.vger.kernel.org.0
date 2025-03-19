Return-Path: <linux-pm+bounces-24276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E4A688CC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 10:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583AE16320E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86A253F3D;
	Wed, 19 Mar 2025 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ETkCthii"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E0253F33;
	Wed, 19 Mar 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377651; cv=none; b=YvdJVNSZavdvv/ee/x85vtfZUEQN2+wNbTVG4SRR8YanW/qhd0k/uc8JSYwPQ3G7qk8ksLb3oSB3tm1qDFrkg7BPeE4V6oV4JgJu4gTw3k+oJTX0/OJgf9yLT7DzJibwE3BS8EJsi9YDglkeqb6UTcsS3RqHvzHIGoUSaGwX2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377651; c=relaxed/simple;
	bh=GLGPJmzIDQceRPnM5b1rtRVZVi1i37F5o+ZWftgRvC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtPttfMaajMw3CYJ2PppF2C18UHo5E1lBDJf4KkJLSTLhJo8PL5+4B+1lJ2wBoe0skE8kHNzhVOA+xBEw/r6eS/LLEoxyb4K1dOnivR+4F7uuH+HOz8uGRE+bjxRKFBKAYaXZ3G4w19Kmlc52BNBGDDN11KPadTGyDbdkf89aqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ETkCthii; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1xba3QwBDEdOqsdbJ70a1n1eNBHIuSvaY2GOl1m11oQ=; b=ETkCthiiHS/MuYoJ6fJY00srdI
	P23n6lZx9HO7rjd98/zNB5Jcv+hvV/1fBViMadwEPHECeJuz4/daWuvBJxSEjISbx8UkMIX/YXaZg
	B0x/yj0QH5LtDsPGbXkXrZ8X4HvmibFMUrYHDPeDXAiZJJC3EfCEn5VqrfrAjPNmAhEKbq9EopGdu
	EpZI+4GnhAGLB6k8BNHfZpwv7SRavwGCPp/I4YGHUcjjshZCDFFiwjgRsEgd2+d52zXmdKSRfexT0
	5iegz2atsw2WKGKOHMynI2/4npLS+xhLk3/ci20wYg4ZgtaK+eVBKRh9nelBIYuSrXE8u9xRLfdl1
	XszRH+MA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tuq0n-008Meg-21;
	Wed, 19 Mar 2025 17:46:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 19 Mar 2025 17:46:57 +0800
Date: Wed, 19 Mar 2025 17:46:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v5 PATCH 14/14] ubifs: Pass folios to acomp
Message-ID: <Z9qSkRbwig5VXstP@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <99ae6a15afc1478bab201949dc3dbb2c7634b687.1742034499.git.herbert@gondor.apana.org.au>
 <9f77f2a4-e4ba-813e-f44d-3a42d9637d0f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f77f2a4-e4ba-813e-f44d-3a42d9637d0f@huawei.com>

On Wed, Mar 19, 2025 at 05:44:17PM +0800, Zhihao Cheng wrote:
>
> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com> # For xfstests

Thank you for testing!

> > 
> > diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
> > index a241ba01c9a8..ea6f06adcd43 100644
> > --- a/fs/ubifs/compress.c
> > +++ b/fs/ubifs/compress.c
> > @@ -16,6 +16,7 @@
> >    */
> >   #include <crypto/acompress.h>
> > +#include <linux/highmem.h>
> >   #include "ubifs.h"
> >   /* Fake description object for the "none" compressor */
> > @@ -126,7 +127,7 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
> >   	{
> >   		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
> > -		acomp_request_set_src_nondma(req, in_buf, in_len);
> > +		acomp_request_set_src_dma(req, in_buf, in_len);
> 
> Why not merging it into patch 13?

Because it will break without this patch.  If the input is a highmem
folio it cannot be directly passed over to DMA (because the virtual
address has been remapped by kmap_local).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

