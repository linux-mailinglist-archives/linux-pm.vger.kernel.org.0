Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1149A89305
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfHKSCH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 14:02:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42913 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfHKSCH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 14:02:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id 15so4621495ljr.9;
        Sun, 11 Aug 2019 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LQ1iGLfDtj2lnEsk9iIw/qcpoUF+FjucXrL64iBzuIo=;
        b=Qi18f0UGWsqimFRmNgEi+JAh6KKllabRbZFih7yICet9D6skfqFNh0KNZpY5X0b6PP
         h8nOJQJ3/slwMuoLD8t3FqZkqyKAYYydgF89bqs26XT54Gndism8/CJpEEZ5mato8yV+
         1TKaOb3HxvRzlSrG9//F9+mYrFinND8xChZzUS4KWJls6acFEmvtJzEyjb4PME1Klcm2
         ch1a0yMx3EtXIjVN9BoHKOn6+NkpXr+BkcUOT+REwvUE/aGgMCZHGG5SZQjH/c7b50cM
         8gA3eYQ2R1BA+ij/yufa5mKq1I27OlLRPUCqVH6PjMgbrz4Og4fcbTrRmHLKhUVNLdKx
         r9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LQ1iGLfDtj2lnEsk9iIw/qcpoUF+FjucXrL64iBzuIo=;
        b=b0wnYbz/ofHZG+iUK4YZNUQkgDJpfCj+DoruiQ22RqvLPL9sDksPlBs1EjOZpz25hE
         U1eRN6rZDveQk33bgO12XKvet7wQElVskDC2zQuNTFZ0rqtoMkgaOHSyvnp3T25Xi0FL
         urm/AFZVk/y7q2T3lM+2ZW3JuUba+vrbtDMR1q1mIseiI41rUlo7+kyStVoWT7vrHAXp
         vUqtJnTav3AQI37W0nezgIeNwOg5qCgxneoL0qoBt3l8r3VkF10TPpHGY4BwMhNr8yyh
         WtoIlJkoYJyC/AigGBv90nQTWK15Dqn1keoUOFvyvILVJsOSllGZAR0mPVYufKRGvG+t
         V5pw==
X-Gm-Message-State: APjAAAXMFFy4UIyGw6XA2QHgG+fVZ7RLX4pvHdy+zSZXMm11ZykfH9Ty
        NjhMiShIZgJVCJ+mmqEPxtYFnyhh
X-Google-Smtp-Source: APXvYqzJz/lxfWp/jMF5PcwzLjTZoSv1bG469uZHzL2G05C6AuC027/gqH9yshQye84YFDUV/mgNpQ==
X-Received: by 2002:a2e:995a:: with SMTP id r26mr17008164ljj.107.1565546524242;
        Sun, 11 Aug 2019 11:02:04 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id v7sm1698146ljc.46.2019.08.11.11.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:02:03 -0700 (PDT)
Subject: Re: [PATCH v8 13/21] clk: tegra210: Use fence_udelay during PLLU init
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
 <1565308020-31952-14-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1d09a2c5-4973-340f-fdfc-d4e665c8b55d@gmail.com>
Date:   Sun, 11 Aug 2019 21:02:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-14-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch uses fence_udelay rather than udelay during PLLU
> initialization to ensure writes to clock registers happens before
> waiting for specified delay.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra210.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
> index 4721ee030d1c..998bf60b219a 100644
> --- a/drivers/clk/tegra/clk-tegra210.c
> +++ b/drivers/clk/tegra/clk-tegra210.c
> @@ -2841,7 +2841,7 @@ static int tegra210_enable_pllu(void)
>  	reg = readl_relaxed(clk_base + pllu.params->ext_misc_reg[0]);
>  	reg &= ~BIT(pllu.params->iddq_bit_idx);
>  	writel_relaxed(reg, clk_base + pllu.params->ext_misc_reg[0]);
> -	udelay(5);
> +	fence_udelay(5, clk_base);
>  
>  	reg = readl_relaxed(clk_base + PLLU_BASE);
>  	reg &= ~GENMASK(20, 0);
> @@ -2849,7 +2849,7 @@ static int tegra210_enable_pllu(void)
>  	reg |= fentry->n << 8;
>  	reg |= fentry->p << 16;
>  	writel(reg, clk_base + PLLU_BASE);
> -	udelay(1);
> +	fence_udelay(1, clk_base);
>  	reg |= PLL_ENABLE;
>  	writel(reg, clk_base + PLLU_BASE);
>  
> @@ -2895,12 +2895,12 @@ static int tegra210_init_pllu(void)
>  		reg = readl_relaxed(clk_base + XUSB_PLL_CFG0);
>  		reg &= ~XUSB_PLL_CFG0_PLLU_LOCK_DLY_MASK;
>  		writel_relaxed(reg, clk_base + XUSB_PLL_CFG0);
> -		udelay(1);
> +		fence_udelay(1, clk_base);
>  
>  		reg = readl_relaxed(clk_base + PLLU_HW_PWRDN_CFG0);
>  		reg |= PLLU_HW_PWRDN_CFG0_SEQ_ENABLE;
>  		writel_relaxed(reg, clk_base + PLLU_HW_PWRDN_CFG0);
> -		udelay(1);
> +		fence_udelay(1, clk_base);
>  
>  		reg = readl_relaxed(clk_base + PLLU_BASE);
>  		reg &= ~PLLU_BASE_CLKENABLE_USB;
> 

The clk_base corresponds to the RESET controller's part of Clock-and-Reset hardware, is it
okay to read-back the RST register and not the clock for the fencing?
