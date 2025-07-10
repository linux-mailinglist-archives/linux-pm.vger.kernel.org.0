Return-Path: <linux-pm+bounces-30528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA3AFF7DB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 06:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3785562394
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 04:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0E2F3E;
	Thu, 10 Jul 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH7Pb3lI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2191F8747;
	Thu, 10 Jul 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120905; cv=none; b=nl4Pv9VE7BrowXphLA+Q4/NhGUH9enmBMoB5ESuNRLkI38cb4jVuxPbiVRXyvx1GdTI3lz7HeX8TMEorrg4dUzYQUzuf9K9YZL8cDVJYJoZANbkb6haRR6ijLzcZkYq83aouOXn7iHgD6EXuETXYdad+KZXKGX7Ce6/S/3rsU9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120905; c=relaxed/simple;
	bh=ARTKtxmOir5rmmLBFRa3OmU/j2lHpRMgK/qhHHuOKko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luFzv5tL4SIA4u/smGPJ7HqrP9Ob8+5Td2t2qw805wXNNuKY6L3UYnbsUIkCbiL/9f56tK4EUkyHN0YjykX4bhi45TWJYZYrAB5H+hxgvIXFpYsfbg7QAuJJ1tTwwU2hMPeZs0Cf8Z2IcFTH26Y9FWuQ3XeU15fr48x/kfDGVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH7Pb3lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DA6C4CEF7;
	Thu, 10 Jul 2025 04:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752120904;
	bh=ARTKtxmOir5rmmLBFRa3OmU/j2lHpRMgK/qhHHuOKko=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=mH7Pb3lIyHhd//Rhj4JWpHiUfwse2DP+b12ZR9i6aoBlAMBbeVa7sZ2E46n7Ru/fj
	 CyhJ7h56V/0eIZB04avnU/YSZ/WGMmtJWNga/pHvuWCOPdV9/aKBuy3D8TW5PEgId3
	 CjqSTs9gTHRhNbT1Hmo/rdTVO4lZYGoeMbPV9Ne+5mBcWWndzL/nsDVP86jhR2KSXv
	 M8t+u3l6Xjj1UKI+PmQf/vItnDvctmNJRrEixn3+JEBkQxvDUepNKIhtS3gB05L/At
	 VUrH/5jJIGy/xi7wTtNKBbqFPaqJRcorVQtYQn6ZunH755mf+pGSNVz66rgbX8g32P
	 2lzKkJmERadLA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32f1df58f21so4874771fa.3;
        Wed, 09 Jul 2025 21:15:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9TFwPMqfHf0bSs4c64W0nvrqik9nTqCiewv16oAvdw/OUE1YLJdddyDcQGgVnoyWjIxiTZDhTc0MNWOC1@vger.kernel.org, AJvYcCVn2qDbbju2PIftigKzwVSRm2wq1NSTKjyTyY5gIe2fONGHXJNJBtRZQ2nkIY2JBSANSm3+y/WS4+hR@vger.kernel.org, AJvYcCW9H4+kQ5fyo9DQuB10VxL+FmC7d82z8JdzaQr2OPGqHo1gv0jEeK8OTqePSFP9cophnL95Wpb0Yd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmIPvfDPgF9VCfntA/sUyF+BcUA6UvEn9zMkKdpdd//jLp7Dx
	IfpbVDHGoJd+4OWmhEmwEB5B8ALmWUJCo9JrP+rVvbz8GrGp8PlRzZmoMxEJwe4xQPhkF9V9rJF
	012PxR96O9Yqiq4dpgRCXHupz1YXiMT4=
X-Google-Smtp-Source: AGHT+IHd/yaX+Sqp/87RP8yhtv3wso+0gj3wtRChh7YZklI8P0YowqNGBnRN0oNMARoYZ86bfbf8+dq5Jpj7iubVQ4c=
X-Received: by 2002:a05:651c:f0e:b0:32a:739d:fac with SMTP id
 38308e7fff4ca-32fb2e345d2mr2833601fa.36.1752120903028; Wed, 09 Jul 2025
 21:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709155343.3765227-1-wens@kernel.org> <20250709155343.3765227-4-wens@kernel.org>
 <043e5826-b68a-4289-bf22-79587bcdad26@arm.com>
