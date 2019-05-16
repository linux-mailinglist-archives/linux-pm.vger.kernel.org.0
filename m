Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF720E68
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEPSHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 14:07:06 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38238 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEPSHG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 14:07:06 -0400
Received: by mail-it1-f194.google.com with SMTP id i63so7794811ita.3;
        Thu, 16 May 2019 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7Wo9xzmx/e1rfFyqrlLyhqwSx9QNN6cqUUgSBlZipdY=;
        b=lPr5OWc1MAuUYOaem0KSVMrE8kiPAHl5BA7wszQ/51yhVtO/+6Ehn/av3IErU317wK
         o8xAG9KAyyrP/67pypTINVNjopM/PR0g41jDn9Z3pbyU2//y07e1Jy+6mpthVFW1YXRi
         cW841EPX03yuWhsGj+w9/SowxC2TcEKLd8zN97WI858TQXZKrJyPYqLreZi0J2zwNyJJ
         0cfBJiLmYA2zVYh5KmJikRlUWxfmXRIadWfShN49yatx4dhnYj53/9ec/MNNoCkIBwxW
         LQIhEYQFZj8BXyNJ8NpqA8Y6ZZFJkMSpX7FXHGOHxRWMN1IscA3y1m2WiJk5KQYa12Dz
         nlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=7Wo9xzmx/e1rfFyqrlLyhqwSx9QNN6cqUUgSBlZipdY=;
        b=QFOpiIWKYmV8uO1Fvn/l5FNB2wc2T4tusDxgydFaiJ6UuJB8gPj60Bh9f/1EViUUxf
         pw4qd3DoYRVkoJseqsaaQuLeU03zSBaLeucPPWsm7PuBC6YuTh/ifQeMEAL7EHMLfRQa
         2FY0KwUbJMfnTAqhrVCiRzuPXwElN9iefzlGZIBY71U/SCFpL6jXYq5bilaLSOGhJcrH
         Znkn7dW5jxYTcz3i5MzCXey3DolB40O4jEgBQZmkqfEJC6vQj9UJHdiTtHaEDNw+jW/2
         VDBxzeC18UrXGBVJGd9jQtW9O9bt/cIaOCkhZw7st7/CJ+uMR3d7PtafZlT61rm3bMU+
         IeNQ==
X-Gm-Message-State: APjAAAWEw7CJzON+XwJDIoVOz0KyvBPe52F4G8a+4wt9hIZLr0aBYg2t
        nxe65Bu1WMmyKiBozykZCp/aFP+usRVLVJ/py9g=
X-Google-Smtp-Source: APXvYqzvan2yioCF/efQYVkzIt/FeMd9pbpNvXX42GmHzx8kcl9QGWU1tG86XUAwYdCJxa8kih0hLDvUtblhFHCsnR4=
X-Received: by 2002:a05:660c:105:: with SMTP id w5mr1018044itj.37.1558030025091;
 Thu, 16 May 2019 11:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512221612.ubmknvim4utnqpl4@core.my.home>
In-Reply-To: <20190512221612.ubmknvim4utnqpl4@core.my.home>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 17 May 2019 02:06:53 +0800
Message-ID: <CAEExFWv5A5mhpV7afQT=AaYx2ko5QnfbM6HvfuTgT1Na=ssOcw@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
To:     Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>,
        olof@lixom.net, bjorn.andersson@linaro.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI Ond=C5=99ej,

