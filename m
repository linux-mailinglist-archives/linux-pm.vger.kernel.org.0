Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3819538BF5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfFGNxH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 09:53:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52040 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfFGNxH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 09:53:07 -0400
Received: by mail-it1-f196.google.com with SMTP id m3so2807736itl.1;
        Fri, 07 Jun 2019 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9O3vJ6UFNZgJdpurkZJ1zf0TI7rxpOSfZyofdAeA3ZA=;
        b=EgbjpWvAYhYXcfOBT3PihpNeG3+zydATGZtm+zKjWl0VVPMQwTQl8tG+ptB12j/oie
         9kGPKwh45YwmBmQ2Kg7Pu5j/CQr7IxGLQQZFJym+ixrcFPKPh7EGOW1TK7qxITprosHy
         wb+GzAHNXnH7E96wcvcL9Iu/4kmhMD8YjE9cpqm5/eNZ741luf0/EVnul0yQLOv/t4LS
         vuBGrpi5GCNXP7Kw/Nd49wqTSWb3URTXFcgK9+qfxMZBo1gBWpSHc3swHxE1Jj/ypdV3
         VycbXBCZJp6M1dtb7KPb/vI0K2WyBQuluato15UdaVDblHTocyOCDKGixkUcu2r+LvI3
         mNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=9O3vJ6UFNZgJdpurkZJ1zf0TI7rxpOSfZyofdAeA3ZA=;
        b=UhmJ8a0VBZ1xJEyW8wA65XMACcTnLytu5HHvVYruSXyIiBOGJbbNN7s7JeGJUYjtxF
         aNSHdSX59yCExSViIJAP4o93ixydCfq8c8XsrQWtRTFgizcUkh6tlHv33vevuztwGbXj
         5RtgXfFDfbSH51b/21DLh2+8ZlxaPLFBO/pNW0yXCC5kT+VhKRDmzWQ99yDynBols/kU
         aZsEX+JHg5EOJZv4MGYWimcThA7vdBUtx1LtSlQADO2M3KN9U7W0lGsMUPnqmnlNCikC
         8M41cFJs4LEUAWJMRx8cYJr9Tuqatt4DDHBwjUQKLb8U+mICkk74hqMjhNVsu7NlzlV3
         m86Q==
X-Gm-Message-State: APjAAAXE3D7tAivN5H29GyQs3GoeVJHiSAxj/cKfj4cpUwBJraeNdOap
        VzS3RLheaItdCsM9HeiUva+XlZDzAbFCQf21uWs=
X-Google-Smtp-Source: APXvYqwi1A102ejKg4N8aXDBe7mxMxKCUX0ZtIeJU/DizGEH7wQxBMvamB2rUFyBed/qXV0tqAcv5vNYnRtU49WAlzY=
X-Received: by 2002:a24:ee08:: with SMTP id b8mr4490939iti.174.1559915585720;
 Fri, 07 Jun 2019 06:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <20190527142544.skblqfcz5fqfzxgl@core.my.home> <CAEExFWvGOuiEMT8SGYUXtqCZh2ZQCavns++kWgXaAtcozBiDeQ@mail.gmail.com>
