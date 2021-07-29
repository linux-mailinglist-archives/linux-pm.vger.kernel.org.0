Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA23DA660
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhG2O2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 10:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbhG2O2b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 10:28:31 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46194C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 07:28:28 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x9so4023589qtw.13
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLj2QK1R5utvd4vrSnwikE1e+hVxBjjxq1nXuXjo4gI=;
        b=AbSYxlJb8Smx3Z/+e5otONwijclrDAkIj7xU+PKleTPInFmOC2OjWYR8Zbr1a4R6wE
         G4nrTw2njuNTe7uf/a+XwwtE91dp1ZhFLSaArKUjwYjgOIrkEPv138OTymtmkVB/1gKb
         JUPYN0Zt+tyivETVlSQS61nEIJ4yOg+b/ZMYHlKuRPv0W6jt6DjrjNJuiW7Ciok62ddt
         LQeHIPH0r1L1iHwoUsXM/m9/9OFhT5QORWbx7xlKdcl7xsB+77Ii0nJcPnhVqz63rxYt
         4PzpbeVOlcbeD8qYORf9g9cQF2vilK4r7WmE20EUwYqYT9qNnKxFAWFVVoHsZJs2MTP1
         UOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLj2QK1R5utvd4vrSnwikE1e+hVxBjjxq1nXuXjo4gI=;
        b=BFxGC8AjxIiuaBG24M0ycuT14Y2l5l8SfW2JGB12xeafnFmVRxYS9RKFfc3bRRIwLc
         IZ9yXQADkOTn9tuW54R5URJEBDJ5xL5YnI21cVnD23ISLRqxQhQcZvJw+71gxXbRAF47
         Yxjw0SUR5+prCCg8j2zlyI4YypIYNMJ06JkSpXOrZzVUnqZ9JlrS9OkmmQEyLaqegRSU
         wZ+fXQUPgjwY8WyrCYvwih8+2lrPrvc79Hji7iBBIeNUGvQWK0jwwMnQgPNZz0M3hv0l
         Pu3KH6deQDy6hR1kx7oeQA8Xp/uEz2DiWke0BsudWIrkVOYU4cQ4I+jwmrJXlXrgZaI8
         /RrQ==
X-Gm-Message-State: AOAM530dgAnw+YxfSzsX1ET3AlIfKdfCHbAsBORKgek8dBDuvHfqgMRF
        NmpXluAeO0G8daD1l6f8TfI9JemWg5ZVDIaWfgohIg==
X-Google-Smtp-Source: ABdhPJxyJ/rYH79KnYLvQd4hmKuqktWzGYbo36HWzJnr8rUgZyn2syDgkgiytXEsZjV7bxNJWR5h0+R/kOT2EQh5qvQ=
X-Received: by 2002:ac8:6697:: with SMTP id d23mr4367324qtp.135.1627568907353;
 Thu, 29 Jul 2021 07:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210728142445.774158-1-dmitry.baryshkov@linaro.org>
 <20210728142445.774158-4-dmitry.baryshkov@linaro.org> <YQFxEIRWRZscPgJl@yoga>
In-Reply-To: <YQFxEIRWRZscPgJl@yoga>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Jul 2021 17:28:16 +0300
Message-ID: <CAA8EJpqzcuctWaOeqq2-mqW3o-DSNPNEmoiDWEcry+SQ+2-uDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] clk: qcom: use devm_pm_runtime_enable and devm_pm_clk_create
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 28 Jul 2021 at 18:00, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 28 Jul 09:24 CDT 2021, Dmitry Baryshkov wrote:
>
> > Use two new helpers instead of pm_runtime_enable() and pm_clk_create(),
> > removing the need for calling pm_runtime_disable and pm_clk_destroy().
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> It's quite reasonable to expect that Rafael wants to take the two first
> patches through his tree, but I expect that these clock patches will
> conflict with your other changes resulting in a less smooth path into
> mainline.

I do not expect any conflicts in the clock code. The gdsc fixes do not
touch these parts.

> Grepping the tree for candidates I find many better examples, that
> we don't foresee any conflicting changes..
>
> So may I suggest that you fix drivers/hwspinlock/omap_hwspinlock.c and
> drivers/hwspinlock/stm32_hwspinlock.c, then I (as maintainer) can Ack
> those changes and Rafael can take the series in his tree for v5.15.

These two would use devm_pm_runtime_enable, but not the
devm_pm_clk_create. Thus I'd still prefer to modify these few drivers
(note, the generification is a separate patch and I can safely drop it
for now).

