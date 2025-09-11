Return-Path: <linux-pm+bounces-34484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF9B5356D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C15AA2CF5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796B333CEAA;
	Thu, 11 Sep 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOXre/iX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3117233CE9E
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601154; cv=none; b=hfVegUrVWNnY7ri0D/mr+c1sDhjCtgZftS13b6px2yrP1HAd+9AVLwi7WEe76qeYxJZFUcr0D+sApbMxM0OE6hcnERwSYU1JmXHR+ifZtEEoc49rKCowtiZOeDrwdaGh/3gshsvRArrxkdSk2nLCfODWQiC/BEWVpOB9ByJ0Caw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601154; c=relaxed/simple;
	bh=eCZcmRvkeBZItFAG3mOym3+dfp8SxuJgpD5cNHuveIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjB5c9GTdmarMVsipK4obb/NaJR7/y3TftWiwjpgjf0W87gHQLcGe3ozLAeuZti90wXDDPQ6Ydrlrb0Mudo+sohdz/i7sRxnHSh1YIUXznpXOq68x4QXIbPkL46Dpfu+8FMEF6TVR5PdKCxDderVdfjlyR1DleoLQ2mjZ88/kZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SOXre/iX; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e9baa0310cbso763801276.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601151; x=1758205951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3G1Q8trf1KrPeh7JRBVP/u6wl+tP3n7DRT+geP906w=;
        b=SOXre/iXppfTNsYCBLL1ZXefoz+sx8eOHLylq+WfkLQxqIoqbpZ+yNFwyj4sSRp3dr
         0dJXB78mCFKVTXKtp1l/prnnacSu5LBRJDo5mFJnUYplYG9BXaSIVE6ar+f8gJ84m4lH
         0jL8LfqsbThN2V0Z45qB1xv/nJcYXXxFvjbRjL6XoMB4n/kf9Tt1cRdtechU5iizm+Zn
         O9XmLtmUVJ4Y2h5TAD7LJY6pmom9/iSrxQwg3VpIAKapmULuk8dOWsvhFS0DXYlqspJt
         X7zxAir4DTiDliOqjAwhEzzjt4DZ7aXPK0trmiADp8R7cadQO3p+D/15g+yDkxYjz7Ce
         b08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601151; x=1758205951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3G1Q8trf1KrPeh7JRBVP/u6wl+tP3n7DRT+geP906w=;
        b=oVjKUUlsYJGIgZT9lDDeuqE5SgEX/Yk8HgmKRoKZ8/jKBZaQlBNgpSdPpniaQaPRn0
         +UHgdpD3ZuBy3esOMurJZvz3LMkdJS1E2Vs+Tl7V9j6w/6N5MRqROVm+c9KRgZZNJMFD
         xh/58b7tkk7MzGv94kLZjAA0AEj6A6nUdiFKj3z4c+ydEqyvosTTS5zF6pBTCRYLcdQ5
         1nBK9jclzD8XuwlvvsAf4slbijtZui5spF9mPoJ61U1VgOXoV1rfBdwh7gXSWOVtdEzk
         TpMVVWuPKgLj/ANbzrSkZbAH6OrdEocQM+sCvHOA+XQP+gzapJH8mKusWFrHs9Umm8UQ
         wjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiveMIWj8Y+L43JzzDcmtUia5SvBvamtCCP9p+obDcIV1/QVBnj/tJKkkoc8jGEllSfTBhqHYKoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQyFP1sHSX7oV4rj3IkmTLwxTqpYE3XdYhjpIYMRDillhIIeV
	47TYVAa6FzBHYjD0gO9qLXswF8aUHLzUfgWy2+WeM5S8ir8L+CMvvah5Vs00VKvebdOvNJaovH4
	4pn8zbMAEKAZf+GRbd/enwmFvDXjeG22ukpScgpJzog==
