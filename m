Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA58455899
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 11:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbhKRKJy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 05:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245577AbhKRKIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 05:08:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37CC061766;
        Thu, 18 Nov 2021 02:05:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so7776653pjb.2;
        Thu, 18 Nov 2021 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JN45LXKgnkRv4Aa7Qb6cv28QBcgSafuVAnE6eeA98Lc=;
        b=QyiZ4tX1BKSq+QGWyIM5u56N3D8I0wogSbQ3SktkYyDIt4EHUFvmtJVATjoQ4NFi6k
         KuhVp3bXWYDMxygqyfNHzAILre2zt+9Ko6S1Zxnr3It8ADmhOAzyqFflCDe0pI3kRdT4
         qm5M2/WS4EpxWDLd/ex4zqGG9CZrwhHKKGcXmFKBEMTBGZIg6lr2DzSdHcswK/0Wp4H7
         o1o4fCfiyhlLFwBQt2uObCRAatsaEtxr5BnfscbAbYwpxHoygNJsQqo6yGgGj3+Ho5kj
         s7t1MX5dD/qcdUfU1Sz33775NDCxAWAPwI8LyG60kn0S4LRmxuTNeik/4AvN9oN3bv/1
         ek3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JN45LXKgnkRv4Aa7Qb6cv28QBcgSafuVAnE6eeA98Lc=;
        b=12AdDJ4nOQqCODABTf9KZh8TgJy0xQhAx7NHP3TyvQHMousrp3cYliBHv2gxkQPTKb
         8KJ4ImAGS3cFNRn8UXgmfiuZJqOdhYRQ2/PSH+CqOkteRtL+TLISuIXjSy90GmF1U/Ws
         xR60MWI5X9LlctoCiqf2U1U68Cx3EwAYE313i3sn8KsVE5PyMuKINBaPjXSqTw2LOTRT
         U8T0nqRh/4vs45uVQE+DzIEyUY2zsD7FmnyX0pdg+lOyt8MeKYjjnC2GMyUiPmePgw4M
         etYrym4t9u1FU5KOdcxosNa1Ium/3t5hlhG+Sq+vu448YKZOtl8Ia9FimGWdwX4g107R
         DC0w==
X-Gm-Message-State: AOAM531CaubemtzfjF4PTZyWj/GOkbbsHQdx7J9/xIf0//jXTkwUys3W
        KOdrYzdfYl2Mr/fVC6Vp65QNfswcdd5Jn+ghHm4=
X-Google-Smtp-Source: ABdhPJyOAIBclReK8e07Nkf+KtpU8XIycPfdNZKnG8J/+uf+9psVRy+wTWZUOd8HZos7UXeCkiBHdQ3JTWqoDtd6yC4=
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr8869815pjw.209.1637229925480;
 Thu, 18 Nov 2021 02:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20211117103426.81813-1-o.rempel@pengutronix.de> <20211117103719.GA4250@pengutronix.de>
In-Reply-To: <20211117103719.GA4250@pengutronix.de>
From:   Petr Benes <petrben@gmail.com>
Date:   Thu, 18 Nov 2021 11:05:14 +0100
Message-ID: <CAPwXO5a+EEWzUm=Kgda8Dr5xmUBhmHMr5dNnFrw2wrjfEmDs0Q@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: imx: implement runtime PM support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Works for me! Well done.

