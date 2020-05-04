Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8141C32FA
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 08:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEDGcB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 02:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgEDGcA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 02:32:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96FC061A0E
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 23:32:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so8529073ljd.3
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15GEnTmegXJFSpar+IlKuYxil7cPr4qiqw1UqwXmEK4=;
        b=IbNtuBabKGrRCwWn89UnhW6zswaaA73zCqJIWm69Ib22X/jHQricNQIOOZFZdTvLBu
         qVvMN3Wjp8A6h4JHPSo1PW0v1yQS+MWozhKSkWn6cec2h1IGD3dd3RrHuTPLbtHG/Wjx
         gevMwyKevbtABkYtgIk2pJ+/C/lP6oBo9nks51KFpObuYTlD1T2UPk50fnM/Zr0D0Neu
         M1Jq5w8COLh3urQJ3Rfv/ZBrM8plTrtFklckUNc1guarVjI/gQtmCZ4qoSf2bjg7N56p
         InvhmX9O8i653FRoGnZtedFLebUyOST4uxii47TuX4IOCfNpyrkrwLFotPt9v5yZMR+M
         b6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15GEnTmegXJFSpar+IlKuYxil7cPr4qiqw1UqwXmEK4=;
        b=ElLlNoLJQNzQzyAlvn/ZXqIxzEu59mzw2eBgcTf2Ss6Ik8L89o7xaxwAEbXRTlTZ+5
         op1EV7HAhXvgr5NBWrmv2ow28nGAREkSDdZWNFttdetxus4mDSo5WrLUnpW4LrOG7c3z
         WTZEe0ji0kym63IBHD8eW5xBkiXEcKB6c5dtXiM4LkMCR7i+yj7MiM73mXu8Ank++v8+
         LpPzEhkocv6subL558aPEaHDg6zIippVnj8BuU4QK/X/54ANndsIC8n5XpUzI4JsZr/b
         1wKPopWHC7Ewcjrr4JnBWyi/eeYQMD2TBYqO5pO5xE1F0DrrWRyhuPY3oTefk52s2hMn
         AoIA==
X-Gm-Message-State: AGi0PuYKONlVuPBfc69TanX0l1OxwXpPIChou/Uh0cDgRyfM1p3STxck
        MZX9y7HPEwEA/FGeuqBmMjyj6iJBugzD8FJkxsW719TA
X-Google-Smtp-Source: APiQypISziGViI7rr1VN0Q5hVXr1Td+AkK1T4H0fFF9nJZAJ/Ik/1qnbkQVA1GCoaF1mGMmBgbot5UUu79Uzo6pjqJY=
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr9224789ljk.286.1588573918781;
 Sun, 03 May 2020 23:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200501203311.143934-1-konradybcio@gmail.com> <20200501203311.143934-2-konradybcio@gmail.com>
In-Reply-To: <20200501203311.143934-2-konradybcio@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 4 May 2020 12:01:29 +0530
Message-ID: <CAP245DUOcsort1B1ftWW251Bzxp8=SuaGdZuZBmUubO9tw78cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: qcom: tsens-v0_1: Add support for MSM8939
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 2, 2020 at 2:03 AM Konrad Dybcio <konradybcio@gmail.com> wrote:
>
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 142 +++++++++++++++++++++++++++++-
>  drivers/thermal/qcom/tsens.c      |   3 +
>  drivers/thermal/qcom/tsens.h      |   2 +-
>  3 files changed, 145 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 959a9371d205c..29b95886273b7 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -48,6 +48,64 @@
>  #define MSM8916_CAL_SEL_MASK   0xe0000000
>  #define MSM8916_CAL_SEL_SHIFT  29
>
> +/* eeprom layout data for 8939 */
> +#define MSM8939_BASE0_MASK           0x000000ff
> +#define MSM8939_BASE1_MASK           0xff000000
> +#define MSM8939_BASE0_SHIFT

Use 0?

