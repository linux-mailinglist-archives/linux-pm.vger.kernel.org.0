Return-Path: <linux-pm+bounces-33869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB5B44459
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7C71785F8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F130FC0D;
	Thu,  4 Sep 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAHMNRgm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8D30ACFD;
	Thu,  4 Sep 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006937; cv=none; b=eHtsZXhVuKxB3swPoWARx+eVEZJ4jthmLQAeQNCb52l0PfWg7bt8BZSBJcxprG2GTBApe93WeCDkZaltarwlxE75fN8PqRP8p3KH9Ts7OMSmFf3lJxOYCxpp6W5ooQnUiZKegYJ3Z7ImkA0C65jSmeRoTGyXGGApqsnv1IL2nwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006937; c=relaxed/simple;
	bh=NhkIXhC7w+TGOm3iyYU2TFlcEu/S0DW0XgNG9zQEOMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPrqS61T9YfpGDA3t+lUha4ZGrbFkUMiB6p7tgzBYNXtapYRJmFq/0G6bqS0SAjHkAIKGJqhsFYO6cKxnYMlUGZQiHqTOFYQQ3Ung0n0g0muFw+yl7eZEMD5KljBL0pI5Gp+s2gJvCG9stsHo07XdElpo7/UxyrUouxlJ2d6rjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAHMNRgm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f76454f69so1254936e87.0;
        Thu, 04 Sep 2025 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757006933; x=1757611733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSwI61WL8IVeh7wDpcBrc2Ynj3mrDWJKVAn398YwFXU=;
        b=dAHMNRgm/qQxxcu/9HodPQKfAKgvsjcDBltjedHVZjzl/K96iJFGoCosXVqEkotgYm
         Ifr/wCxgoFxTwIRXrIkDrwt+ZzyX4migM3lHIclU+gjg5kFPiAqBNIxfQXfi9r9MrOjC
         OXNRjo+PpaE506T+sVuHXp6MLilcG0De9bwe0e9jpdfW+gQxaOsfcO26Kg8N4Ptoup4v
         ocYMix8l07e3utAQs5mYoTCqZJpVOQhmzdkvg2HFq7lyelpgZNQviC+X8+WzCPuamI2y
         ZqBhkXPqAtKt8zaQr0+OvOPWZdDFGXB4gPotaDJS5X1+ZfnNA7eke9v/C9IgExX3d4f6
         glBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757006933; x=1757611733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSwI61WL8IVeh7wDpcBrc2Ynj3mrDWJKVAn398YwFXU=;
        b=DtmWLXIi7Pz8enDFtdZ46T3U4DsmHKytnAcbFO73w4lpuR2E8y6ESredqdzWKR1T/9
         j3PV713nHprCaTFvBWdOHzHP7Q8AAsSPfaUOZtxSjZqzIZVABi2lGQBrZrqA/KF1a+HK
         AXQ80o3b8Q44k89lNUmzkbBLcWvUHqqTq/AdyYXg7tyJCzrx7m/67z8wR4BPxmKVeLEv
         3M6LWe5U9by39i5vADWB8pmTy2FEalYbTf3OMM07yZY9w53iJjtwLUXtOUNxJsI+nPJN
         m+xqMFivqICIfvYAhsehGZHGgZ1tgs7MmC/xNDu1gWAHf/dVujWmxdvWVcoPYoGsx9UM
         9mLg==