In-Reply-To: <CAEExFWvGOuiEMT8SGYUXtqCZh2ZQCavns++kWgXaAtcozBiDeQ@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 7 Jun 2019 21:52:54 +0800
Message-ID: <CAEExFWvxNnwU_f7qRNZehUOs-THXk1RXTsofc+vgkT3OH-Gcdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 7, 2019 at 9:50 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> HI Ond=C5=99ej,
>
>
> On Mon, May 27, 2019 at 10:25 PM Ond=C5=99ej Jirman <megous@megous.com> w=
rote:
> >
> > Hi Yangtao,
> >
> > On Sat, May 25, 2019 at 02:13:27PM -0400, Yangtao Li wrote:
> > > This patch adds the support for allwinner thermal sensor, within
> > > allwinner SoC. It will register sensors for thermal framework
> > > and use device tree to bind cooling device.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  MAINTAINERS                     |   7 +
> > >  drivers/thermal/Kconfig         |  14 +
> > >  drivers/thermal/Makefile        |   1 +
> > >  drivers/thermal/sun8i_thermal.c | 437 ++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 459 insertions(+)
> > >  create mode 100644 drivers/thermal/sun8i_thermal.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 2336dd26ece4..d312f9eecf0d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -674,6 +674,13 @@ L:       linux-crypto@vger.kernel.org
> > >  S:   Maintained
> > >  F:   drivers/crypto/sunxi-ss/
> > >
> > > +ALLWINNER THERMAL DRIVER
> > > +M:   Yangtao Li <tiny.windzz@gmail.com>
> > > +L:   linux-pm@vger.kernel.org
> > > +S:   Maintained
> > > +F:   Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> > > +F:   drivers/thermal/sun8i_thermal.c
> > > +
> > >  ALLWINNER VPU DRIVER
> > >  M:   Maxime Ripard <maxime.ripard@bootlin.com>
> > >  M:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 9966364a6deb..e5465053d66f 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -262,6 +262,20 @@ config SPEAR_THERMAL
> > >         Enable this to plug the SPEAr thermal sensor driver into the =
Linux
> > >         thermal framework.
> > >
> > > +config SUN8I_THERMAL
> > > +     tristate "Allwinner sun8i thermal driver"
> > > +     depends on ARCH_SUNXI || COMPILE_TEST
> > > +     depends on HAS_IOMEM
> > > +     depends on NVMEM_SUNXI_SID
> > > +     depends on OF
> > > +     depends on RESET_CONTROLLER
> > > +     help
> > > +       Support for the sun8i thermal sensor driver into the Linux th=
ermal
> > > +       framework.
> > > +
> > > +       To compile this driver as a module, choose M here: the
> > > +       module will be called sun8i-thermal.
> > > +
> > >  config ROCKCHIP_THERMAL
> > >       tristate "Rockchip thermal driver"
> > >       depends on ARCH_ROCKCHIP || COMPILE_TEST
> > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > index 74a37c7f847a..fa6f8b206281 100644
> > > --- a/drivers/thermal/Makefile
> > > +++ b/drivers/thermal/Makefile
> > > @@ -31,6 +31,7 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devfreq_=
cooling.o
> > >  obj-y                                +=3D broadcom/
> > >  obj-$(CONFIG_THERMAL_MMIO)           +=3D thermal_mmio.o
> > >  obj-$(CONFIG_SPEAR_THERMAL)  +=3D spear_thermal.o
> > > +obj-$(CONFIG_SUN8I_THERMAL)     +=3D sun8i_thermal.o
> > >  obj-$(CONFIG_ROCKCHIP_THERMAL)       +=3D rockchip_thermal.o
> > >  obj-$(CONFIG_RCAR_THERMAL)   +=3D rcar_thermal.o
> > >  obj-$(CONFIG_RCAR_GEN3_THERMAL)      +=3D rcar_gen3_thermal.o
> > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_=
thermal.c
> > > new file mode 100644
> > > index 000000000000..a9cc2197f4cb
> > > --- /dev/null
> > > +++ b/drivers/thermal/sun8i_thermal.c
> > > @@ -0,0 +1,437 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Thermal sensor driver for Allwinner SOC
> > > + * Copyright (C) 2019 Yangtao Li
> > > + *
> > > + * Based on the work of Icenowy Zheng <icenowy@aosc.io>
> > > + * Based on the work of Ondrej Jirman <megous@megous.com>
> > > + * Based on the work of Josef Gajdusek <atx@atx.name>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/device.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/wait.h>
> > > +#include <linux/module.h>
> > > +#include <linux/nvmem-consumer.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/reset.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/thermal.h>
> > > +
> > > +#define MAX_SENSOR_NUM       4
> > > +
> > > +#define FT_TEMP_MASK                         GENMASK(11, 0)
> > > +#define TEMP_CALIB_MASK                              GENMASK(11, 0)
> > > +#define TEMP_TO_REG                          672
> > > +#define CALIBRATE_DEFAULT                    0x800
> > > +
> > > +#define SUN50I_THS_CTRL0                     0x00
> > > +#define SUN50I_H6_THS_ENABLE                 0x04
> > > +#define SUN50I_H6_THS_PC                     0x08
> > > +#define SUN50I_H6_THS_DIC                    0x10
> > > +#define SUN50I_H6_THS_DIS                    0x20
> > > +#define SUN50I_H6_THS_MFC                    0x30
> > > +#define SUN50I_H6_THS_TEMP_CALIB             0xa0
> > > +#define SUN50I_H6_THS_TEMP_DATA                      0xc0
> > > +
> > > +#define SUN50I_THS_CTRL0_T_ACQ(x)            ((GENMASK(15, 0) & (x))=
 << 16)
