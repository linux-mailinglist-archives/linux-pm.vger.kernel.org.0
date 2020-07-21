Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F622890A
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 21:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgGUTWM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgGUTWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 15:22:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B09CC061794;
        Tue, 21 Jul 2020 12:22:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so22312621wrs.0;
        Tue, 21 Jul 2020 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=FoHnD9SjK5CBLRCMFvn08nnEbMfgFJ4R38W+MLAf1DE=;
        b=KD74ey/uh7rpEwluS08Ysg7rMzloVUJI2oN5zD2G+BG0GI1dZevFLyBy+EJ1tq33Cx
         gu1Rx1Qyja26XMJKsc2+FX4vGaOspbAwth4oAlvorEn0a4/CCUZngRNu0X7JFmk22iTo
         SpobUPrF3/gkNcDLOu0kr/8/yfO1rQxVcPPnfOm7hzkik4OBk+UvYs6Y0br8tmAqTANP
         USZa5c9EqxHebaAIkk6GXdkj1XuIoq4AZoa10JdkXNpQmKRV1uHzbwkJhNpc+FIQWvj5
         h7imtUfCzyECVCK1EcViRcMXCw1+xlAKIkgI1x0JuxHU/ANJvHO7awcbXkFvlZr5UdMt
         1fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=FoHnD9SjK5CBLRCMFvn08nnEbMfgFJ4R38W+MLAf1DE=;
        b=HhJXsLdp7cWp+ym2G/hde+lGk83WIBNOwWDcTJpHWpWdqX1jPD1JuAvElYyzTMbIpQ
         +Tu2BzeTwQuMpt0d6fkMGzjE0MyDj1NuCGeoT8tgG/ayaFcU9pANtcP5gmfGSgsQRw8A
         smQB4RAyivBL3veWqcJJCIKL3SdPg2lY2EUGDrDq70KjqkIryPVM5rZRGC7XHrEZXU4Q
         MczA7eiIg1+VlgJf448GLr1VxHmG0NBzLWFP1flOLXxp1DHJCKZHwaouZ3mTBLKWBZNq
         vUT2Q8YNv6+whwfzaRtI8AHuqOJM/9J9q87eNt6p26EbAWCvVVm4xbzh6etmRC6ILoKf
         bF3w==
X-Gm-Message-State: AOAM533O4wZQRavwwof0qnEFB+JUmwYMP6wbjoAW1SeZ+a7rzqD65dQH
        yipimfFMSujEJCfrop0CphE=
X-Google-Smtp-Source: ABdhPJy+phklsh49TF2wsaE+u5gsZ4lO7RTicHDHDd7Ets/tzTjbtErJ2SooHMQx9ilcFw+iQ0bn7g==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr15279739wrb.53.1595359329845;
        Tue, 21 Jul 2020 12:22:09 -0700 (PDT)
