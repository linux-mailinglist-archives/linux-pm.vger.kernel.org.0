Return-Path: <linux-pm+bounces-32616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A6B2BEC2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B853B47C3
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087C27A124;
	Tue, 19 Aug 2025 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEWnW9h3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6058274FF5
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598700; cv=none; b=aPlz7nmyl9n/DmkguXwMJPYCtZhfCYEAXmkCzUEWSmf4pbuU7ABOxGd2E4kntl4Vl1S0QYZKM/L6jwyNt49I2zi9MU64zgqOWmVscHzYnIOhr/uUWUNrRyewA5oCXA0P2W/G5MFCDeJEZyhzomjGOyLyb6dobQGssJb4RSa8HFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598700; c=relaxed/simple;
	bh=OU8a0L8pkiNCrmOFcxWeSvbIGgoMnP9eeAAf089rtxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG1fNfv6W+HspNxf3VcNIA9w4gDCcbfSGDLIm8gejfS18mOXBMHMjuU92SKPQRgvO+y++Hhf16kqmhrznbMRwa3i5NNU2HGNN42DBSSn6agLugJbVGoy4TGa8qN94TqqfuKvpsA0A8JubBtGlvBn8F3AcxANtcCfG0aVfRfGOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEWnW9h3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e93498d41a1so2069485276.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755598696; x=1756203496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCzMVuNyvj4CwzWZJSgJ/7ZOk+cXNaVody6HWjxlZHs=;
        b=jEWnW9h3uZukQTc4c0m32jETAtz3kJoJqZtmbZ4jCcn1md7hys+sUWbxQrgNiTOCk7
         nQ08uKsr6KE9TBoObXC5XutChHLx0oqOA88OM0qzffpua94aBK5oChB3Yqb492NhwwsI
         LN9tPo0r1Z3pSWEWEqFUHz6w3MyS2BJ8fz3nf8Hj62zN5kJOaHDvQVQqEF0Ngbiooj8z
         iJdhfS1TgrD0PijR2cJFlbsGM39ZzJ0gKBGdh/iPlIxHXt8dZ0URjyRstCdcafBnzWid
         MBmWuSsi5NIJFfkLtTOz0zWUHpNZNq2zzwI9QeEBwPAuXlcwSLRB/2TID3T5EyxtluN7
         bjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598696; x=1756203496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCzMVuNyvj4CwzWZJSgJ/7ZOk+cXNaVody6HWjxlZHs=;
        b=ep2/9wkIAca+vXadTXUQrfs67i7gMfO1Ied/pX21HLFxYyrf4LZwHRbNchmvnCsqxq
         YCaD+AhISwYISVqQ/ZRqlSyyIMwl4qkLwxq9bwZNc5gLfvaycd6Ucb3g7ku4Celd0syg
         ICcDvKNw+yyHss6PYQ7qdhNcDfQ0+CJHyxS8JhsMQXSN14UK04/llzsq9M4f/O05Ey2F
         Rk6khKloDu8NyYHt5+BGjgiMu3KHR8gYixs0Z1aOgnYCeL2rIszno57ZtKhJmZAr2qlJ
         9scC0OUwsvId/wMITN/Jb+iL+9FSjJaot2w6AKJK4e/+ZLFDUHNsrPo50aCC/rrNgdr2
         jHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCValTJd4uoZTIiZJVwQY/rNEt/W5L0+gaxTX8hI1sVXW2gD8HuDlVGiv5FM97WjdA/ssQzf+uRqdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzjJaotZBqtflsQGUjUHpoLT/quJ8YavPgOUI0a5sPWng/ubG
	pwhxwdZTTS0URIOTzu11y8d2lXFeKjhvuzHMSCfBONUql1xY08FRjaMiLNoolt22FEBJ+4UL5ds
	81+ikI+wLc07y0WfXzeCXuQaGpKLLcs52YFncGPYDXw==
X-Gm-Gg: ASbGnctR8kFD71G8njkRaVLYFxjTBgcFNslroy7tGxVxA/Qlo9cy2mEr6sil/jiL7Z/
	yVFP3p5GO3lWK5UTLrKFPngrARR06NIMhsoj2fixmJeB9xErlhZTQOGUXlA2FxgxmDow6KkQ+wg
	+0wf22kwHTa4OM1MTwetmHzf0TXYQDjqkkIQQUrHWloW6RDXmNk1RPXnIBYRXbskztX3QP74DZJ
	9Ybuyw=
