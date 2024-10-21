Return-Path: <linux-pm+bounces-16071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBF9A62AA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BEC1C217C6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2C1E376D;
	Mon, 21 Oct 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwZPnZRi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C061E1C19
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506058; cv=none; b=jrjo9sUm6gMffMJOetMP6qgdP5/IBy4F1m3CpciyH4RxoEsTPSQABGV8h/VAS2nKfmI1QSF7UQV3KML+AI/Mz3wTH69qD/sR2QIJmrc6Oi27THdwtPVrV6bjRcXQ2TPiQD+Gh7pUPRYPEO6Jprh5Jbzao7cvBii+qMHlooN5iR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506058; c=relaxed/simple;
	bh=alk7iJpzqAeQolFS1/hgxMBFW4QrUN8p04DSfQCXGsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klTXoGeHhpjfnnpYZsIwlLFrPGmuW8aWU6V3dEMdQlGaUo4xY98rrrOKiXQiOUlY+f/F42Egbd6qubiljHidYQQ1RExUrW+uvKrw+Cz6g9HfMSX91qAf/j2rg8uZBzAbmylIqk+W3jtCZxI7OFO17ICvs6Mo4OnJaIdC1TL9K34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwZPnZRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AD4C4CEC7
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506057;
	bh=alk7iJpzqAeQolFS1/hgxMBFW4QrUN8p04DSfQCXGsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JwZPnZRir72D4PrpJAjqixTwyhPw3xsxP811qgs5kZtjWuUSNtHgF2fsIbQ2fxOSN
	 9aKv6I2MfdFC0rmZOAVLRrE7FeYXoZYAbmxjOZgLoGPphLE6/V840AXiX6iBOd4esp
	 njb/hFlNy1VEb1Be+4Ll7nmpWvuTrZBJvlVX2gFKNSPhsSs5f1D1W1RghE4pOzwFho
	 /O+cYThdsPfOVBHVJFvDSkiZ2nqyvnU5/B0m1YcWAT9dN2hxsjhMcIvKrFhMOXWdz5
	 K5xl50DPhvHRKbgGp+wlq7fO2l0eO7wPpkUcCfTpIfA0oQR5ZoprHi8BLWqfZOrToy
	 ikdHkBViTHKqA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e602994635so1436231b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 03:20:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8fqELZ1HMPy9ju6Af18yBpy+HvyqiH3JYxxnI1Unv0jiEmVBW
	zFfJS9zethtP20+N9kaUqjaUX9dwqMmd1soZ1eu4raNT2Gwj9nYNAvjzYVAqR1+qAsEw8b9LhOf
	jo1oj1wWdJnAhT4sv5GWTEZL/NL4=
X-Google-Smtp-Source: AGHT+IGMI3NiGNoeAwQ5eBYcNtjGHUDgfWIiLww3DZ2ChkNiDYAFkLhgjJt55+OV6XrxbGV9MnJuwz0qNB95i7qWbc0=
X-Received: by 2002:a05:6871:211:b0:287:f1d3:67e5 with SMTP id
 586e51a60fabf-2892c5b019emr9232111fac.43.1729506057019; Mon, 21 Oct 2024
 03:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020153910.324096-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241020153910.324096-2-u.kleine-koenig@baylibre.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 12:20:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jAMr=bmZ5PexVTS0SqrXP4EytZ+RH5X8p1Nep2wMg-kQ@mail.gmail.com>
Message-ID: <CAJZ5v0jAMr=bmZ5PexVTS0SqrXP4EytZ+RH5X8p1Nep2wMg-kQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 5:39=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>
> Convert all platform drivers below drivers/cpufreq to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> given the simplicity of the individual changes I do this all in a single
> patch. I you don't agree, please tell and I will happily split it.
>
> It's based on Friday's next. Feel free to drop changes that result in
> a conflict when you come around to apply this. I'll care for the fallout
> at a later time then. (Having said that, if you use b4 am -3 and git am
> -3, there should be hardly any conflict.)
>
> Note I didn't Cc: all the individual driver maintainers to not trigger
> sending limits and spam filters.

Viresh,

I'll pick this up unless you'd prefer to apply it, so please let me know.


