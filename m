Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C4387B24
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 15:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407091AbfHIN2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 09:28:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36102 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407085AbfHIN2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 09:28:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so15506339lfp.3;
        Fri, 09 Aug 2019 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDzK4HqGCuYHNeAik93nZOt6GVBVyL4RxyPi6JCejLQ=;
        b=YSmPOe6cdLuMYmLalcXrV1zZPmoP7esgm+eyg9ShiE+r9XIoVfqjsOSmd+p3dusaRZ
         nT8ylNAQWkfK8H+NITQZOI/OKZU+ZtFFSe0ZuzeyI4KWtnzv6APYr/Rihbm5sYUfwxD8
         nbGaCvyuROjMeFcV9+qkn0IQHwl5WNZFO/UobWPDIXDKnp1g4gM0LpYKnB8t0euqShEe
         E+Yw7QMFrIt/KyVRwVnlBxE9F82UzfyetEPh/Z9fia6NIHOMpikbZmMEW2nFwxjtnTbn
         9foy3qAKnkjXCQE35uagSJVeo5Hou4api1+baTtM3V/QcTxMRlMhPX30q15N9TmInibe
         N0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDzK4HqGCuYHNeAik93nZOt6GVBVyL4RxyPi6JCejLQ=;
        b=O9u2GxUA8Rk674G3hPxW27sz8sutU27fHluOYz6fBuW4DOn1rYooyWmeQTWFSItKJe
         ub5jv6LviicNBuxcl4eeq2IUOJ06pcrqi0OTg9cbZukw5/QCKkvlh89NbDkVrcJSGndn
         R+Soa/gVmM9MUdtD/KeCjLyUcncugynPNGT+zvl1I8KCH5Fx3RzTjnj+Z/03gX0MehIx
         4CwCNSNr5nP7qKb//GyCwUxOjZi7plMvZ+njwnhYjwEZkAgXdoiqV1uvYWehBiwmTeSS
         fZtUdfte7/h643yxTzW4tZ888FrQTpHYBe9Zb1kOk97ahwTT1qgWRg271fUoCTszcbep
         jZpA==
X-Gm-Message-State: APjAAAXcxNS8Sd2msu0aB2KbTiUUbIVZFxP3B2g65itkeKHCfIKN/Kty
        O5YosX7vgRMk+7kUDPsPSvIbp+Qe
X-Google-Smtp-Source: APXvYqyOgin95krEezpqlMeS2zy8wXVRzT5ENjo1BnJcIm27WZ57gmXVWTJJgHg99kCnFfTlyqFkWQ==
X-Received: by 2002:a19:8586:: with SMTP id h128mr13172457lfd.62.1565357301241;
        Fri, 09 Aug 2019 06:28:21 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id k23sm16209456ljg.90.2019.08.09.06.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:28:20 -0700 (PDT)
Subject: Re: [PATCH v8 16/21] soc/tegra: pmc: Add pmc wake support for
 tegra210
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
 <1565308020-31952-17-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <85ea23c7-1459-e396-b08a-b38e0f6d44eb@gmail.com>
Date:   Fri, 9 Aug 2019 16:28:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-17-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch implements PMC wakeup sequence for Tegra210 and defines
> common used RTC alarm wake event.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 91c84d0e66ae..3aa71c28a10a 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -58,6 +58,11 @@
>  #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
>  #define  PMC_CNTRL_MAIN_RST		BIT(4)
>  
> +#define PMC_WAKE_MASK			0x0c
> +#define PMC_WAKE_LEVEL			0x10
> +#define PMC_WAKE_STATUS			0x14
> +#define PMC_SW_WAKE_STATUS		0x18
> +
>  #define DPD_SAMPLE			0x020
>  #define  DPD_SAMPLE_ENABLE		BIT(0)
>  #define  DPD_SAMPLE_DISABLE		(0 << 0)
> @@ -87,6 +92,11 @@
>  
>  #define PMC_SCRATCH41			0x140
>  
> +#define PMC_WAKE2_MASK			0x160
> +#define PMC_WAKE2_LEVEL			0x164
> +#define PMC_WAKE2_STATUS		0x168
> +#define PMC_SW_WAKE2_STATUS		0x16c
> +
>  #define PMC_SENSOR_CTRL			0x1b0
>  #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
>  #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
> @@ -1922,6 +1932,43 @@ static const struct irq_domain_ops tegra_pmc_irq_domain_ops = {
>  	.alloc = tegra_pmc_irq_alloc,
>  };
>  
> +static int tegra210_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
> +{
> +	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
> +	unsigned int offset, bit;
> +	u32 value;
> +
> +	if (data->hwirq == ULONG_MAX)
> +		return 0;
> +
> +	offset = data->hwirq / 32;
> +	bit = data->hwirq % 32;
> +
> +	/* clear wake status */
> +	tegra_pmc_writel(pmc, 0, PMC_SW_WAKE_STATUS);
> +	tegra_pmc_writel(pmc, 0, PMC_SW_WAKE2_STATUS);
> +
> +	tegra_pmc_writel(pmc, 0, PMC_WAKE_STATUS);
> +	tegra_pmc_writel(pmc, 0, PMC_WAKE2_STATUS);
> +
> +	/* enable PMC wake */
> +	if (data->hwirq >= 32)
> +		offset = PMC_WAKE2_MASK;
> +	else
> +		offset = PMC_WAKE_MASK;
> +
> +	value = tegra_pmc_readl(pmc, offset);
> +
> +	if (on)
> +		value |= 1 << bit;
> +	else
> +		value &= ~(1 << bit);

Looks like a good case for utilizing of the BIT() macro here.