X-Google-Smtp-Source: AGHT+IHEAcO4SzwVu/XD+eGRTC4UNMEX1DV9hFXIwthyq8vKu+pFu02fbBz9fqX6dEsIgcRwLnjixkKRX2KKqzoF0aA=
X-Received: by 2002:a05:6902:f86:b0:e8e:1e32:c2ac with SMTP id
 3f1490d57ef6-e94e60b40f0mr2106357276.16.1755598695665; Tue, 19 Aug 2025
 03:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz> <20250806-pxa1908-genpd-v1-3-16409309fc72@dujemihanovic.xyz>
In-Reply-To: <20250806-pxa1908-genpd-v1-3-16409309fc72@dujemihanovic.xyz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 19 Aug 2025 12:17:39 +0200
X-Gm-Features: Ac12FXwwCWVlz3SBUxWoOpDMHjQLKe8Y27bp2RrWfHQeBsjz0TJO18qciB6F97s
Message-ID: <CAPDyKFqio19zCx+XXgqS-MqUpc-m5Q4J=Wn8wPsB+fQ61fnWMw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] pmdomain: marvell: Add PXA1908 power domains
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Aug 2025 at 19:35, Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> w=
rote:
>
> Marvell's PXA1908 SoC has a few power domains for its VPU, GPU, image
> processor and DSI PHY. Add a driver to control these.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

FYI, overall this looks okay to me, but I will review your next
version more in detail.

Kind regards
Uffe

> ---
>  drivers/pmdomain/Kconfig                           |   1 +
>  drivers/pmdomain/Makefile                          |   1 +
>  drivers/pmdomain/marvell/Kconfig                   |  16 +
>  drivers/pmdomain/marvell/Makefile                  |   3 +
>  .../pmdomain/marvell/pxa1908-power-controller.c    | 347 +++++++++++++++=
++++++
>  5 files changed, 368 insertions(+)
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
> index 0000000000000000000000000000000000000000..be2036726cc563ba2a3d1a82c=
a24763e2148fec2
> --- /dev/null
> +++ b/drivers/pmdomain/marvell/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Marvell PM Domains"
> +       depends on ARCH_MMP || COMPILE_TEST
> +
> +config PXA1908_PM_DOMAINS
> +       tristate "Marvell PXA1908 power domains"
> +       depends on OF
> +       depends on PM
> +       default ARCH_MMP && ARM64
> +       select REGMAP
> +       select PM_GENERIC_DOMAINS
> +       help
> +         Say Y here to enable support for Marvell PXA1908's power domain=
s.
> +
> +endmenu
> diff --git a/drivers/pmdomain/marvell/Makefile b/drivers/pmdomain/marvell=
/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..6163bcbcb00ca7256e4c89311=
7b7443b6fb195e7
> --- /dev/null
> +++ b/drivers/pmdomain/marvell/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_PXA1908_PM_DOMAINS)       +=3D pxa1908-power-controller.o
> diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/driver=
s/pmdomain/marvell/pxa1908-power-controller.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a8940e6dc2eaad2b14e9e6d8a=
a875c11e114b9dd
> --- /dev/null
> +++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/container_of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/of_clk.h>
> +#include <linux/of_platform.h>
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
> +struct pxa1908_pd_ctrl {
> +       struct genpd_onecell_data onecell_data;
> +       struct regmap *base;
> +       struct generic_pm_domain *domains[];
> +};
> +
> +struct pxa1908_pd_data {
> +       u32 reg_clk_res_ctrl;
> +       u32 hw_mode;
> +       u32 pwr_state;
> +       bool keep_on;
> +       int id;
> +};
> +
> +struct pxa1908_pd {
> +       const struct pxa1908_pd_data data;
> +       struct generic_pm_domain genpd;
> +       struct clk_bulk_data *clks;
> +       struct device *dev;
> +       bool initialized;
> +       int num_clks;
> +};
> +
> +static bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
> +{
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(pd->dev);
> +
> +       return regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data=
.pwr_state);
> +}
> +
> +static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct pxa1908_pd *pd =3D container_of(genpd, struct pxa1908_pd, =
genpd);
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(pd->dev);
> +       const struct pxa1908_pd_data *data =3D &pd->data;
> +       unsigned int status;
> +       int ret =3D 0;
> +
> +       if (pd->clks)
> +               ret =3D clk_bulk_prepare_enable(pd->num_clks, pd->clks);
> +
> +       regmap_set_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode=
);
> +       if (data->id !=3D PXA1908_POWER_DOMAIN_ISP)
> +               regmap_write(ctrl->base, APMU_PWR_BLK_TMR_REG, 0x20001fff=
);
> +       regmap_set_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
> +
> +       usleep_range(POWER_ON_LATENCY_US, POWER_ON_LATENCY_US * 2);
> +
> +       ret =3D regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG,=
 status,
