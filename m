Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E65FDD1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 22:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfGDUn6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 16:43:58 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:57599 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDUn6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 16:43:58 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E568E100006;
        Thu,  4 Jul 2019 20:43:37 +0000 (UTC)
Date:   Thu, 4 Jul 2019 22:43:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: [PATCH v2 3/7] rtc: mt6397: improvements of rtc driver
Message-ID: <20190704204336.GJ3692@piout.net>
References: <20190703164822.17924-1-frank-w@public-files.de>
 <20190703164822.17924-4-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703164822.17924-4-frank-w@public-files.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/07/2019 18:48:18+0200, Frank Wunderlich wrote:
> @@ -271,14 +268,11 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> 
>  	platform_set_drvdata(pdev, rtc);
> 
> -	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
> -	if (IS_ERR(rtc->rtc_dev))
> -		return PTR_ERR(rtc->rtc_dev);
> +	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> +					mtk_rtc_irq_handler_thread,
> +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> +					"mt6397-rtc", rtc);
> 

This change may lead to a crash and the allocation was intentionally
placed before the irq request.

> -	ret = request_threaded_irq(rtc->irq, NULL,
> -				   mtk_rtc_irq_handler_thread,
> -				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> -				   "mt6397-rtc", rtc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
>  			rtc->irq, ret);
> @@ -287,6 +281,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> 
>  	device_init_wakeup(&pdev->dev, 1);
> 
> +	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
>  	rtc->rtc_dev->ops = &mtk_rtc_ops;
> 
>  	ret = rtc_register_device(rtc->rtc_dev);
> @@ -302,15 +300,6 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  	return ret;
>  }
> 
> -static int mtk_rtc_remove(struct platform_device *pdev)
> -{
> -	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
> -
> -	free_irq(rtc->irq, rtc);
> -
> -	return 0;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int mt6397_rtc_suspend(struct device *dev)
>  {
> @@ -337,6 +326,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
>  			mt6397_rtc_resume);
> 
>  static const struct of_device_id mt6397_rtc_of_match[] = {
> +	{ .compatible = "mediatek,mt6323-rtc", },

Unrelated change, this is not an improvement and must be accompanied by
a documentation change.

>  	{ .compatible = "mediatek,mt6397-rtc", },
>  	{ }
>  };
> @@ -349,7 +339,6 @@ static struct platform_driver mtk_rtc_driver = {
>  		.pm = &mt6397_pm_ops,
>  	},
>  	.probe	= mtk_rtc_probe,
> -	.remove = mtk_rtc_remove,
>  };
> 
>  module_platform_driver(mtk_rtc_driver);
> --
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
