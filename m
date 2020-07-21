Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6222895C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 21:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgGUTmr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 15:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgGUTmp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 15:42:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5A5C061794
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 12:42:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q6so4352216ljp.4
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wrpTMg2zAV9QqF774s4OLo9SafzffQOIarEy4OxxC38=;
        b=aao1nkXdd0giPcYNgb2H915hfiHKnZzLMtyAh6l+yaaGNKMLyDLdm0494HxeexDyyr
         /pPhIFy/WnhsxZv2CUq/eCIL4RnQADRBvagkRzinl6Q6vtoczDIvWJlSbOMXrvXdrOmq
         +WJwpgBiDv+0vD/PPHB2jZby/3e1KPF/HqDdw1Q/M6WXjF6WgVODVH21jRfN3kQJJVKR
         1u+RAXjSbomr0zIEDevAdnQhnpqqTcyFSezcQytZoUSC8Bz9VCeGeG2gzB8TyZcJeX2q
         YkcMCgOpDVbXRnq8/jp2B84bhIO0nc1XbRymsVvg+8WrX5gHwHYQQPATqi3+CO5GQZbc
         OEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wrpTMg2zAV9QqF774s4OLo9SafzffQOIarEy4OxxC38=;
        b=CN9Sz0/UdEf38AgCm2qWjYFt0jqvGz7ch5pA+3xCXOzlj80P1t7Gy0z1SK5LeOGmMd
         hnvO7IqaH8AgO+1wLyWDduOkgn8hbdYwurSHzYsGF+0qRei2ecQLb8F5aSGsxBcT20bz
         3f3OjsPTzJW2ZJX/5CidGwqwQQJrf9tjMMCYCidrtigoJPLBzrENjddRQ2k8/wVFTr/1
         DHqK8Rmyd/ni4lBeRMXTiUly6FHnLFOZHXK9d0rka4ChnpI5OqZvDsv88mKrzvlU+ZmN
         DZK68Ptc9TG61+T/dPqOcsWexv5i3dJm11xR5+/Lk5LoPfNvhilSqAAfe5OLHfFW09tA
         sZsw==
X-Gm-Message-State: AOAM530WNvkAgtNhrPe+UQ4n0zLHDP797mkI0I6TuyTBdYpE63xjfsqT
        TKXAzDJDy8FkNfhJ6HzIBvXs6BGP/3sMc6RjCZ+kZA==
X-Google-Smtp-Source: ABdhPJy6X8KKJPPxi2bDRgfGOPSkFT4NXybe5YXwJ2C+JJMhwUBqMty93n/kSKdw44jRBwzV4c6pOXbX3rgundsaRGo=
X-Received: by 2002:a2e:3602:: with SMTP id d2mr14072116lja.152.1595360563589;
 Tue, 21 Jul 2020 12:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200716022817.30439-1-ansuelsmth@gmail.com> <20200716022817.30439-6-ansuelsmth@gmail.com>
 <CAP245DUGM7BgNvBEXvgA6xFiNr0a4BFhSorYwkyRDN5r99y=8w@mail.gmail.com> <006001d65f94$39e5d350$adb179f0$@gmail.com>