X-Gm-Gg: ASbGncuBBaSlunKcn3Gl6ucTdh1yfm1975HTuOgDIBl7iAK3Roqfc2w0ZLT7DWvkWxS
	syILSrq14QOmTQbCxcxau8p+gbaTWEDq2N8vnzrTb5x/cQBD3op2wmwzylwl7YFL0zUJRxx6Jnn
	AzD6ZYlIIhuLnG1y7ywGjbLpASYQrOWSgB6PxyvR6V2CzYUiRZ7GH66uGAW1rjcmnbKfEo1xzF4
	Ehp3l7VGczsfT2csSg=
X-Google-Smtp-Source: AGHT+IHk66zPIbwvGUfliID4rNwdavLJX3B1E/zwo4X1IyK21WKvR0Vm876Pd397O+CLNkNssnCw0oVSGGUIeIlQnHA=
X-Received: by 2002:a05:6902:1892:b0:ea3:d40a:2563 with SMTP id
 3f1490d57ef6-ea3d40a2737mr1135991276.41.1757601150819; Thu, 11 Sep 2025
 07:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-pxa1908-genpd-v3-0-2aacaaaca271@dujemihanovic.xyz> <20250829-pxa1908-genpd-v3-2-2aacaaaca271@dujemihanovic.xyz>
