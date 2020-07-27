Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7586E22E5DC
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 08:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgG0G1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 02:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0G1J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 02:27:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B2DC0619D2
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2020 23:27:09 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j23so1443269vsq.7
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2020 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0graZ8FFIpnmTRz+2ZkRPfr1C9GlUQ+dh9E2ZpySws=;
        b=Vr0Jh1QFjAnD1Pu4tS+blqykY24ycyLQ2ZRzd6XRMDi5v+FD1T7L3WP4MDPBplgoBt
         j2fXXl4nISH5YQQXMWmeH/s62Zbc8s2fxESYW54T+zY5zGI+nQhIBYNcfQXcGwy86g+E
         8OUM5FgDULQ6oaIDQVYPUG64jvHPqeyOBsF3L87p8jhLjaCqCObyhQa/ZbqnsD3yPFgx
         ffKrqlN3B9NY8dYPCIXNVLe/g3uKbv4R7og7nC4hcMhKwuPz3SND+v5+R/gd6zTx12zA
         uO4fxvb1B+qp5VhC8bX4r7FNl8EPL78LfV/vknBUlz8EouIWDtuivtzPOOJbkaCsVJJm
         rHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0graZ8FFIpnmTRz+2ZkRPfr1C9GlUQ+dh9E2ZpySws=;
        b=YC93Xhi7c4ccdRwBlqOWF9ceIpwBdzaCbkYe/6lt2V/yorSPthy4t0DgPiMaEByuo5
         FO6YmXa1bP6MVDeTYU861cFZ0LHsA53yQ11MVFMdgmIRyYd0AJWTRcBLz0IfzYin9XXU
         ND8im2V49ZNg9xOTnvKBxU6cwyCWKjh4cBipMJiOAtdHPSY8WzH0/ta3MZNfVznLlGcp
         s+ZFEfwfjQycmU1wrwxoMuyyov8F+pTD5DvKwiB7bdPqSqF+EHnzNIA67v+Neiji5qWV
         oljbWmlVCpfSN15h1K/bPTT+Z9oREqoAUiIUIIOZwd+l3gurY2rmFdoiCvtBfRuguFnp
         expQ==
X-Gm-Message-State: AOAM533AvcCae11+HAunh06dsmNZQPb63DaX9dS0V5xksKM1veWHa/0z
        pEIboj5sWGYIMANWM+uPjA5TLaksIJ5O15xqPFi0sQ==
X-Google-Smtp-Source: ABdhPJxMquLnrdEoUVidLeVzJumC6EkyIEPo6Y42BA0b/l1V1bK0LHTV2eMYoKyMhPErKFKElkpbiqdT+e2zktvRqKg=
X-Received: by 2002:a67:6b05:: with SMTP id g5mr14722654vsc.9.1595831228649;
 Sun, 26 Jul 2020 23:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200629144926.665-1-shawn.guo@linaro.org> <20200629144926.665-3-shawn.guo@linaro.org>
