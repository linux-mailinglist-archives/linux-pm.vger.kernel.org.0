Return-Path: <linux-pm+bounces-36872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A898DC0BE70
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 07:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2993A8ED5
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 06:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB12D9EE0;
	Mon, 27 Oct 2025 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="V/b4RwyO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D52D77E5
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545216; cv=none; b=XDF9sWW6uComdNIffo6x0qZztThutWRF/g13wJvMKReFnwm61XSjYtsX7ORFewE2zE/n8pQ/Covcwi7KoYgS1yH7lRy5MM0JfjXKm2cL19+0X8g28xyM3HNSir6dJ5v3D1S5xcFWV836Z3iUQ6arcmK04WZAPlIlwUWD+7Y0aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545216; c=relaxed/simple;
	bh=5XT8CJzUJB6nvVvVmvtxIz6ke4BVepzM/qAnFjWabAA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5GuOpsQZAg8T7xthYtkzecYvpVEDrEgpENrVTyLwkIHDsvhKiQ8iDjgm933LfC0d6oA9buc9dPDE56n+ipsAj3W/gGWiYbmKYraSWRhDFOHbJQF2MoyMywuqbfSkWVjVl2vR7i82qJ5YEDR/576Gf3NlL9uFPhMH0oofEeBzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=V/b4RwyO; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761545209;
	bh=l3+MYw1gSrGd76gzuuq7j2y+q9z2WnobGN51l903Alg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=V/b4RwyO/nJJ8IdRbHUJ1Ga0wH/a2oOPuM8aI6iB55shSEvR+z06c61SqOuWye7G5
	 IzfrMLsDYN9eGN2hxlDDwBHDAd0+093zZkIy0+XeclQIbvTwyc5DcROZHAKRdp6MzF
	 phm9yxU4xNNLM84jqg2gm7/+XwUzbuyCsRu4kAdw=
X-QQ-mid: zesmtpsz8t1761545207tc173d1ef
X-QQ-Originating-IP: kaW+7dLJIqioSezBmW/uoXxbeOrYpMqkQA962FFA75o=
Received: from = ( [183.48.247.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 14:06:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17316863097272151893
EX-QQ-RecipientCnt: 12
Date: Mon, 27 Oct 2025 14:06:46 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <751AB506001CBF5F+aP8L9hBdTaVEko73@kernel.org>
References: <20251026224424.1891541-1-aurelien@aurel32.net>
 <20251026224424.1891541-2-aurelien@aurel32.net>
 <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>
 <aP8KqZ1hlqfQVPii@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP8KqZ1hlqfQVPii@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NEaes6yu2o+mHKWnqYCoIHCEZg2aNQ5IhYzZYJ6wP4/bwe1EZNtlQw7l
	0VnZlqattkL8CMJdHQw9wJmAvTLOv8z2zztpGDi3FxvgF/757OJPMk8lsrYMMfYfV9b03CU
	XnqtG/O7LRNL1Jhl6Ps3RaLmIrCxbCpV90leSXaWod5KGxmbVOng2KBX51ftb39QB0/Bqbk
	dVEg1tmHtoQWtjdIjrC6Uz33LZGhy8H4ikq15VCWlbw8YR4f1F7GsFT1ohLFicIJ0mA0LWB
	j+1VIdMfg4Nb7QFEi4li1UV+3BQuLEqFL6FuCe8PLG/nJutlL6OHztEjJmGd4ec5aLvQrXx
	j6q9yzcYPWOTxyLF7eg6VRfqnu0ELnE80Jm21wWXwo9xvdoXOXtbA8td+bAPHiv8YmP8ne+
	guWehl6PL9ydD7tZM2r2adybQypJuGpcnknXs3XLMz2M4kXKSIhBzcZgkm5YkmS5r/DMcW0
	j9shO5gZN/YY3DUp/vxGs1WuKoWbSMhV2XGRvnjSY9foPgHoC7YZMBRF2QmMpDD2/dH4Qcw
	NeR8PIGFrqM/YPB50H35iam854rAmVpddOJPiZcGc9ENJwvodQlrx0YbGEAa1AjCjehtRpd
	8JDqb6NfnWUVN0SFwBnB3XoQXl4u6FZJhXqOYXZ/dbSLT5WXH90Qgx0T96yw6f1DeOnCjeI
	IQP0hJozdf6MJcCs4J8PTmNUwqEU7hyykaGRZR7jdcZYusv31zhhe1VVTinTz+TwV9hxqd4
	JBSb+/SdND7veAFGyocUXU9ks8/vxNM/lyARZVCV84p+Pxt5yZj+yciHQ9tnkbGFftcP5ND
	6P7ruyJdLiuqTHNdhzvMGtVav2S22g9NoUP8rvXPn02vSiTVu5lOdWCZmPK+hYiQ04bgb/B
	vg0qP0Cc+qttuhczTNYID9uHI8ZIpzZXSrLd4fklgTS8iLBkU9E79YM8DIcoQVCmffdedzT
	+FjZYGRY6MqOhHDz4Ff8Ovchn8QxLxOARI3dVStsi3nfyurUCS9n3tD0sHry2eNjMCdt1hh
	16QfJzAoD/RWIhqsab9gA4hoPUn8TAwjFuFjdNXQseE2Ig0ubM4B57PBaMovVlL3EbfXxNu
	A+mA93LA4u8O5iyygdrP2g=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Mon, Oct 27, 2025 at 07:01:13AM +0100, Aurelien Jarno wrote:
> On 2025-10-27 11:20, Troy Mitchell wrote:
> > On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
> > > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> > > chip, which is commonly paired with the SpacemiT K1 SoC.
> > > 
> > > The SpacemiT P1 support is implemented as a MFD driver, so the access is
> > > done directly through the regmap interface. Reboot or poweroff is
> > > triggered by setting a specific bit in a control register, which is
> > > automatically cleared by the hardware afterwards.
> > > 
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > ---
> > > v2:
> > >  - Replace the "select" by a "depends on"
> > >  - Remove outdated Reviewed-by
> > > 
> > >  drivers/power/reset/Kconfig              |  9 +++
> > >  drivers/power/reset/Makefile             |  1 +
> > >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
> > >  3 files changed, 98 insertions(+)
> > >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> > > 
> > > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > index 8248895ca9038..61c16f3d5abc7 100644
> > > --- a/drivers/power/reset/Kconfig
> > > +++ b/drivers/power/reset/Kconfig
> > > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > >  	help
> > >  	  Reboot support for the KEYSTONE SoCs.
> > >  
> > > +config POWER_RESET_SPACEMIT_P1
> > > +	tristate "SpacemiT P1 poweroff and reset driver"
> > > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> > > +	depends on MFD_SPACEMIT_P1
> > > +	default m
> > default m if ARCH_SPACEMIT?
> 
> As explained here, this is equivalent:
> https://lore.kernel.org/spacemit/CAJM55Z_BzfRo5aKf2VrneTymSizwDQq6OfMK_LNgyoGjp43K8Q@mail.gmail.com/
> 
> But I can make a v5 to change that, if it's the preferred form on the 
> SpacemiT side.
I missed that conversation. Just keep it!
> 
> > Or default ARCH_SPACEMIT?
> > I believe that reboot and shutdown are actually essential functionalities,
> > so it might make more sense: default ARCH_SPACEMIT?
> 
> That was already changed in v3, following a request on v2:
> https://lore.kernel.org/spacemit/CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com/
Thanks for your link.

                        - Troy
> 
> Regards
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 

