Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49859241B3D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 14:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgHKM6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgHKM6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 08:58:05 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59645C06174A
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 05:58:05 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id m12so2602871vko.5
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBFHfl706h8Q/rIQEa117NC5OvZkkSKYk5SzCFZSYis=;
        b=Obr5opiZuO2ryFJN5Sft0B2C2MHLQ7ZL/zDgEGPuxOTr85P1WaydVIimaASb/eZ80j
         98/eZMLZHEIB5oct++4Zu9VYzBitp13gPamxYOcbradM9sfIVVIgSboowqFt9YjDLjgf
         PVXsbzCIbV2FLjlLMIK0VmhJObzhkWjd5+s3iBU8jL2PcRcPVbNSWcobn+We+Xi4359s
         UbNrKts1JWQLX5EwiV0GS7LQaSSJB6Wa+DcPXo4obiuxC0DWfUBwgVQVvDnonKDokD4n
         a8ODAPNJlfoZsXNxaZIojz+9Xi0pDQPJOKKpJpXXrpNYTpNPt4P3uCU0UxUKXCXwpXmq
         9WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBFHfl706h8Q/rIQEa117NC5OvZkkSKYk5SzCFZSYis=;
        b=E7cVrfR9f878Bk0Zj7PsV/BQsO5FVs3xVBQch+2w1DxOBJEod9wPn0XysGpZ/JpY+N
         CzyLNfuL7Qcy/vZT/csaHB9BBea/TznTR45FFOvYKjrKZu+0cX+4E8zA4MGHMk3IkpVi
         JJ6uziypJJBKHxpTqRlXo/aXx78ezqBy2SEhbDpDySbMaNPlgcddLAmXjMv3fz2mgWd8
         Sb6OfBvwe4lCEsaWAo4W+UDV9J+eu1YzMaGWfA0NTpacxuFWE6xyBtmPsLV3nowqPItW
         RxuFByyQ4DJprNTn24OHe0iCUYCNjtHUXjyR+ZqbQLMjE8Y57kIDOGgfUxiI9cOS884/
         pOEg==
X-Gm-Message-State: AOAM533tSlMmDElmC4275jVLTxKbMHcEYhawVVWhEn83Rw6XzbDtAKnB
        LjXMfObl3VzwxviwsnW52hC/FQaOA/YDDhYajmu9QA==
X-Google-Smtp-Source: ABdhPJzDrXCZmbt9/m57eR99/eX0TO4r0pa0DE4iQxGP3NaiFrTboxgbCASK0cRRih00hTqSZictiDAc0M3qeyBgQrw=
X-Received: by 2002:a1f:9048:: with SMTP id s69mr8450750vkd.73.1597150684496;
 Tue, 11 Aug 2020 05:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200725181404.18951-1-ansuelsmth@gmail.com> <20200725181404.18951-3-ansuelsmth@gmail.com>
In-Reply-To: <20200725181404.18951-3-ansuelsmth@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 11 Aug 2020 18:27:53 +0530
Message-ID: <CAHLCerN_S+5G0oZrAjoui7U6H+H46uLeYHe3p3PVbmCDwJtC_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/7] drivers: thermal: tsens: Convert msm8960 to reg_field
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 25, 2020 at 11:44 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Covert msm9860 driver to reg_filed to use the init_common

typo: field

> function.
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/thermal/qcom/tsens-8960.c | 74 +++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 2a28a5af209e..45cd0cdff2f5 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -56,6 +56,18 @@
>  #define TRDY_MASK              BIT(7)
>  #define TIMEOUT_US             100
>
> +#define S0_STATUS_OFF          0x3628
> +#define S1_STATUS_OFF          0x362c
> +#define S2_STATUS_OFF          0x3630
> +#define S3_STATUS_OFF          0x3634
> +#define S4_STATUS_OFF          0x3638
> +#define S5_STATUS_OFF          0x3664  /* Sensors 5 thru 10 found on apq8064/msm8960 */

Run checkpatch and fix spelling. :-) Or just say 'sensor 5-10'