In-Reply-To: <043e5826-b68a-4289-bf22-79587bcdad26@arm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 10 Jul 2025 12:14:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v65WsPmAtUZRbf5Cu3Pb6Oi+dGH1RH3HhnZLmpJgh5Nu1g@mail.gmail.com>
X-Gm-Features: Ac12FXwfvlY2YWxEzkxFkJVP_9hOVgGw3zz-RJg-5O5SKFrgYbis0hTLsBZzYiU
Message-ID: <CAGb2v65WsPmAtUZRbf5Cu3Pb6Oi+dGH1RH3HhnZLmpJgh5Nu1g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pmdomain: sunxi: add driver for Allwinner A523's
 PCK-600 power controller
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:46=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi Chen-Yu,
>
> thanks for posting this! This is a quick first view, haven't compared
> against the BSP bits yet....
>
> On 09/07/2025 16:53, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Allwinner A523 family has a second power controller, named PCK-600 in
> > the datasheets and BSP. It is likely based on ARM's PCK-600 hardware
> > block, with some additional delay controls. The only documentation for
> > this hardware is the BSP driver. The standard registers defined in ARM'=
s
> > Power Policy Unit Architecture Specification line up. Some extra delay
> > controls are found in the reserved range of registers.
> >
> > Add a driver for this power controller. Delay control register values
> > and power domain names are from the BSP driver.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >   drivers/pmdomain/sunxi/Kconfig         |   8 +
> >   drivers/pmdomain/sunxi/Makefile        |   1 +
> >   drivers/pmdomain/sunxi/sun55i-pck600.c | 225 ++++++++++++++++++++++++=
+
> >   3 files changed, 234 insertions(+)
> >   create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
> >
> > diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kc=
onfig
> > index 43eecb3ea981..3e2b77cd9a2b 100644
> > --- a/drivers/pmdomain/sunxi/Kconfig
> > +++ b/drivers/pmdomain/sunxi/Kconfig
> > @@ -18,3 +18,11 @@ config SUN50I_H6_PRCM_PPU
> >         Say y to enable the Allwinner H6/H616 PRCM power domain driver.
> >         This is required to enable the Mali GPU in the H616 SoC, it is
> >         optional for the H6.
> > +
> > +config SUN55I_PCK600
> > +     bool "Allwinner A523 PCK-600 power domain driver"
>
> Any particular reason this is not tristate? The driver advertises itself
> as a platform driver module?

Cargo-culted from the D1 PPU driver. So, no particular reason.

> > +     depends on PM
> > +     select PM_GENERIC_DOMAINS
> > +     help
> > +       Say y to enable the PCK-600 power domain driver. This saves pow=
er
> > +       when certain peripherals, such as the video engine, are idle.
>
> If I understand correctly, this driver is *required* to make use of
> those peripherals, and the video engine is not even the most prominent
> user. So regardless of the reset state of the power domain, I think the
> wording should be changed, to make sure distributions activate this
> option. At the moment it sounds highly optional. I wonder if we should
> use "default y if ARCH_SUNXI" even.

Makes sense. Though this was also cargo-culted from the D1 PPU. So I
guess I should fix both.

> > diff --git a/drivers/pmdomain/sunxi/Makefile b/drivers/pmdomain/sunxi/M=
akefile
> > index c1343e123759..e344b232fc9f 100644
> > --- a/drivers/pmdomain/sunxi/Makefile
> > +++ b/drivers/pmdomain/sunxi/Makefile
> > @@ -1,3 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   obj-$(CONFIG_SUN20I_PPU)            +=3D sun20i-ppu.o
> >   obj-$(CONFIG_SUN50I_H6_PRCM_PPU)    +=3D sun50i-h6-prcm-ppu.o
> > +obj-$(CONFIG_SUN55I_PCK600)          +=3D sun55i-pck600.o
> > diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/=
sunxi/sun55i-pck600.c
> > new file mode 100644
> > index 000000000000..7248f6113665
> > --- /dev/null
> > +++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
> > @@ -0,0 +1,225 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Allwinner PCK-600 power domain support
>
> Can you please mention here that this device is based on the Arm PCK-600
> IP, as done in the commit message. And say that this is a minimal
> implementaton, just supporting the off/on states.
>
> Maybe also mention the relevant documentation: the "ARM CoreLink PCK=E2=
=80=91600
> Power Control Kit" TRM and the "Arm Power Policy Unit" architecture
> specification (DEN0051E).

Will do.