> > > +#define SUN50I_THS_FILTER_EN                 BIT(2)
> > > +#define SUN50I_THS_FILTER_TYPE(x)            (GENMASK(1, 0) & (x))
> > > +#define SUN50I_H6_THS_PC_TEMP_PERIOD(x)              ((GENMASK(19, 0=
) & (x)) << 12)
> > > +#define SUN50I_H6_THS_DATA_IRQ_STS(x)                BIT(x)
> > > +
> > > +/* millidegree celsius */
> > > +#define SUN50I_H6_FT_DEVIATION                       7000
> > > +
> > > +struct ths_device;
> > > +
> > > +struct tsensor {
> > > +     struct ths_device               *tmdev;
> > > +     struct thermal_zone_device      *tzd;
> > > +     int                             id;
> > > +     wait_queue_head_t               wait_queue;
> > > +};
> > > +
> > > +struct ths_thermal_chip {
> > > +     int             sensor_num;
> > > +     int             offset;
> > > +     int             scale;
> > > +     int             ft_deviation;
> > > +     int             temp_calib_base;
> > > +     int             temp_data_base;
> > > +     int             (*calibrate)(struct ths_device *tmdev);
> > > +     int             (*init)(struct ths_device *tmdev);
> > > +     irqreturn_t     (*irq_thread)(int irq, void *data);
> > > +};
> > > +
> > > +struct ths_device {
> > > +     const struct ths_thermal_chip           *chip;
> > > +     struct device                           *dev;
> > > +     struct regmap                           *regmap;
> > > +     struct reset_control                    *reset;
> > > +     struct clk                              *bus_clk;
> > > +     struct tsensor                          sensor[MAX_SENSOR_NUM];
> > > +     int                                     data_ready;
> > > +};
> > > +
> > > +/* Temp Unit: millidegree Celsius */
> > > +static int sun8i_ths_reg2temp(struct ths_device *tmdev,
> > > +                           int reg)
> > > +{
> > > +     return (reg + tmdev->chip->offset) * tmdev->chip->scale;
> > > +}
> > > +
> > > +static int sun8i_ths_get_temp(void *data, int *temp)
> > > +{
> > > +     struct tsensor *s =3D data;
> > > +     struct ths_device *tmdev =3D s->tmdev;
> > > +     int val;
> > > +
> > > +     wait_event(s->wait_queue, tmdev->data_ready & BIT(s->id));
> > > +     tmdev->data_ready &=3D ~BIT(s->id);
> >
> > I've looked at thermal_core.c and it looks like that the proper way to =
handle
> > this situation is just returning -EAGAIN.
>
> What we are doing now is to turn it into an interrupt-based program.
> Every time we use temperature data, we need to wait until new data is col=
lected.
>
> >
> > See update_temperature() function in thermal_core.c.
> >
> > That will suppress the warning about failure to read thermal zone. Also
> > it's much simpler than this wait_queue stuff. No other thermal driver u=
ses this
> > either. Also get_temp is called under thermal_list_lock mutex and that =
would
> > block cooling device registrations and god knows what else.
>
> Since there is no valid temperature data, it cannot be blocked.

Since there is no valid temperature data, why can't it be blocked?

>
> MBR,
> Yangtao
>
> >
> > Other than that, and what Maxime said, I don't see any more issues.
> >
> > thank you,
> >         o.
> >
> > > +     regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > > +                 0x4 * s->id, &val);
> > > +
> > > +     *temp =3D sun8i_ths_reg2temp(tmdev, val);
> > > +     /*
> > > +      * XX - According to the original sdk, there are some platforms=
(rarely)
> > > +      * that add a fixed offset value after calculating the temperat=
ure
> > > +      * value. We can't simply put it on the formula for calculating=
 the
> > > +      * temperature above, because the formula for calculating the
> > > +      * temperature above is also used when the sensor is calibrated=
. If
> > > +      * do this, the correct calibration formula is hard to know.
> > > +      */
> > > +     if (tmdev->chip->ft_deviation)
> > > +             *temp +=3D tmdev->chip->ft_deviation;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct thermal_zone_of_device_ops ths_ops =3D {
> > > +     .get_temp =3D sun8i_ths_get_temp,
> > > +};
> > > +
> > > +static const struct regmap_config config =3D {
> > > +     .reg_bits =3D 32,
> > > +     .val_bits =3D 32,
> > > +     .reg_stride =3D 4,
> > > +     .fast_io =3D true,
> > > +};
> > > +
> > > +static irqreturn_t sun50i_h6_irq_thread(int irq, void *data)
> > > +{
> > > +     wait_queue_head_t *data_wait;
> > > +     struct ths_device *tmdev =3D data;
> > > +     int i, state;
> > > +
> > > +     regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
> > > +
> > > +     for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > +             data_wait =3D &tmdev->sensor[i].wait_queue;
> > > +
> > > +             if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
> > > +                     /* clear data irq pending */
> > > +                     regmap_write(tmdev->regmap, SUN50I_H6_THS_DIS,
> > > +                                  SUN50I_H6_THS_DATA_IRQ_STS(i));
> > > +
> > > +                     tmdev->data_ready |=3D BIT(i);
> > > +                     wake_up(data_wait);
> > > +             }
> > > +     }
> > > +
> > > +     return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int sun8i_ths_resource_init(struct ths_device *tmdev)
> > > +{
> > > +     struct device *dev =3D tmdev->dev;
> > > +     struct platform_device *pdev =3D to_platform_device(dev);
> > > +     struct resource *mem;
> > > +     void __iomem *base;
> > > +     int ret, irq;
> > > +
> > > +     mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +     base =3D devm_ioremap_resource(dev, mem);
> > > +     if (IS_ERR(base))
> > > +             return PTR_ERR(base);
> > > +
> > > +     tmdev->regmap =3D devm_regmap_init_mmio(dev, base, &config);
> > > +     if (IS_ERR(tmdev->regmap))
> > > +             return PTR_ERR(tmdev->regmap);
> > > +
> > > +     tmdev->reset =3D devm_reset_control_get(dev, 0);
> > > +     if (IS_ERR(tmdev->reset))
> > > +             return PTR_ERR(tmdev->reset);
> > > +
> > > +     tmdev->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
> > > +     if (IS_ERR(tmdev->bus_clk))
> > > +             return PTR_ERR(tmdev->bus_clk);
> > > +
> > > +     irq =3D platform_get_irq(pdev, 0);
> > > +     if (irq < 0)
> > > +             return irq;
> > > +
> > > +     ret =3D devm_request_threaded_irq(dev, irq, NULL,
> > > +                                     tmdev->chip->irq_thread,
> > > +                                     IRQF_ONESHOT, "ths", tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D reset_control_deassert(tmdev->reset);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D clk_prepare_enable(tmdev->bus_clk);
> > > +     if (ret)
> > > +             goto assert_reset;
> > > +
> > > +     ret =3D tmdev->chip->calibrate(tmdev);
> > > +     if (ret)
> > > +             goto bus_disable;
> > > +
> > > +     return 0;
> > > +
> > > +bus_disable:
> > > +     clk_disable_unprepare(tmdev->bus_clk);
> > > +assert_reset:
> > > +     reset_control_assert(tmdev->reset);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int sun50i_ths_calibrate(struct ths_device *tmdev)
> > > +{
> > > +     struct nvmem_cell *calcell;
> > > +     struct device *dev =3D tmdev->dev;
> > > +     u16 *caldata;
> > > +     size_t callen;
> > > +     int ft_temp;
> > > +     int i, ret =3D 0;
> > > +
> > > +     calcell =3D devm_nvmem_cell_get(dev, "calib");
> > > +     if (IS_ERR(calcell)) {
> > > +             if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
> > > +                     return -EPROBE_DEFER;
> > > +             /*
> > > +              * Even if the external calibration data stored in sid =
is
> > > +              * not accessible, the THS hardware can still work, alt=
hough
> > > +              * the data won't be so accurate.
> > > +              *
> > > +              * The default value of calibration register is 0x800 f=
or
> > > +              * every sensor, and the calibration value is usually 0=
x7xx
> > > +              * or 0x8xx, so they won't be away from the default val=
ue
> > > +              * for a lot.
> > > +              *
> > > +              * So here we do not return error if the calibartion da=
ta is
> > > +              * not available, except the probe needs deferring.
> > > +              */
> > > +             goto out;
> > > +     }
> > > +
> > > +     caldata =3D nvmem_cell_read(calcell, &callen);
> > > +     if (IS_ERR(caldata)) {
> > > +             ret =3D PTR_ERR(caldata);
> > > +             goto out;
> > > +     }
> > > +
> > > +     if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num) {
> > > +             ret =3D -EINVAL;
> > > +             goto out_free;
> > > +     }
> > > +
> > > +     /*
> > > +      * efuse layout:
> > > +      *
> > > +      *      0   11  16       32
> > > +      *      +-------+-------+-------+
> > > +      *      |temp|  |sensor0|sensor1|
> > > +      *      +-------+-------+-------+
> > > +      *
> > > +      * The calibration data on the H6 is the ambient temperature an=
d
> > > +      * sensor values that are filled during the factory test stage.
> > > +      *
> > > +      * The unit of stored FT temperature is 0.1 degreee celusis.
> > > +      * Through the stored ambient temperature and the data read
> > > +      * by the sensor, after a certain calculation, the calibration
> > > +      * value to be compensated can be obtained.
> > > +      */
> > > +     ft_temp =3D caldata[0] & FT_TEMP_MASK;
> > > +
> > > +     for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > +             int reg =3D (int)caldata[i + 1];
> > > +             int sensor_temp =3D sun8i_ths_reg2temp(tmdev, reg);
> > > +             int delta, cdata, calib_offest;
> > > +
> > > +             /*
> > > +              * To calculate the calibration value:
> > > +              *
> > > +              * X(in Celsius) =3D Ts - ft_temp
> > > +              * delta =3D X * 10000 / TEMP_TO_REG
> > > +              * cdata =3D CALIBRATE_DEFAULT - delta
> > > +              *
> > > +              * cdata: calibration value
> > > +              */
> > > +             delta =3D (sensor_temp - ft_temp * 100) * 10 / TEMP_TO_=
REG;
> > > +             cdata =3D CALIBRATE_DEFAULT - delta;
> > > +             if (cdata & ~TEMP_CALIB_MASK) {
> > > +                     /*
> > > +                      * Calibration value more than 12-bit, but cali=
bration
> > > +                      * register is 12-bit. In this case, ths hardwa=
re can
> > > +                      * still work without calibration, although the=
 data
> > > +                      * won't be so accurate.
> > > +                      */
> > > +                     dev_warn(dev, "sensor%d is not calibrated.\n", =
i);
> > > +
> > > +                     continue;
> > > +             }
> > > +
> > > +             calib_offest =3D tmdev->chip->temp_calib_base + (i / 2)=
 * 0x4;
> > > +
> > > +             if (i % 2) {
> > > +                     int val;
> > > +
> > > +                     regmap_read(tmdev->regmap, calib_offest, &val);
> > > +                     val =3D (val & TEMP_CALIB_MASK) | (cdata << 16)=
;
> > > +                     regmap_write(tmdev->regmap, calib_offest, val);
> > > +             } else {
> > > +                     regmap_write(tmdev->regmap, calib_offest, cdata=
);
> > > +             }
> > > +     }
> > > +
> > > +out_free:
> > > +     kfree(caldata);
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static int sun8i_ths_register(struct ths_device *tmdev)
> > > +{
> > > +     struct thermal_zone_device *tzd;
> > > +     int i;
> > > +
> > > +     for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > +             tmdev->sensor[i].tmdev =3D tmdev;
> > > +             tmdev->sensor[i].id =3D i;
> > > +             tmdev->sensor[i].tzd =3D
> > > +                     devm_thermal_zone_of_sensor_register(tmdev->dev=
,
> > > +                                                          i,
> > > +                                                          &tmdev->se=
nsor[i],
> > > +                                                          &ths_ops);
> > > +             if (IS_ERR(tmdev->sensor[i].tzd))
> > > +                     return PTR_ERR(tzd);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int sun8i_ths_probe(struct platform_device *pdev)
> > > +{
> > > +     struct ths_device *tmdev;
> > > +     struct device *dev =3D &pdev->dev;
> > > +     int i, ret;
> > > +
> > > +     tmdev =3D devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > > +     if (!tmdev)
> > > +             return -ENOMEM;
> > > +
> > > +     tmdev->dev =3D dev;
> > > +     tmdev->chip =3D of_device_get_match_data(&pdev->dev);
> > > +     if (!tmdev->chip)
> > > +             return -EINVAL;
> > > +
> > > +     /*
> > > +      * Initialize wait_queue in advance, to avoid calling wake_up
> > > +      * before ths is registered in isr.
> > > +      */
> > > +     for (i =3D 0; i < tmdev->chip->sensor_num; i++)
> > > +             init_waitqueue_head(&tmdev->sensor[i].wait_queue);
> > > +
> > > +     platform_set_drvdata(pdev, tmdev);
> > > +
> > > +     ret =3D sun8i_ths_resource_init(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D tmdev->chip->init(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D sun8i_ths_register(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int sun8i_ths_remove(struct platform_device *pdev)
> > > +{
> > > +     struct ths_device *tmdev =3D platform_get_drvdata(pdev);
> > > +
> > > +     clk_disable_unprepare(tmdev->bus_clk);
> > > +     reset_control_assert(tmdev->reset);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int sun50i_thermal_init(struct ths_device *tmdev)
> > > +{
> > > +     int val;
> > > +
> > > +     /*
> > > +      * clkin =3D 24MHz
> > > +      * T acquire =3D clkin / (x + 1)
> > > +      *           =3D 20us
> > > +      */
> > > +     regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> > > +                  SUN50I_THS_CTRL0_T_ACQ(479));
> > > +     /* average over 4 samples */
> > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> > > +                  SUN50I_THS_FILTER_EN |
> > > +                  SUN50I_THS_FILTER_TYPE(1));
> > > +     /* period =3D (x + 1) * 4096 / clkin; ~10ms */
> > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> > > +                  SUN50I_H6_THS_PC_TEMP_PERIOD(58));
> > > +     /* enable sensor */
> > > +     val =3D GENMASK(tmdev->chip->sensor_num - 1, 0);
> > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
> > > +     /* thermal data interrupt enable */
> > > +     val =3D GENMASK(tmdev->chip->sensor_num - 1, 0);
> > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_DIC, val);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct ths_thermal_chip sun50i_h6_ths =3D {
> > > +     .sensor_num =3D 2,
> > > +     .offset =3D -2794,
> > > +     .scale =3D -67,
> > > +     .ft_deviation =3D SUN50I_H6_FT_DEVIATION,
> > > +     .temp_calib_base =3D SUN50I_H6_THS_TEMP_CALIB,
> > > +     .temp_data_base =3D SUN50I_H6_THS_TEMP_DATA,
> > > +     .calibrate =3D sun50i_ths_calibrate,
> > > +     .init =3D sun50i_thermal_init,
> > > +     .irq_thread =3D sun50i_h6_irq_thread,
> > > +};
> > > +
> > > +static const struct of_device_id of_ths_match[] =3D {
> > > +     { .compatible =3D "allwinner,sun50i-h6-ths", .data =3D &sun50i_=
h6_ths },
> > > +     { /* sentinel */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, of_ths_match);
> > > +
> > > +static struct platform_driver ths_driver =3D {
> > > +     .probe =3D sun8i_ths_probe,
> > > +     .remove =3D sun8i_ths_remove,
> > > +     .driver =3D {
> > > +             .name =3D "sun8i-thermal",
> > > +             .of_match_table =3D of_ths_match,
> > > +     },
> > > +};
> > > +module_platform_driver(ths_driver);
> > > +
> > > +MODULE_DESCRIPTION("Thermal sensor driver for Allwinner SOC");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.17.0
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
