Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE41D1C5512
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 14:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgEEMJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728660AbgEEMJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 08:09:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2DFC061A41
        for <linux-pm@vger.kernel.org>; Tue,  5 May 2020 05:09:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so1319255ljj.11
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2020 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOGlYy9uXhZHulZgQ0+V+pYl6SxONHQ8OrIB8ymK4ps=;
        b=cI/VTDMEfFxsqqItuPTCMGNcbAOVoJT4cTNyAcRAS5tXYSR8gP0oUHRHKeQfegAM5a
         NFEKi2ILQEBpj4zgt7b/vDfWdA8+Dm2YtgCP/Ll7kvSkXEqyMZt2nm/dyib4zSMuSQFe
         yQv3P6MGoz8pYRF8ahCMrpvuUbOM0fDIBXaMSVQs7u+Myb43MZ7xE9ATu2Br8nk6ERmr
         u9odYySxINwVlP+O1jkiieSth5OSr+FE/UIV4aSOWEXA5qG7mR30flSOFIwW3JBDG40M
         6/HKjaaD9H8pFjJrz/r6UBfliRXA1xzCABBoPelzSXQ3LnOEPLSZuQ6HWPJ97TCDL7FN
         lU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOGlYy9uXhZHulZgQ0+V+pYl6SxONHQ8OrIB8ymK4ps=;
        b=rtkMHPBKnpzvLTgvGckNjHBsbnQC7RbH7C0hjUeUs7oquPYIKozVX9mp+wR/kQvE9+
         p1x0Wyt/ZT01UGINCuiin4B48AzSHcf42iq46OV2qlhbEPnuLHyXtPQKCaUnawSzr8T4
         xrtmV2B9XHVkaGivTJgsZ+MLoGXxxeuoXjvWthlM+sQ/1nsIH7FN6Yj92xEnvyE8s1CU
         srsym1c9QWPX7LLdJqG10uu5h516dJ2VmWV5Kf6eCcymtQW54zCcHnatw2MWKaUCEMju
         VCinO/78b5zRvC+3wKQyudeYrR4EvQh1C8m+Aup8fGGLQrTv47xb37xFRyqBNZ/QL3iO
         OPcQ==
X-Gm-Message-State: AGi0PuYqO70ho2v1MOtuQrGQG1pJV1qoYJXG5OlIpklY8a4KuER4kRm/
        X+SekgVafh31wNNujhxjVBwFs7bNTPjiM3h6wBg4MA==
X-Google-Smtp-Source: APiQypIsUpqg7P4EsnRmnk5zJcX42n/zqB9YCqBESh486eP4/FfbjcFgbgxE9/xBz3IGZ47zlAuEug6fE2dqWyglFpU=
X-Received: by 2002:a2e:8658:: with SMTP id i24mr1529959ljj.287.1588680587262;
 Tue, 05 May 2020 05:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200505111204.963-1-manafm@codeaurora.org> <20200505111204.963-2-manafm@codeaurora.org>
In-Reply-To: <20200505111204.963-2-manafm@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 5 May 2020 17:39:14 +0530
Message-ID: <CAP245DV3-WXa1183tY=AzREAfzt3nXYugngG+zn6pEjXLc68cA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: thermal: tsens: Add 0C (zeorC) interrupt support
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Manaf,

Typo: fix zeorC in subject line.

Please rebase this patch[1] on top of my patch merging tsens-common.c
and tsens.c.

[1] https://lore.kernel.org/linux-arm-msm/e30e2ba6fa5c007983afd4d7d4e0311c0b57917a.1588183879.git.amit.kucheria@linaro.org/

