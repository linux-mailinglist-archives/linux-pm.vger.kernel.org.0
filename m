Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5B11736E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 19:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLISEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 13:04:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42291 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLISEd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 13:04:33 -0500
Received: by mail-io1-f67.google.com with SMTP id f82so15738796ioa.9;
        Mon, 09 Dec 2019 10:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GBfykdCMzGnFhNNuZ8MGrm6rhha6Rt2k6la3AP3en2c=;
        b=Ui84EOaWHfqgz/mWmz1M84QPGAXz/+b2RlzoQZX5pytbu2G4J75CYNdPjX+43H+oUI
         ifYwXYy+yrbGRPjZTyQe4mFPaMHJwh9Sn1iVKBBh63jUAMHNbv0UR3egP4QcPoF6p4OV
         oa5cTzwyzt5e/YQfg9MJA9dBJX4Q/JEiHVlpN4R6E6s4KVJouqdG/W4s3qJ1tERdn4pr
         dAnQn15hO/hTneKub+MhV8rvVQkCg1hO9Mm0xg1U6ikHpltOK/wGvRMNG+OpMLvoUmgm
         fR08aSIhhOSS8Yo2Rwr/+f+aVp5BLxmfTNs+qerOrXKDORUVNO4MvjPLFxVwayskrh3C
         xjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=GBfykdCMzGnFhNNuZ8MGrm6rhha6Rt2k6la3AP3en2c=;
        b=ccbde0ETvlw7Iqw74HEiP5SXYbrcwmezn1MOfITcvvLcJWRdOZ11m3s8I9s5N7ETRP
         hedKezfs/VpkZbzQi8PRn5lqxAMz5hSp6a7/Qw//Q4T6IekirmALGZBHz+K3T5OUN7JW
         gKrh4AgYeuus7B0ncf18glud5Ze3icze3NOeWhM0sfFwVFW59dyuEONGqQRpPvlxOr3I
         gSraiXe+AxdteKHip6riWhEmI6eTeD8vWFsp/exmwpXet9l98VJ7hcE1q5axWt7Uma+T
         zqdUFekwx0QnpwRBhr2u0D+2ZAkKQd1iThnalSJCia/ZL3BV9VFFRyO1OvM94WXlBW3v
         96ow==
X-Gm-Message-State: APjAAAVPqWjH7MOFqcrclHoYcNXsYaU6/IU5YFExZ3nf0GxXjpv6BLQI
        5BIysRLZ1C+OtmzUEjl7Tcd/Bc04GfodNxShQMRxBvqyqFI=
X-Google-Smtp-Source: APXvYqzFtC//8o4hHKWBW2TxQDgKkUqX0Y3MiQTUr764eJlAMQZ+PpVPxVjmvO+fnt3fUQyrjCPAPRL9f/03nk1FYH8=
X-Received: by 2002:a05:6638:a2c:: with SMTP id 12mr28835181jao.60.1575914671398;
 Mon, 09 Dec 2019 10:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-2-anarsoul@gmail.com>
 <CAEExFWtGcxevppy7yRHbcQSbMued_s_0u6FV6rT=fe+1AW=Jbg@mail.gmail.com>
 <20191128170626.xsm7xmizmbenqval@core.my.home> <CAEExFWt_c0gdwudf62JhT1et6SPXUEwE67KTdjtmk7fnSAcEiQ@mail.gmail.com>
 <20191202015816.amtz45fyd6h6pcqk@core.my.home>
