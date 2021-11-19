Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C8456C3A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 10:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhKSJVh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 04:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhKSJVh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Nov 2021 04:21:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C4C061574;
        Fri, 19 Nov 2021 01:18:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so10584575pja.1;
        Fri, 19 Nov 2021 01:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HWWw8CLJjhPbVMwFeeK+Fr/nFgTX8U8aS9pEiBtSWv0=;
        b=XbaEQbQmMKvTneicf4GBI38ZZuBxhlileCp2740K7GHCjM8kUlTMPOwe/FCnyg/KMp
         5n5XthF9PEQ+1X5xw1scvUA1S1mrGgueWMUOs64bQ4hAydFkAOm02sqefKF52ooyS/YO
         gNqskNdxBWzihgDzLa+GztqZJJUW04xoxN4mjGPYTbP+MFs8PP/IcS/LVDxr2YERIy+h
         uVB78bG2BZqd3/IGuV/1xPIsEwGZp77EKb8vN+GSGRWZ9mAxUfUJpXzUTmKcViCEdIX2
         ZWfxjXEWcHzC2+7F1+HGIcWVGD6zJj2iN1fX70ewvZq+P4wiU4oGA00I5Bfd7TVXK5ML
         xAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HWWw8CLJjhPbVMwFeeK+Fr/nFgTX8U8aS9pEiBtSWv0=;
        b=0NVAD009eiy8G2wFyfZqxIWWAhKaiipbubI9fq2KunuxSKs5Uud2ozlbejZ5jAbdD2
         OWtOdSfmPo7pOPujsl4pnbKDXmjm/igvGhADOS4IIPhibP0Pp9zSvV0BaP7cAx/VNMqQ
         pKclMNmBO0qE+fvLVyCInW/FF8eISfZmaHt9HVuW9JlVtIqAhs9dN8NTQ/zFU/eYO4UH
         31uRKdqy3vRbvvReTj4UkZqaXJPUW/SmwdAXeKqjes2qyzeBfQ0xpt7dFpn2+brSmKD5
         RPF/zmMKxD72gzQXVeozVs/bjci2npldQLypNr/jrvim2rf36xtGV6jSlo5Eenm53rWq
         Tclw==
X-Gm-Message-State: AOAM530Qro3y1Ze0s9cV/PxD1ZmCSvuw+oHbQ6liMtRqGPy1YdoMvbaO
        u/lz0OF+Q/k3ve8K7hZf0oXo7FtSZs4a2E4DWKA=
X-Google-Smtp-Source: ABdhPJxI2gslCblVjNq3NNaqsSZ4tyjro16DYqmo2qjG00O8+lTW5G8CFFfGSooG/NWPb0rTyWZ1qOZe0iY0A1vb1Ys=
X-Received: by 2002:a17:903:285:b0:142:21ba:2191 with SMTP id
 j5-20020a170903028500b0014221ba2191mr74769262plr.28.1637313515526; Fri, 19
 Nov 2021 01:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20211117103426.81813-1-o.rempel@pengutronix.de>
 <20211117103719.GA4250@pengutronix.de> <CAPwXO5a+EEWzUm=Kgda8Dr5xmUBhmHMr5dNnFrw2wrjfEmDs0Q@mail.gmail.com>
In-Reply-To: <CAPwXO5a+EEWzUm=Kgda8Dr5xmUBhmHMr5dNnFrw2wrjfEmDs0Q@mail.gmail.com>
From:   Petr Benes <petrben@gmail.com>
Date:   Fri, 19 Nov 2021 10:18:24 +0100
Message-ID: <CAPwXO5bHG7WmPLFFN429VGV7ra4V9ZvT5WfDMwdXOCvS3_x9jA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello everybody,

If this issue is about to close. Appending my tag.

Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide
whether to run a measurement")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Tested-by: Petr Bene=C5=A1 <petr.benes@ysoft.com>

Thank you for the fix.

Petr

