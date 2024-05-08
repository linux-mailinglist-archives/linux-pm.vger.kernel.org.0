Return-Path: <linux-pm+bounces-7662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E8A8C0131
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA7284EFD
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4ED127E11;
	Wed,  8 May 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBwou4AL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5031A2C05;
	Wed,  8 May 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183008; cv=none; b=UmwJkaPrOIFp8XXhznNpr1DJMn7EoN/HE8e4KAP0UIRJy3G0cL2d+UTsndftInZa7GThjeT+O5ONeE2ytqwSrwRvfIC0vMBdCnUuOwIp2FbzspW1kxu1EBvpRbtAkd8LMpj3UXnbSIQT+2tNNs5kI9XPfIeN2rKR/bGbwhgDqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183008; c=relaxed/simple;
	bh=WGEKQNPsGIlqGJkiD5yTGPTYvZOR4IkHFj8Rd9RX0so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFwdFn8uBrEWNslNXwjJHuvbwi2DZ28ByKuQ6iYGplPogR3BnCRyEwNlJhY6OH+6dgUWUVIGlOYowkkIeoqKqPApaxWIcGoWSiIzll/fRZGpHaY/R+daltSjELC/fTnBhyWi7D/oHv5+iwwSvZDyYYTsrnPTugiT0OXC3b7aj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBwou4AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAE9C32782;
	Wed,  8 May 2024 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715183008;
	bh=WGEKQNPsGIlqGJkiD5yTGPTYvZOR4IkHFj8Rd9RX0so=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IBwou4ALRHngYqW5G0hJhXy6VE0u/AjCPSHpeMFfmzmaKw4Tv3Nkb5Ird/gKkkx6q
	 uKX6CxEPS3Yl5S3bqccKe6wkqwhGkyou7o2rwZcw+yS/KYk+Tf26maA4z/6bYFtp5m
	 4ZX0XWa1zLOpSDN21ErmpndKQ8PuNAoI1a+EZF9VWDI0C2CV2dFGdyRgJ5S2xpudhc
	 P4TuXDcQDLvCoihgTp9hG4I2+G87H3xKkSjoZjG0SRdu4Q3pp0PpyZRaczEGXEhCzX
	 WpAkHisB0WsMqZaMsHRS5eu/QHz1LBNd3up24r8Q1o8RXvqKtthovUNGWnREpoxVpQ
	 P6qaLKj7idS0Q==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b21e393debso1872626eaf.2;
        Wed, 08 May 2024 08:43:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAjoYYOjTtsSYL4qHp3gA7YgLuqF9YuSEutOwdgPAiUPV0Q+wZv1rgd3uFtJXC+xRMMp/T2qre6BvCzDbWfTHWmmdu7lrciolzWSZWJjBE1xpQIPWnXyZ8y8IFUuAt9Hsj8IYLEAjshHkXf2ZUBXG2hrVSkhIKQC6mZfHmdoAgcW4/mw4QS9dG2g==
X-Gm-Message-State: AOJu0YwuIljzbQ9jLk96jUAEyXOX4y6VYq10wjsRT0MuyhM8k8nt/Zeq
	JXGMJ3wwQG9brCjElLmPs9YwrI+4ziUvDg2NmE74/GjE5wxwagXbCzKlQaUIeqkIft5qETdVUZE
	dG/lcTyJl14I4YzY9XCQosWRFWsY=
X-Google-Smtp-Source: AGHT+IFh3i/3YYN7HOjr7Z5K1kyZwtyQs0WZfT1Cnebhuxii0Mfhb2g2OLKNcu0NGeFk7XBJcaJ+Iau8whhmKGNLqi0=
X-Received: by 2002:a4a:aaca:0:b0:5b2:a5b:a88b with SMTP id
 006d021491bc7-5b24d110a4emr2651009eaf.2.1715183007358; Wed, 08 May 2024
 08:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417044459.1908-1-linux.amoon@gmail.com> <20240417044459.1908-2-linux.amoon@gmail.com>
In-Reply-To: <20240417044459.1908-2-linux.amoon@gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Thu, 9 May 2024 00:42:50 +0900
X-Gmail-Original-Message-ID: <CAGTfZH08WoMpBxw6JRsjobYsh-e1CAuddwp4j1DQOTTvAwtS=A@mail.gmail.com>
Message-ID: <CAGTfZH08WoMpBxw6JRsjobYsh-e1CAuddwp4j1DQOTTvAwtS=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM / devfreq: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS
 for PM functions
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
> This macro has the advantage over SET_SYSTEM_SLEEP_PM_OPS that we don't
> have to care about when the functions are actually used.
>
> Also make use of pm_sleep_ptr() to discard all PM_SLEEP related
> stuff if CONFIG_PM_SLEEP isn't enabled.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v3: fix using new DEFINE_SIMPLE_DEV_PM_OPS PM macro hence
>     change the $subject and the commit message
>
> v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM
>    is disabled
> ---
>  drivers/devfreq/exynos-bus.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 153340b6685f..b89e04eb8430 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -454,7 +454,6 @@ static void exynos_bus_shutdown(struct platform_devic=
e *pdev)
>         devfreq_suspend_device(bus->devfreq);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int exynos_bus_resume(struct device *dev)
>  {
>         struct exynos_bus *bus =3D dev_get_drvdata(dev);
> @@ -482,11 +481,9 @@ static int exynos_bus_suspend(struct device *dev)
>
>         return 0;
>  }
> -#endif
>
> -static const struct dev_pm_ops exynos_bus_pm =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(exynos_bus_suspend, exynos_bus_resume)
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(exynos_bus_pm,
> +                               exynos_bus_suspend, exynos_bus_resume);
>
>  static const struct of_device_id exynos_bus_of_match[] =3D {
>         { .compatible =3D "samsung,exynos-bus", },
> @@ -499,7 +496,7 @@ static struct platform_driver exynos_bus_platdrv =3D =
{
>         .shutdown       =3D exynos_bus_shutdown,
>         .driver =3D {
>                 .name   =3D "exynos-bus",
> -               .pm     =3D &exynos_bus_pm,
> +               .pm     =3D pm_sleep_ptr(&exynos_bus_pm),
>                 .of_match_table =3D exynos_bus_of_match,
>         },
>  };
> --
> 2.44.0
>
>

Applied it. Thanks.

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

