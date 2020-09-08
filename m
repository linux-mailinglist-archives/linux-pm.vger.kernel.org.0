Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E075A261641
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbgIHRHS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 13:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732067AbgIHRHH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 13:07:07 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78226218AC
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599584825;
        bh=YnJRsJUG1pSW75HhPkDqFEpQnLbYGnKtTbKpi28dmLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WlhLwMSx0iwCqa8K3DJcD/KhLX8X+kUPN0Q76NNXA4e9e0P2AQk6NfTsRdyYZYYw7
         bIJRCogunOkjudd91T3Ji1HMrpxMrzItxVIf/qrLN40efCcjJI8IeOoZtwEYb7QxL1
         IuaDXCzPyBTRTvH8Y4YFWGqnt3e1tjDnrV4vOLdU=
Received: by mail-vs1-f43.google.com with SMTP id q13so9393641vsj.13
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 10:07:05 -0700 (PDT)
X-Gm-Message-State: AOAM530tEMXLlD7AiclHF3RoMhU/YbwTofcb/hAKdwbya5x6CZi6ynB2
        PhsLNDA1H0943g2en4yhF5zo9UPHLA9828z+jhuBIw==
X-Google-Smtp-Source: ABdhPJzDh4z5smAq+NO3nlyaPUB6zWghkiwltuG1BO8M1na3KvNjpxAboIuZLLXfHc5OZyl+pxScVD25k1EO2UK82qc=
X-Received: by 2002:a67:7fd0:: with SMTP id a199mr90272vsd.98.1599584824457;
 Tue, 08 Sep 2020 10:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-5-manivannan.sadhasivam@linaro.org> <CAHLCerP7frrGyUBKbcurKhpkuGtJZjB+D82smnJ5U5CeL2bQgA@mail.gmail.com>
 <20200908150945.GB2352@mani-NUC7i5DNKE>
