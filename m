Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C70D74E5C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbfGYMoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 08:44:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41688 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387824AbfGYMoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 08:44:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so29561915lfa.8;
        Thu, 25 Jul 2019 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=eknW/TOhMypD0xkCLP+fL/Yr6TV2yqEhmiGmkOzq3EY=;
        b=SGrHQnGamBfhL9h2LIZhaX7f9KvB10ttFxb277iUL+BvpuX19DWhTckbrOHBS4+bB+
         m9YetynEB8y7ypr4B8nFLVAGyapGKxWjoZxUPkuSEeDirKOx+jYujLjma9zqPA4jRlS3
         GqwZ7gFTVqcgMYaMp5hSI+XykjFFYKDAt78k+JUDX26g+tebTeWpVj7PKL3tuV7FVjHN
         JuE8XfOXKZUJ/QTUpnBfsy4KGo+SEGF8wT74VSYK0JXj9TD9qMCge0cJS9XqIsPcrFd7
         r8QfBLlVMx5sLRIa7z3M/0UhksbtUTCZ/ao0mZ7+K907kG9CK9zFquLPd5PxSCf8UdbU
         grbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=eknW/TOhMypD0xkCLP+fL/Yr6TV2yqEhmiGmkOzq3EY=;
        b=mfTzABfxm8CpRRZbTq1wgaJ85AiA/btb6CDHTVLj03ucLhZVkcRTJ1s8s3/6sgsHU8
         0TdKoaxbyEBLAnVH66usqEuCBtvOfXq3EBHYp49w3w/6ac+yROVlr8iwAgW78x6yLM7x
         qdomT6yrbCfCjndaoC/kdkriaMD3WcCse5NXsR93fF/RGWEoQlL5r7ScqrJ++bW8CTHP
         JVJTVwkQ00zO+V9ioJHi8Koywc7OJwFWlwWqBUEitQkn+uM7fQDMO6D7wVBB2/pdPu2B
         gnePJJLy/bmB1t5F5eqVFwPbj+AUekWlt2c672DCJmX3LMnsJ5M3cnMmc0QDixGXLCFC
         GOTQ==
X-Gm-Message-State: APjAAAVsMZmJPDOmCPg6Rhp77vtzy/eIA2GjsiouLt/XgUK6VoxuScod
        QpMsbKio7TvVtlptZc9KtkHvclMbTuHsWkPwmF8=
X-Google-Smtp-Source: APXvYqwpmD94AweNs5qa5XTy4hbRxs01Hq1+o+UpAxFYnCbprWQUIs8wQla3LFmrbYj8sb8whiJOm8JPZnPJaxTAFyo=
X-Received: by 2002:a19:7f17:: with SMTP id a23mr44348217lfd.49.1564058649021;
 Thu, 25 Jul 2019 05:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190723122022eucas1p1266d90873d564894bd852c20140f8474@eucas1p1.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com> <20190723122016.30279-2-a.swigon@partner.samsung.com>
In-Reply-To: <20190723122016.30279-2-a.swigon@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 21:43:31 +0900
Message-ID: <CAGTfZH0JE0PmiCHaT3vMrDaP0-8eZ3afyHy_zT9aFmMOGNTR8g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] devfreq: exynos-bus: Extract exynos_bus_profile_init()
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

