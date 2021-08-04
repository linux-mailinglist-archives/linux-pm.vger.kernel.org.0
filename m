Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8992B3E0748
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbhHDSM1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:12:27 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:43926 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbhHDSM1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:12:27 -0400
Received: by mail-oo1-f51.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so683199oos.10;
        Wed, 04 Aug 2021 11:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0g4tHgIgUJb7cYcVp4RPbDV68RXFdnmQz+5rqu8K6KQ=;
        b=dFu83rfsWzIhY1+Xxhxo+5m5GGpTnJSOfbqQmvB3z0Q5Z29jbNdJTm4tHb4ksxY0bJ
         unJYHlGEiQbo/YjQThUCx3DCXcO47LrvEbb+HoHm/M0BXgcJZVHhn01FKjtqNKDXGJPk
         CULCUTaeGc8ReHxLJ5CC5ybBAt2n7FuEmXQuqpyJub7PRNFhWZ/YFrhEJrhN3sIgGmJf
         yAlaeT4doBqckEPhfzPvHl3voaRAnPy2qxK05cxlaV8z6h7E5leeVvhnREjjc9phA45X
         7O3uroHLSOm8mZSEBoXCCKonVqmu5DlAj6iVLEDkmJBcBO5cTYY2C9pv1vfRTu+kqP5j
         HJKA==
X-Gm-Message-State: AOAM533UWHrbcafI+/DBlJZxi52dneZ4KRnTthyTUzcW9knrPUG2kWGy
        LkDAsy0HO63miLmxZM5MFeycR1CCS71X59D+34Q=
X-Google-Smtp-Source: ABdhPJwWA3EjVz2OhP8f4hzMiCCOOMDNgw5W0+G/YYjPR77VcU4n0aNcNzPIL5D2aSj5GmFG6GAp9NbGK7Cy5pPY7qU=
X-Received: by 2002:a4a:9c05:: with SMTP id y5mr571625ooj.2.1628100733952;
 Wed, 04 Aug 2021 11:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org> <20210731195034.979084-4-dmitry.baryshkov@linaro.org>
In-Reply-To: <20210731195034.979084-4-dmitry.baryshkov@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 20:12:02 +0200
Message-ID: <CAJZ5v0jVJpfzO9zWYSmKjCNeqfREc3OLC5aR8k1NRLnwnh57oA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] clk: qcom: use devm_pm_runtime_enable and devm_pm_clk_create
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 31, 2021 at 9:50 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Use two new helpers instead of pm_runtime_enable() and pm_clk_create(),
> removing the need for calling pm_runtime_disable and pm_clk_destroy().
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

This needs some ACKs if you want me to apply it.

