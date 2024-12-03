Return-Path: <linux-pm+bounces-18479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEB79E2955
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B54BC3E83
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF0204F6E;
	Tue,  3 Dec 2024 15:36:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273271F76AE
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240213; cv=none; b=O3teNs6dLX5ss6DChe1G6c6LXCBpRyqWlKKx3wbPyvSqFZZBR9f5VIXNACX/r05JwLB+lj5rKOwwIno+Se//C5HoivY/Gn6xJi99LS05+L4P8S024CDGMn86BIaDpqckzVqsPxj1Uh07gXGQh+iYfAinshUh3e4PfhP30aykynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240213; c=relaxed/simple;
	bh=8cI36BzhHV8HgXQu/TVym++uvxOl9i6AEwSINrhZjEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DytggueFm/uyexVtxQvKOIBuS+k7f7ghcDYCxDBwDKP4HEEfExh7ghnt18tQ4ihcsfKywiphU8ZtYrGtsBbNIeo9qRoqu+4YESyhOITz8+M8QX3g5eGKgbWQbl/+3Jz2p2cU1b4aaDoqc9JnbrdESTvu+NKeZ76aIpzlf6kHyN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df80eeeedso5876567e87.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 07:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733240209; x=1733845009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dh6O5hcOma4p8AZfLng5WyXnPkEX/xU+8B4IUyvO9lw=;
        b=j5kgLFJLDG2pSrHlE8yT58OqeSJyPXW2PGNa0xDFbK9jOS6BSyzz3DUVLw3IP6D94B
         yTDeM+b3Bn2wmowhE36UDFZo5XNbtPAupTZmRgFSARSV4ZzUUPB75InTaAO8zZwVDCdC
         biBD3OylgyLZrmtamek/Uvs8XhrRRp1C/8DxXXoNnY9eKH44GURMzok6pdbxAiLq2x5o
         12yWKOr4zd6k90CPZYeS3rLFENZSLyuR3n12j3GkyACWlZQpYV9Fb+T+OiV56WVjC5Yi
         0qnmHviXPFWV8NWliKdFePntKO1qV/7gB0raiwpRBaTRBxmCxXoHvzCoMQ3JuD+wDigi
         cOvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsJotkJCQ0aRuUg3VecawT0ffkojUZ3BWql2TdAYy3QJD2dtVLSretIYJ+ML51rRQFdCzEB7HAOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FoY64FP+vIEWUh/58uyYub5bf2tW9ArRIfB09xdeCAVbAFZQ
	EEGxqC5+SOxyhbGvvR+fkbxjt0Hi7sWhWTqm/UdY1VunJQXQeVCdfnZzi43z
X-Gm-Gg: ASbGncvzdwBKDYSRKZZZZ7E04lzYia2wdZq5kIbohOn21AaBlQkF+27VMCIhLTENQHE
	zn0YEVr8BbrOupYZe2sbYRkv9L8owXcp6LRLmrVaJX2RwxXptqIl+Am6H/AEM3mgDOnDWO8I3Ct
	Vx0ysmpTFc48gD3F1HKA3GoE5F53Zwe/GTaUGij/2cTuBI7FQhlY1BVHlwGpd6OZa9jQiI4EtcY
	5nG2L1y3DEExVsGdHwFWuTaoc17F3Bu/ewTrjzM5EichwXbb0Pt2vyCH6ZMBkzaCpM63ex8ElGx
	qecbceo=
X-Google-Smtp-Source: AGHT+IE+Wf9keFJpx6nSTScWO55cEngwZlrKSXVCpLy8rkukzvtKU6oUShnToXWQzTo8E/pJJneeRw==
X-Received: by 2002:a05:6512:3c8c:b0:53d:ed63:4bdf with SMTP id 2adb3069b0e04-53e12a079fcmr1553903e87.34.1733240208644;
        Tue, 03 Dec 2024 07:36:48 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1ba299dbsm44960e87.109.2024.12.03.07.36.48
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 07:36:48 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffdf564190so65724701fa.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 07:36:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOmNcDX8ILaFePMRif+L9iHe81+pmKuiS9UjPLnJP6m37SJ/pcy7wVeMGf3VP826bFCCYaAOWomg==@vger.kernel.org
X-Received: by 2002:a2e:bc83:0:b0:2fb:955e:5c17 with SMTP id
 38308e7fff4ca-30009cc52cfmr17349571fa.40.1733240208287; Tue, 03 Dec 2024
 07:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111112237.336310-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241111112237.336310-2-u.kleine-koenig@baylibre.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 3 Dec 2024 23:36:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v65i=Ttij+pnK9nhdPzsk9kTdP0ZXS1MGboAud+QudbEDA@mail.gmail.com>
Message-ID: <CAGb2v65i=Ttij+pnK9nhdPzsk9kTdP0ZXS1MGboAud+QudbEDA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:22=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Use devm allocators for enabling the bus clock and
> clk_rate_exclusive_get(). This simplifies error handling and the remove
> callback.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

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

