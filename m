Return-Path: <linux-pm+bounces-9684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8E9109E5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BEC1F25A6E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16211AE87C;
	Thu, 20 Jun 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX1t4But"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADA1E52F;
	Thu, 20 Jun 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897493; cv=none; b=ZEoKVCsrfnTT1jD0nDLZoI6dlemrY5OufPb+yEfOj+cUXkxdW/rYTjOomBqQ2twgm6YP9ES/bZMO302FlBc/nMEWGEGJs8JrUI9k3AP3D/6UBB8t9DJq4y84HKsTCqTgP4kSUp68oy/DR47Ns8ozaruqDr8qse814GH6mmvcyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897493; c=relaxed/simple;
	bh=ARSBC7yLTcnp/pqnpPOI57zF+ilkvpeQEb6s7WIO16g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3ggRwU7UBudwHkbiAqIlnF8h1/Ugc5hEdAd75xNUD7BHAeS07z8yqYyicM2/leTPpC8hDJynMVYOPNsuxjDh5m+PYeZzd4QwxXJahkeFN4Y9QhVvIzzVAkPtdoTtCHniTgquSqFNozSjZMEPGY4JoM6QTHCBskScygGQgZqFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX1t4But; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5babfde1c04so440567eaf.2;
        Thu, 20 Jun 2024 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718897490; x=1719502290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt2+2PTw+WUyvoeIVUnfeBTtCiiz/yh/xagrQfb3Rno=;
        b=HX1t4ButI6JR9gmf7UkzU8GxJWpsPbrvfEgCgKmsjlnJ/mXf7k4uPVDuRomjMw/xcw
         KBDULv1SqZnMF2UzhPoUbNe8D2VOdhAuFOxtJWE/6U/7KGX3zz018nBlzlumzqVNev6s
         DRfsf4NXLRCPAU58EvfprTkC4cBM0FORCVsitggFonTSZ79CxqCQYiU1i1AQcMWe14fo
         a8CyoCcgeFHUM3L68bxTb1vO9KkhDmAMfSvCGWsG4WnXGJJjepO1xONn/8cazI1S17Hu
         RQfNLu0TNJ5ctBTNMcEFjRdNjmybPwLlzFcRJkH1vzNpyjgqBokJ9pZhcWnaz0y3ccvj
         uUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897490; x=1719502290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt2+2PTw+WUyvoeIVUnfeBTtCiiz/yh/xagrQfb3Rno=;
        b=HW0tu+lYcwfjrRzyp5LD8XZMzIX6dDyMry5DB1JeeT1g3WvW352r+Xn65L/ZxSQtPg
         vMFvGG/x+1Y0QD7Ksyv6+Q/wKcdep86sxZk+KhUFQUxsQsWFt9WdTZRb1N32TYzxWvtn
         PY2Sz8nkmcmYfrnj71nv+gfI4uqx4+ah1cINVBblBBP4m5C0aH+6Ln2z+4xN9JTiHm5t
         rh2OU+DYfPV0w/3LFuwLl9W4Jlhtmj3saREB0G+jQmPs6HnZTaqEPOQFnChq447k3YkM
         amPGlRm9rG3xiU7jMCWu3gueHgl9RgPUvLXcVFvemzhec14LjkC18K2tUqa1pwVPSfeO
         CStQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPFzLKGgjGMA8GN2acCfzirJ/Sh9EBR/w/YP8bhpr80VOcW6lK+ofQCmTHJ4HVTORuwRVWmzjCUVC1c+DxD9tHWnaMUbl0OLszPbZDwmEfM6DgAz3ZNDlr4JJFBs3sA3ujl8WBEYeRxSoo7ryw8tsTah8sK1ha1KBuVpLNE1aEExvjzBwek2wGxdtjNJRww9BHJyta6egsJpLPfXVM9j9n0V0bheCAgbHc
X-Gm-Message-State: AOJu0YwXvuctCym64jliDpLf0L9Iuwt4EoDDevScBNOigBMI25dbo901
	b1kmxvjWU4z84UiVfbXnL0hWjdsY4q9f/jIvLgFzXqifeq5FCr7cSzJLwvJjIxCc6srz6/ZNZT2
	FNmZPBH8qdxI+KrwSffnXanaM1Hshau5eTqjVNQ==