In-Reply-To: <006001d65f94$39e5d350$adb179f0$@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 22 Jul 2020 01:12:32 +0530
Message-ID: <CAP245DVusaFFCQ=0kT_HoBq=4O9+QpmqTMXi4Fn3SN+bd9+r9A@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] drivers: thermal: tsens: add interrupt support for
 9860 driver
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 22, 2020 at 12:52 AM <ansuelsmth@gmail.com> wrote:
>
>
>
> > -----Messaggio originale-----
> > Da: Amit Kucheria <amit.kucheria@linaro.org>
> > Inviato: luned=C3=AC 20 luglio 2020 11:41
> > A: Ansuel Smith <ansuelsmth@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Andy Gross <agross@kernel.org>;
> > Bjorn Andersson <bjorn.andersson@linaro.org>; Zhang Rui
> > <rui.zhang@intel.com>; Daniel Lezcano <daniel.lezcano@linaro.org>;
> > Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > <sboyd@kernel.org>; Linux PM list <linux-pm@vger.kernel.org>; linux-arm=
-
> > msm <linux-arm-msm@vger.kernel.org>; DTML
> > <devicetree@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; linux-clk <linux-clk@vger.kernel.org>
> > Oggetto: Re: [PATCH v4 5/7] drivers: thermal: tsens: add interrupt supp=
ort
> > for 9860 driver
> >
> > Hi Ansuel,
> >
> > Thanks for this patch.
> >
> > On Thu, Jul 16, 2020 at 7:58 AM Ansuel Smith <ansuelsmth@gmail.com>
> > wrote:
> > >
> > > Add interrupt support for 9860 tsens driver used to set thermal trip
> > > point for the system.
> >
> > typo: 8960
> >
> > You've used the names 8960 and ipq8064 interchangeably throughout the
> > series. AFAICT, msm8960, ipq8064 and apq8064 use the same IP version
> > of tsens. Please use 8960 in all patches, descriptions and dt-binding.
> > to reflect the filename for the driver.
> > Then add ipq8064 and apq8064 in a comment in the driver like here to
> > show that the driver also supports these other SoCs:
> > https://elixir.bootlin.com/linux/v5.8-
> > rc4/source/drivers/thermal/qcom/tsens-v0_1.c#L328
> >
> > You can also add a new compatible string for ipq8064 as a separate
> > patch at the end of the series.
> >
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/thermal/qcom/tsens-8960.c | 197
> > +++++++++++++++++++++++++++---
> > >  drivers/thermal/qcom/tsens.h      |   3 +
> > >  2 files changed, 186 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/thermal/qcom/tsens-8960.c
> > b/drivers/thermal/qcom/tsens-8960.c
> > > index 45788eb3c666..20d0bfb10f1f 100644
> > > --- a/drivers/thermal/qcom/tsens-8960.c
> > > +++ b/drivers/thermal/qcom/tsens-8960.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/bitops.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/mfd/syscon.h>
> > > +#include <linux/interrupt.h>
> > >  #include <linux/thermal.h>
> > >  #include "tsens.h"
> > >
> > > @@ -27,7 +28,6 @@
> > >  /* CNTL_ADDR bitmasks */
> > >  #define EN                     BIT(0)
> > >  #define SW_RST                 BIT(1)
> > > -#define SENSOR0_EN             BIT(3)
> > >  #define SLP_CLK_ENA            BIT(26)
> > >  #define SLP_CLK_ENA_8660       BIT(24)
> > >  #define MEASURE_PERIOD         1
> > > @@ -41,14 +41,26 @@
> > >
> > >  #define THRESHOLD_ADDR         0x3624
> > >  /* THRESHOLD_ADDR bitmasks */
> > > +#define THRESHOLD_MAX_CODE             0x20000
> > > +#define THRESHOLD_MIN_CODE             0
> > >  #define THRESHOLD_MAX_LIMIT_SHIFT      24
> > >  #define THRESHOLD_MIN_LIMIT_SHIFT      16
> > >  #define THRESHOLD_UPPER_LIMIT_SHIFT    8
> > >  #define THRESHOLD_LOWER_LIMIT_SHIFT    0
> > > +#define THRESHOLD_MAX_LIMIT_MASK       (THRESHOLD_MAX_CODE
> > << \
> > > +                                               THRESHOLD_MAX_LIMIT_S=
HIFT)
> > > +#define THRESHOLD_MIN_LIMIT_MASK       (THRESHOLD_MAX_CODE <<
> > \
> > > +                                               THRESHOLD_MIN_LIMIT_S=
HIFT)
> > > +#define THRESHOLD_UPPER_LIMIT_MASK     (THRESHOLD_MAX_CODE
> > << \
> > > +                                               THRESHOLD_UPPER_LIMIT=
_SHIFT)
> > > +#define THRESHOLD_LOWER_LIMIT_MASK     (THRESHOLD_MAX_CODE
> > << \
> > > +                                               THRESHOLD_LOWER_LIMIT=
_SHIFT)
> > >
> > >  /* Initial temperature threshold values */
> > > -#define LOWER_LIMIT_TH         0x50
> > > -#define UPPER_LIMIT_TH         0xdf
> > > +#define LOWER_LIMIT_TH_8960    0x50
> > > +#define UPPER_LIMIT_TH_8960    0xdf
> > > +#define LOWER_LIMIT_TH_8064    0x9d /* 95C */
> > > +#define UPPER_LIMIT_TH_8064    0xa6 /* 105C */
> > >  #define MIN_LIMIT_TH           0x0
> > >  #define MAX_LIMIT_TH           0xff
> > >
> > > @@ -57,6 +69,170 @@
> > >  #define TRDY_MASK              BIT(7)
> > >  #define TIMEOUT_US             100
> > >
> > > +#define TSENS_EN               BIT(0)
> > > +#define TSENS_SW_RST           BIT(1)
> > > +#define TSENS_ADC_CLK_SEL      BIT(2)
> > > +#define SENSOR0_EN             BIT(3)
> > > +#define SENSOR1_EN             BIT(4)
> > > +#define SENSOR2_EN             BIT(5)
> > > +#define SENSOR3_EN             BIT(6)
> > > +#define SENSOR4_EN             BIT(7)
> > > +#define SENSORS_EN             (SENSOR0_EN | SENSOR1_EN | \
> > > +                               SENSOR2_EN | SENSOR3_EN | SENSOR4_EN)
> > > +#define TSENS_8064_SENSOR5_EN                          BIT(8)
> > > +#define TSENS_8064_SENSOR6_EN                          BIT(9)
> > > +#define TSENS_8064_SENSOR7_EN                          BIT(10)
> > > +#define TSENS_8064_SENSOR8_EN                          BIT(11)
> > > +#define TSENS_8064_SENSOR9_EN                          BIT(12)
> > > +#define TSENS_8064_SENSOR10_EN                         BIT(13)
> > > +#define TSENS_8064_SENSORS_EN                          (SENSORS_EN |=
 \
