Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3FC133E77
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 10:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgAHJli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 04:41:38 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:34853 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgAHJli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 04:41:38 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 97692200010;
        Wed,  8 Jan 2020 09:41:32 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, ssantosh@kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, rogerq@ti.com,
        tony@atomide.com, lukasz.luba@arm.com, kgene@kernel.org,
        krzk@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        allison@lohutok.net, tglx@linutronix.de, yong.wu@mediatek.com,
        jroedel@suse.de, evgreen@chromium.org, rfontana@redhat.com,
        digetx@gmail.com, pdeschrijver@nvidia.com, john@phrozen.org,
        alexios.zavras@intel.com, sboyd@kernel.org,
        kstewart@linuxfoundation.org, info@metux.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 3/9] memory: mvebu-devbus: convert to devm_platform_ioremap_resource
In-Reply-To: <20191222185034.4665-3-tiny.windzz@gmail.com>
References: <20191222185034.4665-1-tiny.windzz@gmail.com> <20191222185034.4665-3-tiny.windzz@gmail.com>
Date:   Wed, 08 Jan 2020 10:41:32 +0100
Message-ID: <87lfqib7zn.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yangtao Li,

> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>


Applied on mvebu/drivers

Thanks,

Gregory

> ---
>  drivers/memory/mvebu-devbus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
> index 095f8a3b2cfc..886aea587276 100644
> --- a/drivers/memory/mvebu-devbus.c
> +++ b/drivers/memory/mvebu-devbus.c
> @@ -267,7 +267,6 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
>  	struct devbus_read_params r;
>  	struct devbus_write_params w;
>  	struct devbus *devbus;
> -	struct resource *res;
>  	struct clk *clk;
>  	unsigned long rate;
>  	int err;
> @@ -277,8 +276,7 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	devbus->dev = dev;
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	devbus->base = devm_ioremap_resource(&pdev->dev, res);
> +	devbus->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(devbus->base))
>  		return PTR_ERR(devbus->base);
>  
> -- 
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