X-Forwarded-Encrypted: i=1; AJvYcCVPsvXYzSQs0r+8b3KmJKW2m11a1h23uZKo/VMBXj9txTkorn3nkTDMFT9XtiW77e4M2SwlZ1yHCQg=@vger.kernel.org, AJvYcCVtLDYuDvxjiCnBBCkrCrIeK2oAiv8gRP24Wg5Shsef/0yvcSfPwgT57yo9Lfl/ZoOgQZfHaSHTKRHPoFU=@vger.kernel.org, AJvYcCXOlnw0hFI+ivaC3H4g5QGUazJjyqhHnXZD9GukdAktDJqK9kyfhLLwgggNBAaviPyQPdcFPyBHDJ1TVKQ6@vger.kernel.org, AJvYcCXShZpn7KlBvr8sUrP20CixlwoIUjdsJozDAiJqSKGsU5W4v7UbzAKSj/11ify6A1+Fq2xTyTHYKpd7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bVBt8sKqXjo+C4ldTsSGvpTmQ8GMppJLfKgDEeT+kx8wgwqH
	eQddwzZCIYquqv3mnGkQLn3elxTgsvH4VQgvZZ+XtqCgme1zL72y8scHVrgnep+LGhQG3WoM05o
	PPCSe6eV/0xJXtVT94jxz98rRVqbp9SE=
X-Gm-Gg: ASbGncuBiw3ZassVHAIxuqXsdlolt6jZwYjJ94+BPqVqgYpWISMWTqGbIB3vCqpQGg4
	TCeaxaGBwoBKNpbWGJJhQWoM25Vqja4WpolNSl5ty1Y//3iYC7mqKrN7IsfVilX65R/qST8KAR/
	y7dniVvoMdx/oCpF6jKuO2iST1crzLm0utsYVwAX37MVzJeymv7P6M8b+dxcWWqvuNZjHW7Hjet
	lYfZqqBIyh2rF9Gtw==
X-Google-Smtp-Source: AGHT+IEmKm5z3+4UsCNF7tYNuaX/TlayQR+W73dq374TEwEYPRINixXfuytelD0RucR69hGpw712dsVZsY4MlOCqjzs=
X-Received: by 2002:a05:6512:b8a:b0:55f:6831:6ef9 with SMTP id
 2adb3069b0e04-55f70969065mr6172160e87.46.1757006932917; Thu, 04 Sep 2025
 10:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-5-e0d534d4f8ea@gmail.com> <20250904-aloof-cow-of-speed-ad5fe5@kuoka>
In-Reply-To: <20250904-aloof-cow-of-speed-ad5fe5@kuoka>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 4 Sep 2025 12:28:40 -0500
X-Gm-Features: Ac12FXwoUbHXbnjPltBaIDA6qIv1rYOBoXszdGWN7uaYcYD8LQamV8-PcX0xrq8
Message-ID: <CALHNRZ-A6L1s_Uc0cO-+akHyzHGkb4bkYd0pNKX96DqJfOBp9g@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] memory: tegra210: Support interconnect framework
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:17=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Wed, Sep 03, 2025 at 02:50:11PM -0500, Aaron Kling wrote:
> > This makes mc and emc interconnect providers and allows for dynamic
> > memory clock scaling.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/memory/tegra/Kconfig             |   1 +
> >  drivers/memory/tegra/tegra210-emc-core.c | 274 +++++++++++++++++++++++=
+++++++-
> >  drivers/memory/tegra/tegra210-emc.h      |  23 +++
> >  drivers/memory/tegra/tegra210.c          |  81 +++++++++
> >  4 files changed, 377 insertions(+), 2 deletions(-)
>
> Patch #3 was memory, patch #4 was soc, patch #5 is memory, so that
> mixup pattern continues.
>
> Please address the earlier feedback.

Alright, I double check the docs and re-order this and my other series
for the next revisions. I had a misunderstanding how subsystems were
split up, which caused most but not all of the issues.

