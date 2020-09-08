Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FB2620B2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgIHUNU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbgIHPLM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 11:11:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592C4C00459E
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 08:10:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so8435022pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WMfNlCWPtAqmjDJxph15Yqjhyln52B42k3Q64GJ4H6E=;
        b=bEBF0b7OmHxXWU3T4erE6RtHmTBN2sFOfCTvj3s6JlO1gzOT7nH1ho3loAv3RlavLS
         aFLA5GwG11lOwAkxx1WOwtkVO9q9eBCNNMR2Dcr2Vz4YxGYauy5eAZhVVsjS740dofMD
         Y+Xf32sHb4wQ7C10XWNR6aFKSq4489bojRkGAxCy6lFAFSdJO4nEkMpnellpkiKkFXwL
         mLmespMiSQnpdUlIBZY8bc6g6ImUxVdgZ6XcYxxHk+s2pUlc5aYTa+g4GMLMgHlX3Q6a
         fumvQNi4s7830y+sJmzYNJupTxzWzI5XOSpX4XUT6IMBJH2W0M81+dlM9GYy4Dibp+Ld
         aOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WMfNlCWPtAqmjDJxph15Yqjhyln52B42k3Q64GJ4H6E=;
        b=Lzcr6mdz9wWpA5xSQ++FWWMcID0xLvVXt99yF6KuTAjKzc2uSzaDVnB1xgC5Uk2jce
         pz94Doa40zV32v2A6zfbFRoJ+d1QdsEAKPSDivYoKaEMy6GRUGWgrwc8TX41nuGzuvlu
         ELTrKUy05+l2pagpexG2+KRIA/yXHJabVeTf44o2OqHWlHpkV8c4fk/TT72lVko3y7LS
         gUoiPpei4Bh2K+JYqgdH7eGUpjvN6Og/atGNO9K/32lmWYMYwtlg11R2yLZsN0QsgTWA
         jVLOzl2Wxjwz9B3ag2VK0+x2bqnKcksBJgodRJjZq4nzcISe1vaTmhAYKhX1nvBqsQLe
         osGA==
X-Gm-Message-State: AOAM532OELC0MUsHMs4ojQ46VV0pyVbGvMsTguCQyp4x4yB9aPcTtibk
        cswoOftNwtyN/MVMLDMMWd2G
X-Google-Smtp-Source: ABdhPJydieDNLuAEPV2nYdMftox1nUEU2SWeT7PJiVwm/zKN/TPB4J3x+wA0UIfbkvL0gaGDWzFqYQ==
X-Received: by 2002:a17:90a:aa89:: with SMTP id l9mr4498450pjq.226.1599577800561;
        Tue, 08 Sep 2020 08:10:00 -0700 (PDT)
Received: from mani-NUC7i5DNKE ([2409:4072:6213:6149:cb0:8a44:a6a5:e3bd])
        by smtp.gmail.com with ESMTPSA id q190sm19958444pfq.99.2020.09.08.08.09.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 08:09:59 -0700 (PDT)
Date:   Tue, 8 Sep 2020 20:39:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 4/7] cpufreq: qcom-hw: Make use of of_match data for
 offsets and row size
Message-ID: <20200908150945.GB2352@mani-NUC7i5DNKE>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-5-manivannan.sadhasivam@linaro.org>
 <CAHLCerP7frrGyUBKbcurKhpkuGtJZjB+D82smnJ5U5CeL2bQgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerP7frrGyUBKbcurKhpkuGtJZjB+D82smnJ5U5CeL2bQgA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 0908, Amit Kucheria wrote:
> On Tue, Sep 8, 2020 at 1:27 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > For preparing the driver to handle further SoC revisions, let's use the
> > of_match data for getting the device specific offsets and row size instead
> > of defining them globally.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 
> 
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 96 +++++++++++++++++++++----------
> >  1 file changed, 66 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index ccea34f61152..41853db7c9b8 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -19,15 +19,21 @@
> >  #define LUT_L_VAL                      GENMASK(7, 0)
> >  #define LUT_CORE_COUNT                 GENMASK(18, 16)
> >  #define LUT_VOLT                       GENMASK(11, 0)
> > -#define LUT_ROW_SIZE                   32
> >  #define CLK_HW_DIV                     2
> >  #define LUT_TURBO_IND                  1
> >
> > -/* Register offsets */
> > -#define REG_ENABLE                     0x0
> > -#define REG_FREQ_LUT                   0x110
> > -#define REG_VOLT_LUT                   0x114
> > -#define REG_PERF_STATE                 0x920
> > +struct qcom_cpufreq_soc_data {
> > +       u32 reg_enable;
> > +       u32 reg_freq_lut;
> > +       u32 reg_volt_lut;
> > +       u32 reg_perf_state;
> > +       u8 lut_row_size;
> > +};
> > +
> > +struct qcom_cpufreq_data {
> > +       void __iomem *base;
> > +       const struct qcom_cpufreq_soc_data *soc_data;
> > +};
> >
> >  static unsigned long cpu_hw_rate, xo_rate;
> >  static bool icc_scaling_enabled;
> > @@ -76,10 +82,11 @@ static int qcom_cpufreq_update_opp(struct device *cpu_dev,
> >  static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> >                                         unsigned int index)
> >  {
> > -       void __iomem *perf_state_reg = policy->driver_data;
> > +       struct qcom_cpufreq_data *data = policy->driver_data;
> > +       const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
> >         unsigned long freq = policy->freq_table[index].frequency;
> >
> > -       writel_relaxed(index, perf_state_reg);
> > +       writel_relaxed(index, data->base + soc_data->reg_perf_state);
> >
> >         if (icc_scaling_enabled)
> >                 qcom_cpufreq_set_bw(policy, freq);
> > @@ -91,7 +98,8 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> >
> >  static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> >  {
> > -       void __iomem *perf_state_reg;
> > +       struct qcom_cpufreq_data *data;
> > +       const struct qcom_cpufreq_soc_data *soc_data;
> >         struct cpufreq_policy *policy;
> >         unsigned int index;
> >
> > @@ -99,9 +107,10 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> >         if (!policy)
> >                 return 0;
> >
> > -       perf_state_reg = policy->driver_data;
> > +       data = policy->driver_data;
> > +       soc_data = data->soc_data;
> >
> > -       index = readl_relaxed(perf_state_reg);
> > +       index = readl_relaxed(data->base + soc_data->reg_perf_state);
> >         index = min(index, LUT_MAX_ENTRIES - 1);
> >
> >         return policy->freq_table[index].frequency;
> > @@ -110,12 +119,13 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> >  static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> >                                                 unsigned int target_freq)
> >  {
> > -       void __iomem *perf_state_reg = policy->driver_data;
> > +       struct qcom_cpufreq_data *data = policy->driver_data;
> > +       const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
> >         unsigned int index;
> >         unsigned long freq;
> >
> >         index = policy->cached_resolved_idx;
> > -       writel_relaxed(index, perf_state_reg);
> > +       writel_relaxed(index, data->base + soc_data->reg_perf_state);
> >
> >         freq = policy->freq_table[index].frequency;
> >         arch_set_freq_scale(policy->related_cpus, freq,
> > @@ -125,8 +135,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> >  }
> >
> >  static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> > -                                   struct cpufreq_policy *policy,
> > -                                   void __iomem *base)
> > +                                   struct cpufreq_policy *policy)
> >  {
> >         u32 data, src, lval, i, core_count, prev_freq = 0, freq;
> >         u32 volt;
> > @@ -134,6 +143,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> >         struct dev_pm_opp *opp;
> >         unsigned long rate;
> >         int ret;
> > +       struct qcom_cpufreq_data *drv_data = policy->driver_data;
> > +       const struct qcom_cpufreq_soc_data *soc_data = drv_data->soc_data;
> >
> >         table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
> >         if (!table)
> > @@ -160,14 +171,14 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> >         }
> >
> >         for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> > -               data = readl_relaxed(base + REG_FREQ_LUT +
> > -                                     i * LUT_ROW_SIZE);
> > +               data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
> > +                                     i * soc_data->lut_row_size);
> >                 src = FIELD_GET(LUT_SRC, data);
> >                 lval = FIELD_GET(LUT_L_VAL, data);
> >                 core_count = FIELD_GET(LUT_CORE_COUNT, data);
> >
> > -               data = readl_relaxed(base + REG_VOLT_LUT +
> > -                                     i * LUT_ROW_SIZE);
> > +               data = readl_relaxed(drv_data->base + soc_data->reg_volt_lut +
> > +                                     i * soc_data->lut_row_size);
> >                 volt = FIELD_GET(LUT_VOLT, data) * 1000;
> >
> >                 if (src)
> > @@ -237,6 +248,20 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
> >         }
> >  }
> >
> > +static const struct qcom_cpufreq_soc_data qcom_soc_data = {
> 
> rename this to sdm845_soc_data?
> 

Nah, this is not specific to SDM845. Atleast in mainline, there are 3 SoCs
using this compatible.

> Or even better, maybe just use the IP version number for this IP block
> so that all SoCs using that IP version can use this struct?
> 

Since the SoCs are using the same compatible it makes sense to use the same
name for the of_data. I don't think it is a good idea to use different name
for the of_data since the differentiation has to happen at compatible level.

Thanks,
Mani

> > +       .reg_enable = 0x0,
> > +       .reg_freq_lut = 0x110,
> > +       .reg_volt_lut = 0x114,
> > +       .reg_perf_state = 0x920,
> > +       .lut_row_size = 32,
> > +};
> > +
> > +static const struct of_device_id qcom_cpufreq_hw_match[] = {
> > +       { .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> > +
> >  static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >  {
> >         struct platform_device *pdev = cpufreq_get_driver_data();
> > @@ -246,6 +271,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >         struct device *cpu_dev;
> >         struct resource *res;
> >         void __iomem *base;
> > +       struct qcom_cpufreq_data *data;
> > +       const struct of_device_id *match;
> >         int ret, index;
> >
> >         cpu_dev = get_cpu_device(policy->cpu);
> > @@ -275,8 +302,23 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >         if (!base)
> >                 return -ENOMEM;
> >
> > +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data) {
> > +               ret = -ENOMEM;
> > +               goto error;
> > +       }
> > +
> > +       match = of_match_device(qcom_cpufreq_hw_match, &pdev->dev);
> > +       if (!match) {
> > +               ret = -ENODEV;
> > +               goto error;
> > +       }
> > +
> > +       data->soc_data = match->data;
> > +       data->base = base;
> > +
> >         /* HW should be in enabled state to proceed */
> > -       if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
> > +       if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> >                 dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> >                 ret = -ENODEV;
> >                 goto error;
> > @@ -289,9 +331,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >                 goto error;
> >         }
> >
> > -       policy->driver_data = base + REG_PERF_STATE;
> > +       policy->driver_data = data;
> >
> > -       ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy, base);
> > +       ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
> >         if (ret) {
> >                 dev_err(dev, "Domain-%d failed to read LUT\n", index);
> >                 goto error;
> > @@ -315,13 +357,13 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >  static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> >  {
> >         struct device *cpu_dev = get_cpu_device(policy->cpu);
> > -       void __iomem *base = policy->driver_data - REG_PERF_STATE;
> > +       struct qcom_cpufreq_data *data = policy->driver_data;
> >         struct platform_device *pdev = cpufreq_get_driver_data();
> >
> >         dev_pm_opp_remove_all_dynamic(cpu_dev);
> >         dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> >         kfree(policy->freq_table);
> > -       devm_iounmap(&pdev->dev, base);
> > +       devm_iounmap(&pdev->dev, data->base);
> >
> >         return 0;
> >  }
> > @@ -391,12 +433,6 @@ static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
> >         return cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
> >  }
> >
> > -static const struct of_device_id qcom_cpufreq_hw_match[] = {
> > -       { .compatible = "qcom,cpufreq-hw" },
> > -       {}
> > -};
> > -MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> > -
> >  static struct platform_driver qcom_cpufreq_hw_driver = {
> >         .probe = qcom_cpufreq_hw_driver_probe,
> >         .remove = qcom_cpufreq_hw_driver_remove,
> > --
> > 2.17.1
> >
