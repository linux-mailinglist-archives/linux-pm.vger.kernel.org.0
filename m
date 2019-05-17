Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1021E26
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEQTVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 15:21:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44697 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfEQTVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 15:21:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id z65so5931386oia.11;
        Fri, 17 May 2019 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usvjkESDKCkdcL7KjxK5+weEZxQOT9+0N++Iq5zdUfY=;
        b=S9wgwZAY+KfYsVSEgX6g5fIWJUzcYaV+VDSx3qecASV/3amWnu1K8ghLVj22td+vpS
         cIkxdCL+mxzliwVMOtw609kDQPIpxyljZs/P/+QYPLtwVCn3TJKB00b/fO0XKwwo0pZp
         3HYfjvxrr/uIORshlVrkRUsjVSDvxpbkIEO3IqglPHRUJ0Pl6snTbbDwHGjBiYFg7Y+D
         gVn2ziDXvSIi8sx9lAMbwtHrTlfUBbPjGvER0x97PaNZgoLgMwGK08Mye9pyGtuwDyhG
         FFfncqMqxhYhOLFsAwcpdkoqoa4WsZIshjCWNH1BWgMoanGh90ByX/qe6ta3GRFaz+L5
         2foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usvjkESDKCkdcL7KjxK5+weEZxQOT9+0N++Iq5zdUfY=;
        b=ikLIot8VHHJETy0BGed9mwpWj20ozQDvBK2OHPr1xaJGp58hXwjsPZi8DtFL9vy7LD
         wY9G4hvE41CUeAIaL3JMPvZcTHhN0WB829JLIRV2/F+N5aJ57SL9UDLfLWqaLSH07y1V
         3mad/TLIFm5hriVudkrFuey5Jd4TGCM/3CZvtxB86CNQJCfWESiqewT75xYuHYWBvmMw
         DdVXXBBpkPgr0tQ7/izLIp+kSe+95F74Mi6/nK4hJAw0CE9sGuCS+um26KDTIdflPD6w
         uZU6vGFpDQjPL80mI1ylTDUy6bz+wLl/2uvbW410HsRekXXCxeL+FRIiWgJws6IaLivi
         vL6A==
X-Gm-Message-State: APjAAAVf4N+gud/dWJ0DfQYInzQuL8Ut28I+WhrfM4q14uAXdv6cRxld
        p9TH5HnL/UAPbwuUsNhXoI3X/vEtf/kRGmWN0AM=
X-Google-Smtp-Source: APXvYqyhI6mpfCIEu0hREAEy64CQG4lKET9ZCLVdqqDF8nsijUoo625MEC2XZQW2+mMbkAM/X8eVXLmm8Vl4bRN0Cvc=
X-Received: by 2002:aca:240d:: with SMTP id n13mr14768947oic.145.1558120901888;
 Fri, 17 May 2019 12:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea>
In-Reply-To: <20190512133930.t5txssl7mou2gljt@flea>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 17 May 2019 12:21:57 -0700
Message-ID: <CA+E=qVe82xXPBXpgyLgt2ME6EjGMWWMVvD5eU-b3ntQk_okMdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, daniel.lezcano@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, bjorn.andersson@linaro.org,
        mchehab+samsung@kernel.org, paulmck@linux.ibm.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-pm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>, andy.gross@linaro.org,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        marc.w.gonzalez@free.fr, edubezval@gmail.com,
        enric.balletbo@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Jonathan.Cameron@huawei.com,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 12, 2019 at 6:39 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> Thanks a lot for working on this!
