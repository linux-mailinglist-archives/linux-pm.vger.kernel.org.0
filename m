Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD33C3E2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbfFKGTI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 02:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391197AbfFKGTI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 02:19:08 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A22E621721;
        Tue, 11 Jun 2019 06:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560233947;
        bh=zAg8BR5dmZHz0GhzDvxgmJ5z7bh7GV7MwQeYYOMSX8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VENhbnFYbx/WXplXzFt6V2uVy6xWv2QvdsHchlMRUvn32aFmfEa/RTLFqgesbtn7a
         5Vn2Pl8EMdrkfaVw3fIq0zfvUM0Q6FN5bAHhKFqUaH81Gaozj3UVn4jWpZz5GIRijB
         AjncSa6k0Zf7WTR3+JgvIiX7XVVWsHhQgs7nZpTo=
Received: by mail-lj1-f182.google.com with SMTP id s21so10340234lji.8;
        Mon, 10 Jun 2019 23:19:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWRQUeKrQBFhSb5QpYQmXjbsKxp+A+rPa86YWrYD4KvDXSzutjh
        zxt1519XhpNhh1R95M7tlfyG+tx7jiWwZpVCw9k=
X-Google-Smtp-Source: APXvYqxCFe4p5zlRmaqB4z0m9SNAEZkRno1BZHx+dIcGSMw57gobxcdysDyFElC+91e5QK0Z6gFqPQzkY5U87LkuzcY=
X-Received: by 2002:a2e:9e83:: with SMTP id f3mr16999335ljk.47.1560233944850;
 Mon, 10 Jun 2019 23:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190607143531eucas1p11f6b3a63068d529dae8be16abaa60ed0@eucas1p1.samsung.com>
 <20190607143507.30286-1-l.luba@partner.samsung.com> <20190607143507.30286-9-l.luba@partner.samsung.com>
In-Reply-To: <20190607143507.30286-9-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 11 Jun 2019 08:18:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdKGG25T46d+SmES7wyQ=kAMj2jdT3GCYa+z87wpYKNEQ@mail.gmail.com>
Message-ID: <CAJKOXPdKGG25T46d+SmES7wyQ=kAMj2jdT3GCYa+z87wpYKNEQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/13] drivers: memory: add DMC driver for Exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 7 Jun 2019 at 16:35, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds driver for Exynos5422 Dynamic Memory Controller.
> The driver provides support for dynamic frequency and voltage scaling for
> DMC and DRAM. It supports changing timings of DRAM running with different
> frequency. There is also an algorithm to calculate timigns based on
> memory description provided in DT.
> The patch also contains needed MAINTAINERS file update.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                             |    8 +
>  drivers/memory/samsung/Kconfig          |   17 +
>  drivers/memory/samsung/Makefile         |    1 +
>  drivers/memory/samsung/exynos5422-dmc.c | 1261 +++++++++++++++++++++++
>  4 files changed, 1287 insertions(+)
>  create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

(...)

