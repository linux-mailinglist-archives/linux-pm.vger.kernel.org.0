Return-Path: <linux-pm+bounces-14143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D3977F26
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD234B22B94
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB671D9328;
	Fri, 13 Sep 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAsUsGFc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D71DA101
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228949; cv=none; b=c1XPdBMVSMGrgUSVhb9D+44CdS5f4JROpgEuqK1dOES3SnV7nNmOeTPffALoqwcDCD9o0J4qD0xQ8ZDZq1aW24FLDcNIJzzzUOrC5gWkQXscyAEgtdsqlhzsD2RYD5NpL2jDMpO0qN9Th2256QimYm3SRy1WgDbxxkL4lCMFAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228949; c=relaxed/simple;
	bh=5ecyZVpYI8q2kAC7DnbFHrixpgS8zfec8GgteQKL9vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEXe/qteUomzmqPeNlRY862xQGWvd5rtnlez8hdiVV/zAwI1mbUgwWt4t37LrvwIsdpPjp5ra02q3bJ4wI5qGycXOwnSxrHdoKkhUGsVu4LXz2IOOgHjhqiJuek03zhZGrr/5z2wEAqdcZs+6fpr0m0Z62dDGZiqw/CeTe0QqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAsUsGFc; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so918276276.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228946; x=1726833746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aUCJeUdbCtTzlTdC7hKAZDf0AYKIsmkYRDth/Vcc+GU=;
        b=DAsUsGFcP1p7seo84Vno61loKj4E953gsV2n2cPVRdfMqc/haFwPynwRc6H1O85qm7
         6oRRjp/UL3pCskdpQ1G6fnMC4WKAVEG5gwqY7KscgxDKArO187F/dAmHwmUDcDBzFIbB
         Ofem0beGLAGc2JYecwaZi04ZRxuSVrNhtCkuImSKZf/ZIl0Gx2S5UA+cv5A11EKRLQhq
         GWwqbyO1n4MHIMd3kuUnbzO48ZxHeFEo7AGsfEo/VGAXPwByWOIi4F61lB7o397GXFlX
         3T3sPNokUzM/DPLwAu6NYSuJDeC0MjvixAZeztGiIS/rCXOy2wqZjE4FG7QoiPzq1ueT
         IlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228946; x=1726833746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUCJeUdbCtTzlTdC7hKAZDf0AYKIsmkYRDth/Vcc+GU=;
        b=iEwGYH/CjEKg+HNUdtXXcw8AfnhqwmtBxLCoZruW2K5rfb6wxYHviybix36yPO1Voj
         UQ8xZtWAoqOix2gY3kDGOR7+AckIblIKnk5BFEdD4W8R+8SPzOPrOcfmsJ41FDzXqTH0
         0gf4XKFoSO91azQeEeai+c7qplL+a6iom3q1iNUh0m66PCUlODZPMCEM2rLsgUGdlWaD
         4Mi8JrP7Nzcxgm7XMQ3qqacIx/v6PPQ1qiyYTTuTaQil3np649H39M3VAKdOnf3spQF4
         yoCTkFRjGwvonsmeFkO8tkroPZP/XyRI5aZ2zA2CNcdF3wZ458sN5vK+eV79JDGJYqtB
         qGeA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDhSEB+iTA0gxXycyKwZABaYPSzYqSA0CVRO6+ftzaGo44IY/4iX+bJg8T/0gvmJrxAXZBjccpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXg+Q0cYiCanbrzcgFAgymcEw/66i1Y8woljkwkuHJO6ubxyW/
	B74EYp//SpygDjRSgp/x5vvLF1Uf+XxSpekC/jlWKHo+7Vw3GzL763Ez3A9f0ksFksAXZ9k3CvY
	0uDqinAJy06AtpCLf4kzAtkKDVFT6zR4x361h9Q==
X-Google-Smtp-Source: AGHT+IECNxvcFi3ScZRYjWcQww81p9XEb9hR+bYUmttrCAW18q0cmnkWFae6PLyr/4yCBmR962PjB7HU9kMt0j8tTw8=
X-Received: by 2002:a05:690c:4989:b0:650:859b:ec8d with SMTP id
 00721157ae682-6dbcc29ef68mr21668657b3.10.1726228946301; Fri, 13 Sep 2024
 05:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com> <20240825143428.556439-3-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240825143428.556439-3-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:50 +0200
Message-ID: <CAPDyKFoO4UUuJf6G7BTx-4LNpKVY8gJvZ0dj8tWP1E1aJiHYqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pmdomain: imx93-pd: drop the context variable "init_off"
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Aug 2024 at 16:34, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> This variable is only used within the probe() function, so let's remove
> it from the context and define it locally within the same function.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> (no changes since v1)
>
>  drivers/pmdomain/imx/imx93-pd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index fb53a8e359bc..25ab592945bd 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -28,7 +28,6 @@ struct imx93_power_domain {
>         void __iomem *addr;
>         struct clk_bulk_data *clks;
>         int num_clks;
> -       bool init_off;
>  };
>
>  #define to_imx93_pd(_genpd) container_of(_genpd, struct imx93_power_domain, genpd)
> @@ -99,6 +98,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
>         struct imx93_power_domain *domain;
> +       bool init_off;
>         int ret;
>
>         domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
> @@ -118,9 +118,9 @@ static int imx93_pd_probe(struct platform_device *pdev)
>         domain->genpd.power_on = imx93_pd_on;
>         domain->dev = dev;
>
> -       domain->init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
> +       init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
>         /* Just to sync the status of hardware */
> -       if (!domain->init_off) {
> +       if (!init_off) {
>                 ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
>                 if (ret)
>                         return dev_err_probe(domain->dev, ret,
> @@ -128,7 +128,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
>                                              domain->genpd.name);
>         }
>
> -       ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
> +       ret = pm_genpd_init(&domain->genpd, NULL, init_off);
>         if (ret)
>                 goto err_clk_unprepare;
>
> @@ -144,7 +144,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
>         pm_genpd_remove(&domain->genpd);
>
>  err_clk_unprepare:
> -       if (!domain->init_off)
> +       if (!init_off)
>                 clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>
>         return ret;
> --
> 2.43.0
>