2019=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:09, A=
rtur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> This patch adds a new static function, exynos_bus_profile_init(), extract=
ed
> from exynos_bus_probe().
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++---------------
>  1 file changed, 60 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index d9f377912c10..d8f1efaf2d49 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -372,12 +372,69 @@ static int exynos_bus_parse_of(struct device_node *=
np,
>         return ret;
>  }
>
> +static int exynos_bus_profile_init(struct exynos_bus *bus,
> +                                  struct devfreq_dev_profile *profile)
> +{
> +       struct device *dev =3D bus->dev;
> +       struct devfreq_simple_ondemand_data *ondemand_data;
> +       int ret;
> +
> +       /* Initialize the struct profile and governor data for parent dev=
ice */
> +       profile->polling_ms =3D 50;
> +       profile->target =3D exynos_bus_target;
> +       profile->get_dev_status =3D exynos_bus_get_dev_status;
> +       profile->exit =3D exynos_bus_exit;
> +
> +       ondemand_data =3D devm_kzalloc(dev, sizeof(*ondemand_data), GFP_K=
ERNEL);
> +       if (!ondemand_data) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +       ondemand_data->upthreshold =3D 40;
> +       ondemand_data->downdifferential =3D 5;
> +
> +       /* Add devfreq device to monitor and handle the exynos bus */
> +       bus->devfreq =3D devm_devfreq_add_device(dev, profile,
> +                                               DEVFREQ_GOV_SIMPLE_ONDEMA=
ND,
> +                                               ondemand_data);
> +       if (IS_ERR(bus->devfreq)) {
> +               dev_err(dev, "failed to add devfreq device\n");
> +               ret =3D PTR_ERR(bus->devfreq);
> +               goto err;
> +       }
> +
> +       /* Register opp_notifier to catch the change of OPP  */
> +       ret =3D devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register opp notifier\n");
> +               goto err;
> +       }
> +
> +       /*
> +        * Enable devfreq-event to get raw data which is used to determin=
e
> +        * current bus load.
> +        */
> +       ret =3D exynos_bus_enable_edev(bus);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to enable devfreq-event devices\n");
> +               goto err;
> +       }
> +
> +       ret =3D exynos_bus_set_event(bus);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to set event to devfreq-event device=
s\n");
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
> -       struct devfreq_simple_ondemand_data *ondemand_data;
>         struct devfreq_passive_data *passive_data;
>         struct devfreq *parent_devfreq;
>         struct exynos_bus *bus;
> @@ -418,52 +475,9 @@ static int exynos_bus_probe(struct platform_device *=
pdev)
>         if (ret < 0)
>                 goto err;
>
> -       /* Initialize the struct profile and governor data for parent dev=
ice */
> -       profile->polling_ms =3D 50;
> -       profile->target =3D exynos_bus_target;
> -       profile->get_dev_status =3D exynos_bus_get_dev_status;
> -       profile->exit =3D exynos_bus_exit;
> -
> -       ondemand_data =3D devm_kzalloc(dev, sizeof(*ondemand_data), GFP_K=
ERNEL);
> -       if (!ondemand_data) {
> -               ret =3D -ENOMEM;
> +       ret =3D exynos_bus_profile_init(bus, profile);
> +       if (ret < 0)
>                 goto err;
> -       }
> -       ondemand_data->upthreshold =3D 40;
> -       ondemand_data->downdifferential =3D 5;
> -
> -       /* Add devfreq device to monitor and handle the exynos bus */
> -       bus->devfreq =3D devm_devfreq_add_device(dev, profile,
> -                                               DEVFREQ_GOV_SIMPLE_ONDEMA=
ND,
> -                                               ondemand_data);
> -       if (IS_ERR(bus->devfreq)) {
> -               dev_err(dev, "failed to add devfreq device\n");
> -               ret =3D PTR_ERR(bus->devfreq);
> -               goto err;
> -       }
> -
> -       /* Register opp_notifier to catch the change of OPP  */
> -       ret =3D devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to register opp notifier\n");
> -               goto err;
> -       }
> -
> -       /*
> -        * Enable devfreq-event to get raw data which is used to determin=
e
> -        * current bus load.
> -        */
> -       ret =3D exynos_bus_enable_edev(bus);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to enable devfreq-event devices\n");
> -               goto err;
> -       }
> -
> -       ret =3D exynos_bus_set_event(bus);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to set event to devfreq-event device=
s\n");
> -               goto err;
> -       }
>
>         goto out;
>  passive:
> --
> 2.17.1
>

NACK.

It has not any benefit and I don't understand reason why it is necessary.
I don't agree. Please drop it.

--=20
Best Regards,
Chanwoo Choi
