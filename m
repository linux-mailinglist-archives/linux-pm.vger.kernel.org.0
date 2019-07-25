Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7330D751FE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 17:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbfGYPAB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 11:00:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38609 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388374AbfGYPAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 11:00:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so48317540ljg.5;
        Thu, 25 Jul 2019 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=p9OR61FicIpVENd/71fr74aLBznslcDzFyCpkAgUAXc=;
        b=QpF6BdCinO8sSU+WgwVqhTBRehdNQtib+EoE3soWMylfDlEr7ExQR6aPDum3wSyomO
         YjvZHhKphEW9EvLI+saojKFniOHKA2wjO4m2MIh/dEBr82C/sZIL9KLeDDVlhcJaZjbU
         4YMf32NobArfgLnsmOTI4uAUgcPoo9s12i65I023l8RYJ8s18KSHHdOQsaIsBRh3JEiA
         TwZ55d1Eln05YRaSbpfpRcuQ8uLXh2ZNprhmG8BfsBxq/RjNvFhqBWGgW3vX7DKt3mtc
         UqzbXF2+OgEuSmOr4S+gW1cA2J707vr1vY0nG1Ph5wxT5BKtVL5GBhYe94vSiSH7AWib
         jLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=p9OR61FicIpVENd/71fr74aLBznslcDzFyCpkAgUAXc=;
        b=EV2nrpFgfwE/A5uNlXmmEfV2W5d+tgps9I3gbSINEzYORttBaLGtSxBlTtqeL2rTwR
         vYx4qLtUrWBtziST/ZkKCis+zix0lYpkBBCfwz0eROw51mQurC/v4iBOoXynONvl+V4u
         Mk8ZikzGgooLFHcGC75wg7vxdevfHphZR01effMnClrs8swALoHnCHkeOi+nxJyFh11/
         o3TUC7v7Nu4myO4tByom+Lsxy2+4zoqkVaT4VgEXXUVtvCnbmBrZRmCKuDOuqJkuNiwq
         ZMpEL9jYnLJgubleojn2gE4mD+sFxxJVBb/L9jrFcQlpDCZrKlyD71Q5a+yumylFijM+
         XImQ==
X-Gm-Message-State: APjAAAXKmjtQN7svYtxPTBZjPt8NPcXg7DbWIm7uRF+Wuu4VOqbYalCb
        AxVD0UwIRDcIpBcGdV75R37WaG2wd8gIYbsgoSw=
X-Google-Smtp-Source: APXvYqwsM3OgAowPI5xaCfG8fdrn/hdgdcd4tyijHhC7H2G6DeZ7i8m+exE9TkNVLdcveFGTrpBdfmLVo4VyTFHuGTE=
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr44378736ljl.18.1564066797851;
 Thu, 25 Jul 2019 07:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190725144325eucas1p1463ecde90f9c93cb73d3c54c7cf3f1ff@eucas1p1.samsung.com>
 <20190725144300.25014-1-k.konieczny@partner.samsung.com> <20190725144300.25014-2-k.konieczny@partner.samsung.com>
In-Reply-To: <20190725144300.25014-2-k.konieczny@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 23:59:21 +0900
Message-ID: <CAGTfZH0=skWJ3Dny7voeRzDp5oRkbNO=Pf6j+PM03=epmX-86g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] devfreq: exynos-bus: correct clock enable sequence
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

You are missing my Acked tag.

2019=EB=85=84 7=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 11:44, =
<k.konieczny@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Regulators should be enabled before clocks to avoid h/w hang. This
> require change in exynos_bus_probe() to move exynos_bus_parse_of()
> after exynos_bus_parent_parse_of() and change in error handling.
> Similar change is needed in exynos_bus_exit() where clock should be
> disabled before regulators.
>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
> Changes:
> v4:
> - move regulator disable after clock disable
> - remove unrelated changes
> - add disabling regulators in error path in exynos_bus_probe()
>
> ---
>  drivers/devfreq/exynos-bus.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 486cc5b422f1..f34fa26f00d0 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -194,11 +194,10 @@ static void exynos_bus_exit(struct device *dev)
>         if (ret < 0)
>                 dev_warn(dev, "failed to disable the devfreq-event device=
s\n");
>
> -       if (bus->regulator)
> -               regulator_disable(bus->regulator);
> -
>         dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
> +       if (bus->regulator)
> +               regulator_disable(bus->regulator);
>  }
>
>  /*
> @@ -386,6 +385,7 @@ static int exynos_bus_probe(struct platform_device *p=
dev)
>         struct exynos_bus *bus;
>         int ret, max_state;
>         unsigned long min_freq, max_freq;
> +       bool passive =3D false;
>
>         if (!np) {
>                 dev_err(dev, "failed to find devicetree node\n");
> @@ -399,27 +399,27 @@ static int exynos_bus_probe(struct platform_device =
*pdev)
>         bus->dev =3D &pdev->dev;
>         platform_set_drvdata(pdev, bus);
>
> -       /* Parse the device-tree to get the resource information */
> -       ret =3D exynos_bus_parse_of(np, bus);
> -       if (ret < 0)
> -               return ret;
> -
>         profile =3D devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> -       if (!profile) {
> -               ret =3D -ENOMEM;
> -               goto err;
> -       }
> +       if (!profile)
> +               return -ENOMEM;
>
>         node =3D of_parse_phandle(dev->of_node, "devfreq", 0);
>         if (node) {
>                 of_node_put(node);
> -               goto passive;
> +               passive =3D true;
>         } else {
>                 ret =3D exynos_bus_parent_parse_of(np, bus);
> +               if (ret < 0)
> +                       return ret;
>         }
>
> +       /* Parse the device-tree to get the resource information */
> +       ret =3D exynos_bus_parse_of(np, bus);
>         if (ret < 0)
> -               goto err;
> +               goto err_reg;
> +
> +       if (passive)
> +               goto passive;
>
>         /* Initialize the struct profile and governor data for parent dev=
ice */
>         profile->polling_ms =3D 50;
> @@ -510,6 +510,9 @@ static int exynos_bus_probe(struct platform_device *p=
dev)
>  err:
>         dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
> +err_reg:
> +       if (!passive)
> +               regulator_disable(bus->regulator);
>
>         return ret;
>  }
> --
> 2.22.0
>


--=20
Best Regards,
Chanwoo Choi