In-Reply-To: <20250829-pxa1908-genpd-v3-2-2aacaaaca271@dujemihanovic.xyz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Sep 2025 16:31:55 +0200
X-Gm-Features: Ac12FXxKrX9P2Lh17PZPTTUHZfR9xq35WTK20siD_z-ekoywxELI_UvNVL-MSOI
Message-ID: <CAPDyKFqTVUZn5F7ss7qCtNktCGfSaXCB+cGOnN9rH0hjTwJkhw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] pmdomain: marvell: Add PXA1908 power domains
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Aug 2025 at 18:22, Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> =
wrote:
>
> Marvell's PXA1908 SoC has a few power domains for its VPU, GPU, image
> processor and DSI PHY. Add a driver to control these.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---
> v3:
> - Move driver back to pmdomain subsystem, use auxiliary bus to
>   instantiate the driver
> - Drop redundant 'struct device' pointer in 'struct pxa1908_pd'
> - Fix pxa1908_pd_is_on() for DSI domain
> - Replace usleep_range() with fsleep()
> - Use dev_err_probe() where sensible
>
> v2:
> - Move to clk subsystem, instantiate the driver from the APMU clock
>   driver
> - Drop clock handling
> - Squash MAINTAINERS patch
> ---
>  MAINTAINERS                                        |   1 +
>  drivers/pmdomain/Kconfig                           |   1 +
>  drivers/pmdomain/Makefile                          |   1 +
>  drivers/pmdomain/marvell/Kconfig                   |  18 ++
>  drivers/pmdomain/marvell/Makefile                  |   3 +
>  .../pmdomain/marvell/pxa1908-power-controller.c    | 268 +++++++++++++++=
++++++
>  6 files changed, 292 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 88f7bd50686eb1f6bcd4f34c6827f27ad44ea4e8..34e5e218e83e0ed9882b111f5=
251601dd6549d4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2871,6 +2871,7 @@ L:        linux-arm-kernel@lists.infradead.org (mod=
erated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm64/boot/dts/marvell/mmp/
>  F:     drivers/clk/mmp/clk-pxa1908*.c
> +F:     drivers/pmdomain/marvell/
>  F:     include/dt-bindings/clock/marvell,pxa1908.h
>  F:     include/dt-bindings/power/marvell,pxa1908-power.h
>
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 91f04ace35d4b024fafdf6af4e26a179640eb82f..23076ae90e6641dea8e5dbc85=
1d041cd7929cee6 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -7,6 +7,7 @@ source "drivers/pmdomain/apple/Kconfig"
>  source "drivers/pmdomain/arm/Kconfig"
>  source "drivers/pmdomain/bcm/Kconfig"
>  source "drivers/pmdomain/imx/Kconfig"
> +source "drivers/pmdomain/marvell/Kconfig"
>  source "drivers/pmdomain/mediatek/Kconfig"
>  source "drivers/pmdomain/qcom/Kconfig"
>  source "drivers/pmdomain/renesas/Kconfig"
> diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
> index 7030f44a49df9e91b1c9d1b6d12690a6248671fb..ebc802f13eb953db750f5a950=
7caa64c637a957a 100644
> --- a/drivers/pmdomain/Makefile
> +++ b/drivers/pmdomain/Makefile
> @@ -5,6 +5,7 @@ obj-y                                   +=3D apple/
>  obj-y                                  +=3D arm/
>  obj-y                                  +=3D bcm/
>  obj-y                                  +=3D imx/
> +obj-y                                  +=3D marvell/
>  obj-y                                  +=3D mediatek/
>  obj-y                                  +=3D qcom/
>  obj-y                                  +=3D renesas/
> diff --git a/drivers/pmdomain/marvell/Kconfig b/drivers/pmdomain/marvell/=
Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..6c4084c826670266b7d948438=
f6e6d76acb416e2
> --- /dev/null
> +++ b/drivers/pmdomain/marvell/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Marvell PM Domains"
> +       depends on ARCH_MMP || COMPILE_TEST
> +
> +config PXA1908_PM_DOMAINS
> +       tristate "Marvell PXA1908 power domains"
> +       depends on OF
> +       depends on PM
> +       default y if ARCH_MMP && ARM64
> +       select AUXILIARY_BUS
> +       select MFD_SYSCON
> +       select PM_GENERIC_DOMAINS
> +       select PM_GENERIC_DOMAINS_OF
> +       help
> +         Say Y here to enable support for Marvell PXA1908's power domani=
s.
> +
> +endmenu
> diff --git a/drivers/pmdomain/marvell/Makefile b/drivers/pmdomain/marvell=
/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..22c25013f6c856a2ca01a121e=
830279ee88eb0ed
> --- /dev/null
> +++ b/drivers/pmdomain/marvell/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_PXA1908_PM_DOMAINS) +=3D pxa1908-power-controller.o
> diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/driver=
s/pmdomain/marvell/pxa1908-power-controller.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..29134629861abcf46959f9dcc=
98d3f05a4cc5b72
> --- /dev/null
> +++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#include <dt-bindings/power/marvell,pxa1908-power.h>
> +
> +/* VPU, GPU, ISP */
> +#define APMU_PWR_CTRL_REG      0xd8
> +#define APMU_PWR_BLK_TMR_REG   0xdc
> +#define APMU_PWR_STATUS_REG    0xf0
> +
> +/* DSI */
> +#define APMU_DEBUG             0x88
> +#define DSI_PHY_DVM_MASK       BIT(31)
> +
> +#define POWER_ON_LATENCY_US    300
> +#define POWER_OFF_LATENCY_US   20
> +
> +#define NR_DOMAINS     5
> +
> +struct pxa1908_pd_ctrl {
> +       struct generic_pm_domain *domains[NR_DOMAINS];
> +       struct genpd_onecell_data onecell_data;
> +       struct regmap *base;
> +};
> +
> +struct pxa1908_pd_data {
> +       u32 reg_clk_res_ctrl;
> +       u32 pwr_state;
> +       u32 hw_mode;
> +       bool keep_on;
> +       int id;
> +};
> +
> +struct pxa1908_pd {
> +       const struct pxa1908_pd_data data;
> +       struct generic_pm_domain genpd;
> +       bool initialized;
> +};
> +
> +static inline bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
> +{
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(&pd->genpd.dev);

The genpd.dev is owned by the genpd core and must not be used like this.

Please find another way to derive the needed data.

> +
> +       return pd->data.id !=3D PXA1908_POWER_DOMAIN_DSI
> +               ? regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->d=
ata.pwr_state)
> +               : regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MA=
SK);
> +}
> +
> +static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct pxa1908_pd *pd =3D container_of(genpd, struct pxa1908_pd, =
genpd);
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(&genpd->dev);

Ditto.


> +       const struct pxa1908_pd_data *data =3D &pd->data;
> +       unsigned int status;
> +       int ret =3D 0;
> +
> +       regmap_set_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode=
);
> +       if (data->id !=3D PXA1908_POWER_DOMAIN_ISP)
> +               regmap_write(ctrl->base, APMU_PWR_BLK_TMR_REG, 0x20001fff=
);
> +       regmap_set_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
> +
> +       fsleep(POWER_ON_LATENCY_US);

