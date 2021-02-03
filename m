Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D59B30D38D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 07:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhBCG4f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 01:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhBCG4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 01:56:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1866C061573
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 22:55:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id f14so9644410ejc.8
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2021 22:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J+1btNhoC7XQ9M1i+p2yxgqSKnNhpctzXaXRCEoe3UQ=;
        b=lzBDi07t5XsaZVnawZuxnwablA+/iXeTR4X4AJqHTCWbOOgVHgnGhs3awZHKD0qikm
         brpHynUs0Ywv3d4s3MvvELuH58UGsI00KVbx3L3qMIFEOVCmTssevX26qQavu+gyasjH
         /GtGMMmlo22DzQo3awoCiSECb+YTvzkCIP/foUDGvP3iE0ykfaML5v3s4Qu8HS39yiwZ
         HALmPaUiuJz/9ZYlgz4dLlblqHVbh2wad+dOkelrGDJYHu3T5TEQuL+fuoj0G8Z7zqvv
         ZQYbrhayE1e/qbyWBrp2/29m6wF//4eBcEaPilRM5YmB+cBCpion2Oci0taf3/25BfCv
         nQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J+1btNhoC7XQ9M1i+p2yxgqSKnNhpctzXaXRCEoe3UQ=;
        b=hZ5oHmbnj8SiLDUORRrlyH3Or7cWYOTK4WIIxelwgn1tmjU8WVJpRCrH70dDI0AEcD
         s0L7vRMNRfVhB55bdMu0qnDhv94a/G9wM/ao40JNKTAsSJctBR6ljTUgduB2t28LQMwb
         7vK2UWrtYtqVQWxwARp7kqs6Gs8vtcUJE7mxCTVdOofwf7GLqh+G8/mtRgvhlbuNNkWY
         3Ej4nV0P8yvxnLNfzkJPgU9s6hF00bXfmuoND0F7GgvFfTWQSVi9bGohBYSrDdp8+q73
         dBoNUBU6cFeM41Y9Envi60UfrMnQFHVME8d0zWd9r3KQBLm0T8ucUZxZA169A9c/OX/R
         zsfQ==
X-Gm-Message-State: AOAM532zhX41JcyQom3DR955xFHfmyf8bC5AaqkHYhvx3QXxFsnYkT63
        74tl8bMgjjdklLc6m713xRUVqXeYJmi4+DvjWR5HQnymiA==
X-Google-Smtp-Source: ABdhPJzMgv+swzpijFBwr2uTz3jx9p0w/Y9C6eumMY1aOk8McbfjbMOqrJ9KDw7h5DYwP3kXg2K4Zvbil/OfW73WANQ=
X-Received: by 2002:a17:906:c455:: with SMTP id ck21mr1824976ejb.354.1612335353186;
 Tue, 02 Feb 2021 22:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20201207222829.13676-1-ma.czerski@gmail.com> <20210116150413.gqsodziwjv6g6bvd@earth.universe>
In-Reply-To: <20210116150413.gqsodziwjv6g6bvd@earth.universe>
From:   Marek Czerski <ma.czerski@gmail.com>
Date:   Wed, 3 Feb 2021 07:55:42 +0100
Message-ID: <CAOOgLvq4_qSy3KAo9bjH4j5qdTL5nweRJ+KtdO--LZ0_LvQCKg@mail.gmail.com>
Subject: Re: [PATCH] power: reset: ltc2952: make trigger delay configurable
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

Thanks for the review. I will send fixed patch as v2 to the correct
list of recipients afer I test it on my hardware this week.

Best regards,
Marek Czerski.

sob., 16 sty 2021 o 16:04 Sebastian Reichel <sre@kernel.org> napisa=C5=82(a=
):
>
> Hi,
>
> On Mon, Dec 07, 2020 at 11:28:29PM +0100, Marek Czerski wrote:
> > Make trigger delay configurable through device tree with
> > trigger-delay-ms property.
> >
> > Trigger delay is the time to wait before starting shutdown
> > sequence after trigger line assertion.
> > Trigger delay must take into account the OFFT time configured
> > with the capacitor connected to OFFT pin of the LTC2952 chip.
> > Basically, the higher the capacitance connected to OFFT pin,
> > the larger trigger delay must be.
> >
> > Signed-off-by: Marek Czerski <ma.czerski@gmail.com>
> > ---
> >  .../devicetree/bindings/power/reset/ltc2952-poweroff.txt  | 4 ++++
> >  drivers/power/reset/ltc2952-poweroff.c                    | 8 ++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-powe=
roff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.t=
xt
> > index cd2d7f58a..881f15a78 100644
> > --- a/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.tx=
t
> > +++ b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.tx=
t
>
> Please additionally Cc DT binding maintainer:
>
> OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> M:      Rob Herring <robh+dt@kernel.org>
> L:      devicetree@vger.kernel.org
>
> > @@ -17,6 +17,9 @@ Optional properties:
> >                       chip's trigger line. If this property is not set,=
 the
> >                       trigger function is ignored and the chip is kept =
alive
> >                       until an explicit kill signal is received
> > +- trigger-delay-ms   The number of milliseconds to wait after trigger =
line
> > +                     assertion before executing shut down procedure.
> > +                     The default is 2500ms.
> >
> >  Example:
> >
> > @@ -24,6 +27,7 @@ ltc2952 {
> >       compatible =3D "lltc,ltc2952";
> >
> >       trigger-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
> > +        trigger-delay-ms =3D <2000>;
>
> please use tab instead of spaces
>
> >       watchdog-gpios =3D <&gpio1 2 GPIO_ACTIVE_HIGH>;
> >       kill-gpios =3D <&gpio0 2 GPIO_ACTIVE_LOW>;
> >  };
> > diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/res=
et/ltc2952-poweroff.c
> > index 318927938..243811541 100644
> > --- a/drivers/power/reset/ltc2952-poweroff.c
> > +++ b/drivers/power/reset/ltc2952-poweroff.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/reboot.h>
> > +#include <linux/of.h>
> >
> >  struct ltc2952_poweroff {
> >       struct hrtimer timer_trigger;
> > @@ -172,10 +173,17 @@ static void ltc2952_poweroff_default(struct ltc29=
52_poweroff *data)
> >  static int ltc2952_poweroff_init(struct platform_device *pdev)
> >  {
> >       int ret;
> > +     u32 trigger_delay_ms;
> >       struct ltc2952_poweroff *data =3D platform_get_drvdata(pdev);
> >
> >       ltc2952_poweroff_default(data);
> >
> > +     if (!of_property_read_u32(pdev->dev.of_node, "trigger-delay-ms",
> > +                               &trigger_delay_ms)) {
>
> please use device_property_read_u32() from <linux/property.h>.
>
> > +             data->trigger_delay =3D ktime_set(trigger_delay_ms / MSEC=
_PER_SEC,
> > +                     (trigger_delay_ms % MSEC_PER_SEC) * NSEC_PER_MSEC=
);
> > +     }
> > +
> >       data->gpio_watchdog =3D devm_gpiod_get(&pdev->dev, "watchdog",
> >                                            GPIOD_OUT_LOW);
> >       if (IS_ERR(data->gpio_watchdog)) {
>
> Thanks and sorry for delayed response,
>
> -- Sebastian



--=20
mgr in=C5=BC. Marek Czerski
+48 696 842 686
