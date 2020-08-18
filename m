Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F928248079
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 10:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHRIW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 04:22:26 -0400
Received: from foss.arm.com ([217.140.110.172]:37866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRIW0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Aug 2020 04:22:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74771FB;
        Tue, 18 Aug 2020 01:22:25 -0700 (PDT)
Received: from [10.37.12.68] (unknown [10.37.12.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA8FC3F66B;
        Tue, 18 Aug 2020 01:22:21 -0700 (PDT)
Subject: Re: [PATCH 16/16] memory: samsung: exynos5422-dmc: Correct white
 space issues
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-17-krzk@kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f02d1d01-aefa-cdae-c937-7a3b6e4e3114@arm.com>
Date:   Tue, 18 Aug 2020 09:22:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200724182328.3348-17-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/24/20 7:23 PM, Krzysztof Kozlowski wrote:
> Remove unneeded blank line and align indentation with open parenthesis.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 0388066a7d96..62a7193e3904 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -1394,7 +1394,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>   		return PTR_ERR(dmc->base_drexi1);
>   
>   	dmc->clk_regmap = syscon_regmap_lookup_by_phandle(np,
> -				"samsung,syscon-clk");
> +							  "samsung,syscon-clk");
>   	if (IS_ERR(dmc->clk_regmap))
>   		return PTR_ERR(dmc->clk_regmap);
>   
> @@ -1473,7 +1473,6 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>   		exynos5_dmc_df_profile.polling_ms = 500;
>   	}
>   
> -
>   	dmc->df = devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
>   					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
>   					  &dmc->gov_data);
> 

LGTM

Acked-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
