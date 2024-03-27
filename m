Return-Path: <linux-pm+bounces-5500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA32888DCC9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471161F2ABE9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EA129E82;
	Wed, 27 Mar 2024 11:46:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139A4129E77;
	Wed, 27 Mar 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539990; cv=none; b=j3eRTww/lwHX9kiJjK6/hdKI80+K6bON7HvY7ijxRzd40cpGslK1nhlSzKnSoMJ+wXK5ZPc10IeFMPXcox5rtrwc2TJqFbbPQsMFH02UNhjQQJTjxn+SbgXa4444trcQD1Z507/W55vmuPBaqVo3BQyoh9NUm/1cpOmrjfFAGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539990; c=relaxed/simple;
	bh=Ul4yG9uNhoPlqOLn8b/P5MHv0W7DsyjvWSzXRltK4I8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBS6tQaTE8oF8KGefs+vkAiteKvvZpmzHGxTRa+r1KCeYKXWnHKte8DqsCVpSXWqOqL7DINH2389SlKxSF+x8PBwaTqkRr2cl1Iietkt4xBcPxVpQoIyhENfi8fInGOO8TuJW+Z1pKTk4GnNe0O1enLkrPbkwMQoWdsdHqqJco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75A7D2F4;
	Wed, 27 Mar 2024 04:47:01 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77E033F694;
	Wed, 27 Mar 2024 04:46:24 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:46:08 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Brandon
 Cheo Fusi <fusibrandon13@gmail.com>, Martin Botka
 <martin.botka@somainline.org>, Martin Botka <martin.botka1@gmail.com>,
 Chris Morgan <macroalpha82@gmail.com>, Ryan Walklin <ryan@testtoast.com>,
 Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
 <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 6/8] cpufreq: sun50i: Add H616 support
Message-ID: <20240327114608.2ffca28e@minigeek.lan>
In-Reply-To: <65e86555-761e-4e26-8778-e2452876b5e4@sholland.org>
References: <20240326114743.712167-1-andre.przywara@arm.com>
	<20240326114743.712167-7-andre.przywara@arm.com>
	<65e86555-761e-4e26-8778-e2452876b5e4@sholland.org>
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

On Tue, 26 Mar 2024 22:46:27 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> On 3/26/24 06:47, Andre Przywara wrote:
> > From: Martin Botka <martin.botka@somainline.org>
> > 
> > The Allwinner H616/H618 SoCs have different OPP tables per SoC version
> > and die revision. The SoC version is stored in NVMEM, as before, though
> > encoded differently. The die revision is in a different register, in the
> > SRAM controller. Firmware already exports that value in a standardised
> > way, through the SMCCC SoCID mechanism. We need both values, as some chips
> > have the same SoC version, but they don't support the same frequencies and
> > they get differentiated by the die revision.
> > 
> > Add the new compatible string and tie the new translation function to
> > it. This mechanism not only covers the original H616 SoC, but also its
> > very close sibling SoCs H618 and H700, so add them to the list as well.
> > 
> > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 61 ++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index bd170611c7906..f9e9fc340f848 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -10,6 +10,7 @@
> >  
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> > +#include <linux/arm-smccc.h>
> >  #include <linux/cpu.h>
> >  #include <linux/module.h>
> >  #include <linux/nvmem-consumer.h>
> > @@ -46,14 +47,71 @@ static u32 sun50i_h6_efuse_xlate(u32 speedbin)
> >  		return 0;
> >  }
> >  
> > +/*
> > + * Judging by the OPP tables in the vendor BSP, the quality order of the
> > + * returned speedbin index is 4 -> 0/2 -> 3 -> 1, from worst to best.
> > + * 0 and 2 seem identical from the OPP tables' point of view.
> > + */
> > +static u32 sun50i_h616_efuse_xlate(u32 speedbin)
> > +{
> > +	int ver_bits = arm_smccc_get_soc_id_revision();  
> 
> This needs a Kconfig dependency on ARM_SMCCC_SOC_ID.

That was my first impulse as well, but it's actually not true:
ARM_SMCCC_SOC_ID just protects the sysfs export code, not this function
here. That does just depend on HAVE_ARM_SMCCC_DISCOVERY, which gets
selected by ARM_GIC_V3, which gets selected by CONFIG_ARM64. So the
arm64 kernel is safe.
Now apart from ARM(32) (where the situation seems a bit more complex) I
just realise that this would torpedo Brandon's D1 efforts, so I need to
add this change I played with to provide an alternative:

static int get_soc_id_revision(void)
{
#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
	return arm_smccc_get_soc_id_revision();
#else
	/* Return the value for the worse die revision, to be safe. */
	return 2;
#endif
}

Does that look acceptable, despite the #ifdef?

Cheers,
Andre


> 
> Regards,
> Samuel
> 
> > +	u32 value = 0;
> > +
> > +	switch (speedbin & 0xffff) {
> > +	case 0x2000:
> > +		value = 0;
> > +		break;
> > +	case 0x2400:
> > +	case 0x7400:
> > +	case 0x2c00:
> > +	case 0x7c00:
> > +		if (ver_bits != SMCCC_RET_NOT_SUPPORTED &&
> > ver_bits <= 1) {
> > +			/* ic version A/B */
> > +			value = 1;
> > +		} else {
> > +			/* ic version C and later version */
> > +			value = 2;
> > +		}
> > +		break;
> > +	case 0x5000:
> > +	case 0x5400:
> > +	case 0x6000:
> > +		value = 3;
> > +		break;
> > +	case 0x5c00:
> > +		value = 4;
> > +		break;
> > +	case 0x5d00:
> > +		value = 0;
> > +		break;
> > +	case 0x6c00:
> > +		value = 5;
> > +		break;
> > +	default:
> > +		pr_warn("sun50i-cpufreq-nvmem: unknown speed bin
> > 0x%x, using default bin 0\n",
> > +			speedbin & 0xffff);
> > +		value = 0;
> > +		break;
> > +	}
> > +
> > +	return value;
> > +}
> > +
> >  static struct sunxi_cpufreq_data sun50i_h6_cpufreq_data = {
> >  	.efuse_xlate = sun50i_h6_efuse_xlate,
> >  };
> >  
> > +static struct sunxi_cpufreq_data sun50i_h616_cpufreq_data = {
> > +	.efuse_xlate = sun50i_h616_efuse_xlate,
> > +};
> > +
> >  static const struct of_device_id cpu_opp_match_list[] = {
> >  	{ .compatible = "allwinner,sun50i-h6-operating-points",
> >  	  .data = &sun50i_h6_cpufreq_data,
> >  	},
> > +	{ .compatible = "allwinner,sun50i-h616-operating-points",
> > +	  .data = &sun50i_h616_cpufreq_data,
> > +	},
> >  	{}
> >  };
> >  
> > @@ -230,6 +288,9 @@ static struct platform_driver
> > sun50i_cpufreq_driver = { 
> >  static const struct of_device_id sun50i_cpufreq_match_list[] = {
> >  	{ .compatible = "allwinner,sun50i-h6" },
> > +	{ .compatible = "allwinner,sun50i-h616" },
> > +	{ .compatible = "allwinner,sun50i-h618" },
> > +	{ .compatible = "allwinner,sun50i-h700" },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);  
> 
> 


