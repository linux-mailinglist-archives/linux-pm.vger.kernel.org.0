Return-Path: <linux-pm+bounces-14142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A6F977F25
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5B4B21FA4
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A571DA0F2;
	Fri, 13 Sep 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTl4UVu1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4591D88D3
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228946; cv=none; b=GHhYtTw4XsqcMxgWFshT+23x3hM15Xw36aPd/QTlh/9O5eks3BRQNAAKw77HkvyaKnlak6mfVkW8A5tPmfVM+a3C094Vb2gCEx8QIT0EnMFvOZo8qnbithUQD8w5O63PoE0ei7+zfGax9eVtFTkev5c+TSrIP8YbM29q7v/1SP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228946; c=relaxed/simple;
	bh=xq52X4izzTGGeGD0h4REXhT37n5h+HRXNX1b1mCLlps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+8JR9z49g6VPrgH8hBY8yG1ZYBEpnIDsi7bC26JTD4AvE9gBcVrWCTK4lX6jJ5yX2t0pP+shxDxP7WTXGJt8tTID7MnuYozSlRd67iO/g7XVQoyviLVKRahQ/y0v3CU2PfQ4dzZJMaO0tr5mYF1W0zumtUFh5vJXAzOGUeZY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TTl4UVu1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6b8f13f28fbso15034977b3.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228943; x=1726833743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b5vJYLAw6LfW5JlVpNstXeXKwlbfZrfsNunfO3F9ncY=;
        b=TTl4UVu1IF7qcqnFySe/9jtRoYKQuPLRYpKIXzIuNvplB8YgNLVKY6GjJ4Ly8MXKHE
         JUQPCMye0+yJVWPXwN+32lW5EQBLTgpSK/T/58IWgb7g/5wf7r30Ss4OXqGvekoEV13a
         PeANltxPkczo/CggPSIix1Qs1XV2t3l65hsJEVy5AnPdEaCx4crWkFocZcBEp3CMQut7
         ReVd9OW9B3VrX8P4wHZEZBJzmiIgGr45+JdGLJHqHvcm5i40jTF9iUgSJugUhQNdHX8x
         BWGFR7cl+EVoxFgruaZvBCTAAmJoWC90xprDMeJkD/NDhpxp11HcrxyMNpxJaE9y3dTA
         wVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228943; x=1726833743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5vJYLAw6LfW5JlVpNstXeXKwlbfZrfsNunfO3F9ncY=;
        b=iMbvgmHO0TBe21y6C+syY+sipAUYTMNSSR2K37hY8lsY2+U2SOh5s95f6Kb0w+r1UW
         tITevYnfEZoIAS5y2nFyqvl5myPNqJI94+jjV88X9hTykzjwqGmciuYZvRRr+su9A6ks
         31d7AUE1fJTWxBCZr4aFUTmVHQ4BofMSYvwANlVFGhB+6vFK0+NLFyjPzwID+ThDK2Wv
         EZTO3/LjENlid1FW2Eo0+gsrWGI48qCsED2JbLx4ovGyfCAyeu7zUgOrSSn758wKvqbF
         OyUNQVu2tPrhFEDxthEOh7N0bTos4Eu6sVmK+2vfCY8pbl8WV/j8P/pLjnftDgVWhp4q
         aLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyHBx5K9XLZ/7MNAo34Kx5PtKR2fr3JaYDTi85/blKnrFpe3NsBYyx3ZE8nbKbOsT/dOUyPsZIxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUy8V17danCVsmUm+IiB41Xsa4afNwv/y5Mk20LipgmveIx4PF
	0zutMB6t4HgiCfwYXOhEo5xLKw3svvMwu3d0sug4I/KYjzQMZtKUfjVekEgVdNUHmzq8s/RZdR0
	sdt3tLK5Qu/v+kwZWSG8Wafp1f94OqRd7KrbECw==
X-Google-Smtp-Source: AGHT+IFQpLMOb2ArVCK3W98VSnKdRZbVOJ4EKZFMdKxG+HpYDqytbv3LW6pkSdrJcbfv2WHNAhhoee60un7J4w7BPdg=
X-Received: by 2002:a05:690c:c9b:b0:6ae:e4b8:6a46 with SMTP id
 00721157ae682-6dbb6ba1112mr60834227b3.44.1726228942612; Fri, 13 Sep 2024
 05:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:46 +0200
Message-ID: <CAPDyKFrY7ohfWw+boNEph9+NfTW7uEYKbuEnbk53Ne5XJPXuiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pmdomain: imx93-pd: replace dev_err() with dev_err_probe()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Aug 2024 at 16:34, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> This way, the code becomes more compact, and dev_err_probe() is used in
> every error path of the probe() function.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes in v2:
> - Drop the extra { } to be even more compact.
>
>  drivers/pmdomain/imx/imx93-pd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index d750a7dc58d2..44daecbe5cc3 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -125,11 +125,10 @@ static int imx93_pd_probe(struct platform_device *pdev)
>         /* Just to sync the status of hardware */
>         if (!domain->init_off) {
>                 ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> -               if (ret) {
> -                       dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
> -                               domain->genpd.name);
> -                       return ret;
> -               }
> +               if (ret)
> +                       return dev_err_probe(domain->dev, ret,
> +                                            "failed to enable clocks for domain: %s\n",
> +                                            domain->genpd.name);
>         }
>
>         ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
> --
> 2.43.0
>

