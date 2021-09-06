Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB00401919
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbhIFJpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbhIFJpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 05:45:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB9C061575
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 02:44:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g14so5234185pfm.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 02:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fdCtbBYQ/PbhDaRGww8WvWvNG3K6421Ly2OyMudY+g=;
        b=nu6zVxvMTCUcU1kFqIrZtxEIa8LOtsEiLY8/fh67CoszQ/i5N3ehZ4nusDbBcELVoU
         G6d3N/kOC1p0CbFjXTppZQQVk/R7QxYekOi7ydCeLF5JBooZdtaIrC22+nVKZjTSS4EX
         c6fHHwZ8ziA2Cp5M/hzMGqyz1Zzc20DiP8WRn1+r0QNFiimWBQtQQ3Ibk7kx4I0h+ZFm
         Wrurc3mdZsBvUo4/svijHyrPuayLn6jJWoeFtZDXQZy/R8sjJTc7Pn22zILuhU/uZOiK
         WR0QB8xrAVzDJba5IRpF07K3Tkxp9Zui0Zf6EfX5d6d6qW0tWAwnHO7Ida93K+cuL/ab
         IxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fdCtbBYQ/PbhDaRGww8WvWvNG3K6421Ly2OyMudY+g=;
        b=nyT9zTGenI9C+9Rww+fLXcBiGSIVvcDkDY+L/l4GRGcGqBl2gnnQJZGN3UrJC/fhmY
         KE1oh/gu9YZBwyRk8sEV8f37w8lWgC1ZtKsdCOZFu9ES+jEiIVucdSyjiFF/XvagRQES
         Z5ugoknDZAOomz0IFJk22PNeQxqxAqrW8jRTQEVKx1/nx4fn0+q3jAYhq9APHD1Noe99
         S0mk1sKgXR1kaETFwzQ+xlq3PRAXkXI4DbARNndvysOrNxdyORJ2ivgSo7lblreWricx
         fF13ux62eUXcG+Q5GMDcs+vdKFvKvQJhBrn2EMsrjys0ElCs0HYmmczxI+5WI5n5gwq7
         X1kQ==
X-Gm-Message-State: AOAM532i1qtNqFR4cHsFkEvMblXsTO5Msu0XNJDEYPzj7pWyISPKTkBk
        UP2PmZxq3Qu9Y0+HJwKW+4Imaw==
X-Google-Smtp-Source: ABdhPJwfXM4+jjhjXvhIy4LyWObIRTANV0ysLDQeZwmr3hjSYRCZBrmjzwR4mFPjdgmhAUPpJHAGLA==
X-Received: by 2002:a63:c045:: with SMTP id z5mr11460233pgi.374.1630921453591;
        Mon, 06 Sep 2021 02:44:13 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id g11sm7527702pgn.41.2021.09.06.02.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 02:44:13 -0700 (PDT)
Date:   Mon, 6 Sep 2021 15:14:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v15 3/3] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210906094411.q55crm4cfcjpffau@vireshk-i7>
References: <1630658364-6192-1-git-send-email-hector.yuan@mediatek.com>
 <1630658364-6192-4-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630658364-6192-4-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-09-21, 16:39, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Introduce cpufreq HW driver which can support
> CPU frequency adjust in MT6779 platform.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  drivers/cpufreq/Kconfig.arm           |   12 ++
>  drivers/cpufreq/Makefile              |    1 +
>  drivers/cpufreq/mediatek-cpufreq-hw.c |  340 +++++++++++++++++++++++++++++++++
>  3 files changed, 353 insertions(+)
>  create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c

Here as well, I have added below diff to the original patch. Lemme
know if you don't like something.

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 9c6df1b00f3e..0cf18dd46b92 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -33,12 +33,6 @@ enum {
        REG_ARRAY_SIZE,
 };

-struct mtk_cpufreq_drv;
-
-struct mtk_cpufreq_drv {
-       const u16 *offsets;
-};
-
 struct mtk_cpufreq_data {
        struct cpufreq_frequency_table *table;
        void __iomem *reg_bases[REG_ARRAY_SIZE];
@@ -126,8 +120,8 @@ static int mtk_cpu_create_freq_table(struct platform_device *pdev,
                                     struct mtk_cpufreq_data *data)
 {
        struct device *dev = &pdev->dev;
-       void __iomem *base_table;
        u32 temp, i, freq, prev_freq = 0;
+       void __iomem *base_table;

        data->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
                                   sizeof(*data->table), GFP_KERNEL);
@@ -198,15 +192,13 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
        struct platform_device *pdev = cpufreq_get_driver_data();
-       struct mtk_cpufreq_drv *drv = platform_get_drvdata(pdev);
        int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
        struct mtk_cpufreq_data *data;
-       struct device *cpu_dev;
        unsigned int latency;
        int ret;

        /* Get the bases of cpufreq for domains */
-       ret = mtk_cpu_resources_init(pdev, policy, drv->offsets);
+       ret = mtk_cpu_resources_init(pdev, policy, platform_get_drvdata(pdev));
        if (ret) {
                dev_info(&pdev->dev, "CPUFreq resource init failed\n");
                return ret;
@@ -218,9 +210,7 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
        if (!latency)
                latency = CPUFREQ_ETERNAL;

-       /* us convert to ns */
        policy->cpuinfo.transition_latency = latency;
-
        policy->fast_switch_possible = true;

        /* HW should be in enabled state to proceed now */
@@ -237,12 +227,6 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
                pr_info("SVS of CPU%d is not enabled\n", policy->cpu);
        }

-       cpu_dev = get_cpu_device(policy->cpu);
-       if (!cpu_dev) {
-               pr_info("failed to get cpu%d device\n", policy->cpu);
-               return -ENODEV;
-       }
-
        return 0;
 }

@@ -261,9 +245,6 @@ static void mtk_cpufreq_register_em(struct cpufreq_policy *policy)
        struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
        struct mtk_cpufreq_data *data = policy->driver_data;

-       if (!data->nr_opp)
-               return;
-
        em_dev_register_perf_domain(get_cpu_device(policy->cpu), data->nr_opp,
                                    &em_cb, policy->cpus, true);
 }
@@ -285,22 +266,14 @@ static struct cpufreq_driver cpufreq_mtk_hw_driver = {

 static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
-       struct mtk_cpufreq_drv *drv;
-       const u16 *offsets;
+       const void *data;
        int ret;

-       offsets = of_device_get_match_data(&pdev->dev);
-       if (!offsets)
+       data = of_device_get_match_data(&pdev->dev);
+       if (!data)
                return -EINVAL;

-       drv = kzalloc(sizeof(*drv), GFP_KERNEL);
-       if (!drv)
-               return -ENOMEM;
-
-       drv->offsets = offsets;
-
-       platform_set_drvdata(pdev, drv);
-
+       platform_set_drvdata(pdev, (void *) data);
        cpufreq_mtk_hw_driver.driver_data = pdev;

        ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
@@ -312,11 +285,6 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)

 static int mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
 {
-       struct mtk_cpufreq_drv *drv = platform_get_drvdata(pdev);
-
-       kfree(drv->offsets);
-       kfree(drv);
-
        return cpufreq_unregister_driver(&cpufreq_mtk_hw_driver);
 }

