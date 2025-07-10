Return-Path: <linux-pm+bounces-30648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A08B00F23
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BDC582164
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAF22C08C1;
	Thu, 10 Jul 2025 22:55:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E228B7E9;
	Thu, 10 Jul 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188144; cv=none; b=WeWhrCt60adtUEEEhZYjRyo4uRwC15f9pYIhrUBeXtUJ2QAXtASGDsz+FWaIJPSchgyH/KPTBS0qhYhS4NO92Yr0692LSSTF3ZQQXjCV/UbUJuo0G053JJCADZ/iuwayS4SQ98JRSg5+RA5RYkcoVLMb0Qng33qt7Ma+rVAtxuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188144; c=relaxed/simple;
	bh=uFoSNbcHpZYkHGdRVsmEJJdE/7PJ2Bcwmfu9OqOhPos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhXdNbmPhBGrAzxFPZJasPsNM64l7OycIE3l0BmxawqRT9yncHbi4HMwetNzkdFAg9hagVrMG4Z46go5XfXOn9rU9PLwyuGVtlYcYXjo/34xoI6xaIe+U7WwpGR7ASeJEcK2/uVKia4YAH9y9jz0DjniCkBHxym533jG9Im+hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8A81C0A;
	Thu, 10 Jul 2025 15:55:23 -0700 (PDT)
Received: from [10.43.3.235] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B5C33F6A8;
	Thu, 10 Jul 2025 15:55:32 -0700 (PDT)
Message-ID: <3f003164-f77d-4357-a21c-14d9ec16e46a@arm.com>
Date: Thu, 10 Jul 2025 23:55:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] pmdomain: sunxi: add driver for Allwinner A523's
 PCK-600 power controller
To: wens@kernel.org
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250709155343.3765227-1-wens@kernel.org>
 <20250709155343.3765227-4-wens@kernel.org>
 <043e5826-b68a-4289-bf22-79587bcdad26@arm.com>
 <CAGb2v65WsPmAtUZRbf5Cu3Pb6Oi+dGH1RH3HhnZLmpJgh5Nu1g@mail.gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <CAGb2v65WsPmAtUZRbf5Cu3Pb6Oi+dGH1RH3HhnZLmpJgh5Nu1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 10/07/2025 05:14, Chen-Yu Tsai wrote:
> On Thu, Jul 10, 2025 at 7:46 AM Andre Przywara <andre.przywara@arm.com> wrote:
>>
>> Hi Chen-Yu,
>>
>> thanks for posting this! This is a quick first view, haven't compared
>> against the BSP bits yet....
>>
>> On 09/07/2025 16:53, Chen-Yu Tsai wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> Allwinner A523 family has a second power controller, named PCK-600 in
>>> the datasheets and BSP. It is likely based on ARM's PCK-600 hardware
>>> block, with some additional delay controls. The only documentation for
>>> this hardware is the BSP driver. The standard registers defined in ARM's
>>> Power Policy Unit Architecture Specification line up. Some extra delay
>>> controls are found in the reserved range of registers.
>>>
>>> Add a driver for this power controller. Delay control register values
>>> and power domain names are from the BSP driver.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>    drivers/pmdomain/sunxi/Kconfig         |   8 +
>>>    drivers/pmdomain/sunxi/Makefile        |   1 +
>>>    drivers/pmdomain/sunxi/sun55i-pck600.c | 225 +++++++++++++++++++++++++
>>>    3 files changed, 234 insertions(+)
>>>    create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
>>>
>>> diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kconfig
>>> index 43eecb3ea981..3e2b77cd9a2b 100644
>>> --- a/drivers/pmdomain/sunxi/Kconfig
>>> +++ b/drivers/pmdomain/sunxi/Kconfig
>>> @@ -18,3 +18,11 @@ config SUN50I_H6_PRCM_PPU
>>>          Say y to enable the Allwinner H6/H616 PRCM power domain driver.
>>>          This is required to enable the Mali GPU in the H616 SoC, it is
>>>          optional for the H6.
>>> +
>>> +config SUN55I_PCK600
>>> +     bool "Allwinner A523 PCK-600 power domain driver"
>>
>> Any particular reason this is not tristate? The driver advertises itself
>> as a platform driver module?
> 
> Cargo-culted from the D1 PPU driver. So, no particular reason.
> 
>>> +     depends on PM
>>> +     select PM_GENERIC_DOMAINS
>>> +     help
>>> +       Say y to enable the PCK-600 power domain driver. This saves power
>>> +       when certain peripherals, such as the video engine, are idle.
>>
>> If I understand correctly, this driver is *required* to make use of
>> those peripherals, and the video engine is not even the most prominent
>> user. So regardless of the reset state of the power domain, I think the
>> wording should be changed, to make sure distributions activate this
>> option. At the moment it sounds highly optional. I wonder if we should
>> use "default y if ARCH_SUNXI" even.
> 
> Makes sense. Though this was also cargo-culted from the D1 PPU. So I
> guess I should fix both.
> 
>>> diff --git a/drivers/pmdomain/sunxi/Makefile b/drivers/pmdomain/sunxi/Makefile
>>> index c1343e123759..e344b232fc9f 100644
>>> --- a/drivers/pmdomain/sunxi/Makefile
>>> +++ b/drivers/pmdomain/sunxi/Makefile
>>> @@ -1,3 +1,4 @@
>>>    # SPDX-License-Identifier: GPL-2.0-only
>>>    obj-$(CONFIG_SUN20I_PPU)            += sun20i-ppu.o
>>>    obj-$(CONFIG_SUN50I_H6_PRCM_PPU)    += sun50i-h6-prcm-ppu.o
>>> +obj-$(CONFIG_SUN55I_PCK600)          += sun55i-pck600.o
>>> diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/sunxi/sun55i-pck600.c
>>> new file mode 100644
>>> index 000000000000..7248f6113665
>>> --- /dev/null
>>> +++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
>>> @@ -0,0 +1,225 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Allwinner PCK-600 power domain support
>>
>> Can you please mention here that this device is based on the Arm PCK-600
>> IP, as done in the commit message. And say that this is a minimal
>> implementaton, just supporting the off/on states.
>>
>> Maybe also mention the relevant documentation: the "ARM CoreLink PCK‑600
>> Power Control Kit" TRM and the "Arm Power Policy Unit" architecture
>> specification (DEN0051E).
> 
> Will do.
> 
>>> + *
>>> + * Copyright (c) 2025 Chen-Yu Tsai <wens@csie.org>
>>> + */
>>> +
>>> +#include <linux/bitfield.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/container_of.h>
>>> +#include <linux/device.h>
>>> +#include <linux/dev_printk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/iopoll.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_domain.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/string_choices.h>
>>> +
>>> +#define PPU_PWPR    0x0
>>> +#define PPU_PWSR    0x8
>>> +#define      PPU_DCDR0   0x170
>>
>> white space issue?
>>
>>> +#define PPU_DCDR1   0x174
>>> +
>>> +#define PPU_PWSR_PWR_STATUS  GENMASK(3, 0)
>>
>> Would just PPU_PWR_STATUS be a better name, since it's used by both the
>> PWPR and PWSR registers?
>>
>>> +#define PPU_POWER_MODE_ON    0x8
>>> +#define PPU_POWER_MODE_OFF   0x0
>>> +
>>> +#define PPU_REG_SIZE 0x1000
>>> +
>>> +struct sunxi_pck600_desc {
>>> +     const char * const *pd_names;
>>> +     unsigned int num_domains;
>>> +     u32 logic_power_switch0_delay_offset;
>>> +     u32 logic_power_switch1_delay_offset;
>>> +     u32 off2on_delay_offset;
>>> +     u32 device_ctrl0_delay;
>>> +     u32 device_ctrl1_delay;
>>> +     u32 logic_power_switch0_delay;
>>> +     u32 logic_power_switch1_delay;
>>> +     u32 off2on_delay;
>>
>> Is there any indication that those parameters are different between
>> different SoCs? I appreciate the idea of making this future-proof, but
>> this might be a bit premature, if all SoCs use the same values?
> 
> It's hard to tell since the BSP driver only covers the A523. I'd just
> keep this the way it is, since it makes it easier to generalize this
> to cover PCK-600 in other platforms, if such a need ever presents itself.

Yeah, fair enough, I was just curious. It's fine either way, we can 
adjust this internal detail later, if need be.

>>> +};
>>> +
>>> +struct sunxi_pck600_pd {
>>> +     struct generic_pm_domain genpd;
>>> +     struct sunxi_pck600 *pck;
>>> +     void __iomem *base;
>>> +};
>>> +
>>> +struct sunxi_pck600 {
>>> +     struct device *dev;
>>> +     struct genpd_onecell_data genpd_data;
>>> +     struct sunxi_pck600_pd pds[];
>>> +};
>>> +
>>> +#define to_sunxi_pd(gpd) container_of(gpd, struct sunxi_pck600_pd, genpd)
>>> +
>>> +static int sunxi_pck600_pd_set_power(struct sunxi_pck600_pd *pd, bool on)
>>> +{
>>> +     struct sunxi_pck600 *pck = pd->pck;
>>> +     struct generic_pm_domain *genpd = &pd->genpd;
>>> +     int ret;
>>> +     u32 val, reg;
>>> +
>>> +     val = on ? PPU_POWER_MODE_ON : PPU_POWER_MODE_OFF;
>>> +
>>> +     reg = readl(pd->base + PPU_PWPR);
>>> +     FIELD_MODIFY(PPU_PWSR_PWR_STATUS, &reg, val);
>>> +     writel(reg, pd->base + PPU_PWPR);
>>
>> Don't we need a lock here, or is this covered by the power domain framework?
> 
> AFAICT genpd has a lock for each power domain. Since each power domain has
> its own set of registers, I think we're good here.

Right, I was adittedly lazy yesterday, but now looked it up: indeed 
there is a lock around every call to genpd_power_{off,on}, so it's all good.

Cheers,
Andre


> 
> 
> Thanks
> ChenYu
> 
>> Cheers,
>> Andre
>>
>>> +
>>> +     /* push write out to hardware */
>>> +     reg = readl(pd->base + PPU_PWPR);
>>> +
>>> +     ret = readl_poll_timeout_atomic(pd->base + PPU_PWSR, reg,
>>> +                                     FIELD_GET(PPU_PWSR_PWR_STATUS, reg) == val,
>>> +                                     0, 10000);
>>> +     if (ret)
>>> +             dev_err(pck->dev, "failed to turn domain \"%s\" %s: %d\n",
>>> +                     genpd->name, str_on_off(on), ret);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int sunxi_pck600_power_on(struct generic_pm_domain *domain)
>>> +{
>>> +     struct sunxi_pck600_pd *pd = to_sunxi_pd(domain);
>>> +
>>> +     return sunxi_pck600_pd_set_power(pd, true);
>>> +}
>>> +
>>> +static int sunxi_pck600_power_off(struct generic_pm_domain *domain)
>>> +{
>>> +     struct sunxi_pck600_pd *pd = to_sunxi_pd(domain);
>>> +
>>> +     return sunxi_pck600_pd_set_power(pd, false);
>>> +}
>>> +
>>> +static void sunxi_pck600_pd_setup(struct sunxi_pck600_pd *pd,
>>> +                               const struct sunxi_pck600_desc *desc)
>>> +{
>>> +     writel(desc->device_ctrl0_delay, pd->base + PPU_DCDR0);
>>> +     writel(desc->device_ctrl1_delay, pd->base + PPU_DCDR1);
>>> +     writel(desc->logic_power_switch0_delay,
>>> +            pd->base + desc->logic_power_switch0_delay_offset);
>>> +     writel(desc->logic_power_switch1_delay,
>>> +            pd->base + desc->logic_power_switch1_delay_offset);
>>> +     writel(desc->off2on_delay, pd->base + desc->off2on_delay_offset);
>>> +}
>>> +
>>> +static int sunxi_pck600_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     const struct sunxi_pck600_desc *desc;
>>> +     struct genpd_onecell_data *genpds;
>>> +     struct sunxi_pck600 *pck;
>>> +     struct reset_control *rst;
>>> +     struct clk *clk;
>>> +     void __iomem *base;
>>> +     int i, ret;
>>> +
>>> +     desc = of_device_get_match_data(dev);
>>> +
>>> +     pck = devm_kzalloc(dev, struct_size(pck, pds, desc->num_domains), GFP_KERNEL);
>>> +     if (!pck)
>>> +             return -ENOMEM;
>>> +
>>> +     pck->dev = &pdev->dev;
>>> +     platform_set_drvdata(pdev, pck);
>>> +
>>> +     genpds = &pck->genpd_data;
>>> +     genpds->num_domains = desc->num_domains;
>>> +     genpds->domains = devm_kcalloc(dev, desc->num_domains,
>>> +                                    sizeof(*genpds->domains), GFP_KERNEL);
>>> +     if (!genpds->domains)
>>> +             return -ENOMEM;
>>> +
>>> +     base = devm_platform_ioremap_resource(pdev, 0);
>>> +     if (IS_ERR(base))
>>> +             return PTR_ERR(base);
>>> +
>>> +     rst = devm_reset_control_get_exclusive_released(dev, NULL);
>>> +     if (IS_ERR(rst))
>>> +             return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control\n");
>>> +
>>> +     clk = devm_clk_get_enabled(dev, NULL);
>>> +     if (IS_ERR(clk))
>>> +             return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
>>> +
>>> +     for (i = 0; i < desc->num_domains; i++) {
>>> +             struct sunxi_pck600_pd *pd = &pck->pds[i];
>>> +
>>> +             pd->genpd.name = desc->pd_names[i];
>>> +             pd->genpd.power_off = sunxi_pck600_power_off;
>>> +             pd->genpd.power_on = sunxi_pck600_power_on;
>>> +             pd->base = base + PPU_REG_SIZE * i;
>>> +
>>> +             sunxi_pck600_pd_setup(pd, desc);
>>> +             ret = pm_genpd_init(&pd->genpd, NULL, false);
>>> +             if (ret) {
>>> +                     dev_err_probe(dev, ret, "failed to initialize power domain\n");
>>> +                     goto err_remove_pds;
>>> +             }
>>> +
>>> +             genpds->domains[i] = &pd->genpd;
>>> +     }
>>> +
>>> +     ret = of_genpd_add_provider_onecell(dev_of_node(dev), genpds);
>>> +     if (ret) {
>>> +             dev_err_probe(dev, ret, "failed to add PD provider\n");
>>> +             goto err_remove_pds;
>>> +     }
>>> +
>>> +     return 0;
>>> +
>>> +err_remove_pds:
>>> +     for (i--; i >= 0; i--)
>>> +             pm_genpd_remove(genpds->domains[i]);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static const char * const sun55i_a523_pck600_pd_names[] = {
>>> +     "VE", "GPU", "VI", "VO0", "VO1", "DE", "NAND", "PCIE"
>>> +};
>>> +
>>> +static const struct sunxi_pck600_desc sun55i_a523_pck600_desc = {
>>> +     .pd_names = sun55i_a523_pck600_pd_names,
>>> +     .num_domains = ARRAY_SIZE(sun55i_a523_pck600_pd_names),
>>> +     .logic_power_switch0_delay_offset = 0xc00,
>>> +     .logic_power_switch1_delay_offset = 0xc04,
>>> +     .off2on_delay_offset = 0xc10,
>>> +     .device_ctrl0_delay = 0xffffff,
>>> +     .device_ctrl1_delay = 0xffff,
>>> +     .logic_power_switch0_delay = 0x8080808,
>>> +     .logic_power_switch1_delay = 0x808,
>>> +     .off2on_delay = 0x8
>>> +};
>>> +
>>> +static const struct of_device_id sunxi_pck600_of_match[] = {
>>> +     {
>>> +             .compatible     = "allwinner,sun55i-a523-pck-600",
>>> +             .data           = &sun55i_a523_pck600_desc,
>>> +     },
>>> +     {}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, sunxi_pck600_of_match);
>>> +
>>> +static struct platform_driver sunxi_pck600_driver = {
>>> +     .probe = sunxi_pck600_probe,
>>> +     .driver = {
>>> +             .name   = "sunxi-pck-600",
>>> +             .of_match_table = sunxi_pck600_of_match,
>>> +             /* Power domains cannot be removed if in use. */
>>> +             .suppress_bind_attrs = true,
>>> +     },
>>> +};
>>> +module_platform_driver(sunxi_pck600_driver);
>>> +
>>> +MODULE_DESCRIPTION("Allwinner PCK-600 power domain driver");
>>> +MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
>>> +MODULE_LICENSE("GPL");
>>
>>
> 