>  drivers/cpufreq/acpi-cpufreq.c         | 2 +-
>  drivers/cpufreq/brcmstb-avs-cpufreq.c  | 2 +-
>  drivers/cpufreq/cpufreq-dt.c           | 2 +-
>  drivers/cpufreq/davinci-cpufreq.c      | 2 +-
>  drivers/cpufreq/imx-cpufreq-dt.c       | 2 +-
>  drivers/cpufreq/imx6q-cpufreq.c        | 2 +-
>  drivers/cpufreq/kirkwood-cpufreq.c     | 2 +-
>  drivers/cpufreq/loongson3_cpufreq.c    | 2 +-
>  drivers/cpufreq/mediatek-cpufreq-hw.c  | 2 +-
>  drivers/cpufreq/omap-cpufreq.c         | 2 +-
>  drivers/cpufreq/pcc-cpufreq.c          | 2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c      | 2 +-
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 2 +-
>  drivers/cpufreq/qoriq-cpufreq.c        | 2 +-
>  drivers/cpufreq/raspberrypi-cpufreq.c  | 2 +-
>  drivers/cpufreq/scpi-cpufreq.c         | 2 +-
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 2 +-
>  drivers/cpufreq/tegra186-cpufreq.c     | 2 +-
>  drivers/cpufreq/tegra194-cpufreq.c     | 2 +-
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 2 +-
>  20 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 0f04feb6cafa..433eb597c2b8 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -1028,7 +1028,7 @@ static struct platform_driver acpi_cpufreq_platdrv =
=3D {
>         .driver =3D {
>                 .name   =3D "acpi-cpufreq",
>         },
> -       .remove_new     =3D acpi_cpufreq_remove,
> +       .remove =3D acpi_cpufreq_remove,
>  };
>
>  static int __init acpi_cpufreq_init(void)
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcm=
stb-avs-cpufreq.c
> index ea8438550b49..5d03a295a085 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -777,7 +777,7 @@ static struct platform_driver brcm_avs_cpufreq_platdr=
v =3D {
>                 .of_match_table =3D brcm_avs_cpufreq_match,
>         },
>         .probe          =3D brcm_avs_cpufreq_probe,
> -       .remove_new     =3D brcm_avs_cpufreq_remove,
> +       .remove         =3D brcm_avs_cpufreq_remove,
>  };
>  module_platform_driver(brcm_avs_cpufreq_platdrv);
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 983443396f8f..3a7c3372bda7 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -345,7 +345,7 @@ static struct platform_driver dt_cpufreq_platdrv =3D =
{
>                 .name   =3D "cpufreq-dt",
>         },
>         .probe          =3D dt_cpufreq_probe,
> -       .remove_new     =3D dt_cpufreq_remove,
> +       .remove         =3D dt_cpufreq_remove,
>  };
>  module_platform_driver(dt_cpufreq_platdrv);
>
> diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-=
cpufreq.c
> index 7d2754411d8c..8736be3a06ce 100644
> --- a/drivers/cpufreq/davinci-cpufreq.c
> +++ b/drivers/cpufreq/davinci-cpufreq.c
> @@ -145,7 +145,7 @@ static struct platform_driver davinci_cpufreq_driver =
=3D {
>         .driver =3D {
>                 .name    =3D "cpufreq-davinci",
>         },
> -       .remove_new =3D __exit_p(davinci_cpufreq_remove),
> +       .remove =3D __exit_p(davinci_cpufreq_remove),
>  };
>
>  int __init davinci_cpufreq_init(void)
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufr=
eq-dt.c
> index 577bb9e2f112..1492c92ffc1a 100644
> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> @@ -183,7 +183,7 @@ static void imx_cpufreq_dt_remove(struct platform_dev=
ice *pdev)
>
>  static struct platform_driver imx_cpufreq_dt_driver =3D {
>         .probe =3D imx_cpufreq_dt_probe,
> -       .remove_new =3D imx_cpufreq_dt_remove,
> +       .remove =3D imx_cpufreq_dt_remove,
>         .driver =3D {
>                 .name =3D "imx-cpufreq-dt",
>         },
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpuf=
req.c
> index c20d3ecc5a81..f3c99f378ad6 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -522,7 +522,7 @@ static struct platform_driver imx6q_cpufreq_platdrv =
=3D {
>                 .name   =3D "imx6q-cpufreq",
>         },
>         .probe          =3D imx6q_cpufreq_probe,
> -       .remove_new     =3D imx6q_cpufreq_remove,
> +       .remove         =3D imx6q_cpufreq_remove,
>  };
>  module_platform_driver(imx6q_cpufreq_platdrv);
>
> diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwoo=
d-cpufreq.c
> index fd20b986d1f2..312f2654d1d5 100644
> --- a/drivers/cpufreq/kirkwood-cpufreq.c
> +++ b/drivers/cpufreq/kirkwood-cpufreq.c
> @@ -189,7 +189,7 @@ static void kirkwood_cpufreq_remove(struct platform_d=
evice *pdev)
>
>  static struct platform_driver kirkwood_cpufreq_platform_driver =3D {
>         .probe =3D kirkwood_cpufreq_probe,
> -       .remove_new =3D kirkwood_cpufreq_remove,
> +       .remove =3D kirkwood_cpufreq_remove,
>         .driver =3D {
>                 .name =3D "kirkwood-cpufreq",
>         },
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongs=
on3_cpufreq.c
> index 6b5e6798d9a2..61ebebf69455 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -386,7 +386,7 @@ static struct platform_driver loongson3_platform_driv=
er =3D {
>         },
>         .id_table =3D cpufreq_id_table,
>         .probe =3D loongson3_cpufreq_probe,
> -       .remove_new =3D loongson3_cpufreq_remove,
> +       .remove =3D loongson3_cpufreq_remove,
>  };
>  module_platform_driver(loongson3_platform_driver);
>
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/medi=
atek-cpufreq-hw.c
> index 8925e096d5b9..f7db5f4ad306 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -344,7 +344,7 @@ MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);
>
>  static struct platform_driver mtk_cpufreq_hw_driver =3D {
>         .probe =3D mtk_cpufreq_hw_driver_probe,
> -       .remove_new =3D mtk_cpufreq_hw_driver_remove,
> +       .remove =3D mtk_cpufreq_hw_driver_remove,
>         .driver =3D {
>                 .name =3D "mtk-cpufreq-hw",
>                 .of_match_table =3D mtk_cpufreq_hw_match,
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufre=
q.c
> index de8be0a8932d..106220c0fd11 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -188,7 +188,7 @@ static struct platform_driver omap_cpufreq_platdrv =
=3D {
>                 .name   =3D "omap-cpufreq",
>         },
>         .probe          =3D omap_cpufreq_probe,
> -       .remove_new     =3D omap_cpufreq_remove,
> +       .remove         =3D omap_cpufreq_remove,
>  };
>  module_platform_driver(omap_cpufreq_platdrv);
>
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.=
c
> index 771efbf51a48..ac2e90a65f0c 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -615,7 +615,7 @@ static struct platform_driver pcc_cpufreq_platdrv =3D=
 {
>         .driver =3D {
>                 .name   =3D "pcc-cpufreq",
>         },
> -       .remove_new     =3D pcc_cpufreq_remove,
> +       .remove         =3D pcc_cpufreq_remove,
>  };
>
>  static int __init pcc_cpufreq_init(void)
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpu=
freq-hw.c
> index 900d6844c43d..98129565acb8 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -736,7 +736,7 @@ static void qcom_cpufreq_hw_driver_remove(struct plat=
form_device *pdev)
>
>  static struct platform_driver qcom_cpufreq_hw_driver =3D {
>         .probe =3D qcom_cpufreq_hw_driver_probe,
> -       .remove_new =3D qcom_cpufreq_hw_driver_remove,
> +       .remove =3D qcom_cpufreq_hw_driver_remove,
>         .driver =3D {
>                 .name =3D "qcom-cpufreq-hw",
>                 .of_match_table =3D qcom_cpufreq_hw_match,
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-=
cpufreq-nvmem.c
> index ae556d5ba231..3a8ed723a23e 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -578,7 +578,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qcom_cpufreq_pm_ops, =
qcom_cpufreq_suspend, NULL)
>
>  static struct platform_driver qcom_cpufreq_driver =3D {
>         .probe =3D qcom_cpufreq_probe,
> -       .remove_new =3D qcom_cpufreq_remove,
> +       .remove =3D qcom_cpufreq_remove,
>         .driver =3D {
>                 .name =3D "qcom-cpufreq-nvmem",
>                 .pm =3D pm_sleep_ptr(&qcom_cpufreq_pm_ops),
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpuf=
req.c
> index 3519bf34d397..a37ce051236c 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -296,7 +296,7 @@ static struct platform_driver qoriq_cpufreq_platform_=
driver =3D {
>                 .name =3D "qoriq-cpufreq",
>         },
>         .probe =3D qoriq_cpufreq_probe,
> -       .remove_new =3D qoriq_cpufreq_remove,
> +       .remove =3D qoriq_cpufreq_remove,
>  };
>  module_platform_driver(qoriq_cpufreq_platform_driver);
>
> diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/rasp=
berrypi-cpufreq.c
> index e0705cc9a57d..5050932954e3 100644
> --- a/drivers/cpufreq/raspberrypi-cpufreq.c
> +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> @@ -85,7 +85,7 @@ static struct platform_driver raspberrypi_cpufreq_drive=
r =3D {
>                 .name =3D "raspberrypi-cpufreq",
>         },
>         .probe          =3D raspberrypi_cpufreq_probe,
> -       .remove_new     =3D raspberrypi_cpufreq_remove,
> +       .remove         =3D raspberrypi_cpufreq_remove,
>  };
>  module_platform_driver(raspberrypi_cpufreq_driver);
>
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufre=
q.c
> index 8d73e6e8be2a..cd89c1b9832c 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -217,7 +217,7 @@ static struct platform_driver scpi_cpufreq_platdrv =
=3D {
>                 .name   =3D "scpi-cpufreq",
>         },
>         .probe          =3D scpi_cpufreq_probe,
> -       .remove_new     =3D scpi_cpufreq_remove,
> +       .remove         =3D scpi_cpufreq_remove,
>  };
>  module_platform_driver(scpi_cpufreq_platdrv);
>
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun=
50i-cpufreq-nvmem.c
> index 293921acec93..352e1a69a85e 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -283,7 +283,7 @@ static void sun50i_cpufreq_nvmem_remove(struct platfo=
rm_device *pdev)
>
>  static struct platform_driver sun50i_cpufreq_driver =3D {
>         .probe =3D sun50i_cpufreq_nvmem_probe,
> -       .remove_new =3D sun50i_cpufreq_nvmem_remove,
> +       .remove =3D sun50i_cpufreq_nvmem_remove,
>         .driver =3D {
>                 .name =3D "sun50i-cpufreq-nvmem",
>         },
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra18=
6-cpufreq.c
> index 7b8fcfa55038..c7761eb99f3c 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -276,7 +276,7 @@ static struct platform_driver tegra186_cpufreq_platfo=
rm_driver =3D {
>                 .of_match_table =3D tegra186_cpufreq_of_match,
>         },
>         .probe =3D tegra186_cpufreq_probe,
> -       .remove_new =3D tegra186_cpufreq_remove,
> +       .remove =3D tegra186_cpufreq_remove,
>  };
>  module_platform_driver(tegra186_cpufreq_platform_driver);
>
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra19=
4-cpufreq.c
> index 07ea7ed61b68..9055dd398e7f 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -818,7 +818,7 @@ static struct platform_driver tegra194_ccplex_driver =
=3D {
>                 .of_match_table =3D tegra194_cpufreq_of_match,
>         },
>         .probe =3D tegra194_cpufreq_probe,
> -       .remove_new =3D tegra194_cpufreq_remove,
> +       .remove =3D tegra194_cpufreq_remove,
>  };
>  module_platform_driver(tegra194_ccplex_driver);
>
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vex=
press-spc-cpufreq.c
> index 3fadf536c429..0f86cdb7ec8a 100644
> --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -565,7 +565,7 @@ static struct platform_driver ve_spc_cpufreq_platdrv =
=3D {
>                 .name   =3D "vexpress-spc-cpufreq",
>         },
>         .probe          =3D ve_spc_cpufreq_probe,
> -       .remove_new     =3D ve_spc_cpufreq_remove,
> +       .remove         =3D ve_spc_cpufreq_remove,
>  };
>  module_platform_driver(ve_spc_cpufreq_platdrv);
>
>
> base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> --
> 2.45.2
>

