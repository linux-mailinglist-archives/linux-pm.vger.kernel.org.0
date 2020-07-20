Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9E225C0F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgGTJvb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 05:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGTJva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 05:51:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02AC061794
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2020 02:51:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h8so1141350lfp.9
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2020 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2cHmL53yXV3ZmDO+QNpbRpa2tPzqP3N0L07wSX88PE=;
        b=IfiNG7l2QCoIIBYQIiXB7cuqj8YvM0E+GxhUNlmAueCh58ojnh7mImhk1rIhrSx/9L
         kIU6UIBqX2uwsA/8RIOE5UI4WU16+n/gIgJghQ7CdfUKclw1MZJjjQgChKmeyxtZInEP
         vgBymwFw35a/YsXJNeVdbECx0JgCplmxQGoC4UTP7y74HGynJiykkShfHmYPIIdfGncg
         ikvKl2XCCxwSWjAYIkxsLbrhgaXaT90iQgnAcv2IOpIJs5+nQslQucxTSY2t2puoFexu
         HaIlQ/s5klVrvRTG6tpRTqWLjY1Ah4/EGHGeKrYSG2raKu8qjw1+fD5OeGyTI3TgYDZ3
         4DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2cHmL53yXV3ZmDO+QNpbRpa2tPzqP3N0L07wSX88PE=;
        b=BmaVA1VGi9W/DHpWSqioQkEoI+ecgtS0DsBse5l9oW6CxJTFpm9J7Jfwe6DBU6ecrQ
         raacDtJ89QbBwf95TjIWBSSw0dTqGhMUCIQLHm+SdZud7tNPDJeqbZuUOmwW2NceVYJT
         /n1rGoQlwFgfYqM8Hat0rKSuI2PGHhYl0k+yOhGk7UFkMO6rIDHqSKBHJ5jwo0m0OQQT
         EdpTW7811q255V93TJncKlc+dm3PVZbjaTcFOnJ11uotFltmUOuQWl8i8Q+gJTh32LUS
         BxU4X4mW0t5M7aMmdCxYtSjCDSuJz6meL6jQNP6AbEygoYlU1iaP3WIyeCa53mByXzvP
         UIgQ==
X-Gm-Message-State: AOAM532S/vlXrPO23VuQ9y10LwMtvGhE15Qb1wAWsP+oxiopD+xuZZo6
        0Dp1NcutXshHHVqkH7aUBhiqyElBBi3L0Oy+Q5/C6A==
X-Google-Smtp-Source: ABdhPJwMANyempeOoFA5FVmODj562f30Aq1s3f9pjZIi85fwDrxRdamhIw0HSrczuKWlAuEiPZ9koIUI1q6yWIrtoHU=
X-Received: by 2002:a19:8505:: with SMTP id h5mr4819390lfd.7.1595238688501;
 Mon, 20 Jul 2020 02:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200716022817.30439-1-ansuelsmth@gmail.com> <20200716022817.30439-8-ansuelsmth@gmail.com>
In-Reply-To: <20200716022817.30439-8-ansuelsmth@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 20 Jul 2020 15:21:17 +0530
Message-ID: <CAP245DXjO1M+kDSudiONM9WY9t2hzDDCj-osmoSNpca1sihzYQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drivers: thermal: tsens: add set_trip support for 8960
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ansuel,

On Thu, Jul 16, 2020 at 7:58 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Add custom set_trip function for 8960 needed to set trip point to the
> tsens driver for 8960 driver.

Please describe why it needs a custom function please.

>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/thermal/qcom/tsens-8960.c | 78 +++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 20d0bfb10f1f..4ad65ab3fd18 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -93,6 +93,15 @@
>                                                 TSENS_8064_SENSOR9_EN | \
>                                                 TSENS_8064_SENSOR10_EN)
>
> +/* Trips: from very hot to very cold */
> +enum tsens_trip_type {
> +       TSENS_TRIP_STAGE3 = 0,
> +       TSENS_TRIP_STAGE2,
> +       TSENS_TRIP_STAGE1,
> +       TSENS_TRIP_STAGE0,
> +       TSENS_TRIP_NUM,
> +};
> +
>  u32 tsens_8960_slope[] = {
>                         1176, 1176, 1154, 1176,
>                         1111, 1132, 1132, 1199,
> @@ -110,6 +119,16 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
>         return adc_code * slope + offset;
>  }
>
> +static int mdegC_to_code(int degC, const struct tsens_sensor *s)
> +{
> +       int slope, offset;
> +
> +       slope = thermal_zone_get_slope(s->tzd);
> +       offset = CAL_MDEGC - slope * s->offset;
> +
> +       return degC / slope - offset;
> +}
> +
>  static void notify_uspace_tsens_fn(struct work_struct *work)
>  {
>         struct tsens_sensor *s = container_of(work, struct tsens_sensor,
> @@ -448,6 +467,64 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
>         return -ETIMEDOUT;
>  }
>
> +static int set_trip_temp_ipq8064(void *data, int trip, int temp)
> +{
> +       unsigned int reg_th, reg_cntl;
> +       int ret, code, code_chk, hi_code, lo_code;
> +       const struct tsens_sensor *s = data;
> +       struct tsens_priv *priv = s->priv;
> +
> +       code = mdegC_to_code(temp, s);
> +       code_chk = code;
> +
> +       if (code < THRESHOLD_MIN_CODE || code > THRESHOLD_MAX_CODE)
> +               return -EINVAL;
> +
> +       ret = regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064, &reg_cntl);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_read(priv->tm_map, THRESHOLD_ADDR, &reg_th);
> +       if (ret)
> +               return ret;
> +
> +       hi_code = (reg_th & THRESHOLD_UPPER_LIMIT_MASK)
> +                       >> THRESHOLD_UPPER_LIMIT_SHIFT;
> +       lo_code = (reg_th & THRESHOLD_LOWER_LIMIT_MASK)
> +                       >> THRESHOLD_LOWER_LIMIT_SHIFT;
> +
> +       switch (trip) {
> +       case TSENS_TRIP_STAGE3:
> +               code <<= THRESHOLD_MAX_LIMIT_SHIFT;
> +               reg_th &= ~THRESHOLD_MAX_LIMIT_MASK;
> +               break;
> +       case TSENS_TRIP_STAGE2:
> +               if (code_chk <= lo_code)
> +                       return -EINVAL;
> +               code <<= THRESHOLD_UPPER_LIMIT_SHIFT;
> +               reg_th &= ~THRESHOLD_UPPER_LIMIT_MASK;
> +               break;
> +       case TSENS_TRIP_STAGE1:
> +               if (code_chk >= hi_code)
> +                       return -EINVAL;
> +               code <<= THRESHOLD_LOWER_LIMIT_SHIFT;
> +               reg_th &= ~THRESHOLD_LOWER_LIMIT_MASK;
> +               break;
> +       case TSENS_TRIP_STAGE0:
> +               code <<= THRESHOLD_MIN_LIMIT_SHIFT;
> +               reg_th &= ~THRESHOLD_MIN_LIMIT_MASK;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret = regmap_write(priv->tm_map, THRESHOLD_ADDR, reg_th | code);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
>  static const struct tsens_ops ops_8960 = {
>         .init           = init_8960,
>         .calibrate      = calibrate_8960,
> @@ -456,6 +533,7 @@ static const struct tsens_ops ops_8960 = {
>         .disable        = disable_8960,
>         .suspend        = suspend_8960,
>         .resume         = resume_8960,
> +       .set_trip_temp  = set_trip_temp_ipq8064,
>  };
>
>  struct tsens_plat_data data_8960 = {
> --
> 2.27.0
>
