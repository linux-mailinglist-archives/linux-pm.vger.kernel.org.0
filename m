Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588E4BE705
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfIYVZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 17:25:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40402 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfIYVZr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 17:25:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so14512pgj.7
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1Y1J1Kw/LXYSdUV06b1dy3Hdb52qSoFy0DppBDWha44=;
        b=fDG7GLpWOijl3/znkPByFyhC2Hzp+IvPmDBuEn9x9EfiC8H7q1Mt/fO3YAofHgjPni
         io2vWxqDMyaMj0cJs2bjquKDfDbWJfym4YrTr7UUokWpPqe01xFaXadxSTIRfp9LHBjA
         68atluJ2Q1iKYX3MuXlDh79prBM9tS4F2dHDnm5M7ff+Q6mV+uawWu5WRb85e/yJwerU
         FN+X/Acm1R02RsIVxHPG/5UOnQ3coOZyhOl2cJYKPqUqe2/nlRQ1ffvjKfv6LPUsgE1q
         fEyS1vl+EAQT3pjO4wZBxIEgqOXH4bvMqaM8hvpC3iMSSUQLMek7TioHNItI24HpGDw7
         p1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1Y1J1Kw/LXYSdUV06b1dy3Hdb52qSoFy0DppBDWha44=;
        b=LANahtv/izbBiJt21IgJBGqu8LgY/ZxV/9AtedkUCMKLto7GDNFaNlNC+pKgamxx/I
         kBApnSgD7ZtI/6DTv088NpSpkeQykx6/HlftBjgxnCe+mIE7HilucNkpIvxWeE9WgWJV
         Gm2e9+bV1MPC5BkMPJC8hgLUgj8PtSzxOb3poxpynmaNm8MMmOaoIR399rWvXxy9pYEo
         VcqOi2ntmVGtq44ZrNpMmO/cUFKx/GtKEmZQWEsM4eN7I7C7rLqwCu0HZOHIGQRpCliJ
         Ufb2qVmD9Pw9K9qoSKt0jq5cZiRRZ2cD0chAB72ndA+KyzIHjGDaA4XECsZqdwuGn8ur
         IMZQ==
X-Gm-Message-State: APjAAAWJO2zu2ONz3UPA5QbFDMA5UbhiZd5DY3Vgyc0HvTdD1cjq42eN
        F6tGhhu7Kz9gNoak79PLa8z5JtYMU0Ss6g==
X-Google-Smtp-Source: APXvYqwgUR4Z8HtrG9mlqqRXWQIUNeORyF7p+25oUPoAEWkRMulS2hiRlTY2wV+lUnYfhKuGjxHm6Q==
X-Received: by 2002:a17:90b:d91:: with SMTP id bg17mr8643532pjb.79.1569446744835;
        Wed, 25 Sep 2019 14:25:44 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 5sm488979pgk.75.2019.09.25.14.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 14:25:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: amlogic: ee-pwrc: ensure driver state maches HW state
In-Reply-To: <20190925191233.22253-3-khilman@baylibre.com>
References: <20190925191233.22253-1-khilman@baylibre.com> <20190925191233.22253-3-khilman@baylibre.com>
Date:   Wed, 25 Sep 2019 14:25:43 -0700
Message-ID: <7hftkkukyw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> During init, ensure that the driver on/off state as well as clock
> state matches the hardware state by calling drivers on/off functions
> based on whether the HW state is on/off.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/soc/amlogic/meson-ee-pwrc.c | 30 +++++++++--------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
> index dcce8e694a07..2cb5341aedfa 100644
> --- a/drivers/soc/amlogic/meson-ee-pwrc.c
> +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
> @@ -323,6 +323,8 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
>  				     struct meson_ee_pwrc *pwrc,
>  				     struct meson_ee_pwrc_domain *dom)
>  {
> +	bool is_off;
> +
>  	dom->pwrc = pwrc;
>  	dom->num_rstc = dom->desc.reset_names_count;
>  	dom->num_clks = dom->desc.clk_names_count;
> @@ -356,27 +358,13 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
>  	dom->base.power_on = meson_ee_pwrc_on;
>  	dom->base.power_off = meson_ee_pwrc_off;
>  
> -	/*
> -         * TOFIX: This is a special case for the VPU power domain, which can
> -	 * be enabled previously by the bootloader. In this case the VPU
> -         * pipeline may be functional but no driver maybe never attach
> -         * to this power domain, and if the domain is disabled it could
> -         * cause system errors. This is why the pm_domain_always_on_gov
> -         * is used here.
> -         * For the same reason, the clocks should be enabled in case
> -         * we need to power the domain off, otherwise the internal clocks
> -         * prepare/enable counters won't be in sync.
> -         */
> -	if (dom->num_clks && dom->desc.is_off && !dom->desc.is_off(dom)) {
> -		int ret = clk_bulk_prepare_enable(dom->num_clks, dom->clks);
> -		if (ret)
> -			return ret;
> -
> -		pm_genpd_init(&dom->base, &pm_domain_always_on_gov, false);
> -	} else
> -		pm_genpd_init(&dom->base, NULL,
> -			      (dom->desc.is_off ?
> -			       dom->desc.is_off(dom) : true));
> +	/* Ensure that driver state matches HW state */
> +	is_off = dom->desc.is_off ? dom->desc.is_off(dom) : true;
> +	if (is_off)
> +		meson_ee_pwrc_off(&dom->base);

Neil pointed out off-list that this isn't quite right.

This _off() call can potentially try to disable clocks that have never
been enabled (by the clock fwk) resulting in noisy warnings.

I'll send a v2 which always calls _on() and then optionall calls _off().
That will ensure that the drivers notion of the clock state also matches
the HW state.

Kevin