X-Google-Smtp-Source: AGHT+IFNpfr2jSnuExITl+ds5bqhiqdYJjyiZvjeYYXSNVzTjJWTZDJ+5te0gNBG31OjvyRJvbUPfq4HEb3xCfGvrH8=
X-Received: by 2002:a05:6358:478e:b0:1a0:d4b4:5eb3 with SMTP id
 e5c5f4694b2df-1a1fd52528fmr674606355d.23.1718897490357; Thu, 20 Jun 2024
 08:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com> <20240619120920.2703605-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240619120920.2703605-3-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 20 Jun 2024 16:31:04 +0100
Message-ID: <CA+V-a8v7hxhhiT4X28kKJ5yTuMahCuCUWX_nFKd4cWL9GAWxug@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] watchdog: rzg2l_wdt: Keep the clocks prepared
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, wim@linux-watchdog.org, linux@roeck-us.net, 
	rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, geert+renesas@glider.be, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the patch.

On Thu, Jun 20, 2024 at 9:29=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The watchdog restart handler is called with interrupts disabled. In
> rzg2l_wdt_restart() we call clk_prepare_enable() to enable the watchdog
> clocks. The prepare part of clk_prepare_enable() may sleep. Sleep in
> atomic context should not happen. The clock drivers for all the
> micro-architectures where the RZ/G2L watchdog driver is used are not
> implementing struct clk_ops::prepare(). Even so, to be sure we are
> not hitted by this at some point, keep the watchdog clocks prepared
> and only enable them in restart handler. It is guaranteed that
> clk_enable() can be called in atomic context.
>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Closes: https://lore.kernel.org/all/CAPDyKFq1+cL1M9qGY0P58ETHUZHGymxQL0w9=
2emUJPMe7a_GxA@mail.gmail.com
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/watchdog/rzg2l_wdt.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 2a35f890a288..6e3d7512f38c 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -166,8 +166,8 @@ static int rzg2l_wdt_restart(struct watchdog_device *=
wdev,
>         struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
>         int ret;
>
> -       clk_prepare_enable(priv->pclk);
> -       clk_prepare_enable(priv->osc_clk);
> +       clk_enable(priv->pclk);
> +       clk_enable(priv->osc_clk);
>
I think we need to add a check before enabling the clocks:

if (!watchdog_active(wdev)) {
         clk_enable(priv->pclk);
         clk_enable(priv->osc_clk);
}

>         if (priv->devtype =3D=3D WDT_RZG2L) {
>                 ret =3D reset_control_deassert(priv->rstc);
> @@ -226,11 +226,28 @@ static const struct watchdog_ops rzg2l_wdt_ops =3D =
{
>         .restart =3D rzg2l_wdt_restart,
>  };
>
> +static int rzg2l_clks_prepare(struct rzg2l_wdt_priv *priv)
> +{
> +       int ret;
> +
> +       ret =3D clk_prepare(priv->pclk);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_prepare(priv->osc_clk);
> +       if (ret)
> +               clk_unprepare(priv->pclk);
> +
> +       return ret;
> +}
> +
>  static void rzg2l_wdt_pm_disable(void *data)
>  {
> -       struct watchdog_device *wdev =3D data;
> +       struct rzg2l_wdt_priv *priv =3D data;
>
> -       pm_runtime_disable(wdev->parent);
> +       pm_runtime_disable(priv->wdev.parent);
> +       clk_unprepare(priv->osc_clk);
> +       clk_unprepare(priv->pclk);
>  }
>
All the above chunk can go away if we use devm_clk_get_prepared()
while requesting the clocks in the probe.

Cheers,
Prabhakar

>  static int rzg2l_wdt_probe(struct platform_device *pdev)
> @@ -275,6 +292,10 @@ static int rzg2l_wdt_probe(struct platform_device *p=
dev)
>
>         priv->devtype =3D (uintptr_t)of_device_get_match_data(dev);
>
> +       ret =3D rzg2l_clks_prepare(priv);
> +       if (ret)
> +               return ret;
> +
>         pm_runtime_enable(&pdev->dev);
>
>         priv->wdev.info =3D &rzg2l_wdt_ident;
> @@ -287,7 +308,7 @@ static int rzg2l_wdt_probe(struct platform_device *pd=
ev)
>
>         watchdog_set_drvdata(&priv->wdev, priv);
>         dev_set_drvdata(dev, priv);
> -       ret =3D devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable=
, &priv->wdev);
> +       ret =3D devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable=
, &priv);
>         if (ret)
>                 return ret;
>
> --
> 2.39.2
>
>