> > > +                                               TSENS_8064_SENSOR5_EN=
 | \
> > > +                                               TSENS_8064_SENSOR6_EN=
 | \
> > > +                                               TSENS_8064_SENSOR7_EN=
 | \
> > > +                                               TSENS_8064_SENSOR8_EN=
 | \
> > > +                                               TSENS_8064_SENSOR9_EN=
 | \
> > > +                                               TSENS_8064_SENSOR10_E=
N)
> > > +
> > > +u32 tsens_8960_slope[] =3D {
> > > +                       1176, 1176, 1154, 1176,
> > > +                       1111, 1132, 1132, 1199,
> > > +                       1132, 1199, 1132
> > > +                       };
> > > +
> > > +/* Temperature on y axis and ADC-code on x-axis */
> > > +static inline int code_to_mdegC(u32 adc_code, const struct
> > tsens_sensor *s)
> > > +{
> > > +       int slope, offset;
> > > +
> > > +       slope =3D thermal_zone_get_slope(s->tzd);
> > > +       offset =3D CAL_MDEGC - slope * s->offset;
> > > +
> > > +       return adc_code * slope + offset;
> > > +}
> > > +
> > > +static void notify_uspace_tsens_fn(struct work_struct *work)
> > > +{
> > > +       struct tsens_sensor *s =3D container_of(work, struct tsens_se=
nsor,
> > > +                                                               notif=
y_work);
> > > +
> > > +       sysfs_notify(&s->tzd->device.kobj, NULL, "type");
> > > +}
> > > +
> > > +static void tsens_scheduler_fn(struct work_struct *work)
> > > +{
> > > +       struct tsens_priv *priv =3D
> > > +               container_of(work, struct tsens_priv, tsens_work);
> > > +       unsigned int threshold, threshold_low, code, reg, sensor;
> > > +       unsigned long mask;
> > > +       bool upper_th_x, lower_th_x;
> > > +       int ret;
> > > +
> > > +       ret =3D regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064,
> > &reg);
> > > +       if (ret)
> > > +               return;
> > > +       reg =3D reg | LOWER_STATUS_CLR | UPPER_STATUS_CLR;
> > > +       ret =3D regmap_write(priv->tm_map, STATUS_CNTL_ADDR_8064, reg=
);
> > > +       if (ret)
> > > +               return;
> > > +
> > > +       mask =3D ~(LOWER_STATUS_CLR | UPPER_STATUS_CLR);
> > > +       ret =3D regmap_read(priv->tm_map, THRESHOLD_ADDR, &threshold)=
;
> > > +       if (ret)
> > > +               return;
> > > +       threshold_low =3D (threshold & THRESHOLD_LOWER_LIMIT_MASK) >>
> > > +                       THRESHOLD_LOWER_LIMIT_SHIFT;
> > > +       threshold =3D (threshold & THRESHOLD_UPPER_LIMIT_MASK) >>
> > > +                   THRESHOLD_UPPER_LIMIT_SHIFT;
> > > +
> > > +       ret =3D regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064,
> > &reg);
> > > +       if (ret)
> > > +               return;
> > > +
> > > +       ret =3D regmap_read(priv->tm_map, CNTL_ADDR, &sensor);
> > > +       if (ret)
> > > +               return;
> > > +       sensor &=3D (uint32_t)TSENS_8064_SENSORS_EN;
> > > +       sensor >>=3D SENSOR0_SHIFT;
> > > +
> > > +       /* Constraint: There is only 1 interrupt control register for=
 all
> > > +        * 11 temperature sensor. So monitoring more than 1 sensor ba=
sed
> > > +        * on interrupts will yield inconsistent result. To overcome =
this
> > > +        * issue we will monitor only sensor 0 which is the master se=
nsor.
> > > +        */
> > > +
> > > +       /* Skip if the sensor is disabled */
> > > +       if (sensor & 1) {
> > > +               ret =3D regmap_read(priv->tm_map, priv->sensor[0].sta=
tus,
> > &code);
> > > +               if (ret)
> > > +                       return;
> > > +               upper_th_x =3D code >=3D threshold;
> > > +               lower_th_x =3D code <=3D threshold_low;
> > > +               if (upper_th_x)
> > > +                       mask |=3D UPPER_STATUS_CLR;
> > > +               if (lower_th_x)
> > > +                       mask |=3D LOWER_STATUS_CLR;
> > > +               if (upper_th_x || lower_th_x) {
> > > +                       /* Notify user space */
> > > +                       schedule_work(&priv->sensor[0].notify_work);
> > > +                       pr_debug("Trigger (%d degrees) for sensor %d\=
n",
> > > +                                code_to_mdegC(code, &priv->sensor[0]=
), 0);
> > > +               }
> > > +       }
> > > +       regmap_write(priv->tm_map, STATUS_CNTL_ADDR_8064, reg &
> > mask);
> > > +}
> > > +
> > > +static irqreturn_t tsens_isr(int irq, void *data)
> > > +{
> > > +       struct tsens_priv *priv =3D data;
> > > +
> > > +       schedule_work(&priv->tsens_work);
> > > +       return IRQ_HANDLED;
> >
> >
> > Have you considered trying to reuse the regmap and interrupt handling
> > infrastructure in tsens.c that I used to convert over everything after
> > IP version 0.1?
> >
> > I started converting over 8960 but never managed to finish testing
> > this[1]. I'd be happy for you to take this over and get it working so
> > the 8960 doesn't end up being a completely separate driver from the
> > other platforms.
> >
> > [1]
> > https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=3Dwrk3/ts=
ens-
> > 8960-breakage
> >
>
> Thanks a lot for the link. I started doing some test and I think the only=
 general
> code we will be able to use will be the init_common. The get temp and
> the function to convert code to decg are very different from the one used=
 in
> 8960.  Do you think keep a custom get temp function is good or not?

OK. Let's start common init code and custom get_temp and adc-to-degc functi=
ons.

Regards,
Amit
