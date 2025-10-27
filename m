Return-Path: <linux-pm+bounces-36871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC4C0BE25
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 07:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3713BC357
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 06:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCD2D94BE;
	Mon, 27 Oct 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="ToPggUCo"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114C236454;
	Mon, 27 Oct 2025 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544890; cv=none; b=rv9tC+n7qvNHkms8GwXwf1WlP5RNA3p5S3kee0bTXkg5kgyrbyKkI4Nmjp6vGtyIBPMU/z7obInsYPv4ev6aO2K0v9QouK+YPqtRNJYIwaje37Xm+YVTxrKwHYs6A6eXeLX8FASTL9qT1A6lVZZxI5rA6YorVpxlqik993ogHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544890; c=relaxed/simple;
	bh=/uSTh9jnNHxZr8l0AmC9H14h3So3FspudvBB4vT9/A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCQft3jH5XOZ7htdBUdnHBrBuK8ZBcOwZhDJdqWHIqc1p6EyAwNyZ9ZOLzydSmElxYadM7ynbbClkFYXdGS7BchovcOYWJ1xxk4wx829a+7ql8hLjRdGT64LHpwgwDlBx6DPt1krPQpS29tDgLOwKlXiBbRelIKuSiN25mCY4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=ToPggUCo; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=gaYFdwY891p4uuTCbTw+bn5GIMXkeSKRlnDMN0uMIbE=; b=ToPggUCoz7Enp03xT9VVYhZwRd
	DctaY9+fMIm0Jilb2UDw/quz1ygSP/8HF+mp9o8kCfX8GX1P/HTMDJ+UpjisBVIgPVJOnSadvCuHB
	UL3bnQ2YIRWTEkCMge+FLHnEQKvv9gFbm+LYbTRCMSuv32HoiFd3vzE8GjbNWcugqcmecS6zeIloH
	ZthKdMOBOov2OM7RJ72b1v42dUjzCi/DFXdTlB6GCrIO1XAHFUdHQF2yBsolPJrvuFyg/Mrl/gQT4
	TLemeuJIuny0dJy+hfn+UsWXm45JNlpcaYlBa50wuqRbHD8C5xScwBeP3bG6LSnI7zVVac5nYK7ZX
	bWQY/v5Q==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vDGI5-006Wiq-2q;
	Mon, 27 Oct 2025 07:01:13 +0100
Date: Mon, 27 Oct 2025 07:01:13 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <aP8KqZ1hlqfQVPii@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
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
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-10-27 11:20, Troy Mitchell wrote:
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
> default m if ARCH_SPACEMIT?

As explained here, this is equivalent:
https://lore.kernel.org/spacemit/CAJM55Z_BzfRo5aKf2VrneTymSizwDQq6OfMK_LNgyoGjp43K8Q@mail.gmail.com/

But I can make a v5 to change that, if it's the preferred form on the 
SpacemiT side.

> Or default ARCH_SPACEMIT?
> I believe that reboot and shutdown are actually essential functionalities,
> so it might make more sense: default ARCH_SPACEMIT?

That was already changed in v3, following a request on v2:
https://lore.kernel.org/spacemit/CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com/

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

