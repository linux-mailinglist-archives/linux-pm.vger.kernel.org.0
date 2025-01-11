Return-Path: <linux-pm+bounces-20268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4515A0A37E
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 13:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0666188C24D
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C27192D68;
	Sat, 11 Jan 2025 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxrCQMr+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FE29A2;
	Sat, 11 Jan 2025 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736597555; cv=none; b=Ug+8LXKX7U9B0kyXPVm3HGskj2K7q5dGmDh2qhxfcGoJONMxQ2WSg0AlD6BQMPzAYkznQcTGvn4p0U6WNjU/5GrSOJpqOl1dSbWWZhmSSqsq+1HHWUhBE7Qe88Kigj3LfqjvlPArRcsB0QtcdWIVA8o/LYy3WSwIizGJYLb38eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736597555; c=relaxed/simple;
	bh=0GwypkPnWt/RJ4fOsgJazzW5HFbXsyFVM3KJa4beDIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEds0hd6hMJueB0p5dmPceBZ+pYJPGmDywVAoODaXvdS6Fh7o4kmoO5QTD89P/MiWLyLhkFJACqYOaHs8h8HeQeWMhmmef5Ai2qWIdLuSpm/e7qTZq+DtoQ7fWS+Loq4duW6SdKb1EN14h19vil+uGmGWt21fHwvh7W+PYJlCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxrCQMr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59F2C4AF09;
	Sat, 11 Jan 2025 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736597554;
	bh=0GwypkPnWt/RJ4fOsgJazzW5HFbXsyFVM3KJa4beDIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fxrCQMr+RCvNGMaiA6ixR0TWRXYKzahN74tGdnMrP+HY/IOQ6+acTQOI5m3/ZDqZ/
	 2fMJE+8zn4AhM/On64vZObAO6aAQXvgfOpPOrbTgkHtuxwhk0TBoFmGEU/47/t2bD7
	 nhaNkiXg62ZeriuGk8R4jDbfDcJQcM0uVbbhgsUKHaJMyfFfcTgAPv30awkKzOM9zQ
	 ekG9RMzAASEEEXS8qaNF5FftbjaBNvD9WoqkMMaeO6hZDGsGlyfdNONIdMaf+K56gG
	 RmFDxP0xP07kNpPqTa+26zUFAXauAozK+ccC8eHP2WApe9GGg6wSY1DeQzzbVXQyyk
	 xBn0GBYLRnWUg==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e15717a2dso1440545a34.3;
        Sat, 11 Jan 2025 04:12:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQASROUfRZ5OuSG/UhLZ9vuG14VD63SnDpuR/sIz9kpDKFvtdy01ROa4JaShe4mODCfjtzmYrS9ls=@vger.kernel.org, AJvYcCXQcXCqW3Pjbo3dWEizRrDqTpo7u+U1ph5zoZHCcCi897MKZM5AgETJXQCEA+NTPO35pAC/Yb6kDw/r9C9Y0R9MCR0=@vger.kernel.org, AJvYcCXnWGBVOcyze7DAmB8ygFXQo61g9CPrX105QuGfdimOUqM9HRMu3KKYM5hwR1p44YU6hThjtQNBd7o2hR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ynvw+cEWoIO94m5VgifAuJ6pJ7OTYUHXB7Lnvqx2LM/289eg
	wdWJ6yqL1P/wOJatK3zqfYbMJjPkE0mxy7XSeMzcvQFzNfDFA8ffwsOXULWoA253bSu0IG+YtRK
	dxuC9JPLLVPDV9R2+pnzMQjXyzl0=
X-Google-Smtp-Source: AGHT+IEA+04JMbR+NRAig83ydrur6btFIeS5TcU1Qs7bn3iWd4r1LnpTaQxOJRAw5YKsg1jbSKvC3H1HgwC0F8K5xco=
X-Received: by 2002:a05:6870:9d1a:b0:29e:4111:fefc with SMTP id
 586e51a60fabf-2aa06689212mr7311232fac.12.1736597554200; Sat, 11 Jan 2025
 04:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110173520.78464-1-aha310510@gmail.com>
In-Reply-To: <20250110173520.78464-1-aha310510@gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sat, 11 Jan 2025 21:11:57 +0900
X-Gmail-Original-Message-ID: <CAGTfZH02tdR_5i_RwghpRqb7WXtLMFFUNGrXrTXQ=UWNCwC0wA@mail.gmail.com>
X-Gm-Features: AbW1kvYpgl8fYL3OchY66N21_jsSfItdGZkJkogkPHBgXj8fF5dOaAOM10nqfIE
Message-ID: <CAGTfZH02tdR_5i_RwghpRqb7WXtLMFFUNGrXrTXQ=UWNCwC0wA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: exynos: remove unused function parameter
To: Jeongjun Park <aha310510@gmail.com>
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, 
	krzk@kernel.org, alim.akhtar@samsung.com, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks

On Sat, Jan 11, 2025 at 2:35=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> exynos_bus_parse_of() still declares a parameter struct device_node that
> is not used yet. This parameter is unnecessary and should be removed.
>
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/devfreq/exynos-bus.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 7d06c476d8e9..b9ea7ad2e51b 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -236,8 +236,7 @@ static int exynos_bus_parent_parse_of(struct device_n=
ode *np,
>         return ret;
>  }
>
> -static int exynos_bus_parse_of(struct device_node *np,
> -                             struct exynos_bus *bus)
> +static int exynos_bus_parse_of(struct exynos_bus *bus)
>  {
>         struct device *dev =3D bus->dev;
>         struct dev_pm_opp *opp;
> @@ -408,7 +407,7 @@ static int exynos_bus_probe(struct platform_device *p=
dev)
>         }
>
>         /* Parse the device-tree to get the resource information */
> -       ret =3D exynos_bus_parse_of(np, bus);
> +       ret =3D exynos_bus_parse_of(bus);
>         if (ret < 0)
>                 goto err_reg;
>
> --
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

