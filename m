Return-Path: <linux-pm+bounces-13175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44399648F4
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 16:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF081F21B3C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352001B1514;
	Thu, 29 Aug 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCUb42z8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FF1946DF
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942848; cv=none; b=QfaJwVOy8Pxa33YB5XXjppi40ZIgXoefwJR4yy8Y1EU3Q5c0AtieqUckiLLda4e+veFE4zQklqjVCYPnIhc+FhKENyG10lHDC0GCqgrAmySgyEmnvw8WxagrlnJgMA4Aih1Se6jOyAKmEWbOL5NdhNu2ND95W3DAPZPGVSJBsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942848; c=relaxed/simple;
	bh=2wEme4/XiIxv+XC7IKX+UEP3LoIr+uA9GwuBXw2L62Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDvohWSEvOhUaYinZvdFlxcYWia9CSoD07jykhmQWf0bBswQdhRrpU85FDfCfThXM3CJq9Lbrm1Jln5Lz8pEzR3kFTgdnwZCenl8oPXDIlWXsukF/ch4rJGXLJw5fE84uwD/ljmD88sZ/j1rUncJHkxQS0+dHZDpsqhGJlg7RVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCUb42z8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-68d30057ae9so7223297b3.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724942845; x=1725547645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/vkim+xummqOk2H9b+74Hhqn660ITeM09qY2Omx2bI=;
        b=sCUb42z8vNA3J5MeggF6wBq5FlGHw3OoHnWXuf+tZ4KAckNpJ+VQ8rT2/EwQPJw0Gk
         O2RGjkGTazpYQqV7Uld0/mv4z0bwdAEB30rTQW9iN/CBsDxxCmyyTJvv3dVILPWmOI1K
         OSH/Bs5LCkDuyuSbMHM7PGWda3tOlSaxa1LJfVxywlQAZY+yCgKV2ZIgrjUjXhiNOImE
         OSQoC6mD2wQf4I2fSA06D8w1LhJYjVudqqwuvwfhbse/hg0RCBcB/ykqH84lr32nwDVz
         gpKYvej8qQxCQLMebIvTtkYGiteKT0wWxIoIrUVqzufLKnk7+YpHcCmAKTWF6ohyAI52
         NOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942845; x=1725547645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/vkim+xummqOk2H9b+74Hhqn660ITeM09qY2Omx2bI=;
        b=updz3WyCvr2rSPfLDLEmOhL4pJwwGCA3dNwrFQXoUVe/hT/v/ezrdU9icLmSxRGanE
         uWkPO5pPLejB2XRhKH50ltYWpZKmAgiQEezub8PuiHL8OI8hAwm3v/oYOQw3mBPlO7QS
         3V+BUjJ/hh5XEKZpuuxkOHycm7ADTblKSx3NBrXxUxgct6IgCi3H2vCxFptQNMeEkQv+
         YlTzl8QH9eAPJnyEmr5N2/OIYAQifP9mZ8guTWtFg4Av+td992tb81MRQoW3PC5IL3Nh
         EWwRNiDNUQBuIjCxhxURZkUy5de6eWF1XV7fImJf3rQEz79hM4BLld5mHdBTwDL9XtKY
         rTMw==
X-Forwarded-Encrypted: i=1; AJvYcCXqhL6DK8+KpVFZVTRDgxitNGBS6101CYWBAuxuEnS8NHvqQfpcfSyFi+II4KIuNe4iklK3PClj/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJC6Al1FNpp3dWYg11nDvxdM8tGiETDxGf9IHVlBvswol/odZ
	xAgAdQdAeB8fCd9JlNLWZSxwRy9NFZryoYda8FKWJeXK+SkCZr4QnkVunvrkMDP3G2QGeKYgCDd
	teuCsLoq3snTHngWIgIZfTzhGS18IPOWuVFNOwg==