In-Reply-To: <20200629144926.665-3-shawn.guo@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 27 Jul 2020 11:56:57 +0530
Message-ID: <CAHLCerMyEsvuhNPnwDow5JYVAbem0Rzs+5-uzKZNeFt+3rYHQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: qcom: tsens-v0_1: Add support for MSM8939
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 30, 2020 at 1:09 AM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> The TSENS integrated on MSM8939 is a v0_1 device with 10 sensors.
> Different from its predecessor MSM8916, where 'calib_sel' bits sit in
> separate qfprom word, MSM8939 has 'cailb' and 'calib_sel' bits mixed and
> spread on discrete offsets.  That's why all qfprom bits are read as one
> go and later mapped to calibration data for MSM8939.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 144 +++++++++++++++++++++++++++++-
>  drivers/thermal/qcom/tsens.c      |   3 +
>  drivers/thermal/qcom/tsens.h      |   2 +-
>  3 files changed, 147 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 959a9371d205..e64db5f80d90 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -48,6 +48,63 @@
>  #define MSM8916_CAL_SEL_MASK   0xe0000000
>  #define MSM8916_CAL_SEL_SHIFT  29
>
> +/* eeprom layout data for 8939 */
> +#define MSM8939_BASE0_MASK     0x000000ff
> +#define MSM8939_BASE1_MASK     0xff000000
> +#define MSM8939_BASE0_SHIFT    0
> +#define MSM8939_BASE1_SHIFT    24
> +
> +#define MSM8939_S0_P1_MASK     0x000001f8
> +#define MSM8939_S1_P1_MASK     0x001f8000
> +#define MSM8939_S2_P1_MASK_0_4 0xf8000000
> +#define MSM8939_S2_P1_MASK_5   0x00000001
> +#define MSM8939_S3_P1_MASK     0x00001f80
> +#define MSM8939_S4_P1_MASK     0x01f80000
> +#define MSM8939_S5_P1_MASK     0x00003f00
> +#define MSM8939_S6_P1_MASK     0x03f00000
> +#define MSM8939_S7_P1_MASK     0x0000003f
> +#define MSM8939_S8_P1_MASK     0x0003f000
> +#define MSM8939_S9_P1_MASK     0x07e00000
> +
> +#define MSM8939_S0_P2_MASK     0x00007e00
> +#define MSM8939_S1_P2_MASK     0x07e00000
> +#define MSM8939_S2_P2_MASK     0x0000007e
> +#define MSM8939_S3_P2_MASK     0x0007e000
> +#define MSM8939_S4_P2_MASK     0x7e000000
> +#define MSM8939_S5_P2_MASK     0x000fc000
> +#define MSM8939_S6_P2_MASK     0xfc000000
> +#define MSM8939_S7_P2_MASK     0x00000fc0
> +#define MSM8939_S8_P2_MASK     0x00fc0000
> +#define MSM8939_S9_P2_MASK_0_4 0xf8000000
> +#define MSM8939_S9_P2_MASK_5   0x00002000
> +
> +#define MSM8939_S0_P1_SHIFT    3
> +#define MSM8939_S1_P1_SHIFT    15
> +#define MSM8939_S2_P1_SHIFT_0_4        27
> +#define MSM8939_S2_P1_SHIFT_5  0
> +#define MSM8939_S3_P1_SHIFT    7
> +#define MSM8939_S4_P1_SHIFT    19
> +#define MSM8939_S5_P1_SHIFT    8
> +#define MSM8939_S6_P1_SHIFT    20
> +#define MSM8939_S7_P1_SHIFT    0
> +#define MSM8939_S8_P1_SHIFT    12
> +#define MSM8939_S9_P1_SHIFT    21
> +
> +#define MSM8939_S0_P2_SHIFT    9
> +#define MSM8939_S1_P2_SHIFT    21
> +#define MSM8939_S2_P2_SHIFT    1
> +#define MSM8939_S3_P2_SHIFT    13
> +#define MSM8939_S4_P2_SHIFT    25
> +#define MSM8939_S5_P2_SHIFT    14
> +#define MSM8939_S6_P2_SHIFT    26
> +#define MSM8939_S7_P2_SHIFT    6
> +#define MSM8939_S8_P2_SHIFT    18
> +#define MSM8939_S9_P2_SHIFT_0_4        27
> +#define MSM8939_S9_P2_SHIFT_5  13
> +
> +#define MSM8939_CAL_SEL_MASK   0x7
> +#define MSM8939_CAL_SEL_SHIFT  0
> +
>  /* eeprom layout data for 8974 */
>  #define BASE1_MASK             0xff
>  #define S0_P1_MASK             0x3f00
> @@ -189,6 +246,76 @@ static int calibrate_8916(struct tsens_priv *priv)
>         return 0;
>  }
>
> +static int calibrate_8939(struct tsens_priv *priv)
> +{
> +       int base0 = 0, base1 = 0, i;
> +       u32 p1[10], p2[10];
> +       int mode = 0;
> +       u32 *qfprom_cdata;
> +       u32 cdata[6];
> +
> +       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> +       if (IS_ERR(qfprom_cdata))
> +               return PTR_ERR(qfprom_cdata);
> +
> +       /* Mapping between qfprom nvmem and calibration data */
> +       cdata[0] = qfprom_cdata[12];
> +       cdata[1] = qfprom_cdata[13];
> +       cdata[2] = qfprom_cdata[0];
> +       cdata[3] = qfprom_cdata[1];
> +       cdata[4] = qfprom_cdata[22];
> +       cdata[5] = qfprom_cdata[21];
> +
> +       mode = (cdata[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
> +       dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +
> +       switch (mode) {
> +       case TWO_PT_CALIB:
> +               base1 = (cdata[3] & MSM8939_BASE1_MASK) >> MSM8939_BASE1_SHIFT;
> +               p2[0] = (cdata[0] & MSM8939_S0_P2_MASK) >> MSM8939_S0_P2_SHIFT;
> +               p2[1] = (cdata[0] & MSM8939_S1_P2_MASK) >> MSM8939_S1_P2_SHIFT;
> +               p2[2] = (cdata[1] & MSM8939_S2_P2_MASK) >> MSM8939_S2_P2_SHIFT;
> +               p2[3] = (cdata[1] & MSM8939_S3_P2_MASK) >> MSM8939_S3_P2_SHIFT;
> +               p2[4] = (cdata[1] & MSM8939_S4_P2_MASK) >> MSM8939_S4_P2_SHIFT;
> +               p2[5] = (cdata[2] & MSM8939_S5_P2_MASK) >> MSM8939_S5_P2_SHIFT;
> +               p2[6] = (cdata[2] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
> +               p2[7] = (cdata[3] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
> +               p2[8] = (cdata[3] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
> +               p2[9] = (cdata[4] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
> +               p2[9] |= ((cdata[5] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5) << 5;
> +               for (i = 0; i < priv->num_sensors; i++)
> +                       p2[i] = (base1 + p2[i]) << 2;
> +               fallthrough;
> +       case ONE_PT_CALIB2:
> +               base0 = (cdata[2] & MSM8939_BASE0_MASK) >> MSM8939_BASE0_SHIFT;
> +               p1[0] = (cdata[0] & MSM8939_S0_P1_MASK) >> MSM8939_S0_P1_SHIFT;
> +               p1[1] = (cdata[0] & MSM8939_S1_P1_MASK) >> MSM8939_S1_P1_SHIFT;
> +               p1[2] = (cdata[0] & MSM8939_S2_P1_MASK_0_4) >> MSM8939_S2_P1_SHIFT_0_4;
> +               p1[2] |= ((cdata[1] & MSM8939_S2_P1_MASK_5) >> MSM8939_S2_P1_SHIFT_5) << 5;
> +               p1[3] = (cdata[1] & MSM8939_S3_P1_MASK) >> MSM8939_S3_P1_SHIFT;
> +               p1[4] = (cdata[1] & MSM8939_S4_P1_MASK) >> MSM8939_S4_P1_SHIFT;
> +               p1[5] = (cdata[2] & MSM8939_S5_P1_MASK) >> MSM8939_S5_P1_SHIFT;
> +               p1[6] = (cdata[2] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
> +               p1[7] = (cdata[3] & MSM8939_S7_P1_MASK) >> MSM8939_S7_P1_SHIFT;
> +               p1[8] = (cdata[3] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
> +               p1[9] = (cdata[4] & MSM8939_S9_P1_MASK) >> MSM8939_S9_P1_SHIFT;
> +               for (i = 0; i < priv->num_sensors; i++)
> +                       p1[i] = ((base0) + p1[i]) << 2;
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
> +
> +       return 0;
> +}
> +
>  static int calibrate_8974(struct tsens_priv *priv)
>  {
>         int base1 = 0, base2 = 0, i;
> @@ -325,7 +452,7 @@ static int calibrate_8974(struct tsens_priv *priv)
>         return 0;
>  }
>
> -/* v0.1: 8916, 8974 */
> +/* v0.1: 8916, 8939, 8974 */
>
>  static struct tsens_features tsens_v0_1_feat = {
>         .ver_major      = VER_0_1,
> @@ -386,6 +513,21 @@ struct tsens_plat_data data_8916 = {
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
> +       .ops            = &ops_8939,
> +       .hw_ids         = (unsigned int []){ 0, 1, 2, 4, 5, 6, 7, 8, 9, 10 },
> +
> +       .feat           = &tsens_v0_1_feat,
> +       .fields = tsens_v0_1_regfields,
> +};
> +
>  static const struct tsens_ops ops_8974 = {
>         .init           = init_common,
>         .calibrate      = calibrate_8974,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 8d3e94d2a9ed..52656a24f813 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -897,6 +897,9 @@ static const struct of_device_id tsens_table[] = {
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
> index 59d01162c66a..f40b625f897e 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -585,7 +585,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
>  extern struct tsens_plat_data data_8960;
>
>  /* TSENS v0.1 targets */
> -extern struct tsens_plat_data data_8916, data_8974;
> +extern struct tsens_plat_data data_8916, data_8939, data_8974;
>
>  /* TSENS v1 targets */
>  extern struct tsens_plat_data data_tsens_v1, data_8976;
> --
> 2.17.1
>