> +#define MSM8939_BASE1_SHIFT          24
> +
> +#define MSM8939_S0_P1_MASK         0x000001f8
> +#define MSM8939_S1_P1_MASK         0x001f8000
> +#define MSM8939_S2_P1_MASK_0_4     0xf8000000
> +#define MSM8939_S2_P1_MASK_5       0x00000001
> +#define MSM8939_S3_P1_MASK         0x00001f80
> +#define MSM8939_S4_P1_MASK         0x01f80000
> +#define MSM8939_S5_P1_MASK         0x00003f00
> +#define MSM8939_S6_P1_MASK         0x03f00000
> +#define MSM8939_S7_P1_MASK         0x0000003f
> +#define MSM8939_S8_P1_MASK         0x0003f000
> +#define MSM8939_S9_P1_MASK         0x07e00000
> +
> +#define MSM8939_S0_P2_MASK         0x00007e00
> +#define MSM8939_S1_P2_MASK         0x07e00000
> +#define MSM8939_S2_P2_MASK         0x0000007e
> +#define MSM8939_S3_P2_MASK         0x0007e000
> +#define MSM8939_S4_P2_MASK         0x7e000000
> +#define MSM8939_S5_P2_MASK         0x000fc000
> +#define MSM8939_S6_P2_MASK         0xfc000000
> +#define MSM8939_S7_P2_MASK         0x00000fc0
> +#define MSM8939_S8_P2_MASK         0x00fc0000
> +#define MSM8939_S9_P2_MASK_0_4     0xf8000000
> +#define MSM8939_S9_P2_MASK_5       0x00002000
> +
> +#define MSM8939_CAL_SEL_MASK   0xc0000000
> +#define MSM8939_CAL_SEL_SHIFT  0
> +
> +

Get rid of extra line.

> +#define MSM8939_S0_P1_SHIFT        3
> +#define MSM8939_S1_P1_SHIFT        15
> +#define MSM8939_S2_P1_SHIFT_0_4    27
> +#define MSM8939_S2_P1_SHIFT_5      5
> +#define MSM8939_S3_P1_SHIFT        7
> +#define MSM8939_S4_P1_SHIFT        19
> +#define MSM8939_S5_P1_SHIFT        8
> +#define MSM8939_S6_P1_SHIFT        20
> +//yes, 7 is missing in downstream

Use C style comments.

