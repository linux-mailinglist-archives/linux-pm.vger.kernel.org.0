Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDA807B0
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2019 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfHCSZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Aug 2019 14:25:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37138 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfHCSZH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Aug 2019 14:25:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so15951865otp.4;
        Sat, 03 Aug 2019 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0k/3wM0F9hkcUv0u81phO5YELB+EYkQGAmqQnT3ZS1k=;
        b=Us8rileHENKvobs3syDjHKWM5OF1Aa2j4WI5uHrhNeVEIKpIwlqcGoP8twTdGWWHwM
         QK97jEf4N2q2Of/FGYubC8EQk7OrF8QvyGLFk2racGYjrhDzWFO/dXOm5jGbIqWmOB19
         akTa01WYT0afd/NZNvn8RJtdfHHARVOjN6LfQXueYutAg8QJJ7SiYWYoeiQ1Nd+qWYAJ
         hpXytOcwgErCj0AkPPclEiO7AqUkZT3ewRBMN7wcnbstjk78dPXnUvkJtLyriL7KXPw5
         UucpQ4ob29f02VE0v2p/9hRmM7jsGykPm23zDZEFfKaWHpJ0i0OMTnf3aLJim7z3PS5C
         c8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0k/3wM0F9hkcUv0u81phO5YELB+EYkQGAmqQnT3ZS1k=;
        b=WlZD5K6dE6RYKm5oSbabOhUDlMeVKRF+MPAJH2f24fk4IXs+r4BiY/IkjgMiAO9tc9
         iLnCg0d9BxmCslxLihm/6k7V0MlFXrXC1u7+aD7qeAA6p0e4TTafG8lm0HlIXirK0FP/
         kw3YmfbrmThRY8Ch2go/5zGD4hb+A1jRxDO9hpsu2jKIMRvDDAPP0Zuaeps8++cYD9CW
         UP8J0RbPWyPnhV6tySydhgwblb2O8G7kg5oDQDgV0FwPOcDDjlSu2jB8Lf4k7i4KibMv
         5DRWIuUmhkIL5GphIAhYg/fVtgVjjoB+ShwEgQOIlltVNOU7hd5hX+9SRtPwVoMZSn7k
         jNsA==
X-Gm-Message-State: APjAAAU6opa70gqJegrZLXDZtmiHV/qQGdI8R77O1gUGnDL5sViy3Ial
        /Gz8mJ69Cem37aeKW1AvcxGZGIzgLrw0Pgtwv1U/osXU
X-Google-Smtp-Source: APXvYqxNo1Y+A6MJXdJl28CDf2nMoUwhIsGw4mZMR5DIF5eM9XrgOQQG12ZuWebxmTC0QKW3HNs4qMLC6KmZ58QzaZo=
X-Received: by 2002:a9d:226c:: with SMTP id o99mr24398880ota.42.1564856705915;
 Sat, 03 Aug 2019 11:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153529.30159-1-glaroque@baylibre.com> <20190731153529.30159-3-glaroque@baylibre.com>
In-Reply-To: <20190731153529.30159-3-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 3 Aug 2019 20:24:54 +0200
Message-ID: <CAFBinCDGSJABnS1L1ULueyeXZaV38qrxEA0a12gB-uyRC_TvPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] thermal: amlogic: Add thermal driver to support
 G12 SoCs
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guillaume,

(I still don't have any experience with the thermal framework, so
below are some general comments)

On Wed, Jul 31, 2019 at 5:36 PM Guillaume La Roque
<glaroque@baylibre.com> wrote:
I would add a patch description here:
"
Amlogic G12A and G12B SoCs integrate two thermal sensors with the same design.
One is located close to the DDR (controller?) and the other one is
located close to the PLLs (between the CPU and GPU).

The calibration data for each of the thermal sensors instance is
stored in a different location within the AO region.

Implement reading the temperature from each thermal sensor.

The IP block has more functionality, which may be added to this driver
in the future:
- reading up to 16 stored temperature samples
- chip reset when the temperature exceeds a configurable threshold
- up to four interrupts when the temperature has risen above a
configurable threshold
- up to four interrupts when the temperature has fallen below a
configurable threshold
"

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/thermal/Kconfig           |  11 +
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/amlogic_thermal.c | 332 ++++++++++++++++++++++++++++++
>  3 files changed, 344 insertions(+)
>  create mode 100644 drivers/thermal/amlogic_thermal.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 9966364a6deb..0f31bb4bc372 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -348,6 +348,17 @@ config MTK_THERMAL
>           Enable this option if you want to have support for thermal management
>           controller present in Mediatek SoCs
>
> +config AMLOGIC_THERMAL
we typically use "MESON" in the Kconfig symbols:
$ grep -c AMLOGIC .config
1
$ grep -c MESON .config
33

