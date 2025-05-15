Return-Path: <linux-pm+bounces-27200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F1AB8995
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102A03A4B31
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C331E521E;
	Thu, 15 May 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlUNeyHg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB41E3775
	for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319929; cv=none; b=q+vMQlaKXnnWL4IHUfezlATDbnWbhL7QiCPS567IELbeP7otFkNECwhx3YBR0t9DDt1ANxyL/Oe9rmOsfoISlhp4qILqIl6UkXlEXYlQUC1ZMFweVzL0q6lAul3yMfY8IIbQhpclEgbRtXVB1pBNlcIP9Q1Sed3Zq1t7AWt7clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319929; c=relaxed/simple;
	bh=HY+qJgM0yYWWR5BRYJcoqs5QSVlkgtqqpbluFMxs0w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhIVM/TX0DWTEa9EZPAF2ZIIrewa98ZmRlgdfRBZeh0cfmbyPk+GcLkXDVwcLsgZUsPwjvuOYi/v+yQO4c3NxjqqPOpEuO6aTmVySSJ/E28uMA0J47ec7FE8U/tloTiKzvfYKkENKJwWshp7OKYYA/1xrdSlq1Vk/eDy/Z7JDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlUNeyHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2758AC4AF09
	for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747319927;
	bh=HY+qJgM0yYWWR5BRYJcoqs5QSVlkgtqqpbluFMxs0w0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XlUNeyHgu1WgqlfjtdehqwZSsxtnbh5JxSjmDdvRvzZIC8dHMp5ZlM3q6gHbE+u0m
	 uWXcNeLT3nQUFcAMydn4hY1VrshtDY1S2MMtFt4TdtmlkRdxfZHqHITwT+V2Ww4LJt
	 rAWa1bPaQ6kuHRnrx7YIe9uWu2XGmjdyzgVODAirrQ0DWUxL4tMOAc7ZhA+LzEpxsb
	 Gpk8gBy0XGQYuyEWsYVtfEZGyQes+VbSai4YAQNKM6TqY0mbEpKeyZ8EhPJ9TVeppt
	 qSlF6NXfthVpAxgzDOezmIxq0q0mzmV78hFXz/h1H4cnZZkEeTKKG5dCxs3BH6RWP2
	 dZ1Kf0pmIbXmg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60634f82c77so370681eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 07:38:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPk6aaI5Iq1nnX8fKFlbUbSITmchQ7WL64JeymwKPyHSKy6maXp233UC5MbLe1Mx3DjiyCnpFMPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysCDOBSc+YVcWxi4BmySJPUt6K35/cSJKbtRh7fOM7lwcWkEie
	jmWOX8I0VkfBNnZcKz8+g69PXs0KYhFxOZVMA4Se7WSn44kXDBYmsgiIOXQQZajQ3XFp1YOm7yO
	ZJ7bVn6nWff5JSFRZQM7Bc7GWvt4=
X-Google-Smtp-Source: AGHT+IHGdjpe73oLpoH8fkWYunyQ+qiWvEA5aPtzHTJu6wWW6p5XtqkX8NoQ0qeCaUyT8XvFkMDBDMNOpym6MJAH8Cs=
X-Received: by 2002:a05:6820:98d:b0:603:fada:ac53 with SMTP id
 006d021491bc7-609ec1f446dmr1516987eaf.2.1747319926526; Thu, 15 May 2025
 07:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513203908.205060-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250513203908.205060-2-u.kleine-koenig@baylibre.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Thu, 15 May 2025 23:38:11 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2jVrD_Bfu3NZJ+vNdQCjdxo4vygxWob+h0VasyxUa4gA@mail.gmail.com>
X-Gm-Features: AX0GCFuopvJHbf-CNvM7N5xp7U1FlvHL3EE-1-DaHwbFHrhtaHm-zDV1Ez_RZWI
Message-ID: <CAGTfZH2jVrD_Bfu3NZJ+vNdQCjdxo4vygxWob+h0VasyxUa4gA@mail.gmail.com>
Subject: Re: [PATCH v2] PM / devfreq: sun8i-a33-mbus: Simplify by using more
 devm functions
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 5:39=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit

Applied it after removing the above unneeded information.

Thanks,

