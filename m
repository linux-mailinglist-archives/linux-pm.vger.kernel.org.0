Return-Path: <linux-pm+bounces-18912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA6F9EB290
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1734B28962C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCED1B0F1C;
	Tue, 10 Dec 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uEyXd1H2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BA1B4122
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839357; cv=none; b=tYQd2jAKAjqAzU0Sqw5aR8iI4hve8bQrzYtBEwcpeC33QkqQtni37uxILAisCUwq7VtmLBfOhxSaCshDw2sq+kDAX0tmH8P25F1s1wy/M0btbujlbXsph8dBFYX1JX3myPl4TL4a/YJ24XOwNF7JCxftsO0rP1zt3mBHO83GKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839357; c=relaxed/simple;
	bh=TRfjmBKfiMFehXKfcPR5PjcSzxFgFyiC03eittaPsog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5YcISA+G/akbvKS8657lua8HL4zc6iYD1HjW7DFHqm8ad5yLOHAYzD6mjS4khlxIJbbmJZGZKtQ9pNxcwqnNoiamb1oG03K1L8aCM/anNpXkMDFw9Aq42uEekJvzuZhzWYLg+cpbAdIB8nf06N3B4MIVvJGDvyCan7sCDuOqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uEyXd1H2; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3997835700so4433759276.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733839355; x=1734444155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=besKoqTUl8UspqMzSV4i/1U3YcYukO65Us63dIVJlmo=;
        b=uEyXd1H2sGUfptuvtqPpiahykBneao1Qix7Y4obhLNBLxTq5vC30nlIm50yL7n5fDS
         qMEnUfoarTdrar4RP1BTwgoE2vspu8bIlqMXDsPCxCLn1k+3P8PuI3RrHCYJCT9eb2z5
         /JYEYRRdFQxlygFoAzggFadtNFio6aV9r6oZ4vWDnz2AkvcHKnbcs/DaHJZtDfuDJRhB
         ytmNwk/Gwxy0DgtKlBi9vbptlKVlBNxkdkb8CliW3o51bQdWTrC7gt9gjl9mPyJQo9F+
         Pn+F2437/OqlJpoeFEXytCX5kHXuL8GqHa3xGFSZ6LK0l/OpHd1/yp2buzWfaToRwiYh
         Ca6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839355; x=1734444155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=besKoqTUl8UspqMzSV4i/1U3YcYukO65Us63dIVJlmo=;
        b=w6C3RmaS1iBZ7pUA51sFTKixxe0xmccFeDt9jOvnSHapbcXembuqEKzut7oLzyj5cr
         gya7wZubCYumxTEK4w9DUN7jaKJ8waQxkTiJmAv1kkr1CW5ijp7Agmg8T7HSzpPfxsbg
         kTIW2QPUC/k6AoGviLqaUYW0bYmlTmsYS+agyxeQqFOc0zC6v4LQLY97/cfX+9w+2ViM
         ywFOjXUL0bctoewYdLp4HiCCiVbsv8L6ZQzMUyKxUF05X8yWGXb1whd5hhRVxQN1Hwi6
         Fjw61sIWCmkloHhm1gIwtxs4vRJRS1/Wha15Gg4K6CVPKoovJI+xudkDCwl6wF/zK83v
         D6JA==
X-Forwarded-Encrypted: i=1; AJvYcCVs0LxdUICUbZ6hZPD0uS+6xRNLJgMFXbRqXYtxrRxBUq0Km56x8he1npHUBhShFixzWgGMaQMDHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwktBrbkNEnHL+OGrxUeOiGDVu/B88qhiZ3kCLN6pu2dZaoe2Sb
	nslJ6BCilm4J7msOD45WaUtEMyWc8YmUPWcK3y9VnVgylr9qVt/ZTD3uQkX4RmPgucY/D6mm7Zi
	AZoJd61ErhmG/9nxD+AQrkEWS9uIjWmkmHNoeZA==
X-Gm-Gg: ASbGnctpSmWpxEbnxiGNPEzQeEfVIo3hD2DYPhgSSopLNAJQ5P2FRR5ZtMS0eNvMYDs
	BNlNJYqh91FKFJgYLS7zJLmi0ZjZTBqwE4Ptg
X-Google-Smtp-Source: AGHT+IFN1yCbB7HlDLaJwtDy5HM3+UgGOrK5CihsW5CiH9M8fU1rwshFqKnyFZ0DMkKGTqWE5e1F/csj0lrK/77hhbM=
X-Received: by 2002:a05:6902:2b86:b0:e30:d4df:4974 with SMTP id
 3f1490d57ef6-e3a59bdca97mr3979566276.40.1733839355475; Tue, 10 Dec 2024
 06:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206112731.98244-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241206112731.98244-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 15:01:58 +0100
Message-ID: <CAPDyKFrM6wX5uWY8g0pgZNEZn8uG5hbD4JsAijBenOMWkEgD4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: imx8m[p]-blk-ctrl: Suppress bind attrs
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pm@vger.kernel.org, aford173@gmail.com, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 12:28, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The blk ctrl drivers on imx8m series are registered as platform
> devices and this opens the possibility of reloading the driver
> at runtime.
>
> But this doesn't actually work. There are some hardware sequence
> dependecy between blk ctrl and gpc, also power domains are used
> by other peripherals, so fix this by explicitly suppressing bind
> attrs.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 1 +
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 23db85b7aa9e..912802b5215b 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -894,6 +894,7 @@ static struct platform_driver imx8m_blk_ctrl_driver = {
>                 .name = "imx8m-blk-ctrl",
>                 .pm = &imx8m_blk_ctrl_pm_ops,
>                 .of_match_table = imx8m_blk_ctrl_of_match,
> +               .suppress_bind_attrs = true,
>         },
>  };
>  module_platform_driver(imx8m_blk_ctrl_driver);
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index e3a0f64c144c..411dd548c67c 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -862,6 +862,7 @@ static struct platform_driver imx8mp_blk_ctrl_driver = {
>                 .name = "imx8mp-blk-ctrl",
>                 .pm = &imx8mp_blk_ctrl_pm_ops,
>                 .of_match_table = imx8mp_blk_ctrl_of_match,
> +               .suppress_bind_attrs = true,
>         },
>  };
>  module_platform_driver(imx8mp_blk_ctrl_driver);
> --
> 2.37.1
>