>
> On Sun, May 12, 2019 at 04:26:13AM -0400, Yangtao Li wrote:
> > This patch adds the support for allwinner thermal sensor, within
> > allwinner SoC. It will register sensors for thermal framework
> > and use device tree to bind cooling device.
> >
> > Based on driver code found here:
> > https://megous.com/git/linux and https://github.com/Allwinner-Homlet/H6-BSP4.9-linux
>
> I wouldn't place the URL in the commit log. The commit log stays
> forever in the linux history. Git repos and branches are going away
> over time.
>
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  MAINTAINERS                      |   7 +
> >  drivers/thermal/Kconfig          |  14 ++
> >  drivers/thermal/Makefile         |   1 +
> >  drivers/thermal/sun50i_thermal.c | 357 +++++++++++++++++++++++++++++++
>
> The long term goal is to support all the thermal sensors, not just the
> H6. Since that controller was introduced with the sun8i family, it
> makes more sense to use that prefix for the driver and the functions.
>
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
> >         Enable this to plug the SPEAr thermal sensor driver into the Linux
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
> > +       Support for the sun50i thermal sensor driver into the Linux thermal
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
> > @@ -30,6 +30,7 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
> >  # platform thermal drivers
> >  obj-y                                += broadcom/
> >  obj-$(CONFIG_SPEAR_THERMAL)  += spear_thermal.o
> > +obj-$(CONFIG_SUN50I_THERMAL) += sun50i_thermal.o
> >  obj-$(CONFIG_ROCKCHIP_THERMAL)       += rockchip_thermal.o
> >  obj-$(CONFIG_RCAR_THERMAL)   += rcar_thermal.o
> >  obj-$(CONFIG_RCAR_GEN3_THERMAL)      += rcar_gen3_thermal.o
> > diff --git a/drivers/thermal/sun50i_thermal.c b/drivers/thermal/sun50i_thermal.c
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
> > +#define SUN50I_THS_CTRL0_T_ACQ(x)            ((GENMASK(15, 0) & (x)) << 16)
> > +#define SUN50I_THS_FILTER_EN                 BIT(2)
> > +#define SUN50I_THS_FILTER_TYPE(x)            (GENMASK(1, 0) & (x))
> > +#define SUN50I_H6_THS_PC_TEMP_PERIOD(x)              ((GENMASK(19, 0) & (x)) << 12)
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
>
> I'm not super fond of having a lot of quirks that are not needed. If
> we ever need those quirks when adding support for a new SoC, then
> yeah, we should totally have some, but only when and if it's needed.
>
> Otherwise, the driver is more complicated for no particular reason.
>
> > +
> > +struct tsens_device {
>
> IIRC the acronym used by allwinner is THS, maybe we can just use that
> as a prefix?
>
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
> > +     struct tsensor *s = data;
> > +     struct tsens_device *tmdev = s->tmdev;
> > +     int val;
> > +
> > +     regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > +                 0x4 * s->id, &val);
> > +
> > +     if (unlikely(val == 0))
> > +             return -EBUSY;
>
> I'm not sure why a val equals to 0 would be associated with EBUSY?

First few reads of temp data return 0, and in case of H6 (and A64) it
means max temperature, so kernel does emergency shutdown. I used
-ETIMEDOUT as a workaround in my tree, but it's not appropriate here
either. Any suggestions are welcome.

> Also, it's not in a fast path, so you can drop the unlikely. Chances
> are it's not that unlikely anyway.

As I said earlier, it's just few samples after start up.

