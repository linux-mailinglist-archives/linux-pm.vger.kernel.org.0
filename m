Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41E763C7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGZKqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 06:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGZKqA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jul 2019 06:46:00 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C574F22CBB;
        Fri, 26 Jul 2019 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564137958;
        bh=x9mpS5NvmpKmAahIcVZmBhUi4LVxeCyzdFwA6MTZsMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q5TngikPRTXMNg0jozDNBJPwFVF/esEnumTmy+r7ILHTK8YXiAtYXiv4n0Ftz/gYH
         VoWYJrImvalMWzFplysthaI8Pd2QGW14KO/MIM/bQ9BOcY6m+ViYxbnLc9ibtDq8W2
         YWBb3du4rBxkznulmmTs9BFTIKNfvEuXon0wj6fQ=
Received: by mail-lj1-f177.google.com with SMTP id h10so51050503ljg.0;
        Fri, 26 Jul 2019 03:45:57 -0700 (PDT)
X-Gm-Message-State: APjAAAXIO3bswoo3QQIAVLl8SdZkcRbdIjtUDfg5fezTqIKVGDB0dcgF
        MqyRjtCZ14lsc6rfoHKe3xgRQ9ljLjjTDWVmgNc=
X-Google-Smtp-Source: APXvYqzZkUIlkzQtInKbgDs9Nar+L2o6NkagjMqtMfPToLfoMzoo3NIJHIWVhDdfUt4SL85oQ13GjXQLdyM04b3g+uU=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr48690964ljg.80.1564137955920;
 Fri, 26 Jul 2019 03:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22@eucas1p2.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com> <20190723122016.30279-5-a.swigon@partner.samsung.com>
 <CAGTfZH3Z334D3OKpBOGSfS9RoHkOX-s_2M858z1Ye2NoMtVh4g@mail.gmail.com>
In-Reply-To: <CAGTfZH3Z334D3OKpBOGSfS9RoHkOX-s_2M858z1Ye2NoMtVh4g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 26 Jul 2019 12:45:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfsD0XFs2hM64Kf0eG2G+xhWef3QZKjk9NU2ECzgQeqsA@mail.gmail.com>
Message-ID: <CAJKOXPfsD0XFs2hM64Kf0eG2G+xhWef3QZKjk9NU2ECzgQeqsA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/11] devfreq: exynos-bus: Clean up code
To:     cwchoi00@gmail.com
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 25 Jul 2019 at 14:51, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> 2019=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:07,=
 Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >
> > This patch adds minor improvements to the exynos-bus driver.
> >
> > Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 49 ++++++++++++++++--------------------
> >  1 file changed, 22 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.=
c
> > index 4bb83b945bf7..412511ca7703 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -15,11 +15,10 @@
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/module.h>
> > -#include <linux/of_device.h>
> > +#include <linux/of.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> > -#include <linux/slab.h>
> >
> >  #define DEFAULT_SATURATION_RATIO       40
> >  #define DEFAULT_VOLTAGE_TOLERANCE      2
> > @@ -256,7 +255,7 @@ static int exynos_bus_parent_parse_of(struct device=
_node *np,
> >                                         struct exynos_bus *bus)
> >  {
> >         struct device *dev =3D bus->dev;
> > -       int i, ret, count, size;
> > +       int i, ret, count;
> >
> >         /* Get the regulator to provide each bus with the power */
> >         bus->regulator =3D devm_regulator_get(dev, "vdd");
> > @@ -283,8 +282,7 @@ static int exynos_bus_parent_parse_of(struct device=
_node *np,
> >         }
> >         bus->edev_count =3D count;
> >
> > -       size =3D sizeof(*bus->edev) * count;
> > -       bus->edev =3D devm_kzalloc(dev, size, GFP_KERNEL);
> > +       bus->edev =3D devm_kcalloc(dev, count, sizeof(*bus->edev), GFP_=
KERNEL);
> >         if (!bus->edev) {
> >                 ret =3D -ENOMEM;
> >                 goto err_regulator;
> > @@ -388,7 +386,7 @@ static int exynos_bus_profile_init(struct exynos_bu=
s *bus,
> >         ondemand_data =3D devm_kzalloc(dev, sizeof(*ondemand_data), GFP=
_KERNEL);
> >         if (!ondemand_data) {
> >                 ret =3D -ENOMEM;
> > -               goto err;
> > +               goto out;
> >         }
> >         ondemand_data->upthreshold =3D 40;
> >         ondemand_data->downdifferential =3D 5;
> > @@ -400,14 +398,14 @@ static int exynos_bus_profile_init(struct exynos_=
bus *bus,
> >         if (IS_ERR(bus->devfreq)) {
> >                 dev_err(dev, "failed to add devfreq device\n");
> >                 ret =3D PTR_ERR(bus->devfreq);
> > -               goto err;
> > +               goto out;
> >         }
> >
> >         /* Register opp_notifier to catch the change of OPP  */
> >         ret =3D devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> >         if (ret < 0) {
> >                 dev_err(dev, "failed to register opp notifier\n");
> > -               goto err;
> > +               goto out;
> >         }
> >
> >         /*
> > @@ -417,16 +415,16 @@ static int exynos_bus_profile_init(struct exynos_=
bus *bus,
> >         ret =3D exynos_bus_enable_edev(bus);
> >         if (ret < 0) {
> >                 dev_err(dev, "failed to enable devfreq-event devices\n"=
);
> > -               goto err;
> > +               goto out;
> >         }
> >
> >         ret =3D exynos_bus_set_event(bus);
> >         if (ret < 0) {
> >                 dev_err(dev, "failed to set event to devfreq-event devi=
ces\n");
> > -               goto err;
> > +               goto out;
> >         }
> >
> > -err:
> > +out:
> >         return ret;
> >  }
> >
> > @@ -446,27 +444,28 @@ static int exynos_bus_profile_init_passive(struct=
 exynos_bus *bus,
> >         parent_devfreq =3D devfreq_get_devfreq_by_phandle(dev, 0);
> >         if (IS_ERR(parent_devfreq)) {
> >                 ret =3D -EPROBE_DEFER;
> > -               goto err;
> > +               goto out;
> >         }
> >
> >         passive_data =3D devm_kzalloc(dev, sizeof(*passive_data), GFP_K=
ERNEL);
> >         if (!passive_data) {
> >                 ret =3D -ENOMEM;
> > -               goto err;
> > +               goto out;
> >         }
> >         passive_data->parent =3D parent_devfreq;
> >
> >         /* Add devfreq device for exynos bus with passive governor */
> > -       bus->devfreq =3D devm_devfreq_add_device(dev, profile, DEVFREQ_=
GOV_PASSIVE,
> > +       bus->devfreq =3D devm_devfreq_add_device(dev, profile,
> > +                                               DEVFREQ_GOV_PASSIVE,
> >                                                 passive_data);
> >         if (IS_ERR(bus->devfreq)) {
> >                 dev_err(dev,
> >                         "failed to add devfreq dev with passive governo=
r\n");
> >                 ret =3D PTR_ERR(bus->devfreq);
> > -               goto err;
> > +               goto out;
> >         }
> >
> > -err:
> > +out:
> >         return ret;
> >  }
> >
> > @@ -484,11 +483,11 @@ static int exynos_bus_probe(struct platform_devic=
e *pdev)
> >                 return -EINVAL;
> >         }
> >
> > -       bus =3D devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> > +       bus =3D devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);
> >         if (!bus)
> >                 return -ENOMEM;
> >         mutex_init(&bus->lock);
> > -       bus->dev =3D &pdev->dev;
> > +       bus->dev =3D dev;
> >         platform_set_drvdata(pdev, bus);
> >
> >         /* Parse the device-tree to get the resource information */
> > @@ -502,7 +501,7 @@ static int exynos_bus_probe(struct platform_device =
*pdev)
> >                 goto err;
> >         }
> >
> > -       node =3D of_parse_phandle(dev->of_node, "devfreq", 0);
> > +       node =3D of_parse_phandle(np, "devfreq", 0);
> >         if (node) {
> >                 of_node_put(node);
> >                 ret =3D exynos_bus_profile_init_passive(bus, profile);
> > @@ -547,12 +546,10 @@ static int exynos_bus_resume(struct device *dev)
> >         int ret;
> >
> >         ret =3D exynos_bus_enable_edev(bus);
> > -       if (ret < 0) {
> > +       if (ret < 0)
> >                 dev_err(dev, "failed to enable the devfreq-event device=
s\n");
> > -               return ret;
> > -       }
> >
> > -       return 0;
> > +       return ret;
> >  }
> >
> >  static int exynos_bus_suspend(struct device *dev)
> > @@ -561,12 +558,10 @@ static int exynos_bus_suspend(struct device *dev)
> >         int ret;
> >
>
> NACK.

Instead of simple nack you should explain what is wrong with proposed
approach. The existing code could be improved and this patch clearly
improves the readability. "err" label is confusing if it is used for
correct exit path. The last "if() return" block is subjective - but
then explain exactly why you prefer one over another. No just "nack"
for peoples contributions.

> >         ret =3D exynos_bus_disable_edev(bus);
> > -       if (ret < 0) {
> > +       if (ret < 0)
> >                 dev_err(dev, "failed to disable the devfreq-event devic=
es\n");
> > -               return ret;
> > -       }
> >
> > -       return 0;
> > +       return ret;
> >  }
> >  #endif
> >
> > --
> > 2.17.1
> >
>
> NACK.
>
> As I already commented, It has never any benefit.
> I think that it is not usful. Please drop it.

The benefit for me is clear - makes the code easier to understand.

Best regards,
Krzysztof
