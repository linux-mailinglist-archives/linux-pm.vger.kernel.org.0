Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22BB819F8
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfHEMs5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 08:48:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54295 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfHEMs5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 08:48:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so74591102wme.4
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I4WQBlYtUK3LpLALLS8/Bgf6TMUihDOjjA4mHf9gmXw=;
        b=s6b1QVHf93ASWMbEq+K8NrqNubU0VKZcHFb4e3uq3oEfx0rf+//MchlNQPKayhgCvW
         CUCBE6YkH92ZifWWrmW464gGWwOUVdrm0W2eT6xdLqZNfIYzONd2kTpbiOBcmqc2tB9t
         V17h1u1tU/TF5u+mTW3xwhB87mA6giFlr3gwUIuId9c7WGoqw54is7R02XNt40eTKWhh
         njOMkKU2kfjm6zt/L8R3Pi0g4lmHu4rKkXKvyKyDWGZzC8Aa6+VHuuwKrFXWOphk9qRO
         drwPAPxNLKqoP7G/WnTmYb8fAbRYc6ukNJq0jnnb+rvIaWUqY4BabyFS8jOldRo6+q8d
         Gxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I4WQBlYtUK3LpLALLS8/Bgf6TMUihDOjjA4mHf9gmXw=;
        b=Pu/Jb90meThrUTlY+YofPsV+2SKBWAQAZIB6M68hlTDnfsJ6d13K2s/IKs9+p5qwaw
         mwm1UqJEGh76YmVVwJ6P8i2811At9pRsY96o9cKGinotob6Q/kzrE6WjJYKUBE/U2lkK
         9RmAutY06Pq0ea9LX97qM3txdLuOvOX9+J9RwuASN9UnP4WDNGtDKvhLWMGTeglhpwZz
         BWlS6ZLScApxEc3Tl2SxGThbFFwRcPvmCR/pV2DO3s5J1AMHNvlGcbp4v9nByxI0ndsr
         x138hCpe7MJL67cAWOjw3rl45LqLS4jPBjLLoymnrPwXXqS7b61W2khy8qsoYDDECZiG
         oDlQ==
X-Gm-Message-State: APjAAAUPVrRAhgkRP8gLJ/nqn9Lgqms+n0L1d2j6lvz9iRpvPt54SGJw
        Lnd7TXgk0h8o4Kt+lvLWKLwFEARXpso=
X-Google-Smtp-Source: APXvYqwpd7vS0LRg5oITH/nfFBUXRzWmk9UAeFv1TcmYUsmKHnazMLOnFGlOmL6kk7iKgRhpY4SaJw==
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr19095355wme.146.1565009334383;
        Mon, 05 Aug 2019 05:48:54 -0700 (PDT)
Received: from [10.1.4.98] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i66sm151649804wmi.11.2019.08.05.05.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 05:48:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] thermal: amlogic: Add thermal driver to support
 G12 SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190731153529.30159-1-glaroque@baylibre.com>
 <20190731153529.30159-3-glaroque@baylibre.com>
 <CAFBinCDGSJABnS1L1ULueyeXZaV38qrxEA0a12gB-uyRC_TvPQ@mail.gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <14e14cd9-46bd-0d43-654c-6db64397f5c7@baylibre.com>
Date:   Mon, 5 Aug 2019 14:48:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDGSJABnS1L1ULueyeXZaV38qrxEA0a12gB-uyRC_TvPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

again thanks for your review.

On 8/3/19 8:24 PM, Martin Blumenstingl wrote:
> Hi Guillaume,
>
> (I still don't have any experience with the thermal framework, so
> below are some general comments)
>
> On Wed, Jul 31, 2019 at 5:36 PM Guillaume La Roque
> <glaroque@baylibre.com> wrote:
> I would add a patch description here:
> "
> Amlogic G12A and G12B SoCs integrate two thermal sensors with the same design.
> One is located close to the DDR (controller?) and the other one is
> located close to the PLLs (between the CPU and GPU).
>
> The calibration data for each of the thermal sensors instance is
> stored in a different location within the AO region.
>
> Implement reading the temperature from each thermal sensor.
>
> The IP block has more functionality, which may be added to this driver
> in the future:
> - reading up to 16 stored temperature samples

it's not working, you can verify it if you check the regmap define in the driver. in fact temp is only write in one register, it's confirmed by amlogic.

> - chip reset when the temperature exceeds a configurable threshold
> - up to four interrupts when the temperature has risen above a
> configurable threshold
> - up to four interrupts when the temperature has fallen below a
> configurable threshold
> "

agreed with you to add description  and optional without 16 register part.

>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  drivers/thermal/Kconfig           |  11 +
>>  drivers/thermal/Makefile          |   1 +
>>  drivers/thermal/amlogic_thermal.c | 332 ++++++++++++++++++++++++++++++
>>  3 files changed, 344 insertions(+)
>>  create mode 100644 drivers/thermal/amlogic_thermal.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 9966364a6deb..0f31bb4bc372 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -348,6 +348,17 @@ config MTK_THERMAL
>>           Enable this option if you want to have support for thermal management
>>           controller present in Mediatek SoCs
>>
>> +config AMLOGIC_THERMAL
> we typically use "MESON" in the Kconfig symbols:
> $ grep -c AMLOGIC .config
> 1
> $ grep -c MESON .config
> 33
>
> I also wonder if we should add G12 or G12A so we don't conflict with
> upcoming thermal sensors with a different design (assuming that this
> will be a thing).
> for example we already have three different USB2 PHY drivers
>
> [...]

