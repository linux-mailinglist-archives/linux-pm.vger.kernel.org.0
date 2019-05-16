Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF1420E6E
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfEPSIR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 14:08:17 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38415 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEPSIR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 14:08:17 -0400
Received: by mail-it1-f193.google.com with SMTP id i63so7801466ita.3;
        Thu, 16 May 2019 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bRGNfoi3EoTJSvk4p56wrep4PuBD3CxbFt0eKUTVRzw=;
        b=CeCV8K2ybHSKA8hJGlcUizvgobC7q9c5lITXgx7zK4s8nl9YZ4OmkY6mDtmP1dW/CS
         cTHERUxoysE7aphwMiMDMSSet9GOf6WGtQDGtflmsRFRgSY0nk8bgaczup7eFIhReRPe
         acCBTZxLbHFVVYkZyBo8ye0sZYBJskmMkAQuob0Q0uFGZGtkNIjlUPMAHHLqkpTZZQb/
         QyOhp4S2F8ocyJJv0+DfXpoJg8j+ngxuitQ3VwDhZHmn92qF0T9ODeH17FcTHpZh7jol
         vSDkebBIizDb4guPMORvKiWEQ+Z0XTj8+YMr4s8CD9xGTkwkIjbWNyAS1o2j8EJzZNo+
         fbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=bRGNfoi3EoTJSvk4p56wrep4PuBD3CxbFt0eKUTVRzw=;
        b=NOAHgqItFZWDWHl7eYjS/beC2OblJBi2wHLz7qLbRQKWV7wfpAUFuFz3lfyDErDKGY
         nkoK5m3ZtA6fh5nf07g6w4tRug0jNRKLRVv05p2kBOYFxDdI5q98682a3gOpuzuWqaP/
         j11qt1IbkKf82UmovgOpVP3N+DsAVzs0gJmX9dWgWiTr9nXZR8t8kNDmYv4yrj6J/Cg6
         HNtr6/5khapOpb8Q4n+d2dwwpnihGFnP+6Qhsmd6GfaNINS9+lNu0hSy5aFSLObwAGiW
         LQ55CXolmCZkDetA93S1B4QZSoJMbE0lfMOZn6YLCttSVz5SZUdgZLE2hgQjX52uTBN+
         3XXQ==
X-Gm-Message-State: APjAAAXsg6Ds0PgjjCA55EjW+B1Udc50p/daZkKKcEY+rW7iGCTNWrwm
        Alkv0zwFlU8ozASZ4gdRJ3OnM7Ds9IgBNcwIbEc=
X-Google-Smtp-Source: APXvYqy4Q/t3MpMc3CX1RvTvOr9qa0nPdscFSA6XqayhsgeFsfD9dIMmCQGpwWO4Jl4bveRra/Wj5gpYhQ3VO9FMh8o=
X-Received: by 2002:a24:520f:: with SMTP id d15mr13737618itb.78.1558030095932;
 Thu, 16 May 2019 11:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512223955.6lhclj6jr2akmsdx@core.my.home>
In-Reply-To: <20190512223955.6lhclj6jr2akmsdx@core.my.home>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 17 May 2019 02:08:04 +0800
Message-ID: <CAEExFWt0o59qpFbtAef2hJgWoqNzEnetfgVtu8izK-FmR_LxUA@mail.gmail.com>
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

Hi Ond=C5=99ej,

On Mon, May 13, 2019 at 6:39 AM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> On Sun, May 12, 2019 at 04:26:13AM -0400, Yangtao Li wrote:
> > This patch adds the support for allwinner thermal sensor, within
> > allwinner SoC. It will register sensors for thermal framework
> > and use device tree to bind cooling device.
> >
> > Based on driver code found here:
> > https://megous.com/git/linux and https://github.com/Allwinner-Homlet/H6=
-BSP4.9-linux
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  MAINTAINERS                      |   7 +
> >  drivers/thermal/Kconfig          |  14 ++
> >  drivers/thermal/Makefile         |   1 +
> >  drivers/thermal/sun50i_thermal.c | 357 +++++++++++++++++++++++++++++++
> >  4 files changed, 379 insertions(+)
> >  create mode 100644 drivers/thermal/sun50i_thermal.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3c65228e93c5..8da56582e72a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -674,6 +674,13 @@ L:       linux-crypto@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/crypto/sunxi-ss/
> >
> > +ALLWINNER THERMAL DRIVER
> > +M:   Yangtao Li <tiny.windzz@gmail.com>
> > +L:   linux-pm@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
> > +F:   drivers/thermal/sun50i_thermal.c
> > +
> >  ALLWINNER VPU DRIVER
> >  M:   Maxime Ripard <maxime.ripard@bootlin.com>
> >  M:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 653aa27a25a4..2a8d1c98c6ca 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -252,6 +252,20 @@ config SPEAR_THERMAL
> >         Enable this to plug the SPEAr thermal sensor driver into the Li=
nux
> >         thermal framework.
> >
> > +config SUN50I_THERMAL
> > +     tristate "Allwinner sun50i thermal driver"
> > +     depends on ARCH_SUNXI || COMPILE_TEST
> > +     depends on HAS_IOMEM
> > +     depends on NVMEM
> > +     depends on OF
> > +     depends on RESET_CONTROLLER
> > +     help
> > +       Support for the sun50i thermal sensor driver into the Linux the=
rmal
> > +       framework.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called sun50i-thermal.
> > +
> >  config ROCKCHIP_THERMAL
> >       tristate "Rockchip thermal driver"
> >       depends on ARCH_ROCKCHIP || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 486d682be047..a09b30b90003 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -30,6 +30,7 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devfreq_co=
oling.o
> >  # platform thermal drivers
> >  obj-y                                +=3D broadcom/
> >  obj-$(CONFIG_SPEAR_THERMAL)  +=3D spear_thermal.o
> > +obj-$(CONFIG_SUN50I_THERMAL) +=3D sun50i_thermal.o
> >  obj-$(CONFIG_ROCKCHIP_THERMAL)       +=3D rockchip_thermal.o
> >  obj-$(CONFIG_RCAR_THERMAL)   +=3D rcar_thermal.o
> >  obj-$(CONFIG_RCAR_GEN3_THERMAL)      +=3D rcar_gen3_thermal.o
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
> > +
> > +                     continue;
> > +             }
> > +
> > +             calib_offest =3D tmdev->chip->temp_calib_base + (i / 2) *=
 0x4;
> > +
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
> > +
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
> > +
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
>
> Also this math is not all that clear:
>
>   period =3D (SUN50I_H6_THS_PC_TEMP_PERIOD + 1) * 4096 / clkin; ~10ms
>
> SUN50I_H6_THS_PC_TEMP_PERIOD is a macro with an argument. So how does
> this work?
>
> Also, related to this, I've noticed that you removed the interrupt
> processing from the original driver. Without that you have to make sure
> that OF contains non-zero polling-delay and polling-delay-passive.
>
> Nonzero values are necessary for enabling polling mode of the tz core,
> otherwise tz core will not read values periodically from your driver.
>
> You should documment it in the DT bindings, too. Or keep the interrupt
> handling for THS.
See v2.

Thx,
Yangtao
>
> regards,
>         o.
>
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