>
> Use devm allocators for enabling the bus clock and
> clk_rate_exclusive_get(). This simplifies error handling and the remove
> callback.
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> On Wed, May 14, 2025 at 01:25:51AM +0900, Chanwoo Choi wrote in the
> thread at
> https://lore.kernel.org/linux-pm/CAGTfZH2uk-6-R5QNZwsssQ1UtnqexKeo=3De=3D=
SsXB26NMwqf8c9g@mail.gmail.com:
> > Instead of fix-up patch, I'd like you to send the v2 of patch[1].
> > [1] https://patchwork.kernel.org/project/linux-pm/patch/20241111112237.=
336310-2-u.kleine-koenig@baylibre.com/
>
> Ah, then I misunderstood. Here comes the requested v2. The changes since
> (implicit) v1 are:
>
>  - Fix the build failure that I introduced by forgetting to add the dev
>    parameter to devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
>
>  - Added the Reviewed-by tag for Chen-Yu.
>
>  - Actually compile tested. I would have sworn I did that for v1
>    already, but that is proven to be a perjury now. Don't know how that
>    slipped through.
>
> Best regards and again sorry for the mess
> Uwe
>
>  drivers/devfreq/sun8i-a33-mbus.c | 38 ++++++++------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33=
-mbus.c
> index 7c6ae91ede1f..4bd5657558d6 100644
> --- a/drivers/devfreq/sun8i-a33-mbus.c
> +++ b/drivers/devfreq/sun8i-a33-mbus.c
> @@ -360,7 +360,7 @@ static int sun8i_a33_mbus_probe(struct platform_devic=
e *pdev)
>         if (IS_ERR(priv->reg_mbus))
>                 return PTR_ERR(priv->reg_mbus);
>
> -       priv->clk_bus =3D devm_clk_get(dev, "bus");
> +       priv->clk_bus =3D devm_clk_get_enabled(dev, "bus");
>         if (IS_ERR(priv->clk_bus))
>                 return dev_err_probe(dev, PTR_ERR(priv->clk_bus),
>                                      "failed to get bus clock\n");
> @@ -375,24 +375,15 @@ static int sun8i_a33_mbus_probe(struct platform_dev=
ice *pdev)
>                 return dev_err_probe(dev, PTR_ERR(priv->clk_mbus),
>                                      "failed to get mbus clock\n");
>
> -       ret =3D clk_prepare_enable(priv->clk_bus);
> -       if (ret)
> -               return dev_err_probe(dev, ret,
> -                                    "failed to enable bus clock\n");
> -
>         /* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
> -       ret =3D clk_rate_exclusive_get(priv->clk_dram);
> -       if (ret) {
> -               err =3D "failed to lock dram clock rate\n";
> -               goto err_disable_bus;
> -       }
> +       ret =3D devm_clk_rate_exclusive_get(dev, priv->clk_dram);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to lock dram clock=
 rate\n");
>
>         /* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
> -       ret =3D clk_rate_exclusive_get(priv->clk_mbus);
> -       if (ret) {
> -               err =3D "failed to lock mbus clock rate\n";
> -               goto err_unlock_dram;
> -       }
> +       ret =3D devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to lock mbus clock=
 rate\n");
>
>         priv->gov_data.upthreshold      =3D 10;
>         priv->gov_data.downdifferential =3D  5;
> @@ -405,10 +396,8 @@ static int sun8i_a33_mbus_probe(struct platform_devi=
ce *pdev)
>         priv->profile.max_state         =3D max_state;
>
>         ret =3D devm_pm_opp_set_clkname(dev, "dram");
> -       if (ret) {
> -               err =3D "failed to add OPP table\n";
> -               goto err_unlock_mbus;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to add OPP table\n=
");
>
>         base_freq =3D clk_get_rate(clk_get_parent(priv->clk_dram));
>         for (i =3D 0; i < max_state; ++i) {
> @@ -448,12 +437,6 @@ static int sun8i_a33_mbus_probe(struct platform_devi=
ce *pdev)
>
>  err_remove_opps:
>         dev_pm_opp_remove_all_dynamic(dev);
> -err_unlock_mbus:
> -       clk_rate_exclusive_put(priv->clk_mbus);
> -err_unlock_dram:
> -       clk_rate_exclusive_put(priv->clk_dram);
> -err_disable_bus:
> -       clk_disable_unprepare(priv->clk_bus);
>
>         return dev_err_probe(dev, ret, err);
>  }
> @@ -472,9 +455,6 @@ static void sun8i_a33_mbus_remove(struct platform_dev=
ice *pdev)
>                 dev_warn(dev, "failed to restore DRAM frequency: %d\n", r=
et);
>
>         dev_pm_opp_remove_all_dynamic(dev);
> -       clk_rate_exclusive_put(priv->clk_mbus);
> -       clk_rate_exclusive_put(priv->clk_dram);
> -       clk_disable_unprepare(priv->clk_bus);
>  }
>
>  static const struct sun8i_a33_mbus_variant sun50i_a64_mbus =3D {
>
> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
> --
> 2.47.2
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

