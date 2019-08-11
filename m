Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD9E89307
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKSEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 14:04:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46414 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfHKSE3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 14:04:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id h13so921849ljc.13;
        Sun, 11 Aug 2019 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mwCCmTPyZMzB8rOB2/u+aHD+9E+Hp331HV98rXItsy0=;
        b=ibKaAsX9ikH9awumenb7RFQejb6OIAjvguIQ9x3qSfgbwDLOe8y/isrP8t5T3aExCp
         yCo5P6K2VaEfSATv2a+z1mCazdhQDKSs13QPvF6ht/6RIOfmsM5k/GPSlqSCDzFyhyrq
         8ZTzSXievbbq6VrTpFjYFyF4VDrWM15oD0e2Yr54MKmRoj8TPqHFO0PE9ZqH7F5EYnB0
         yt9kf7ReoKEBg+km75tj9r38bOrDmRoqH5a/lrG0V49p5edci7qQRpLv6srb35j+qnki
         C0o3grbkFP9lECGJys7YY4BBYLKiBGB5fjZFOZc88RrrgHAsUQDGF7l1HzbYh6NWEWcC
         DG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mwCCmTPyZMzB8rOB2/u+aHD+9E+Hp331HV98rXItsy0=;
        b=jWeplow+YNcVZjmXikoRY3sGYBYKEiBTIi3SMGD/s12Sa6kXudQyuLc1mklpaRFGIV
         +QQaalfsyIv2XuZzZt9W1oyOy69S2FSeWXV1Y61QOXa+8iK3gMIR/IlwVUKsq40wNupH
         f4fNuVo6do3z413dArM0UlFans9++fnCBTP/HY5nDvw7qwVQhBbO5KZBeGa+sj4im910
         bNsWVUs5Q8kQamkydp9PzyxZZVkVLgjmBFsgM14loWYQ6/DHc/XqyI+oDHCdOgQ3021k
         3x8MoBR2f7bfi3GULg+NB9ItVEufGHm7iQPe8jB0AAcYfgvLo7iYLOPXKrdxrmoPjVmF
         PCVw==
X-Gm-Message-State: APjAAAWX1/+4OqoHVo7b/5QQiX2hBJu1o+DnutedGs+PkFFTi7i5frGl
        eQ1nYiFq2FEJotn5mjTEh+8U0odi
X-Google-Smtp-Source: APXvYqwSAgc+L2f0y5uKMKUohDnZg6B/2bgLcBngpfnUX56foIbBQ87h6ZEZBm1g5ve48U2Q1YAbvw==
X-Received: by 2002:a2e:9f0d:: with SMTP id u13mr17165699ljk.186.1565546666339;
        Sun, 11 Aug 2019 11:04:26 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id v7sm20649866ljj.3.2019.08.11.11.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:04:25 -0700 (PDT)
Subject: Re: [PATCH v8 04/21] clk: tegra: pllout: Save and restore pllout
 context
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
 <1565308020-31952-5-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3bc1cdc5-c8e7-a210-67ae-2a3f6f01660f@gmail.com>
Date:   Sun, 11 Aug 2019 21:04:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-5-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch implements save and restore of pllout context.
> 
> During system suspend, core power goes off and looses the settings
> of the Tegra CAR controller registers.
> 
> So during suspend entry the state of pllout is saved and on resume
> it is restored back to have pllout in same state as before suspend.
> 
> pllout rate is saved and restore in clock divider so it will be at
> same rate as before suspend when pllout state is restored.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-pll-out.c  | 9 +++++++++
>  drivers/clk/tegra/clk-tegra210.c | 3 ++-
>  drivers/clk/tegra/clk.h          | 6 ++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll-out.c b/drivers/clk/tegra/clk-pll-out.c
> index 35f2bf00e1e6..d8bf89a81e6d 100644
> --- a/drivers/clk/tegra/clk-pll-out.c
> +++ b/drivers/clk/tegra/clk-pll-out.c
> @@ -69,10 +69,19 @@ static void clk_pll_out_disable(struct clk_hw *hw)
>  		spin_unlock_irqrestore(pll_out->lock, flags);
>  }
>  
> +static void tegra_clk_pll_out_restore_context(struct clk_hw *hw)
> +{
> +	if (!__clk_get_enable_count(hw->clk))
> +		clk_pll_out_disable(hw);
> +	else
> +		clk_pll_out_enable(hw);
> +}
> +
>  const struct clk_ops tegra_clk_pll_out_ops = {
>  	.is_enabled = clk_pll_out_is_enabled,
>  	.enable = clk_pll_out_enable,
>  	.disable = clk_pll_out_disable,
> +	.restore_context = tegra_clk_pll_out_restore_context,
>  };
>  
>  struct clk *tegra_clk_register_pll_out(const char *name,
> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
> index df172d5772d7..4721ee030d1c 100644
> --- a/drivers/clk/tegra/clk-tegra210.c
> +++ b/drivers/clk/tegra/clk-tegra210.c
> @@ -3200,7 +3200,8 @@ static void __init tegra210_pll_init(void __iomem *clk_base,
>  					 8, 8, 1, NULL);
>  	clk = tegra_clk_register_pll_out("pll_re_out1", "pll_re_out1_div",
>  					 clk_base + PLLRE_OUT1, 1, 0,
> -					 CLK_SET_RATE_PARENT, 0, NULL);
> +					 CLK_SET_RATE_PARENT, TEGRA_PLLRE_OUT,
> +					 NULL);
>  	clks[TEGRA210_CLK_PLL_RE_OUT1] = clk;
>  
>  	/* PLLE */
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index 905bf1096558..a464524fbc90 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -437,6 +437,10 @@ struct clk *tegra_clk_register_pllu_tegra210(const char *name,
>   * @rst_bit_idx:	bit to reset PLL divider
>   * @lock:		register lock
>   * @flags:		hardware-specific flags
> + *
> + * Flags:
> + * TEGRA_PLLRE_OUT - This flag indicates that it is PLLRE_OUT and is used to
> + *		     identify PLLRE_OUT during clk_pll_out save and restore.
>   */
>  struct tegra_clk_pll_out {
>  	struct clk_hw	hw;
> @@ -447,6 +451,8 @@ struct tegra_clk_pll_out {
>  	u8		flags;
>  };
>  
> +#define TEGRA_PLLRE_OUT BIT(0)
> +
>  #define to_clk_pll_out(_hw) container_of(_hw, struct tegra_clk_pll_out, hw)
>  
>  extern const struct clk_ops tegra_clk_pll_out_ops;
> 

Looks like the TEGRA_PLLRE_OUT flag is unused.

