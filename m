Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D1C87AE3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406848AbfHINN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 09:13:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45574 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHINNZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 09:13:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id a30so6430752lfk.12;
        Fri, 09 Aug 2019 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R/qbfybNTawBfvTZEySh0cjltm2Kq0tph5R6n428udM=;
        b=GlblEZrkT23FfH3YxwgAttCw6xMNP7KmjYM4WXbspvsjFKfa2jnMBD9iz9n/359YcB
         mh1ba0d5xf1zHxpLYacNsJ3P90ZN+296q6JzVff86xucaYj/+8z6O4lg6Lk8RQX1Ftfi
         ISE1PqIr2YzS82esJXELAiYZhczT1wMe71LlZOhk/PnPHjZ2R5k3+3XQCEEg4zOWHdHr
         md4eFoFMjx17VGzybjmylCG7pkgn06aca+wnsBRr6jiVDdjPDUmN+4APIHiT9poKviyF
         oMEBxX3477w1dW3K+x6B52wSS/8CkF3eQtIrPf+jvad1ZuOdshSYXAMuhyVGzBm78tth
         3qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/qbfybNTawBfvTZEySh0cjltm2Kq0tph5R6n428udM=;
        b=j1YtCmyfZ48Dgraz2bmpoKEtL8ufcAevdF5JTPvFIHTIsWQb9AbJJKXb8Ubr9jvBdT
         aOmBfvE+yNH/iiuwkxoDvR09+MdssA7ZCVUf021iZMI9sjcP9jwRbz4ezqKDthz5pfU+
         T7PF9T9c/8WIFPaQiTQCygYlLL5JPytZEh0GMd4yfRjLiRTMgRF0uLc1UdbPHitH8Wqu
         B964jWD7e/OX3C6P9tavqmGTEx5x5l0Q34ihhX7kPpHcIqgu7s8ZsJhX90uOFoBWELKB
         EFi8hKDg5X91ctI0nlZ7d7xwj9jQT+WCz5fhnpfWE+JG2Y1Srny2fOMvU7Ipw4OqK+CH
         EthQ==
X-Gm-Message-State: APjAAAVaqDVFElqP5I4yHme1FMNQlqfG6NqGKEQhFVO/gzyEihhdodzT
        sd7s+OVI4j7Ig1SsDTH6PV4KB+2K
X-Google-Smtp-Source: APXvYqyf29S37MuD+Ii1VOieSMvQRwalWsMCTSNp4taVg2fWHXkXUtz+sOa2dH9UTLHVaWFwFCfeCQ==
X-Received: by 2002:ac2:568e:: with SMTP id 14mr12994101lfr.189.1565356402685;
        Fri, 09 Aug 2019 06:13:22 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id k124sm17587000lfd.60.2019.08.09.06.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:13:21 -0700 (PDT)
Subject: Re: [PATCH v8 18/21] soc/tegra: pmc: Configure core power request
 polarity
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
 <1565308020-31952-19-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <29842147-a5f8-d51d-c594-b93b20b2e20f@gmail.com>
Date:   Fri, 9 Aug 2019 16:13:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-19-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch configures polarity of the core power request signal
> in PMC control register based on the device tree property.
> 
> PMC asserts and de-asserts power request signal based on it polarity
> when it need to power-up and power-down the core rail during SC7.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 3aa71c28a10a..e013ada7e4e9 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -56,6 +56,7 @@
>  #define  PMC_CNTRL_SIDE_EFFECT_LP0	BIT(14) /* LP0 when CPU pwr gated */
>  #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
>  #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
> +#define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
>  #define  PMC_CNTRL_MAIN_RST		BIT(4)
>  
>  #define PMC_WAKE_MASK			0x0c
> @@ -2290,6 +2291,11 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
>  	else
>  		value |= PMC_CNTRL_SYSCLK_POLARITY;
>  
> +	if (pmc->corereq_high)
> +		value &= ~PMC_CNTRL_PWRREQ_POLARITY;
> +	else
> +		value |= PMC_CNTRL_PWRREQ_POLARITY;
> +
>  	/* configure the output polarity while the request is tristated */
>  	tegra_pmc_writel(pmc, value, PMC_CNTRL);
>  
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
