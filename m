Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10BC74E6D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfGYMqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 08:46:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36738 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbfGYMp7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 08:45:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so47885223ljj.3;
        Thu, 25 Jul 2019 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YxoMXX9Nct0eRRcS7Q/PLXYnZRgyZpcSP8/DWhoCE08=;
        b=iC1vZvfJutufEB8O0LVkEL3eLGLkJvcm3eMtB88c8eNso6GNJRzNp+ZIqa/3Q52BIu
         JRoQYKgU9myUBTAbT0TCOHH5UbyaMYcVFjy0TEU3YM81qHCSIkGNjrtDJtW+uxLeVFwA
         kRHHCiwp15FcRYWijkcBil/QsrUnPTJH2FLrZb5nWB8g8uEQIW22396vX3zHb35bpdR3
         UD1bfkthTgUKyJ+NW7JORGckCMOEp4JMlXM5VEoEoEj01RVHQ5NYxto3PDXdunGJjHiC
         9vtq66s8v7Wl8bnyGmgwgfT7Zruss//MqXAsQOXN1Ft+UULQ/F+gDuzbsN6AJOXkE/cj
         Wf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YxoMXX9Nct0eRRcS7Q/PLXYnZRgyZpcSP8/DWhoCE08=;
        b=AquvUnnGLUf0F+hqnm2VvkyP9xUSulJ+GXsk+VNCighqJVwi0jVubsG4AO7URAN+qW
         /ly2JwZ4b+TNo5X05q8ZLcNeB6Ei21yUMQ3wlCiyfBZgict4dEYyEv32AH5FxJa6YdPf
         RFPlDDmtHx/KcVc94nlD8xs4InDlpP1x3TcLH3sARbe55jTBvdMDBJWW2Q2DN4k1D3h/
         wgZcMjgX2RUigDSM5og4guCGjcKE46Oyak756cY4kMR01eWuAgJqkXNcRB0ncWmBh/Tz
         y6ojH36F8MEC4adHfnN99Gst36HHZsKVd3Y64L3z+hNFjTP2mHj7/fpc4GUkZ3650Oy4
         /JDA==
X-Gm-Message-State: APjAAAUQ2JUbAo2qCfCGTMu7o4SXIskLnte+aanCxHn/eHYCpmorRDo0
        GBTGY6qrELpb8rtG4Zr8MpEQ6w6GQfvC7P3oZ40=
X-Google-Smtp-Source: APXvYqwievWEj3UbBaN2VIfe8QRJUis+gUfdQlAX6IUbqOgqfMnKj83r/6dVQ+2l6WZ0uRdOwLDmDD1IMt9qut4IPNs=
X-Received: by 2002:a2e:8945:: with SMTP id b5mr44878199ljk.93.1564058756462;
 Thu, 25 Jul 2019 05:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190723122023eucas1p2ff56c00b60a676ed85d9fe159a1839f2@eucas1p2.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com> <20190723122016.30279-3-a.swigon@partner.samsung.com>
In-Reply-To: <20190723122016.30279-3-a.swigon@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 21:45:19 +0900
Message-ID: <CAGTfZH3GXCuYY-xmKtGd-M47WKp2c8PseytKw-oUOwp+TtGsvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/11] devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:07, A=
rtur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> This patch adds a new static function, exynos_bus_profile_init_passive(),
> extracted from exynos_bus_probe().
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 70 +++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index d8f1efaf2d49..cf6f6cbd0f55 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -430,13 +430,51 @@ static int exynos_bus_profile_init(struct exynos_bu=
s *bus,
>         return ret;
>  }
>
> +static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> +                                          struct devfreq_dev_profile *pr=
ofile)
> +{
> +       struct device *dev =3D bus->dev;
> +       struct devfreq *parent_devfreq;
> +       struct devfreq_passive_data *passive_data;
> +       int ret =3D 0;
> +
> +       /* Initialize the struct profile and governor data for passive de=
vice */
> +       profile->target =3D exynos_bus_passive_target;
> +       profile->exit =3D exynos_bus_passive_exit;
> +
> +       /* Get the instance of parent devfreq device */
> +       parent_devfreq =3D devfreq_get_devfreq_by_phandle(dev, 0);
> +       if (IS_ERR(parent_devfreq)) {
> +               ret =3D -EPROBE_DEFER;
> +               goto err;
> +       }
> +
> +       passive_data =3D devm_kzalloc(dev, sizeof(*passive_data), GFP_KER=
NEL);
> +       if (!passive_data) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +       passive_data->parent =3D parent_devfreq;
> +
> +       /* Add devfreq device for exynos bus with passive governor */
> +       bus->devfreq =3D devm_devfreq_add_device(dev, profile, DEVFREQ_GO=
V_PASSIVE,
> +                                               passive_data);
> +       if (IS_ERR(bus->devfreq)) {
> +               dev_err(dev,
> +                       "failed to add devfreq dev with passive governor\=
n");
> +               ret =3D PTR_ERR(bus->devfreq);
> +               goto err;
> +       }
> +
> +err:
> +       return ret;
> +}
> +
>  static int exynos_bus_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
>         struct device_node *np =3D dev->of_node, *node;
>         struct devfreq_dev_profile *profile;
> -       struct devfreq_passive_data *passive_data;
> -       struct devfreq *parent_devfreq;
>         struct exynos_bus *bus;
>         int ret, max_state;
>         unsigned long min_freq, max_freq;
> @@ -481,33 +519,9 @@ static int exynos_bus_probe(struct platform_device *=
pdev)
>
>         goto out;
>  passive:
> -       /* Initialize the struct profile and governor data for passive de=
vice */
> -       profile->target =3D exynos_bus_passive_target;
> -       profile->exit =3D exynos_bus_passive_exit;
> -
> -       /* Get the instance of parent devfreq device */
> -       parent_devfreq =3D devfreq_get_devfreq_by_phandle(dev, 0);
> -       if (IS_ERR(parent_devfreq)) {
> -               ret =3D -EPROBE_DEFER;
> +       ret =3D exynos_bus_profile_init_passive(bus, profile);
> +       if (ret < 0)
>                 goto err;
> -       }
> -
> -       passive_data =3D devm_kzalloc(dev, sizeof(*passive_data), GFP_KER=
NEL);
> -       if (!passive_data) {
> -               ret =3D -ENOMEM;
> -               goto err;
> -       }
> -       passive_data->parent =3D parent_devfreq;
> -
> -       /* Add devfreq device for exynos bus with passive governor */
> -       bus->devfreq =3D devm_devfreq_add_device(dev, profile, DEVFREQ_GO=
V_PASSIVE,
> -                                               passive_data);
> -       if (IS_ERR(bus->devfreq)) {
> -               dev_err(dev,
> -                       "failed to add devfreq dev with passive governor\=
n");
> -               ret =3D PTR_ERR(bus->devfreq);
> -               goto err;
> -       }
>
>  out:
>         max_state =3D bus->devfreq->profile->max_state;
> --
> 2.17.1
>

Actually, it is not necessary. It has no any benefit.
Please drop it as I commented on patch1.


--
Best Regards,
Chanwoo Choi
