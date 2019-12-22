Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9428C128EEC
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 17:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLVQtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 11:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfLVQtj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Dec 2019 11:49:39 -0500
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BDC22070A;
        Sun, 22 Dec 2019 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577033378;
        bh=zNwV6UcRWYyXPEtNmmpVjDoWHyX7Z1gcx8eFJmze8mg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WdS5yxPmd7RX9ltaK4Oge25rmUk44wOe0yd4V6/7qk1BRZTYlcDg8xn+6N8wdvQPr
         NlEMcuioxl8QWiP2mVUD69EIrOPzovxEMSWP3lpa4eeORQjsOJJlQijZbDZpthIXmx
         FgdRE6YjBFTm2YXH1k4O+oylhv0x15M9UYwnjH1o=
Received: by mail-lj1-f174.google.com with SMTP id l2so15505686lja.6;
        Sun, 22 Dec 2019 08:49:38 -0800 (PST)
X-Gm-Message-State: APjAAAU52rjvYOA6fm91y9A/g2X/bGQd+9PaEZbo5dpHnfWOfXMqNU0z
        xQ7SEbI37+yc77dciduA10zmAmMtCJurImLed4k=
X-Google-Smtp-Source: APXvYqw+7LsTvhfr17gQzvZhmz8/LnvcJbjWww+1BqNZBdSt5pyypiA6KMl3+4MaQAGBhgU3LpIiXqsY+ypdKUkPeTo=
X-Received: by 2002:a2e:8551:: with SMTP id u17mr10521487ljj.165.1577033376732;
 Sun, 22 Dec 2019 08:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20191221181855.31380-1-tiny.windzz@gmail.com>
In-Reply-To: <20191221181855.31380-1-tiny.windzz@gmail.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Mon, 23 Dec 2019 01:49:00 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1aObSb5oWnVzp_WaGALFfC9VQpRKQ+AWTauPVL7VPOSg@mail.gmail.com>
Message-ID: <CAGTfZH1aObSb5oWnVzp_WaGALFfC9VQpRKQ+AWTauPVL7VPOSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / devfreq: rk3399_dmc: Add missing devfreq_event_disable_edev
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

2019=EB=85=84 12=EC=9B=94 22=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 3:21, =
Yangtao Li <tiny.windzz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The probe process may fail, but the devfreq event device remains
> enabled. Call devfreq_event_disable_edev on the error return path.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/rk3399_dmc.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 2f1027c5b647..4f4e7c041888 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -364,7 +364,8 @@ static int rk3399_dmcfreq_probe(struct platform_devic=
e *pdev)
>                         if (res.a0) {
>                                 dev_err(dev, "Failed to set dram param: %=
ld\n",
>                                         res.a0);
> -                               return -EINVAL;
> +                               ret =3D -EINVAL;
> +                               goto err_disable_edev;

After jumping err_disable_edev, it calls the dev_pm_opp_of_remove_table().
it is wrong. It doesn't need to remove the table.

>                         }
>                 }
>         }
> @@ -373,8 +374,10 @@ static int rk3399_dmcfreq_probe(struct platform_devi=
ce *pdev)
>         if (node) {
>                 data->regmap_pmu =3D syscon_node_to_regmap(node);
>                 of_node_put(node);
> -               if (IS_ERR(data->regmap_pmu))
> -                       return PTR_ERR(data->regmap_pmu);
> +               if (IS_ERR(data->regmap_pmu)) {
> +                       ret =3D PTR_ERR(data->regmap_pmu);
> +                       goto err_disable_edev;

ditto.

After jumping err_disable_edev, it calls the dev_pm_opp_of_remove_table().
it is wrong. It doesn't need to remove the table.

> +               }
>         }
>
>         regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> @@ -392,7 +395,8 @@ static int rk3399_dmcfreq_probe(struct platform_devic=
e *pdev)
>                 data->odt_dis_freq =3D data->timing.lpddr4_odt_dis_freq;
>                 break;
>         default:
> -               return -EINVAL;
> +               ret =3D -EINVAL;
> +               goto err_disable_edev;

ditto.

>         };
>
>         arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
> @@ -426,7 +430,8 @@ static int rk3399_dmcfreq_probe(struct platform_devic=
e *pdev)
>          */
>         if (dev_pm_opp_of_add_table(dev)) {
>                 dev_err(dev, "Invalid operating-points in device tree.\n"=
);
> -               return -EINVAL;
> +               ret =3D -EINVAL;
> +               goto err_disable_edev;

ditto.

>         }
>
>         of_property_read_u32(np, "upthreshold",
> @@ -464,6 +469,8 @@ static int rk3399_dmcfreq_probe(struct platform_devic=
e *pdev)
>
>         return 0;
>
> +err_disable_edev:
> +       devfreq_event_disable_edev(data->edev);

It is wrong. It have to be called under dev_pm_opp_of_remove_table().
It ignores the sequence of exception handling.

>  err_free_opp:
>         dev_pm_opp_of_remove_table(&pdev->dev);
>         return ret;
> --
> 2.17.1
>


--=20
Best Regards,
Chanwoo Choi