>
> >
> > diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfi=
g
> > index fc5a277918267ee8240f9fb9efeb80275db4790b..2d0be29afe2b9ebf9a0630e=
f7fb6fb43ff359499 100644
> > --- a/drivers/memory/tegra/Kconfig
> > +++ b/drivers/memory/tegra/Kconfig
> > @@ -55,6 +55,7 @@ config TEGRA210_EMC
> >       tristate "NVIDIA Tegra210 External Memory Controller driver"
> >       depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
> >       select TEGRA210_EMC_TABLE
> > +     select PM_OPP
> >       help
> >         This driver is for the External Memory Controller (EMC) found o=
n
> >         Tegra210 chips. The EMC controls the external DRAM on the board=
.
> > diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/=
tegra/tegra210-emc-core.c
> > index e96ca4157d48182574310f8caf72687bed7cc16a..f12e60b47fa87d629505cde=
57310d2bb68fc87f3 100644
> > --- a/drivers/memory/tegra/tegra210-emc-core.c
> > +++ b/drivers/memory/tegra/tegra210-emc-core.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_opp.h>
> >  #include <linux/slab.h>
> >  #include <linux/thermal.h>
> >  #include <soc/tegra/fuse.h>
> > @@ -1569,6 +1570,79 @@ static int tegra210_emc_set_rate(struct device *=
dev,
> >       return 0;
> >  }
> >
>
> ...
>
> > @@ -1758,6 +1832,193 @@ static void tegra210_emc_debugfs_init(struct te=
gra210_emc *emc)
> >                           &tegra210_emc_debug_temperature_fops);
> >  }
> >
> > +static inline struct tegra210_emc *
> > +to_tegra210_emc_provider(struct icc_provider *provider)
> > +{
> > +     return container_of(provider, struct tegra210_emc, icc_provider);
> > +}
> > +
> > +static struct icc_node_data *
> > +emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *da=
ta)
> > +{
> > +     struct icc_provider *provider =3D data;
> > +     struct icc_node_data *ndata;
> > +     struct icc_node *node;
> > +
> > +     /* External Memory is the only possible ICC route */
> > +     list_for_each_entry(node, &provider->nodes, node_list) {
> > +             if (node->id !=3D TEGRA_ICC_EMEM)
> > +                     continue;
> > +
> > +             ndata =3D kzalloc(sizeof(*ndata), GFP_KERNEL);
> > +             if (!ndata)
> > +                     return ERR_PTR(-ENOMEM);
> > +
> > +             /*
> > +              * SRC and DST nodes should have matching TAG in order to=
 have
> > +              * it set by default for a requested path.
> > +              */
> > +             ndata->tag =3D TEGRA_MC_ICC_TAG_ISO;
> > +             ndata->node =3D node;
> > +
> > +             return ndata;
> > +     }
> > +
> > +     return ERR_PTR(-EPROBE_DEFER);
> > +}
> > +
> > +static int emc_icc_set(struct icc_node *src, struct icc_node *dst)
> > +{
> > +     struct tegra210_emc *emc =3D to_tegra210_emc_provider(dst->provid=
er);
> > +     unsigned long long peak_bw =3D icc_units_to_bps(dst->peak_bw);
> > +     unsigned long long avg_bw =3D icc_units_to_bps(dst->avg_bw);
> > +     unsigned long long rate =3D max(avg_bw, peak_bw);
> > +     const unsigned int ddr =3D 2;
>
> Just use defines in top part for this.
>
> > +     int err;
> > +
> > +     /*
> > +      * Tegra210 memory layout can be 1 channel at 64-bit or 2 channel=
s
> > +      * at 32-bit each. Either way, the total bus width will always be
> > +      * 64-bit.
> > +      */
> > +     const unsigned int dram_data_bus_width_bytes =3D 64 / 8;
>
> Same here.
>
> > +
> > +     /*
> > +      * Tegra210 EMC runs on a clock rate of SDRAM bus. This means tha=
t
> > +      * EMC clock rate is twice smaller than the peak data rate becaus=
e
> > +      * data is sampled on both EMC clock edges.
> > +      */
> > +     do_div(rate, ddr * dram_data_bus_width_bytes);
> > +     rate =3D min_t(u64, rate, U32_MAX);
> > +
> > +     err =3D emc_set_min_rate(emc, rate, EMC_RATE_ICC);
> > +     if (err)
> > +             return err;
> > +
> > +     return 0;
> > +}
> > +
> > +static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, =
u32 *peak)
> > +{
> > +     *avg =3D 0;
> > +     *peak =3D 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int tegra_emc_interconnect_init(struct tegra210_emc *emc)
> > +{
> > +     const struct tegra_mc_soc *soc =3D emc->mc->soc;
> > +     struct icc_node *node;
> > +     int err;
> > +
> > +     emc->icc_provider.dev =3D emc->dev;
> > +     emc->icc_provider.set =3D emc_icc_set;
> > +     emc->icc_provider.data =3D &emc->icc_provider;
> > +     emc->icc_provider.aggregate =3D soc->icc_ops->aggregate;
> > +     emc->icc_provider.xlate_extended =3D emc_of_icc_xlate_extended;
> > +     emc->icc_provider.get_bw =3D tegra_emc_icc_get_init_bw;
> > +
> > +     icc_provider_init(&emc->icc_provider);
> > +
> > +     /* create External Memory Controller node */
> > +     node =3D icc_node_create(TEGRA_ICC_EMC);
> > +     if (IS_ERR(node)) {
> > +             err =3D PTR_ERR(node);
> > +             goto err_msg;
> > +     }
> > +
> > +     node->name =3D "External Memory Controller";
> > +     icc_node_add(node, &emc->icc_provider);
> > +
> > +     /* link External Memory Controller to External Memory (DRAM) */
> > +     err =3D icc_link_create(node, TEGRA_ICC_EMEM);
> > +     if (err)
> > +             goto remove_nodes;
> > +
> > +     /* create External Memory node */
> > +     node =3D icc_node_create(TEGRA_ICC_EMEM);
> > +     if (IS_ERR(node)) {
> > +             err =3D PTR_ERR(node);
> > +             goto remove_nodes;
> > +     }
> > +
> > +     node->name =3D "External Memory (DRAM)";
> > +     icc_node_add(node, &emc->icc_provider);
> > +
> > +     err =3D icc_provider_register(&emc->icc_provider);
> > +     if (err)
> > +             goto remove_nodes;
> > +
> > +     return 0;
> > +
> > +remove_nodes:
> > +     icc_nodes_remove(&emc->icc_provider);
> > +err_msg:
> > +     dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
> > +
> > +     return err;
> > +}
> > +
> > +static int tegra_emc_opp_table_init(struct tegra210_emc *emc)
> > +{
> > +     u32 hw_version =3D BIT(tegra_sku_info.soc_speedo_id);
> > +     struct dev_pm_opp *opp;
> > +     unsigned long rate;
> > +     int opp_token, err, max_opps, i;
> > +
> > +     err =3D dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
> > +     if (err < 0) {
> > +             dev_err(emc->dev, "failed to set OPP supported HW: %d\n",=
 err);
> > +             return err;
> > +     }
> > +     opp_token =3D err;
> > +
> > +     err =3D dev_pm_opp_of_add_table(emc->dev);
> > +     if (err) {
> > +             if (err =3D=3D -ENODEV)
> > +                     dev_err(emc->dev, "OPP table not found, please up=
date your device tree\n");
>
> So this looks like the actual ABI break.

Okay, so let's discuss this. For reference, I based this patch off the
tegra124 change [0], which also caused an abi break. I know past
changes don't justify current mistakes, but this is the context. This
series adds all new required dt properties to the arch common dtsi, so
any newly compiled dtb will work. Any old dtb with a new kernel would
fail to probe, however. I think it would be safe to just skip the
interconnect init if the opp table init returns ENODEV, then let probe
succeed, but I would have to verify that. Do I need to do that and
drop the new requires from the binding?

Aaron

[0] https://github.com/torvalds/linux/commit/380def2d4cf257663de42618e57134=
afeded32dd#diff-3ff603a1ea7654928390eb213cea0424b6a12251bccbb5fd3b9720402a3=
c076aR1435

