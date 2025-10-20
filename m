Return-Path: <linux-pm+bounces-36448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F363BEF513
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 06:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA5C1895AF2
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 04:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F242BF3CA;
	Mon, 20 Oct 2025 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="P0I2b8/3"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784EF29A326;
	Mon, 20 Oct 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936158; cv=none; b=GLrFf1epIOl5mHULn+XDenRtb1yssx6FVcO1T/brFWDbEryHpfLc+GgQekmdyewKkWgwpcZUJPuTwQDiBvTQPp4ts5vQwEh//M2SONU092xm06uSPOpfYp+FBBcz2VXp6iUTmFcHzO+vexU3WfecTNHY2AW6RiF+aiHNoRzQNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936158; c=relaxed/simple;
	bh=kBn/BaHmnqL5QFvolLwa2gumlyATIfAmmraHylEbFlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCNwNGnudtenzeC6nUn9SLuxQAZBIa+2a8SWElI6OEVo5VHGdLIa8AwZWB2LI2z84N5YDzlXBJnh8YdVFcP/ph/CPH3qH8uwXhYGf8tXRbtoAi/1m8uR5TPKHjtl1CUo4pSP6yAqtaKWhp/jQoA+M/o+qSH9xDmOqCVkKTFhmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=P0I2b8/3; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=Pc2eH0TYEK2vWDWx1vyxaWQbgLYdq9hSWdj4iutTehQ=; b=P0I2b8/3fP6rXv5OquxBSDwB5v
	kzi4c80GhQUhRCcf0eJ+dHd7lCsijsbIRS0su2D7p7N1YF93KfdSbet9zwTykv+wLDSe/K/aj4wj5
	DCmNClBOneDOrCUKZiU/Uy5+dXnTxo5nXb53FrNNXU02VHwt4WnCJYc1EmIa3Kyq5M9iBmyliZT66
	U81EkDLNZfCLK9xx0D6i3ROPCQ5e9XR9oDJ/hmmYX6tEIzOzZyeu9mL51Z6bTuIionOpggDZ6fSZZ
	nNntRSj4g0Vg18jhAJfmjEOqmgtcGd8/BCFX+7S9lx4ku8DO/HAygf3tOelNL3+Rk7rlq/Dqo4/bG
	d7z9wFkA==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vAhvm-00E83f-16;
	Mon, 20 Oct 2025 06:55:38 +0200
Date: Mon, 20 Oct 2025 06:55:37 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <aPXAyeDC7YXAketm@aurel32.net>
Mail-Followup-To: Emil Renner Berthing <emil.renner.berthing@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
References: <20251019191519.3898095-1-aurelien@aurel32.net>
 <20251019191519.3898095-2-aurelien@aurel32.net>
 <CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Emil,

On 2025-10-19 22:53, Emil Renner Berthing wrote:
> On Sun, 19 Oct 2025 at 22:34, Aurelien Jarno <aurelien@aurel32.net> wrote:
> >
> > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> > chip, which is commonly paired with the SpacemiT K1 SoC.
> >
> > The SpacemiT P1 support is implemented as a MFD driver, so the access is
> > done directly through the regmap interface. Reboot or poweroff is
> > triggered by setting a specific bit in a control register, which is
> > automatically cleared by the hardware afterwards.
> >
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> > v2:
> >  - Rebase onto v6.18-rc1
> >  - Use dev_err_probe() to simplify the code
> >  - Fix indentation of patch 1
> >  - Collect Acked-by and Tested-by
> >
> >  drivers/power/reset/Kconfig              |  9 +++
> >  drivers/power/reset/Makefile             |  1 +
> >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
> >  3 files changed, 98 insertions(+)
> >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> >
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 8248895ca9038..063202923d95d 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> >         help
> >           Reboot support for the KEYSTONE SoCs.
> >
> > +config POWER_RESET_SPACEMIT_P1
> > +       bool "SpacemiT P1 poweroff and reset driver"
> 
> The driver code looks to be written to work as a module, but here it
> says "bool" not "tristate".

I have just tested to build it as a module, and it indeed works that 
way. I'll change that to tristate in the next version.

> > +       depends on ARCH_SPACEMIT || COMPILE_TEST
> > +       select MFD_SPACEMIT_P1
> > +       default ARCH_SPACEMIT
> 
> If it does work as a module I'd prefer "default m" here.

Do you mean "default m" or "default m if ARCH_SPACEMIT"?

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

