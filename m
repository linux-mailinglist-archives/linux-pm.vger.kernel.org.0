Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3078287A6A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 14:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406700AbfHIMqK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 08:46:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44644 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfHIMqK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 08:46:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so91944005ljc.11;
        Fri, 09 Aug 2019 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oHD9gAbpUGqohG11KOfFTQG8DPTHY5YiY1mqT8307h0=;
        b=Aicz9GKaiBL3XNYy5FUJNijtWIq0HJaEKfd7pD9t0ChHaGa9Y6LvuNZ/sXwHV/X0BH
         yon5hYP3TQtf11PavNBvvfat9+Yb1J76Pxdfj8m58OJ59I4Y0O2gxMUz7KZCkEUKsVrp
         V8nS5wxKUUhFsoDM5a/QUoD2q2aOwiMJcFyOtJcXpIQ1ILVwMXL8iHee1q1pByLXTp7R
         fPGJq5NbJ6kSX7fokzgVoyKeBrdltU5JeF91YhpbJdIt12xzx1e8h1Q7oxVJFlHyUSzM
         4Bz361fkZX9xNhoubpAMwuropRnPruAKK6KMfw4OvUdrEju1PFjFocFpNZLqv8pGTbaQ
         EuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oHD9gAbpUGqohG11KOfFTQG8DPTHY5YiY1mqT8307h0=;
        b=Ig4IpEx2uURg+2biZT91bNMdGIem5yPCmdQT08oDASzo42uXaWVIKONA137jubl8tG
         0acbtI2tcL8UuE6LB7M50uBL4tNim3a8/RcW2BCrdapcrzPVN4cApcrQczLlAUczmle7
         897HO3xz+/XVHEogqyAHMHtAu6rodAW0fkIHwtkQMlmJi71FF/BmeFs6tyaCsa3wmuHb
         GSZyfP6J6OG4xNhQTFvj48ZXigi/fK+7CMYlJUa99F6L+tRAMPHjDKjaNREROAZF7MM9
         zi9VjqAkG+SCwLnvS7oTtvg+Alkv19VFSm4SHjtj+GTVyBx57b90fSuK9s79zb5HmDGc
         7Jtg==
X-Gm-Message-State: APjAAAWe+D7ZcPmU+HDhCAQRiwwnsL4m1EWGQMpwn6XkOc7ehimoLbvC
        Atgkzh82fBuB9IxIXVEny938lQHc
X-Google-Smtp-Source: APXvYqyqnTJF/IDLsH/Wh7eA04jc+Hd8J1dnUy6eHI5Oz6M87mrrHA6GwJ7gbtqVvE/Q0rNE+X8SAw==
X-Received: by 2002:a2e:9c19:: with SMTP id s25mr11168306lji.188.1565354766958;
        Fri, 09 Aug 2019 05:46:06 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id a15sm3206759lfo.2.2019.08.09.05.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 05:46:06 -0700 (PDT)
Subject: Re: [PATCH v8 05/21] clk: tegra: pll: Save and restore pll context
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-6-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3e5867db-2675-a701-948b-1436f9d5dcd9@gmail.com>
Date:   Fri, 9 Aug 2019 15:46:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-6-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch implements save and restore of PLL context.
> 
> During system suspend, core power goes off and looses the settings
> of the Tegra CAR controller registers.
> 
> So during suspend entry pll context is stored and on resume it is
> restored back along with its state.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-pll.c | 88 ++++++++++++++++++++++++++++-----------------
>  drivers/clk/tegra/clk.h     |  2 ++
>  2 files changed, 58 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 1583f5fc992f..e52add2bbdbb 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -1008,6 +1008,28 @@ static unsigned long clk_plle_recalc_rate(struct clk_hw *hw,
>  	return rate;
>  }
>  
> +static void tegra_clk_pll_restore_context(struct clk_hw *hw)
> +{
> +	struct tegra_clk_pll *pll = to_clk_pll(hw);
> +	struct clk_hw *parent = clk_hw_get_parent(hw);
> +	unsigned long parent_rate = clk_hw_get_rate(parent);
> +	unsigned long rate = clk_hw_get_rate(hw);
> +	u32 val;
> +
> +	if (clk_pll_is_enabled(hw))
> +		return;
> +
> +	if (pll->params->set_defaults)
> +		pll->params->set_defaults(pll);
> +
> +	clk_pll_set_rate(hw, rate, parent_rate);
> +
> +	if (!__clk_get_enable_count(hw->clk))
> +		clk_pll_disable(hw);
> +	else
> +		clk_pll_enable(hw);
> +}

drivers/clk/tegra/clk-pll.c: In function ‘tegra_clk_pll_restore_context’:
drivers/clk/tegra/clk-pll.c:1024:6: warning: unused variable ‘val’ [-Wunused-variable]
 1024 |  u32 val;

