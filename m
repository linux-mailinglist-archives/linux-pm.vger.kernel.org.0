Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C410A8325
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfIDMnm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 4 Sep 2019 08:43:42 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41681 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIDMnl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 08:43:41 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1B4DA2000E;
        Wed,  4 Sep 2019 12:43:33 +0000 (UTC)
Date:   Wed, 4 Sep 2019 14:43:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <eric@anholt.net>, <wahrenst@gmx.net>, <f.fainelli@gmail.com>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <mmayer@broadcom.com>, <computersforpeace@gmail.com>,
        <gregory.0xf0@gmail.com>, <matthias.bgg@gmail.com>,
        <agross@kernel.org>, <heiko@sntech.de>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <marc.w.gonzalez@free.fr>, <mans@mansr.com>, <talel@amazon.com>,
        <jun.nie@linaro.org>, <shawnguo@kernel.org>,
        <phil@raspberrypi.org>, <gregkh@linuxfoundation.org>,
        <david.hernandezsanchez@st.com>, <horms+renesas@verge.net.au>,
        <wsa+renesas@sang-engineering.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH -next 01/15] thermal: armada: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20190904144332.46ab190f@xps13>
In-Reply-To: <20190904122939.23780-2-yuehaibing@huawei.com>
References: <20190904122939.23780-1-yuehaibing@huawei.com>
        <20190904122939.23780-2-yuehaibing@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yue,

YueHaibing <yuehaibing@huawei.com> wrote on Wed, 4 Sep 2019 20:29:25
+0800:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/thermal/armada_thermal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 709a22f..70fe9c6 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -708,12 +708,10 @@ static int armada_thermal_probe_legacy(struct platform_device *pdev,
>  				       struct armada_thermal_priv *priv)
>  {
>  	struct armada_thermal_data *data = priv->data;
> -	struct resource *res;
>  	void __iomem *base;
>  
>  	/* First memory region points towards the status register */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