On Mon, May 13, 2019 at 6:16 AM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> Hello Yangtao,
>
> On Sun, May 12, 2019 at 04:26:13AM -0400, Yangtao Li wrote:
> > diff --git a/drivers/thermal/sun50i_thermal.c b/drivers/thermal/sun50i_=
thermal.c
> > new file mode 100644
> > index 000000000000..3bdb3677b3d4
> > --- /dev/null
> > +++ b/drivers/thermal/sun50i_thermal.c
> > @@ -0,0 +1,357 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Thermal sensor driver for Allwinner SOC
> > + * Copyright (C) 2019 Yangtao Li
> > + *
> > + * Based on the work of Icenowy Zheng <icenowy@aosc.io>
> > + * Based on the work of Ondrej Jirman <megous@megous.com>
> > + * Based on the work of Josef Gajdusek <atx@atx.name>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +#include <linux/thermal.h>
> > +
> > +#define MAX_SENSOR_NUM       4
> > +
> > +#define FT_TEMP_MASK                         GENMASK(11, 0)
> > +#define TEMP_CALIB_MASK                              GENMASK(11, 0)
> > +#define TEMP_TO_REG                          672
> > +#define CALIBRATE_DEFAULT                    0x800
> > +
> > +#define SUN50I_THS_CTRL0                     0x00
> > +#define SUN50I_H6_THS_ENABLE                 0x04
> > +#define SUN50I_H6_THS_PC                     0x08
> > +#define SUN50I_H6_THS_MFC                    0x30
> > +#define SUN50I_H6_TEMP_CALIB                 0xa0
> > +#define SUN50I_H6_TEMP_DATA                  0xc0
> > +
> > +#define SUN50I_THS_CTRL0_T_ACQ(x)            ((GENMASK(15, 0) & (x)) <=
< 16)
> > +#define SUN50I_THS_FILTER_EN                 BIT(2)
> > +#define SUN50I_THS_FILTER_TYPE(x)            (GENMASK(1, 0) & (x))
> > +#define SUN50I_H6_THS_PC_TEMP_PERIOD(x)              ((GENMASK(19, 0) =
& (x)) << 12)
> > +
> > +/* millidegree celsius */
> > +#define SUN50I_H6_FT_DEVIATION                       7000
> > +
> > +struct tsens_device;
> > +
> > +struct tsensor {
> > +     struct tsens_device             *tmdev;
> > +     struct thermal_zone_device      *tzd;
> > +     int                             id;
> > +};
> > +
> > +struct sun50i_thermal_chip {
> > +     int     sensor_num;
> > +     int     offset;
> > +     int     scale;
> > +     int     ft_deviation;
> > +     int     temp_calib_base;
> > +     int     temp_data_base;
> > +     int     (*enable)(struct tsens_device *tmdev);
> > +     int     (*disable)(struct tsens_device *tmdev);
> > +};
> > +
> > +
> > +struct tsens_device {
> > +     const struct sun50i_thermal_chip        *chip;
> > +     struct device                           *dev;
> > +     struct regmap                           *regmap;
> > +     struct reset_control                    *reset;
> > +     struct clk                              *bus_clk;
> > +     struct tsensor                          sensor[MAX_SENSOR_NUM];
> > +};
> > +
> > +/* Temp Unit: millidegree Celsius */
> > +static int tsens_reg2temp(struct tsens_device *tmdev,
> > +                           int reg)
>
> Please name all functions so that they are more clearly identifiable
> in stack traces as belonging to this driver. For example:
>
>   sun8i_ths_reg2temp
>
> The same applies for all tsens_* functions below. tsens_* is too
> generic.

Done but no sun8i_ths_reg2temp.

ths_reg2tem() should be a generic func.
I think it should be suitable for all platforms=EF=BC=8C so no platform pre=
fix.

