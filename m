Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39122925B
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbfEXIEq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 May 2019 04:04:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39867 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388996AbfEXIEp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2019 04:04:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so3992735qkd.6
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2019 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBXfo3f3VBxQHXcdRSMKfsobC/cqHl7OlQRiXsV30VE=;
        b=Up8QcnJHOhogEiKKRZBk7rIW48oCZIkD0YdLLu9spajcuW7/MYtWd3epuGdovq00P/
         SUbc99vqX5gDHrPGwN7Dolt/v7jcwDTPibqK8zKHGAFtJqYgHfxoBXw0+0oNALI2mIfE
         KUT7oul7kXsOiTjUSfdzkVzzqJ1UInOsTxARo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBXfo3f3VBxQHXcdRSMKfsobC/cqHl7OlQRiXsV30VE=;
        b=Tt5ebUucBfV4FRhJ4cHpbCCOzhuIXrPc5PAzX5yNVFI07fuJ7NtOWYsQgjbd4vHEDc
         YYbX+dar3iTNXekjqqjOwkYN2sF4ecFug5uv3g37Cg+oruDiR503s1WnY1vasHmRDcVT
         RUzGQISefyCGyJ4Idh4PPK7BdgCACdCqZN5qBN0n/eKrMfMmNrJlrmbqIE24o3+0T27F
         6CBMYmQ393a0CymZvPZTHVK9oq5q8Ngdv+imnYGtynMRsVNB8hkrHYkFz1ZE6LH0T3xz
         u/MK9eMac4kww2BICSLxoAiNowMW1LWXeJhsr7bER0IuIQ4bxqweiYkJIhKMqZexqH3I
         HlMA==
X-Gm-Message-State: APjAAAVh86Jen0v3rYp7yMHUeHRoq2Vrs5gOxPo3cnbRTd1Q5nxFuASR
        TwOu0SYDODgOGIfSoYC2jJS52uPbgBNHgFrHXR7U3A==
X-Google-Smtp-Source: APXvYqyB85ubtcUVl583XzKJZMZmxA4tCmm7+GDK24kIDpdUoaqG/G/G21Le/PPOJRIOpUavh90Nb+rOMBaAuEwQaXA=
X-Received: by 2002:aed:3512:: with SMTP id a18mr85921585qte.181.1558685084516;
 Fri, 24 May 2019 01:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com> <1557997725-12178-9-git-send-email-andrew-sh.cheng@mediatek.com>