> ---
>  drivers/clk/qcom/camcc-sc7180.c       | 25 +++++++++------------
>  drivers/clk/qcom/lpass-gfm-sm8250.c   | 21 ++++++++----------
>  drivers/clk/qcom/lpasscorecc-sc7180.c | 18 ++-------------
>  drivers/clk/qcom/mss-sc7180.c         | 30 +++++++------------------
>  drivers/clk/qcom/q6sstop-qcs404.c     | 32 ++++++++-------------------
>  drivers/clk/qcom/turingcc-qcs404.c    | 30 +++++++------------------
>  6 files changed, 46 insertions(+), 110 deletions(-)
>
> diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
> index 9bcf2f8ed4de..ce73ee9037cb 100644
> --- a/drivers/clk/qcom/camcc-sc7180.c
> +++ b/drivers/clk/qcom/camcc-sc7180.c
> @@ -1652,32 +1652,35 @@ static int cam_cc_sc7180_probe(struct platform_device *pdev)
>         struct regmap *regmap;
>         int ret;
>
> -       pm_runtime_enable(&pdev->dev);
> -       ret = pm_clk_create(&pdev->dev);
> +       ret = devm_pm_runtime_enable(&pdev->dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = devm_pm_clk_create(&pdev->dev);
>         if (ret < 0)
>                 return ret;
>
>         ret = pm_clk_add(&pdev->dev, "xo");
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Failed to acquire XO clock\n");
> -               goto disable_pm_runtime;
> +               return ret;
>         }
>
>         ret = pm_clk_add(&pdev->dev, "iface");
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Failed to acquire iface clock\n");
> -               goto disable_pm_runtime;
> +               return ret;
>         }
>
>         ret = pm_runtime_get(&pdev->dev);
>         if (ret)
> -               goto destroy_pm_clk;
> +               return ret;
>
>         regmap = qcom_cc_map(pdev, &cam_cc_sc7180_desc);
>         if (IS_ERR(regmap)) {
>                 ret = PTR_ERR(regmap);
>                 pm_runtime_put(&pdev->dev);
> -               goto destroy_pm_clk;
> +               return ret;
>         }
>
>         clk_fabia_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
> @@ -1689,18 +1692,10 @@ static int cam_cc_sc7180_probe(struct platform_device *pdev)
>         pm_runtime_put(&pdev->dev);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Failed to register CAM CC clocks\n");
> -               goto destroy_pm_clk;
> +               return ret;
>         }
>
>         return 0;
> -
> -destroy_pm_clk:
> -       pm_clk_destroy(&pdev->dev);
> -
> -disable_pm_runtime:
> -       pm_runtime_disable(&pdev->dev);
> -
> -       return ret;
>  }
>
>  static const struct dev_pm_ops cam_cc_pm_ops = {
> diff --git a/drivers/clk/qcom/lpass-gfm-sm8250.c b/drivers/clk/qcom/lpass-gfm-sm8250.c
> index f5e31e692b9b..96f476f24eb2 100644
> --- a/drivers/clk/qcom/lpass-gfm-sm8250.c
> +++ b/drivers/clk/qcom/lpass-gfm-sm8250.c
> @@ -251,15 +251,18 @@ static int lpass_gfm_clk_driver_probe(struct platform_device *pdev)
>         if (IS_ERR(cc->base))
>                 return PTR_ERR(cc->base);
>
> -       pm_runtime_enable(dev);
> -       err = pm_clk_create(dev);
> +       err = devm_pm_runtime_enable(dev);
>         if (err)
> -               goto pm_clk_err;
> +               return err;
> +
> +       err = devm_pm_clk_create(dev);
> +       if (err)
> +               return err;
>
>         err = of_pm_clk_add_clks(dev);
>         if (err < 0) {
>                 dev_dbg(dev, "Failed to get lpass core voting clocks\n");
> -               goto clk_reg_err;
> +               return err;
>         }
>
>         for (i = 0; i < data->onecell_data->num; i++) {
> @@ -273,22 +276,16 @@ static int lpass_gfm_clk_driver_probe(struct platform_device *pdev)
>
>                 err = devm_clk_hw_register(dev, &data->gfm_clks[i]->hw);
>                 if (err)
> -                       goto clk_reg_err;
> +                       return err;
>
>         }
>
>         err = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>                                           data->onecell_data);
>         if (err)
> -               goto clk_reg_err;
> +               return err;
>
>         return 0;
> -
> -clk_reg_err:
> -       pm_clk_destroy(dev);
> -pm_clk_err:
> -       pm_runtime_disable(dev);
> -       return err;
>  }
>
>  static const struct of_device_id lpass_gfm_clk_match_table[] = {
> diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
> index 2e0ecc38efdd..ac09b7b840ab 100644
> --- a/drivers/clk/qcom/lpasscorecc-sc7180.c
> +++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
> @@ -356,32 +356,18 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
>         .num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
>  };
>
> -static void lpass_pm_runtime_disable(void *data)
> -{
> -       pm_runtime_disable(data);
> -}
> -
> -static void lpass_pm_clk_destroy(void *data)
> -{
> -       pm_clk_destroy(data);
> -}
> -
>  static int lpass_create_pm_clks(struct platform_device *pdev)
>  {
>         int ret;
>
>         pm_runtime_use_autosuspend(&pdev->dev);
>         pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> -       pm_runtime_enable(&pdev->dev);
>
> -       ret = devm_add_action_or_reset(&pdev->dev, lpass_pm_runtime_disable, &pdev->dev);
> +       ret = devm_pm_runtime_enable(&pdev->dev);
>         if (ret)
>                 return ret;
>
> -       ret = pm_clk_create(&pdev->dev);
> -       if (ret)
> -               return ret;
> -       ret = devm_add_action_or_reset(&pdev->dev, lpass_pm_clk_destroy, &pdev->dev);
> +       ret = devm_pm_clk_create(&pdev->dev);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/clk/qcom/mss-sc7180.c b/drivers/clk/qcom/mss-sc7180.c
> index 673fa1a4f734..5a1407440662 100644
> --- a/drivers/clk/qcom/mss-sc7180.c
> +++ b/drivers/clk/qcom/mss-sc7180.c
> @@ -73,36 +73,23 @@ static int mss_sc7180_probe(struct platform_device *pdev)
>  {
>         int ret;
>
> -       pm_runtime_enable(&pdev->dev);
> -       ret = pm_clk_create(&pdev->dev);
> +       ret = devm_pm_runtime_enable(&pdev->dev);
>         if (ret)
> -               goto disable_pm_runtime;
> +               return ret;
> +
> +       ret = devm_pm_clk_create(&pdev->dev);
> +       if (ret)
> +               return ret;
>
>         ret = pm_clk_add(&pdev->dev, "cfg_ahb");
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "failed to acquire iface clock\n");
> -               goto destroy_pm_clk;
> +               return ret;
>         }
>
>         ret = qcom_cc_probe(pdev, &mss_sc7180_desc);
>         if (ret < 0)
> -               goto destroy_pm_clk;
> -
> -       return 0;
> -
> -destroy_pm_clk:
> -       pm_clk_destroy(&pdev->dev);
> -
> -disable_pm_runtime:
> -       pm_runtime_disable(&pdev->dev);
> -
> -       return ret;
> -}
> -
> -static int mss_sc7180_remove(struct platform_device *pdev)
> -{
> -       pm_clk_destroy(&pdev->dev);
> -       pm_runtime_disable(&pdev->dev);
> +               return ret;
>
>         return 0;
>  }
> @@ -119,7 +106,6 @@ MODULE_DEVICE_TABLE(of, mss_sc7180_match_table);
>
>  static struct platform_driver mss_sc7180_driver = {
>         .probe          = mss_sc7180_probe,
> -       .remove         = mss_sc7180_remove,
>         .driver         = {
>                 .name           = "sc7180-mss",
>                 .of_match_table = mss_sc7180_match_table,
> diff --git a/drivers/clk/qcom/q6sstop-qcs404.c b/drivers/clk/qcom/q6sstop-qcs404.c
> index 723f932fbf7d..507386bee07d 100644
> --- a/drivers/clk/qcom/q6sstop-qcs404.c
> +++ b/drivers/clk/qcom/q6sstop-qcs404.c
> @@ -159,15 +159,18 @@ static int q6sstopcc_qcs404_probe(struct platform_device *pdev)
>         const struct qcom_cc_desc *desc;
>         int ret;
>
> -       pm_runtime_enable(&pdev->dev);
> -       ret = pm_clk_create(&pdev->dev);
> +       ret = devm_pm_runtime_enable(&pdev->dev);
>         if (ret)
> -               goto disable_pm_runtime;
> +               return ret;
> +
> +       ret = devm_pm_clk_create(&pdev->dev);
> +       if (ret)
> +               return ret;
>
>         ret = pm_clk_add(&pdev->dev, NULL);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "failed to acquire iface clock\n");
> -               goto destroy_pm_clk;
> +               return ret;
>         }
>
>         q6sstop_regmap_config.name = "q6sstop_tcsr";
> @@ -175,30 +178,14 @@ static int q6sstopcc_qcs404_probe(struct platform_device *pdev)
>
>         ret = qcom_cc_probe_by_index(pdev, 1, desc);
>         if (ret)
> -               goto destroy_pm_clk;
> +               return ret;
>
>         q6sstop_regmap_config.name = "q6sstop_cc";
>         desc = &q6sstop_qcs404_desc;
>
>         ret = qcom_cc_probe_by_index(pdev, 0, desc);
>         if (ret)
> -               goto destroy_pm_clk;
> -
> -       return 0;
> -
> -destroy_pm_clk:
> -       pm_clk_destroy(&pdev->dev);
> -
> -disable_pm_runtime:
> -       pm_runtime_disable(&pdev->dev);
> -
> -       return ret;
> -}
> -
> -static int q6sstopcc_qcs404_remove(struct platform_device *pdev)
> -{
> -       pm_clk_destroy(&pdev->dev);
> -       pm_runtime_disable(&pdev->dev);
> +               return ret;
>
>         return 0;
>  }
> @@ -209,7 +196,6 @@ static const struct dev_pm_ops q6sstopcc_pm_ops = {
>
>  static struct platform_driver q6sstopcc_qcs404_driver = {
>         .probe          = q6sstopcc_qcs404_probe,
> -       .remove         = q6sstopcc_qcs404_remove,
>         .driver         = {
>                 .name   = "qcs404-q6sstopcc",
>                 .of_match_table = q6sstopcc_qcs404_match_table,
> diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
> index 4cfbbf5bf4d9..4543bda793f4 100644
> --- a/drivers/clk/qcom/turingcc-qcs404.c
> +++ b/drivers/clk/qcom/turingcc-qcs404.c
> @@ -110,36 +110,23 @@ static int turingcc_probe(struct platform_device *pdev)
>  {
>         int ret;
>
> -       pm_runtime_enable(&pdev->dev);
> -       ret = pm_clk_create(&pdev->dev);
> +       ret = devm_pm_runtime_enable(&pdev->dev);
>         if (ret)
> -               goto disable_pm_runtime;
> +               return ret;
> +
> +       ret = devm_pm_clk_create(&pdev->dev);
> +       if (ret)
> +               return ret;
>
>         ret = pm_clk_add(&pdev->dev, NULL);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "failed to acquire iface clock\n");
> -               goto destroy_pm_clk;
> +               return ret;
>         }
>
>         ret = qcom_cc_probe(pdev, &turingcc_desc);
>         if (ret < 0)
> -               goto destroy_pm_clk;
> -
> -       return 0;
> -
> -destroy_pm_clk:
> -       pm_clk_destroy(&pdev->dev);
> -
> -disable_pm_runtime:
> -       pm_runtime_disable(&pdev->dev);
> -
> -       return ret;
> -}
> -
> -static int turingcc_remove(struct platform_device *pdev)
> -{
> -       pm_clk_destroy(&pdev->dev);
> -       pm_runtime_disable(&pdev->dev);
> +               return ret;
>
>         return 0;
>  }
> @@ -156,7 +143,6 @@ MODULE_DEVICE_TABLE(of, turingcc_match_table);
>
>  static struct platform_driver turingcc_driver = {
>         .probe          = turingcc_probe,
> -       .remove         = turingcc_remove,
>         .driver         = {
>                 .name   = "qcs404-turingcc",
>                 .of_match_table = turingcc_match_table,
> --
> 2.30.2
>
