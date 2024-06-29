Return-Path: <linux-pm+bounces-10241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7772891CD6E
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B84B282C8B
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF0E80035;
	Sat, 29 Jun 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lziih1CO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6220B35;
	Sat, 29 Jun 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719669141; cv=none; b=NOOnJHvMlkt/Szgi1V+lz1P9dZ4CZlT9hSz/EVJRNw0Zx8WA60egRb5uWO8O0PQ42XgtvotMBj8mHhWlOTESy/P7niKeWWyOVl8tWk1tu6Oitlosa6pF0FrpdZ0Hq2yKvq1F9t4YO8sLK4Zoddh/cpwmkLnJmxrhRMqtI5khpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719669141; c=relaxed/simple;
	bh=TbbyMyfvILKCy9QD4+VE6X1XF2QUuSxC/os+k31QF6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aN1j5ZxsnROw2ugHgYgGWXLI8p8SDwaZTQJp7OAIn7FOD3Ghdh4PmPDzyHateYtUcG/AtnA3ott2bZnoVz3Xc6Q9dSiQ9rgK5oi/CsAYk6uu3DIR2XzdWQj5fyZOUxyHsd7R/GjBk21TfXnQURINKtPdq9ThnrCLYcECvQLip+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lziih1CO; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c21ba58227so780342eaf.0;
        Sat, 29 Jun 2024 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719669139; x=1720273939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wisMx0ek/spfbVP70onUB10Oer/RxJ8B4YlAA8+gQ8w=;
        b=Lziih1COlBYG2EiRvyU/sgOhEVKNdmAbLKIsBz2j1CKEH7jIdFqquhgD07lXGjuu8O
         zUqjEggyOxUbx0moJJLROmutiYtThZs2hQUIlkNl40tXp/BQB5JeXGkUSPlMxOtEy0mM
         CIj9Gi3C1jzvRCLo2/q/ubdi2UyyhBAyXv8xjOG+ogGdCwOA8PsNOJyX6gFsWy4GZl57
         O5pK+giizdu1xmLl/bJIZ1oqx/BkCCGg0noq1/jR2oiTryMwPxGAUSkqFsEOfdaAyhVv
         tKwU0LzDIyGG+1/wvqSeBLgj40/CnZ10ZtX9U3ZdfV5PEBX0VcVMqEfzQ/Z9Wi1QSrjk
         0fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719669139; x=1720273939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wisMx0ek/spfbVP70onUB10Oer/RxJ8B4YlAA8+gQ8w=;
        b=oWuljWkntLocFnAAyHEA+U+jThn0IY7GnyQcpvqRICQD+dDGFjRTCmqFsWj0eHm7AL
         aC6EQqAZItyXS6pSLbnCo9UHxSDG+YEpb4kKMCDps9wC6JZRxSpPHzhFbWBk9FApNry4
         Q82fd6MWEnIVqDC4lCPCDZcsUtZu9oxhPZWjqhJ7qac1Wg5JCDPX6+zWzHoCZOe8i6ub
         LzDAZDRAZG2zT+udLCjJfsw6MPdc8o6KvYFSMmbn7BaKeaP7kQLoiQPrku2WIj1dZFnK
         H7sRY4fgEW6CCtLKl5Amj3zE/AAXKpDOSxgvbBT90P7vhChdqRxza5KVoFByvP4f8Bxt
         /Qrg==
X-Forwarded-Encrypted: i=1; AJvYcCXZu1DTDgajxQuaGvjHgzLkSKrjguqdtTJ+01wSTvdCvR/0/ffcq1V+Z0H9FeITj6+2bof+lqlzdKdp4ppD3bK6AOIlLbWmwfupStoNf425IdRlA3V0I3Pzk4KOqZJxu4wSoRNPvQzLRfuyW+OX6ESqHZ0PNUZDyRcXIW0e3OV9ph4nl7pILvQeFA==
X-Gm-Message-State: AOJu0YzxJY0orMQUE3Fg5P67OJP/F/Xn4KcbcqyXYy3pkOS/qEdr+UQJ
	EXwlmsi0DKlgrLYFB9UkH6Qg4dWL9rZCNtXtjZRLP9cv1hcxNOtdxPuLPaEkqpAQpCxrFaN9mxb
	WQ9tz6CC9cJFs7RqBnA1HhOlZgLI=
X-Google-Smtp-Source: AGHT+IEnqeU/rjRxtlGchXeDSLdHKdBq5buSR6YNbubUtRs1QS9eoTiCbB4x+HyoR4KIHTFFBNwQOpSnJYXZ1R+yCbs=
X-Received: by 2002:a05:6870:d14d:b0:250:8913:7400 with SMTP id
 586e51a60fabf-25db35af930mr802172fac.40.1719669139304; Sat, 29 Jun 2024
 06:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510094034.12493-1-linux.amoon@gmail.com> <20240510094034.12493-2-linux.amoon@gmail.com>
In-Reply-To: <20240510094034.12493-2-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 29 Jun 2024 19:22:02 +0530
Message-ID: <CANAwSgRETDNtLLyh_5z-TXdkhRN_VwegDBZuaSyx=hXWkAJdRA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PM / devfreq: exynos: Use local clk variable
 instead of exynos_bus member
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Chamwoo,

On Fri, 10 May 2024 at 15:11, Anand Moon <linux.amoon@gmail.com> wrote:
>
> This commit modifies the exynos bus driver to use a local clk variable
> for clock handling instead of storing it in the exynos_bus struct member.
> This helps in simplifying the code and makes it more readable.
>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---

I am letting you know that you missed this patch.

> v5: New patch
> ---
>  drivers/devfreq/exynos-bus.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 7d06c476d8e9..e55ae59a8ae7 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -34,7 +34,6 @@ struct exynos_bus {
>         unsigned long curr_freq;
>
>         int opp_token;
> -       struct clk *clk;
>         unsigned int ratio;
>  };
>
> @@ -241,13 +240,14 @@ static int exynos_bus_parse_of(struct device_node *np,
>  {
>         struct device *dev = bus->dev;
>         struct dev_pm_opp *opp;
> +       struct clk *clk;
>         unsigned long rate;
>         int ret;
>
>         /* Get the clock to provide each bus with source clock */
> -       bus->clk = devm_clk_get_enabled(dev, "bus");
> -       if (IS_ERR(bus->clk))
> -               return dev_err_probe(dev, PTR_ERR(bus->clk),
> +       clk = devm_clk_get_enabled(dev, "bus");
> +       if (IS_ERR(clk))
> +               return dev_err_probe(dev, PTR_ERR(clk),
>                                 "failed to get bus clock\n");
>
>         /* Get the freq and voltage from OPP table to scale the bus freq */
> @@ -257,7 +257,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>                 return ret;
>         }
>
> -       rate = clk_get_rate(bus->clk);
> +       rate = clk_get_rate(clk);
>
>         opp = devfreq_recommended_opp(dev, &rate, 0);
>         if (IS_ERR(opp)) {
> --
> 2.44.0
>
Thanks & Regards

-Anand

