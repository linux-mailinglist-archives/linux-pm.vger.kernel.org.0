Return-Path: <linux-pm+bounces-6449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775838A5DF7
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050381F21F55
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 23:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DC158859;
	Mon, 15 Apr 2024 23:00:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8B0157A7D;
	Mon, 15 Apr 2024 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713222054; cv=none; b=IOp0pw37cnQQ9tV2reHNCEunLYOJBeNRO4D0bO3BoHF+nbQ8ZSY8/jLyLFf2dv27vXsYvQdShilTksHR8K4l0Gjn45uwrh4MdpRMijb6orrABdksdl94tNG6FWERVgO7b3QAW40V9B1/sTqu9qfUOPmH/bS7K3msZmZ0S/huSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713222054; c=relaxed/simple;
	bh=SaDLEK/GJzA5gn1n+hQFjSwklsdC8xkcNf7+K1rWP/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw5Opo78ARExbSLyjzSYePueXErYZ1YZ9HVhmvtNO95GhKz2U5YP2g7ObKlcIWudY6QqV+Qu5oc6LmWpBlD2j+94vXZrvI/7s9P0DUSe0KLzKUviz0GSqu/YF+R6aGuSL+/x5dMUt2DkcrG42K0KMMZPmZ0bPXcOhFHB8QABZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 884652F4;
	Mon, 15 Apr 2024 16:01:19 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ED923F792;
	Mon, 15 Apr 2024 16:00:49 -0700 (PDT)
Date: Tue, 16 Apr 2024 00:00:41 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH 1/1] clk: sunxi-ng: h6-r: add GPU power domain
Message-ID: <20240416000041.47a4ecb5@minigeek.lan>
In-Reply-To: <CAPDyKFptmNcbOTEs052yLGLxObWy7975fgpM3Kfg1TjMPVmeyA@mail.gmail.com>
References: <20240225160616.15001-1-andre.przywara@arm.com>
 <20240225160616.15001-2-andre.przywara@arm.com>
 <CAPDyKFptmNcbOTEs052yLGLxObWy7975fgpM3Kfg1TjMPVmeyA@mail.gmail.com>
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

On Mon, 8 Apr 2024 14:55:04 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

Hi Ulf,

many thanks for having a look!

> On Sun, 25 Feb 2024 at 17:08, Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > The Allwinner H616 features register 0x7010254 in the PRCM MMIO frame,
> > where bit 0 needs to be cleared to enable operation of the Mali GPU.
> > With this bit set (the reset default), any access to the Mali registers
> > hangs the bus and thus the whole system. The BSP code clears this bit
> > in U-Boot and their kernel never touches it again.  
> 
> Is the bit representing a reset or power-rail? If it's a reset, it's
> probably better to model it like that.

So there is no real documentation about this bit (or the whole "PRCM"
device), but we are pretty sure it's a power rail and not a reset. There
are other similar rails in neighbouring registers, and some BSP code
hints at those being power gates. Samuel once condensed this to:
https://github.com/crust-firmware/crust/blob/master/platform/h6/include/platform/prcm.h

> > Register a power-domain device to control this bit. Since we claim this
> > MMIO region in the H6 R-CCU driver, add the code here, so that we don't
> > need to artificially split the MMIO range in the DT.
> > Since there seems to be at least one other register with similar behaviour
> > nearby (0x7010260), make the power domain take one cell, even though we
> > only support domain #0 for now.  
> 
> Seems like we need some updated DT bindings too to cover this?

That's right (and I mentioned this in the cover letter), but I omitted
this from this first RFC post. I will include binding patches in the v1
post.

> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 84 ++++++++++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > index 02b28cfc5525e..363fb7a71e9f5 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > @@ -4,9 +4,11 @@
> >   */
> >
> >  #include <linux/clk-provider.h>
> > +#include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> >
> >  #include "ccu_common.h"
> >  #include "ccu_reset.h"
> > @@ -217,6 +219,86 @@ static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
> >         .num_resets     = ARRAY_SIZE(sun50i_h616_r_ccu_resets),
> >  };
> >
> > +#define        PD_H616_GPU_REG                 0x254
> > +
> > +struct sun50i_h616_ppu_pd {
> > +       struct generic_pm_domain        genpd;
> > +       void __iomem                    *base;
> > +};
> > +
> > +#define to_sun50i_h616_ppu_pd(_genpd) \
> > +       container_of(_genpd, struct sun50i_h616_ppu_pd, genpd)
> > +
> > +static bool sun50i_h616_ppu_power_status(const struct sun50i_h616_ppu_pd *pd)
> > +{
> > +       return !readl(pd->base + PD_H616_GPU_REG);
> > +}
> > +
> > +static int sun50i_h616_ppu_pd_set_power(const struct sun50i_h616_ppu_pd *pd,
> > +                                       bool power_on)
> > +{
> > +       if (power_on)
> > +               writel(0, pd->base + PD_H616_GPU_REG);
> > +       else
> > +               writel(1, pd->base + PD_H616_GPU_REG);
> > +
> > +       return 0;
> > +}
> > +
> > +static int sun50i_h616_ppu_pd_power_on(struct generic_pm_domain *genpd)
> > +{
> > +       const struct sun50i_h616_ppu_pd *pd = to_sun50i_h616_ppu_pd(genpd);
> > +
> > +       return sun50i_h616_ppu_pd_set_power(pd, true);
> > +}
> > +
> > +static int sun50i_h616_ppu_pd_power_off(struct generic_pm_domain *genpd)
> > +{
> > +       const struct sun50i_h616_ppu_pd *pd = to_sun50i_h616_ppu_pd(genpd);
> > +
> > +       return sun50i_h616_ppu_pd_set_power(pd, false);
> > +}
> > +
> > +static int sun50i_h616_register_ppu(struct platform_device *pdev,
> > +                                   void __iomem *base)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct genpd_onecell_data *ppu;
> > +       struct sun50i_h616_ppu_pd *pd;
> > +       int ret;
> > +
> > +       pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> > +       if (!pd)
> > +               return -ENOMEM;
> > +
> > +       ppu = devm_kzalloc(dev, sizeof(*ppu), GFP_KERNEL);
> > +       if (!ppu)
> > +               return -ENOMEM;
> > +
> > +       ppu->domains = devm_kzalloc(dev, sizeof(*ppu->domains), GFP_KERNEL);
> > +       if (!ppu->domains)
> > +               return -ENOMEM;
> > +
> > +       ppu->num_domains = 1;
> > +       pd->genpd.name          = "GPU";
> > +       pd->genpd.power_off     = sun50i_h616_ppu_pd_power_off;
> > +       pd->genpd.power_on      = sun50i_h616_ppu_pd_power_on;
> > +       pd->base                = base;
> > +
> > +       ret = pm_genpd_init(&pd->genpd, NULL, !sun50i_h616_ppu_power_status(pd));
> > +       if (ret) {
> > +               dev_warn(dev, "Failed to add GPU power domain: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ppu->domains[0] = &pd->genpd;
> > +       ret = of_genpd_add_provider_onecell(dev->of_node, ppu);
> > +       if (ret)
> > +               dev_warn(dev, "Failed to add provider: %d\n", ret);
> > +
> > +       return 0;
> > +}
> > +
> >  static int sun50i_h6_r_ccu_probe(struct platform_device *pdev)
> >  {
> >         const struct sunxi_ccu_desc *desc;
> > @@ -230,6 +312,8 @@ static int sun50i_h6_r_ccu_probe(struct platform_device *pdev)
> >         if (IS_ERR(reg))
> >                 return PTR_ERR(reg);
> >
> > +       sun50i_h616_register_ppu(pdev, reg);
> > +
> >         return devm_sunxi_ccu_probe(&pdev->dev, reg, desc);
> >  }
> >  
> 
> In general (for maintenance reasons) it's a good idea to put genpd
> providers under drivers/pmdomain/*. It looks like that should work
> this case too, right?

Well, this question was the main reason to mark this as an RFC.
This patch here lives in the R-CCU driver, since this device is using
the same MMIO frame. The manual calls this device "PRCM" (Power Reset
Clock Management), so this covers more than just those essential
clocks, but those were all we needed and knew about until now.

For simplicity (since this is indeed just a single bit to flip), I
put the code into this existing R-CCU driver. This avoids splitting up
the MMIO frame (at some potentially arbitrary point), and avoids the
churn for an extra driver and DT node.

Now just last week we found another separate component in this PRCM: an
NMI interrupt controller[1], for which we already have a separate
binding (and driver) in the tree, so we split this MMIO range
up anyway.
So that means at this point we might as well make this a separate
driver, tied to a separate DT compatible string. I originally made a
version of this driver as a separate file in drivers/pmdomain, so will
just dig this out and post it.

Unless people disagree, then please let me know.

Thanks for the comments!

Cheers,
Andre

