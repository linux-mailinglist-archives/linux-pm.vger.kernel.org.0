Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A42A1E94
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 15:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgKAOkR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 09:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgKAOkQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 09:40:16 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F74C0617A6;
        Sun,  1 Nov 2020 06:40:16 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so14046973lfc.7;
        Sun, 01 Nov 2020 06:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jCVo8/94MpOYTFL7DjkVjM764ActVLI9C2TJGoIPVUo=;
        b=sAoFVURxhvfaOGnIkTZuaaZV/mY1PKQRf+hiVsxhWynrCOKGIaAPDlVp7q/9Tirpb+
         ydPDEe/8aTnnrBLotQVvumGGo2JoSyRa6I8NLr6h9eCZPUNl6MrK8x3fqthJ3I/1bs30
         2X5+RmXcFwL5Zyszqmfi8+JJchjkFhQaR4wyMltM9KzuGtPbAREre/N23Hyp1IDFWpRm
         I3lqj5nFqYdajwJCy+/W90mNvg49jCwxi4mrXP6QBfoc+Omu6pwmWZWphG4RoyZR/esS
         nO/trk/L3M54aGtbKVBVp32mR2jXbnPI39SFY9ebqC5Bj+vKq6SOrosXptjKrN4KVfl5
         PZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jCVo8/94MpOYTFL7DjkVjM764ActVLI9C2TJGoIPVUo=;
        b=Bg8OYS8TbRg1jwH2Eg9/uTeeAhBaK1xaKmH63QuHFraiaA9mJzgVtsN1I3AU3biQUv
         g2AdO07LM0lUb4rBduDMWmMYjSROBdfrQD/ZET42qpxYhTctT7GG05aEaUsfNIzqPzk9
         9qSamsyFYzfBb6snOp7Lt+a6cBnJXRNOZHRSRdZ51VClgr8yURtGNt//rgMxk0L6GwlG
         4bIQDKKeLElkbIYwHujgTMjJ/lDGMiE6eaWKJsZ5a1w064l1AI1w0Kg9VjoAklmGEogD
         Ff3BEROvag7f7cfForGIhsGnzaqSmFfdARZdyVjQIkSy+RKbzLRpr8YMiNzwbq094xIu
         OAsA==
X-Gm-Message-State: AOAM533Y7ZL0QpeUq7wMmoTsEqoQxoAuLaPNigoUmyUJORRdcCE+fxdi
        /nlXRSLkN5Gb28Yg1Y4YP8GUIUJ9VobcIp7/iuc=
X-Google-Smtp-Source: ABdhPJwzY72IAzZXfHh1kd2WvF4eru+wJcTYbTGog09NjEfOz6/MxYbDxXzd5UXgy+NqRwNDFjRJFAz49a7gyQ9NHSc=
X-Received: by 2002:a19:40ca:: with SMTP id n193mr3828917lfa.96.1604241614536;
 Sun, 01 Nov 2020 06:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20201025221735.3062-1-digetx@gmail.com> <20201025221735.3062-52-digetx@gmail.com>