I assume the fsleep here is intentional and should be combined with
the poll-timeout below. Although I wonder why we can't just poll
immediately and by using some reasonable period+timeout instead?

> +
> +       ret =3D regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG,=
 status,
> +                                      status & data->pwr_state, 6, 25 * =
USEC_PER_MSEC);

Please avoid hardcoding periods/timeouts here.

> +       if (ret =3D=3D -ETIMEDOUT)
> +               dev_err(&genpd->dev, "timed out powering on domain '%s'\n=
", pd->genpd.name);
> +
> +       return ret;
> +}
> +
> +static int pxa1908_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct pxa1908_pd *pd =3D container_of(genpd, struct pxa1908_pd, =
genpd);
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(&genpd->dev);
> +       const struct pxa1908_pd_data *data =3D &pd->data;
> +       unsigned int status;
> +       int ret;
> +
> +       regmap_clear_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state)=
;
> +
> +       fsleep(POWER_OFF_LATENCY_US);

Ditto.

> +
> +       ret =3D regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG,=
 status,
> +                                      !(status & data->pwr_state), 6, 25=
 * USEC_PER_MSEC);

Ditto.

> +       if (ret =3D=3D -ETIMEDOUT) {
> +               dev_err(&genpd->dev, "timed out powering off domain '%s'\=
n", pd->genpd.name);
> +               return ret;
> +       }
> +
> +       return regmap_clear_bits(ctrl->base, data->reg_clk_res_ctrl, data=
->hw_mode);
> +}
> +
> +static inline int pxa1908_dsi_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(&genpd->dev);
> +
> +       return regmap_set_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
> +}
> +
> +static inline int pxa1908_dsi_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(&genpd->dev);
> +
> +       return regmap_clear_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK=
);
> +}
> +
> +#define DOMAIN(_id, _name, ctrl, mode, state) \
> +       [_id] =3D { \
> +               .data =3D { \
> +                       .reg_clk_res_ctrl =3D ctrl, \
> +                       .hw_mode =3D BIT(mode), \
> +                       .pwr_state =3D BIT(state), \
> +                       .id =3D _id, \
> +               }, \
> +               .genpd =3D { \
> +                       .name =3D _name, \
> +                       .power_on =3D pxa1908_pd_power_on, \
> +                       .power_off =3D pxa1908_pd_power_off, \
> +               }, \
> +       }
> +
> +static struct pxa1908_pd domains[NR_DOMAINS] =3D {
> +       DOMAIN(PXA1908_POWER_DOMAIN_VPU, "vpu", 0xa4, 19, 2),
> +       DOMAIN(PXA1908_POWER_DOMAIN_GPU, "gpu", 0xcc, 11, 0),
> +       DOMAIN(PXA1908_POWER_DOMAIN_GPU2D, "gpu2d", 0xf4, 11, 6),
> +       DOMAIN(PXA1908_POWER_DOMAIN_ISP, "isp", 0x38, 15, 4),
> +       [PXA1908_POWER_DOMAIN_DSI] =3D {
> +               .genpd =3D {
> +                       .name =3D "dsi",
> +                       .power_on =3D pxa1908_dsi_power_on,
> +                       .power_off =3D pxa1908_dsi_power_off,
> +                       /*
> +                        * TODO: There is no DSI driver written yet and u=
ntil then we probably
> +                        * don't want to power off the DSI PHY ever.
> +                        */
> +                       .flags =3D GENPD_FLAG_ALWAYS_ON,
> +               },
> +               .data =3D {
> +                       /* See above. */
> +                       .keep_on =3D true,
> +               },
> +       },
> +};
> +
> +static void pxa1908_pd_remove(struct auxiliary_device *auxdev)
> +{
> +       struct pxa1908_pd *pd;
> +       int ret;
> +
> +       for (int i =3D NR_DOMAINS - 1; i >=3D 0; i--) {
> +               pd =3D &domains[i];
> +
> +               if (!pd->initialized)
> +                       continue;
> +
> +               if (pxa1908_pd_is_on(pd) && !pd->data.keep_on)
> +                       pxa1908_pd_power_off(&pd->genpd);
> +
> +               ret =3D pm_genpd_remove(&pd->genpd);
> +               if (ret)
> +                       dev_err(&pd->genpd.dev, "failed to remove domain =
'%s': %d\n",
> +                               pd->genpd.name, ret);
> +       }
> +}
> +
> +static int
> +pxa1908_pd_init(struct pxa1908_pd_ctrl *ctrl, int id, struct device *dev=
)
> +{
> +       struct pxa1908_pd *pd =3D &domains[id];
> +       int ret;
> +
> +       ctrl->domains[id] =3D &pd->genpd;
> +
> +       ret =3D pm_genpd_init(&pd->genpd, NULL, !pd->data.keep_on);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "domain '%s' failed to ini=
tialize\n",
> +                                    pd->genpd.name);
> +
> +       dev_set_drvdata(&pd->genpd.dev, ctrl);

