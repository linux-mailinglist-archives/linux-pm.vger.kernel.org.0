Return-Path: <linux-pm+bounces-5505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6988E166
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 14:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCFD1C2A3FF
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4C1586DC;
	Wed, 27 Mar 2024 12:16:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144A158218;
	Wed, 27 Mar 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541817; cv=none; b=Qt2X8mpH52RMEt6Xks8Aho9aD33ltbVtNTO//Vlk8GNl8116EzPVuiBliDqkdkfYNL/I6MZQJuhhdPZnNfHJ3uwyu8ByK4Kn+/+IM7jFPfFPdiG+Lcu5V6BmmroZDAuwg1lnJ3/wr+AV6GERDLRYAkmoIoR96eMfiCrIZci6CWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541817; c=relaxed/simple;
	bh=hDcbCqoUsh/uSrDxeLcfI7VVyJoLbnAOut0GvCf9SsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwoBzdwBG+Ujd8RpmAouN5eaz4U43VL9wz0EetRWouwMlvy+a+vDQO8qUtHUZPHDnbXmbYPqnBk134ofXLil0nuFudaOFd1CCsljAInV+aGt0p0/R1ME9lcsr0JCX/thjGNwKYqJHBa6h+RGEJTRYBqqMns/oX+6aYjebwRkdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41CF52F4;
	Wed, 27 Mar 2024 05:17:26 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B1763F694;
	Wed, 27 Mar 2024 05:16:49 -0700 (PDT)
Date: Wed, 27 Mar 2024 12:16:40 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Brandon Cheo Fusi
 <fusibrandon13@gmail.com>, Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>, Chris Morgan
 <macroalpha82@gmail.com>, Ryan Walklin <ryan@testtoast.com>, Mark Rutland
 <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Yangtao
 Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 6/8] cpufreq: sun50i: Add H616 support
Message-ID: <20240327121640.11bb5684@minigeek.lan>
In-Reply-To: <ZgQJ1N3-JeSFwZJb@bogus>
References: <20240326114743.712167-1-andre.przywara@arm.com>
	<20240326114743.712167-7-andre.przywara@arm.com>
	<65e86555-761e-4e26-8778-e2452876b5e4@sholland.org>
	<20240327114608.2ffca28e@minigeek.lan>
	<ZgQJ1N3-JeSFwZJb@bogus>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 11:58:12 +0000
Sudeep Holla <sudeep.holla@arm.com> wrote:

Hi Sudeep,

> On Wed, Mar 27, 2024 at 11:46:08AM +0000, Andre Przywara wrote:
> > On Tue, 26 Mar 2024 22:46:27 -0500
> > Samuel Holland <samuel@sholland.org> wrote:
> > 
> > Hi Samuel,
> >   
> > > On 3/26/24 06:47, Andre Przywara wrote:  
> > > > From: Martin Botka <martin.botka@somainline.org>
> > > > 
> > > > The Allwinner H616/H618 SoCs have different OPP tables per SoC version
> > > > and die revision. The SoC version is stored in NVMEM, as before, though
> > > > encoded differently. The die revision is in a different register, in the
> > > > SRAM controller. Firmware already exports that value in a standardised
> > > > way, through the SMCCC SoCID mechanism. We need both values, as some chips
> > > > have the same SoC version, but they don't support the same frequencies and
> > > > they get differentiated by the die revision.
> > > > 
> > > > Add the new compatible string and tie the new translation function to
> > > > it. This mechanism not only covers the original H616 SoC, but also its
> > > > very close sibling SoCs H618 and H700, so add them to the list as well.
> > > > 
> > > > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > ---
> > > >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 61 ++++++++++++++++++++++++++
> > > >  1 file changed, 61 insertions(+)
> > > > 
> > > > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > > index bd170611c7906..f9e9fc340f848 100644
> > > > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > > @@ -10,6 +10,7 @@
> > > >  
> > > >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > >  
> > > > +#include <linux/arm-smccc.h>
> > > >  #include <linux/cpu.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/nvmem-consumer.h>
> > > > @@ -46,14 +47,71 @@ static u32 sun50i_h6_efuse_xlate(u32 speedbin)
> > > >  		return 0;
> > > >  }
> > > >  
> > > > +/*
> > > > + * Judging by the OPP tables in the vendor BSP, the quality order of the
> > > > + * returned speedbin index is 4 -> 0/2 -> 3 -> 1, from worst to best.
> > > > + * 0 and 2 seem identical from the OPP tables' point of view.
> > > > + */
> > > > +static u32 sun50i_h616_efuse_xlate(u32 speedbin)
> > > > +{
> > > > +	int ver_bits = arm_smccc_get_soc_id_revision();    
> > > 
> > > This needs a Kconfig dependency on ARM_SMCCC_SOC_ID.  
> > 
> > That was my first impulse as well, but it's actually not true:
> > ARM_SMCCC_SOC_ID just protects the sysfs export code, not this function
> > here. That does just depend on HAVE_ARM_SMCCC_DISCOVERY, which gets
> > selected by ARM_GIC_V3, which gets selected by CONFIG_ARM64. So the
> > arm64 kernel is safe.  
> 
> It is safe to add the dependency explicitly so that if GICV3 decides to drop
> it, this won't be affected. Thoughts ?

That would be one possibility, but since there are patches on the
list[1] that use this driver for the Allwinner D1 with RISC-V cores,
this would need to be revisited then anyway. 

> > Now apart from ARM(32) (where the situation seems a bit more complex) I
> > just realise that this would torpedo Brandon's D1 efforts, so I need to
> > add this change I played with to provide an alternative:
> >
> > static int get_soc_id_revision(void)
> > {
> > #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> > 	return arm_smccc_get_soc_id_revision();
> > #else
> > 	/* Return the value for the worse die revision, to be safe. */
> > 	return 2;
> > #endif
> > }
> > 
> > Does that look acceptable, despite the #ifdef?
> >   
> 
> if(IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)) instead ?

Well, but this would rely on at least the prototype to be visible,
right? And then on the toolchain to optimise away the call, so that the
symbol doesn't even appear in the object file?
So would this work for the RISC-V case?

Cheers,
Andre

[1]
https://lore.kernel.org/linux-sunxi/20231218110543.64044-1-fusibrandon13@gmail.com/T/#t