X-Google-Smtp-Source: AGHT+IFHAtMxCb+GcwQvbb/tvHuVYvN/sUzIggHVFuoFNFPiNhIN+TbyVH/OKH+M77ZtiY09qXR7uD8wMI4GqyNRYMQ=
X-Received: by 2002:a05:690c:7604:b0:6d3:98b1:e3bc with SMTP id
 00721157ae682-6d398b1e4e3mr2993127b3.32.1724942845200; Thu, 29 Aug 2024
 07:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com> <20240828140602.1006438-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240828140602.1006438-4-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Aug 2024 16:46:49 +0200
Message-ID: <CAPDyKFrGGKU034C81Q_1AvwVLobKXrwbkgGXL83HgJW68-h+Sg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain
 in the restart handler
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 16:06, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On RZ/G3S the watchdog can be part of a software-controlled PM domain. In
> this case, the watchdog device need to be powered on in
> struct watchdog_ops::restart API. This can be done though
> pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog
> device are marked as IRQ safe. We mark the watchdog PM domain as IRQ safe
> with GENPD_FLAG_IRQ_SAFE when the watchdog PM domain is registered and the
> watchdog device though pm_runtime_irq_safe().
>
> Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") pm_runtime_get_sync() was used in watchdog restart handler
> (which is similar to pm_runtime_resume_and_get() except the later one
> handles the runtime resume errors).
>
> Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") dropped the pm_runtime_get_sync() and replaced it with
> clk_prepare_enable() to avoid invalid wait context due to genpd_lock()
> in genpd_runtime_resume() being called from atomic context. But
> clk_prepare_enable() doesn't fit for this either (as reported by
> Ulf Hansson) as clk_prepare() can also sleep (it just not throw invalid
> wait context warning as it is not written for this).
>
> Because the watchdog device is marked now as IRQ safe (though this patch)
> the irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
> 1 for devices not registering an IRQ safe PM domain for watchdog (as the
> watchdog device is IRQ safe, PM domain is not and watchdog PM domain is
> always-on), this being the case for RZ/G3S with old device trees and
> the rest of the SoCs that use this driver, we can now drop also the
> clk_prepare_enable() calls in restart handler and rely on
> pm_runtime_resume_and_get().
>
> Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in
> watchdog restart handler.
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Changes in v2:
> - adjusted patch description and comment from code
> - collected tags
>
> Changes since RFC:
> - use pm_runtime_resume_and_get() and pm_runtime_irq_safe()
> - drop clock prepare in probe
>
>  drivers/watchdog/rzg2l_wdt.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 2a35f890a288..11bbe48160ec 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/units.h>
> @@ -166,8 +167,22 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>         struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>         int ret;
>
> -       clk_prepare_enable(priv->pclk);
> -       clk_prepare_enable(priv->osc_clk);
> +       /*
> +        * In case of RZ/G3S the watchdog device may be part of an IRQ safe power
> +        * domain that is currently powered off. In this case we need to power
> +        * it on before accessing registers. Along with this the clocks will be
> +        * enabled. We don't undo the pm_runtime_resume_and_get() as the device
> +        * need to be on for the reboot to happen.
> +        *
> +        * For the rest of SoCs not registering a watchdog IRQ safe power
> +        * domain it is safe to call pm_runtime_resume_and_get() as the
> +        * irq_safe_dev_in_sleep_domain() call in genpd_runtime_resume()
> +        * returns non zero value and the genpd_lock() is avoided, thus, there
> +        * will be no invalid wait context reported by lockdep.
> +        */
> +       ret = pm_runtime_resume_and_get(wdev->parent);
> +       if (ret)
> +               return ret;
>
>         if (priv->devtype == WDT_RZG2L) {
>                 ret = reset_control_deassert(priv->rstc);
> @@ -275,6 +290,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>
>         priv->devtype = (uintptr_t)of_device_get_match_data(dev);
>
> +       pm_runtime_irq_safe(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
>
>         priv->wdev.info = &rzg2l_wdt_ident;
> --
> 2.39.2
>