> Then as v5.15-rc1 lands, we have the API and we can follow up changing
> these more complex drivers - and those patches can go through the
> individual maintainer trees.
>
> Regards,
> Bjorn
>
> > ---
> >  drivers/clk/qcom/camcc-sc7180.c       | 25 +++++++++------------
> >  drivers/clk/qcom/lpass-gfm-sm8250.c   | 21 ++++++++----------
> >  drivers/clk/qcom/lpasscorecc-sc7180.c | 18 ++-------------
> >  drivers/clk/qcom/mss-sc7180.c         | 30 +++++++------------------
> >  drivers/clk/qcom/q6sstop-qcs404.c     | 32 ++++++++-------------------
> >  drivers/clk/qcom/turingcc-qcs404.c    | 30 +++++++------------------
> >  6 files changed, 46 insertions(+), 110 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
> > index 9bcf2f8ed4de..ce73ee9037cb 100644
> > --- a/drivers/clk/qcom/camcc-sc7180.c
> > +++ b/drivers/clk/qcom/camcc-sc7180.c
> > @@ -1652,32 +1652,35 @@ static int cam_cc_sc7180_probe(struct platform_device *pdev)
> >       struct regmap *regmap;
> >       int ret;
> >
> > -     pm_runtime_enable(&pdev->dev);
> > -     ret = pm_clk_create(&pdev->dev);
> > +     ret = devm_pm_runtime_enable(&pdev->dev);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = devm_pm_clk_create(&pdev->dev);
> >       if (ret < 0)
> >               return ret;
> >
> >       ret = pm_clk_add(&pdev->dev, "xo");
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "Failed to acquire XO clock\n");
> > -             goto disable_pm_runtime;
> > +             return ret;
> >       }
> >
> >       ret = pm_clk_add(&pdev->dev, "iface");
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "Failed to acquire iface clock\n");
> > -             goto disable_pm_runtime;
> > +             return ret;
> >       }
> >
> >       ret = pm_runtime_get(&pdev->dev);
> >       if (ret)
> > -             goto destroy_pm_clk;
> > +             return ret;
> >
> >       regmap = qcom_cc_map(pdev, &cam_cc_sc7180_desc);
> >       if (IS_ERR(regmap)) {
> >               ret = PTR_ERR(regmap);
> >               pm_runtime_put(&pdev->dev);
> > -             goto destroy_pm_clk;
> > +             return ret;
> >       }
> >
> >       clk_fabia_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
> > @@ -1689,18 +1692,10 @@ static int cam_cc_sc7180_probe(struct platform_device *pdev)
> >       pm_runtime_put(&pdev->dev);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "Failed to register CAM CC clocks\n");
> > -             goto destroy_pm_clk;
> > +             return ret;
> >       }
> >
> >       return 0;
> > -
> > -destroy_pm_clk:
> > -     pm_clk_destroy(&pdev->dev);
> > -
> > -disable_pm_runtime:
> > -     pm_runtime_disable(&pdev->dev);
> > -
> > -     return ret;
> >  }
> >
> >  static const struct dev_pm_ops cam_cc_pm_ops = {
> > diff --git a/drivers/clk/qcom/lpass-gfm-sm8250.c b/drivers/clk/qcom/lpass-gfm-sm8250.c
> > index f5e31e692b9b..96f476f24eb2 100644
> > --- a/drivers/clk/qcom/lpass-gfm-sm8250.c
> > +++ b/drivers/clk/qcom/lpass-gfm-sm8250.c
> > @@ -251,15 +251,18 @@ static int lpass_gfm_clk_driver_probe(struct platform_device *pdev)
> >       if (IS_ERR(cc->base))
> >               return PTR_ERR(cc->base);
> >
> > -     pm_runtime_enable(dev);
> > -     err = pm_clk_create(dev);
> > +     err = devm_pm_runtime_enable(dev);
> >       if (err)
> > -             goto pm_clk_err;
> > +             return err;
> > +
> > +     err = devm_pm_clk_create(dev);
> > +     if (err)
> > +             return err;
> >
> >       err = of_pm_clk_add_clks(dev);
> >       if (err < 0) {
> >               dev_dbg(dev, "Failed to get lpass core voting clocks\n");
> > -             goto clk_reg_err;
> > +             return err;
> >       }
> >
> >       for (i = 0; i < data->onecell_data->num; i++) {
> > @@ -273,22 +276,16 @@ static int lpass_gfm_clk_driver_probe(struct platform_device *pdev)
> >
> >               err = devm_clk_hw_register(dev, &data->gfm_clks[i]->hw);
> >               if (err)
> > -                     goto clk_reg_err;
> > +                     return err;
> >
> >       }
> >
> >       err = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> >                                         data->onecell_data);
> >       if (err)
> > -             goto clk_reg_err;
> > +             return err;
> >
> >       return 0;
> > -
> > -clk_reg_err:
> > -     pm_clk_destroy(dev);
> > -pm_clk_err:
> > -     pm_runtime_disable(dev);
> > -     return err;
> >  }
> >
> >  static const struct of_device_id lpass_gfm_clk_match_table[] = {
> > diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
> > index 2e0ecc38efdd..ac09b7b840ab 100644
> > --- a/drivers/clk/qcom/lpasscorecc-sc7180.c
> > +++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
> > @@ -356,32 +356,18 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
> >       .num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
> >  };
> >
> > -static void lpass_pm_runtime_disable(void *data)
> > -{
> > -     pm_runtime_disable(data);
> > -}
> > -
> > -static void lpass_pm_clk_destroy(void *data)
> > -{
> > -     pm_clk_destroy(data);
> > -}
> > -
> >  static int lpass_create_pm_clks(struct platform_device *pdev)
> >  {
> >       int ret;
> >
> >       pm_runtime_use_autosuspend(&pdev->dev);
> >       pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> > -     pm_runtime_enable(&pdev->dev);
> >
> > -     ret = devm_add_action_or_reset(&pdev->dev, lpass_pm_runtime_disable, &pdev->dev);
> > +     ret = devm_pm_runtime_enable(&pdev->dev);
> >       if (ret)
> >               return ret;
> >
> > -     ret = pm_clk_create(&pdev->dev);
> > -     if (ret)
> > -             return ret;
> > -     ret = devm_add_action_or_reset(&pdev->dev, lpass_pm_clk_destroy, &pdev->dev);
> > +     ret = devm_pm_clk_create(&pdev->dev);
> >       if (ret)
> >               return ret;
> >
> > diff --git a/drivers/clk/qcom/mss-sc7180.c b/drivers/clk/qcom/mss-sc7180.c
> > index 673fa1a4f734..5a1407440662 100644
> > --- a/drivers/clk/qcom/mss-sc7180.c
> > +++ b/drivers/clk/qcom/mss-sc7180.c
> > @@ -73,36 +73,23 @@ static int mss_sc7180_probe(struct platform_device *pdev)
> >  {
> >       int ret;
> >
> > -     pm_runtime_enable(&pdev->dev);
> > -     ret = pm_clk_create(&pdev->dev);
> > +     ret = devm_pm_runtime_enable(&pdev->dev);
> >       if (ret)
> > -             goto disable_pm_runtime;
> > +             return ret;
> > +
> > +     ret = devm_pm_clk_create(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> >
> >       ret = pm_clk_add(&pdev->dev, "cfg_ahb");
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to acquire iface clock\n");
> > -             goto destroy_pm_clk;
> > +             return ret;
> >       }
> >
> >       ret = qcom_cc_probe(pdev, &mss_sc7180_desc);
> >       if (ret < 0)
> > -             goto destroy_pm_clk;
> > -
> > -     return 0;
> > -
> > -destroy_pm_clk:
> > -     pm_clk_destroy(&pdev->dev);
> > -
> > -disable_pm_runtime:
> > -     pm_runtime_disable(&pdev->dev);
> > -
> > -     return ret;
> > -}
> > -
> > -static int mss_sc7180_remove(struct platform_device *pdev)
> > -{
> > -     pm_clk_destroy(&pdev->dev);
> > -     pm_runtime_disable(&pdev->dev);
> > +             return ret;
> >
> >       return 0;
> >  }
> > @@ -119,7 +106,6 @@ MODULE_DEVICE_TABLE(of, mss_sc7180_match_table);
> >
> >  static struct platform_driver mss_sc7180_driver = {
> >       .probe          = mss_sc7180_probe,
> > -     .remove         = mss_sc7180_remove,
> >       .driver         = {
> >               .name           = "sc7180-mss",
> >               .of_match_table = mss_sc7180_match_table,
> > diff --git a/drivers/clk/qcom/q6sstop-qcs404.c b/drivers/clk/qcom/q6sstop-qcs404.c
> > index 723f932fbf7d..507386bee07d 100644
> > --- a/drivers/clk/qcom/q6sstop-qcs404.c
> > +++ b/drivers/clk/qcom/q6sstop-qcs404.c
> > @@ -159,15 +159,18 @@ static int q6sstopcc_qcs404_probe(struct platform_device *pdev)
> >       const struct qcom_cc_desc *desc;
> >       int ret;
> >
> > -     pm_runtime_enable(&pdev->dev);
> > -     ret = pm_clk_create(&pdev->dev);
> > +     ret = devm_pm_runtime_enable(&pdev->dev);
> >       if (ret)
> > -             goto disable_pm_runtime;
> > +             return ret;
> > +
> > +     ret = devm_pm_clk_create(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> >
> >       ret = pm_clk_add(&pdev->dev, NULL);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to acquire iface clock\n");
> > -             goto destroy_pm_clk;
> > +             return ret;
> >       }
> >
> >       q6sstop_regmap_config.name = "q6sstop_tcsr";
> > @@ -175,30 +178,14 @@ static int q6sstopcc_qcs404_probe(struct platform_device *pdev)
> >
> >       ret = qcom_cc_probe_by_index(pdev, 1, desc);
> >       if (ret)
> > -             goto destroy_pm_clk;
> > +             return ret;
> >
> >       q6sstop_regmap_config.name = "q6sstop_cc";
> >       desc = &q6sstop_qcs404_desc;
> >
> >       ret = qcom_cc_probe_by_index(pdev, 0, desc);
> >       if (ret)
> > -             goto destroy_pm_clk;
> > -
> > -     return 0;
> > -
> > -destroy_pm_clk:
> > -     pm_clk_destroy(&pdev->dev);
> > -
> > -disable_pm_runtime:
> > -     pm_runtime_disable(&pdev->dev);
> > -
> > -     return ret;
> > -}
> > -
> > -static int q6sstopcc_qcs404_remove(struct platform_device *pdev)
> > -{
> > -     pm_clk_destroy(&pdev->dev);
> > -     pm_runtime_disable(&pdev->dev);
> > +             return ret;
> >
> >       return 0;
> >  }
> > @@ -209,7 +196,6 @@ static const struct dev_pm_ops q6sstopcc_pm_ops = {
> >
> >  static struct platform_driver q6sstopcc_qcs404_driver = {
> >       .probe          = q6sstopcc_qcs404_probe,
> > -     .remove         = q6sstopcc_qcs404_remove,
> >       .driver         = {
> >               .name   = "qcs404-q6sstopcc",
> >               .of_match_table = q6sstopcc_qcs404_match_table,
> > diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
> > index 4cfbbf5bf4d9..4543bda793f4 100644
> > --- a/drivers/clk/qcom/turingcc-qcs404.c
> > +++ b/drivers/clk/qcom/turingcc-qcs404.c
> > @@ -110,36 +110,23 @@ static int turingcc_probe(struct platform_device *pdev)
> >  {
> >       int ret;
> >
> > -     pm_runtime_enable(&pdev->dev);
> > -     ret = pm_clk_create(&pdev->dev);
> > +     ret = devm_pm_runtime_enable(&pdev->dev);
> >       if (ret)
> > -             goto disable_pm_runtime;
> > +             return ret;
> > +
> > +     ret = devm_pm_clk_create(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> >
> >       ret = pm_clk_add(&pdev->dev, NULL);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to acquire iface clock\n");
> > -             goto destroy_pm_clk;
> > +             return ret;
> >       }
> >
> >       ret = qcom_cc_probe(pdev, &turingcc_desc);
> >       if (ret < 0)
> > -             goto destroy_pm_clk;
> > -
> > -     return 0;
> > -
> > -destroy_pm_clk:
> > -     pm_clk_destroy(&pdev->dev);
> > -
> > -disable_pm_runtime:
> > -     pm_runtime_disable(&pdev->dev);
> > -
> > -     return ret;
> > -}
> > -
> > -static int turingcc_remove(struct platform_device *pdev)
> > -{
> > -     pm_clk_destroy(&pdev->dev);
> > -     pm_runtime_disable(&pdev->dev);
> > +             return ret;
> >
> >       return 0;
> >  }
> > @@ -156,7 +143,6 @@ MODULE_DEVICE_TABLE(of, turingcc_match_table);
> >
> >  static struct platform_driver turingcc_driver = {
> >       .probe          = turingcc_probe,
> > -     .remove         = turingcc_remove,
> >       .driver         = {
> >               .name   = "qcs404-turingcc",
> >               .of_match_table = turingcc_match_table,
> > --
> > 2.30.2
> >



-- 
With best wishes
Dmitry
