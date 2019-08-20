Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E153969C4
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 21:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfHTTuC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 15:50:02 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46073 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTTuC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 15:50:02 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 51CF160004;
        Tue, 20 Aug 2019 19:49:59 +0000 (UTC)
Date:   Tue, 20 Aug 2019 21:49:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>, Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v6 07/13] rtc: mt6397: improvements of rtc driver
Message-ID: <20190820194959.GY3545@piout.net>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-8-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818135611.7776-8-frank-w@public-files.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/08/2019 15:56:05+0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> - use regmap_read_poll_timeout to drop while-loop
> - use devm-api to drop remove-callback
> 
> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> changes since v5: none
> changes since v4: none
> changes since v3: none
> changes since v2:
> - fix allocation after irq-request
> - compatible for mt6323 in separate commit => part 5
> ---
>  drivers/rtc/rtc-mt6397.c | 51 +++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index c08ee5edf865..9370b7fc9f81 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -4,16 +4,19 @@
>  * Author: Tianping.Fang <tianping.fang@mediatek.com>
>  */
>  
> -#include <linux/delay.h>
> -#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/mt6397/core.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
>  #include <linux/mfd/mt6397/rtc.h>
> +#include <linux/mod_devicetable.h>
>  
>  static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  {
> -	unsigned long timeout = jiffies + HZ;
>  	int ret;
>  	u32 data;
>  
> @@ -21,19 +24,13 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  	if (ret < 0)
>  		return ret;
>  
> -	while (1) {
> -		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
> -				  &data);
> -		if (ret < 0)
> -			break;
> -		if (!(data & RTC_BBPU_CBUSY))
> -			break;
> -		if (time_after(jiffies, timeout)) {
> -			ret = -ETIMEDOUT;
> -			break;
> -		}
> -		cpu_relax();
> -	}
> +	ret = regmap_read_poll_timeout(rtc->regmap,
> +					rtc->addr_base + RTC_BBPU, data,
> +					!(data & RTC_BBPU_CBUSY),
> +					MTK_RTC_POLL_DELAY_US,
> +					MTK_RTC_POLL_TIMEOUT);
> +	if (ret < 0)
> +		dev_err(rtc->dev, "failed to write WRTGE: %d\n", ret);
>  
>  	return ret;
>  }
> @@ -266,19 +263,19 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  		return rtc->irq;
>  
>  	rtc->regmap = mt6397_chip->regmap;
> -	rtc->dev = &pdev->dev;
>  	mutex_init(&rtc->lock);
>  
>  	platform_set_drvdata(pdev, rtc);
>  
> -	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
> +	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
>  	if (IS_ERR(rtc->rtc_dev))
>  		return PTR_ERR(rtc->rtc_dev);
>  
> -	ret = request_threaded_irq(rtc->irq, NULL,
> -				   mtk_rtc_irq_handler_thread,
> -				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> -				   "mt6397-rtc", rtc);
> +	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> +					mtk_rtc_irq_handler_thread,
> +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> +					"mt6397-rtc", rtc);
> +
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
>  			rtc->irq, ret);
> @@ -302,15 +299,6 @@ static int mtk_rtc_probe(struct platform_device *pdev)
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
> @@ -349,7 +337,6 @@ static struct platform_driver mtk_rtc_driver = {
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