In-Reply-To: <20191202015816.amtz45fyd6h6pcqk@core.my.home>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 10 Dec 2019 02:04:19 +0800
Message-ID: <CAEExFWvtSkFD0Oj8d13g9aJX35rtiEnJdtL9sHWCO0pF3Ba-Xg@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
To:     Frank Lee <tiny.windzz@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 2, 2019 at 9:58 AM Ond=C5=99ej Jirman <megous@megous.com> wrote=
:
>
> On Fri, Nov 29, 2019 at 07:46:58PM +0800, Frank Lee wrote:
> > On Fri, Nov 29, 2019 at 1:06 AM Ond=C5=99ej Jirman <megous@megous.com> =
wrote:
> > >
> > > On Fri, Nov 29, 2019 at 12:43:02AM +0800, Frank Lee wrote:
> > > > HI,
> > > >
> > > > I took a closer look at it, and I had some questions about these pl=
aces.
> > > >
> > > > On Wed, Nov 27, 2019 at 1:30 PM Vasily Khoruzhick <anarsoul@gmail.c=
om> wrote:
> > > > >
> > > > > From: Yangtao Li <tiny.windzz@gmail.com>
> > > > >
> > > > > This patch adds the support for allwinner thermal sensor, within
> > > > > allwinner SoC. It will register sensors for thermal framework
> > > > > and use device tree to bind cooling device.
> > > > >
> > > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > ---
> > > > >  MAINTAINERS                     |   7 +
> > > > >  drivers/thermal/Kconfig         |  14 +
> > > > >  drivers/thermal/Makefile        |   1 +
> > > > >  drivers/thermal/sun8i_thermal.c | 643 ++++++++++++++++++++++++++=
++++++
> > > > >  4 files changed, 665 insertions(+)
> > > > >  create mode 100644 drivers/thermal/sun8i_thermal.c
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 66cc549ac327..da34f3f2e80b 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -688,6 +688,13 @@ L: linux-crypto@vger.kernel.org
> > > > >  S:     Maintained
> > > > >  F:     drivers/crypto/allwinner/
> > > > >
> > > > > +ALLWINNER THERMAL DRIVER
> > > > > +M:     Yangtao Li <tiny.windzz@gmail.com>
> > > > > +L:     linux-pm@vger.kernel.org
> > > > > +S:     Maintained
> > > > > +F:     Documentation/devicetree/bindings/thermal/allwinner,sun8i=
-a83t-ths.yaml
> > > > > +F:     drivers/thermal/sun8i_thermal.c
> > > > > +
> > > > >  ALLWINNER VPU DRIVER
> > > > >  M:     Maxime Ripard <mripard@kernel.org>
> > > > >  M:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > > > index 001a21abcc28..0b0422e89adb 100644
> > > > > --- a/drivers/thermal/Kconfig
> > > > > +++ b/drivers/thermal/Kconfig
> > > > > @@ -262,6 +262,20 @@ config SPEAR_THERMAL
> > > > >           Enable this to plug the SPEAr thermal sensor driver int=
o the Linux
> > > > >           thermal framework.
> > > > >
> > > > > +config SUN8I_THERMAL
> > > > > +       tristate "Allwinner sun8i thermal driver"
> > > > > +       depends on ARCH_SUNXI || COMPILE_TEST
> > > > > +       depends on HAS_IOMEM
> > > > > +       depends on NVMEM
> > > > > +       depends on OF
> > > > > +       depends on RESET_CONTROLLER
> > > > > +       help
> > > > > +         Support for the sun8i thermal sensor driver into the Li=
nux thermal
> > > > > +         framework.
> > > > > +
> > > > > +         To compile this driver as a module, choose M here: the
> > > > > +         module will be called sun8i-thermal.
> > > > > +
> > > > >  config ROCKCHIP_THERMAL
> > > > >         tristate "Rockchip thermal driver"
> > > > >         depends on ARCH_ROCKCHIP || COMPILE_TEST
> > > > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > > > index 74a37c7f847a..fa6f8b206281 100644
> > > > > --- a/drivers/thermal/Makefile
> > > > > +++ b/drivers/thermal/Makefile
> > > > > @@ -31,6 +31,7 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devf=
req_cooling.o
> > > > >  obj-y                          +=3D broadcom/
> > > > >  obj-$(CONFIG_THERMAL_MMIO)             +=3D thermal_mmio.o
> > > > >  obj-$(CONFIG_SPEAR_THERMAL)    +=3D spear_thermal.o
> > > > > +obj-$(CONFIG_SUN8I_THERMAL)     +=3D sun8i_thermal.o
> > > > >  obj-$(CONFIG_ROCKCHIP_THERMAL) +=3D rockchip_thermal.o
> > > > >  obj-$(CONFIG_RCAR_THERMAL)     +=3D rcar_thermal.o
> > > > >  obj-$(CONFIG_RCAR_GEN3_THERMAL)        +=3D rcar_gen3_thermal.o
> > > > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/su=
n8i_thermal.c
> > > > > new file mode 100644
> > > > > index 000000000000..e86b64f51196
> > > > > --- /dev/null
> > > > > +++ b/drivers/thermal/sun8i_thermal.c
> > > > > @@ -0,0 +1,643 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Thermal sensor driver for Allwinner SOC
> > > > > + * Copyright (C) 2019 Yangtao Li
> > > > > + *
> > > > > + * Based on the work of Icenowy Zheng <icenowy@aosc.io>
> > > > > + * Based on the work of Ondrej Jirman <megous@megous.com>
> > > > > + * Based on the work of Josef Gajdusek <atx@atx.name>
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/nvmem-consumer.h>
> > > > > +#include <linux/of_device.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/regmap.h>
> > > > > +#include <linux/reset.h>
> > > > > +#include <linux/slab.h>
> > > > > +#include <linux/thermal.h>
> > > > > +
> > > > > +#define MAX_SENSOR_NUM 4
> > > > > +
> > > > > +#define FT_TEMP_MASK                           GENMASK(11, 0)
> > > > > +#define TEMP_CALIB_MASK                                GENMASK(1=
1, 0)
> > > > > +#define CALIBRATE_DEFAULT                      0x800
> > > > > +
> > > > > +#define SUN8I_THS_CTRL0                                0x00
> > > > > +#define SUN8I_THS_CTRL2                                0x40
> > > > > +#define SUN8I_THS_IC                           0x44
> > > > > +#define SUN8I_THS_IS                           0x48
> > > > > +#define SUN8I_THS_MFC                          0x70
> > > > > +#define SUN8I_THS_TEMP_CALIB                   0x74
> > > > > +#define SUN8I_THS_TEMP_DATA                    0x80
> > > > > +
> > > > > +#define SUN50I_THS_CTRL0                       0x00
> > > > > +#define SUN50I_H6_THS_ENABLE                   0x04
> > > > > +#define SUN50I_H6_THS_PC                       0x08
> > > > > +#define SUN50I_H6_THS_DIC                      0x10
> > > > > +#define SUN50I_H6_THS_DIS                      0x20
> > > > > +#define SUN50I_H6_THS_MFC                      0x30
> > > > > +#define SUN50I_H6_THS_TEMP_CALIB               0xa0
> > > > > +#define SUN50I_H6_THS_TEMP_DATA                        0xc0
> > > > > +
> > > > > +#define SUN8I_THS_CTRL0_T_ACQ0(x)              (GENMASK(15, 0) &=
 (x))