> > + *
> > + * Copyright (c) 2025 Chen-Yu Tsai <wens@csie.org>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/container_of.h>
> > +#include <linux/device.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +#include <linux/string_choices.h>
> > +
> > +#define PPU_PWPR    0x0
> > +#define PPU_PWSR    0x8
> > +#define      PPU_DCDR0   0x170
>
> white space issue?
>
> > +#define PPU_DCDR1   0x174
> > +
> > +#define PPU_PWSR_PWR_STATUS  GENMASK(3, 0)
>
> Would just PPU_PWR_STATUS be a better name, since it's used by both the
> PWPR and PWSR registers?
>
> > +#define PPU_POWER_MODE_ON    0x8
> > +#define PPU_POWER_MODE_OFF   0x0
> > +
> > +#define PPU_REG_SIZE 0x1000
> > +
> > +struct sunxi_pck600_desc {
> > +     const char * const *pd_names;
> > +     unsigned int num_domains;
> > +     u32 logic_power_switch0_delay_offset;
> > +     u32 logic_power_switch1_delay_offset;
> > +     u32 off2on_delay_offset;
> > +     u32 device_ctrl0_delay;
> > +     u32 device_ctrl1_delay;
> > +     u32 logic_power_switch0_delay;
> > +     u32 logic_power_switch1_delay;
> > +     u32 off2on_delay;
>
> Is there any indication that those parameters are different between
> different SoCs? I appreciate the idea of making this future-proof, but
> this might be a bit premature, if all SoCs use the same values?

It's hard to tell since the BSP driver only covers the A523. I'd just
keep this the way it is, since it makes it easier to generalize this
to cover PCK-600 in other platforms, if such a need ever presents itself.

> > +};
> > +
> > +struct sunxi_pck600_pd {
> > +     struct generic_pm_domain genpd;
> > +     struct sunxi_pck600 *pck;
> > +     void __iomem *base;
> > +};
> > +
> > +struct sunxi_pck600 {
> > +     struct device *dev;
> > +     struct genpd_onecell_data genpd_data;
> > +     struct sunxi_pck600_pd pds[];
> > +};
> > +
> > +#define to_sunxi_pd(gpd) container_of(gpd, struct sunxi_pck600_pd, gen=
pd)
> > +
> > +static int sunxi_pck600_pd_set_power(struct sunxi_pck600_pd *pd, bool =
on)
> > +{
> > +     struct sunxi_pck600 *pck =3D pd->pck;
> > +     struct generic_pm_domain *genpd =3D &pd->genpd;
> > +     int ret;
> > +     u32 val, reg;
> > +
> > +     val =3D on ? PPU_POWER_MODE_ON : PPU_POWER_MODE_OFF;
> > +
> > +     reg =3D readl(pd->base + PPU_PWPR);
> > +     FIELD_MODIFY(PPU_PWSR_PWR_STATUS, &reg, val);
> > +     writel(reg, pd->base + PPU_PWPR);
>
> Don't we need a lock here, or is this covered by the power domain framewo=
rk?

AFAICT genpd has a lock for each power domain. Since each power domain has
its own set of registers, I think we're good here.


Thanks
ChenYu

> Cheers,
> Andre
>
> > +
> > +     /* push write out to hardware */
> > +     reg =3D readl(pd->base + PPU_PWPR);
> > +
> > +     ret =3D readl_poll_timeout_atomic(pd->base + PPU_PWSR, reg,
> > +                                     FIELD_GET(PPU_PWSR_PWR_STATUS, re=
g) =3D=3D val,
> > +                                     0, 10000);
> > +     if (ret)
> > +             dev_err(pck->dev, "failed to turn domain \"%s\" %s: %d\n"=
,
> > +                     genpd->name, str_on_off(on), ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int sunxi_pck600_power_on(struct generic_pm_domain *domain)
> > +{
> > +     struct sunxi_pck600_pd *pd =3D to_sunxi_pd(domain);
> > +
> > +     return sunxi_pck600_pd_set_power(pd, true);
> > +}
> > +
> > +static int sunxi_pck600_power_off(struct generic_pm_domain *domain)
> > +{
> > +     struct sunxi_pck600_pd *pd =3D to_sunxi_pd(domain);
> > +
> > +     return sunxi_pck600_pd_set_power(pd, false);
> > +}
> > +
> > +static void sunxi_pck600_pd_setup(struct sunxi_pck600_pd *pd,
> > +                               const struct sunxi_pck600_desc *desc)
> > +{
> > +     writel(desc->device_ctrl0_delay, pd->base + PPU_DCDR0);
> > +     writel(desc->device_ctrl1_delay, pd->base + PPU_DCDR1);
> > +     writel(desc->logic_power_switch0_delay,
> > +            pd->base + desc->logic_power_switch0_delay_offset);
> > +     writel(desc->logic_power_switch1_delay,
> > +            pd->base + desc->logic_power_switch1_delay_offset);
> > +     writel(desc->off2on_delay, pd->base + desc->off2on_delay_offset);
> > +}
> > +
> > +static int sunxi_pck600_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     const struct sunxi_pck600_desc *desc;
> > +     struct genpd_onecell_data *genpds;
> > +     struct sunxi_pck600 *pck;
> > +     struct reset_control *rst;
> > +     struct clk *clk;
> > +     void __iomem *base;
> > +     int i, ret;
> > +
> > +     desc =3D of_device_get_match_data(dev);
> > +
> > +     pck =3D devm_kzalloc(dev, struct_size(pck, pds, desc->num_domains=
), GFP_KERNEL);
> > +     if (!pck)
> > +             return -ENOMEM;
> > +
> > +     pck->dev =3D &pdev->dev;
> > +     platform_set_drvdata(pdev, pck);
> > +
> > +     genpds =3D &pck->genpd_data;
> > +     genpds->num_domains =3D desc->num_domains;
> > +     genpds->domains =3D devm_kcalloc(dev, desc->num_domains,
> > +                                    sizeof(*genpds->domains), GFP_KERN=
EL);
> > +     if (!genpds->domains)
> > +             return -ENOMEM;
> > +
> > +     base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     rst =3D devm_reset_control_get_exclusive_released(dev, NULL);
> > +     if (IS_ERR(rst))
> > +             return dev_err_probe(dev, PTR_ERR(rst), "failed to get re=
set control\n");
> > +
> > +     clk =3D devm_clk_get_enabled(dev, NULL);
> > +     if (IS_ERR(clk))
> > +             return dev_err_probe(dev, PTR_ERR(clk), "failed to get cl=
ock\n");
> > +
> > +     for (i =3D 0; i < desc->num_domains; i++) {
> > +             struct sunxi_pck600_pd *pd =3D &pck->pds[i];
> > +
> > +             pd->genpd.name =3D desc->pd_names[i];
> > +             pd->genpd.power_off =3D sunxi_pck600_power_off;
> > +             pd->genpd.power_on =3D sunxi_pck600_power_on;
> > +             pd->base =3D base + PPU_REG_SIZE * i;
> > +
> > +             sunxi_pck600_pd_setup(pd, desc);
> > +             ret =3D pm_genpd_init(&pd->genpd, NULL, false);
> > +             if (ret) {
> > +                     dev_err_probe(dev, ret, "failed to initialize pow=
er domain\n");
> > +                     goto err_remove_pds;
> > +             }
> > +
> > +             genpds->domains[i] =3D &pd->genpd;
> > +     }
> > +
> > +     ret =3D of_genpd_add_provider_onecell(dev_of_node(dev), genpds);
> > +     if (ret) {
> > +             dev_err_probe(dev, ret, "failed to add PD provider\n");
> > +             goto err_remove_pds;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_remove_pds:
> > +     for (i--; i >=3D 0; i--)
> > +             pm_genpd_remove(genpds->domains[i]);
> > +
> > +     return ret;
> > +}
> > +
> > +static const char * const sun55i_a523_pck600_pd_names[] =3D {
> > +     "VE", "GPU", "VI", "VO0", "VO1", "DE", "NAND", "PCIE"
> > +};
> > +
> > +static const struct sunxi_pck600_desc sun55i_a523_pck600_desc =3D {
> > +     .pd_names =3D sun55i_a523_pck600_pd_names,
> > +     .num_domains =3D ARRAY_SIZE(sun55i_a523_pck600_pd_names),
> > +     .logic_power_switch0_delay_offset =3D 0xc00,
> > +     .logic_power_switch1_delay_offset =3D 0xc04,
> > +     .off2on_delay_offset =3D 0xc10,
> > +     .device_ctrl0_delay =3D 0xffffff,
> > +     .device_ctrl1_delay =3D 0xffff,
> > +     .logic_power_switch0_delay =3D 0x8080808,
> > +     .logic_power_switch1_delay =3D 0x808,
> > +     .off2on_delay =3D 0x8
> > +};
> > +
> > +static const struct of_device_id sunxi_pck600_of_match[] =3D {
> > +     {
> > +             .compatible     =3D "allwinner,sun55i-a523-pck-600",
> > +             .data           =3D &sun55i_a523_pck600_desc,
> > +     },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, sunxi_pck600_of_match);
> > +
> > +static struct platform_driver sunxi_pck600_driver =3D {
> > +     .probe =3D sunxi_pck600_probe,
> > +     .driver =3D {
> > +             .name   =3D "sunxi-pck-600",
> > +             .of_match_table =3D sunxi_pck600_of_match,
> > +             /* Power domains cannot be removed if in use. */
> > +             .suppress_bind_attrs =3D true,
> > +     },
> > +};
> > +module_platform_driver(sunxi_pck600_driver);
> > +
> > +MODULE_DESCRIPTION("Allwinner PCK-600 power domain driver");
> > +MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
> > +MODULE_LICENSE("GPL");
>
>

