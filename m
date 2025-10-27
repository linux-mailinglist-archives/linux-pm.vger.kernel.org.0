Return-Path: <linux-pm+bounces-36873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB7EC0BF34
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 07:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A918A1BC7
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 06:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF92DC78D;
	Mon, 27 Oct 2025 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DzGTbIhk"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EE2DC33D;
	Mon, 27 Oct 2025 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546317; cv=none; b=g9N2wR3nzBvZW5L93UcTZ4iKI5FPmG/dG9DiUpmzeV+bbBYkHZTG5cG3okjGgwjzceHTgYhqQkFj1WNSh8R5gvXNCy9fsIifMFANxN9mNqcMZz58dvaO9zrBoqcs5R5lnNSOCRWlh8yvi1LlJF2HDPSSMD7b8/ml+o3JQcGDsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546317; c=relaxed/simple;
	bh=stTFyfLVGp+W4whQthMtW+Y9CwBF66g3n0AdFiL433g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzIQjxl1EcpKeC2+LCYfwBip4Nhzk0RuVa4Ne5i6HeQ+HOTec0LQDuHGAdv4AAoC1iYOlthDCMZVOJDnu/1OL9v1WFjVXVMUDhpc7O/xDAz2I7iVmNk+ncRIG0yubZAOcEvRpyITXDwnfEYTdvp+PYdQJaRieXj/1IKDvDhJswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DzGTbIhk; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C81EF26165;
	Mon, 27 Oct 2025 07:25:06 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZHsxAfypXtY; Mon, 27 Oct 2025 07:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761546305; bh=stTFyfLVGp+W4whQthMtW+Y9CwBF66g3n0AdFiL433g=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=DzGTbIhkjVGAqaFY4Ckdcddadvv49E1vqrO3HCLuc17+5EW3y4lck5lJ0QMwwyeWb
	 1/a5SzmCzazKSvbinwNw6Qkqo/a8h5RCLSdDD+1ODTI8k6bMrCQpNDuNFjdIQEvi+2
	 dijh5UfWJvrauNDSLHI95xhtqxWF3OZ9ZbLGsik27ffWxLfvqWSs3Byz7TiPeRF00X
	 vq3dJbLBu5FzMGaHOYJaIQrvcAWRRrMZPpnRbFQB/YEizkSE9b61vHY2kkm+twXGQ3
	 jHIf8wCIN2ETtw82N7mS7irlxSeYgPUk2zrEDFyB4gnTDnJ0vG5jxlm8KJ6WhkN+R4
	 nfZtQYaoe8h1Q==
Date: Mon, 27 Oct 2025 06:24:31 +0000
From: Yao Zi <ziyao@disroot.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
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
Message-ID: <aP8QHwsYDlbQxQJo@pie>
References: <20251026224424.1891541-1-aurelien@aurel32.net>
 <20251026224424.1891541-2-aurelien@aurel32.net>
 <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>

On Mon, Oct 27, 2025 at 11:20:33AM +0800, Troy Mitchell wrote:
> On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
> > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> > chip, which is commonly paired with the SpacemiT K1 SoC.
> > 
> > The SpacemiT P1 support is implemented as a MFD driver, so the access is
> > done directly through the regmap interface. Reboot or poweroff is
> > triggered by setting a specific bit in a control register, which is
> > automatically cleared by the hardware afterwards.
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> > v2:
> >  - Replace the "select" by a "depends on"
> >  - Remove outdated Reviewed-by
> > 
> >  drivers/power/reset/Kconfig              |  9 +++
> >  drivers/power/reset/Makefile             |  1 +
> >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
> >  3 files changed, 98 insertions(+)
> >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> > 
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 8248895ca9038..61c16f3d5abc7 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> >  	help
> >  	  Reboot support for the KEYSTONE SoCs.
> >  
> > +config POWER_RESET_SPACEMIT_P1
> > +	tristate "SpacemiT P1 poweroff and reset driver"
> > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> > +	depends on MFD_SPACEMIT_P1
> > +	default m
> default m if ARCH_SPACEMIT? Or default ARCH_SPACEMIT?
> I believe that reboot and shutdown are actually essential functionalities,
> so it might make more sense: default ARCH_SPACEMIT?

I don't think there's anything preventing it to be built as module by
default: even though it's "essential", it's unnecessary during kernel
and userspace startup, thus I see no reason to build it in the image.

Building it as module by default shrinks the kernel image, which most
distributions are willing to see, thus helps distro maintainers to
maintain the configuration.

The default value has been discussed in v2 of the series[1], where Emil,
Yixun have expressed preference on "default m". So do I here.

>                                       - Troy

Regards,
Yao Zi

[1]: https://lore.kernel.org/spacemit/aPXAyeDC7YXAketm@aurel32.net/

> > +	help
> > +	  This driver supports power-off and reset operations for the SpacemiT
> > +	  P1 PMIC.
> > +
> >  config POWER_RESET_SYSCON
> >  	bool "Generic SYSCON regmap reset driver"
> >  	depends on OF

