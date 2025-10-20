Return-Path: <linux-pm+bounces-36446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E4BEEEC5
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 02:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253013B7A27
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520554C92;
	Mon, 20 Oct 2025 00:05:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A27184E;
	Mon, 20 Oct 2025 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760918744; cv=none; b=nC+FDJbSGha+89GMz9tPM9eyL83LWbZVE2fXAlPge2IEYgTAnld1H6/bci64syIkNv0AXYGcO3h/NjuJfz1Y1Rh31HxTSPgnUrMc341VI4FKDxx6X4PpSh5J98p/ajlP03e7q2X0Stv+XcyK7ou39Jg85qjrWnT5ZrXzgGCXvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760918744; c=relaxed/simple;
	bh=hJLTcllLmRKGjPAn9fdLk6a7sjgVkoZ3O9xsU1vvFno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVJIQTrBKzHY/SlbIuYUVjlD++Vz8peMg/pAIchJhPO+pb/QryrYLKevDpNy/AkMcVHEtYNCbwLSpOrH8M6b91Ah+A2hIMe3dzVsTEs4ztCrnZZpdxJK0/asIfCfyWX40LUzrOWr/xicghD6T+aX1XN2VwagHUvsA1TzTlOxtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B60C6340F21;
	Mon, 20 Oct 2025 00:05:41 +0000 (UTC)
Date: Mon, 20 Oct 2025 08:05:37 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <20251020000537-GYC1506524@gentoo.org>
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

Hi Aurelien, 

On 22:53 Sun 19 Oct     , Emil Renner Berthing wrote:
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
> 
> > +       depends on ARCH_SPACEMIT || COMPILE_TEST
> > +       select MFD_SPACEMIT_P1
> > +       default ARCH_SPACEMIT
> 
> If it does work as a module I'd prefer "default m" here.
> 
I second this, you can add my RoB if with it fixed

Reviewed-by: Yixun Lan <dlan@gentoo.org>

-- 
Yixun Lan (dlan)

