Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAB94AC4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfHSQsT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 12:48:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36387 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfHSQsS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 12:48:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id u15so2408239ljl.3;
        Mon, 19 Aug 2019 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4cCBpaVpJ68XhsS0fEBg/zeEbwE8v9btGHUczOVXYFE=;
        b=M0rBRZ0zHOHx6M2/xN0hgV4nZtnt2cV1h94sqVV8wmkyT9XTOer9bHkat3otrnqfmE
         E5P3jNSp15/gqivlJ5NUmnOhCM0bY/rDLwB0VLX1RPsRBWEdLFJn3PaU81KvHbSAlKRH
         3I5lMGirf23PB6N53k9JleivAgMYoiOV0pOo/xPIqlgiWUjDOek/WNVamjgk5FBk6QWU
         yrkcyAlErD5jOwE8EtgavErXhQcNrlwS65reFNFCC+CqG6y4qvf1i0h+uxm4UB+hansh
         UcBsx9jAZdoJKPnZbomzA5sHXEzl44hAzRPwxTu75JQp+YChyMyvjaqT+K8OGW8lVdiS
         YYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4cCBpaVpJ68XhsS0fEBg/zeEbwE8v9btGHUczOVXYFE=;
        b=ZHmp4TxxM2VXpw8e5O6VzAeSlcVUGxxPwD3YbRiXgAfFH7b9vbmD1+C+9AOudkZyvV
         EpKn7+HBW2MCh9fY22csVLoN/het2xciYr6eWUSNItFGbrlcQv41IMFe23hHEbPexepz
         lTMsJWIIMM6jCtBg9b8KlyrdNI5afNI+YzhvbNUYJi6JbZ4nXMhyCgnRD2VtvJa9qvhF
         qRbMteWYhAoKqUr9yhXKGj4P8h8PpGeeLCIRx6PsbDytpveWc4JE5f5WhjdWUmAcpJ3w
         hw9Y50Hf0YdBMakMHzss+Pd2xMs/I72jaeSZwquTe9yDxj6r1dDGOr1kQjiEyctsSnEZ
         +k0w==
X-Gm-Message-State: APjAAAV+u67/l5FUnDnQC79Kea6ka9JtKYganT4s8Qz5RU6bRt2yn3jw
        fXkCziD3zugUnEdt+TfChv9xspkw
X-Google-Smtp-Source: APXvYqysRECmtvRVy8+XpPVm1yeXw0Q+dIDjZj8OGuKne9FSQJ9xNjC13u/L/MlN8hCh68CGjJ8Jlg==
X-Received: by 2002:a2e:914c:: with SMTP id q12mr5961018ljg.34.1566233294537;
        Mon, 19 Aug 2019 09:48:14 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id r12sm2680502ljg.36.2019.08.19.09.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:48:13 -0700 (PDT)
Subject: Re: [PATCH v9 20/22] soc/tegra: pmc: Configure deep sleep control
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
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-21-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bf5541d2-1bad-8a8c-fd9d-821b55861136@gmail.com>
Date:   Mon, 19 Aug 2019 19:48:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565984527-5272-21-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.08.2019 22:42, Sowjanya Komatineni пишет:
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
>  drivers/soc/tegra/pmc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 53ed70773872..710969043668 100644
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
> @@ -2303,6 +2305,16 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
>  	value |= PMC_CNTRL_SYSCLK_OE;
>  	tegra_pmc_writel(pmc, value, PMC_CNTRL);
> +
> +	/* program core timings which are applicable only for suspend state */
> +	if (pmc->suspend_mode != TEGRA_SUSPEND_NONE) {
> +		osc = DIV_ROUND_UP(pmc->core_osc_time * 8192, 1000000);
> +		pmu = DIV_ROUND_UP(pmc->core_pmu_time * 32768, 1000000);
> +		off = DIV_ROUND_UP(pmc->core_off_time * 32768, 1000000);
> +		tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
> +				 PMC_COREPWRGOOD_TIMER);
> +		tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);
> +	}
>  }
>  
>  static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
> 

In the previous version of this patch there were checks for zero values
of the timers with intention to skip programming of the timers if value
is zero. I'm a bit puzzled by the new version, given that SUSPEND_NONE
means that suspending isn't available at all and thus PMC timers won't
be utilized, hence it shouldn't matter what values are programmed for
the counters, isn't it?
