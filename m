Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1B892FC
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHKRwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 13:52:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35622 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKRwc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 13:52:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so6444471lje.2;
        Sun, 11 Aug 2019 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rIU90j9rmc0loKWn/Zvdc4rY0H97o0GEeKBESXJwW0A=;
        b=VMfbVcIxRwIj74Ya3SeIBTYo+Q3lx7+9VjhmEhhYZlu4988dm4YbJmz++gucXsDGBB
         nRD073sJKCh8P95/CCmX/chQxVKVIfRlErURNt3qv5u1OI3MQmEqqx7ut24BOB4xTEFi
         VqbKzvtH8LF1sNKMqvWCfiQFe51v14/8XKFSi9t0aYG8k6VntcJf+c+yx+E5RdzNmUQy
         MiK4nI8QpD43MIrbcilgqt3oH4QFehZi0dn4oAY8011Ls703PmYSm9g2FJCP68Q+ccTq
         svrQrRWp0j0Yp+hUM2cbQkORp+MU2hV0ciOOmf1owjLD8AKnc+ub6WAITcBtoJuvcDuq
         xEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIU90j9rmc0loKWn/Zvdc4rY0H97o0GEeKBESXJwW0A=;
        b=eOAB0Urb/hs+e9L36UujyxySy7Kiz67XEQnLmlYeWmqg0WmCjCmDkDgnQWO1TzCvBx
         Md78/WEp16XERIECp9ekBVEogp4cIWQE7wJKtezUW3Piu4Dn9BFF1YW+wNGDOlI14+LQ
         XISxPNIVobGGqlZ2GKK6qiUyft4SWMHxFWXhB6ktk6kv2BhX1yiP4+W/dluJzKIBi/5n
         nZKCTocbkJCVn32SzW+gFQfjLQKLOJkAZfAOlGbjfGfcFGMIHwnuXPMe4bhMOP7+mZb5
         Ijx2FjOvlSijOdoGAedV6eXqIiQk6oo49YV3YTeWh2YayEWnbW9FrT0VUhKzygqLSmAZ
         kcXA==
X-Gm-Message-State: APjAAAVjwBb6tO1h1ZgAorc9aWfOZqlcDuikswEu1f6yMvdtAqf44F2A
        Q/9n7PjmVCxZbtrKditFMFFv4J94
X-Google-Smtp-Source: APXvYqwZ9Ji04vtk6kNzV+t0QZO7OK2X65TeYFt1oxK8FP21Bf2xuGQRdgvYT7bIR3lDyeFMnGFD1A==
X-Received: by 2002:a2e:b0c6:: with SMTP id g6mr6084135ljl.60.1565545949227;
        Sun, 11 Aug 2019 10:52:29 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id r68sm18553765lff.52.2019.08.11.10.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 10:52:28 -0700 (PDT)
Subject: Re: [PATCH v8 15/21] soc/tegra: pmc: Allow to support more tegras
 wake
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
 <1565308020-31952-16-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <53634c8e-1295-86eb-60c2-27da26d05400@gmail.com>
Date:   Sun, 11 Aug 2019 20:52:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-16-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch allows to create separate irq_set_wake and irq_set_type
> implementations for different tegra designs PMC that has different
> wake models which require difference wake registers and different
> programming sequence.
> 
> AOWAKE model support is available for Tegra186 and Tegra194 only
> and it resides within PMC and supports tiered wake architecture.
> 
> Tegra210 and prior tegra designs uses PMC directly to receive wake
> events and coordinate the wake sequence.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 9f9c1c677cf4..91c84d0e66ae 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -226,6 +226,8 @@ struct tegra_pmc_soc {
>  	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
>  				   struct device_node *np,
>  				   bool invert);
> +	int (*irq_set_wake)(struct irq_data *data, unsigned int on);
> +	int (*irq_set_type)(struct irq_data *data, unsigned int type);
>  
>  	const char * const *reset_sources;
>  	unsigned int num_reset_sources;
> @@ -1920,7 +1922,7 @@ static const struct irq_domain_ops tegra_pmc_irq_domain_ops = {
>  	.alloc = tegra_pmc_irq_alloc,
>  };
>  
> -static int tegra_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
> +static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
>  {
>  	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
>  	unsigned int offset, bit;
> @@ -1952,7 +1954,7 @@ static int tegra_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
>  	return 0;
>  }
>  
> -static int tegra_pmc_irq_set_type(struct irq_data *data, unsigned int type)
> +static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
>  {
>  	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
>  	u32 value;
> @@ -2006,8 +2008,8 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
>  	pmc->irq.irq_unmask = irq_chip_unmask_parent;
>  	pmc->irq.irq_eoi = irq_chip_eoi_parent;
>  	pmc->irq.irq_set_affinity = irq_chip_set_affinity_parent;
> -	pmc->irq.irq_set_type = tegra_pmc_irq_set_type;
> -	pmc->irq.irq_set_wake = tegra_pmc_irq_set_wake;
> +	pmc->irq.irq_set_type = pmc->soc->irq_set_type;
> +	pmc->irq.irq_set_wake = pmc->soc->irq_set_wake;
>  
>  	pmc->domain = irq_domain_add_hierarchy(parent, 0, 96, pmc->dev->of_node,
>  					       &tegra_pmc_irq_domain_ops, pmc);
> @@ -2680,6 +2682,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
>  	.regs = &tegra186_pmc_regs,
>  	.init = NULL,
>  	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
> +	.irq_set_wake = tegra186_pmc_irq_set_wake,
> +	.irq_set_type = tegra186_pmc_irq_set_type,
>  	.reset_sources = tegra186_reset_sources,
>  	.num_reset_sources = ARRAY_SIZE(tegra186_reset_sources),
>  	.reset_levels = tegra186_reset_levels,
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
