Return-Path: <linux-pm+bounces-7663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135868C014E
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAA4B20A8A
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81645127E32;
	Wed,  8 May 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzchGpKm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631F8663E;
	Wed,  8 May 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183168; cv=none; b=oNBtflsqvaP0WWW0y2VQMTLWIZfxuAPk81N2r6VhGV4GTX1cOmTFAFaRYkUpmwtMUOtXxhWknM6nRsoD0fSsbQrbiCA0BKIe6xPQSWhVsUuEeRKcL246yj+cR/5ZbrT48LTWR3gIAOS16/YTjeCoqqVWnCgWLIFLw4UnJsj9VLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183168; c=relaxed/simple;
	bh=9faLKA5XKMW4fuawS5HE+LFSPeCjU5F3QYsafZQ/I0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn133RP6c2jydElxe7HUmGBgEVlIBu9obCitU+r3K3FXuLOSW+7x4+6R3ahlbyXwlml34R6sYV6XCgEY683vIvAhlH4qP4NFXZ09/yIxuGAhWL1G5tjxPIzv2I3xi5miWqZl1wCtyyNdh8se/WRJZTfXAVLJce+FyM00ga9i+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzchGpKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D275CC2BD10;
	Wed,  8 May 2024 15:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715183167;
	bh=9faLKA5XKMW4fuawS5HE+LFSPeCjU5F3QYsafZQ/I0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IzchGpKmiMUkh9d2vo19t401Ko5RhUnYizFnSNrcRBat9dYyl48IaGQWqHFog7VBf
	 1z1DpGeRlO4jCrcmj830wjF7kevP9hSbUwpByDne7owXpGRp3QT+PXaYuZpddZsp9D
	 lrz7mbVBppy297y6TrVCKctpnvqIcNC4FRhBl/y/o8GObW/jO0J5saq9PPg2DJne/i
	 YPTLsL+/64CJXdsKNt99olDUo654PphN0lCNgW76MTYR0fcePKNJS1vFIALzttqVyK
	 yljXSHqXGonORzsIv8uZ4QyRg8CZZlV5m8/ngTXEI0Jl9p2UjhpWu8nC+tiOODna7t
	 nBlYub/YfnpMQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b264f3ec79so184435eaf.3;
        Wed, 08 May 2024 08:46:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGUGQbYF7tXAVXuteKOvUTjSVLmLO3de/ziCRYTzf9QyCujXVR6GxR8r4QPlwt7csnoSP7fmB6+FzwTrQlfdkmtwv7KDzf9o9C7NdIl2Lunv/fr+D95xiVkmRnjyDhV7nkXqHEDzduW1bo2JA0BeFNWMNN7rqWx88kury6xPnBVqxFSisbIg0JPw==
X-Gm-Message-State: AOJu0YzN9WyfyRhOPebZSQbHCghlq1LgFWI+44+GLz+YYv638EPJ6P/V
	UhlexBEWR3plgiOBAQ3H76himPRrEigf472NyX+L0vFLD16PEnj4wdApPdLzpO7/IVWAmEYIACv
	t2wlqJnuPAfRBCFCj89Kw7/1MQno=
X-Google-Smtp-Source: AGHT+IGvIPQZWsqX1hgK6QcrGssTICYqXpiGpjNqL7cHyisXt5WVsp5YwTqaNCsJQHb8eEQju8hMx2CabLvoKT5VcNI=
X-Received: by 2002:a4a:b00b:0:b0:5b2:bc0:f385 with SMTP id
 006d021491bc7-5b24d81b9f1mr2671702eaf.8.1715183167259; Wed, 08 May 2024
 08:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417044459.1908-1-linux.amoon@gmail.com>
In-Reply-To: <20240417044459.1908-1-linux.amoon@gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Thu, 9 May 2024 00:45:30 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3oJQsc0XVrrA-F7NxSfKx8=mOYDM1Vvxt37+skvXZVaw@mail.gmail.com>
Message-ID: <CAGTfZH3oJQsc0XVrrA-F7NxSfKx8=mOYDM1Vvxt37+skvXZVaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM / devfreq: exynos: Use Use devm_clk_get_enabled()
 helpers
To: Anand Moon <linux.amoon@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:45=E2=80=AFPM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>
> This simplifies the code and avoids the calls to clk_disable_unprepare().
>
> While at it, use dev_err_probe consistently, and use its return value
> to return the error code.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v3 - No change
> v2 - No change
> ---
>  drivers/devfreq/exynos-bus.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 245898f1a88e..153340b6685f 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -160,7 +160,6 @@ static void exynos_bus_exit(struct device *dev)
>         platform_device_unregister(bus->icc_pdev);
>
>         dev_pm_opp_of_remove_table(dev);
> -       clk_disable_unprepare(bus->clk);
>         dev_pm_opp_put_regulators(bus->opp_token);
>  }
>
> @@ -171,7 +170,6 @@ static void exynos_bus_passive_exit(struct device *de=
v)
>         platform_device_unregister(bus->icc_pdev);
>
>         dev_pm_opp_of_remove_table(dev);
> -       clk_disable_unprepare(bus->clk);
>  }
>
>  static int exynos_bus_parent_parse_of(struct device_node *np,
> @@ -247,23 +245,15 @@ static int exynos_bus_parse_of(struct device_node *=
np,
>         int ret;
>
>         /* Get the clock to provide each bus with source clock */
> -       bus->clk =3D devm_clk_get(dev, "bus");
> -       if (IS_ERR(bus->clk)) {
> -               dev_err(dev, "failed to get bus clock\n");
> -               return PTR_ERR(bus->clk);
> -       }
> -
> -       ret =3D clk_prepare_enable(bus->clk);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to get enable clock\n");
> -               return ret;
> -       }
> +       bus->clk =3D devm_clk_get_enabled(dev, "bus");
> +       if (IS_ERR(bus->clk))
> +               return dev_err_probe(dev, PTR_ERR(bus->clk), "failed to g=
et bus clock\n");

nitpick. I recommend that better to keep 80 char on one line as following
for the readability.

               return dev_err_probe(dev, PTR_ERR(bus->clk),
                                          "failed to get bus clock\n");


>
>         /* Get the freq and voltage from OPP table to scale the bus freq =
*/
>         ret =3D dev_pm_opp_of_add_table(dev);
>         if (ret < 0) {
>                 dev_err(dev, "failed to get OPP table\n");
> -               goto err_clk;
> +               return ret;
>         }
>
>         rate =3D clk_get_rate(bus->clk);
> @@ -281,8 +271,6 @@ static int exynos_bus_parse_of(struct device_node *np=
,
>
>  err_opp:
>         dev_pm_opp_of_remove_table(dev);
> -err_clk:
> -       clk_disable_unprepare(bus->clk);
>
>         return ret;
>  }
> @@ -453,7 +441,6 @@ static int exynos_bus_probe(struct platform_device *p=
dev)
>
>  err:
>         dev_pm_opp_of_remove_table(dev);
> -       clk_disable_unprepare(bus->clk);
>  err_reg:
>         dev_pm_opp_put_regulators(bus->opp_token);
>
> --
> 2.44.0
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