On Wed, 17 Nov 2021 at 11:37, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Petr, Michal,
>
> can you please test this patch.
>
> On Wed, Nov 17, 2021 at 11:34:26AM +0100, Oleksij Rempel wrote:
> > Starting with commit d92ed2c9d3ff ("thermal: imx: Use driver's local
> > data to decide whether to run a measurement") this driver stared using
> > irq_enabled flag to make decision to power on/off the thermal core. This
> > triggered a regression, where after reaching critical temperature, alarm
> > IRQ handler set irq_enabled to false,  disabled thermal core and was not
> > able read temperature and disable cooling sequence.
> >
> > In case the cooling device is "CPU/GPU freq", the system will run with
> > reduce performance until next reboot.
> >
> > To solve this issue, we need to move all parts implementing hand made
> > runtime power management and let it handle actual runtime PM framework.
> >
> > Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide whether to run a measurement")
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/thermal/imx_thermal.c | 145 +++++++++++++++++++++-------------
> >  1 file changed, 91 insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> > index 2c7473d86a59..16663373b682 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/thermal.h>
> >  #include <linux/nvmem-consumer.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #define REG_SET              0x4
> >  #define REG_CLR              0x8
> > @@ -194,6 +195,7 @@ static struct thermal_soc_data thermal_imx7d_data = {
> >  };
> >
> >  struct imx_thermal_data {
> > +     struct device *dev;
> >       struct cpufreq_policy *policy;
> >       struct thermal_zone_device *tz;
> >       struct thermal_cooling_device *cdev;
> > @@ -252,44 +254,15 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
> >       const struct thermal_soc_data *soc_data = data->socdata;
> >       struct regmap *map = data->tempmon;
> >       unsigned int n_meas;
> > -     bool wait, run_measurement;
> >       u32 val;
> > +     int ret;
> >
> > -     run_measurement = !data->irq_enabled;
> > -     if (!run_measurement) {
> > -             /* Check if a measurement is currently in progress */
> > -             regmap_read(map, soc_data->temp_data, &val);
> > -             wait = !(val & soc_data->temp_valid_mask);
> > -     } else {
> > -             /*
> > -              * Every time we measure the temperature, we will power on the
> > -              * temperature sensor, enable measurements, take a reading,
> > -              * disable measurements, power off the temperature sensor.
> > -              */
> > -             regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > -                         soc_data->power_down_mask);
> > -             regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > -                         soc_data->measure_temp_mask);
> > -
> > -             wait = true;
> > -     }
> > -
> > -     /*
> > -      * According to the temp sensor designers, it may require up to ~17us
> > -      * to complete a measurement.
> > -      */
> > -     if (wait)
> > -             usleep_range(20, 50);
> > +     ret = pm_runtime_resume_and_get(data->dev);
> > +     if (ret < 0)
> > +             return ret;
> >
> >       regmap_read(map, soc_data->temp_data, &val);
> >
> > -     if (run_measurement) {
> > -             regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > -                          soc_data->measure_temp_mask);
> > -             regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > -                          soc_data->power_down_mask);
> > -     }
> > -
> >       if ((val & soc_data->temp_valid_mask) == 0) {
> >               dev_dbg(&tz->device, "temp measurement never finished\n");
> >               return -EAGAIN;
> > @@ -328,6 +301,8 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
> >               enable_irq(data->irq);
> >       }
> >
> > +     pm_runtime_put(data->dev);
> > +
> >       return 0;
> >  }
> >
> > @@ -335,24 +310,16 @@ static int imx_change_mode(struct thermal_zone_device *tz,
> >                          enum thermal_device_mode mode)
> >  {
> >       struct imx_thermal_data *data = tz->devdata;
> > -     struct regmap *map = data->tempmon;
> > -     const struct thermal_soc_data *soc_data = data->socdata;
> >
> >       if (mode == THERMAL_DEVICE_ENABLED) {
> > -             regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > -                          soc_data->power_down_mask);
> > -             regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > -                          soc_data->measure_temp_mask);
> > +             pm_runtime_get(data->dev);
> >
> >               if (!data->irq_enabled) {
> >                       data->irq_enabled = true;
> >                       enable_irq(data->irq);
> >               }
> >       } else {
> > -             regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > -                          soc_data->measure_temp_mask);
> > -             regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > -                          soc_data->power_down_mask);
> > +             pm_runtime_put(data->dev);
> >
> >               if (data->irq_enabled) {
> >                       disable_irq(data->irq);
> > @@ -393,6 +360,11 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
> >                            int temp)
> >  {
> >       struct imx_thermal_data *data = tz->devdata;
> > +     int ret;
> > +
> > +     ret = pm_runtime_resume_and_get(data->dev);
> > +     if (ret < 0)
> > +             return ret;
> >
> >       /* do not allow changing critical threshold */
> >       if (trip == IMX_TRIP_CRITICAL)
> > @@ -406,6 +378,8 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
> >
> >       imx_set_alarm_temp(data, temp);
> >
> > +     pm_runtime_put(data->dev);
> > +
> >       return 0;
> >  }
> >
> > @@ -681,6 +655,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >       if (!data)
> >               return -ENOMEM;
> >
> > +     data->dev = &pdev->dev;
> > +
> >       map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tempmon");
> >       if (IS_ERR(map)) {
> >               ret = PTR_ERR(map);
> > @@ -800,6 +776,16 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >                    data->socdata->power_down_mask);
> >       regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> >                    data->socdata->measure_temp_mask);
> > +     /* After power up, we need a delay before first access can be done. */
> > +     usleep_range(20, 50);
> > +
> > +     /* the core was configured and enabled just before */
> > +     pm_runtime_set_active(&pdev->dev);
> > +     pm_runtime_enable(data->dev);
> > +
> > +     ret = pm_runtime_resume_and_get(data->dev);
> > +     if (ret < 0)
> > +             goto disable_runtime_pm;
> >
> >       data->irq_enabled = true;
> >       ret = thermal_zone_device_enable(data->tz);
> > @@ -814,10 +800,15 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >               goto thermal_zone_unregister;
> >       }
> >
> > +     pm_runtime_put(data->dev);
> > +
> >       return 0;
> >
> >  thermal_zone_unregister:
> >       thermal_zone_device_unregister(data->tz);
> > +disable_runtime_pm:
> > +     pm_runtime_put_noidle(data->dev);
> > +     pm_runtime_disable(data->dev);
> >  clk_disable:
> >       clk_disable_unprepare(data->thermal_clk);
> >  legacy_cleanup:
> > @@ -829,13 +820,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >  static int imx_thermal_remove(struct platform_device *pdev)
> >  {
> >       struct imx_thermal_data *data = platform_get_drvdata(pdev);
> > -     struct regmap *map = data->tempmon;
> >
> > -     /* Disable measurements */
> > -     regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> > -                  data->socdata->power_down_mask);
> > -     if (!IS_ERR(data->thermal_clk))
> > -             clk_disable_unprepare(data->thermal_clk);
> > +     pm_runtime_put_noidle(data->dev);
> > +     pm_runtime_disable(data->dev);
> >
> >       thermal_zone_device_unregister(data->tz);
> >       imx_thermal_unregister_legacy_cooling(data);
> > @@ -858,29 +845,79 @@ static int __maybe_unused imx_thermal_suspend(struct device *dev)
> >       ret = thermal_zone_device_disable(data->tz);
> >       if (ret)
> >               return ret;
> > +
> > +     return pm_runtime_force_suspend(data->dev);
> > +}
> > +
> > +static int __maybe_unused imx_thermal_resume(struct device *dev)
> > +{
> > +     struct imx_thermal_data *data = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret = pm_runtime_force_resume(data->dev);
> > +     if (ret)
> > +             return ret;
> > +     /* Enabled thermal sensor after resume */
> > +     return thermal_zone_device_enable(data->tz);
> > +}
> > +
> > +static int __maybe_unused imx_thermal_runtime_suspend(struct device *dev)
> > +{
> > +     struct imx_thermal_data *data = dev_get_drvdata(dev);
> > +     const struct thermal_soc_data *socdata = data->socdata;
> > +     struct regmap *map = data->tempmon;
> > +     int ret;
> > +
> > +     ret = regmap_write(map, socdata->sensor_ctrl + REG_CLR,
> > +                        socdata->measure_temp_mask);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = regmap_write(map, socdata->sensor_ctrl + REG_SET,
> > +                        socdata->power_down_mask);
> > +     if (ret)
> > +             return ret;
> > +
> >       clk_disable_unprepare(data->thermal_clk);
> >
> >       return 0;
> >  }
> >
> > -static int __maybe_unused imx_thermal_resume(struct device *dev)
> > +static int __maybe_unused imx_thermal_runtime_resume(struct device *dev)
> >  {
> >       struct imx_thermal_data *data = dev_get_drvdata(dev);
> > +     const struct thermal_soc_data *socdata = data->socdata;
> > +     struct regmap *map = data->tempmon;
> >       int ret;
> >
> >       ret = clk_prepare_enable(data->thermal_clk);
> >       if (ret)
> >               return ret;
> > -     /* Enabled thermal sensor after resume */
> > -     ret = thermal_zone_device_enable(data->tz);
> > +
> > +     ret = regmap_write(map, socdata->sensor_ctrl + REG_CLR,
> > +                        socdata->power_down_mask);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = regmap_write(map, socdata->sensor_ctrl + REG_SET,
> > +                        socdata->measure_temp_mask);
> >       if (ret)
> >               return ret;
> >
> > +     /*
> > +      * According to the temp sensor designers, it may require up to ~17us
> > +      * to complete a measurement.
> > +      */
> > +     usleep_range(20, 50);
> > +
> >       return 0;
> >  }
> >
> > -static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
> > -                      imx_thermal_suspend, imx_thermal_resume);
> > +static const struct dev_pm_ops imx_thermal_pm_ops = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(imx_thermal_suspend, imx_thermal_resume)
> > +     SET_RUNTIME_PM_OPS(imx_thermal_runtime_suspend,
> > +                        imx_thermal_runtime_resume, NULL)
> > +};
> >
> >  static struct platform_driver imx_thermal = {
> >       .driver = {
> > --
> > 2.30.2
> >
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
