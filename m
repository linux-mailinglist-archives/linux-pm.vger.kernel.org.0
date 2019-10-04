Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646D0CC533
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfJDVuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 17:50:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38224 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfJDVuR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Oct 2019 17:50:17 -0400
Received: from 94.112.246.102.static.b2b.upcbusiness.cz ([94.112.246.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iGVSP-0006tk-DS; Fri, 04 Oct 2019 23:49:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     miquel.raynal@bootlin.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, eric@anholt.net, wahrenst@gmx.net,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        mmayer@broadcom.com, computersforpeace@gmail.com,
        gregory.0xf0@gmail.com, matthias.bgg@gmail.com, agross@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, talel@amazon.com,
        jun.nie@linaro.org, shawnguo@kernel.org, phil@raspberrypi.org,
        gregkh@linuxfoundation.org, david.hernandezsanchez@st.com,
        horms+renesas@verge.net.au, wsa+renesas@sang-engineering.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH -next 09/15] thermal: rockchip: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 04 Oct 2019 23:49:47 +0200
Message-ID: <6308452.QoXZFhLlpT@phil>
In-Reply-To: <20190904122939.23780-10-yuehaibing@huawei.com>
References: <20190904122939.23780-1-yuehaibing@huawei.com> <20190904122939.23780-10-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, 4. September 2019, 14:29:33 CEST schrieb YueHaibing:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/thermal/rockchip_thermal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 343c2f5..044e6eb 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1219,7 +1219,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct rockchip_thermal_data *thermal;
>  	const struct of_device_id *match;
> -	struct resource *res;
>  	int irq;
>  	int i;
>  	int error;
> @@ -1245,8 +1244,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  	if (!thermal->chip)
>  		return -EINVAL;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	thermal->regs = devm_ioremap_resource(&pdev->dev, res);
> +	thermal->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(thermal->regs))
>  		return PTR_ERR(thermal->regs);
>  
> 




