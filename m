Return-Path: <linux-pm+bounces-20759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F359A17A9D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94C51884AEF
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92731E25F4;
	Tue, 21 Jan 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErmcMPKp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA51E7C07
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453351; cv=none; b=pxwip/CS+ke2Dm+E3iAu6CMR/ilu3yQT5orRNmUU719G9/MfwgEY5gX4Fa7yb0jRIJu/zkAou+BZHfjHwoIUuynuEcfsxbH3wHMTY//JMJiDKjQOC7tAFuVf0qC/ThaoNpZcofNF9e1clnj7sw88inDVjTJY8PcNDLWNLPyrED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453351; c=relaxed/simple;
	bh=9wW/GoI7Ggznx9yj9vItellduLwLGWMghCyWxpRqr9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCnDbvZ1RwWxWwDOJvrwwn7lhPXEh0lEV0YZWXG9/DoDqbVXjL59xy6CmPT7JU3eiOqVWM5c8SsajLvUWLUeiQoMip7zSRLSV5/2+NDL8QmiJ+N5SZLpWm0m0mFeuX7eqGIViS984dhqcxbQUA7ptjHzQTBh6q1egiQbtnmrBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErmcMPKp; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e549a71dd3dso9518290276.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737453348; x=1738058148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7o6IOiITgKj2aaYMKuu2L3/b1CWQWZ/+CCPF6c2JWmw=;
        b=ErmcMPKpIqeWMqIwhTq++G0FAyXaUJhyHUt7Rh7ElhGI6SymHJPKBUKaqAesEng7jN
         FYT/QCenBWgRrVDx3u1notEoOHerGmwRSpd4VGQYnEqHeMoeQTLfArl30vNeV226SYNx
         DNlc/qOS8ENrsKlW1bab9WI/HKcOQG6oTdpNVaL3Tmv5tvbYofOWH6TINCVaPvmVzk8v
         sy+U+/JYb5TuZ3HXsNCQM/Ep2SX32Klgqyx3m9pwKJ+TuzD6+d908XsRVSTyXxdgn/3I
         xeG/CrkfTOSvj91CWrVEECMcrmrR8i6plzDmLFdkbWt3GTXQ+qFyjpR04NQP5nAXKD1g
         voBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737453348; x=1738058148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o6IOiITgKj2aaYMKuu2L3/b1CWQWZ/+CCPF6c2JWmw=;
        b=Lh2s57fu+F9oCt194qQ8J74sy32oAWWcoFgX73vNKHdboTpdFdNb1/cxhVwIUGc4ed
         Tcm3EJ0uS/YbvPhvey2Qvs53hOAuZ01JhPnW/TCXgruL774bC+gWHET5TS9mxX3pafQH
         ZK2okSei/gly2Of0YMPwL4j1DegMMHfsVMZE+HBFF0RXoRxhXrN9w25GdsDNxWjShBab
         kgE9RHMt6ZLGSPx/f8CeqPPRNKwcEGYNieJswnx72UzrnxYJJ4dgPble6jxEQGmL+JXE
         DCYGBeWb8VaBIdkrkULwy/CFo4PBusZ4sTGFTE5jvcef9wexGBQy29sCbxYfZJzCt3lB
         pcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs33UGnl4TnL4UVDnt50Os/AGuullXau5gV6REvT+q9VmEVKMBOUfnZ0O5KmY3UJgswfNpqf2XOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOk3c84H+rSMcyTYCbRo9BdlMS0sbaqjH9x6eyZmNm+2NGbChc
	Y+HE+UHk7yX6tRV78U8Q1uKddzPMNkL1e8lcbYP3/jfA7A7gBmpBHxyzH6qjRMdsLf5jODog1Ne
	7vzoq5bB6rWDw8HTa7NH0rphQoRKwBKAJ0nf0MQ==
