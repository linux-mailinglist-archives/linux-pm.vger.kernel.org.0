Return-Path: <linux-pm+bounces-36682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE6BFECF3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 03:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCF13A51B8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DE21DDC35;
	Thu, 23 Oct 2025 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="aY5rUL1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02681175BF
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181573; cv=none; b=uTuhaoqpNyctuk8gWUrcJmWNQYu/1cDYgspFGzV/9fEUpQjP2Vdr1/DSW8kIEzJXskHQhWLHuFlpi4jSgJ1sETaLCrAvDw5jwdX6hP8uaEPc2gKZO2hjW8F8NC17tES5xWocUHfOoP0eJ+QZVsmGoSIquNNea/8NQ0wCHNePI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181573; c=relaxed/simple;
	bh=uFxGX+eI6uH+Bh3hEnUm8uApgHL2PeR35JjVEXAeMMg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvaoO1JleMU9BeLQNbPcKOFpxwj+ao5P2kG7aPD/C8PcACejAOCOxquFwDFbJIFqcolEiR7rpSCd9nLm81BYB8R1GJg2sBeFWVT1Fp21JQzldb6rrASE4fHte274tEQ30Y+xLCFe+UUaK44oDHwF1T6xaYWmsM8j507oQ+Uj5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=aY5rUL1o; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761181562;
	bh=XsRWgb+mLGrtoREAsHT1s5qba4+X2pYPCy+f+7l7JVg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=aY5rUL1oYae3PGa9/+kez8ngWA+V7a2/Td9Gr2n5/V7REI5AsSwLJ9msohLNPryIJ
	 6aeUTrqSAvlP0nHXjyGtAOyXIu51PLyf/mU2qpb9XhpKbKTi8Ahb4nRkHPKh7MP76V
	 EPgjRyIK0qUJj6ozSnahl5MoeozG/fO/RJk/V60g=
X-QQ-mid: esmtpgz14t1761181560t1645cf02
X-QQ-Originating-IP: gkSINpiiygpxneEIVwBY685Q0g+hGSeOD1Z1ltMwcms=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 09:05:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5511248865145279605
EX-QQ-RecipientCnt: 12
Date: Thu, 23 Oct 2025 09:05:58 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <4A64F9771A29AB00+aPl_duwqfb45u4NW@kernel.org>
References: <20251021201451.1013640-1-aurelien@aurel32.net>
 <20251021201451.1013640-2-aurelien@aurel32.net>
 <20251022004830-GYB1522542@gentoo.org>
 <aPhtd0j6iBpqiGUQ@aurel32.net>
 <52468F28CD7B50FD+aPhurJD4HTXqIGDT@kernel.org>
 <aPkK7aEHhxKScoCN@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkK7aEHhxKScoCN@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MoSEQw8weEWfGfLqmS/FW7Y5J7z8eaJpdKNfLvnuiEEepr4SNn9dyBoF
	OSYWor55m19AI/JRVN1wkybW5Nnb8+DWGVB11ioZxzqUZVlkM19nNO8LXjDzQDlTH9NyDSF
	VWc6TLbfxzzR2DZD9tB0z3t3wYd+WG9Q8Jzce5+KHTW5FQPxKORpCTWZDqBQNv9dV8kblFr
	wVV1sn3CCg5FLuM2WZwVmM1y0nJdxG7zAGPHR4zx8tzORA+bcYTDOVZ+IejTOHjMpD2qdHe
	QqdFmZzgVEzOkjDBGcw+gUXH1onDwdec3GcIqNSK/75uB+8Rr4g9pRYSJKpYRcH6Ym+W3Ey
	B5+1Pi5mG+UmtpZKikuJPaW2l4VVEh7o49L52Yfisp5X1eRe0Jwgkvt06fptvCbIuwt03XE
	AeXE02AjvbuwLJ+9pINWmtMOswUTeLDo7ixcmRxfsFyNs8wQRmNzxzNsGYbfK22/XSsC4p0
	xejAv9Eldz68b45/P9nZfMcW/AJW8qG6uhaSHjurim4H89Fco7ubCcmGGtf2jzq1HMJdGuU
	0rOlFT4W/Y0XOxJvMwEpmm99cW0qiU2MLgAREZ90UwZjBchWn8H53eoBMMjyS8RQMzzjF7b
	s8T1YV/VxKDg5dKn5O1x9b8pxKv7F2QGvUMUDJiF6SkgaGNOWsqQn8cjjTHZfAwzardRavm
	MmJt3JStbIGbHK0uYR2rx4ehKU1KIvFkZlwSVTfsXMybdO0v13LJKL1wNpDH86zB2DzTmAR
	I0hMf1IyineChJomdUvzxHnV6BW9N2Dxxz/83WFqX7oktpfXTtiFgGSY+3EBBP2QIiaT/m+
	FkakwBeTAVtXA7gP7LoRQwtfQ7rDR7e8QRLcdaldKZKyiqqoUX0akYHZ7KVmfe46xoOCoVB
	laFAwdwAo21ylpcltustGpGnQXT0yP6bXVEOdbP0LHmSIJu/TOaUWfn+zGK+AcQ6QxF6GdG
	4PTUW3eXfj1WC6m5WNAFMGnaUJkSvhCTe5Or6/74CjFVkAi3bD12xxrviTrA6cVYJ/47l3R
	mlbBbYBozWv278MBSrRPbrwk6tKSo+sKZDtI9kb6D1hmGiPqHE6b5isJikuiWI1e4F40d8q
	bj07wIY2TVbiQ9+phok+7I=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Oct 22, 2025 at 06:48:45PM +0200, Aurelien Jarno wrote:
> On 2025-10-22 13:42, Troy Mitchell wrote:
> > > > > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > > > index 8248895ca9038..6577d73edbda4 100644
> > > > > --- a/drivers/power/reset/Kconfig
> > > > > +++ b/drivers/power/reset/Kconfig
> > > > > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > > > >  	help
> > > > >  	  Reboot support for the KEYSTONE SoCs.
> > > > >  
> > > > > +config POWER_RESET_SPACEMIT_P1
> > > > > +	tristate "SpacemiT P1 poweroff and reset driver"
> > > > > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> > > > ..
> > > > > +	select MFD_SPACEMIT_P1
> > > > I'd suggest to use "depends on" instead of "select", the reason is that
> > > > using "select" will sometimes ignore the dependency, considering
> > > > the reset driver here is tightly coupled with P1, so I think it's 
> > > > reasonable to switch to use "depends on", also refer below link
> > > > 
> > > > https://lxr.linux.no/#linux+v6.7.1/Documentation/kbuild/kconfig-language.rst#L144
> > > > 
> > > >         select should be used with care. select will force
> > > >         a symbol to a value without visiting the dependencies.
> > > >         By abusing select you are able to select a symbol FOO even
> > > >         if FOO depends on BAR that is not set.
> > > >         In general use select only for non-visible symbols
> > > >         (no prompts anywhere) and for symbols with no dependencies.
> > > >         That will limit the usefulness but on the other hand avoid
> > > >         the illegal configurations all over.
> > > 
> > > Thanks for the pointer, I'll fix that in the next version. I used 
> > > REGULATOR_SPACEMIT_P1 and RTC_DRV_SPACEMIT_P1 as examples, they'll also 
> > > need to be fixed.
> > Yes, I have said here[1].
> > Do you want to fix that? If you don't have time, I can do it.
> 
> For the reboot patch series, I'll do that in the v4, 
makes sense.

> but I would 
> appreciate if you can do it for the PMIC and RTC drivers. I guess it can 
> be a patch series with the first patch being the one you already posted.
Thanks for your suggestion! I will.

                    - Troy
> 
> > > Note also that without the select, a default value has to be added to 
> > > MFD_SPACEMIT_P1. 
> > Yes, I will add it in my patch. Thanks.
> 
> Thanks.
> 
> Regards
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 