As stated above, please don't abuse the genpd.dev like this.

> +
> +       /* Make sure the state of the hardware is synced with the domain =
table above. */
> +       if (pd->data.keep_on) {
> +               ret =3D pd->genpd.power_on(&pd->genpd);

This should be managed before pm_genpd_init() is called.

> +               if (ret)
> +                       return dev_err_probe(dev, ret, "failed to power o=
n domain '%s'\n",
> +                                            pd->genpd.name);
> +       } else {
> +               if (pxa1908_pd_is_on(pd)) {
> +                       dev_warn(dev,
> +                                "domain '%s' is on despite being default=
 off; powering off\n",
> +                                pd->genpd.name);
> +
> +                       ret =3D pd->genpd.power_off(&pd->genpd);

Ditto.

> +                       if (ret)
> +                               return dev_err_probe(dev, ret,
> +                                                    "failed to power off=
 domain '%s'\n",
> +                                                    pd->genpd.name);
> +               }
> +       }
> +
> +       pd->initialized =3D true;
> +
> +       return 0;
> +}
> +
> +static int
> +pxa1908_pd_probe(struct auxiliary_device *auxdev, const struct auxiliary=
_device_id *aux_id)
> +{
> +       struct pxa1908_pd_ctrl *ctrl;
> +       struct device *dev =3D &auxdev->dev;
> +       int ret;
> +
> +       ctrl =3D devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
> +       if (!ctrl)
> +               return -ENOMEM;
> +
> +       auxiliary_set_drvdata(auxdev, ctrl);
> +
> +       ctrl->base =3D syscon_node_to_regmap(dev->parent->of_node);
> +       if (IS_ERR(ctrl->base))
> +               return dev_err_probe(dev, PTR_ERR(ctrl->base), "no regmap=
 available\n");
> +
> +       ctrl->onecell_data.domains =3D ctrl->domains;
> +       ctrl->onecell_data.num_domains =3D NR_DOMAINS;
> +
> +       for (int i =3D 0; i < NR_DOMAINS; i++) {
> +               ret =3D pxa1908_pd_init(ctrl, i, dev);
> +               if (ret)
> +                       goto err;
> +       }
> +
> +       return of_genpd_add_provider_onecell(dev->parent->of_node, &ctrl-=
>onecell_data);
> +
> +err:
> +       pxa1908_pd_remove(auxdev);
> +       return ret;
> +}
> +
> +static const struct auxiliary_device_id pxa1908_pd_id[] =3D {
> +       { .name =3D "clk_pxa1908_apmu.power" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, pxa1908_pd_id);
> +
> +static struct auxiliary_driver pxa1908_pd_driver =3D {
> +       .probe =3D pxa1908_pd_probe,
> +       .remove =3D pxa1908_pd_remove,
> +       .id_table =3D pxa1908_pd_id,
> +};
> +module_auxiliary_driver(pxa1908_pd_driver);
> +
> +MODULE_AUTHOR("Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>");
> +MODULE_DESCRIPTION("Marvell PXA1908 power domain driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.51.0
>

Kind regards
Uffe