I also wonder if we should add G12 or G12A so we don't conflict with
upcoming thermal sensors with a different design (assuming that this
will be a thing).
for example we already have three different USB2 PHY drivers

[...]
> +/*
> + * Calculate a temperature value from a temperature code.
> + * The unit of the temperature is degree Celsius.
is it really degree Celsius or millicelsius?

> + */
> +static int code_to_temp(struct amlogic_thermal *pdata, int temp_code)
PREFIX_thermal_code_to_millicelsius?

[...]
> +static int amlogic_thermal_enable(struct amlogic_thermal *data)
> +{
> +       clk_prepare_enable(data->clk);
no clock error handling?

> +       regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
> +                          TSENSOR_CFG_REG1_ENABLE, TSENSOR_CFG_REG1_ENABLE);
> +
> +       return 0;
> +}
> +
> +static int amlogic_thermal_disable(struct amlogic_thermal *data)
> +{
> +       regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
> +                          TSENSOR_CFG_REG1_ENABLE, 0);
> +       clk_disable(data->clk);
either clk_disable_unprepare here or use only clk_enable in
amlogic_thermal_enable and move prepare/unprepare somewhere else

> +
> +       return 0;
> +}
> +
> +static int amlogic_thermal_get_temp(void *data, int *temp)
> +{
> +       unsigned int tvalue;
> +       struct amlogic_thermal *pdata = data;
> +
> +       if (!data)
> +               return -EINVAL;
> +
> +       regmap_read(pdata->regmap, TSENSOR_STAT0, &tvalue);
> +       *temp = code_to_temp(pdata,
> +                            tvalue & TSENSOR_READ_TEMP_MASK);
maybe simply move the implementation from code_to_temp here?

[...]
> +static const struct amlogic_thermal_data amlogic_thermal_g12_cpu_param = {
> +       .u_efuse_off = 0x128,
> +       .soc = &amlogic_thermal_g12,
based on the variable name I expected this to be an enum of some sort.
I would have expected it to be called calibration_parameters or
similar to match the explanation in the driver description
(no need to change it if you prefer it like this, I just want to make
you aware of this)

> +       .regmap_config = &amlogic_thermal_regmap_config_g12,
if regmap_config is always the same you may also pass it directly to
devm_regmap_init_mmio

> +};
> +
> +static const struct amlogic_thermal_data amlogic_thermal_g12_ddr_param = {
> +       .u_efuse_off = 0xF0,
I believe we use lower-case hex everywhere else

[...]
> +static const struct of_device_id of_amlogic_thermal_match[] = {
> +       {
> +               .compatible = "amlogic,g12-ddr-thermal",
> +               .data = &amlogic_thermal_g12_ddr_param,
> +       },
> +       {
> +               .compatible = "amlogic,g12-cpu-thermal",
> +               .data = &amlogic_thermal_g12_cpu_param,
> +       },
> +       { /* end */ }
other drivers use "sentinel", but personally I have no preference here

[...]
> +       pdata->tzd = devm_thermal_zone_of_sensor_register
> +                               (&pdev->dev,
> +                                0,
> +                                pdata,
> +                                &amlogic_thermal_ops);
I believe the opening brace has to go onto the same line as the function name

[...]
> +       ret = amlogic_thermal_enable(pdata);
> +       if (ret)
> +               clk_unprepare(pdata->clk);
clk_disable_unprepare, else you'll leave the clock prepared

> +#ifdef CONFIG_PM_SLEEP
> +static int amlogic_thermal_suspend(struct device *dev)
> +{
> +       struct amlogic_thermal *data = dev_get_drvdata(dev);
> +
> +       return amlogic_thermal_disable(data);
> +}
> +
> +static int amlogic_thermal_resume(struct device *dev)
> +{
> +       struct amlogic_thermal *data = dev_get_drvdata(dev);
> +
> +       return amlogic_thermal_enable(data);
> +}
> +#endif
instead of using an #ifdef here annotate the suspend/resume functions
with __maybe_unused, see [0]


Martin


[0] https://lore.kernel.org/patchwork/patch/732981/
