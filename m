Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0368474E86
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 14:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbfGYMve (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 08:51:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40955 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbfGYMve (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 08:51:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so34470432lff.7;
        Thu, 25 Jul 2019 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/Xsj00ljhBsEGtdT+wj7N34Rn+B2eibrc+3bGLHtXVM=;
        b=KrxMTzFAhzWFqULF0MbgezdmTCddBLW97aZPw3roEOocGi9PDJFCSZH+TnwulnpeHu
         3dXe6bI5xxyAEbMIqJ7cE0SM5Oidx/BetTLPcq2iPyBBaZJUK4Fu316uFx+7yYEtQspd
         7Wd9dy9MMx4pEro5eP9OpYcYTFB+yFEDUswcHd8NvJXkH/qh9HqcXpCcPo98DeGgu+Fz
         yDYtoOYw+cgpWw0MTtZg/sSmqRJkcceW1Rw7N/o+FwuIIM4y7hjxM6d7sVHRcrlWfviM
         tdoCkMRczvDnAkzxE4hW0IdrhEwqrpzzmBZ/wdXyF8q8+hkBo2kecS8AtzQnc4HOXUYY
         4dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/Xsj00ljhBsEGtdT+wj7N34Rn+B2eibrc+3bGLHtXVM=;
        b=ZVT5j4lZyHk5Z290cj99uRQ/hFuvQxsCgrVSyhSPiJCGNkpyrgoJjkAZRyP5dpZT1/
         xvl78D10Oy9T9PwldTjVHarvnYvqn6eubZSBFntjLpBZMeS17NUaXlkYsumQ3S1tDMoa
         ajzNHvwXoEZQRd43Clx1Lxs/IVCDbnLknCwQpYUnrBmraqDu0I0ea9vxCtRlim5uZyZe
         SEdss2eYWVJgEPtNNHeFiMVS/ZdsfFP7BMZOI3PpQGd/Xxw9ZuynVwgNyf10P0xuc3ox
         FZQ5bU9Chfm/xeUFOJexF/a1HWxPx1j6aXhd0MQNM6ME8IMUi/OVy5fpcn1ZJwbzmU+S
         EbeA==
X-Gm-Message-State: APjAAAU/W3x1jCfafWxhbgGHssldwjF631wi5GrBr4utXSsmuTGULu4t
        cb0iZwLSP5tKuWQFtb7dmd/UOSmVnxd8Zl5uXkE=
X-Google-Smtp-Source: APXvYqxevdANPfOlkVtzMQ882vgwBXm0Jbm6vzvza8p7XXpVnciz9Vl5i1ZzZxjAhKyc6EfZHmf4aPb+4/23UDQiUlw=
X-Received: by 2002:a19:914c:: with SMTP id y12mr41019898lfj.108.1564059090602;
 Thu, 25 Jul 2019 05:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22@eucas1p2.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com> <20190723122016.30279-5-a.swigon@partner.samsung.com>
In-Reply-To: <20190723122016.30279-5-a.swigon@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 21:50:53 +0900
Message-ID: <CAGTfZH3Z334D3OKpBOGSfS9RoHkOX-s_2M858z1Ye2NoMtVh4g@mail.gmail.com>
Subject: Re: [RFC PATCH 04/11] devfreq: exynos-bus: Clean up code
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
> This patch adds minor improvements to the exynos-bus driver.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 49 ++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 4bb83b945bf7..412511ca7703 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -15,11 +15,10 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/pm_opp.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/slab.h>
>
>  #define DEFAULT_SATURATION_RATIO       40
>  #define DEFAULT_VOLTAGE_TOLERANCE      2
> @@ -256,7 +255,7 @@ static int exynos_bus_parent_parse_of(struct device_n=
ode *np,
>                                         struct exynos_bus *bus)
>  {
>         struct device *dev =3D bus->dev;
> -       int i, ret, count, size;
> +       int i, ret, count;
>
>         /* Get the regulator to provide each bus with the power */
>         bus->regulator =3D devm_regulator_get(dev, "vdd");
> @@ -283,8 +282,7 @@ static int exynos_bus_parent_parse_of(struct device_n=
ode *np,
>         }
>         bus->edev_count =3D count;
>
> -       size =3D sizeof(*bus->edev) * count;
> -       bus->edev =3D devm_kzalloc(dev, size, GFP_KERNEL);
> +       bus->edev =3D devm_kcalloc(dev, count, sizeof(*bus->edev), GFP_KE=
RNEL);
>         if (!bus->edev) {
>                 ret =3D -ENOMEM;
>                 goto err_regulator;
> @@ -388,7 +386,7 @@ static int exynos_bus_profile_init(struct exynos_bus =
*bus,
>         ondemand_data =3D devm_kzalloc(dev, sizeof(*ondemand_data), GFP_K=
ERNEL);
>         if (!ondemand_data) {
>                 ret =3D -ENOMEM;
> -               goto err;
> +               goto out;
>         }
>         ondemand_data->upthreshold =3D 40;
>         ondemand_data->downdifferential =3D 5;
> @@ -400,14 +398,14 @@ static int exynos_bus_profile_init(struct exynos_bu=
s *bus,
>         if (IS_ERR(bus->devfreq)) {
>                 dev_err(dev, "failed to add devfreq device\n");
>                 ret =3D PTR_ERR(bus->devfreq);
> -               goto err;
> +               goto out;
>         }
>
>         /* Register opp_notifier to catch the change of OPP  */
>         ret =3D devm_devfreq_register_opp_notifier(dev, bus->devfreq);
>         if (ret < 0) {
>                 dev_err(dev, "failed to register opp notifier\n");
> -               goto err;
> +               goto out;
>         }
>
>         /*
> @@ -417,16 +415,16 @@ static int exynos_bus_profile_init(struct exynos_bu=
s *bus,
>         ret =3D exynos_bus_enable_edev(bus);
>         if (ret < 0) {
>                 dev_err(dev, "failed to enable devfreq-event devices\n");
> -               goto err;
> +               goto out;
>         }
>
>         ret =3D exynos_bus_set_event(bus);
>         if (ret < 0) {
>                 dev_err(dev, "failed to set event to devfreq-event device=
s\n");
> -               goto err;
> +               goto out;
>         }
>
> -err:
> +out:
>         return ret;
>  }
>
> @@ -446,27 +444,28 @@ static int exynos_bus_profile_init_passive(struct e=
xynos_bus *bus,
>         parent_devfreq =3D devfreq_get_devfreq_by_phandle(dev, 0);
>         if (IS_ERR(parent_devfreq)) {
>                 ret =3D -EPROBE_DEFER;
> -               goto err;
> +               goto out;
>         }
>
>         passive_data =3D devm_kzalloc(dev, sizeof(*passive_data), GFP_KER=
NEL);
>         if (!passive_data) {
>                 ret =3D -ENOMEM;
> -               goto err;
> +               goto out;
>         }
>         passive_data->parent =3D parent_devfreq;
>
>         /* Add devfreq device for exynos bus with passive governor */
> -       bus->devfreq =3D devm_devfreq_add_device(dev, profile, DEVFREQ_GO=
V_PASSIVE,
> +       bus->devfreq =3D devm_devfreq_add_device(dev, profile,
> +                                               DEVFREQ_GOV_PASSIVE,
>                                                 passive_data);
>         if (IS_ERR(bus->devfreq)) {
>                 dev_err(dev,
>                         "failed to add devfreq dev with passive governor\=
n");
>                 ret =3D PTR_ERR(bus->devfreq);
> -               goto err;
> +               goto out;
>         }
>
> -err:
> +out:
>         return ret;
>  }
>
> @@ -484,11 +483,11 @@ static int exynos_bus_probe(struct platform_device =
*pdev)
>                 return -EINVAL;
>         }
>
> -       bus =3D devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +       bus =3D devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);
>         if (!bus)
>                 return -ENOMEM;
>         mutex_init(&bus->lock);
> -       bus->dev =3D &pdev->dev;
> +       bus->dev =3D dev;
>         platform_set_drvdata(pdev, bus);
>
>         /* Parse the device-tree to get the resource information */
> @@ -502,7 +501,7 @@ static int exynos_bus_probe(struct platform_device *p=
dev)
>                 goto err;
>         }
>
> -       node =3D of_parse_phandle(dev->of_node, "devfreq", 0);
> +       node =3D of_parse_phandle(np, "devfreq", 0);
>         if (node) {
>                 of_node_put(node);
>                 ret =3D exynos_bus_profile_init_passive(bus, profile);
> @@ -547,12 +546,10 @@ static int exynos_bus_resume(struct device *dev)
>         int ret;
>
>         ret =3D exynos_bus_enable_edev(bus);
> -       if (ret < 0) {
> +       if (ret < 0)
>                 dev_err(dev, "failed to enable the devfreq-event devices\=
n");
> -               return ret;
> -       }
>
> -       return 0;
> +       return ret;
>  }
>
>  static int exynos_bus_suspend(struct device *dev)
> @@ -561,12 +558,10 @@ static int exynos_bus_suspend(struct device *dev)
>         int ret;
>

NACK.
>         ret =3D exynos_bus_disable_edev(bus);
> -       if (ret < 0) {
> +       if (ret < 0)
>                 dev_err(dev, "failed to disable the devfreq-event devices=
\n");
> -               return ret;
> -       }
>
> -       return 0;
> +       return ret;
>  }
>  #endif
>
> --
> 2.17.1
>

NACK.

As I already commented, It has never any benefit.
I think that it is not usful. Please drop it.



--=20
Best Regards,
Chanwoo Choi