> > > > > +#define SUN8I_THS_CTRL2_T_ACQ1(x)              ((GENMASK(15, 0) =
& (x)) << 16)
> > > > > +#define SUN8I_THS_DATA_IRQ_STS(x)              BIT(x + 8)
> > > > > +
> > > > > +#define SUN50I_THS_CTRL0_T_ACQ(x)              ((GENMASK(15, 0) =
& (x)) << 16)
> > > > > +#define SUN50I_THS_FILTER_EN                   BIT(2)
> > > > > +#define SUN50I_THS_FILTER_TYPE(x)              (GENMASK(1, 0) & =
(x))
> > > > > +#define SUN50I_H6_THS_PC_TEMP_PERIOD(x)                ((GENMASK=
(19, 0) & (x)) << 12)
> > > > > +#define SUN50I_H6_THS_DATA_IRQ_STS(x)          BIT(x)
> > > > > +
> > > > > +/* millidegree celsius */
> > > > > +#define THS_EFUSE_CP_FT_MASK                   0x3000
> > > > > +#define THS_EFUSE_CP_FT_BIT                    12
> > > > > +#define THS_CALIBRATION_IN_FT                  1
> > > > > +
> > > > > +struct ths_device;
> > > > > +
> > > > > +struct tsensor {
> > > > > +       struct ths_device               *tmdev;
> > > > > +       struct thermal_zone_device      *tzd;
> > > > > +       int                             id;
> > > > > +};
> > > > > +
> > > > > +struct ths_thermal_chip {
> > > > > +       bool            has_mod_clk;
> > > > > +       bool            has_bus_clk_reset;
> > > > > +       int             sensor_num;
> > > > > +       int             offset;
> > > > > +       int             scale;
> > > > > +       int             ft_deviation;
> > > > > +       int             temp_data_base;
> > > > > +       int             (*calibrate)(struct ths_device *tmdev,
> > > > > +                                    u16 *caldata, int callen);
> > > > > +       int             (*init)(struct ths_device *tmdev);
> > > > > +       int             (*irq_ack)(struct ths_device *tmdev);
> > > > > +       int             (*calc_temp)(struct ths_device *tmdev,
> > > > > +                                    int id, int reg);
> > > > > +};
> > > > > +
> > > > > +struct ths_device {
> > > > > +       const struct ths_thermal_chip           *chip;
> > > > > +       struct device                           *dev;
> > > > > +       struct regmap                           *regmap;
> > > > > +       struct reset_control                    *reset;
> > > > > +       struct clk                              *bus_clk;
> > > > > +       struct clk                              *mod_clk;
> > > > > +       struct tsensor                          sensor[MAX_SENSOR=
_NUM];
> > > > > +       u32                                     cp_ft_flag;
> > > > > +};
> > > > > +
> > > > > +/* Temp Unit: millidegree Celsius */
> > > > > +static int sun8i_ths_calc_temp(struct ths_device *tmdev,
> > > > > +                              int id, int reg)
> > > > > +{
> > > > > +       return tmdev->chip->offset - (reg * tmdev->chip->scale / =
10);
> > > > > +}
> > > > > +
> > > > > +static int sun50i_h5_calc_temp(struct ths_device *tmdev,
> > > > > +                              int id, int reg)
> > > > > +{
> > > > > +       if (reg >=3D 0x500)
> > > > > +               return -1191 * reg / 10 + 223000;
> > > > > +       else if (!id)
> > > > > +               return -1452 * reg / 10 + 259000;
> > > > > +       else
> > > > > +               return -1590 * reg / 10 + 276000;
> > > > > +}
> > > > > +
> > > > > +static int sun8i_ths_get_temp(void *data, int *temp)
> > > > > +{
> > > > > +       struct tsensor *s =3D data;
> > > > > +       struct ths_device *tmdev =3D s->tmdev;
> > > > > +       int val =3D 0;
> > > > > +
> > > > > +       regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > > > > +                   0x4 * s->id, &val);
> > > > > +
> > > > > +       /* ths have no data yet */
> > > > > +       if (!val)
> > > > > +               return -EAGAIN;
> > > > > +
> > > > > +       *temp =3D tmdev->chip->calc_temp(tmdev, s->id, val);
> > > > > +       /*
> > > > > +        * According to the original sdk, there are some platform=
s(rarely)
> > > > > +        * that add a fixed offset value after calculating the te=
mperature
> > > > > +        * value. We can't simply put it on the formula for calcu=
lating the
> > > > > +        * temperature above, because the formula for calculating=
 the
> > > > > +        * temperature above is also used when the sensor is cali=
brated. If
> > > > > +        * do this, the correct calibration formula is hard to kn=
ow.
> > > > > +        */
> > > > > +       *temp +=3D tmdev->chip->ft_deviation;
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct thermal_zone_of_device_ops ths_ops =3D {
> > > > > +       .get_temp =3D sun8i_ths_get_temp,
> > > > > +};
> > > > > +
> > > > > +static const struct regmap_config config =3D {
> > > > > +       .reg_bits =3D 32,
> > > > > +       .val_bits =3D 32,
> > > > > +       .reg_stride =3D 4,
> > > > > +       .fast_io =3D true,
> > > > > +       .max_register =3D 0xfc,
> > > > > +};
> > > > > +
> > > > > +static int sun8i_h3_irq_ack(struct ths_device *tmdev)
> > > > > +{
> > > > > +       int i, state, ret =3D 0;
> > > > > +
> > > > > +       regmap_read(tmdev->regmap, SUN8I_THS_IS, &state);
> > > > > +
> > > > > +       for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > > > +               if (state & SUN8I_THS_DATA_IRQ_STS(i)) {
> > > > > +                       regmap_write(tmdev->regmap, SUN8I_THS_IS,
> > > > > +                                    SUN8I_THS_DATA_IRQ_STS(i));
> > > > > +                       ret |=3D BIT(i);
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static int sun50i_h6_irq_ack(struct ths_device *tmdev)
> > > > > +{
> > > > > +       int i, state, ret =3D 0;
> > > > > +
> > > > > +       regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
> > > > > +
> > > > > +       for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > > > +               if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
> > > > > +                       regmap_write(tmdev->regmap, SUN50I_H6_THS=
_DIS,
> > > > > +                                    SUN50I_H6_THS_DATA_IRQ_STS(i=
));
> > > > > +                       ret |=3D BIT(i);
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static irqreturn_t sun8i_irq_thread(int irq, void *data)
> > > > > +{
> > > > > +       struct ths_device *tmdev =3D data;
> > > > > +       int i, state;
> > > > > +
> > > > > +       state =3D tmdev->chip->irq_ack(tmdev);
> > > > > +
> > > > > +       for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > > > +               if (state & BIT(i))
> > > > > +                       thermal_zone_device_update(tmdev->sensor[=
i].tzd,
> > > > > +                                                  THERMAL_EVENT_=
UNSPECIFIED);
> > > > > +       }
> > > > > +
> > > > > +       return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +static int sun8i_h3_ths_calibrate(struct ths_device *tmdev,
> > > > > +                                 u16 *caldata, int callen)
> > > > > +{
> > > > > +       int i;
> > > > > +
> > > > > +       if (!caldata[0] || callen < 2 * tmdev->chip->sensor_num)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > > > +               int offset =3D (i % 2) << 4;
> > > > > +
> > > > > +               regmap_update_bits(tmdev->regmap,
> > > > > +                                  SUN8I_THS_TEMP_CALIB + (4 * (i=
 >> 1)),
> > > > > +                                  0xfff << offset,
> > > > > +                                  caldata[i] << offset);
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
> > > > > +                                  u16 *caldata, int callen)
> > > > > +{
> > > > > +       struct device *dev =3D tmdev->dev;
> > > > > +       int i, ft_temp;
> > > > > +
> > > > > +       if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_n=
um)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       /*
> > > > > +        * efuse layout:
> > > > > +        *
> > > > > +        *      0   11  16       32
> > > > > +        *      +-------+-------+-------+
> > > > > +        *      |temp|  |sensor0|sensor1|
> > > > > +        *      +-------+-------+-------+
> > > > > +        *
> > > > > +        * The calibration data on the H6 is the ambient temperat=
ure and
> > > > > +        * sensor values that are filled during the factory test =
stage.
> > > > > +        *
> > > > > +        * The unit of stored FT temperature is 0.1 degreee celus=
is.
> > > > > +        *
> > > > > +        * We need to calculate a delta between measured and calu=
clated
> > > > > +        * register values and this will become a calibration off=
set.
> > > > > +        */
> > > > > +       ft_temp =3D (caldata[0] & FT_TEMP_MASK) * 100;
> > > > > +       tmdev->cp_ft_flag =3D (caldata[0] & THS_EFUSE_CP_FT_MASK)
> > > > > +               >> THS_EFUSE_CP_FT_BIT;
> > > >
> > > > Here got an unused data "cp_ft_flag",
> > > > which is used in the calculation of the temperature function accord=
ing
> > > > to the source code.
> > > >
> > > > https://github.com/orangepi-xunlong/OrangePiH6_kernel/blob/master/d=
rivers/thermal/sunxi_thermal/sunxi_ths_core.c#L392
> > >
> > > It should be used to enable the addition of ft_deviation in
> > > sun8i_ths_get_temp(), I guess. Probably an ommission. I guess most of=
 H6
> > > chips will have this set anyway.
> > >
> > > > > +
> > > > > +       for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > > > +               int sensor_reg =3D caldata[i + 1];
> > > > > +               int cdata, offset;
> > > > > +               int sensor_temp =3D tmdev->chip->calc_temp(tmdev,=
 i, sensor_reg);
> > > > > +
> > > > > +               /*
> > > > > +                * Calibration data is CALIBRATE_DEFAULT - (calcu=
lated
> > > > > +                * temperature from sensor reading at factory tem=
perature
> > > > > +                * minus actual factory temperature) * 14.88 (sca=
le from
> > > > > +                * temperature to register values)
> > > > > +                */
> > > > > +               cdata =3D CALIBRATE_DEFAULT -
> > > > > +                       ((sensor_temp - ft_temp) * 10 / tmdev->ch=
ip->scale);
> > > >
> > > > Why change the formula here.
> > > >
> > > > https://github.com/orangepi-xunlong/OrangePiH6_kernel/blob/master/d=
rivers/thermal/sunxi_thermal/sunxi_ths_core.c#L339
> > >
> >
> > HI,
> >
> > I suggest keeping you as it was before this patch, just change this
> > place to this.
> >
> > cdata =3D CALIBRATE_DEFAULT - ((ft_temp * 100 - sensor_temp) /
> > tmdev->chip->scale);
>
> Hi,
>
> any reason for your suggestion? I also changed scale to be 10* specifical=
ly to
> allow it to be more precise when doing integer math, so that it more easi=
ly
> supports A83T's value. H6's scale value is also needlessly rounded too mu=
ch
> without this change. With your suggestion, I'd have to round A83T's scale=
 from
> 70.5 to either 70 or 71, but why?

The calculation result of this formula, due to the difference of the
chip, the temperature
will not be very accurate, with some deviations(May be a few degrees from a=
ctual
temperature). I'm not too keen to keep it exactly the same as the
original formula.
At this time rounding to 71, 70 may not cause the calculated
temperature difference too much.

Yours,
Yangtao

>
> regards,
>         o.
>
> > Yangtao
> >
> > > It looks the same to me as before. Here's the original patch:
> > >
> > > https://megous.com/git/linux/commit/?h=3Dths-5.4&id=3Dcae28a7dfa6fc79=
ba37e31d4dff281947247e822
> > >
> > > It's basicaly to avoid magic values TEMP_TO_REG and use what's define=
d
> > > in the chip struct.
> > >
> > > regards,
> > >         o.
> > >
> > > > > +               if (cdata & ~TEMP_CALIB_MASK) {
> > > > > +                       /*
> > > > > +                        * Calibration value more than 12-bit, bu=
t calibration
> > > > > +                        * register is 12-bit. In this case, ths =
hardware can
> > > > > +                        * still work without calibration, althou=
gh the data
> > > > > +                        * won't be so accurate.
> > > > > +                        */
> > > > > +                       dev_warn(dev, "sensor%d is not calibrated=
.\n", i);
> > > > > +                       continue;
> > > > > +               }
> > > > > +
> > > > > +               offset =3D (i % 2) * 16;
> > > > > +               regmap_update_bits(tmdev->regmap,
> > > > > +                                  SUN50I_H6_THS_TEMP_CALIB + (i =
/ 2 * 4),
> > > > > +                                  0xfff << offset,
> > > > > +                                  cdata << offset);
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int sun8i_ths_calibrate(struct ths_device *tmdev)
> > > > > +{
> > > > > +       struct nvmem_cell *calcell;
> > > > > +       struct device *dev =3D tmdev->dev;
> > > > > +       u16 *caldata;
> > > > > +       size_t callen;
> > > > > +       int ret =3D 0;
> > > > > +
> > > > > +       calcell =3D devm_nvmem_cell_get(dev, "calibration");
> > > > > +       if (IS_ERR(calcell)) {
> > > > > +               if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
> > > > > +                       return -EPROBE_DEFER;
> > > > > +               /*
> > > > > +                * Even if the external calibration data stored i=
n sid is
> > > > > +                * not accessible, the THS hardware can still wor=
k, although
> > > > > +                * the data won't be so accurate.
> > > > > +                *
> > > > > +                * The default value of calibration register is 0=
x800 for
> > > > > +                * every sensor, and the calibration value is usu=
ally 0x7xx
> > > > > +                * or 0x8xx, so they won't be away from the defau=
lt value
> > > > > +                * for a lot.
> > > > > +                *
> > > > > +                * So here we do not return error if the calibart=
ion data is
> > > > > +                * not available, except the probe needs deferrin=
g.
> > > > > +                */
> > > > > +               goto out;
> > > > > +       }
> > > > > +
> > > > > +       caldata =3D nvmem_cell_read(calcell, &callen);
> > > > > +       if (IS_ERR(caldata)) {
> > > > > +               ret =3D PTR_ERR(caldata);
> > > > > +               goto out;
> > > > > +       }
> > > > > +
> > > > > +       tmdev->chip->calibrate(tmdev, caldata, callen);
> > > > > +
> > > > > +       kfree(caldata);
> > > > > +out:
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static int sun8i_ths_resource_init(struct ths_device *tmdev)
> > > > > +{
> > > > > +       struct device *dev =3D tmdev->dev;
> > > > > +       struct platform_device *pdev =3D to_platform_device(dev);
> > > > > +       struct resource *mem;
> > > > > +       void __iomem *base;
> > > > > +       int ret;
> > > > > +
> > > > > +       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > +       base =3D devm_ioremap_resource(dev, mem);
> > > > > +       if (IS_ERR(base))
> > > > > +               return PTR_ERR(base);
> > > > > +
> > > > > +       tmdev->regmap =3D devm_regmap_init_mmio(dev, base, &confi=
g);
> > > > > +       if (IS_ERR(tmdev->regmap))
> > > > > +               return PTR_ERR(tmdev->regmap);
> > > > > +
> > > > > +       if (tmdev->chip->has_bus_clk_reset) {
> > > > > +               tmdev->reset =3D devm_reset_control_get(dev, 0);
> > > > > +               if (IS_ERR(tmdev->reset))
> > > > > +                       return PTR_ERR(tmdev->reset);
> > > > > +
> > > > > +               tmdev->bus_clk =3D devm_clk_get(&pdev->dev, "bus"=
);
> > > > > +               if (IS_ERR(tmdev->bus_clk))
> > > > > +                       return PTR_ERR(tmdev->bus_clk);
> > > > > +       }
> > > > > +
> > > > > +       if (tmdev->chip->has_mod_clk) {
> > > > > +               tmdev->mod_clk =3D devm_clk_get(&pdev->dev, "mod"=
);
> > > > > +               if (IS_ERR(tmdev->mod_clk))
> > > > > +                       return PTR_ERR(tmdev->mod_clk);
> > > > > +       }
> > > > > +
> > > > > +       ret =3D reset_control_deassert(tmdev->reset);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       ret =3D clk_prepare_enable(tmdev->bus_clk);
> > > > > +       if (ret)
> > > > > +               goto assert_reset;
> > > > > +
> > > > > +       ret =3D clk_set_rate(tmdev->mod_clk, 24000000);
> > > > > +       if (ret)
> > > > > +               goto bus_disable;
> > > > > +
> > > > > +       ret =3D clk_prepare_enable(tmdev->mod_clk);
> > > > > +       if (ret)
> > > > > +               goto bus_disable;
> > > > > +
> > > > > +       ret =3D sun8i_ths_calibrate(tmdev);
> > > > > +       if (ret)
> > > > > +               goto mod_disable;
> > > > > +
> > > > > +       return 0;
> > > > > +
> > > > > +mod_disable:
> > > > > +       clk_disable_unprepare(tmdev->mod_clk);
> > > > > +bus_disable:
> > > > > +       clk_disable_unprepare(tmdev->bus_clk);
> > > > > +assert_reset:
> > > > > +       reset_control_assert(tmdev->reset);
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static int sun8i_h3_thermal_init(struct ths_device *tmdev)
> > > > > +{
> > > > > +       int val;
> > > > > +
> > > > > +       /* average over 4 samples */
> > > > > +       regmap_write(tmdev->regmap, SUN8I_THS_MFC,
> > > > > +                    SUN50I_THS_FILTER_EN |
> > > > > +                    SUN50I_THS_FILTER_TYPE(1));
> > > > > +       /*
> > > > > +        * clkin =3D 24MHz
> > > > > +        * filter_samples =3D 4
> > > > > +        * period =3D 0.25s
> > > > > +        *
> > > > > +        * x =3D period * clkin / 4096 / filter_samples - 1
> > > > > +        *   =3D 365
> > > > > +        */
> > > > > +       val =3D GENMASK(7 + tmdev->chip->sensor_num, 8);
> > > > > +       regmap_write(tmdev->regmap, SUN8I_THS_IC,
> > > > > +                    SUN50I_H6_THS_PC_TEMP_PERIOD(365) | val);
> > > > > +       /*
> > > > > +        * T_acq =3D 20us
> > > > > +        * clkin =3D 24MHz
> > > > > +        *
> > > > > +        * x =3D T_acq * clkin - 1
> > > > > +        *   =3D 479
> > > > > +        */
> > > > > +       regmap_write(tmdev->regmap, SUN8I_THS_CTRL0,
> > > > > +                    SUN8I_THS_CTRL0_T_ACQ0(479));
> > > > > +       val =3D GENMASK(tmdev->chip->sensor_num - 1, 0);
> > > > > +       regmap_write(tmdev->regmap, SUN8I_THS_CTRL2,
> > > > > +                    SUN8I_THS_CTRL2_T_ACQ1(479) | val);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Without this undocummented value, the returned temperatures w=
ould
> > > > > + * be higher than real ones by about 20C.
> > > > > + */
> > > > > +#define SUN50I_H6_CTRL0_UNK 0x0000002f
> > > > > +
> > > > > +static int sun50i_h6_thermal_init(struct ths_device *tmdev)
> > > > > +{
> > > > > +       int val;
> > > > > +
> > > > > +       /*
> > > > > +        * T_acq =3D 20us
> > > > > +        * clkin =3D 24MHz
> > > > > +        *
> > > > > +        * x =3D T_acq * clkin - 1
> > > > > +        *   =3D 479
> > > > > +        */
> > > > > +       regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> > > > > +                    SUN50I_H6_CTRL0_UNK | SUN50I_THS_CTRL0_T_ACQ=
(479));
> > > > > +       /* average over 4 samples */
> > > > > +       regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> > > > > +                    SUN50I_THS_FILTER_EN |
> > > > > +                    SUN50I_THS_FILTER_TYPE(1));
> > > > > +       /*
> > > > > +        * clkin =3D 24MHz
> > > > > +        * filter_samples =3D 4
> > > > > +        * period =3D 0.25s
> > > > > +        *
> > > > > +        * x =3D period * clkin / 4096 / filter_samples - 1
> > > > > +        *   =3D 365
> > > > > +        */
> > > > > +       regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> > > > > +                    SUN50I_H6_THS_PC_TEMP_PERIOD(365));
> > > > > +       /* enable sensor */
> > > > > +       val =3D GENMASK(tmdev->chip->sensor_num - 1, 0);
> > > > > +       regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
> > > > > +       /* thermal data interrupt enable */
> > > > > +       val =3D GENMASK(tmdev->chip->sensor_num - 1, 0);
> > > > > +       regmap_write(tmdev->regmap, SUN50I_H6_THS_DIC, val);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int sun8i_ths_register(struct ths_device *tmdev)
> > > > > +{
> > > > > +       int i;
> > > > > +
> > > > > +       for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> > > > > +               tmdev->sensor[i].tmdev =3D tmdev;
> > > > > +               tmdev->sensor[i].id =3D i;
> > > > > +               tmdev->sensor[i].tzd =3D
> > > > > +                       devm_thermal_zone_of_sensor_register(tmde=
v->dev,
> > > > > +                                                            i,
> > > > > +                                                            &tmd=
ev->sensor[i],
> > > > > +                                                            &ths=
_ops);
> > > > > +               if (IS_ERR(tmdev->sensor[i].tzd))
> > > > > +                       return PTR_ERR(tmdev->sensor[i].tzd);
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int sun8i_ths_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct ths_device *tmdev;
> > > > > +       struct device *dev =3D &pdev->dev;
> > > > > +       int ret, irq;
> > > > > +
> > > > > +       tmdev =3D devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > > > > +       if (!tmdev)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       tmdev->dev =3D dev;
> > > > > +       tmdev->chip =3D of_device_get_match_data(&pdev->dev);
> > > > > +       if (!tmdev->chip)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       platform_set_drvdata(pdev, tmdev);
> > > > > +
> > > > > +       ret =3D sun8i_ths_resource_init(tmdev);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       irq =3D platform_get_irq(pdev, 0);
> > > > > +       if (irq < 0)
> > > > > +               return irq;
> > > > > +
> > > > > +       ret =3D tmdev->chip->init(tmdev);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       ret =3D sun8i_ths_register(tmdev);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       /*
> > > > > +        * Avoid entering the interrupt handler, the thermal devi=
ce is not
> > > > > +        * registered yet, we deffer the registration of the inte=
rrupt to
> > > > > +        * the end.
> > > > > +        */
> > > > > +       ret =3D devm_request_threaded_irq(dev, irq, NULL,
> > > > > +                                       sun8i_irq_thread,
> > > > > +                                       IRQF_ONESHOT, "ths", tmde=
v);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static int sun8i_ths_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct ths_device *tmdev =3D platform_get_drvdata(pdev);
> > > > > +
> > > > > +       clk_disable_unprepare(tmdev->mod_clk);
> > > > > +       clk_disable_unprepare(tmdev->bus_clk);
> > > > > +       reset_control_assert(tmdev->reset);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct ths_thermal_chip sun8i_a83t_ths =3D {
> > > > > +       .sensor_num =3D 3,
> > > > > +       .scale =3D 705,
> > > > > +       .offset =3D 191668,
> > > > > +       .temp_data_base =3D SUN8I_THS_TEMP_DATA,
> > > > > +       .calibrate =3D sun8i_h3_ths_calibrate,
> > > > > +       .init =3D sun8i_h3_thermal_init,
> > > > > +       .irq_ack =3D sun8i_h3_irq_ack,
> > > > > +       .calc_temp =3D sun8i_ths_calc_temp,
> > > > > +};
> > > > > +
> > > > > +static const struct ths_thermal_chip sun8i_h3_ths =3D {
> > > > > +       .sensor_num =3D 1,
> > > > > +       .scale =3D 1211,
> > > > > +       .offset =3D 217000,
> > > > > +       .has_mod_clk =3D true,
> > > > > +       .has_bus_clk_reset =3D true,
> > > > > +       .temp_data_base =3D SUN8I_THS_TEMP_DATA,
> > > > > +       .calibrate =3D sun8i_h3_ths_calibrate,
> > > > > +       .init =3D sun8i_h3_thermal_init,
> > > > > +       .irq_ack =3D sun8i_h3_irq_ack,
> > > > > +       .calc_temp =3D sun8i_ths_calc_temp,
> > > > > +};
> > > > > +
> > > > > +static const struct ths_thermal_chip sun8i_r40_ths =3D {
> > > > > +       .sensor_num =3D 3,
> > > > > +       .offset =3D 251086,
> > > > > +       .scale =3D 1130,
> > > > > +       .has_mod_clk =3D true,
> > > > > +       .has_bus_clk_reset =3D true,
> > > > > +       .temp_data_base =3D SUN8I_THS_TEMP_DATA,
> > > > > +       .calibrate =3D sun8i_h3_ths_calibrate,
> > > > > +       .init =3D sun8i_h3_thermal_init,
> > > > > +       .irq_ack =3D sun8i_h3_irq_ack,
> > > > > +       .calc_temp =3D sun8i_ths_calc_temp,
> > > > > +};
> > > > > +
> > > > > +static const struct ths_thermal_chip sun50i_a64_ths =3D {
> > > > > +       .sensor_num =3D 3,
> > > > > +       .offset =3D 253890,
> > > > > +       .scale =3D 1170,
> > > > > +       .has_mod_clk =3D true,
> > > > > +       .has_bus_clk_reset =3D true,
> > > > > +       .temp_data_base =3D SUN8I_THS_TEMP_DATA,
> > > > > +       .calibrate =3D sun8i_h3_ths_calibrate,
> > > > > +       .init =3D sun8i_h3_thermal_init,
> > > > > +       .irq_ack =3D sun8i_h3_irq_ack,
> > > > > +       .calc_temp =3D sun8i_ths_calc_temp,
> > > > > +};
> > > > > +
> > > > > +static const struct ths_thermal_chip sun50i_h5_ths =3D {
> > > > > +       .sensor_num =3D 2,
> > > > > +       .has_mod_clk =3D true,
> > > > > +       .has_bus_clk_reset =3D true,
> > > > > +       .temp_data_base =3D SUN8I_THS_TEMP_DATA,
> > > > > +       .calibrate =3D sun8i_h3_ths_calibrate,
> > > > > +       .init =3D sun8i_h3_thermal_init,
> > > > > +       .irq_ack =3D sun8i_h3_irq_ack,
> > > > > +       .calc_temp =3D sun50i_h5_calc_temp,
> > > > > +};
> > > > > +
> > > > > +static const struct ths_thermal_chip sun50i_h6_ths =3D {
> > > > > +       .sensor_num =3D 2,
> > > > > +       .has_bus_clk_reset =3D true,
> > > > > +       .ft_deviation =3D 7000,
> > > > > +       .offset =3D 187744,
> > > > > +       .scale =3D 672,
> > > > > +       .temp_data_base =3D SUN50I_H6_THS_TEMP_DATA,
> > > > > +       .calibrate =3D sun50i_h6_ths_calibrate,
> > > > > +       .init =3D sun50i_h6_thermal_init,
> > > > > +       .irq_ack =3D sun50i_h6_irq_ack,
> > > > > +       .calc_temp =3D sun8i_ths_calc_temp,
> > > > > +};
> > > > > +
> > > > > +static const struct of_device_id of_ths_match[] =3D {
> > > > > +       { .compatible =3D "allwinner,sun8i-a83t-ths", .data =3D &=
sun8i_a83t_ths },
> > > > > +       { .compatible =3D "allwinner,sun8i-h3-ths", .data =3D &su=
n8i_h3_ths },
> > > > > +       { .compatible =3D "allwinner,sun8i-r40-ths", .data =3D &s=
un8i_r40_ths },
> > > > > +       { .compatible =3D "allwinner,sun50i-a64-ths", .data =3D &=
sun50i_a64_ths },
> > > > > +       { .compatible =3D "allwinner,sun50i-h5-ths", .data =3D &s=
un50i_h5_ths },
> > > > > +       { .compatible =3D "allwinner,sun50i-h6-ths", .data =3D &s=
un50i_h6_ths },
> > > > > +       { /* sentinel */ },
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, of_ths_match);
> > > > > +
> > > > > +static struct platform_driver ths_driver =3D {
> > > > > +       .probe =3D sun8i_ths_probe,
> > > > > +       .remove =3D sun8i_ths_remove,
> > > > > +       .driver =3D {
> > > > > +               .name =3D "sun8i-thermal",
> > > > > +               .of_match_table =3D of_ths_match,
> > > > > +       },
> > > > > +};
> > > > > +module_platform_driver(ths_driver);
> > > > > +
> > > > > +MODULE_DESCRIPTION("Thermal sensor driver for Allwinner SOC");
> > > > > +MODULE_LICENSE("GPL v2");
> > > > > --
> > > > > 2.24.0
> > > > >
> > > >
> > > > Thx,
> > > > Yangtao
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
