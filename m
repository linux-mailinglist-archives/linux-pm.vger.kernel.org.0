Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFA12CE1C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 10:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfL3JNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 04:13:53 -0500
Received: from foss.arm.com ([217.140.110.172]:53560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfL3JNx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Dec 2019 04:13:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 745A8328;
        Mon, 30 Dec 2019 01:13:52 -0800 (PST)
Received: from [10.37.12.68] (unknown [10.37.12.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31233F703;
        Mon, 30 Dec 2019 01:13:45 -0800 (PST)
Subject: Re: [PATCH 7/9] memory: samsung: exynos5422-dmc: convert to
 devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>, ssantosh@kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, rogerq@ti.com,
        tony@atomide.com, kgene@kernel.org, krzk@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        allison@lohutok.net, tglx@linutronix.de, yong.wu@mediatek.com,
        jroedel@suse.de, evgreen@chromium.org, rfontana@redhat.com,
        digetx@gmail.com, pdeschrijver@nvidia.com, john@phrozen.org,
        alexios.zavras@intel.com, sboyd@kernel.org,
        kstewart@linuxfoundation.org, info@metux.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
 <20191222185034.4665-7-tiny.windzz@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a331ae9c-ee2c-6c5e-3a61-a50c172359aa@arm.com>
Date:   Mon, 30 Dec 2019 09:13:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191222185034.4665-7-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 12/22/19 6:50 PM, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 47dbf6d1789f..81a1b1d01683 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -1374,7 +1374,6 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
>   	struct exynos5_dmc *dmc;
> -	struct resource *res;
>   	int irq[2];
>   
>   	dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
> @@ -1386,13 +1385,11 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>   	dmc->dev = dev;
>   	platform_set_drvdata(pdev, dmc);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dmc->base_drexi0 = devm_ioremap_resource(dev, res);
> +	dmc->base_drexi0 = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(dmc->base_drexi0))
>   		return PTR_ERR(dmc->base_drexi0);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	dmc->base_drexi1 = devm_ioremap_resource(dev, res);
> +	dmc->base_drexi1 = devm_platform_ioremap_resource(pdev, 1);
>   	if (IS_ERR(dmc->base_drexi1))
>   		return PTR_ERR(dmc->base_drexi1);
>   
> 

Acked-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
