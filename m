Return-Path: <linux-pm+bounces-24100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB028A62A32
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194B617BA40
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA11F76C0;
	Sat, 15 Mar 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="lG9Ekt1A"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71791F7076;
	Sat, 15 Mar 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031300; cv=none; b=VXz17AXngnGyIDE4OibtGdDImAhAkVqbn5KHpA1VdKLh81o/W84R4tqyxDbKF+aIymtImNqkFEwdUlN3dWNcBsVQX/321V8Sh5f6bW3wJr1cwhrJQLmxPVEiRQfceYnOb2YP1DqmiKSvmyl7/fFyUmWZiJpuvHVi2LMBV8Quz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031300; c=relaxed/simple;
	bh=PhpK/FDG+WqU+nQeeVS3ClTvOlqXqn+75VPr4tBB1Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F250HShIR525mtyCEZvL5w4eLP/qe/o4LjWhW8dDlTehUb52yuXvQanYHqKq/W+M59a5X1WK4RHjk0VPIcpjbU+PxRMOZTqpXvFFX8QlEF89s3maTush2dcO1TKvB5YGVTRwE1kCJma+yOnsny6W3mwSQ1dSqCB2TjnKpNbOkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=lG9Ekt1A; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bf04FaDSJInFFvE99abyiooWZ6DhuQ0k4BNLeKjh8l8=; b=lG9Ekt1APmuMProcfaLFcLEq7Z
	QWH+Qu8zNF/58q8MuCJxpLwmP12QOcrbMFF2rMI3ZhTiJoLPDAIlYCSLtsn9+2YXCtCj7T0ofIXD+
	Xm5rvYq2m/D74XKoGMHA0sBUTYrsJgNyUBndUtQfsx2KehYm3OsHZqCnkg8O1xs4V+ZKNxaB0j3kI
	hSU26ykPnpJf6WYVnClsjvH6JPYSA/P3ApmWZKDXmCjbTokFd2rnT6wt15BQ13nQ0Topkk7GTMcZs
	WRryjlViBP1yrcbGLi71rifJeCKITlhiwaUuA7Tbv7Vitcuf/sByuuyQUJbPZ1dmezfAksqUF8LoE
	4ymZRYiA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttNuk-006oJN-1S;
	Sat, 15 Mar 2025 17:34:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 17:34:42 +0800
Date: Sat, 15 Mar 2025 17:34:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
Message-ID: <Z9VJsgD2f5O8Ogyj@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <e5792e49-588d-8dee-0e3e-9e73e4bedebf@huawei.com>
 <Z9VCPB_pcT4ycYyt@gondor.apana.org.au>
 <dfa799fd-5ece-4ea4-d5d0-8c1da39a3a8d@huawei.com>
 <Z9VEkEOul9bt4bc1@gondor.apana.org.au>
 <1b6176d7-31a8-7211-b648-a79bd25af6dc@huawei.com>
 <Z9VJK5npf_sMcVMd@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9VJK5npf_sMcVMd@gondor.apana.org.au>

On Sat, Mar 15, 2025 at 05:32:27PM +0800, Herbert Xu wrote:
>
> Unfortunately that requires quite a bit of work.  If you would
> like to restore the warning you will need to modify each algorithm
> implementation to return a consistent error.  Right now it's all
> over the place.

Of course if you really want to keep the warning, then I can
just restore the existing worst-case output length so that
even incompressible data will succeed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

