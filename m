Return-Path: <linux-pm+bounces-27084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E76F2AB59CC
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EF31B62BDD
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506872BE7A7;
	Tue, 13 May 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghnA84IH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6BF15533F
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153588; cv=none; b=nLZiqTm6izgJOu5DdqD9u7GMQ42ohMbO/gvuBN/EtPecOesZ47HCjGUoYOw/WqB0GR/bPgs/iU5kSxOfvkdcf2YKmjbGG0zN7p4CHm8jqP9vdS8C3G+XhDmejjxmbElL4e/SX8mt6PfsXSw8TtqQOtzxum50BgHKvNC6sBPl3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153588; c=relaxed/simple;
	bh=ga3zCv76QkUCBLxG+3obr75Z66d/dc+j2DqdsPQXh0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaDAxqSbnCDcjca6n+yQhqTXDY+6kLLtwC6qk4YNpd2JhvpkYskoXvINKI5SCtjWLjYckpAS5vTaeVRlGRewihyXItfRzMm8oYBWO02jDGNssU6kbcUrhRvuGF+6rK7SF5xBI5lvnj6Ydm6yZU+g8gSfaKTytwkXxR3L3VbZX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghnA84IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1781C4CEE9
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747153587;
	bh=ga3zCv76QkUCBLxG+3obr75Z66d/dc+j2DqdsPQXh0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ghnA84IHlg7O22yhptVGd5Vo4K2suyTcvlb+dB5s7Xg4X6SCKx0ZtMdwAnmiIGhrH
	 M868zaiZXQjfGDXf9pX+lD9EQ9T5uT9qwj6inycMkJOrwftBuYfzqwRkK1PToW2PZs
	 RYNCKFYf3234mnyWthq+oKNmQQvb8i58T5ANMMw1R8pSUmTgMPX1KuXrfKOLRSumu4
	 Y/Lg0OuxA6RGFWAgVYErB6RT1wwV+AFVxlYEKgJ6/v10H8Ksf7D8azLajSyucjEEwe
	 mWxhdjJIYEZ+LQTq5P2LTa366AGYaAE9nvfu0kzlc/FZxK0WpLPebLv/Wk5X+aA5O9
	 LGfIdhM7MlxpQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso11849085a12.1
        for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 09:26:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOFCRlYGYkKwiaKzofLtshW0JRxt9gIdSUyfja13D0xflQvlrd6HbnEEOkoilADLW2p5JGN2gmvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8i/GWh+cnZv1hGvfqvjDRWneUbTOtOvMT2dKWCGZwK5PIW7O
	ChDESERvFPZDg+T/C9rXNZdcraC10KhY2Lxa9BsV9V5/ahqrDaEUSTuRRwNqXBK5v6TWaIaGMVw
	NBYOjl3rQ0RIPYVj2acFnQ51LOfg=
X-Google-Smtp-Source: AGHT+IGLphKmJHdSpxiAM6EZINozmZaCBpRvN/kTcv+//ma0V7JmmF8efQr+QHrkewteuL8JarBqgc1UuBNDbXrxzSs=
X-Received: by 2002:a17:907:d17:b0:ad4:f6d3:a188 with SMTP id
 a640c23a62f3a-ad4f755173bmr20068366b.46.1747153586566; Tue, 13 May 2025
 09:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512082938.97110-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250512082938.97110-2-u.kleine-koenig@baylibre.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Wed, 14 May 2025 01:25:51 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2uk-6-R5QNZwsssQ1UtnqexKeo=e=SsXB26NMwqf8c9g@mail.gmail.com>
X-Gm-Features: AX0GCFv7rFmK8zZwyel010vviBuZuUDkrqDnxqcGo43EqBsoQ0TBQM5VkdZiclQ
Message-ID: <CAGTfZH2uk-6-R5QNZwsssQ1UtnqexKeo=e=SsXB26NMwqf8c9g@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: sun8i-a33-mbus: Fix misconversion to devm_clk_rate_exclusive_get()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Instead of fix-up patch, I'd like you to send the v2 of patch[1].
[1] https://patchwork.kernel.org/project/linux-pm/patch/20241111112237.3363=
10-2-u.kleine-koenig@baylibre.com/



On Mon, May 12, 2025 at 5:29=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> The patch converting the driver to make more use of devm functions got
> one conversion wrong making the driver not compilable any more. I have
> no excuse, mea culpa!
>
> Fix this by adding the needed device parameter.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202412070231.MzXdNrLv-lkp@intel.com
> Fixes: bc253b28a365 ("PM / devfreq: sun8i-a33-mbus: Simplify by using mor=
e devm functions")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/devfreq/sun8i-a33-mbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33=
-mbus.c
> index f99af530211d..4bd5657558d6 100644
> --- a/drivers/devfreq/sun8i-a33-mbus.c
> +++ b/drivers/devfreq/sun8i-a33-mbus.c
> @@ -381,7 +381,7 @@ static int sun8i_a33_mbus_probe(struct platform_devic=
e *pdev)
>                 return dev_err_probe(dev, ret, "failed to lock dram clock=
 rate\n");
>
>         /* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
> -       ret =3D devm_clk_rate_exclusive_get(priv->clk_mbus);
> +       ret =3D devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to lock mbus clock=
 rate\n");
>
> --
> 2.47.2
>



--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