> +#define MSM8939_S8_P1_SHIFT        12
> +#define MSM8939_S9_P1_SHIFT        21
> +
> +#define MSM8939_S0_P2_SHIFT        9
> +#define MSM8939_S1_P2_SHIFT        21
> +#define MSM8939_S2_P2_SHIFT        1
> +#define MSM8939_S3_P2_SHIFT        13
> +#define MSM8939_S4_P2_SHIFT        25
> +#define MSM8939_S5_P2_SHIFT        14
> +#define MSM8939_S6_P2_SHIFT        26
> +#define MSM8939_S7_P2_SHIFT        6
> +#define MSM8939_S8_P2_SHIFT        18
> +#define MSM8939_S9_P2_SHIFT_0_4    27
> +#define MSM8939_S9_P2_SHIFT_5      8
> +
>  /* eeprom layout data for 8974 */
>  #define BASE1_MASK             0xff
>  #define S0_P1_MASK             0x3f00
> @@ -189,6 +247,73 @@ static int calibrate_8916(struct tsens_priv *priv)
>         return 0;
>  }
>
> +static int calibrate_8939(struct tsens_priv *priv)
> +{
> +       int base0 = 0, base1 = 0, i;
> +       u32 p1[11], p2[11];
> +       int mode = 0;
> +       u32 *qfprom_cdata, *qfprom_csel;
> +
> +       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> +       if (IS_ERR(qfprom_cdata))
> +               return PTR_ERR(qfprom_cdata);
> +
> +       qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
> +       if (IS_ERR(qfprom_csel)) {
> +               kfree(qfprom_cdata);
> +               return PTR_ERR(qfprom_csel);
> +       }
> +
> +       mode = (qfprom_csel[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
> +       dev_dbg(priv->dev, "calibration mode is %d\n", mode);

Add an extra line here.

> +       switch (mode) {
> +       case TWO_PT_CALIB:
> +               base1 = (qfprom_cdata[1] & MSM8939_BASE1_MASK) >> MSM8939_BASE1_SHIFT;
> +               p2[0] = (qfprom_cdata[0] & MSM8939_S0_P2_MASK) >> MSM8939_S0_P2_SHIFT;
> +               p2[1] = (qfprom_cdata[0] & MSM8939_S1_P2_MASK) >> MSM8939_S1_P2_SHIFT;
> +               p2[2] = (qfprom_cdata[1] & MSM8939_S2_P2_MASK) >> MSM8939_S2_P2_SHIFT;
> +               p2[3] = (qfprom_cdata[1] & MSM8939_S3_P2_MASK) >> MSM8939_S3_P2_SHIFT;
> +               p2[4] = (qfprom_cdata[1] & MSM8939_S4_P2_MASK) >> MSM8939_S4_P2_SHIFT;
> +               p2[5] = (qfprom_cdata[1] & MSM8939_S5_P2_MASK) >> MSM8939_S5_P2_SHIFT;
> +               p2[6] = (qfprom_cdata[1] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
> +               p2[7] = (qfprom_cdata[1] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
> +               p2[8] = (qfprom_cdata[1] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
> +               p2[9] = (qfprom_cdata[1] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
> +               p2[10] = (qfprom_cdata[1] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5;
> +               for (i = 0; i < priv->num_sensors; i++)
> +                       p2[i] = ((base1 + p2[i]) << 3);
> +               /* Fall through */
> +       case ONE_PT_CALIB2:
> +               base0 = (qfprom_cdata[0] & MSM8939_BASE0_MASK);
> +               p1[0] = (qfprom_cdata[0] & MSM8939_S0_P1_MASK) >> MSM8939_S0_P1_SHIFT;
> +               p1[1] = (qfprom_cdata[0] & MSM8939_S1_P1_MASK) >> MSM8939_S1_P1_SHIFT;
> +               p1[2] = (qfprom_cdata[0] & MSM8939_S2_P1_MASK_0_4) >> MSM8939_S2_P1_SHIFT_0_4;
> +               p1[3] = (qfprom_cdata[0] & MSM8939_S2_P1_MASK_5) >> MSM8939_S2_P1_SHIFT_5;
> +               p1[4] = (qfprom_cdata[1] & MSM8939_S3_P1_MASK) >> MSM8939_S3_P1_SHIFT;
> +               p1[5] = (qfprom_cdata[1] & MSM8939_S4_P1_MASK) >> MSM8939_S4_P1_SHIFT;
> +               p1[6] = (qfprom_cdata[1] & MSM8939_S5_P1_MASK) >> MSM8939_S5_P1_SHIFT;
> +               p1[7] = (qfprom_cdata[1] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
> +               //yes, 7 is missing in downstream

Use C comment style. Might this be a bug?

> +               p1[8] = (qfprom_cdata[1] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
> +               p1[9] = (qfprom_cdata[1] & MSM8939_S9_P1_MASK) >> MSM8939_S9_P1_SHIFT;
> +               for (i = 0; i < priv->num_sensors; i++)
> +                       p1[i] = (((base0) + p1[i]) << 3);
> +               break;
> +       default:
> +               for (i = 0; i < priv->num_sensors; i++) {
> +                       p1[i] = 500;
> +                       p2[i] = 780;
> +               }
> +               break;
> +       }
> +
> +       compute_intercept_slope(priv, p1, p2, mode);
> +       kfree(qfprom_cdata);
> +       kfree(qfprom_csel);
> +
> +       return 0;
> +}
> +
>  static int calibrate_8974(struct tsens_priv *priv)
>  {
>         int base1 = 0, base2 = 0, i;
> @@ -325,7 +450,7 @@ static int calibrate_8974(struct tsens_priv *priv)
>         return 0;
>  }
>
> -/* v0.1: 8916, 8974 */
> +/* v0.1: 8916, 8939, 8974 */
>
>  static struct tsens_features tsens_v0_1_feat = {
>         .ver_major      = VER_0_1,
> @@ -386,6 +511,21 @@ struct tsens_plat_data data_8916 = {
>         .fields = tsens_v0_1_regfields,
>  };
>
> +static const struct tsens_ops ops_8939 = {
> +       .init           = init_common,
> +       .calibrate      = calibrate_8939,
> +       .get_temp       = get_temp_common,
> +};
> +
> +struct tsens_plat_data data_8939 = {
> +       .num_sensors    = 10,

I think 8939 has 11 sensors. Can you confirm?

> +       .ops            = &ops_8939,
> +       .hw_ids         = (unsigned int []){0, 1, 2, 4, 5, 6, 7, 8, 9 },

And this should be equal to the number of sensors


> +
> +       .feat           = &tsens_v0_1_feat,
> +       .fields = tsens_v0_1_regfields,
> +};
> +
>  static const struct tsens_ops ops_8974 = {
>         .init           = init_common,
>         .calibrate      = calibrate_8974,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 2f77d235cf735..f654057e96ae1 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -59,6 +59,9 @@ static const struct of_device_id tsens_table[] = {
>         {
>                 .compatible = "qcom,msm8916-tsens",
>                 .data = &data_8916,
> +       }, {
> +               .compatible = "qcom,msm8939-tsens",
> +               .data = &data_8939,
>         }, {
>                 .compatible = "qcom,msm8974-tsens",
>                 .data = &data_8974,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 502acf0e68285..403b15546f648 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -590,7 +590,7 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data);
>  extern struct tsens_plat_data data_8960;
>
>  /* TSENS v0.1 targets */
> -extern struct tsens_plat_data data_8916, data_8974;
> +extern struct tsens_plat_data data_8916, data_8939, data_8974;
>
>  /* TSENS v1 targets */
>  extern struct tsens_plat_data data_tsens_v1, data_8976;
> --
> 2.26.1
>