> +                                      status & data->pwr_state, 6, 25 * =
USEC_PER_MSEC);
> +       if (ret =3D=3D -ETIMEDOUT)
> +               dev_err(pd->dev, "timed out powering on domain '%s'\n", p=
d->genpd.name);
> +
> +       if (pd->clks)
> +               clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +
> +       return ret;
> +}
> +
> +static int pxa1908_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct pxa1908_pd *pd =3D container_of(genpd, struct pxa1908_pd, =
genpd);
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(pd->dev);
> +       const struct pxa1908_pd_data *data =3D &pd->data;
> +       unsigned int status;
> +       int ret;
> +
> +       regmap_clear_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state)=
;
> +
> +       usleep_range(POWER_OFF_LATENCY_US, POWER_OFF_LATENCY_US * 2);
> +
> +       ret =3D regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG,=
 status,
> +                                      !(status & data->pwr_state), 6, 25=
 * USEC_PER_MSEC);
> +       if (ret =3D=3D -ETIMEDOUT) {
> +               dev_err(pd->dev, "timed out powering off domain '%s'\n", =
pd->genpd.name);
> +               return ret;
> +       }
> +
> +       regmap_clear_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mo=
de);
> +
> +       return 0;
> +}
> +
> +static int pxa1908_dsi_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct pxa1908_pd *pd =3D container_of(genpd, struct pxa1908_pd, =
genpd);
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(pd->dev);
> +
> +       if (pd->clks) {
> +               int ret =3D clk_bulk_prepare_enable(pd->num_clks, pd->clk=
s);
> +
> +               if (ret) {
> +                       dev_err(pd->dev, "failed to enable clocks for dom=
ain '%s': %d\n",
> +                               pd->genpd.name, ret);
> +                       return ret;
> +               }
> +       }
> +
> +       regmap_set_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
> +
> +       return 0;
> +}
> +
> +static int pxa1908_dsi_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct pxa1908_pd *pd =3D container_of(genpd, struct pxa1908_pd, =
genpd);
> +       struct pxa1908_pd_ctrl *ctrl =3D dev_get_drvdata(pd->dev);
> +
> +       regmap_clear_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
> +
> +       if (pd->clks)
> +               clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +
> +       return 0;
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
> +static struct pxa1908_pd domains[] =3D {
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
> +static void pxa1908_pd_cleanup(struct pxa1908_pd_ctrl *ctrl)
> +{
> +       struct pxa1908_pd *pd;
> +       int ret;
> +
> +       for (int i =3D ARRAY_SIZE(domains) - 1; i >=3D 0; i--) {
> +               pd =3D &domains[i];
> +
> +               if (!pd->initialized)
> +                       continue;
> +
> +               ret =3D pm_genpd_remove(&pd->genpd);
> +               if (ret)
> +                       dev_err(pd->dev, "failed to remove domain '%s': %=
d\n",
> +                               pd->genpd.name, ret);
> +               if (pxa1908_pd_is_on(pd) && !pd->data.keep_on)
> +                       pxa1908_pd_power_off(&pd->genpd);
> +
> +               clk_bulk_put_all(pd->num_clks, pd->clks);
> +       }
> +}
> +
> +static int
> +pxa1908_pd_init(struct pxa1908_pd_ctrl *ctrl, struct device_node *node, =
struct device *dev)
> +{
> +       struct pxa1908_pd *pd;
> +       int clk_idx =3D 0, ret;
> +       u32 id;
> +
> +       ret =3D of_property_read_u32(node, "reg", &id);
> +       if (ret) {
> +               dev_err(dev, "failed to get domain id from reg: %d\n", re=
t);
> +               return ret;
> +       }
> +
> +       if (id >=3D ARRAY_SIZE(domains)) {
> +               dev_err(dev, "invalid domain id %d\n", id);
> +               return ret;
> +       }
> +
> +       pd =3D &domains[id];
> +       pd->dev =3D dev;
> +       pd->num_clks =3D of_clk_get_parent_count(node);
> +       ctrl->domains[id] =3D &pd->genpd;
> +
> +       if (pd->num_clks > 0) {
> +               pd->clks =3D devm_kcalloc(dev, pd->num_clks, sizeof(*pd->=
clks), GFP_KERNEL);
> +               if (!pd->clks)
> +                       return -ENOMEM;
> +       }
> +
> +       for (int i =3D 0; i < pd->num_clks; i++) {
> +               struct clk *clk =3D of_clk_get(node, i);
> +
> +               if (IS_ERR(clk)) {
> +                       ret =3D PTR_ERR(clk);
> +                       dev_err(dev, "failed to get clk for domain '%s': =
%d\n",
> +                               pd->genpd.name, ret);
> +                       goto err;
> +               }
> +
> +               pd->clks[clk_idx++].clk =3D clk;
> +       }
> +
> +       /* Make sure the state of the hardware is synced with the domain =
table above. */
> +       if (pd->data.keep_on) {
> +               ret =3D pd->genpd.power_on(&pd->genpd);
> +               if (ret) {
> +                       dev_err(dev, "failed to power on domain '%s': %d\=
n", pd->genpd.name, ret);
> +                       goto err;
> +               }
> +       } else {
> +               if (pxa1908_pd_is_on(pd)) {
> +                       dev_warn(dev,
> +                                "domain '%s' is on despite being default=
 off; powering off\n",
> +                                pd->genpd.name);
> +
> +                       ret =3D pxa1908_pd_power_off(&pd->genpd);
> +                       if (ret) {
> +                               dev_err(dev, "failed to power off domain =
'%s': %d\n",
> +                                       pd->genpd.name, ret);
> +                               goto err;
> +                       }
> +               }
> +       }
> +
> +       ret =3D pm_genpd_init(&pd->genpd, NULL, !pd->data.keep_on);
> +       if (ret) {
> +               dev_err(dev, "domain '%s' failed to initialize: %d\n", pd=
->genpd.name, ret);
> +               goto err;
> +       }
> +
> +       pd->initialized =3D true;
> +
> +       return 0;
> +
> +err:
> +       clk_bulk_put_all(pd->num_clks, pd->clks);
> +       return ret;
> +}
> +
> +static int pxa1908_pd_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct pxa1908_pd_ctrl *ctrl;
> +       struct device_node *node;
> +       int ret;
> +
> +       ctrl =3D devm_kzalloc(dev, struct_size(ctrl, domains, ARRAY_SIZE(=
domains)), GFP_KERNEL);
> +       if (!ctrl)
> +               return -ENOMEM;
> +
> +       ctrl->base =3D syscon_node_to_regmap(dev->parent->of_node);
> +       if (IS_ERR(ctrl->base)) {
> +               dev_err(dev, "no regmap available\n");
> +               return PTR_ERR(ctrl->base);
> +       }
> +
> +       platform_set_drvdata(pdev, ctrl);
> +
> +       ctrl->onecell_data.domains =3D ctrl->domains;
> +       ctrl->onecell_data.num_domains =3D ARRAY_SIZE(domains);
> +
> +       for_each_available_child_of_node(dev->of_node, node) {
> +               ret =3D pxa1908_pd_init(ctrl, node, dev);
> +               if (ret)
> +                       goto err;
> +       }
> +
> +       return of_genpd_add_provider_onecell(dev->of_node, &ctrl->onecell=
_data);
> +
> +err:
> +       pxa1908_pd_cleanup(ctrl);
> +       return ret;
> +}
> +
> +static void pxa1908_pd_remove(struct platform_device *pdev)
> +{
> +       pxa1908_pd_cleanup(platform_get_drvdata(pdev));
> +}
> +
> +static const struct of_device_id pxa1908_pd_match[] =3D {
> +       {
> +               .compatible =3D "marvell,pxa1908-power-controller",
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, pxa1908_pd_match);
> +
> +static struct platform_driver pxa1908_pd_driver =3D {
> +       .probe =3D pxa1908_pd_probe,
> +       .remove =3D pxa1908_pd_remove,
> +       .driver =3D {
> +               .name =3D "pxa1908-power-controller",
> +               .of_match_table =3D pxa1908_pd_match,
> +       },
> +};
> +module_platform_driver(pxa1908_pd_driver);
> +
> +MODULE_AUTHOR("Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>");
> +MODULE_DESCRIPTION("Marvell PXA1908 power domain driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.50.1
>