> +
> +/**
> + * exynos5_performance_counters_init() - Initializes performance DMC's counters
> + * @dmc:       DMC for which it does the setup
> + *
> + * Initialization of performance counters in DMC for estimating usage.
> + * The counter's values are used for calculation of a memory bandwidth and based
> + * on that the governor changes the frequency.
> + * The counters are not used when the governor is GOVERNOR_USERSPACE.
> + */
> +static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
> +{
> +       int counters_size;
> +       int ret, i;
> +
> +       dmc->num_counters = devfreq_event_get_edev_count(dmc->dev);
> +       if (dmc->num_counters < 0) {
> +               dev_err(dmc->dev, "could not get devfreq-event counters\n");
> +               return dmc->num_counters;
> +       }
> +
> +       counters_size = sizeof(struct devfreq_event_dev) * dmc->num_counters;
> +       dmc->counter = devm_kzalloc(dmc->dev, counters_size, GFP_KERNEL);
> +       if (!dmc->counter)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < dmc->num_counters; i++) {
> +               dmc->counter[i] =
> +                       devfreq_event_get_edev_by_phandle(dmc->dev, i);
> +               if (IS_ERR_OR_NULL(dmc->counter[i]))
> +                       return -EPROBE_DEFER;
> +       }
> +
> +       ret = exynos5_counters_enable_edev(dmc);
> +       if (ret < 0) {
> +               dev_err(dmc->dev, "could not enable event counter\n");
> +               return ret;
> +       }
> +
> +       ret = exynos5_counters_set_event(dmc);
> +       if (ret < 0) {
> +               dev_err(dmc->dev, "counld not set event counter\n");

Missing cleanup - edev counters disable.

> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_set_pause_on_switching() - Controls a pause feature in DMC
> + * @dmc:       device which is used for changing this feature
> + * @set:       a boolean state passing enable/disable request
> + *
> + * There is a need of pausing DREX DMC when divider or MUX in clock tree
> + * changes its configuration. In such situation access to the memory is blocked
> + * in DMC automatically. This feature is used when clock frequency change
> + * request appears and touches clock tree.
> + */
> +static inline int exynos5_dmc_set_pause_on_switching(struct exynos5_dmc *dmc)
> +{
> +       unsigned int val;
> +       int ret;
> +
> +       ret = regmap_read(dmc->clk_regmap, CDREX_PAUSE, &val);
> +       if (ret)
> +               return ret;
> +
> +       val |= 1UL;
> +       regmap_write(dmc->clk_regmap, CDREX_PAUSE, val);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_probe() - Probe function for the DMC driver
> + * @pdev:      platform device for which the driver is going to be initialized
> + *
> + * Initialize basic components: clocks, regulators, performance counters, etc.
> + * Read out product version and based on the information setup
> + * internal structures for the controller (frequency and voltage) and for DRAM
> + * memory parameters: timings for each operating frequency.
> + * Register new devfreq device for controlling DVFS of the DMC.
> + */
> +static int exynos5_dmc_probe(struct platform_device *pdev)
> +{
> +       int ret = 0;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct exynos5_dmc *dmc;
> +       struct resource *res;
> +
> +       dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
> +       if (!dmc)
> +               return -ENOMEM;
> +
> +       mutex_init(&dmc->lock);
> +
> +       dmc->dev = dev;
> +       platform_set_drvdata(pdev, dmc);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       dmc->base_drexi0 = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(dmc->base_drexi0))
> +               return PTR_ERR(dmc->base_drexi0);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       dmc->base_drexi1 = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(dmc->base_drexi1))
> +               return PTR_ERR(dmc->base_drexi1);
> +
> +       dmc->clk_regmap = syscon_regmap_lookup_by_phandle(np,
> +                               "samsung,syscon-clk");
> +       if (IS_ERR(dmc->clk_regmap))
> +               return PTR_ERR(dmc->clk_regmap);
> +
> +       ret = exynos5_init_freq_table(dmc, &exynos5_dmc_df_profile);
> +       if (ret) {
> +               dev_warn(dev, "couldn't initialize frequency settings\n");
> +               return ret;
> +       }
> +
> +       dmc->vdd_mif = devm_regulator_get(dev, "vdd");
> +       if (IS_ERR(dmc->vdd_mif)) {
> +               ret = PTR_ERR(dmc->vdd_mif);
> +               return ret;
> +       }
> +
> +       ret = exynos5_dmc_init_clks(dmc);
> +       if (ret)
> +               return ret;
> +
> +       ret = of_get_dram_timings(dmc);
> +       if (ret) {
> +               dev_warn(dev, "couldn't initialize timings settings\n");

goto remove_clocks;

> +               return ret;
> +       }
> +
> +       ret = exynos5_performance_counters_init(dmc);
> +       if (ret) {
> +               dev_warn(dev, "couldn't probe performance counters\n");
> +               goto remove_clocks;
> +       }
> +
> +       ret = exynos5_dmc_set_pause_on_switching(dmc);
> +       if (ret) {
> +               dev_warn(dev, "couldn't get access to PAUSE register\n");
> +               goto remove_clocks;

goto err_devfreq_add;

Best regards,
Krzysztof

> +       }
> +
> +       /*
> +        * Setup default thresholds for the devfreq governor.
> +        * The values are chosen based on experiments.
> +        */
> +       dmc->gov_data.upthreshold = 30;
> +       dmc->gov_data.downdifferential = 5;
> +
> +       dmc->df = devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
> +                                         DEVFREQ_GOV_USERSPACE,
> +                                         &dmc->gov_data);
> +
> +       if (IS_ERR(dmc->df)) {
> +               ret = PTR_ERR(dmc->df);
> +               goto err_devfreq_add;
> +       }
> +
> +       dev_info(dev, "DMC initialized\n");
> +
> +       return 0;
> +
> +err_devfreq_add:
> +       exynos5_counters_disable_edev(dmc);
> +remove_clocks:
> +       clk_disable_unprepare(dmc->mout_bpll);
> +       clk_disable_unprepare(dmc->fout_bpll);
> +
> +       return ret;
> +}
> +
>
