Return-Path: <linux-pm+bounces-24081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E33A625B5
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 05:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0995517FA9E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11CD1898E9;
	Sat, 15 Mar 2025 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="sNCJEQBn"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35808A2D;
	Sat, 15 Mar 2025 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742011410; cv=none; b=ElfRC917XOyLr5y6C0mXFBWCYwtGDc6RX2AUUvNH7i0FWqLznLw6O3mbzQybrV1PcdEN3mtDC+374pnNIFuYrF24oAlgpSvWQF52gmSa9DBBITAglNv+rxRvHPsPWwP3eR48MKPMkNcODZD54UriCJH51dAZ6UBZJZb0XQv2Kq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742011410; c=relaxed/simple;
	bh=ZAj0Z7E+7qehzFc6TL2aGQ9TJZYwiw3Qatp/XotLBq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arMf/aFb6uuAZJdmL3MxoB1SDPDJ1xO02klOO2BwyFY5PFXVEQLoyUpy6LbSDXwRN4BM68/9ha6x4u4GwejrX22DvsLAlwnPps0QoCMNb9kxLxW49BIzVyOZe5VrLLhCdzwE6rXe/mciU9D6osGgCzLS66NS9gkisbeW9Im9oi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=sNCJEQBn; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2VUsKyX4LW0rXY166Mqej+WS9QN0xTroHFRzX9sIm0o=; b=sNCJEQBn5tLW27DpywCT+NgK5O
	UB4RhYMWCTKgdOE27URAD5B0yLayoHm72rCMe71c5IrlfMpbngAMxxJ0FEoQyOngVZe898Q7funoi
	7tZyc78f5k270/K6jFM8eDNXA35TOJI20QfxCwPztoEBjfWqcZzj38JfbM4aMOKDwgz2+qrctKDfT
	LOMQS5vS3F+w0J8740CddEqmNcVU6yV1kX4CSdbTupfxtewarfgCHrxgSuYNGTJ9NKxVuy2dMQs/5
	sNzY+mRdIuz4XufxQLvImqJ7EDH+Ri+j5eL1SIxkxcFDhwA5Gg3NSJPd2YSZmPfrGNRiywo8yZQCR
	d+pClWlw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttIjk-006lfE-1Q;
	Sat, 15 Mar 2025 12:03:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 12:03:00 +0800
Date: Sat, 15 Mar 2025 12:03:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
Message-ID: <Z9T79PKW0TFO-2xl@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <023a23b0-d9fd-6d4d-d5a2-207e47419645@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023a23b0-d9fd-6d4d-d5a2-207e47419645@huawei.com>

On Sat, Mar 15, 2025 at 11:54:43AM +0800, Zhihao Cheng wrote:
>
> We get capi_name by 'crypto_acomp_alg_name(crypto_acomp_reqtfm(req))', not
> compr->name.

It should return the same string.

> There are conflicts in patch 2 on the latest mainline version, can you
> rebase this series so I can do some tests for UBIFS.

Thanks for testing! I've just pushed it to

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git acomp

So you should be able to pull that to test.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