Received: from AnsuelXPS (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.gmail.com with ESMTPSA id s15sm4962749wmj.41.2020.07.21.12.22.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:22:09 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Amit Kucheria'" <amit.kucheria@linaro.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Zhang Rui'" <rui.zhang@intel.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        "'Linux PM list'" <linux-pm@vger.kernel.org>,
        "'linux-arm-msm'" <linux-arm-msm@vger.kernel.org>,
        "'DTML'" <devicetree@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'linux-clk'" <linux-clk@vger.kernel.org>
References: <20200716022817.30439-1-ansuelsmth@gmail.com> <20200716022817.30439-6-ansuelsmth@gmail.com> <CAP245DUGM7BgNvBEXvgA6xFiNr0a4BFhSorYwkyRDN5r99y=8w@mail.gmail.com>
In-Reply-To: <CAP245DUGM7BgNvBEXvgA6xFiNr0a4BFhSorYwkyRDN5r99y=8w@mail.gmail.com>
Subject: R: [PATCH v4 5/7] drivers: thermal: tsens: add interrupt support for 9860 driver
Date:   Tue, 21 Jul 2020 21:22:06 +0200
Message-ID: <006001d65f94$39e5d350$adb179f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHD+Sy6OmkuDb4Sao9CLBNDWRTt2wI15zSEAdo/l8epFrQeMA==
Content-Language: it
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Messaggio originale-----
> Da: Amit Kucheria <amit.kucheria@linaro.org>
> Inviato: luned=C3=AC 20 luglio 2020 11:41
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Andy Gross <agross@kernel.org>;
> Bjorn Andersson <bjorn.andersson@linaro.org>; Zhang Rui
> <rui.zhang@intel.com>; Daniel Lezcano <daniel.lezcano@linaro.org>;
> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Linux PM list <linux-pm@vger.kernel.org>; =
linux-arm-
> msm <linux-arm-msm@vger.kernel.org>; DTML
> <devicetree@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-clk <linux-clk@vger.kernel.org>
> Oggetto: Re: [PATCH v4 5/7] drivers: thermal: tsens: add interrupt =
support
> for 9860 driver
>=20
> Hi Ansuel,
>=20
> Thanks for this patch.
>=20
> On Thu, Jul 16, 2020 at 7:58 AM Ansuel Smith <ansuelsmth@gmail.com>
> wrote:
> >
> > Add interrupt support for 9860 tsens driver used to set thermal trip
> > point for the system.
>=20
> typo: 8960
>=20
> You've used the names 8960 and ipq8064 interchangeably throughout the
> series. AFAICT, msm8960, ipq8064 and apq8064 use the same IP version
> of tsens. Please use 8960 in all patches, descriptions and dt-binding.
> to reflect the filename for the driver.
> Then add ipq8064 and apq8064 in a comment in the driver like here to
> show that the driver also supports these other SoCs:
> https://elixir.bootlin.com/linux/v5.8-
> rc4/source/drivers/thermal/qcom/tsens-v0_1.c#L328
>=20
> You can also add a new compatible string for ipq8064 as a separate
> patch at the end of the series.
>=20
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/thermal/qcom/tsens-8960.c | 197
> +++++++++++++++++++++++++++---
> >  drivers/thermal/qcom/tsens.h      |   3 +
> >  2 files changed, 186 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-8960.c
> b/drivers/thermal/qcom/tsens-8960.c
> > index 45788eb3c666..20d0bfb10f1f 100644
> > --- a/drivers/thermal/qcom/tsens-8960.c
> > +++ b/drivers/thermal/qcom/tsens-8960.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bitops.h>
> >  #include <linux/regmap.h>
> >  #include <linux/mfd/syscon.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/thermal.h>
> >  #include "tsens.h"
> >
> > @@ -27,7 +28,6 @@
> >  /* CNTL_ADDR bitmasks */
> >  #define EN                     BIT(0)
> >  #define SW_RST                 BIT(1)
> > -#define SENSOR0_EN             BIT(3)
> >  #define SLP_CLK_ENA            BIT(26)
> >  #define SLP_CLK_ENA_8660       BIT(24)
> >  #define MEASURE_PERIOD         1
> > @@ -41,14 +41,26 @@
> >
> >  #define THRESHOLD_ADDR         0x3624
> >  /* THRESHOLD_ADDR bitmasks */
> > +#define THRESHOLD_MAX_CODE             0x20000
> > +#define THRESHOLD_MIN_CODE             0
> >  #define THRESHOLD_MAX_LIMIT_SHIFT      24
> >  #define THRESHOLD_MIN_LIMIT_SHIFT      16
> >  #define THRESHOLD_UPPER_LIMIT_SHIFT    8
> >  #define THRESHOLD_LOWER_LIMIT_SHIFT    0
> > +#define THRESHOLD_MAX_LIMIT_MASK       (THRESHOLD_MAX_CODE
> << \
> > +                                               =
THRESHOLD_MAX_LIMIT_SHIFT)
> > +#define THRESHOLD_MIN_LIMIT_MASK       (THRESHOLD_MAX_CODE <<
> \
> > +                                               =
THRESHOLD_MIN_LIMIT_SHIFT)
> > +#define THRESHOLD_UPPER_LIMIT_MASK     (THRESHOLD_MAX_CODE
> << \
> > +                                               =
THRESHOLD_UPPER_LIMIT_SHIFT)
> > +#define THRESHOLD_LOWER_LIMIT_MASK     (THRESHOLD_MAX_CODE
> << \
> > +                                               =
THRESHOLD_LOWER_LIMIT_SHIFT)
> >
> >  /* Initial temperature threshold values */
> > -#define LOWER_LIMIT_TH         0x50
> > -#define UPPER_LIMIT_TH         0xdf
> > +#define LOWER_LIMIT_TH_8960    0x50
> > +#define UPPER_LIMIT_TH_8960    0xdf
> > +#define LOWER_LIMIT_TH_8064    0x9d /* 95C */
> > +#define UPPER_LIMIT_TH_8064    0xa6 /* 105C */
> >  #define MIN_LIMIT_TH           0x0
> >  #define MAX_LIMIT_TH           0xff
> >
> > @@ -57,6 +69,170 @@
> >  #define TRDY_MASK              BIT(7)
> >  #define TIMEOUT_US             100
> >
> > +#define TSENS_EN               BIT(0)
> > +#define TSENS_SW_RST           BIT(1)
> > +#define TSENS_ADC_CLK_SEL      BIT(2)
> > +#define SENSOR0_EN             BIT(3)
> > +#define SENSOR1_EN             BIT(4)
> > +#define SENSOR2_EN             BIT(5)
> > +#define SENSOR3_EN             BIT(6)
> > +#define SENSOR4_EN             BIT(7)
> > +#define SENSORS_EN             (SENSOR0_EN | SENSOR1_EN | \
> > +                               SENSOR2_EN | SENSOR3_EN | =
SENSOR4_EN)
> > +#define TSENS_8064_SENSOR5_EN                          BIT(8)
> > +#define TSENS_8064_SENSOR6_EN                          BIT(9)
> > +#define TSENS_8064_SENSOR7_EN                          BIT(10)
> > +#define TSENS_8064_SENSOR8_EN                          BIT(11)
> > +#define TSENS_8064_SENSOR9_EN                          BIT(12)
> > +#define TSENS_8064_SENSOR10_EN                         BIT(13)
> > +#define TSENS_8064_SENSORS_EN                          (SENSORS_EN =
| \
> > +                                               =
TSENS_8064_SENSOR5_EN | \
> > +                                               =
TSENS_8064_SENSOR6_EN | \
> > +                                               =
TSENS_8064_SENSOR7_EN | \
> > +                                               =
TSENS_8064_SENSOR8_EN | \
> > +                                               =
TSENS_8064_SENSOR9_EN | \
> > +                                               =
TSENS_8064_SENSOR10_EN)
> > +
> > +u32 tsens_8960_slope[] =3D {
> > +                       1176, 1176, 1154, 1176,
> > +                       1111, 1132, 1132, 1199,
> > +                       1132, 1199, 1132
> > +                       };
> > +
> > +/* Temperature on y axis and ADC-code on x-axis */
> > +static inline int code_to_mdegC(u32 adc_code, const struct
> tsens_sensor *s)
> > +{
> > +       int slope, offset;
> > +
> > +       slope =3D thermal_zone_get_slope(s->tzd);
> > +       offset =3D CAL_MDEGC - slope * s->offset;
> > +
> > +       return adc_code * slope + offset;
> > +}
> > +
> > +static void notify_uspace_tsens_fn(struct work_struct *work)
> > +{
> > +       struct tsens_sensor *s =3D container_of(work, struct =
tsens_sensor,
> > +                                                               =
notify_work);
> > +
> > +       sysfs_notify(&s->tzd->device.kobj, NULL, "type");
> > +}
> > +
> > +static void tsens_scheduler_fn(struct work_struct *work)
> > +{
> > +       struct tsens_priv *priv =3D
> > +               container_of(work, struct tsens_priv, tsens_work);
> > +       unsigned int threshold, threshold_low, code, reg, sensor;
> > +       unsigned long mask;
> > +       bool upper_th_x, lower_th_x;
> > +       int ret;
> > +
> > +       ret =3D regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064,
> &reg);
> > +       if (ret)
> > +               return;
> > +       reg =3D reg | LOWER_STATUS_CLR | UPPER_STATUS_CLR;
> > +       ret =3D regmap_write(priv->tm_map, STATUS_CNTL_ADDR_8064, =
reg);
> > +       if (ret)
> > +               return;
> > +
> > +       mask =3D ~(LOWER_STATUS_CLR | UPPER_STATUS_CLR);
> > +       ret =3D regmap_read(priv->tm_map, THRESHOLD_ADDR, =
&threshold);
> > +       if (ret)
> > +               return;
> > +       threshold_low =3D (threshold & THRESHOLD_LOWER_LIMIT_MASK) =
>>
> > +                       THRESHOLD_LOWER_LIMIT_SHIFT;
> > +       threshold =3D (threshold & THRESHOLD_UPPER_LIMIT_MASK) >>
> > +                   THRESHOLD_UPPER_LIMIT_SHIFT;
> > +
> > +       ret =3D regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064,
> &reg);
> > +       if (ret)
> > +               return;
> > +
> > +       ret =3D regmap_read(priv->tm_map, CNTL_ADDR, &sensor);
> > +       if (ret)
> > +               return;
> > +       sensor &=3D (uint32_t)TSENS_8064_SENSORS_EN;
> > +       sensor >>=3D SENSOR0_SHIFT;
> > +
> > +       /* Constraint: There is only 1 interrupt control register =
for all
> > +        * 11 temperature sensor. So monitoring more than 1 sensor =
based
> > +        * on interrupts will yield inconsistent result. To overcome =
this
> > +        * issue we will monitor only sensor 0 which is the master =
sensor.
> > +        */
> > +
> > +       /* Skip if the sensor is disabled */
> > +       if (sensor & 1) {
> > +               ret =3D regmap_read(priv->tm_map, =
priv->sensor[0].status,
> &code);
> > +               if (ret)
> > +                       return;
> > +               upper_th_x =3D code >=3D threshold;
> > +               lower_th_x =3D code <=3D threshold_low;
> > +               if (upper_th_x)
> > +                       mask |=3D UPPER_STATUS_CLR;
> > +               if (lower_th_x)
> > +                       mask |=3D LOWER_STATUS_CLR;
> > +               if (upper_th_x || lower_th_x) {
> > +                       /* Notify user space */
> > +                       schedule_work(&priv->sensor[0].notify_work);
> > +                       pr_debug("Trigger (%d degrees) for sensor =
%d\n",
> > +                                code_to_mdegC(code, =
&priv->sensor[0]), 0);
> > +               }
> > +       }
> > +       regmap_write(priv->tm_map, STATUS_CNTL_ADDR_8064, reg &
> mask);
> > +}
> > +
> > +static irqreturn_t tsens_isr(int irq, void *data)
> > +{
> > +       struct tsens_priv *priv =3D data;
> > +
> > +       schedule_work(&priv->tsens_work);
> > +       return IRQ_HANDLED;
>=20
>=20
> Have you considered trying to reuse the regmap and interrupt handling
> infrastructure in tsens.c that I used to convert over everything after
> IP version 0.1?
>=20
> I started converting over 8960 but never managed to finish testing
> this[1]. I'd be happy for you to take this over and get it working so
> the 8960 doesn't end up being a completely separate driver from the
> other platforms.
>=20
> [1]
> =
https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=3Dwrk3/tsen=
s-
> 8960-breakage
>=20

Thanks a lot for the link. I started doing some test and I think the =
only general
code we will be able to use will be the init_common. The get temp and=20
the function to convert code to decg are very different from the one =
used in=20
8960.  Do you think keep a custom get temp function is good or not?


> > +}
> > +
> > +static void hw_init(struct tsens_priv *priv)
> > +{
> > +       int ret;
> > +       unsigned int reg_cntl =3D 0, reg_cfg =3D 0, reg_thr =3D 0;
> > +       unsigned int reg_status_cntl =3D 0;
> > +
> > +       regmap_read(priv->tm_map, CNTL_ADDR, &reg_cntl);
> > +       regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl |
> TSENS_SW_RST);
> > +
> > +       reg_cntl |=3D SLP_CLK_ENA | (MEASURE_PERIOD << 18) |
> > +                   (((1 << priv->num_sensors) - 1) << =
SENSOR0_SHIFT);
> > +       regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
> > +       regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064,
> &reg_status_cntl);
> > +       reg_status_cntl |=3D LOWER_STATUS_CLR | UPPER_STATUS_CLR |
> > +                          MIN_STATUS_MASK | MAX_STATUS_MASK;
> > +       regmap_write(priv->tm_map, STATUS_CNTL_ADDR_8064,
> reg_status_cntl);
> > +       reg_cntl |=3D TSENS_EN;
> > +       regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
> > +
> > +       regmap_read(priv->tm_map, CONFIG_ADDR, &reg_cfg);
> > +       if (priv->num_sensors > 1)
> > +               reg_cfg =3D (reg_cfg & ~CONFIG_MASK) | CONFIG;
> > +       else
> > +               reg_cfg =3D (reg_cfg & ~CONFIG_MASK) |
> > +                         (CONFIG << CONFIG_SHIFT_8660);
> > +       regmap_write(priv->tm_map, CONFIG_ADDR, reg_cfg);
> > +
> > +       reg_thr |=3D (LOWER_LIMIT_TH_8064 <<
> THRESHOLD_LOWER_LIMIT_SHIFT) |
> > +                  (UPPER_LIMIT_TH_8064 << =
THRESHOLD_UPPER_LIMIT_SHIFT)
> |
> > +                  (MIN_LIMIT_TH << THRESHOLD_MIN_LIMIT_SHIFT) |
> > +                  (MAX_LIMIT_TH << THRESHOLD_MAX_LIMIT_SHIFT);
> > +
> > +       regmap_write(priv->tm_map, THRESHOLD_ADDR, reg_thr);
> > +
> > +       ret =3D devm_request_irq(priv->dev, priv->tsens_irq, =
tsens_isr,
> > +                              IRQF_TRIGGER_RISING, =
"tsens_interrupt", priv);
> > +       if (ret < 0) {
> > +               dev_err(priv->dev, "request_irq FAIL: %d", ret);
> > +               return;
> > +       }
> > +
> > +       INIT_WORK(&priv->tsens_work, tsens_scheduler_fn);
> > +}
> > +
> >  static int suspend_8960(struct tsens_priv *priv)
> >  {
> >         int ret;
> > @@ -191,6 +367,8 @@ static int init_8960(struct tsens_priv *priv)
> >                 if (i >=3D 5)
> >                         priv->sensor[i].status =3D S0_STATUS_ADDR + =
40;
> >                 priv->sensor[i].status +=3D i * 4;
> > +               priv->sensor[i].slope =3D tsens_8960_slope[i];
> > +               INIT_WORK(&priv->sensor[i].notify_work,
> notify_uspace_tsens_fn);
> >         }
> >
> >         reg_cntl =3D SW_RST;
> > @@ -241,18 +419,9 @@ static int calibrate_8960(struct tsens_priv
> *priv)
> >
> >         kfree(data);
> >
> > -       return 0;
> > -}
> > -
> > -/* Temperature on y axis and ADC-code on x-axis */
> > -static inline int code_to_mdegC(u32 adc_code, const struct =
tsens_sensor
> *s)
> > -{
> > -       int slope, offset;
> > +       hw_init(priv);
> >
> > -       slope =3D thermal_zone_get_slope(s->tzd);
> > -       offset =3D CAL_MDEGC - slope * s->offset;
> > -
> > -       return adc_code * slope + offset;
>=20
> This code move hunk belongs in a separate patch.
>=20
> > +       return 0;
> >  }
> >
> >  static int get_temp_8960(const struct tsens_sensor *s, int *temp)
> > diff --git a/drivers/thermal/qcom/tsens.h
> b/drivers/thermal/qcom/tsens.h
> > index 59d01162c66a..e66048fabcc7 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -48,6 +48,7 @@ enum tsens_irq_type {
> >  struct tsens_sensor {
> >         struct tsens_priv               *priv;
> >         struct thermal_zone_device      *tzd;
> > +       struct work_struct              notify_work;
> >         int                             offset;
> >         unsigned int                    hw_id;
> >         int                             slope;
> > @@ -559,6 +560,7 @@ struct tsens_priv {
> >         struct regmap                   *tm_map;
> >         struct regmap                   *srot_map;
> >         u32                             tm_offset;
> > +       u32                             tsens_irq;
> >
> >         /* lock for upper/lower threshold interrupts */
> >         spinlock_t                      ul_lock;
> > @@ -568,6 +570,7 @@ struct tsens_priv {
> >         struct tsens_features           *feat;
> >         const struct reg_field          *fields;
> >         const struct tsens_ops          *ops;
> > +       struct work_struct              tsens_work;
> >
> >         struct dentry                   *debug_root;
> >         struct dentry                   *debug;
> > --
> > 2.27.0
> >