> > +     *temp = tsens_reg2temp(tmdev, val);
> > +     if (tmdev->chip->ft_deviation)
> > +             *temp += tmdev->chip->ft_deviation;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops tsens_ops = {
> > +     .get_temp = tsens_get_temp,
> > +};
> > +
> > +static const struct regmap_config config = {
> > +     .reg_bits = 32,
> > +     .val_bits = 32,
> > +     .reg_stride = 4,
> > +     .fast_io = true,
> > +};
> > +
> > +static int tsens_init(struct tsens_device *tmdev)
> > +{
> > +     struct device *dev = tmdev->dev;
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct resource *mem;
> > +     void __iomem *base;
> > +
> > +     mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     base = devm_ioremap_resource(dev, mem);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     tmdev->regmap = devm_regmap_init_mmio_clk(dev, "bus",
> > +                                               base,
> > +                                               &config);
> > +     if (IS_ERR(tmdev->regmap))
> > +             return PTR_ERR(tmdev->regmap);
> > +
> > +     tmdev->reset = devm_reset_control_get(dev, "bus");
> > +     if (IS_ERR(tmdev->reset))
> > +             return PTR_ERR(tmdev->reset);
> > +
> > +     tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
> > +     if (IS_ERR(tmdev->bus_clk))
> > +             return PTR_ERR(tmdev->bus_clk);
>
> You don't need to get that clock if regmap has it already.
>
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Even if the external calibration data stored in sid is not accessible,
> > + * the THS hardware can still work, although the data won't be so accurate.
> > + * The default value of calibration register is 0x800 for every sensor,
> > + * and the calibration value is usually 0x7xx or 0x8xx, so they won't be
> > + * away from the default value for a lot.
> > + *
> > + * So here we do not return error if the calibartion data is
> > + * not available, except the probe needs deferring.
> > + */
> > +static int tsens_calibrate(struct tsens_device *tmdev)
> > +{
> > +     struct nvmem_cell *calcell;
> > +     struct device *dev = tmdev->dev;
> > +     u16 *caldata;
> > +     size_t callen;
> > +     int ft_temp;
> > +     int i = 0;
> > +
> > +     calcell = devm_nvmem_cell_get(dev, "calib");
> > +     if (IS_ERR(calcell)) {
> > +             if (PTR_ERR(calcell) == -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +
> > +             goto out;
> > +     }
> > +
> > +     caldata = nvmem_cell_read(calcell, &callen);
> > +     if (IS_ERR(caldata))
> > +             goto out;
> > +
> > +     if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num)
> > +             goto out_free;
>
> The first part of your or isn't obvious and should have a comment.
>
> The second part shouldn't return 0 but an error
>
> > +
> > +     /*
> > +      * The calbration data on H6 is stored as temperature-value
> > +      * pair when being filled at factory test stage.
> > +      * The unit of stored FT temperature is 0.1 degreee celusis.
> > +      */
> > +     ft_temp = caldata[0] & FT_TEMP_MASK;
> > +
> > +     for (; i < tmdev->chip->sensor_num; i++) {
>
> Usually you would initialize i here, and not when declared.
>
> > +             int reg = (int)caldata[i + 1];
> > +             int sensor_temp = tsens_reg2temp(tmdev, reg);
> > +             int delta, cdata, calib_offest;
> > +
> > +             /*
> > +              * To calculate the calibration value:
> > +              *
> > +              * X(in Celsius) = Ts - ft_temp
> > +              * delta = X * 10000 / TEMP_TO_REG
> > +              * cdata = CALIBRATE_DEFAULT - delta
> > +              *
> > +              * cdata: calibration value
> > +              */
> > +             delta = (sensor_temp - ft_temp * 100) * 10 / TEMP_TO_REG;
> > +             cdata = CALIBRATE_DEFAULT - delta;
> > +             if (cdata & ~TEMP_CALIB_MASK) {
> > +                     dev_warn(dev, "sensor%d calibration value error", i);
> > +
> > +                     continue;
> > +             }
> > +
> > +             calib_offest = tmdev->chip->temp_calib_base + (i / 2) * 0x4;
> > +
> > +             if (i % 2) {
> > +                     int val;
> > +
> > +                     regmap_read(tmdev->regmap, calib_offest, &val);
> > +                     val = (val & TEMP_CALIB_MASK) | (cdata << 16);
> > +                     regmap_write(tmdev->regmap, calib_offest, val);
> > +             } else
> > +                     regmap_write(tmdev->regmap, calib_offest, cdata);
>
> This should have brackets as well
>
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
> > +     int i = 0;
> > +
> > +     for (; i < tmdev->chip->sensor_num; i++) {
>
> Ditto
>
> > +             tmdev->sensor[i].tmdev = tmdev;
> > +             tmdev->sensor[i].id = i;
> > +             tmdev->sensor[i].tzd = devm_thermal_zone_of_sensor_register(
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
> > +     struct device *dev = &pdev->dev;
> > +     int ret;
> > +
> > +     tmdev = devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > +     if (!tmdev)
> > +             return -ENOMEM;
> > +
> > +     tmdev->dev = dev;
> > +     tmdev->chip = of_device_get_match_data(&pdev->dev);
> > +     if (!tmdev->chip)
> > +             return -EINVAL;
> > +
> > +     ret = tsens_init(tmdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = tsens_register(tmdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = tmdev->chip->enable(tmdev);
> > +     if (ret)
> > +             return ret;
> >
> > +     platform_set_drvdata(pdev, tmdev);
>
> Your registration should be the very last thing you do. Otherwise, you
> have a small window where the get_temp callback can be called, but the
> driver will not be functional yet.
>
> > +     return ret;
> > +}
> > +
> > +static int tsens_remove(struct platform_device *pdev)
> > +{
> > +     struct tsens_device *tmdev = platform_get_drvdata(pdev);
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
> > +     ret = reset_control_deassert(tmdev->reset);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = clk_prepare_enable(tmdev->bus_clk);
> > +     if (ret)
> > +             goto assert_reset;
>
> This is done by regmap as well
>
> > +     ret = tsens_calibrate(tmdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * clkin = 24MHz
> > +      * T acquire = clkin / (SUN50I_THS_CTRL0_T_ACQ + 1)
> > +      *           = 20us
> > +      */
> > +     regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> > +                  SUN50I_THS_CTRL0_T_ACQ(479));
> > +     /* average over 4 samples */
> > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> > +                  SUN50I_THS_FILTER_EN |
> > +                  SUN50I_THS_FILTER_TYPE(1));
> > +     /* period = (SUN50I_H6_THS_PC_TEMP_PERIOD + 1) * 4096 / clkin; ~10ms */
> > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> > +                  SUN50I_H6_THS_PC_TEMP_PERIOD(58));
> > +     /* enable sensor */
> > +     val = GENMASK(tmdev->chip->sensor_num - 1, 0);
> > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
> > +
> > +     return 0;
> > +
> > +assert_reset:
> > +     reset_control_assert(tmdev->reset);
> > +
> > +     return ret;
>
> Can't we do that with runtime_pm?
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
