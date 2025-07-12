Return-Path: <linux-pm+bounces-30726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 971C7B02A0D
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D277B13B9
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E426B775;
	Sat, 12 Jul 2025 08:26:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AC26B2C4;
	Sat, 12 Jul 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308762; cv=none; b=HsFTuTAPOnvkLEQ6MaQDKSbCIIbFFKEl0JsiYeXSnqYnfWzbuAj/snoVBw2GwjnHfd0UAv4uxwXHmM+HQRKBpVz1hj0CQCACS+un/Hc4VQQ04UNFZFDuPMvdctr1iFqxl/b6/+2sC5jBJ3IkrVZzrtKOiyBnX3eW4XxGxEQRQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308762; c=relaxed/simple;
	bh=ULgQmqNv8PySGk5+xltUtgTVVyz184W244B3rlM3Zvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQm6IaUe3HGdutG4qv5m0Bwwg3cNJqSILBonwMk/wxNlsBqyjE0jLJvO6CZEOod0yaZunuBE5bNCF1hrk0AnXhiYYdnZuWE0PivBX6GGP51BrRHesA36qUgbpS6fGqe9MujoAwPP/EwgGPBZpyemlX/DKkxrs1hm2LoMq4xMvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32e14cf205cso25145391fa.1;
        Sat, 12 Jul 2025 01:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752308758; x=1752913558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s8+rtQC6XpTE2vRTh9EDlBtLhS/B0Gdgn+coAVMY1wQ=;
        b=WdVrL2utg0ZkOYLKbOJgfxO2Me/XyD6uPqdgPoE+IItM8/PdrjSmKJZ2u8PKggGFER
         yC4KWcRrvD9HmDumFda1zluYjYdaP2MN8qJxsNsEzRYCi1dnwPV2Jj8xkeqbZvL+KjZ3
         h82b76puya4V+W6nGrb1ctGVq0Xwr402zQTTkkvohhBOe18sqrvz2uJ0Vc2+s8o60anf
         /S7/Ra1ACfLwe2jWQbbQiKZPayXoVCYOBN6S+sGrOnoNZAR1U6P1pVkgKYgfnSRU9ifq
         3d0uI1AhgpfClS+EKxoYOtPqNHJyzfzRPCgxf6umYsR9tdH+9JPjeAYCYG0ilLmrVUeb
         j5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUIyUdlSaVF+MqAfc1xl39htuwAoLwo53d1kfAcvk0EhgeweTsQSi5jw6yYhO5vgbgbuubX94Q/z5MZ2nrl@vger.kernel.org, AJvYcCW7vomyJDHDnE0N4iGJs5T2ku4hH7JBtzpiw9CaStmBeebqjC48xyP6u3UsOWQopJD1RDBBUSMrSsM=@vger.kernel.org, AJvYcCWvnzorh+1KQI/4u5tKrZdXVc9BVoMYrKJ8L1M5zNOkbywvUg4tGkA5iR6usgHDFI/MSjLSAvUCH+y7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rKRvk0mMTMc26+OOgUILHIkM6HiNpRbVFo0amzoj2C910DD3
	NpxlEFCRliyOfM+LiwuKMcp3Y7wygvMeGpJOwzI4FqDtkeadI+CF5HTeHRIHQ1R2
X-Gm-Gg: ASbGncsGAz5jLKmFHNyeD85YBhTLSMNVnECTuoeBrVc3dOiJz9PEkHRHK3EJEZluRZe
	vpjmVAY4MUcUHWyerCM5rwXT5XRUw7/YBun80RRo8O4OvJzvjli5dekaUGoAH9ql+yUC+lsLnGf
	TvOn5NG8QRFV61qSUzz3cyJT3oStkc/4JKvxWlW9Tm0Lm05XsBeptYcejZW3z6xjmgz5WAP8/tv
	Bc15NXkgD6OJ8h0AKu66v8kGGb8a2aQMKGgDd5wTP/7DOt3wrI+dAdi/ixCX6DmzoVyckgJ09Pt
	rGq5X8VFGonFRdfkDXvcooLMXNnuYQeaEb0Bgw9i1Zf5F250zlkKLILBleO59bGUmzZi3pfq0ow
	nA586h5ONStCWZPKNsT2G0zyhSelMVXEAHabN/z1SWAus8fD3W2seOVk=