In-Reply-To: <20201025221735.3062-52-digetx@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 1 Nov 2020 23:39:38 +0900
Message-ID: <CAGTfZH1PV4r-pD=zTKD71nQb5+UobJKa5mBv-Nb2ZgSubkscjA@mail.gmail.com>
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On Mon, Oct 26, 2020 at 7:22 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> This patch moves ACTMON driver away from generating OPP table by itself,
> transitioning it to use the table which comes from device-tree. This
> change breaks compatibility with older device-trees in order to bring
> support for the interconnect framework to the driver. This is a mandatory
> change which needs to be done in order to implement interconnect-based
> memory DVFS. Users of legacy device-trees will get a message telling that
> theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth request
> using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 91 ++++++++++++++++---------------
>  1 file changed, 48 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 3f732ab53573..1b0b91a71886 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -19,6 +19,8 @@
>  #include <linux/reset.h>
>  #include <linux/workqueue.h>
>
> +#include <soc/tegra/fuse.h>
> +
>  #include "governor.h"
>
>  #define ACTMON_GLB_STATUS                                      0x0
> @@ -155,6 +157,7 @@ struct tegra_devfreq_device {
>
>  struct tegra_devfreq {
>         struct devfreq          *devfreq;
> +       struct opp_table        *opp_table;
>
>         struct reset_control    *reset;
>         struct clk              *clock;
> @@ -612,34 +615,19 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>                                 u32 flags)
>  {
> -       struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> -       struct devfreq *devfreq = tegra->devfreq;
>         struct dev_pm_opp *opp;
> -       unsigned long rate;
> -       int err;
> +       int ret;
>
>         opp = devfreq_recommended_opp(dev, freq, flags);
>         if (IS_ERR(opp)) {
> -               dev_err(dev, "Failed to find opp for %lu Hz\n", *freq);
> +               dev_err(dev, "failed to find opp for %lu Hz\n", *freq);
>                 return PTR_ERR(opp);
>         }
> -       rate = dev_pm_opp_get_freq(opp);
> -       dev_pm_opp_put(opp);
> -
> -       err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
> -       if (err)
> -               return err;
> -
> -       err = clk_set_rate(tegra->emc_clock, 0);
> -       if (err)
> -               goto restore_min_rate;
>
> -       return 0;
> -
> -restore_min_rate:
> -       clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> +       ret = dev_pm_opp_set_bw(dev, opp);
> +       dev_pm_opp_put(opp);
>
> -       return err;
> +       return ret;
>  }
>
>  static int tegra_devfreq_get_dev_status(struct device *dev,
> @@ -655,7 +643,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>         stat->private_data = tegra;
>
>         /* The below are to be used by the other governors */
> -       stat->current_frequency = cur_freq;
> +       stat->current_frequency = cur_freq * KHZ;

I can't find any change related to the frequency unit on this patch.
Do you fix the previous bug of the frequency unit?

>
>         actmon_dev = &tegra->devices[MCALL];
>
> @@ -705,7 +693,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>                 target_freq = max(target_freq, dev->target_freq);
>         }
>
> -       *freq = target_freq;
> +       *freq = target_freq * KHZ;

ditto.

>
>         return 0;
>  }
> @@ -773,13 +761,22 @@ static struct devfreq_governor tegra_devfreq_governor = {
>
>  static int tegra_devfreq_probe(struct platform_device *pdev)
>  {
> +       u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
>         struct tegra_devfreq_device *dev;
>         struct tegra_devfreq *tegra;
> +       struct opp_table *opp_table;
>         struct devfreq *devfreq;
>         unsigned int i;
>         long rate;
>         int err;
>
> +       /* legacy device-trees don't have OPP table and must be updated */
> +       if (!device_property_present(&pdev->dev, "operating-points-v2")) {
> +               dev_err(&pdev->dev, "OPP table not found, cannot continue\n");
> +               dev_err(&pdev->dev, "please update your device tree\n");
> +               return -ENODEV;
> +       }

As you mentioned, it breaks the old dtb. I have no objection to improving
the driver. Instead, you need confirmation from the Devicetree maintainer.

And,
I recommend that you use dev_pm_opp_of_get_opp_desc_node(&pdev->dev)
to check whether a device contains opp-table or not.

> +
>         tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>         if (!tegra)
>                 return -ENOMEM;
> @@ -821,11 +818,29 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>                 return err;
>         }
>
> +       tegra->opp_table = dev_pm_opp_get_opp_table(&pdev->dev);
> +       if (IS_ERR(tegra->opp_table))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(tegra->opp_table),
> +                                    "Failed to prepare OPP table\n");

As I knew, each device can contain the opp_table on devicetree.
It means that opp_table has not depended to another device driver.
Did you see this exception case with EPROBE_DEFER error?

> +
> +       opp_table = dev_pm_opp_set_supported_hw(&pdev->dev, &hw_version, 1);
> +       err = PTR_ERR_OR_ZERO(opp_table);
> +       if (err) {
> +               dev_err(&pdev->dev, "Failed to set supported HW: %d\n", err);
> +               goto put_table;
> +       }
> +
> +       err = dev_pm_opp_of_add_table(&pdev->dev);
> +       if (err) {
> +               dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
> +               goto put_hw;
> +       }
> +
>         err = clk_prepare_enable(tegra->clock);
>         if (err) {
>                 dev_err(&pdev->dev,
>                         "Failed to prepare and enable ACTMON clock\n");
> -               return err;
> +               goto remove_table;
>         }
>
>         err = reset_control_reset(tegra->reset);
> @@ -849,23 +864,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>                 dev->regs = tegra->regs + dev->config->offset;
>         }
>
> -       for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
> -               rate = clk_round_rate(tegra->emc_clock, rate);
> -
> -               if (rate < 0) {
> -                       dev_err(&pdev->dev,
> -                               "Failed to round clock rate: %ld\n", rate);
> -                       err = rate;
> -                       goto remove_opps;
> -               }
> -
> -               err = dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
> -               if (err) {
> -                       dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
> -                       goto remove_opps;
> -               }
> -       }
> -
>         platform_set_drvdata(pdev, tegra);
>
>         tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
> @@ -881,7 +879,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>         }
>
>         tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> -       tegra_devfreq_profile.initial_freq /= KHZ;
>
>         devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>                                      "tegra_actmon", NULL);
> @@ -901,6 +898,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>         reset_control_reset(tegra->reset);
>  disable_clk:
>         clk_disable_unprepare(tegra->clock);
> +remove_table:
> +       dev_pm_opp_of_remove_table(&pdev->dev);
> +put_hw:
> +       dev_pm_opp_put_supported_hw(tegra->opp_table);
> +put_table:
> +       dev_pm_opp_put_opp_table(tegra->opp_table);
>
>         return err;
>  }
> @@ -912,11 +915,13 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>         devfreq_remove_device(tegra->devfreq);
>         devfreq_remove_governor(&tegra_devfreq_governor);
>
> -       dev_pm_opp_remove_all_dynamic(&pdev->dev);
> -
>         reset_control_reset(tegra->reset);
>         clk_disable_unprepare(tegra->clock);
>
> +       dev_pm_opp_of_remove_table(&pdev->dev);
> +       dev_pm_opp_put_supported_hw(tegra->opp_table);
> +       dev_pm_opp_put_opp_table(tegra->opp_table);
> +
>         return 0;
>  }
>
> --
> 2.27.0
>


-- 
Best Regards,
Chanwoo Choi