On Thu, 18 Nov 2021 at 11:05, Petr Benes <petrben@gmail.com> wrote:
>
> Works for me! Well done.
>
> On Wed, 17 Nov 2021 at 11:37, Oleksij Rempel <o.rempel@pengutronix.de> wr=
ote:
> >
> > Petr, Michal,
> >
> > can you please test this patch.
> >
> > On Wed, Nov 17, 2021 at 11:34:26AM +0100, Oleksij Rempel wrote:
> > > Starting with commit d92ed2c9d3ff ("thermal: imx: Use driver's local
> > > data to decide whether to run a measurement") this driver stared usin=
g
> > > irq_enabled flag to make decision to power on/off the thermal core. T=
his
> > > triggered a regression, where after reaching critical temperature, al=
arm
> > > IRQ handler set irq_enabled to false,  disabled thermal core and was =
not
> > > able read temperature and disable cooling sequence.
> > >
> > > In case the cooling device is "CPU/GPU freq", the system will run wit=
h
> > > reduce performance until next reboot.
> > >
> > > To solve this issue, we need to move all parts implementing hand made
> > > runtime power management and let it handle actual runtime PM framewor=
k.
> > >
> > > Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide=
 whether to run a measurement")
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  drivers/thermal/imx_thermal.c | 145 +++++++++++++++++++++-----------=
--
> > >  1 file changed, 91 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_ther=
mal.c
> > > index 2c7473d86a59..16663373b682 100644
> > > --- a/drivers/thermal/imx_thermal.c
> > > +++ b/drivers/thermal/imx_thermal.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/thermal.h>
> > >  #include <linux/nvmem-consumer.h>
> > > +#include <linux/pm_runtime.h>
> > >
> > >  #define REG_SET              0x4
> > >  #define REG_CLR              0x8
> > > @@ -194,6 +195,7 @@ static struct thermal_soc_data thermal_imx7d_data=
 =3D {
> > >  };
> > >
> > >  struct imx_thermal_data {
> > > +     struct device *dev;
> > >       struct cpufreq_policy *policy;
> > >       struct thermal_zone_device *tz;
> > >       struct thermal_cooling_device *cdev;
> > > @@ -252,44 +254,15 @@ static int imx_get_temp(struct thermal_zone_dev=
ice *tz, int *temp)
> > >       const struct thermal_soc_data *soc_data =3D data->socdata;
> > >       struct regmap *map =3D data->tempmon;
> > >       unsigned int n_meas;
> > > -     bool wait, run_measurement;
> > >       u32 val;
> > > +     int ret;
> > >
> > > -     run_measurement =3D !data->irq_enabled;
> > > -     if (!run_measurement) {
> > > -             /* Check if a measurement is currently in progress */
> > > -             regmap_read(map, soc_data->temp_data, &val);
> > > -             wait =3D !(val & soc_data->temp_valid_mask);
> > > -     } else {
> > > -             /*
> > > -              * Every time we measure the temperature, we will power=
 on the
> > > -              * temperature sensor, enable measurements, take a read=
ing,
> > > -              * disable measurements, power off the temperature sens=
or.
> > > -              */
> > > -             regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > > -                         soc_data->power_down_mask);
> > > -             regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > > -                         soc_data->measure_temp_mask);
> > > -
> > > -             wait =3D true;
> > > -     }
> > > -
> > > -     /*
> > > -      * According to the temp sensor designers, it may require up to=
 ~17us
> > > -      * to complete a measurement.
> > > -      */
> > > -     if (wait)
> > > -             usleep_range(20, 50);
> > > +     ret =3D pm_runtime_resume_and_get(data->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       regmap_read(map, soc_data->temp_data, &val);
> > >
> > > -     if (run_measurement) {
> > > -             regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > > -                          soc_data->measure_temp_mask);
> > > -             regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > > -                          soc_data->power_down_mask);
> > > -     }
> > > -
> > >       if ((val & soc_data->temp_valid_mask) =3D=3D 0) {
> > >               dev_dbg(&tz->device, "temp measurement never finished\n=
");
> > >               return -EAGAIN;
> > > @@ -328,6 +301,8 @@ static int imx_get_temp(struct thermal_zone_devic=
e *tz, int *temp)
> > >               enable_irq(data->irq);
> > >       }
> > >
> > > +     pm_runtime_put(data->dev);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -335,24 +310,16 @@ static int imx_change_mode(struct thermal_zone_=
device *tz,
> > >                          enum thermal_device_mode mode)
> > >  {
> > >       struct imx_thermal_data *data =3D tz->devdata;
> > > -     struct regmap *map =3D data->tempmon;
> > > -     const struct thermal_soc_data *soc_data =3D data->socdata;
> > >
> > >       if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
> > > -             regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > > -                          soc_data->power_down_mask);
> > > -             regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > > -                          soc_data->measure_temp_mask);
> > > +             pm_runtime_get(data->dev);
> > >
> > >               if (!data->irq_enabled) {
> > >                       data->irq_enabled =3D true;
> > >                       enable_irq(data->irq);
> > >               }
> > >       } else {
> > > -             regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > > -                          soc_data->measure_temp_mask);
> > > -             regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > > -                          soc_data->power_down_mask);
> > > +             pm_runtime_put(data->dev);
> > >
> > >               if (data->irq_enabled) {
> > >                       disable_irq(data->irq);
> > > @@ -393,6 +360,11 @@ static int imx_set_trip_temp(struct thermal_zone=
_device *tz, int trip,
> > >                            int temp)
> > >  {
> > >       struct imx_thermal_data *data =3D tz->devdata;
> > > +     int ret;
> > > +
> > > +     ret =3D pm_runtime_resume_and_get(data->dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       /* do not allow changing critical threshold */
> > >       if (trip =3D=3D IMX_TRIP_CRITICAL)
> > > @@ -406,6 +378,8 @@ static int imx_set_trip_temp(struct thermal_zone_=
device *tz, int trip,
> > >
> > >       imx_set_alarm_temp(data, temp);
> > >
> > > +     pm_runtime_put(data->dev);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -681,6 +655,8 @@ static int imx_thermal_probe(struct platform_devi=
ce *pdev)
> > >       if (!data)
> > >               return -ENOMEM;
> > >
> > > +     data->dev =3D &pdev->dev;
> > > +
> > >       map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl=
,tempmon");
> > >       if (IS_ERR(map)) {
> > >               ret =3D PTR_ERR(map);
> > > @@ -800,6 +776,16 @@ static int imx_thermal_probe(struct platform_dev=
ice *pdev)
> > >                    data->socdata->power_down_mask);
> > >       regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> > >                    data->socdata->measure_temp_mask);
> > > +     /* After power up, we need a delay before first access can be d=
one. */
> > > +     usleep_range(20, 50);
> > > +
> > > +     /* the core was configured and enabled just before */
> > > +     pm_runtime_set_active(&pdev->dev);
> > > +     pm_runtime_enable(data->dev);
> > > +
> > > +     ret =3D pm_runtime_resume_and_get(data->dev);
> > > +     if (ret < 0)
> > > +             goto disable_runtime_pm;
> > >
> > >       data->irq_enabled =3D true;
> > >       ret =3D thermal_zone_device_enable(data->tz);
> > > @@ -814,10 +800,15 @@ static int imx_thermal_probe(struct platform_de=
vice *pdev)
> > >               goto thermal_zone_unregister;
> > >       }
> > >
> > > +     pm_runtime_put(data->dev);
> > > +
> > >       return 0;
> > >
> > >  thermal_zone_unregister:
> > >       thermal_zone_device_unregister(data->tz);
> > > +disable_runtime_pm:
> > > +     pm_runtime_put_noidle(data->dev);
> > > +     pm_runtime_disable(data->dev);
> > >  clk_disable:
> > >       clk_disable_unprepare(data->thermal_clk);
> > >  legacy_cleanup:
> > > @@ -829,13 +820,9 @@ static int imx_thermal_probe(struct platform_dev=
ice *pdev)
> > >  static int imx_thermal_remove(struct platform_device *pdev)
> > >  {
> > >       struct imx_thermal_data *data =3D platform_get_drvdata(pdev);
> > > -     struct regmap *map =3D data->tempmon;
> > >
> > > -     /* Disable measurements */
> > > -     regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> > > -                  data->socdata->power_down_mask);
> > > -     if (!IS_ERR(data->thermal_clk))
> > > -             clk_disable_unprepare(data->thermal_clk);
> > > +     pm_runtime_put_noidle(data->dev);
> > > +     pm_runtime_disable(data->dev);
> > >
> > >       thermal_zone_device_unregister(data->tz);
> > >       imx_thermal_unregister_legacy_cooling(data);
> > > @@ -858,29 +845,79 @@ static int __maybe_unused imx_thermal_suspend(s=
truct device *dev)
> > >       ret =3D thermal_zone_device_disable(data->tz);
> > >       if (ret)
> > >               return ret;
> > > +
> > > +     return pm_runtime_force_suspend(data->dev);
> > > +}
> > > +
> > > +static int __maybe_unused imx_thermal_resume(struct device *dev)
> > > +{
> > > +     struct imx_thermal_data *data =3D dev_get_drvdata(dev);
> > > +     int ret;
> > > +
> > > +     ret =3D pm_runtime_force_resume(data->dev);
> > > +     if (ret)
> > > +             return ret;
> > > +     /* Enabled thermal sensor after resume */
> > > +     return thermal_zone_device_enable(data->tz);
> > > +}
> > > +
> > > +static int __maybe_unused imx_thermal_runtime_suspend(struct device =
*dev)
> > > +{
> > > +     struct imx_thermal_data *data =3D dev_get_drvdata(dev);
> > > +     const struct thermal_soc_data *socdata =3D data->socdata;
> > > +     struct regmap *map =3D data->tempmon;
> > > +     int ret;
> > > +
> > > +     ret =3D regmap_write(map, socdata->sensor_ctrl + REG_CLR,
> > > +                        socdata->measure_temp_mask);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D regmap_write(map, socdata->sensor_ctrl + REG_SET,
> > > +                        socdata->power_down_mask);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > >       clk_disable_unprepare(data->thermal_clk);
> > >
> > >       return 0;
> > >  }
> > >
> > > -static int __maybe_unused imx_thermal_resume(struct device *dev)
> > > +static int __maybe_unused imx_thermal_runtime_resume(struct device *=
dev)
> > >  {
> > >       struct imx_thermal_data *data =3D dev_get_drvdata(dev);
> > > +     const struct thermal_soc_data *socdata =3D data->socdata;
> > > +     struct regmap *map =3D data->tempmon;
> > >       int ret;
> > >
> > >       ret =3D clk_prepare_enable(data->thermal_clk);
> > >       if (ret)
> > >               return ret;
> > > -     /* Enabled thermal sensor after resume */
> > > -     ret =3D thermal_zone_device_enable(data->tz);
> > > +
> > > +     ret =3D regmap_write(map, socdata->sensor_ctrl + REG_CLR,
> > > +                        socdata->power_down_mask);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D regmap_write(map, socdata->sensor_ctrl + REG_SET,
> > > +                        socdata->measure_temp_mask);
> > >       if (ret)
> > >               return ret;
> > >
> > > +     /*
> > > +      * According to the temp sensor designers, it may require up to=
 ~17us
> > > +      * to complete a measurement.
> > > +      */
> > > +     usleep_range(20, 50);
> > > +
> > >       return 0;
> > >  }
> > >
> > > -static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
> > > -                      imx_thermal_suspend, imx_thermal_resume);
> > > +static const struct dev_pm_ops imx_thermal_pm_ops =3D {
> > > +     SET_SYSTEM_SLEEP_PM_OPS(imx_thermal_suspend, imx_thermal_resume=
)
> > > +     SET_RUNTIME_PM_OPS(imx_thermal_runtime_suspend,
> > > +                        imx_thermal_runtime_resume, NULL)
> > > +};
> > >
> > >  static struct platform_driver imx_thermal =3D {
> > >       .driver =3D {
> > > --
> > > 2.30.2
> > >
> > >
> > >
> >
> > --
> > Pengutronix e.K.                           |                           =
  |
> > Steuerwalder Str. 21                       | http://www.pengutronix.de/=
  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0  =
  |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
