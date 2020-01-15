Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2632D13B94F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 06:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAOF7d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 00:59:33 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42216 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOF73 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 00:59:29 -0500
Received: by mail-ua1-f66.google.com with SMTP id u17so5808080uap.9
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 21:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZcDlJEAOYiI5/opaWlacx6hWbE1fdXB+V/M4pJOPMc=;
        b=zSa2dpRrl8+iQbXBw9A8TC1verWOwJvEQxC/qYk2hCEWe8mNucn6K4UYbGqbj2gFzt
         UgFAsoCPK01qBZN5+0Fd7muGysK7LXkmZcgL2welcWciUOc6mJIun5PUteOcGPJqQrTr
         p5WoJ2HytVTzQXjI7tQIa7DHgVZWB2TkZjqG0YMunupdUpV6OFWSzJT/QjQSNZ/0DAxt
         F/9zVD5ZRiSt6edk3TXPp1PXvBUiIAoYiFgKVJJKQAVZDoZ2suSupcgwTDudBBarv04q
         T90jhY/8r/1ol343WfA3oEm7UeWcg5ld2VB7h40GHzou0GxSuOc1zF1nXu7r14WEOKi5
         Xqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZcDlJEAOYiI5/opaWlacx6hWbE1fdXB+V/M4pJOPMc=;
        b=gHR9mNEnYK0v0sL+wR5bePTsHxyW8go3KwgDF2jxxBRh/LzEJLT0rvqoxQz4adD7wk
         M6LeF4MPQOqGmqnFN6/itqjVWKKGViALVHTJkhVV5Uw2sGfkQmuuuOpACFYDBYaRAEwl
         JfRtcikcrmtNBwTBuvCZy+B4UqrizDIrppTaqpbEFKH9NHdRizxeua0AYMbSh7+nzx57
         DzK7zVQFSQ3WcySnEtq/5oqx8PrBcQsCXoMze0cnKO3wXqaBsedkPFWlKfVatEISuJYA
         NFV10514jTTCA1zjiVCU2Ct1eiRodzpS76G1rrKWfCy8cN+JBr9K/JNEPZIzjiqPve2n
         DOaQ==
X-Gm-Message-State: APjAAAWikgddr4aGQS7wzXLzYHFVnipH49Jej9MFHyX6OfKhS24JxktY
        6QaDexubgchQ5c1khnmLp0HbsSvYIeqPXGW1ic0fgQ==
X-Google-Smtp-Source: APXvYqyOIjenI/978z/kS0ltOPfPgmya2cYrAirQMUXBzHTiFXFhrlDQNvKCTNcbmqjpEUJxYANlmAdPBb9axYlM4oo=
X-Received: by 2002:ab0:634c:: with SMTP id f12mr13371489uap.48.1579067967624;
 Tue, 14 Jan 2020 21:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20200114190607.29339-1-f.fainelli@gmail.com> <20200114190607.29339-3-f.fainelli@gmail.com>
