Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A0538BB7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfFGNe5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 09:34:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43479 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfFGNe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 09:34:57 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so1394053ios.10;
        Fri, 07 Jun 2019 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAwOiKdZDLFkmSa7LbdbIwehYAkzDcfXiMDU2gQvSqI=;
        b=Wgm9na0XXMH5qO8xP7dinXWtXlE5j4hlfZf6EBf1sKMikdHZbCQChrPAAs7nN0RS2a
         IcFM6H0mgXr8ES6OaD4DTW4fQBSTP+h+I7JpqO6BLGQBg9UMdP8yK8sAgkAAwCyfFUAc
         VLWwR0FcYv1ubm25881VQs4AfA2CpAN0I9uXWEhAjBwUg1VOqC4KC41xxnHvDmL7yI0h
         Clh0QG7M1aXicJv/cqWGijXPTD4cIbgiGi5b1J/94sHmSvvMYM7JXU0ncPL4zvmckoxU
         J0jOMHsZvGMR1k/Gyd+YwDCHsJMlnTcMuwSSKzDo6Ck7WSbVU9gy79SRO2hy7C1K3UKH
         6Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAwOiKdZDLFkmSa7LbdbIwehYAkzDcfXiMDU2gQvSqI=;
        b=Iz67vVAXMwi8ONQEi2+tc3NaHGPQcl/deO2ZiuTua0iZkxTuICVnrFKvKzEweaExHc
         iCP9BMhcaeRs3FNdTbN/nOhh2YWzqu7Q9RCEgUv31Uwkig+jXHZzwYQqfofd35YgBGOU
         YMRbm64+VRpL/Csf2pzcKvMtxbJvp0sPUR+ESy5wLIUGXMUtwAcDiqKcZXqcIUlYo78i
         G19L10ZMJ6Gz7SWH1/Fo7Wp5wkOEIlOLnfDQ8+m2adpf8QxfhbkTUd9n7JLLP6s2D/9g
         YrVbApjdugLevj+Jh3phhpq6CI4I/XtfStHgk6aOdRTO1E/likrxgGkYesAxm3nVP+Mb
         EiTA==
X-Gm-Message-State: APjAAAUhTixITjBrMzJDgmDWxOLm/y4ES2jjiG+sS4m7Nkx8BJWYR4IF
        lPUy8oTxnzDoqkKFuiVPSJ0W7ZZZcBBNXxpAWh8=
X-Google-Smtp-Source: APXvYqz9dGTCGsaO4SaGQcW2t5Kf4Wolte6lgl5beTnTMrASz4yJpZeIto2fse2kGnx8+4opVFsQWWoSzehz6IM0I20=
X-Received: by 2002:a05:6602:220d:: with SMTP id n13mr20069237ion.104.1559914495695;
 Fri, 07 Jun 2019 06:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <20190527122752.uc7q6zkjti3zag4q@flea>
