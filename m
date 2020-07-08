Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48D218678
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgGHLzx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 07:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgGHLzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 07:55:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D46C08C5DC;
        Wed,  8 Jul 2020 04:55:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dp18so50132979ejc.8;
        Wed, 08 Jul 2020 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EX2IWN7bRkThFDhQbxfKU17nUc+D3lwl2BkJX4pCu5A=;
        b=CpHy+iHW4tx0y9eFypOsys2jSzjT7ZMT9MtYU12FOM4jnIzHAXHVcYE8agzNHs0S4p
         zsb7VJHGV5oEzx5qherShp9zpp9qzESBpWr8coTbyZVUffNXSS+kkb5Osme1l/Q7etEN
         T/uUdCvGMnN1vk8iYwLOfT8WUedpZOvLwnFVZDCXwNpRUwmKDoshG2VlVdZtrbDfJtfE
         7/8G8MxuUFCIPEOKXTUQl5DZDeDMhe3QOfjZE4qz2Vd/q0I1NiRt6LlbG1PGCXiOe7++
         2f910b37ujnFKBiMvFnaX4I4lafQVHf+JKXEc2qsnLzjRlW+qjlvN4K0cuqHV0S5sx+r
         iTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EX2IWN7bRkThFDhQbxfKU17nUc+D3lwl2BkJX4pCu5A=;
        b=HRBN662/zvZVwvfupAfXgt5bQE15nXs80JRtQ272Wlgpe/s67vlaFa6SWRpvTjvIAY
         Zt1zbhiINJebfzJwRF0KerxurJYSxNkZbnFcilAJER6lO32ZjOOsC8qqB73i4GkQMtqu
         BK3HMXRS+u4MB5byzGAKbS3f6Ru92HZMZBGXDJGNO2xBa6AM3j/QiSHC7YM+YYyHBLon
         CWv/U5QiHqwdq56iR6IgLjHNAuXBsWWhfpACSbU6EONx1f3+cxgDmJ5dr19C9qxZQpfU
         iFz7MYRPawxedO9HUWMS/avQaKGyVe1IAmGtHjKKjeH1jvzmvBA2KtNu7HGrpWrdIR1u
         In9Q==
X-Gm-Message-State: AOAM533w6tW5QEYdFCk4gV7owB8aD7wpGcJSEOIMRV+JpGFAvNEC5Xwq
        sk+vuCEkGi+MKrDOsS6vU5rf3pfhtydBEBccBAg=
X-Google-Smtp-Source: ABdhPJx7PRp2oMgeQTTA1p1kYTOT+xwpfbRRw5F6Hhf6bleBiTgjtbQmzfzmAcg785gG+W4AZh4RDgFogLCJv1fCgeE=
X-Received: by 2002:a17:906:a055:: with SMTP id bg21mr47163493ejb.516.1594209351560;
 Wed, 08 Jul 2020 04:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200708105527.868987-1-megous@megous.com>