In-Reply-To: <1557997725-12178-9-git-send-email-andrew-sh.cheng@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 24 May 2019 16:04:18 +0800
Message-ID: <CAJMQK-hF3RT7wPRunE8q4uaEVaS1wkvmQO5t28Poz9ztiJ5Rmg@mail.gmail.com>
Subject: Re: [PATCH 8/8] devfreq: mediatek: cci devfreq register opp
 notification for SVS support
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 16, 2019 at 9:08 AM Andrew-sh.Cheng
<andrew-sh.cheng@mediatek.com> wrote:
>
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
>
> SVS will change the voltage of opp item.
> CCI devfreq need to react to change frequency.
>
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/mt8183-cci-devfreq.c | 63 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> index 818a167c442f..250c963789f3 100644
> --- a/drivers/devfreq/mt8183-cci-devfreq.c
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -19,7 +19,10 @@ struct cci_devfreq {
>         struct regulator *proc_reg;
>         unsigned long proc_reg_uV;
>         struct clk *cci_clk;
> +       unsigned long freq;
>         struct notifier_block nb;
> +       struct notifier_block opp_nb;
> +       int cci_min_freq;
>  };
>
>  static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
> @@ -65,17 +68,62 @@ static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
>         return 0;
>  }
>
> +static int ccidevfreq_opp_notifier(struct notifier_block *nb,
> +unsigned long event, void *data)
> +{
> +       int ret;
> +       struct dev_pm_opp *opp = data;
> +       struct cci_devfreq *cci_df = container_of(nb, struct cci_devfreq,
> +                                                 opp_nb);
> +       unsigned long   freq, volt, cur_volt;
> +
> +       if (event == OPP_EVENT_ADJUST_VOLTAGE) {
> +               freq = dev_pm_opp_get_freq(opp);
> +               /* current opp item is changed */
> +               if (freq == cci_df->freq) {
> +                       volt = dev_pm_opp_get_voltage(opp);
> +                       cur_volt = regulator_get_voltage(cci_df->proc_reg);
> +
> +                       if (volt > cur_volt) {
> +                               /* need reduce freq */
> +                               mutex_lock(&cci_df->devfreq->lock);
> +                               ret = update_devfreq(cci_df->devfreq);
> +                               if (ret)
> +                                       pr_err("Fail to reduce cci frequency by opp notification: %d\n",
This line is too long
> +                                              ret);
> +                               mutex_unlock(&cci_df->devfreq->lock);
> +                       }
> +               }
> +
> +               if (freq == cci_df->cci_min_freq) {
> +                       volt = dev_pm_opp_get_voltage(opp);
> +                       regulator_set_voltage(cci_df->proc_reg, volt, INT_MAX);
> +               }
> +       } else if (event == OPP_EVENT_DISABLE) {
Is this case handled? If not, is this branch needed?
> +       }
> +
> +       return 0;
> +}
> +
> +
>  static int mtk_cci_governor_get_target(struct devfreq *devfreq,
>                                        unsigned long *freq)
>  {
>         struct cci_devfreq *cci_df;
>         struct dev_pm_opp *opp;
> +       int ret;
>
>         cci_df = dev_get_drvdata(devfreq->dev.parent);
>
>         /* find available frequency */
>         opp = dev_pm_opp_find_freq_ceil_by_volt(devfreq->dev.parent,
>                                                 cci_df->proc_reg_uV);
> +       ret = PTR_ERR_OR_ZERO(opp);
> +       if (ret) {
> +               pr_err("%s[%d], cannot find opp with voltage=%d: %d\n",
> +                      __func__, __LINE__, cci_df->proc_reg_uV, ret);
> +               return ret;
> +       }
>         *freq = dev_pm_opp_get_freq(opp);
>
>         return 0;
> @@ -87,9 +135,11 @@ static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
>         int ret;
>         struct cci_devfreq *cci_df;
>         struct notifier_block *nb;
> +       struct notifier_block *opp_nb;
>
>         cci_df = dev_get_drvdata(devfreq->dev.parent);
>         nb = &cci_df->nb;
> +       opp_nb = &cci_df->opp_nb;
>
>         switch (event) {
>         case DEVFREQ_GOV_START:
> @@ -100,6 +150,8 @@ static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
>                 if (ret)
>                         pr_err("%s: failed to add governor: %d\n", __func__,
>                                ret);
> +               opp_nb->notifier_call = ccidevfreq_opp_notifier;
> +               dev_pm_opp_register_notifier(devfreq->dev.parent, opp_nb);
>                 break;
>
>         case DEVFREQ_GOV_STOP:
> @@ -141,6 +193,8 @@ static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
>                 return ret;
>         }
>
> +       cci_df->freq = *freq;
> +
>         return 0;
>  }
>
> @@ -152,6 +206,8 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
>  {
>         struct device *cci_dev = &pdev->dev;
>         struct cci_devfreq *cci_df;
> +       unsigned long freq, volt;
> +       struct dev_pm_opp *opp;
>         int ret;
>
>         cci_df = devm_kzalloc(cci_dev, sizeof(*cci_df), GFP_KERNEL);
> @@ -181,6 +237,13 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       /* set voltage lower bound */
> +       freq = 1;
> +       opp = dev_pm_opp_find_freq_ceil(cci_dev, &freq);
> +       cci_df->cci_min_freq = dev_pm_opp_get_freq(opp);
> +       volt = dev_pm_opp_get_voltage(opp);
> +       dev_pm_opp_put(opp);
> +
>         platform_set_drvdata(pdev, cci_df);
>
>         cci_df->devfreq = devm_devfreq_add_device(cci_dev,