>
> > +{
> > +     return (reg + tmdev->chip->offset) * tmdev->chip->scale;
> > +}
> > +
> > +static int tsens_get_temp(void *data, int *temp)
> > +{
> > +     struct tsensor *s =3D data;
> > +     struct tsens_device *tmdev =3D s->tmdev;
> > +     int val;
> > +
> > +     regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > +                 0x4 * s->id, &val);
> > +
> > +     if (unlikely(val =3D=3D 0))
> > +             return -EBUSY;
> > +
> > +     *temp =3D tsens_reg2temp(tmdev, val);
> > +     if (tmdev->chip->ft_deviation)
> > +             *temp +=3D tmdev->chip->ft_deviation;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops tsens_ops =3D {
> > +     .get_temp =3D tsens_get_temp,
> > +};
> > +
> > +static const struct regmap_config config =3D {
> > +     .reg_bits =3D 32,
> > +     .val_bits =3D 32,
> > +     .reg_stride =3D 4,
> > +     .fast_io =3D true,
> > +};
> > +
> > +static int tsens_init(struct tsens_device *tmdev)
> > +{
> > +     struct device *dev =3D tmdev->dev;
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +     struct resource *mem;
> > +     void __iomem *base;
> > +
> > +     mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     base =3D devm_ioremap_resource(dev, mem);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     tmdev->regmap =3D devm_regmap_init_mmio_clk(dev, "bus",
> > +                                               base,
> > +                                               &config);
> > +     if (IS_ERR(tmdev->regmap))
> > +             return PTR_ERR(tmdev->regmap);
> > +
> > +     tmdev->reset =3D devm_reset_control_get(dev, "bus");
> > +     if (IS_ERR(tmdev->reset))
> > +             return PTR_ERR(tmdev->reset);
> > +
> > +     tmdev->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
> > +     if (IS_ERR(tmdev->bus_clk))
> > +             return PTR_ERR(tmdev->bus_clk);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Even if the external calibration data stored in sid is not accessib=
le,
> > + * the THS hardware can still work, although the data won't be so accu=
rate.
> > + * The default value of calibration register is 0x800 for every sensor=
,
> > + * and the calibration value is usually 0x7xx or 0x8xx, so they won't =
be
> > + * away from the default value for a lot.
> > + *
> > + * So here we do not return error if the calibartion data is
> > + * not available, except the probe needs deferring.
> > + */
> > +static int tsens_calibrate(struct tsens_device *tmdev)
> > +{
> > +     struct nvmem_cell *calcell;
> > +     struct device *dev =3D tmdev->dev;
> > +     u16 *caldata;
> > +     size_t callen;
> > +     int ft_temp;
> > +     int i =3D 0;
> > +
> > +     calcell =3D devm_nvmem_cell_get(dev, "calib");
> > +     if (IS_ERR(calcell)) {
> > +             if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +
> > +             goto out;
> > +     }
> > +
> > +     caldata =3D nvmem_cell_read(calcell, &callen);
> > +     if (IS_ERR(caldata))
> > +             goto out;
> > +
> > +     if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num)
> > +             goto out_free;
> > +
> > +     /*
> > +      * The calbration data on H6 is stored as temperature-value
> > +      * pair when being filled at factory test stage.
> > +      * The unit of stored FT temperature is 0.1 degreee celusis.
> > +      */
>
> Please describe the calibration data layout more clearly.
Done.
>
> > +     ft_temp =3D caldata[0] & FT_TEMP_MASK;
> > +
> > +     for (; i < tmdev->chip->sensor_num; i++) {
> > +             int reg =3D (int)caldata[i + 1];
> > +             int sensor_temp =3D tsens_reg2temp(tmdev, reg);
> > +             int delta, cdata, calib_offest;
> > +
> > +             /*
> > +              * To calculate the calibration value:
> > +              *
> > +              * X(in Celsius) =3D Ts - ft_temp
> > +              * delta =3D X * 10000 / TEMP_TO_REG
> > +              * cdata =3D CALIBRATE_DEFAULT - delta
> > +              *
> > +              * cdata: calibration value
> > +              */
> > +             delta =3D (sensor_temp - ft_temp * 100) * 10 / TEMP_TO_RE=
G;
> > +             cdata =3D CALIBRATE_DEFAULT - delta;
> > +             if (cdata & ~TEMP_CALIB_MASK) {
> > +                     dev_warn(dev, "sensor%d calibration value error",=
 i);
>
> Please use a more descriptive error message. What error is this?

See commnt in v2.

>
> > +                     continue;
> > +             }
> > +
> > +             calib_offest =3D tmdev->chip->temp_calib_base + (i / 2) *=
 0x4;
> > +             if (i % 2) {
> > +                     int val;
> > +
> > +                     regmap_read(tmdev->regmap, calib_offest, &val);
> > +                     val =3D (val & TEMP_CALIB_MASK) | (cdata << 16);
> > +                     regmap_write(tmdev->regmap, calib_offest, val);
> > +             } else
> > +                     regmap_write(tmdev->regmap, calib_offest, cdata);
> > +     }
> > +
> > +out_free:
> > +     kfree(caldata);
> > +out:
> > +     return 0;
> > +}
> > +
> > +static int tsens_register(struct tsens_device *tmdev)
> > +{
> > +     struct thermal_zone_device *tzd;
> > +     int i =3D 0;
> > +
> > +     for (; i < tmdev->chip->sensor_num; i++) {
> > +             tmdev->sensor[i].tmdev =3D tmdev;
> > +             tmdev->sensor[i].id =3D i;
> > +             tmdev->sensor[i].tzd =3D devm_thermal_zone_of_sensor_regi=
ster(
> > +                                     tmdev->dev, i, &tmdev->sensor[i],
> > +                                     &tsens_ops);
> > +             if (IS_ERR(tmdev->sensor[i].tzd))
> > +                     return PTR_ERR(tzd);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int tsens_probe(struct platform_device *pdev)
> > +{
> > +     struct tsens_device *tmdev;
> > +     struct device *dev =3D &pdev->dev;
> > +     int ret;
> > +
> > +     tmdev =3D devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > +     if (!tmdev)
> > +             return -ENOMEM;
> > +
> > +     tmdev->dev =3D dev;
> > +     tmdev->chip =3D of_device_get_match_data(&pdev->dev);
> > +     if (!tmdev->chip)
> > +             return -EINVAL;
> > +
> > +     ret =3D tsens_init(tmdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D tsens_register(tmdev);
> > +     if (ret)
> > +             return ret;
>
> Why split this out of probe into separate functions?
>
> > +     ret =3D tmdev->chip->enable(tmdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     platform_set_drvdata(pdev, tmdev);
> > +
> > +     return ret;
> > +}
> > +
> > +static int tsens_remove(struct platform_device *pdev)
> > +{
> > +     struct tsens_device *tmdev =3D platform_get_drvdata(pdev);
> > +
> > +     tmdev->chip->disable(tmdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun50i_thermal_enable(struct tsens_device *tmdev)
> > +{
> > +     int ret, val;
> > +
> > +     ret =3D reset_control_deassert(tmdev->reset);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D clk_prepare_enable(tmdev->bus_clk);
> > +     if (ret)
> > +             goto assert_reset;
> > +
> > +     ret =3D tsens_calibrate(tmdev);
> > +     if (ret)
> > +             return ret;
>
> If this fails (it may likely fail with EPROBE_DEFER) you are leaving rese=
t
> deasserted, and clock enabled.
>
> Overall, I think, reset/clock management and nvmem reading will be common
> to all the HW variants, so it doesn't make much sense splitting it out
> of probe into separate functions, and makes it more error prone.

Our long-term goal is to support all platforms.
Bacicallt there is a differencr between each generation.
So I feel it necessary to isolate these differences.

Maybe:
At some point, we can draw a part of the public part and platform
difference into different
files. something like qcom thermal driver.

Regards,
Yangtao
>
> thank you and regards,
>         o.
>
> > +     /*
> > +      * clkin =3D 24MHz
> > +      * T acquire =3D clkin / (SUN50I_THS_CTRL0_T_ACQ + 1)
> > +      *           =3D 20us
> > +      */
> > +     regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> > +                  SUN50I_THS_CTRL0_T_ACQ(479));
> > +     /* average over 4 samples */
> > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> > +                  SUN50I_THS_FILTER_EN |
> > +                  SUN50I_THS_FILTER_TYPE(1));
> > +     /* period =3D (SUN50I_H6_THS_PC_TEMP_PERIOD + 1) * 4096 / clkin; =
~10ms */
> > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> > +                  SUN50I_H6_THS_PC_TEMP_PERIOD(58));
> > +     /* enable sensor */
> > +     val =3D GENMASK(tmdev->chip->sensor_num - 1, 0);
> > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
> > +
> > +     return 0;
> > +
> > +assert_reset:
> > +     reset_control_assert(tmdev->reset);
> > +
> > +     return ret;
> > +}
> > +
> > +static int sun50i_thermal_disable(struct tsens_device *tmdev)
> > +{
> > +     clk_disable_unprepare(tmdev->bus_clk);
> > +     reset_control_assert(tmdev->reset);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct sun50i_thermal_chip sun50i_h6_ths =3D {
> > +     .sensor_num =3D 2,
> > +     .offset =3D -2794,
> > +     .scale =3D -67,
> > +     .ft_deviation =3D SUN50I_H6_FT_DEVIATION,
> > +     .temp_calib_base =3D SUN50I_H6_TEMP_CALIB,
> > +     .temp_data_base =3D SUN50I_H6_TEMP_DATA,
> > +     .enable =3D sun50i_thermal_enable,
> > +     .disable =3D sun50i_thermal_disable,
> > +};
> > +
> > +static const struct of_device_id of_tsens_match[] =3D {
> > +     { .compatible =3D "allwinner,sun50i-h6-ths", .data =3D &sun50i_h6=
_ths },
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, of_tsens_match);
> > +
> > +static struct platform_driver tsens_driver =3D {
> > +     .probe =3D tsens_probe,
> > +     .remove =3D tsens_remove,
> > +     .driver =3D {
> > +             .name =3D "sun50i-thermal",
> > +             .of_match_table =3D of_tsens_match,
> > +     },
> > +};
> > +module_platform_driver(tsens_driver);
> > +
> > +MODULE_DESCRIPTION("Thermal sensor driver for Allwinner SOC");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