In-Reply-To: <20200708105527.868987-1-megous@megous.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 8 Jul 2020 19:55:40 +0800
Message-ID: <CAEExFWvR4QnAQsXBnxk3V776P+YVJzs4PU-HWJ7dfo4B6cdtkg@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI Ondrej,
On Wed, Jul 8, 2020 at 6:55 PM Ondrej Jirman <megous@megous.com> wrote:
>
> I noticed several mobile Linux distributions failing to enable the
> thermal regulation correctly, because the kernel is silent
> when thermal driver fails to probe. Add enough error reporting
> to debug issues and warn users in case thermal sensor is failing
> to probe.
>
> Failing to notify users means, that SoC can easily overheat under
> load.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 74d73be16496..9065e79ae743 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_device *tm=
dev)
>
>         calcell =3D devm_nvmem_cell_get(dev, "calibration");
>         if (IS_ERR(calcell)) {
> +               dev_err(dev, "Failed to get calibration nvmem cell (%ld)\=
n",
> +                       PTR_ERR(calcell));
> +
>                 if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
>                         return -EPROBE_DEFER;
> +
>                 /*
>                  * Even if the external calibration data stored in sid is
>                  * not accessible, the THS hardware can still work, altho=
ugh
> @@ -308,6 +312,8 @@ static int sun8i_ths_calibrate(struct ths_device *tmd=
ev)
>         caldata =3D nvmem_cell_read(calcell, &callen);
>         if (IS_ERR(caldata)) {
>                 ret =3D PTR_ERR(caldata);
> +               dev_err(dev, "Failed to read calibration data (%d)\n",
> +                       ret);
>                 goto out;
>         }
>
> @@ -330,23 +336,35 @@ static int sun8i_ths_resource_init(struct ths_devic=
e *tmdev)
>                 return PTR_ERR(base);
>
>         tmdev->regmap =3D devm_regmap_init_mmio(dev, base, &config);
> -       if (IS_ERR(tmdev->regmap))
> +       if (IS_ERR(tmdev->regmap)) {
> +               dev_err(dev, "Failed to init regmap (%ld)\n",
> +                       PTR_ERR(tmdev->regmap));
>                 return PTR_ERR(tmdev->regmap);
> +       }
>
>         if (tmdev->chip->has_bus_clk_reset) {
>                 tmdev->reset =3D devm_reset_control_get(dev, NULL);
> -               if (IS_ERR(tmdev->reset))
> +               if (IS_ERR(tmdev->reset)) {
> +                       dev_err(dev, "Failed to get reset (%ld)\n",
> +                               PTR_ERR(tmdev->reset));
>                         return PTR_ERR(tmdev->reset);
> +               }
>
>                 tmdev->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
> -               if (IS_ERR(tmdev->bus_clk))
> +               if (IS_ERR(tmdev->bus_clk)) {
> +                       dev_err(dev, "Failed to get bus clock (%ld)\n",
> +                               PTR_ERR(tmdev->bus_clk));
>                         return PTR_ERR(tmdev->bus_clk);
> +               }
>         }
>
>         if (tmdev->chip->has_mod_clk) {
>                 tmdev->mod_clk =3D devm_clk_get(&pdev->dev, "mod");
> -               if (IS_ERR(tmdev->mod_clk))
> +               if (IS_ERR(tmdev->mod_clk)) {
> +                       dev_err(dev, "Failed to get mod clock (%ld)\n",
> +                               PTR_ERR(tmdev->mod_clk));
>                         return PTR_ERR(tmdev->mod_clk);
> +               }
>         }
>
>         ret =3D reset_control_deassert(tmdev->reset);
> @@ -471,8 +489,12 @@ static int sun8i_ths_register(struct ths_device *tmd=
ev)
>                                                              i,
>                                                              &tmdev->sens=
or[i],
>                                                              &ths_ops);
> -               if (IS_ERR(tmdev->sensor[i].tzd))
> +               if (IS_ERR(tmdev->sensor[i].tzd)) {
> +                       dev_err(tmdev->dev,
> +                               "Failed to register sensor %d (%ld)\n",
> +                               i, PTR_ERR(tmdev->sensor[i].tzd));
>                         return PTR_ERR(tmdev->sensor[i].tzd);
> +               }
>
>                 if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
>                         dev_warn(tmdev->dev,
> @@ -501,19 +523,21 @@ static int sun8i_ths_probe(struct platform_device *=
pdev)
>
>         ret =3D sun8i_ths_resource_init(tmdev);
>         if (ret)
> -               return ret;
> +               goto err_out;
>
>         irq =3D platform_get_irq(pdev, 0);
> -       if (irq < 0)
> -               return irq;
> +       if (irq < 0) {
> +               ret =3D irq;
> +               goto err_out;
> +       }
>
>         ret =3D tmdev->chip->init(tmdev);
>         if (ret)
> -               return ret;
> +               goto err_out;
>
>         ret =3D sun8i_ths_register(tmdev);
>         if (ret)
> -               return ret;
> +               goto err_out;
>
>         /*
>          * Avoid entering the interrupt handler, the thermal device is no=
t
> @@ -523,10 +547,17 @@ static int sun8i_ths_probe(struct platform_device *=
pdev)
>         ret =3D devm_request_threaded_irq(dev, irq, NULL,
>                                         sun8i_irq_thread,
>                                         IRQF_ONESHOT, "ths", tmdev);
> -       if (ret)
> -               return ret;
> +       if (ret) {
> +               dev_err(dev, "Failed to request irq (%d)\n", ret);
> +               goto err_out;
> +       }
>
> +       dev_info(dev, "Thermal sensor ready!\n");
>         return 0;
> +
> +err_out:
> +       dev_err(dev, "Failed to probe thermal sensor (%d)\n", ret);

When the driver fails, there will be this print. Isn't it superfluous
for you to add these=EF=BC=9F

sun8i-thermal: probe of 5070400.thermal-sensor failed with error


Yangtao
