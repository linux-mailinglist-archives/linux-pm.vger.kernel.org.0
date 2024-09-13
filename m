Return-Path: <linux-pm+bounces-14141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2552E977F22
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F556B262D5
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24BF1D933A;
	Fri, 13 Sep 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F94mqI+r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4191D88A2
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228941; cv=none; b=rwtLoXb/jSOIGyOKNPphSeidaMUIsfdnjlzLHLdDghXjVjylGvI0QvtAiFEISlI1xuoamXj/43xjm0Bl5RHudH0ZdiNOpJhZyIuyTqSrGKYJiBgVO+608gacQ4W8JvXLeLjGqw6IGM7hKozeFF29m+Oe2ot07OdiI4tubOpoR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228941; c=relaxed/simple;
	bh=nZZIph3qB+32HcJK3NuoJzO2DWNn41IOv65me9LteDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUmKPPOf7tdISSR03wvW8aw32fngTbdONbOK5LUVj5IOx8vPHZSu2Byl8hVifLQQ0SoSDciMFr55TMNk2F5YRcGzS4RaaD8vQulJZW0Fon2pQKKlR68C9Qk1u+xa6S9kVKnpL9eXneDKbTNvbEgmbQOZQRmbwpMZ6lAYx62wnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F94mqI+r; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dbc5db8a31so10139757b3.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228939; x=1726833739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0L/CKeeeoIAk/64E8dSvCZoeLN01IuNNAws/7deCICo=;
        b=F94mqI+rHgAwsQntW6XI36KKkEvqrbvCQqBZN4637wG4HDqI6J88UUhGjNM7gZ6xJx
         cQFTWdLpjGSneKqg5IvHoxf7GpwSN6+aHZbmnQpibyz0uhgUuyLO9SGky8JMq2q6LNqQ
         Jmw30XQk1iZGcnelxNeJEifc4ZfiWNc80AJgEehiIOI38bgwSzJQcx4HZQX1XdKOSw5Z
         v3yj6a0ZlI7p5aGfvL/YNAbHumZLv77YKDwwYwntdeUC1iCBHyNygZ7Ik/jrIicw2hjf
         11w9z6JItMolk2tIl9xM/3mCVU7vA35t2uuqSvQY+qWcUqkeFo7995wK3G9wjxzLnRK+
         I/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228939; x=1726833739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0L/CKeeeoIAk/64E8dSvCZoeLN01IuNNAws/7deCICo=;
        b=RPtjPG7PKs4/lrfZpG/qLEY6JnJ8FhdJddYyN4Zt702RoB3JmPHCaWOsQqbtWmby8z
         7ms+u04CxVUAhsoqPTzhza3cuG/C8m3A0Whp7fQL1R+W7brWPRqIx5VT6QIY8bo9hp4v
         LB4El31M8AeoqQs2K+uGNCgKbXVaWdINzvU0gAepSFuwd2uRLzdEyJwuaDaaPuqATBQQ
         Ba9nqRuj3juKMnFg8qZHu3oBbO7gJaQdtVPi/sQXgkXob8HrfbhztEIRSm+JlmXHnZTn
         vAK7OnpjfCMFpCtqNPZoZWf7DsMDJgQJCTbmXt1Ln6wA3wGfJ2C9BNa6a2SZgneFHTsc
         dRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEj1P65NulWDGKimkDwSM00BwkMiWu9vEoRlnL1S7mz8/q5w/YOQzGPiTUjEb7U2gxfrpuK2pBPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgFbgJh12Rwt0galDk+cm2YjCpgZY3xS4/ylp8zUUNwird1Nc
	Ij6m9xqbMDFWrycfeiFIimvivpwj+FEpe9zf3wAIgLYXtGsLzg1qq1y0Elt4jvTPsV6a7D4um0Y
	qfRAF/kLdpFnGh1KjNbbcmSMpo7GKctAtv1PE6w==
X-Google-Smtp-Source: AGHT+IFZgURqTXFx8rivzcDZVs3brlX5pRkhtUBectyP+qaKbv1UEElsRCVAJCZe7+cEgvaaOmDOn1XGpQ5OsqWHboE=
X-Received: by 2002:a05:690c:46c6:b0:64b:1eb2:3dd4 with SMTP id
 00721157ae682-6dbb7039720mr47687277b3.8.1726228939342; Fri, 13 Sep 2024
 05:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com> <20240825143428.556439-2-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240825143428.556439-2-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:43 +0200
Message-ID: <CAPDyKFrfeKTMW5R6=GSu+t4bY8ebQgcvbzc5wUcgBbSVQWRS5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pmdomain: imx93-pd: don't unprepare clocks on
 driver remove
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Aug 2024 at 16:34, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The removed code was added to handle the case where the power domain is
> already on during the driver's probing. In this use case, the "is_off"
> parameter is passed as false to pm_genpd_init() to inform it not to call
> the power_on() callback, as it's unnecessary to perform the hardware
> power-on procedure since the power domain is already on. Therefore, with
> the call to clk_bulk_prepare_enable() by probe(), the system is in the
> same operational state as when "is_off" is passed as true after the
> power_on() callback execution:
>
>  probe() -> is_off == true  -> clk_bulk_prepare_enable() called by power_on()
>  probe() -> is_off == false -> clk_bulk_prepare_enable() called by probe()
>
> Reaching the same logical and operational state, it follows that upon
> driver removal, there is no need to perform different actions depending
> on the power domain's on/off state during probing.

Well, I guess in most cases genpd would have tried to turn off the PM
domain when it is getting removed. However, there are really no
guarantees for that to happen. We should probably look into that as a
general improvement for genpd.

>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

The above said, this still looks like an improvement to me, so I
decided to queue this up for next, thanks!

Kind regards
Uffe


> ---
>
> (no changes since v1)
>
>  drivers/pmdomain/imx/imx93-pd.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index 44daecbe5cc3..fb53a8e359bc 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -90,9 +90,6 @@ static void imx93_pd_remove(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
>
> -       if (!domain->init_off)
> -               clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> -
>         of_genpd_del_provider(np);
>         pm_genpd_remove(&domain->genpd);
>  }
> --
> 2.43.0
>

