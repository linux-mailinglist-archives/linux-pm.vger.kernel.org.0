Return-Path: <linux-pm+bounces-36622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE9BFA124
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 07:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7C1189A55D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 05:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85CB2EC08E;
	Wed, 22 Oct 2025 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="0Up3RLUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BC21348;
	Wed, 22 Oct 2025 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111437; cv=none; b=tDNiwXS/ksjkGJdixphHaWJtc22pr4fkesM/6FB4Dn0jnvfBHdOUVaf8fO8cwAGKJo8w8vmoxyYbdCZoX45tn/CSZscg0pxLRJXIqGS6dNoaHLzN0viKzKXt5UEQRf3aYyOlarxfTJSPkuDeja+uEHkkw27VyZkOWgaANOiAMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111437; c=relaxed/simple;
	bh=Tbwss0nXMa5BTDRSqT/ghsm1C3O/dSOWFT7FaxGnv98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXaqH8y7IDdCJU7e22hdWrKVfblvtlbByJHRVvfnpG3jB6bc/ZQDsNTpImodoyeEXP6wjnFWVbrUeVEFwqVAcg9q3CrWBOZUXL9mMdyyMZm+/0lWxtzUQ3Qr7ZKxvR0qttOf8w7DFa8SFRbWHlLRNIf+g/IBPODH7UIAjCZXp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=0Up3RLUx; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=55BpwGusbE0Q6zvfMgJToUDCvwjVEr4QNsPjBG6PryY=; b=0Up3RLUxevg5HmyNmj6t+iLeeh
	h9sk+cN5AbTz9BrLD/uDPr/dJ6yMTn4STQXIxdDeme1rpDqCwsKSqwtjgDSfuN0WhEqSGTgs9sICn
	KnndmNcMxh5kNqok6inV4Dp64af+lZ0O3tIsTW5rttpQEwqMuDua7tJl35tz6k6CZo77Zy6IXv1/c
	VpNDDm7WFADtWKZrKUI87mBA0q1axdv/MErhBQ51WFshpSAiZj84uANBFqG64Yx8a3jFIKMkXkQKL
	EpyNNauoeWcqTN6ex1m3UZviSnSQ9FW1FYLbRthOB0iYpcMFYvwxelah14H1fjC/wJ5CUg/ohlUXQ
	PKS92Ryg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vBRWp-00H5T8-33;
	Wed, 22 Oct 2025 07:36:55 +0200
Date: Wed, 22 Oct 2025 07:36:55 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Yixun Lan <dlan@gentoo.org>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <aPhtd0j6iBpqiGUQ@aurel32.net>
Mail-Followup-To: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
References: <20251021201451.1013640-1-aurelien@aurel32.net>
 <20251021201451.1013640-2-aurelien@aurel32.net>
 <20251022004830-GYB1522542@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022004830-GYB1522542@gentoo.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-10-22 08:48, Yixun Lan wrote:
> Hi Aurelien,
> 
> On 22:11 Tue 21 Oct     , Aurelien Jarno wrote:
> > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> > chip, which is commonly paired with the SpacemiT K1 SoC.
> > 
> > The SpacemiT P1 support is implemented as a MFD driver, so the access is
> > done directly through the regmap interface. Reboot or poweroff is
> > triggered by setting a specific bit in a control register, which is
> > automatically cleared by the hardware afterwards.
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > Reviewed-by: Yixun Lan <dlan@gentoo.org>
> > ---
> > v3:
> >  - Allow building as a module
> >  - Remove outdated Acked-by and Tested-by
> >  - Collect Reviewed-by
> > 
> >  drivers/power/reset/Kconfig              |  9 +++
> >  drivers/power/reset/Makefile             |  1 +
> >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
> >  3 files changed, 98 insertions(+)
> >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> > 
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 8248895ca9038..6577d73edbda4 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> >  	help
> >  	  Reboot support for the KEYSTONE SoCs.
> >  
> > +config POWER_RESET_SPACEMIT_P1
> > +	tristate "SpacemiT P1 poweroff and reset driver"
> > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> ..
> > +	select MFD_SPACEMIT_P1
> I'd suggest to use "depends on" instead of "select", the reason is that
> using "select" will sometimes ignore the dependency, considering
> the reset driver here is tightly coupled with P1, so I think it's 
> reasonable to switch to use "depends on", also refer below link
> 
> https://lxr.linux.no/#linux+v6.7.1/Documentation/kbuild/kconfig-language.rst#L144
> 
>         select should be used with care. select will force
>         a symbol to a value without visiting the dependencies.
>         By abusing select you are able to select a symbol FOO even
>         if FOO depends on BAR that is not set.
>         In general use select only for non-visible symbols
>         (no prompts anywhere) and for symbols with no dependencies.
>         That will limit the usefulness but on the other hand avoid
>         the illegal configurations all over.

Thanks for the pointer, I'll fix that in the next version. I used 
REGULATOR_SPACEMIT_P1 and RTC_DRV_SPACEMIT_P1 as examples, they'll also 
need to be fixed.

Note also that without the select, a default value has to be added to 
MFD_SPACEMIT_P1, otherwise this makes the default values on the 
regulator, rtc and reboot drivers useless.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

