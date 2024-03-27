Return-Path: <linux-pm+bounces-5503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662288DD09
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A361C284D5
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FF112CDBF;
	Wed, 27 Mar 2024 12:01:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F5F12BEA0;
	Wed, 27 Mar 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540889; cv=none; b=GNNTk6N0Xiu3IblT4rGz1JyUCVgXVKelMjkaLDUfIXAdwrL856H1qQ8upb7RqzK1nITHbfLftmK+JP+AxtlyQkK6bIitcv9D5KH1B6v4d4E+rQsuzL1neVFnravqIWyix/VwHxb7zviPLaURrxOIGlznKmY17VwtBCaMOp2Mfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540889; c=relaxed/simple;
	bh=dnDruskvW+GxkU2E2YCRG7FXCI3+PwKJTemu2mwTB2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIhN+HqNUJ4PMHZ4z76eysvA14k6DQU5G+NdNlLz3OT5ZEq6EZb5wroX9ZBroPoiXK0LP3JsSIsGU8W+prJkhXOdabr9Rtgy8EFYRfuqn8eoxeZhahq8sRETaKG8R+LZzV7kFaOBNwdAnAt9MvkZTqnB0gcjLi/2ccx+AAT/e78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B30882F4;
	Wed, 27 Mar 2024 05:02:00 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D02733F694;
	Wed, 27 Mar 2024 05:01:23 -0700 (PDT)
Date: Wed, 27 Mar 2024 12:01:21 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 6/8] cpufreq: sun50i: Add H616 support
Message-ID: <ZgQKke6de4_5TMWC@bogus>
References: <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-7-andre.przywara@arm.com>
 <65e86555-761e-4e26-8778-e2452876b5e4@sholland.org>
 <20240327114608.2ffca28e@minigeek.lan>
 <ZgQJ1N3-JeSFwZJb@bogus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgQJ1N3-JeSFwZJb@bogus>

On Wed, Mar 27, 2024 at 11:58:12AM +0000, Sudeep Holla wrote:
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

Ignore this as this will block the ARM(32) build of the driver which I suppose
is needed as well.

--
Regards,
Sudeep