In-Reply-To: <20190527122752.uc7q6zkjti3zag4q@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 7 Jun 2019 21:34:44 +0800
Message-ID: <CAEExFWtxEB67Pv-8x4ry=tZcJjOD6Kxydq_YB73Gox25VmQn7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 27, 2019 at 8:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi!
>
> Thanks for submitting a new version
>
> On Sat, May 25, 2019 at 02:13:27PM -0400, Yangtao Li wrote:
> > This patch adds the support for allwinner thermal sensor, within
> > allwinner SoC. It will register sensors for thermal framework
> > and use device tree to bind cooling device.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  MAINTAINERS                     |   7 +
> >  drivers/thermal/Kconfig         |  14 +
> >  drivers/thermal/Makefile        |   1 +
> >  drivers/thermal/sun8i_thermal.c | 437 ++++++++++++++++++++++++++++++++
> >  4 files changed, 459 insertions(+)
> >  create mode 100644 drivers/thermal/sun8i_thermal.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2336dd26ece4..d312f9eecf0d 100644
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
> > +F:   Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> > +F:   drivers/thermal/sun8i_thermal.c
> > +
> >  ALLWINNER VPU DRIVER
> >  M:   Maxime Ripard <maxime.ripard@bootlin.com>
> >  M:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 9966364a6deb..e5465053d66f 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -262,6 +262,20 @@ config SPEAR_THERMAL
> >         Enable this to plug the SPEAr thermal sensor driver into the Linux
> >         thermal framework.
> >
> > +config SUN8I_THERMAL
> > +     tristate "Allwinner sun8i thermal driver"
> > +     depends on ARCH_SUNXI || COMPILE_TEST
> > +     depends on HAS_IOMEM
> > +     depends on NVMEM_SUNXI_SID
>
> Do you? It looks from your binding as if it's optional. Also, it's
> pretty uncommon to depend on a given driver, usually you'll want to
> depend on the framework instead.
>
> > +     depends on OF
> > +     depends on RESET_CONTROLLER
> > +     help
> > +       Support for the sun8i thermal sensor driver into the Linux thermal
> > +       framework.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called sun8i-thermal.
> > +
> >  config ROCKCHIP_THERMAL
> >       tristate "Rockchip thermal driver"
> >       depends on ARCH_ROCKCHIP || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 74a37c7f847a..fa6f8b206281 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -31,6 +31,7 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
> >  obj-y                                += broadcom/
> >  obj-$(CONFIG_THERMAL_MMIO)           += thermal_mmio.o
> >  obj-$(CONFIG_SPEAR_THERMAL)  += spear_thermal.o
> > +obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
> >  obj-$(CONFIG_ROCKCHIP_THERMAL)       += rockchip_thermal.o
> >  obj-$(CONFIG_RCAR_THERMAL)   += rcar_thermal.o
> >  obj-$(CONFIG_RCAR_GEN3_THERMAL)      += rcar_gen3_thermal.o
> > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > new file mode 100644
> > index 000000000000..a9cc2197f4cb
> > --- /dev/null
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -0,0 +1,437 @@
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
> > +#include <linux/interrupt.h>
> > +#include <linux/wait.h>
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
> > +#define SUN50I_H6_THS_DIC                    0x10
> > +#define SUN50I_H6_THS_DIS                    0x20
> > +#define SUN50I_H6_THS_MFC                    0x30
> > +#define SUN50I_H6_THS_TEMP_CALIB             0xa0
> > +#define SUN50I_H6_THS_TEMP_DATA                      0xc0
> > +
> > +#define SUN50I_THS_CTRL0_T_ACQ(x)            ((GENMASK(15, 0) & (x)) << 16)
> > +#define SUN50I_THS_FILTER_EN                 BIT(2)
> > +#define SUN50I_THS_FILTER_TYPE(x)            (GENMASK(1, 0) & (x))
> > +#define SUN50I_H6_THS_PC_TEMP_PERIOD(x)              ((GENMASK(19, 0) & (x)) << 12)
> > +#define SUN50I_H6_THS_DATA_IRQ_STS(x)                BIT(x)
> > +
> > +/* millidegree celsius */
> > +#define SUN50I_H6_FT_DEVIATION                       7000
> > +
> > +struct ths_device;
> > +
> > +struct tsensor {
> > +     struct ths_device               *tmdev;
> > +     struct thermal_zone_device      *tzd;
> > +     int                             id;
> > +     wait_queue_head_t               wait_queue;
> > +};
> > +
> > +struct ths_thermal_chip {
> > +     int             sensor_num;
> > +     int             offset;
> > +     int             scale;
> > +     int             ft_deviation;
> > +     int             temp_calib_base;
> > +     int             temp_data_base;
> > +     int             (*calibrate)(struct ths_device *tmdev);
> > +     int             (*init)(struct ths_device *tmdev);
> > +     irqreturn_t     (*irq_thread)(int irq, void *data);
> > +};
>
> Again, you should remove these quirks structure at the moment and only
> deal with the H6.
>
> > +struct ths_device {
> > +     const struct ths_thermal_chip           *chip;
> > +     struct device                           *dev;
> > +     struct regmap                           *regmap;
> > +     struct reset_control                    *reset;
> > +     struct clk                              *bus_clk;
> > +     struct tsensor                          sensor[MAX_SENSOR_NUM];
> > +     int                                     data_ready;
> > +};
> > +
> > +/* Temp Unit: millidegree Celsius */
> > +static int sun8i_ths_reg2temp(struct ths_device *tmdev,
> > +                           int reg)
> > +{
> > +     return (reg + tmdev->chip->offset) * tmdev->chip->scale;
> > +}
> > +
> > +static int sun8i_ths_get_temp(void *data, int *temp)
> > +{
> > +     struct tsensor *s = data;
> > +     struct ths_device *tmdev = s->tmdev;
> > +     int val;
> > +
> > +     wait_event(s->wait_queue, tmdev->data_ready & BIT(s->id));
> > +     tmdev->data_ready &= ~BIT(s->id);
> > +
> > +     regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > +                 0x4 * s->id, &val);
> > +
> > +     *temp = sun8i_ths_reg2temp(tmdev, val);
> > +     /*
> > +      * XX - According to the original sdk, there are some platforms(rarely)
> > +      * that add a fixed offset value after calculating the temperature
> > +      * value. We can't simply put it on the formula for calculating the
> > +      * temperature above, because the formula for calculating the
> > +      * temperature above is also used when the sensor is calibrated. If
> > +      * do this, the correct calibration formula is hard to know.
> > +      */
> > +     if (tmdev->chip->ft_deviation)
> > +             *temp += tmdev->chip->ft_deviation;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops ths_ops = {
> > +     .get_temp = sun8i_ths_get_temp,
> > +};
> > +
> > +static const struct regmap_config config = {
> > +     .reg_bits = 32,
> > +     .val_bits = 32,
> > +     .reg_stride = 4,
> > +     .fast_io = true,
> > +};
> > +
> > +static irqreturn_t sun50i_h6_irq_thread(int irq, void *data)
> > +{
> > +     wait_queue_head_t *data_wait;
> > +     struct ths_device *tmdev = data;
> > +     int i, state;
> > +
> > +     regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
> > +
> > +     for (i = 0; i < tmdev->chip->sensor_num; i++) {
> > +             data_wait = &tmdev->sensor[i].wait_queue;
>
> You're only using data_wait in that scope, so you should define it
> here.
>
> > +
> > +             if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
> > +                     /* clear data irq pending */
> > +                     regmap_write(tmdev->regmap, SUN50I_H6_THS_DIS,
> > +                                  SUN50I_H6_THS_DATA_IRQ_STS(i));
> > +
> > +                     tmdev->data_ready |= BIT(i);
> > +                     wake_up(data_wait);
> > +             }
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int sun8i_ths_resource_init(struct ths_device *tmdev)
> > +{
> > +     struct device *dev = tmdev->dev;
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct resource *mem;
> > +     void __iomem *base;
> > +     int ret, irq;
> > +
> > +     mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     base = devm_ioremap_resource(dev, mem);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     tmdev->regmap = devm_regmap_init_mmio(dev, base, &config);
> > +     if (IS_ERR(tmdev->regmap))
> > +             return PTR_ERR(tmdev->regmap);
> > +
> > +     tmdev->reset = devm_reset_control_get(dev, 0);
> > +     if (IS_ERR(tmdev->reset))
> > +             return PTR_ERR(tmdev->reset);
> > +
> > +     tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
> > +     if (IS_ERR(tmdev->bus_clk))
> > +             return PTR_ERR(tmdev->bus_clk);
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
> > +     ret = devm_request_threaded_irq(dev, irq, NULL,
> > +                                     tmdev->chip->irq_thread,
> > +                                     IRQF_ONESHOT, "ths", tmdev);
> > +     if (ret)
> > +             return ret;
>
> Is there any particular reason to use a threaded interrupt?

Just to improve real-time.

>
> Also, starting from here you can start having interrupts...
>
> > +
> > +     ret = reset_control_deassert(tmdev->reset);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = clk_prepare_enable(tmdev->bus_clk);
> > +     if (ret)
> > +             goto assert_reset;
> > +
> > +     ret = tmdev->chip->calibrate(tmdev);
> > +     if (ret)
> > +             goto bus_disable;
>
> While the device hasn't been properly initialized yet. Especially when
> held in reset, some Allwinner controllers has been known to send
> spurious interrupts, so we want to defer that to the very last minute
> (so right before your call to sun8i_ths_register).
>
> > +     return 0;
> > +
> > +bus_disable:
> > +     clk_disable_unprepare(tmdev->bus_clk);
> > +assert_reset:
> > +     reset_control_assert(tmdev->reset);
> > +
> > +     return ret;
> > +}
> > +
> > +static int sun50i_ths_calibrate(struct ths_device *tmdev)
> > +{
> > +     struct nvmem_cell *calcell;
> > +     struct device *dev = tmdev->dev;
> > +     u16 *caldata;
> > +     size_t callen;
> > +     int ft_temp;
> > +     int i, ret = 0;
> > +
> > +     calcell = devm_nvmem_cell_get(dev, "calib");
> > +     if (IS_ERR(calcell)) {
> > +             if (PTR_ERR(calcell) == -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +             /*
> > +              * Even if the external calibration data stored in sid is
> > +              * not accessible, the THS hardware can still work, although
> > +              * the data won't be so accurate.
> > +              *
> > +              * The default value of calibration register is 0x800 for
> > +              * every sensor, and the calibration value is usually 0x7xx
> > +              * or 0x8xx, so they won't be away from the default value
> > +              * for a lot.
> > +              *
> > +              * So here we do not return error if the calibartion data is
> > +              * not available, except the probe needs deferring.
> > +              */
> > +             goto out;
> > +     }
> > +
> > +     caldata = nvmem_cell_read(calcell, &callen);
> > +     if (IS_ERR(caldata)) {
> > +             ret = PTR_ERR(caldata);
> > +             goto out;
> > +     }
> > +
> > +     if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num) {
> > +             ret = -EINVAL;
> > +             goto out_free;
> > +     }
> > +
> > +     /*
> > +      * efuse layout:
> > +      *
> > +      *      0   11  16       32
> > +      *      +-------+-------+-------+
> > +      *      |temp|  |sensor0|sensor1|
> > +      *      +-------+-------+-------+
> > +      *
> > +      * The calibration data on the H6 is the ambient temperature and
> > +      * sensor values that are filled during the factory test stage.
> > +      *
> > +      * The unit of stored FT temperature is 0.1 degreee celusis.
> > +      * Through the stored ambient temperature and the data read
> > +      * by the sensor, after a certain calculation, the calibration
> > +      * value to be compensated can be obtained.
> > +      */
> > +     ft_temp = caldata[0] & FT_TEMP_MASK;
> > +
> > +     for (i = 0; i < tmdev->chip->sensor_num; i++) {
> > +             int reg = (int)caldata[i + 1];
> > +             int sensor_temp = sun8i_ths_reg2temp(tmdev, reg);
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
> > +                     /*
> > +                      * Calibration value more than 12-bit, but calibration
> > +                      * register is 12-bit. In this case, ths hardware can
> > +                      * still work without calibration, although the data
> > +                      * won't be so accurate.
> > +                      */
> > +                     dev_warn(dev, "sensor%d is not calibrated.\n", i);
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
> > +             } else {
> > +                     regmap_write(tmdev->regmap, calib_offest, cdata);
> > +             }
> > +     }
> > +
> > +out_free:
> > +     kfree(caldata);
> > +out:
> > +     return ret;
> > +}
> > +
> > +static int sun8i_ths_register(struct ths_device *tmdev)
> > +{
> > +     struct thermal_zone_device *tzd;
> > +     int i;
> > +
> > +     for (i = 0; i < tmdev->chip->sensor_num; i++) {
> > +             tmdev->sensor[i].tmdev = tmdev;
> > +             tmdev->sensor[i].id = i;
> > +             tmdev->sensor[i].tzd =
> > +                     devm_thermal_zone_of_sensor_register(tmdev->dev,
> > +                                                          i,
> > +                                                          &tmdev->sensor[i],
> > +                                                          &ths_ops);
> > +             if (IS_ERR(tmdev->sensor[i].tzd))
> > +                     return PTR_ERR(tzd);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun8i_ths_probe(struct platform_device *pdev)
> > +{
> > +     struct ths_device *tmdev;
> > +     struct device *dev = &pdev->dev;
> > +     int i, ret;
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
> > +     /*
> > +      * Initialize wait_queue in advance, to avoid calling wake_up
> > +      * before ths is registered in isr.
> > +      */
> > +     for (i = 0; i < tmdev->chip->sensor_num; i++)
> > +             init_waitqueue_head(&tmdev->sensor[i].wait_queue);
> > +
> > +     platform_set_drvdata(pdev, tmdev);
> > +
> > +     ret = sun8i_ths_resource_init(tmdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = tmdev->chip->init(tmdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = sun8i_ths_register(tmdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return ret;
> > +}
> > +
> > +static int sun8i_ths_remove(struct platform_device *pdev)
> > +{
> > +     struct ths_device *tmdev = platform_get_drvdata(pdev);
> > +
> > +     clk_disable_unprepare(tmdev->bus_clk);
>
> I know that we discussed that already, but I'm not sure why you switch
> back to a regular call to regmap_init_mmio, while regmap_init_mmio_clk
> will take care of enabling and disabling the bus clock for you?

It seems that regmap_init_mmio_clk just get clk and prepare clk
but no enable.

Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