X-Gm-Gg: ASbGncvJ5pyTQ8sw0sgLPgKGSdLMgGmfjn+xa4AUDFcNMhqMAVHd0LTp835Xz2sVrwY
	bjjpnwZvTednOrypq4IHCdopBZnd3zyF4N1fffI/JBhKJKJsaE3g=
X-Google-Smtp-Source: AGHT+IEpnT3FHvprwRHA3VpPC4Y+cVC4t00ffjRcKixMRn9RszYOv82pYtRXth2Mua1mSVsOU+7gyK7UGMPrtGwJ2tA=
X-Received: by 2002:a05:6902:154a:b0:e58:cbe:75af with SMTP id
 3f1490d57ef6-e580cbe7a6bmr47838276.8.1737453348429; Tue, 21 Jan 2025 01:55:48
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250120172125eucas1p141540607f423eea4c55b2bd22ff5adf0@eucas1p1.samsung.com>
 <20250120172111.3492708-1-m.wilczynski@samsung.com> <20250120172111.3492708-6-m.wilczynski@samsung.com>
In-Reply-To: <20250120172111.3492708-6-m.wilczynski@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Jan 2025 10:55:12 +0100
X-Gm-Features: AbW1kvYXcCyxNJkjAKX_kGzqeB1Hobs-RjT3osPXjnDxzisZWb_QimmzPk9PWZ4
Message-ID: <CAPDyKFrKKZ4RL5y+sCKAOK71ap7O3aTTc6rY9NrvcHt4hh6EVQ@mail.gmail.com>
Subject: Re: [RFC v3 05/18] pmdomain: thead: Add power-domain driver for TH1520
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, jszhang@kernel.org, 
	p.zabel@pengutronix.de, m.szyprowski@samsung.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 18:21, Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> The T-Head TH1520 SoC contains multiple power islands that can be