> +#define S6_STATUS_OFF          0x3668
> +#define S7_STATUS_OFF          0x366c
> +#define S8_STATUS_OFF          0x3670
> +#define S9_STATUS_OFF          0x3674
> +#define S10_STATUS_OFF         0x3678
> +
>  static int suspend_8960(struct tsens_priv *priv)
>  {
>         int ret;
> @@ -269,6 +281,66 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
>         return -ETIMEDOUT;
>  }
>
> +static struct tsens_features tsens_8960_feat = {
> +       .ver_major      = VER_0,
> +       .crit_int       = 0,
> +       .adc            = 1,
> +       .srot_split     = 0,
> +       .max_sensors    = 11,

Align the equal to like in other files please.

> +};
> +
> +static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
> +       /* ----- SROT ------ */
> +       /* No VERSION information */
> +
> +       /* CNTL */
> +       [TSENS_EN]     = REG_FIELD(CNTL_ADDR,  0, 0),
> +       [TSENS_SW_RST] = REG_FIELD(CNTL_ADDR,  1, 1),
> +       /* 8960 has 5 sensors, 8660 has 11, we only handle 5 */
> +       [SENSOR_EN]    = REG_FIELD(CNTL_ADDR,  3, 7),
> +
> +       /* ----- TM ------ */
> +       /* INTERRUPT ENABLE */
> +       // [INT_EN] = REG_FIELD(TM_INT_EN_OFF, 0, 0),

Get rid of these comments and at the very least use C-style comments.

> +
> +       /* Single UPPER/LOWER TEMPERATURE THRESHOLD for all sensors */
> +       [LOW_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR,  0,  7),
> +       [UP_THRESH_0]    = REG_FIELD(THRESHOLD_ADDR,  8, 15),
> +       [MIN_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR, 16, 23),
> +       [MAX_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR, 24, 31),
> +
> +       // /* UPPER/LOWER INTERRUPT [CLEAR/STATUS] */
> +       // /* 1 == clear, 0 == normal operation */

Get rid of these comments and at the very least use C-style comments.


> +       [LOW_INT_CLEAR_0]   = REG_FIELD(CNTL_ADDR,  9,  9),
> +       [UP_INT_CLEAR_0]    = REG_FIELD(CNTL_ADDR, 10, 10),
> +
> +       /* NO CRITICAL INTERRUPT SUPPORT on 8960 */
> +
> +       /* Sn_STATUS */
> +       [LAST_TEMP_0]  = REG_FIELD(S0_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_1]  = REG_FIELD(S1_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_2]  = REG_FIELD(S2_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_3]  = REG_FIELD(S3_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_4]  = REG_FIELD(S4_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_5]  = REG_FIELD(S5_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_6]  = REG_FIELD(S6_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_7]  = REG_FIELD(S7_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_8]  = REG_FIELD(S8_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_9]  = REG_FIELD(S9_STATUS_OFF,  0,  7),
> +       [LAST_TEMP_10] = REG_FIELD(S10_STATUS_OFF, 0,  7),
> +
> +       /* No VALID field on 8960 */
> +       /* TSENS_INT_STATUS bits: 1 == threshold violated */
> +       [MIN_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 0, 0),
> +       [LOWER_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 1, 1),
> +       [UPPER_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 2, 2),
> +       /* No CRITICAL field on 8960 */
> +       [MAX_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 3, 3),
> +
> +       /* TRDY: 1=ready, 0=in progress */
> +       [TRDY] = REG_FIELD(INT_STATUS_ADDR, 7, 7),
> +};
> +
>  static const struct tsens_ops ops_8960 = {
>         .init           = init_8960,
>         .calibrate      = calibrate_8960,
> @@ -282,4 +354,6 @@ static const struct tsens_ops ops_8960 = {
>  struct tsens_plat_data data_8960 = {
>         .num_sensors    = 11,
>         .ops            = &ops_8960,
> +       .feat           = &tsens_8960_feat,
> +       .fields         = tsens_8960_regfields,
>  };
> --
> 2.27.0
>
