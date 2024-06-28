Return-Path: <linux-pm+bounces-10164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA191B7CD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96F61F21FCB
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 07:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ACC7F498;
	Fri, 28 Jun 2024 07:08:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66848788
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558502; cv=none; b=huT/JwdnHlwRHgTkij4PGH6Wc8nxc9syaON/2zlOjyEUOAnVmy/YGRi4J33MgH033qfMsXAgZMg+srXfWoiEvTiHMAk4L7NJf/GUfgcmz0/4iQreHX5tBOsz1zmd8yYU3LmKctTVvmCzufsTC0yar6RJmLnUSVmrqnn10C1GZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558502; c=relaxed/simple;
	bh=IW4BvU+WtkslLV6DlrajbdSUd/DH91yJLMPSAG8b9zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQ0QfL0m1ylWTE3bsgbZUndZ8Hqwb1TqL9lPzHC2PIPWowGkve+7YIUayMfCkKl7IOFbkeRibApclSViOBsf+y8LpKqQ+kGkDrkw1Xq8sXnrzRHj9K8dVZ8snUdpuye8D5L2LENFVVWAwu7ExHpBomUvnOzAK2+KbGZraa5LIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce01403f6so276486e87.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 00:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719558496; x=1720163296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zo3VHVTl7gNC6GGZIm3/Sa7uX+11Aj0WDxqixq9tZw0=;
        b=ap9PJwgxh3zuqEpiu8dVWl6u/CuEjn9Jog7ZEhDIJhEzIWLIRP5BozAiO7eZXcmw5w
         16MfQQuPkjb1SGwyYYOKClcqR7tj67nU4dAX7nzCqYnCVQ9Bt5daeF8imoz3wijSQaBN
         MFmlCgDex4wM5SV/ZhX0ymHBHYOx7hOQWRQmZ0UNzkIU2WwySZCvc9SbXX84XO7jbPH/
         g5qpWdhRv3uc3fbqoqC9VEGeky+G50eflTyu2avUOl4IDSoX06v0SDyGioZ/9pyPT0it
         myxIokBmh4tjvcO0An3tOWtFUg+Hd10U+9HYRBKFQdse7jOTqXXaKbNHx2+bGC/p6dy0
         iCVw==
X-Forwarded-Encrypted: i=1; AJvYcCXwDNlGHm/OwLrOkewN/KDX6dSNHkeoUjz8ntByl67LmQP0j4T96LcjwjmyCUz7Qv6/Y2xH8T5sGOuiZ0wrECkUa8YcB8UD7nI=
X-Gm-Message-State: AOJu0YwZpsRqKWtAzsWqSnxwItMz1zsUFmtUHgBTwZvUamVwsmJYIpMr
	c2w0riTmMyxnqY3bVio6pU4dGYl05AZ7aSO+7Mxmys6zYQgZH2jr3RkL67Q4qUs=
X-Google-Smtp-Source: AGHT+IHB6wqL691S3XA/rg2+a5nGJp+FM/W/EPKMYtIDDdMw7HOAodTqzuj5lbWyqKL+wrRgRDVNLQ==
X-Received: by 2002:a05:6512:2394:b0:52c:d84c:1182 with SMTP id 2adb3069b0e04-52ce1862c12mr11626808e87.64.1719558496217;
        Fri, 28 Jun 2024 00:08:16 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b441sm188314e87.291.2024.06.28.00.08.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:08:14 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so2309391fa.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 00:08:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAi0Y4S0cezqu9I5REFoKCu/9e7MmGNpaWU5AdAKUUimfDk3MApxLSxDb1WpyeqtLAuHnV3RsBdxkwPzEpG/Vf9v/949UvxJQ=
X-Received: by 2002:a05:651c:1991:b0:2ec:5bb2:c230 with SMTP id
 38308e7fff4ca-2ec5bb2c26bmr125219161fa.12.1719558494097; Fri, 28 Jun 2024
 00:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628061929.89273-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20240628061929.89273-2-u.kleine-koenig@baylibre.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 28 Jun 2024 15:08:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v67m7y2E1Kq8PM9AFYZvBas_kW4k_ihpY42nBTOqZqWJmQ@mail.gmail.com>
Message-ID: <CAGb2v67m7y2E1Kq8PM9AFYZvBas_kW4k_ihpY42nBTOqZqWJmQ@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: sun8i-a33-mbus: Make use of devm_ functions
 for clks
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 2:19=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Using devm_clk_get_enabled() and devm_clk_rate_exclusive_get() allows to
> simplify the error paths in .probe() and the remove callback.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/devfreq/sun8i-a33-mbus.c | 38 +++++++++-----------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33=
-mbus.c
> index bcf654f4ff96..4c179d7ddf0b 100644
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
> @@ -375,24 +375,17 @@ static int sun8i_a33_mbus_probe(struct platform_dev=
ice *pdev)
>                 return dev_err_probe(dev, PTR_ERR(priv->clk_mbus),
>                                      "failed to get mbus clock\n");
>
> -       ret =3D clk_prepare_enable(priv->clk_bus);
> +       /* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
> +       ret =3D devm_clk_rate_exclusive_get(dev, priv->clk_dram);
>         if (ret)
>                 return dev_err_probe(dev, ret,
> -                                    "failed to enable bus clock\n");
> -
> -       /* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
> -       ret =3D clk_rate_exclusive_get(priv->clk_dram);
> -       if (ret) {
> -               err =3D "failed to lock dram clock rate\n";
> -               goto err_disable_bus;
> -       }
> +                                    "failed to lock dram clock rate\n");
>
>         /* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
> -       ret =3D clk_rate_exclusive_get(priv->clk_mbus);
> -       if (ret) {
> -               err =3D "failed to lock mbus clock rate\n";
> -               goto err_unlock_dram;
> -       }
> +       ret =3D devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "failed to lock mbus clock rate\n");
>
>         priv->gov_data.upthreshold      =3D 10;
>         priv->gov_data.downdifferential =3D  5;
> @@ -405,10 +398,8 @@ static int sun8i_a33_mbus_probe(struct platform_devi=
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
> @@ -448,12 +439,6 @@ static int sun8i_a33_mbus_probe(struct platform_devi=
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
> @@ -472,9 +457,6 @@ static void sun8i_a33_mbus_remove(struct platform_dev=
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
> base-commit: 642a16ca7994a50d7de85715996a8ce171a5bdfb
> --
> 2.43.0
>