In-Reply-To: <20200114190607.29339-3-f.fainelli@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 15 Jan 2020 11:29:16 +0530
Message-ID: <CAHLCerOsLA-9+M_2+hxU8BCieGiaeqPh10Ni-jEmW32n7-kqGw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] thermal: brcmstb_thermal: Prepare to support a
 different process
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 15, 2020 at 12:36 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> The driver is currently assuming that it is operating with a 28nm
> process chip, which has a specific formula to convert temperature to a
> code and vice versa. Update the code to support providing two key
> values: offset and multiplier to derive the correct formulas.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 47 +++++++++++++++-------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 680f1a070606..2d555e7b884a 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -102,18 +102,27 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
>         },
>  };
>
> +struct brcmstb_thermal_params {
> +       unsigned int offset;
> +       unsigned int mult;
> +};
> +
>  struct brcmstb_thermal_priv {
>         void __iomem *tmon_base;
>         struct device *dev;
>         struct thermal_zone_device *thermal;
> +       /* Process specific thermal parameters used for calculations */
> +       const struct brcmstb_thermal_params *temp_params;
>  };
>
>  /* Convert a HW code to a temperature reading (millidegree celsius) */
> -static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
> +static inline int avs_tmon_code_to_temp(struct brcmstb_thermal_priv *priv,
>                                         u32 code)
>  {
> -       return (AVS_TMON_TEMP_OFFSET -
> -               (int)((code & AVS_TMON_TEMP_MAX) * AVS_TMON_TEMP_SLOPE));
> +       int offset = priv->temp_params->offset;
> +       int mult = priv->temp_params->mult;
> +
> +       return (offset - (int)((code & AVS_TMON_TEMP_MASK) * mult));
>  }
>
>  /*
> @@ -122,21 +131,22 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
>   * @temp: temperature to convert
>   * @low: if true, round toward the low side
>   */
> -static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
> +static inline u32 avs_tmon_temp_to_code(struct brcmstb_thermal_priv *priv,
>                                         int temp, bool low)
>  {
> +       int offset = priv->temp_params->offset;
> +       int mult = priv->temp_params->mult;
> +
>         if (temp < AVS_TMON_TEMP_MIN)
>                 return AVS_TMON_TEMP_MAX;       /* Maximum code value */
>
> -       if (temp >= AVS_TMON_TEMP_OFFSET)
> +       if (temp >= offset)
>                 return 0;       /* Minimum code value */
>
>         if (low)
> -               return (u32)(DIV_ROUND_UP(AVS_TMON_TEMP_OFFSET - temp,
> -                                         AVS_TMON_TEMP_SLOPE));
> +               return (u32)(DIV_ROUND_UP(offset - temp, mult));
>         else
> -               return (u32)((AVS_TMON_TEMP_OFFSET - temp) /
> -                             AVS_TMON_TEMP_SLOPE);
> +               return (u32)((offset - temp) / mult);
>  }
>
>  static int brcmstb_get_temp(void *data, int *temp)
> @@ -154,7 +164,7 @@ static int brcmstb_get_temp(void *data, int *temp)
>
>         val = (val & AVS_TMON_STATUS_data_msk) >> AVS_TMON_STATUS_data_shift;
>
> -       t = avs_tmon_code_to_temp(priv->thermal, val);
> +       t = avs_tmon_code_to_temp(priv, val);
>         if (t < 0)
>                 *temp = 0;
>         else
> @@ -188,7 +198,7 @@ static int avs_tmon_get_trip_temp(struct brcmstb_thermal_priv *priv,
>         val &= trip->reg_msk;
>         val >>= trip->reg_shift;
>
> -       return avs_tmon_code_to_temp(priv->thermal, val);
> +       return avs_tmon_code_to_temp(priv, val);
>  }
>
>  static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
> @@ -201,7 +211,7 @@ static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
>         dev_dbg(priv->dev, "set temp %d to %d\n", type, temp);
>
>         /* round toward low temp for the low interrupt */
> -       val = avs_tmon_temp_to_code(priv->thermal, temp,
> +       val = avs_tmon_temp_to_code(priv, temp,
>                                     type == TMON_TRIP_TYPE_LOW);
>
>         val <<= trip->reg_shift;
> @@ -218,7 +228,7 @@ static int avs_tmon_get_intr_temp(struct brcmstb_thermal_priv *priv)
>         u32 val;
>
>         val = __raw_readl(priv->tmon_base + AVS_TMON_TEMP_INT_CODE);
> -       return avs_tmon_code_to_temp(priv->thermal, val);
> +       return avs_tmon_code_to_temp(priv, val);
>  }
>
>  static irqreturn_t brcmstb_tmon_irq_thread(int irq, void *data)
> @@ -282,8 +292,13 @@ static const struct thermal_zone_of_device_ops of_ops = {
>         .set_trips      = brcmstb_set_trips,
>  };
>
> +static const struct brcmstb_thermal_params brcmstb_28nm_params = {
> +       .offset = 410040,
> +       .mult   = 487,
> +};
> +
>  static const struct of_device_id brcmstb_thermal_id_table[] = {
> -       { .compatible = "brcm,avs-tmon" },
> +       { .compatible = "brcm,avs-tmon", .data = &brcmstb_28nm_params },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, brcmstb_thermal_id_table);
> @@ -299,6 +314,10 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
>         if (!priv)
>                 return -ENOMEM;
>
> +       priv->temp_params = of_device_get_match_data(&pdev->dev);
> +       if (!priv->temp_params)
> +               return -EINVAL;
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         priv->tmon_base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(priv->tmon_base))
> --
> 2.17.1
>