X-Google-Smtp-Source: AGHT+IF1532bKm7S0qIoOLx0799EOHtzIhvPq6kUzfFu9jk7x+oCr/z8o2sPe7S38TIdM/5ceOCM7A==
X-Received: by 2002:a05:651c:553:b0:32a:8c63:a8b2 with SMTP id 38308e7fff4ca-33053293f96mr17814531fa.8.1752308757519;
        Sat, 12 Jul 2025 01:25:57 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8bd4a8sm9980581fa.65.2025.07.12.01.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 01:25:55 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso24701841fa.0;
        Sat, 12 Jul 2025 01:25:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVYRbWML3JSdpFHBiDBFYZYbNVWWj5IePBC0asG1SKMG1dON5BO1/I3V57SWvqH+74yU35i7PRCck=@vger.kernel.org, AJvYcCWnrg19oaaqGtaCor3GR0mVbIg2XTrxcCuNHlIOgZHRmgcF2bEXRM7lqYlniPqM0UmsP9xEsdZ/hcx4@vger.kernel.org, AJvYcCXnVZR4Va62ncuN3UergBLLDArm2nOeOsg6XL7kSnVbT1dgPOyvS6Cw8u4aHAd7tpz+AeKrhuJDkDma0KKP@vger.kernel.org
X-Received: by 2002:a05:651c:b1e:b0:32b:7472:c334 with SMTP id
 38308e7fff4ca-330532dfcf4mr20735521fa.16.1752308755571; Sat, 12 Jul 2025
 01:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703151132.2642378-1-iuncuim@gmail.com> <20250703151132.2642378-4-iuncuim@gmail.com>
In-Reply-To: <20250703151132.2642378-4-iuncuim@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 12 Jul 2025 16:25:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v66CnNEw0Rhh0SLnr73b+TPJXCZ_eY3n4nH8_9LiXj2Ydw@mail.gmail.com>
X-Gm-Features: Ac12FXymLasGX3Z5Rb9uWIApOu-xW47ktDWvJ_I7-HUhHhL0xFXKGGC-Mm7lvpI
Message-ID: <CAGb2v66CnNEw0Rhh0SLnr73b+TPJXCZ_eY3n4nH8_9LiXj2Ydw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] thermal/drivers/sun8i: add gpadc clock
To: iuncuim <iuncuim@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 11:13=E2=80=AFPM iuncuim <iuncuim@gmail.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> Some processors (e.g. Allwinner A523) require GPADC clocking activation f=
or
> temperature sensors to work. So let's add support for enabling it.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 226747906..45aaf5348 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -66,8 +66,9 @@ struct tsensor {
>  };
>
>  struct ths_thermal_chip {
> -       bool            has_mod_clk;
> -       bool            has_bus_clk_reset;
> +       bool            has_gpadc_clk;
> +       bool            has_mod_clk;
> +       bool            has_bus_clk_reset;

What's with the random whitespace change here?

>         bool            needs_sram;
>         int             sensor_num;
>         int             offset;
> @@ -89,7 +90,8 @@ struct ths_device {
>         struct regmap_field                     *sram_regmap_field;
>         struct reset_control                    *reset;
>         struct clk                              *bus_clk;
> -       struct clk                              *mod_clk;
> +       struct clk                              *mod_clk;
> +       struct clk                              *gpadc_clk;

And here?

>         struct tsensor                          sensor[MAX_SENSOR_NUM];
>  };
>
> @@ -417,6 +419,12 @@ static int sun8i_ths_resource_init(struct ths_device=
 *tmdev)
>         if (ret)
>                 return ret;
>
> +       if (tmdev->chip->has_gpadc_clk) {
> +               tmdev->gpadc_clk =3D devm_clk_get_enabled(&pdev->dev, "gp=
adc");
> +               if (IS_ERR(tmdev->gpadc_clk))
> +                       return PTR_ERR(tmdev->gpadc_clk);
> +       }
> +

This looks correct.


ChenYu

>         if (tmdev->chip->needs_sram) {
>                 struct regmap *regmap;
>
> --
> 2.49.0
>

