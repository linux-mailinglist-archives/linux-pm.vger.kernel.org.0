Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B213087B09
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407000AbfHINYD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 09:24:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41334 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406273AbfHINYC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 09:24:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so92060104ljg.8;
        Fri, 09 Aug 2019 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/+o0/u5R7NkvJLOhK/ApZRoXnapHD8xOYGepISkAyo=;
        b=VOhvoSeRZ7rD6eBBUk7yxCIOFFVUvpY6230zKj7X3LGI/SKkHO2X0VhK80pGd2Ih+t
         7ihIKwalfwTRlAlWcYY/mlbLjmepTx8pUjcWk1KYuIJ35Xx3raa1hm+0v4WlO7UdzcXR
         lLQyJtAQDcc86ZW3wDxmgqFLRu9XkWrDfT85N0/qMzWaR4rjpad6pJ0fmalVWnXP6I0k
         1ruH+Ksvhh2eT4VfLxIG5pM3SeOVrRfXNOVgHmX0EJSuNt7dFR+whlLypDXexMLOdoN9
         QeutEcEuaJMlGHXHYzatj584/og5ovHrNwtYvd8d/9IxAqA59LuCUg7OTgNYLUlzLXsU
         siDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/+o0/u5R7NkvJLOhK/ApZRoXnapHD8xOYGepISkAyo=;
        b=plgWRJqXXDDpoTy8NgMJDTWO+1lrVJUUt4I1x3a4CMSs03T6XVplB7h+6gcy7eHa20
         gAUhXWjHE+Urh3Fq7TW0EXnV/54nXNWhotRUbSF30UsZ/XgjWbPFMWKBGnMSf3YN/qWZ
         XlmhvNJLPjJaVR21eQGi/8eRdkWolM3PTVqKxN1Uu8uDR24n+La4DLMj9SdOed0zXwcI
         aE5FTLGMDcjKXBI5rIO7jvb1GOvftJyGoC4/rxxJAwzrrpLNH2HERtP5Bu1djBHIAHe/
         mtTyFIkmyqrxrUgwL/cYsqWerqRPCVnBbAvJGDuL62va17YKQG3Ykzy49Y1A3GKkuhI+
         h/QA==
X-Gm-Message-State: APjAAAXtc8mfUSB0OSi77PBBijGvS8kGfZILaOaXp6XYkQIEawJ89AP0
        uFn5r1DAgJuGpHB5YcHt/VG6Kijr
X-Google-Smtp-Source: APXvYqzuRfFIaZqZRYW8OBxrTPdd4Po8MVSKSd90aghFv+4NQr6t4zvRSeu+opbWD080igPw3qasEw==
X-Received: by 2002:a2e:5b5b:: with SMTP id p88mr10938309ljb.192.1565357039258;
        Fri, 09 Aug 2019 06:23:59 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id v14sm19401779ljh.51.2019.08.09.06.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:23:58 -0700 (PDT)
Subject: Re: [PATCH v8 19/21] soc/tegra: pmc: Configure deep sleep control
 settings
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
 <1565308020-31952-20-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <57ed54cd-bf57-cab1-eb63-8548761640de@gmail.com>
Date:   Fri, 9 Aug 2019 16:23:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-20-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> Tegra210 and prior Tegra chips have deep sleep entry and wakeup related
> timings which are platform specific that should be configured before
> entering into deep sleep.
> 
> Below are the timing specific configurations for deep sleep entry and
> wakeup.
> - Core rail power-on stabilization timer
> - OSC clock stabilization timer after SOC rail power is stabilized.
> - Core power off time is the minimum wake delay to keep the system
>   in deep sleep state irrespective of any quick wake event.
> 
> These values depends on the discharge time of regulators and turn OFF
> time of the PMIC to allow the complete system to finish entering into
> deep sleep state.
> 
> These values vary based on the platform design and are specified
> through the device tree.
> 
> This patch has implementation to configure these timings which are must
> to have for proper deep sleep and wakeup operations.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index e013ada7e4e9..9a78d8417367 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -88,6 +88,8 @@
>  
>  #define PMC_CPUPWRGOOD_TIMER		0xc8
>  #define PMC_CPUPWROFF_TIMER		0xcc
> +#define PMC_COREPWRGOOD_TIMER		0x3c
> +#define PMC_COREPWROFF_TIMER		0xe0
>  
>  #define PMC_PWR_DET_VALUE		0xe4
>  
> @@ -2277,7 +2279,7 @@ static const struct tegra_pmc_regs tegra20_pmc_regs = {
>  
>  static void tegra20_pmc_init(struct tegra_pmc *pmc)
>  {
> -	u32 value;
> +	u32 value, osc, pmu, off;
>  
>  	/* Always enable CPU power request */
>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
> @@ -2303,6 +2305,15 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
>  	value |= PMC_CNTRL_SYSCLK_OE;
>  	tegra_pmc_writel(pmc, value, PMC_CNTRL);
> +
> +	osc = DIV_ROUND_UP(pmc->core_osc_time * 8192, 1000000);
> +	pmu = DIV_ROUND_UP(pmc->core_pmu_time * 32768, 1000000);
> +	off = DIV_ROUND_UP(pmc->core_off_time * 32768, 1000000);
> +	if (osc && pmu)
> +		tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
> +				 PMC_COREPWRGOOD_TIMER);
> +	if (off)
> +		tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);

The osc/pmu/off values are undefined if they are not defined in device-tree. I suppose this
need to be corrected in tegra_pmc_parse_dt() if the values really matter even if LP0 suspend
isn't supported in device-tree.

And I'm also not sure what's wrong with setting 0 for the timers.

>  }
>  
>  static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
> 

