Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9A763C0
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGZKmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 06:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGZKmT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jul 2019 06:42:19 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2142122CB9;
        Fri, 26 Jul 2019 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564137737;
        bh=X7zomnphSoatQ2ExsZCymGrIKUnr+7mD1sl02mTPfh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xOIT7hQdaE/9saCJ016SORI9yKJR4VdvxCbG1H173OLs1s6mHJXKyd7rc897GqvTd
         gKGbYk2M0FXGKg+ThrcP47kYqY52jrdZIUTa1y2tkWazRdgbUglzRXmdiVxFD9JWf4
         /rjQ/hqg3pM0VOSD8zR3w9k9kqGBqh95ky+LeizI=
Received: by mail-lj1-f181.google.com with SMTP id r9so51018570ljg.5;
        Fri, 26 Jul 2019 03:42:17 -0700 (PDT)
X-Gm-Message-State: APjAAAVDXb0Q5x4XbONwUkcsxIi2/ifvFlxLaIxo3aYUjeskf/uI71Ho
        8v35IMSOwEap4g5K8BGskqPXEgimI6tnZ65E+RI=
X-Google-Smtp-Source: APXvYqwjjPIUcxkurCk45AI+olnU8bXwOyRqJMGB5KvMZHbMvG1vzBey1kV3fpe6+DzCzU8EHqwv22xT+qk5FHRVVEY=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr23905543ljm.5.1564137735265;
 Fri, 26 Jul 2019 03:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190723122022eucas1p1266d90873d564894bd852c20140f8474@eucas1p1.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com> <20190723122016.30279-2-a.swigon@partner.samsung.com>
 <CAGTfZH0JE0PmiCHaT3vMrDaP0-8eZ3afyHy_zT9aFmMOGNTR8g@mail.gmail.com>
In-Reply-To: <CAGTfZH0JE0PmiCHaT3vMrDaP0-8eZ3afyHy_zT9aFmMOGNTR8g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 26 Jul 2019 12:42:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe4nOjjuA2MXLP1n=dPa7o6egjLZScSBNhyi9agHqqM7A@mail.gmail.com>
Message-ID: <CAJKOXPe4nOjjuA2MXLP1n=dPa7o6egjLZScSBNhyi9agHqqM7A@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] devfreq: exynos-bus: Extract exynos_bus_profile_init()
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

On Thu, 25 Jul 2019 at 14:44, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> 2019=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:09,=
 Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >
> > This patch adds a new static function, exynos_bus_profile_init(), extra=
cted
> > from exynos_bus_probe().
> >
> > Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++---------------
> >  1 file changed, 60 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.=
c
> > index d9f377912c10..d8f1efaf2d49 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -372,12 +372,69 @@ static int exynos_bus_parse_of(struct device_node=
 *np,
> >         return ret;
> >  }
> >
> > +static int exynos_bus_profile_init(struct exynos_bus *bus,
> > +                                  struct devfreq_dev_profile *profile)
> > +{
> > +       struct device *dev =3D bus->dev;
> > +       struct devfreq_simple_ondemand_data *ondemand_data;
> > +       int ret;
> > +
> > +       /* Initialize the struct profile and governor data for parent d=
evice */
> > +       profile->polling_ms =3D 50;
> > +       profile->target =3D exynos_bus_target;
> > +       profile->get_dev_status =3D exynos_bus_get_dev_status;
> > +       profile->exit =3D exynos_bus_exit;
> > +
> > +       ondemand_data =3D devm_kzalloc(dev, sizeof(*ondemand_data), GFP=
_KERNEL);
> > +       if (!ondemand_data) {
> > +               ret =3D -ENOMEM;
> > +               goto err;
> > +       }
> > +       ondemand_data->upthreshold =3D 40;
> > +       ondemand_data->downdifferential =3D 5;
> > +
> > +       /* Add devfreq device to monitor and handle the exynos bus */
> > +       bus->devfreq =3D devm_devfreq_add_device(dev, profile,
> > +                                               DEVFREQ_GOV_SIMPLE_ONDE=
MAND,
> > +                                               ondemand_data);
> > +       if (IS_ERR(bus->devfreq)) {
> > +               dev_err(dev, "failed to add devfreq device\n");
> > +               ret =3D PTR_ERR(bus->devfreq);
> > +               goto err;
> > +       }
> > +
> > +       /* Register opp_notifier to catch the change of OPP  */
> > +       ret =3D devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> > +       if (ret < 0) {
> > +               dev_err(dev, "failed to register opp notifier\n");
> > +               goto err;
> > +       }
> > +
> > +       /*
> > +        * Enable devfreq-event to get raw data which is used to determ=
ine
> > +        * current bus load.
> > +        */
> > +       ret =3D exynos_bus_enable_edev(bus);
> > +       if (ret < 0) {
> > +               dev_err(dev, "failed to enable devfreq-event devices\n"=
);
> > +               goto err;
> > +       }
> > +
> > +       ret =3D exynos_bus_set_event(bus);
> > +       if (ret < 0) {
> > +               dev_err(dev, "failed to set event to devfreq-event devi=
ces\n");
> > +               goto err;
> > +       }
> > +
> > +err:
> > +       return ret;
> > +}
> > +
> >  static int exynos_bus_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev =3D &pdev->dev;
> >         struct device_node *np =3D dev->of_node, *node;
> >         struct devfreq_dev_profile *profile;
> > -       struct devfreq_simple_ondemand_data *ondemand_data;
> >         struct devfreq_passive_data *passive_data;
> >         struct devfreq *parent_devfreq;
> >         struct exynos_bus *bus;
> > @@ -418,52 +475,9 @@ static int exynos_bus_probe(struct platform_device=
 *pdev)
> >         if (ret < 0)
> >                 goto err;
> >
> > -       /* Initialize the struct profile and governor data for parent d=
evice */
> > -       profile->polling_ms =3D 50;
> > -       profile->target =3D exynos_bus_target;
> > -       profile->get_dev_status =3D exynos_bus_get_dev_status;
> > -       profile->exit =3D exynos_bus_exit;
> > -
> > -       ondemand_data =3D devm_kzalloc(dev, sizeof(*ondemand_data), GFP=
_KERNEL);
> > -       if (!ondemand_data) {
> > -               ret =3D -ENOMEM;
> > +       ret =3D exynos_bus_profile_init(bus, profile);
> > +       if (ret < 0)
> >                 goto err;
> > -       }
> > -       ondemand_data->upthreshold =3D 40;
> > -       ondemand_data->downdifferential =3D 5;
> > -
> > -       /* Add devfreq device to monitor and handle the exynos bus */
> > -       bus->devfreq =3D devm_devfreq_add_device(dev, profile,
> > -                                               DEVFREQ_GOV_SIMPLE_ONDE=
MAND,
> > -                                               ondemand_data);
> > -       if (IS_ERR(bus->devfreq)) {
> > -               dev_err(dev, "failed to add devfreq device\n");
> > -               ret =3D PTR_ERR(bus->devfreq);
> > -               goto err;
> > -       }
> > -
> > -       /* Register opp_notifier to catch the change of OPP  */
> > -       ret =3D devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> > -       if (ret < 0) {
> > -               dev_err(dev, "failed to register opp notifier\n");
> > -               goto err;
> > -       }
> > -
> > -       /*
> > -        * Enable devfreq-event to get raw data which is used to determ=
ine
> > -        * current bus load.
> > -        */
> > -       ret =3D exynos_bus_enable_edev(bus);
> > -       if (ret < 0) {
> > -               dev_err(dev, "failed to enable devfreq-event devices\n"=
);
> > -               goto err;
> > -       }
> > -
> > -       ret =3D exynos_bus_set_event(bus);
> > -       if (ret < 0) {
> > -               dev_err(dev, "failed to set event to devfreq-event devi=
ces\n");
> > -               goto err;
> > -       }
> >
> >         goto out;
> >  passive:
> > --
> > 2.17.1
> >
>
> NACK.
>
> It has not any benefit and I don't understand reason why it is necessary.
> I don't agree. Please drop it.

The probe has 12 local variables and around 140 lines of code (so much
more than coding style recommendations). Therefore splitting some
logical part out of probe to make code better organized and more
readable is pretty obvious benefit.

Best regards,
Krzysztof