On Tue, May 5, 2020 at 4:42 PM Manaf Meethalavalappu Pallikunhi
<manafm@codeaurora.org> wrote:
>
> TSENS IP v2.6+ adds 0C interrupt support. It triggers set
> interrupt when aggregated minimum temperature of all TSENS falls
> below 0C preset threshold and triggers reset interrupt when aggregate
> minimum temperature of all TSENS crosses above reset threshold.
> Add support for this interrupt in the driver.
>
> It adds another sensor to the of-thermal along with all individual
> TSENS. It enables to add any mitigation for 0C interrupt.
>
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 72 ++++++++++++++++++++++++++++-
>  drivers/thermal/qcom/tsens-v2.c     |  7 +++
>  drivers/thermal/qcom/tsens.c        | 51 ++++++++++++++++++--
>  drivers/thermal/qcom/tsens.h        | 11 +++++
>  4 files changed, 135 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 172545366636..44e7edeb9a90 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -198,7 +198,8 @@ static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
>                 index = LOW_INT_CLEAR_0 + hw_id;
>                 break;
>         case CRITICAL:
> -               /* No critical interrupts before v2 */
> +       case ZEROC:
> +               /* No critical and 0c interrupts before v2 */
>                 return;
>         }
>         regmap_field_write(priv->rf[index], enable ? 0 : 1);
> @@ -229,6 +230,9 @@ static void tsens_set_interrupt_v2(struct tsens_priv *priv, u32 hw_id,
>                 index_mask  = CRIT_INT_MASK_0 + hw_id;
>                 index_clear = CRIT_INT_CLEAR_0 + hw_id;
>                 break;
> +       case ZEROC:
> +               /* Nothing to handle for 0c interrupt */
> +               return;
>         }
>
>         if (enable) {
> @@ -360,6 +364,34 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
>         return 0;
>  }
>
> +/**
> + * tsens_0c_irq_thread - Threaded interrupt handler for 0c interrupt

Let's use zeroc instead of 0c in the function and variable names and
comments everywhere. Easier to grep and better consistency too.

> + * @irq: irq number
> + * @data: tsens controller private data
> + *
> + * Whenever interrupt triggers notify thermal framework using
> + * thermal_zone_device_update() to update cold temperature mitigation.

How is this mitigation updated?

> + *
> + * Return: IRQ_HANDLED
> + */
> +irqreturn_t tsens_0c_irq_thread(int irq, void *data)
> +{
> +       struct tsens_priv *priv = data;
> +       struct tsens_sensor *s = &priv->sensor[priv->num_sensors];
> +       int temp, ret;
> +
> +       ret = regmap_field_read(priv->rf[TSENS_0C_STATUS], &temp);
> +       if (ret)
> +               return ret;
> +
> +       dev_dbg(priv->dev, "[%u] %s: 0c interrupt is %s\n",
> +               s->hw_id, __func__, temp ? "triggered" : "cleared");

So triggered is printed for non-zero (including negative) values?

> +
> +       thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  /**
>   * tsens_critical_irq_thread() - Threaded handler for critical interrupts
>   * @irq: irq number
> @@ -566,6 +598,20 @@ void tsens_disable_irq(struct tsens_priv *priv)
>         regmap_field_write(priv->rf[INT_EN], 0);
>  }
>
> +int tsens_get_0c_int_status(const struct tsens_sensor *s, int *temp)
> +{
> +       struct tsens_priv *priv = s->priv;
> +       int last_temp = 0, ret;
> +
> +       ret = regmap_field_read(priv->rf[TSENS_0C_STATUS], &last_temp);
> +       if (ret)
> +               return ret;
> +
> +       *temp = last_temp;
> +
> +       return 0;
> +}
> +
>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  {
>         struct tsens_priv *priv = s->priv;
> @@ -833,6 +879,30 @@ int __init init_common(struct tsens_priv *priv)
>                 regmap_field_write(priv->rf[CC_MON_MASK], 1);
>         }
>
> +       if (tsens_version(priv) > VER_1_X &&  ver_minor > 5) {
> +               /* 0C interrupt is present only on v2.6+ */
> +               priv->rf[TSENS_0C_INT_EN] = devm_regmap_field_alloc(dev,
> +                                               priv->srot_map,
> +                                               priv->fields[TSENS_0C_INT_EN]);
> +               if (IS_ERR(priv->rf[TSENS_0C_INT_EN])) {
> +                       ret = PTR_ERR(priv->rf[TSENS_0C_INT_EN]);
> +                       goto err_put_device;
> +               }
> +
> +               /* Check whether 0C interrupt is enabled or not */
> +               regmap_field_read(priv->rf[TSENS_0C_INT_EN], &enabled);
> +               if (enabled) {
> +                       priv->feat->zero_c_int = 1;

This should be done at the beginning of the block where you check our
version is > 2.6 since the flag only says whether the feature is
present.

> +                       priv->rf[TSENS_0C_STATUS] = devm_regmap_field_alloc(dev,
> +                                               priv->tm_map,
> +                                               priv->fields[TSENS_0C_STATUS]);
> +                       if (IS_ERR(priv->rf[TSENS_0C_STATUS])) {
> +                               ret = PTR_ERR(priv->rf[TSENS_0C_STATUS]);
> +                               goto err_put_device;
> +                       }
> +               }
> +       }
> +
>         spin_lock_init(&priv->ul_lock);
>         tsens_enable_irq(priv);
>         tsens_debug_init(op);
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index b293ed32174b..ce80d82c7255 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -11,6 +11,7 @@
>  /* ----- SROT ------ */
>  #define SROT_HW_VER_OFF        0x0000
>  #define SROT_CTRL_OFF          0x0004
> +#define SROT_OC_CTRL_OFF       0x0018
>
>  /* ----- TM ------ */
>  #define TM_INT_EN_OFF                  0x0004
> @@ -23,6 +24,7 @@
>  #define TM_Sn_UPPER_LOWER_THRESHOLD_OFF 0x0020
>  #define TM_Sn_CRITICAL_THRESHOLD_OFF   0x0060
>  #define TM_Sn_STATUS_OFF               0x00a0
> +#define TM_0C_INT_STATUS_OFF           0x00e0
>  #define TM_TRDY_OFF                    0x00e4
>  #define TM_WDOG_LOG_OFF                0x013c
>
> @@ -45,6 +47,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>         /* CTRL_OFF */
>         [TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>         [TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
> +       [TSENS_0C_INT_EN] = REG_FIELD(SROT_OC_CTRL_OFF, 0,  0),
>
>         /* ----- TM ------ */
>         /* INTERRUPT ENABLE */
> @@ -86,6 +89,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>         REG_FIELD_FOR_EACH_SENSOR16(CRITICAL_STATUS, TM_Sn_STATUS_OFF, 19,  19),
>         REG_FIELD_FOR_EACH_SENSOR16(MAX_STATUS,      TM_Sn_STATUS_OFF, 20,  20),
>
> +       /* 0C INETRRUPT STATUS */

Typo: Interrupt

> +       [TSENS_0C_STATUS] = REG_FIELD(TM_0C_INT_STATUS_OFF, 0, 0),
> +
>         /* TRDY: 1=ready, 0=in progress */
>         [TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
> @@ -93,6 +99,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  static const struct tsens_ops ops_generic_v2 = {
>         .init           = init_common,
>         .get_temp       = get_temp_tsens_valid,
> +       .get_0c_status  = tsens_get_0c_int_status,
>  };
>
>  struct tsens_plat_data data_tsens_v2 = {
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 2f77d235cf73..e60870c53383 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -14,6 +14,17 @@
>  #include <linux/thermal.h>
>  #include "tsens.h"
>
> +static int tsens_0c_get_temp(void *data, int *temp)
> +{
> +       struct tsens_sensor *s = data;
> +       struct tsens_priv *priv = s->priv;
> +
> +       if (priv->ops->get_0c_status)
> +               return priv->ops->get_0c_status(s, temp);
> +
> +       return -ENOTSUPP;
> +}
> +
>  static int tsens_get_temp(void *data, int *temp)
>  {
>         struct tsens_sensor *s = data;
> @@ -85,6 +96,10 @@ static const struct thermal_zone_of_device_ops tsens_of_ops = {
>         .set_trips = tsens_set_trips,
>  };
>
> +static const struct thermal_zone_of_device_ops tsens_0c_of_ops = {
> +       .get_temp = tsens_0c_get_temp,
> +};
> +
>  static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>                               irq_handler_t thread_fn)
>  {
> @@ -142,6 +157,21 @@ static int tsens_register(struct tsens_priv *priv)
>                 ret = tsens_register_irq(priv, "critical",
>                                          tsens_critical_irq_thread);
>
> +       if (priv->feat->zero_c_int) {
> +               priv->sensor[priv->num_sensors].priv = priv;
> +               tzd = devm_thermal_zone_of_sensor_register(priv->dev,
> +                                       priv->sensor[priv->num_sensors].hw_id,
> +                                       &priv->sensor[priv->num_sensors],
> +                                       &tsens_0c_of_ops);
> +               if (IS_ERR(tzd)) {
> +                       ret = 0;
> +                       return ret;
> +               }
> +
> +               priv->sensor[priv->num_sensors].tzd = tzd;

Why can't this happen in the previous loop, but increase the loop to
<= num_sensors? It is duplicated code.

> +               ret = tsens_register_irq(priv, "zeroc", tsens_0c_irq_thread);
> +       }
> +
>         return ret;
>  }
>
> @@ -178,11 +208,22 @@ static int tsens_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       priv = devm_kzalloc(dev,
> -                            struct_size(priv, sensor, num_sensors),
> -                            GFP_KERNEL);
> -       if (!priv)
> -               return -ENOMEM;
> +       /* Check for 0c interrupt is enabled or not */
> +       if (platform_get_irq_byname(pdev, "zeroc") > 0) {
> +               priv = devm_kzalloc(dev,
> +                               struct_size(priv, sensor, num_sensors + 1),
> +                               GFP_KERNEL);

Instead of doing this, simply do the following,

if (platform_get_irq_byname(pdev, "zeroc") > 0) {
        num_sensors++;

The kzalloc will just work then, no?

> +               if (!priv)
> +                       return -ENOMEM;
> +               /* Use Max sensor index as 0c sensor hw_id */
> +               priv->sensor[num_sensors].hw_id = data->feat->max_sensors;
> +       } else {
> +               priv = devm_kzalloc(dev,
> +                               struct_size(priv, sensor, num_sensors),
> +                               GFP_KERNEL);
> +               if (!priv)
> +                       return -ENOMEM;
> +       }
>
>         priv->dev = dev;
>         priv->num_sensors = num_sensors;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 502acf0e6828..5b53a0352b4d 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -34,6 +34,7 @@ enum tsens_irq_type {
>         LOWER,
>         UPPER,
>         CRITICAL,
> +       ZEROC,
>  };
>
>  /**
> @@ -64,6 +65,7 @@ struct tsens_sensor {
>   * @suspend: Function to suspend the tsens device
>   * @resume: Function to resume the tsens device
>   * @get_trend: Function to get the thermal/temp trend
> + * @get_0c_status: Function to get the 0c interrupt status
>   */
>  struct tsens_ops {
>         /* mandatory callbacks */
> @@ -76,6 +78,7 @@ struct tsens_ops {
>         int (*suspend)(struct tsens_priv *priv);
>         int (*resume)(struct tsens_priv *priv);
>         int (*get_trend)(struct tsens_sensor *s, enum thermal_trend *trend);
> +       int (*get_0c_status)(const struct tsens_sensor *s, int *temp);
>  };
>
>  #define REG_FIELD_FOR_EACH_SENSOR11(_name, _offset, _startbit, _stopbit) \
> @@ -161,6 +164,8 @@ enum regfield_ids {
>         TSENS_SW_RST,
>         SENSOR_EN,
>         CODE_OR_TEMP,
> +       /* 0C CTRL OFFSET */
> +       TSENS_0C_INT_EN,
>
>         /* ----- TM ------ */
>         /* TRDY */
> @@ -485,6 +490,8 @@ enum regfield_ids {
>         MAX_STATUS_14,
>         MAX_STATUS_15,
>
> +       TSENS_0C_STATUS,        /* 0C INTERRUPT status */
> +
>         /* Keep last */
>         MAX_REGFIELDS
>  };
> @@ -497,6 +504,7 @@ enum regfield_ids {
>   * @srot_split: does the IP neatly splits the register space into SROT and TM,
>   *              with SROT only being available to secure boot firmware?
>   * @has_watchdog: does this IP support watchdog functionality?
> + * @zero_c_int: does this IP support 0C interrupt ?
>   * @max_sensors: maximum sensors supported by this version of the IP
>   */
>  struct tsens_features {
> @@ -505,6 +513,7 @@ struct tsens_features {
>         unsigned int adc:1;
>         unsigned int srot_split:1;
>         unsigned int has_watchdog:1;
> +       unsigned int zero_c_int:1;

zeroc_interrupt

>         unsigned int max_sensors;
>  };
>
> @@ -580,11 +589,13 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
>  int init_common(struct tsens_priv *priv);
>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>  int get_temp_common(const struct tsens_sensor *s, int *temp);
> +int tsens_get_0c_int_status(const struct tsens_sensor *s, int *temp);
>  int tsens_enable_irq(struct tsens_priv *priv);
>  void tsens_disable_irq(struct tsens_priv *priv);
>  int tsens_set_trips(void *_sensor, int low, int high);
>  irqreturn_t tsens_irq_thread(int irq, void *data);
>  irqreturn_t tsens_critical_irq_thread(int irq, void *data);
> +irqreturn_t tsens_0c_irq_thread(int irq, void *data);
>
>  /* TSENS target */
>  extern struct tsens_plat_data data_8960;
> --
> 2.26.2