> programmatically turned on and off using the AON (Always-On) protocol
> and a hardware mailbox [1]. The relevant mailbox driver has already been
> merged into the mainline kernel in commit 5d4d263e1c6b ("mailbox:
> Introduce support for T-head TH1520 Mailbox driver");
>
> This commit introduces a power-domain driver for the TH1520 SoC, which
> is using AON firmware protocol to communicate with E902 core through the
> hardware mailbox. This way it can send power on/off commands to the E902
> core.
>
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

I guess this depends on patch2 and patch3. Not sure what's the best
way to merge this, but I can certainly funnel them all three through
my pmdomain tree if that sounds feasible. Just let me know.

Kind regards
Uffe

> ---
>  MAINTAINERS                                |   1 +
>  drivers/pmdomain/Kconfig                   |   1 +
>  drivers/pmdomain/Makefile                  |   1 +
>  drivers/pmdomain/thead/Kconfig             |  12 ++
>  drivers/pmdomain/thead/Makefile            |   2 +
>  drivers/pmdomain/thead/th1520-pm-domains.c | 174 +++++++++++++++++++++
>  6 files changed, 191 insertions(+)
>  create mode 100644 drivers/pmdomain/thead/Kconfig
>  create mode 100644 drivers/pmdomain/thead/Makefile
>  create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c96a1e6c8831..363bb3471a33 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20195,6 +20195,7 @@ F:      drivers/firmware/thead,th1520-aon.c
>  F:     drivers/mailbox/mailbox-th1520.c
>  F:     drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:     drivers/pinctrl/pinctrl-th1520.c
> +F:     drivers/pmdomain/thead/
>  F:     include/dt-bindings/clock/thead,th1520-clk-ap.h
>  F:     include/dt-bindings/firmware/thead,th1520-aon.h
>  F:     include/linux/firmware/thead/thead,th1520-aon.h
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 23c64851a5b0..91f04ace35d4 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -16,6 +16,7 @@ source "drivers/pmdomain/st/Kconfig"
>  source "drivers/pmdomain/starfive/Kconfig"
>  source "drivers/pmdomain/sunxi/Kconfig"
>  source "drivers/pmdomain/tegra/Kconfig"
> +source "drivers/pmdomain/thead/Kconfig"
>  source "drivers/pmdomain/ti/Kconfig"
>  source "drivers/pmdomain/xilinx/Kconfig"
>
> diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
> index a68ece2f4c68..7030f44a49df 100644
> --- a/drivers/pmdomain/Makefile
> +++ b/drivers/pmdomain/Makefile
> @@ -14,6 +14,7 @@ obj-y                                 += st/
>  obj-y                                  += starfive/
>  obj-y                                  += sunxi/
>  obj-y                                  += tegra/
> +obj-y                                  += thead/
>  obj-y                                  += ti/
>  obj-y                                  += xilinx/
>  obj-y                                  += core.o governor.o
> diff --git a/drivers/pmdomain/thead/Kconfig b/drivers/pmdomain/thead/Kconfig
> new file mode 100644
> index 000000000000..c7a1ac0c61dc
> --- /dev/null
> +++ b/drivers/pmdomain/thead/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config TH1520_PM_DOMAINS
> +       tristate "Support TH1520 Power Domains"
> +       depends on TH1520_AON_PROTOCOL || !TH1520_AON_PROTOCOL
> +       select REGMAP_MMIO
> +       help
> +         This driver enables power domain management for the T-HEAD
> +         TH-1520 SoC. On this SoC there are number of power domains,
> +         which can be managed independently. For example GPU, NPU,
> +         and DPU reside in their own power domains which can be
> +         turned on/off.
> diff --git a/drivers/pmdomain/thead/Makefile b/drivers/pmdomain/thead/Makefile
> new file mode 100644
> index 000000000000..adfdf5479c68
> --- /dev/null
> +++ b/drivers/pmdomain/thead/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_TH1520_PM_DOMAINS)                += th1520-pm-domains.o
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
> new file mode 100644
> index 000000000000..d913ad40fb76
> --- /dev/null
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + * Copyright (c) 2024 Samsung Electronics Co., Ltd.
> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
> + */
> +
> +#include <linux/firmware/thead/thead,th1520-aon.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +
> +#include <dt-bindings/firmware/thead,th1520-aon.h>
> +
> +struct th1520_power_domain {
> +       struct th1520_aon_chan *aon_chan;
> +       struct generic_pm_domain genpd;
> +       u32 rsrc;
> +};
> +
> +struct th1520_power_info {
> +       const char *name;
> +       u32 rsrc;
> +};
> +
> +static const struct th1520_power_info th1520_pd_ranges[] = {
> +       { "vdec", TH1520_AON_VDEC_PD },
> +       { "npu", TH1520_AON_NPU_PD },
> +       { "venc", TH1520_AON_VENC_PD },
> +       { "gpu", TH1520_AON_GPU_PD },
> +       { "dsp0", TH1520_AON_DSP0_PD },
> +       { "dsp1", TH1520_AON_DSP1_PD }
> +};
> +
> +static inline struct th1520_power_domain *
> +to_th1520_power_domain(struct generic_pm_domain *genpd)
> +{
> +       return container_of(genpd, struct th1520_power_domain, genpd);
> +}
> +
> +static int th1520_pd_power_on(struct generic_pm_domain *domain)
> +{
> +       struct th1520_power_domain *pd = to_th1520_power_domain(domain);
> +
> +       return th1520_aon_power_update(pd->aon_chan, pd->rsrc, true);
> +}
> +
> +static int th1520_pd_power_off(struct generic_pm_domain *domain)
> +{
> +       struct th1520_power_domain *pd = to_th1520_power_domain(domain);
> +
> +       return th1520_aon_power_update(pd->aon_chan, pd->rsrc, false);
> +}
> +
> +static struct generic_pm_domain *th1520_pd_xlate(const struct of_phandle_args *spec,
> +                                                void *data)
> +{
> +       struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
> +       struct genpd_onecell_data *pd_data = data;
> +       unsigned int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(th1520_pd_ranges); i++) {
> +               struct th1520_power_domain *pd;
> +
> +               pd = to_th1520_power_domain(pd_data->domains[i]);
> +               if (pd->rsrc == spec->args[0]) {
> +                       domain = &pd->genpd;
> +                       break;
> +               }
> +       }
> +
> +       return domain;
> +}
> +
> +static struct th1520_power_domain *
> +th1520_add_pm_domain(struct device *dev, const struct th1520_power_info *pi)
> +{
> +       struct th1520_power_domain *pd;
> +       int ret;
> +
> +       pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pd->rsrc = pi->rsrc;
> +       pd->genpd.power_on = th1520_pd_power_on;
> +       pd->genpd.power_off = th1520_pd_power_off;
> +       pd->genpd.name = pi->name;
> +
> +       ret = pm_genpd_init(&pd->genpd, NULL, true);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return pd;
> +}
> +
> +static void th1520_pd_init_all_off(struct generic_pm_domain **domains,
> +                                  struct device *dev)
> +{
> +       int ret;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(th1520_pd_ranges); i++) {
> +               struct th1520_power_domain *pd =
> +                       to_th1520_power_domain(domains[i]);
> +
> +               ret = th1520_aon_power_update(pd->aon_chan, pd->rsrc, false);
> +               if (ret)
> +                       dev_err(dev,
> +                               "Failed to initially power down power domain %s\n",
> +                               pd->genpd.name);
> +       }
> +}
> +
> +static int th1520_pd_probe(struct platform_device *pdev)
> +{
> +       struct generic_pm_domain **domains;
> +       struct genpd_onecell_data *pd_data;
> +       struct th1520_aon_chan *aon_chan;
> +       struct device *dev = &pdev->dev;
> +       int i;
> +
> +       aon_chan = dev_get_drvdata(dev->parent);
> +       if (!aon_chan) {
> +               dev_err(dev, "Failed to get AON channel from parent\n");
> +               return -EINVAL;
> +       }
> +
> +       domains = devm_kcalloc(dev, ARRAY_SIZE(th1520_pd_ranges),
> +                              sizeof(*domains), GFP_KERNEL);
> +       if (!domains)
> +               return -ENOMEM;
> +
> +       pd_data = devm_kzalloc(dev, sizeof(*pd_data), GFP_KERNEL);
> +       if (!pd_data)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < ARRAY_SIZE(th1520_pd_ranges); i++) {
> +               struct th1520_power_domain *pd;
> +
> +               pd = th1520_add_pm_domain(dev, &th1520_pd_ranges[i]);
> +               if (IS_ERR(pd))
> +                       return PTR_ERR(pd);
> +
> +               pd->aon_chan = aon_chan;
> +               domains[i] = &pd->genpd;
> +               dev_dbg(dev, "added power domain %s\n", pd->genpd.name);
> +       }
> +
> +       pd_data->domains = domains;
> +       pd_data->num_domains = ARRAY_SIZE(th1520_pd_ranges);
> +       pd_data->xlate = th1520_pd_xlate;
> +
> +       /*
> +        * Initialize all power domains to off to ensure they start in a
> +        * low-power state. This allows device drivers to manage power
> +        * domains by turning them on or off as needed.
> +        */
> +       th1520_pd_init_all_off(domains, dev);
> +
> +       return of_genpd_add_provider_onecell(dev->parent->of_node, pd_data);
> +}
> +
> +static struct platform_driver th1520_pd_driver = {
> +       .driver = {
> +               .name = "th1520-pd",
> +       },
> +       .probe = th1520_pd_probe,
> +};
> +module_platform_driver(th1520_pd_driver);
> +
> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
> +MODULE_DESCRIPTION("T-HEAD TH1520 SoC power domain controller");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

