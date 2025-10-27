Return-Path: <linux-pm+bounces-36879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC3DC0CA72
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A0F3AC127
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218FE2F12CB;
	Mon, 27 Oct 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JpPZECOn"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439D2F068F;
	Mon, 27 Oct 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557099; cv=none; b=eXPCpJlbI/O9CIxCKOupSEcr9lgT8X4NbeTG4jPHs92Es9ZjNgitLykaBe68bjADApB4EXScCZWrnerJ5+KJXNpwQQ73d7YqypZQnp6I8HZb+XwcswoOMgSnYBk42cUadzNeSI+ATitARiT35wDDcWTpGGVJTSjCFOcVJa9Jioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557099; c=relaxed/simple;
	bh=jfdUwDgnq3QfeqzXUtLRsl6YPhRoNT1QEbmdgk2ch84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t259oRb8AiUoBlAgI6hOoCoQQIM6S1oJqAt08CP1B8npipL1k7Hf3wIFShhxWhUS3jae2chv1ZZhm8XRgK5TJFDN+VuY9apeFIyfKSQ4pQTQBQf1fNjBE58o07nDR57dZMADDSZMtjTvwn1/tTwGrV3u9EFU3KuLguXI8vgg60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JpPZECOn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AC628260B6;
	Mon, 27 Oct 2025 10:24:54 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fBjG5FigbkBP; Mon, 27 Oct 2025 10:24:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761557090; bh=jfdUwDgnq3QfeqzXUtLRsl6YPhRoNT1QEbmdgk2ch84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JpPZECOnKi87MZULsBuohtO3XHj9JWS0ZQmI9CIwmblDBg1PNP/DVR/VPhE3FE3/N
	 krnmsUymLHPPKod8YPhGBFwK3iGfTcTQ3QwaE555bF3FCUr/1AS7SIF4horTM+Meci
	 K4sFQkXbsPolJpnectPctepeKNgsxt5f/ReIjNVT+Fq0O/8m9YXBm9IoMGK3qzM0r1
	 7NpTEOvJYSHA+kMMF7ZwABd3sWNKIs34O2N8QOcNSps0a9tKN+D/qnU8rpyA+pmd6Z
	 JfnIF+KRicxclrDJxePl/xQOuTqeAhHmrc3UOsroq+rUB8ajsSa8/zLPSg3AXYkkrc
	 Ff4VXpTW2YS1Q==
Date: Mon, 27 Oct 2025 09:24:30 +0000
From: Yao Zi <ziyao@disroot.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <aP86TltQ2uqeK6FY@pie>
References: <20251026224424.1891541-1-aurelien@aurel32.net>
 <20251026224424.1891541-2-aurelien@aurel32.net>
 <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>
 <aP8QHwsYDlbQxQJo@pie>
 <mvmh5vk67in.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmh5vk67in.fsf@suse.de>

On Mon, Oct 27, 2025 at 10:03:44AM +0100, Andreas Schwab wrote:
> On Okt 27 2025, Yao Zi wrote:
> 
> > On Mon, Oct 27, 2025 at 11:20:33AM +0800, Troy Mitchell wrote:
> >> On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
> >> > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> >> > chip, which is commonly paired with the SpacemiT K1 SoC.
> >> > 
> >> > The SpacemiT P1 support is implemented as a MFD driver, so the access is
> >> > done directly through the regmap interface. Reboot or poweroff is
> >> > triggered by setting a specific bit in a control register, which is
> >> > automatically cleared by the hardware afterwards.
> >> > 
> >> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> >> > ---
> >> > v2:
> >> >  - Replace the "select" by a "depends on"
> >> >  - Remove outdated Reviewed-by
> >> > 
> >> >  drivers/power/reset/Kconfig              |  9 +++
> >> >  drivers/power/reset/Makefile             |  1 +
> >> >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
> >> >  3 files changed, 98 insertions(+)
> >> >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> >> > 
> >> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> >> > index 8248895ca9038..61c16f3d5abc7 100644
> >> > --- a/drivers/power/reset/Kconfig
> >> > +++ b/drivers/power/reset/Kconfig
> >> > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> >> >  	help
> >> >  	  Reboot support for the KEYSTONE SoCs.
> >> >  
> >> > +config POWER_RESET_SPACEMIT_P1
> >> > +	tristate "SpacemiT P1 poweroff and reset driver"
> >> > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> >> > +	depends on MFD_SPACEMIT_P1
> >> > +	default m
> >> default m if ARCH_SPACEMIT? Or default ARCH_SPACEMIT?
> >> I believe that reboot and shutdown are actually essential functionalities,
> >> so it might make more sense: default ARCH_SPACEMIT?
> >
> > I don't think there's anything preventing it to be built as module by
> > default: even though it's "essential", it's unnecessary during kernel
> > and userspace startup, thus I see no reason to build it in the image.
> 
> Wouldn't it be needed in a reboot-on-panic situation?

Oops, yeah, I missed this stuff. Seems systemd automatic boot assessment
could switch to another boot option if one fails to boot. And if it's
caused by a (very early) kernel panic, then reboot support does play a
part here.

So my statement, maybe as well as the module's default value, should be
re-evaluated. Yixun, Emil, what do you think about it?

Best regards,
Yao Zi

> -- 
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

