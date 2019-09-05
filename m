Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799BAAA0E3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 13:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfIELG5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 5 Sep 2019 07:06:57 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:59326 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733182AbfIELG4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Sep 2019 07:06:56 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id B3B4B17FE3; Thu,  5 Sep 2019 12:06:54 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <miquel.raynal@bootlin.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>, <eric@anholt.net>,
        <wahrenst@gmx.net>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <mmayer@broadcom.com>,
        <computersforpeace@gmail.com>, <gregory.0xf0@gmail.com>,
        <matthias.bgg@gmail.com>, <agross@kernel.org>, <heiko@sntech.de>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <marc.w.gonzalez@free.fr>, <talel@amazon.com>,
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
Subject: Re: [PATCH -next 12/15] thermal: tango: use devm_platform_ioremap_resource() to simplify code
References: <20190904122939.23780-1-yuehaibing@huawei.com>
        <20190904122939.23780-13-yuehaibing@huawei.com>
Date:   Thu, 05 Sep 2019 12:06:54 +0100
In-Reply-To: <20190904122939.23780-13-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Wed, 4 Sep 2019 20:29:36 +0800")
Message-ID: <yw1xmufj6lyp.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Mans Rullgard <mans@mansr.com>

> ---
>  drivers/thermal/tango_thermal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
> index 304b461..f44441b 100644
> --- a/drivers/thermal/tango_thermal.c
> +++ b/drivers/thermal/tango_thermal.c
> @@ -73,7 +73,6 @@ static void tango_thermal_init(struct tango_thermal_priv *priv)
>
>  static int tango_thermal_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	struct tango_thermal_priv *priv;
>  	struct thermal_zone_device *tzdev;
>
> @@ -81,8 +80,7 @@ static int tango_thermal_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>
> -- 
> 2.7.4
>

-- 
Måns Rullgård