In-Reply-To: <20200908150945.GB2352@mani-NUC7i5DNKE>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Tue, 8 Sep 2020 22:36:53 +0530
X-Gmail-Original-Message-ID: <CAHLCerN+sfk5bOg6-Exgdy+fWJO4e29qRYkaycjWbG3MoZFikg@mail.gmail.com>
Message-ID: <CAHLCerN+sfk5bOg6-Exgdy+fWJO4e29qRYkaycjWbG3MoZFikg@mail.gmail.com>
Subject: Re: [PATCH 4/7] cpufreq: qcom-hw: Make use of of_match data for
 offsets and row size
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 8, 2020 at 8:40 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On 0908, Amit Kucheria wrote:
> > On Tue, Sep 8, 2020 at 1:27 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > For preparing the driver to handle further SoC revisions, let's use the
> > > of_match data for getting the device specific offsets and row size instead
> > > of defining them globally.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> >
> >
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-hw.c | 96 +++++++++++++++++++++----------
> > >  1 file changed, 66 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index ccea34f61152..41853db7c9b8 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -19,15 +19,21 @@
> > >  #define LUT_L_VAL                      GENMASK(7, 0)
> > >  #define LUT_CORE_COUNT                 GENMASK(18, 16)
> > >  #define LUT_VOLT                       GENMASK(11, 0)
> > > -#define LUT_ROW_SIZE                   32
> > >  #define CLK_HW_DIV                     2
> > >  #define LUT_TURBO_IND                  1
> > >
> > > -/* Register offsets */
> > > -#define REG_ENABLE                     0x0
> > > -#define REG_FREQ_LUT                   0x110
> > > -#define REG_VOLT_LUT                   0x114
> > > -#define REG_PERF_STATE                 0x920
> > > +struct qcom_cpufreq_soc_data {
> > > +       u32 reg_enable;
> > > +       u32 reg_freq_lut;
> > > +       u32 reg_volt_lut;
> > > +       u32 reg_perf_state;
> > > +       u8 lut_row_size;
> > > +};
> > > +
> > > +struct qcom_cpufreq_data {
> > > +       void __iomem *base;
> > > +       const struct qcom_cpufreq_soc_data *soc_data;
> > > +};
> > >
> > >  static unsigned long cpu_hw_rate, xo_rate;
> > >  static bool icc_scaling_enabled;
> > > @@ -76,10 +82,11 @@ static int qcom_cpufreq_update_opp(struct device *cpu_dev,
> > >  static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> > >                                         unsigned int index)
> > >  {
> > > -       void __iomem *perf_state_reg = policy->driver_data;
> > > +       struct qcom_cpufreq_data *data = policy->driver_data;
> > > +       const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
> > >         unsigned long freq = policy->freq_table[index].frequency;
> > >
> > > -       writel_relaxed(index, perf_state_reg);
> > > +       writel_relaxed(index, data->base + soc_data->reg_perf_state);
> > >
> > >         if (icc_scaling_enabled)
> > >                 qcom_cpufreq_set_bw(policy, freq);
> > > @@ -91,7 +98,8 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> > >
> > >  static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> > >  {
> > > -       void __iomem *perf_state_reg;
> > > +       struct qcom_cpufreq_data *data;
> > > +       const struct qcom_cpufreq_soc_data *soc_data;
> > >         struct cpufreq_policy *policy;
> > >         unsigned int index;
> > >
> > > @@ -99,9 +107,10 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> > >         if (!policy)
> > >                 return 0;
> > >
> > > -       perf_state_reg = policy->driver_data;
> > > +       data = policy->driver_data;
> > > +       soc_data = data->soc_data;
> > >
> > > -       index = readl_relaxed(perf_state_reg);
> > > +       index = readl_relaxed(data->base + soc_data->reg_perf_state);
> > >         index = min(index, LUT_MAX_ENTRIES - 1);
> > >
> > >         return policy->freq_table[index].frequency;
> > > @@ -110,12 +119,13 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> > >  static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> > >                                                 unsigned int target_freq)
> > >  {
> > > -       void __iomem *perf_state_reg = policy->driver_data;
> > > +       struct qcom_cpufreq_data *data = policy->driver_data;
> > > +       const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
> > >         unsigned int index;
> > >         unsigned long freq;
> > >
> > >         index = policy->cached_resolved_idx;
> > > -       writel_relaxed(index, perf_state_reg);
> > > +       writel_relaxed(index, data->base + soc_data->reg_perf_state);
> > >
> > >         freq = policy->freq_table[index].frequency;
> > >         arch_set_freq_scale(policy->related_cpus, freq,
> > > @@ -125,8 +135,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> > >  }
> > >
> > >  static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> > > -                                   struct cpufreq_policy *policy,
> > > -                                   void __iomem *base)
> > > +                                   struct cpufreq_policy *policy)
> > >  {
> > >         u32 data, src, lval, i, core_count, prev_freq = 0, freq;
> > >         u32 volt;
> > > @@ -134,6 +143,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> > >         struct dev_pm_opp *opp;
> > >         unsigned long rate;
> > >         int ret;
> > > +       struct qcom_cpufreq_data *drv_data = policy->driver_data;
> > > +       const struct qcom_cpufreq_soc_data *soc_data = drv_data->soc_data;
> > >
> > >         table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
> > >         if (!table)
> > > @@ -160,14 +171,14 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> > >         }
> > >
> > >         for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> > > -               data = readl_relaxed(base + REG_FREQ_LUT +
> > > -                                     i * LUT_ROW_SIZE);
> > > +               data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
> > > +                                     i * soc_data->lut_row_size);
> > >                 src = FIELD_GET(LUT_SRC, data);
> > >                 lval = FIELD_GET(LUT_L_VAL, data);
> > >                 core_count = FIELD_GET(LUT_CORE_COUNT, data);
> > >
> > > -               data = readl_relaxed(base + REG_VOLT_LUT +
> > > -                                     i * LUT_ROW_SIZE);
> > > +               data = readl_relaxed(drv_data->base + soc_data->reg_volt_lut +
> > > +                                     i * soc_data->lut_row_size);
> > >                 volt = FIELD_GET(LUT_VOLT, data) * 1000;
> > >
> > >                 if (src)
> > > @@ -237,6 +248,20 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
> > >         }
> > >  }
> > >
> > > +static const struct qcom_cpufreq_soc_data qcom_soc_data = {
> >
> > rename this to sdm845_soc_data?
> >
>
> Nah, this is not specific to SDM845. Atleast in mainline, there are 3 SoCs
> using this compatible.
>
> > Or even better, maybe just use the IP version number for this IP block
> > so that all SoCs using that IP version can use this struct?
> >
>
> Since the SoCs are using the same compatible it makes sense to use the same
> name for the of_data. I don't think it is a good idea to use different name
> for the of_data since the differentiation has to happen at compatible level.

You are using the name sm8250_soc_data in a subsequent patch, though ;-)

So I think it would make sense for compatible "qcom,cpufreq-hw" to use
data "osm_soc_data" and compatible "qcom,sm8250-epss" to use data
"epss_soc_data" as suggested by Bjorn.

Regards,
Amit


>
> > > +       .reg_enable = 0x0,
> > > +       .reg_freq_lut = 0x110,
> > > +       .reg_volt_lut = 0x114,
> > > +       .reg_perf_state = 0x920,
> > > +       .lut_row_size = 32,
> > > +};
> > > +
> > > +static const struct of_device_id qcom_cpufreq_hw_match[] = {
> > > +       { .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
> > > +       {}
> > > +};
