Return-Path: <linux-pm+bounces-24076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E001A622B2
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 01:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7207117CE69
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 00:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CBFEC2;
	Sat, 15 Mar 2025 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Ea++hkR8"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C417BA1;
	Sat, 15 Mar 2025 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997970; cv=none; b=PItojqExGEycz+D8pFv/DXtyO+8wpIJ5CemHbSCuJegUmVMxHQpocmtySnv7I5zv/j70zOsXQRBbcuFqeD3jj1XlqL403Tz29QY9BxT1QSMZ0UyQaymXN899LCIBVhA+3dU5YR63YjuZE1a+2zDU8dl3LJRSAuUS0Jnp/amOUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997970; c=relaxed/simple;
	bh=8VCNzzazfQIxNjt5dzAoZsn6sB0m5Z2NzhArROzidG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m82ZFVNNe9AVnngAXvtPUc311TPTiLpeLDyFhWswFyYCNV/HWt/wkjZCGvaE4IaCJVgX55TmSG1GhKut/EFAA0xGjbt70a/cS2MiAvhL/J+TGAj+lrnWLNF89p5YZvZQIHHCrgv/H4kaaOqaIyz7mcKYxx4GkwxKTihAEEyeooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Ea++hkR8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iUpCgk4UUaTWvFMQFZJJjWtALQkDE/pM1JIi7Yr1Tos=; b=Ea++hkR8STGZzKJwM++v0vZpuT
	fcILeOVKGxWDYM6Yj+xJ1bVwaSvdKNH+m+YqTTh//BKBUyuSlZEn7LKDctphgQqMeZvRjiMa5aT6P
	OHRFlOJurouAclErhVO9a4FjC50c2nvnRnJv4M4Ido0m/+hlhJo20WAbUTWJTU5wu7Hi37ftAfn6c
	qZNLjT0eghopQwpYzrgXnDmCx4pAa390Csmog/2vK9aE+RjEIM4QHKXvUGMNLu9CgVOf1TNoY3G4I
	JPqK+MbXrG4zYowhVm4zV3bMEzLTVQWnf0bEJhPR2KiDWrKdNjB/Au3+SxSm0cQfDcwOvv8M2fCEQ
	7hyIeCiQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttFEp-006k7n-24;
	Sat, 15 Mar 2025 08:18:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 08:18:51 +0800
Date: Sat, 15 Mar 2025 08:18:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v4 PATCH 03/13] crypto: iaa - Remove dst_null support
Message-ID: <Z9THa4q8Y_Ucg5nJ@gondor.apana.org.au>
References: <cover.1741954320.git.herbert@gondor.apana.org.au>
 <11128811057de7bb7e8d9ce9fe56bf9ee64ad143.1741954320.git.herbert@gondor.apana.org.au>
 <Z9QwrUqA0eaYxZaA@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9QwrUqA0eaYxZaA@gcabiddu-mobl.ger.corp.intel.com>

On Fri, Mar 14, 2025 at 01:35:41PM +0000, Cabiddu, Giovanni wrote:
>
> Something weird happened when you submit the set :-).

Sorry, I changed the order of the first three patches but forgot
to delete the original patch-set before sending.

This orphaned thread is part of the original and should be ignored.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