i check with Neil and for new family it's better to use Amlogic instead of meson.

i don't add G12 because we already know it's same sensors for SM1 SoC family [0].

>> +/*
>> + * Calculate a temperature value from a temperature code.
>> + * The unit of the temperature is degree Celsius.
> is it really degree Celsius or millicelsius?
good point it's in millicelsius, i will fix all
>
>> + */
>> +static int code_to_temp(struct amlogic_thermal *pdata, int temp_code)
> PREFIX_thermal_code_to_millicelsius?
ok
> [...]
>> +static int amlogic_thermal_enable(struct amlogic_thermal *data)
>> +{
>> +       clk_prepare_enable(data->clk);
> no clock error handling?


i will fix

>
>> +       regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
>> +                          TSENSOR_CFG_REG1_ENABLE, TSENSOR_CFG_REG1_ENABLE);
>> +
>> +       return 0;
>> +}
>> +
>> +static int amlogic_thermal_disable(struct amlogic_thermal *data)
>> +{
>> +       regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
>> +                          TSENSOR_CFG_REG1_ENABLE, 0);
>> +       clk_disable(data->clk);
> either clk_disable_unprepare here or use only clk_enable in
> amlogic_thermal_enable and move prepare/unprepare somewhere else
i will align with enable and use clk_disable_unprepare
>
>> +
>> +       return 0;
>> +}
>> +
>> +static int amlogic_thermal_get_temp(void *data, int *temp)
>> +{
>> +       unsigned int tvalue;
>> +       struct amlogic_thermal *pdata = data;
>> +
>> +       if (!data)
>> +               return -EINVAL;
>> +
>> +       regmap_read(pdata->regmap, TSENSOR_STAT0, &tvalue);
>> +       *temp = code_to_temp(pdata,
>> +                            tvalue & TSENSOR_READ_TEMP_MASK);
> maybe simply move the implementation from code_to_temp here?

for the optional function it could be a problem if i move all in code_to_temp.

i prefer to have a function which are just do the conversion.

>
> [...]
>> +static const struct amlogic_thermal_data amlogic_thermal_g12_cpu_param = {
>> +       .u_efuse_off = 0x128,
>> +       .soc = &amlogic_thermal_g12,
> based on the variable name I expected this to be an enum of some sort.
> I would have expected it to be called calibration_parameters or
> similar to match the explanation in the driver description
> (no need to change it if you prefer it like this, I just want to make
> you aware of this)
ok to rename structure name
>
>> +       .regmap_config = &amlogic_thermal_regmap_config_g12,
> if regmap_config is always the same you may also pass it directly to
> devm_regmap_init_mmio

it's the same for now but we don't know if in the future  SoCs use same regmap.


>
>> +};
>> +
>> +static const struct amlogic_thermal_data amlogic_thermal_g12_ddr_param = {
>> +       .u_efuse_off = 0xF0,
> I believe we use lower-case hex everywhere else
>
> [...]
will fix
>> +static const struct of_device_id of_amlogic_thermal_match[] = {
>> +       {
>> +               .compatible = "amlogic,g12-ddr-thermal",
>> +               .data = &amlogic_thermal_g12_ddr_param,
>> +       },
>> +       {
>> +               .compatible = "amlogic,g12-cpu-thermal",
>> +               .data = &amlogic_thermal_g12_cpu_param,
>> +       },
>> +       { /* end */ }
> other drivers use "sentinel", but personally I have no preference here
>
> [...]
same for me i will do same as other drivers
>> +       pdata->tzd = devm_thermal_zone_of_sensor_register
>> +                               (&pdev->dev,
>> +                                0,
>> +                                pdata,
>> +                                &amlogic_thermal_ops);
> I believe the opening brace has to go onto the same line as the function name
>
> [...]
will fix
>> +       ret = amlogic_thermal_enable(pdata);
>> +       if (ret)
>> +               clk_unprepare(pdata->clk);
> clk_disable_unprepare, else you'll leave the clock prepared
will fix
>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int amlogic_thermal_suspend(struct device *dev)
>> +{
>> +       struct amlogic_thermal *data = dev_get_drvdata(dev);
>> +
>> +       return amlogic_thermal_disable(data);
>> +}
>> +
>> +static int amlogic_thermal_resume(struct device *dev)
>> +{
>> +       struct amlogic_thermal *data = dev_get_drvdata(dev);
>> +
>> +       return amlogic_thermal_enable(data);
>> +}
>> +#endif
> instead of using an #ifdef here annotate the suspend/resume functions
> with __maybe_unused, see [0]
will fix
>
>
> Martin
>
>
> [0] https://lore.kernel.org/patchwork/patch/732981/

[0] https://lore.kernel.org/linux-arm-kernel/20190701104705.18271-1-narmstrong@baylibre.com/


thanks

Guillaume

