Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE279760C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjIGQBH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 12:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjIGP4j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 11:56:39 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14D59EFD
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 08:44:44 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-565403bda57so801428a12.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101339; x=1694706139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ovU/2FxJPAjDLCUg/8wOJ1lYtXOuaSxCgEubikhoGHQ=;
        b=n2NEAwHmIRqILOxj/PejPJaZfLDqMO6hj/j9R1790lFApIV4l94b8N6RxsvcvcHMyY
         XHSAPg94L1q9NdnUvLTYmk958FNPaFPI5qK1mpeddIlb3/cltxsy1AUe2/l4qoVbSImy
         7ykDQgpRIouGftsh6k/UKoTNT8Ee5rJOnNjMp+B03G0+A9JkCenh0cbb+cEPwxQPR9/j
         xhWAVyMsS98MNjc0qtYYrXy1E6p8YjjZzm3wReu1gDP/3eSOGstphn9woih/AIdpwjgH
         WDazAvKaNk7WunReHMpxATTNDk0mki00l2GPMJWA4xx0mGUTfBaB1u6ROu1xs5gQYc0H
         bbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101339; x=1694706139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovU/2FxJPAjDLCUg/8wOJ1lYtXOuaSxCgEubikhoGHQ=;
        b=J97joymrQoAGmXywlAe4cMFGL8lxsAFiRU8XJsNDa5uKnbuve3CqiT37J0lUo1WH97
         xJ3vG7iGdeTyFoTTYCeXvOEMW5GIMGEAKN35GZYLe90lRoDv7/ALF/E/aA7TA//NEDqK
         FnsZ3aY5GLEq/BEwKTuIjrDKOuvsaFgKrbIFoxL8FOYwdYOCKjPyLEnvUFFrylJLxLfX
         iP4jDuVRoLSywnZfRAhc7eMFfbmFPmRF11Et8M6YZXkZNsfVTehq1laUlTTiunDbRqyp
         daeklLvQBpbXYPJTHah1D8GmaeaQSsAGOzAo9TsdhJwB6IkqVpeROd6BI3YxgjeyimUK
         ltww==
X-Gm-Message-State: AOJu0Yxn6i13nXTfkqSfp0Ot5eXVnxqYIqQXSjUZJFHicAfZYeyb7Rmy
        7UlkIcymcoyOoGxJLN2sAA089agUt0+AMmx3ipFGhSlVxPbzHAG41Sk=
X-Google-Smtp-Source: AGHT+IGgGELYVKv2nxaDzcRi7A6G5VIgfNHh71hrLRfSFiCDzzZExTZrNatFtyjQnKvxF58qCdkuFUnRMrIuFGcEb1g=
X-Received: by 2002:a25:ad03:0:b0:d7b:8c90:ce5b with SMTP id
 y3-20020a25ad03000000b00d7b8c90ce5bmr19553639ybi.63.1694093984119; Thu, 07
 Sep 2023 06:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <18a3bc0c5b371deec5c4bbe6ceacf8afcf0bc640.1693996662.git.quic_varada@quicinc.com>
In-Reply-To: <18a3bc0c5b371deec5c4bbe6ceacf8afcf0bc640.1693996662.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Sep 2023 16:39:33 +0300
Message-ID: <CAA8EJpoZ_8zXn9RcZQ+dV+hOpYBZQtD7oUQxWQYUqfTN+X=+7A@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] clk: qcom: clk-alpha-pll: introduce stromer plus ops
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 7 Sept 2023 at 08:22, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Stromer plus APSS PLL does not support dynamic frequency scaling.
> To switch between frequencies, we have to shut down the PLL,
> configure the L and ALPHA values and turn on again. So introduce the
> separate set of ops for Stromer Plus PLL.
>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 68 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-alpha-pll.h |  1 +
>  2 files changed, 69 insertions(+)
>
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index e4ef645..2ef81f7 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -2479,3 +2479,71 @@ const struct clk_ops clk_alpha_pll_stromer_ops = {
>         .set_rate = clk_alpha_pll_stromer_set_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
> +
> +static int clk_alpha_pll_stromer_plus_determine_rate(struct clk_hw *hw,
> +                                                    struct clk_rate_request *req)
> +{
> +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +       u32 l, alpha_width = pll_alpha_width(pll);
> +       u64 a;
> +
> +       req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate, &l,
> +                                        &a, alpha_width);
> +       return 0;
> +}

What is the plL_alpha_width on stromer_plus? Does
clk_alpha_pll_stromer_determine_rate() work for you?

> +
> +static int clk_alpha_pll_stromer_plus_set_rate(struct clk_hw *hw,
> +                                              unsigned long rate,
> +                                              unsigned long prate)
> +{
> +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +       u32 l, alpha_width = pll_alpha_width(pll);
> +       int ret;
> +       u64 a;
> +
> +       rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
> +
> +       regmap_write(pll->clkr.regmap, PLL_MODE(pll), 0);
> +
> +       /* Delay of 2 output clock ticks required until output is disabled */
> +       udelay(1);
> +
> +       regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> +
> +       if (alpha_width > ALPHA_BITWIDTH)
> +               a <<= alpha_width - ALPHA_BITWIDTH;
> +
> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
> +                                       a >> ALPHA_BITWIDTH);
> +
> +       regmap_write(pll->clkr.regmap, PLL_MODE(pll), PLL_BYPASSNL);
> +
> +       /* Wait five micro seconds or more */
> +       udelay(5);
> +       regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_RESET_N,
> +                          PLL_RESET_N);
> +
> +       /* The lock time should be less than 50 micro seconds worst case */
> +       udelay(50);
> +
> +       ret = wait_for_pll_enable_lock(pll);
> +       if (ret) {
> +               pr_err("alpha pll running in 800 MHz with source GPLL0\n");
> +               return ret;
> +       }
> +       regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL,
> +                          PLL_OUTCTRL);
> +
> +       return 0;
> +}
> +
> +const struct clk_ops clk_alpha_pll_stromer_plus_ops = {
> +       .enable = clk_alpha_pll_enable,
> +       .disable = clk_alpha_pll_disable,
> +       .is_enabled = clk_alpha_pll_is_enabled,
> +       .recalc_rate = clk_alpha_pll_recalc_rate,
> +       .determine_rate = clk_alpha_pll_stromer_plus_determine_rate,
> +       .set_rate = clk_alpha_pll_stromer_plus_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_plus_ops);
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index e4bd863..903fbab 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -152,6 +152,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_ops;
>  extern const struct clk_ops clk_alpha_pll_huayra_ops;
>  extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
>  extern const struct clk_ops clk_alpha_pll_stromer_ops;
> +extern const struct clk_ops clk_alpha_pll_stromer_plus_ops;
>
>  extern const struct clk_ops clk_alpha_pll_fabia_ops;
>  extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
