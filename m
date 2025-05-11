Return-Path: <linux-pm+bounces-27012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0BBAB283D
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818601895E6E
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256AE1519B8;
	Sun, 11 May 2025 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVdMeWgS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3C19C54F
	for <linux-pm@vger.kernel.org>; Sun, 11 May 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746967155; cv=none; b=RUmiWscOlmbTPjWNWN7xGlUzGs0tYxbYcbl8ga90/+Iwrx16b+FbfIGc1BvMGd2oFOlEkih8oPycigcAJEPQfGmf357LH4SdMmZHnEpaCkrtw6ia527lbXnbawm02ioJ64fAPb7W3+uiGw+g8NAweOj/hYHYANodlaWSt9U6lHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746967155; c=relaxed/simple;
	bh=jhQ5SAEJJF3qUfy6D5IHr1j1BdMfMHXPzSP1qRil+xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiILTjL4KNbyzlQFLHkZcaIhSTnHFF2tu44QH+CYGQcQXY3HEaqJ8QAeyEb6vho/BDxSisckt51ngWeYWcseyCxyK1TGRfSTrZOnpUY35CvwAMIXC+wZYMa1QHe+/ZSz02z+vE0umIzjm5JVd5k9I/wFdNObXQ9at4YuLfRP9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVdMeWgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D3EC4CEEF
	for <linux-pm@vger.kernel.org>; Sun, 11 May 2025 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746967154;
	bh=jhQ5SAEJJF3qUfy6D5IHr1j1BdMfMHXPzSP1qRil+xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HVdMeWgSodlOQnOyxyn/G6NScVBNK/Y1Wmovg68lrItlJZEt+ZD59ixdXwNYivUPT
	 pI091Rmly570u4l5qTu5g8xKK23ttB2HJWyXZdemlZ8PQ3xLbAjsqKVv6Ql73MoGpq
	 Et/z8yHbPMnuC9L0EXtP8PYt8tGVKt8+J7tgC8epvbKtsGqTtDwpa8+OI4ScYKnnlw
	 vP7+Owk8Ywfm/Tgh9zsBzGsZwjWJZ0nQFVXInDh+pV1T7vP1lhK8FU1gGQVy6njI31
	 57fi3/yLUAFcueDt40I5TuMwUsz9NcaPBvL0DBPCy9/54KK2UmwxoKKWjaDBbCJfXS
	 jTtWMqAL6/qcw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-400fa6eafa9so2568335b6e.1
        for <linux-pm@vger.kernel.org>; Sun, 11 May 2025 05:39:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxRP2PAPFLN0XVi+/2eZ5Fj4Uyp+jrzHE/FGqBUmOcE1Jy1PTpTSlFSlyirZJhBufXVYpTR3dmEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnQJ9H+Lum/ofCPbWo4X7wBv3ZDCabLy4cIIlTeuixTL3o8pB
	T99c2X9D/DiOqoZxjuKreAytMzLezAjrLh14zIDHNagjnGfkgDv+5BwcWZU3+FnaXHDN/l0wgy7
	XrLrSxf0lwIwJnY3f7DmPO+vSLi0=
X-Google-Smtp-Source: AGHT+IF7frhH9fByp3nqkp8f/ToldoQoeo1EQiod3AeYHymrByNbZlMh+WjPHSM8WDiv77VlPQFYxVdDFh6afTzXars=
X-Received: by 2002:a05:6808:80c7:b0:401:e6c0:3112 with SMTP id
 5614622812f47-4037fe3b729mr6449007b6e.15.1746967153770; Sun, 11 May 2025
 05:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111112237.336310-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241111112237.336310-2-u.kleine-koenig@baylibre.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 11 May 2025 21:38:36 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1qMMO3ou4cxwaUoah7jS18nu7Y9kgYyraZ9e7jfjrp_A@mail.gmail.com>
X-Gm-Features: AX0GCFubjq5u_HzT96chHqqtsl5Hck05kSg1tAuxI0qgXnWh6f_KB3_n-4XXW9o
Message-ID: <CAGTfZH1qMMO3ou4cxwaUoah7jS18nu7Y9kgYyraZ9e7jfjrp_A@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. I'm sorry for late reply

Thanks.

On Mon, Nov 11, 2024 at 8:25=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Use devm allocators for enabling the bus clock and
> clk_rate_exclusive_get(). This simplifies error handling and the remove
> callback.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/devfreq/sun8i-a33-mbus.c | 38 ++++++++------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33=
-mbus.c
> index bcf654f4ff96..5b630c6e602e 100644
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
> +       ret =3D devm_clk_rate_exclusive_get(priv->clk_mbus);
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
> base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
> --
> 2.45.2
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

