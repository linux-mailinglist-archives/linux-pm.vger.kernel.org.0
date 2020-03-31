Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33FD198DEF
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 10:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgCaIGy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 04:06:54 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:63129 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCaIGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 04:06:54 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 4C28F24000A;
        Tue, 31 Mar 2020 08:06:48 +0000 (UTC)
Date:   Tue, 31 Mar 2020 10:06:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v11 4/5] rtc: mt6397: Add support for the MediaTek MT6358
 RTC
Message-ID: <20200331080648.GH846876@piout.net>
References: <1585627657-3265-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/03/2020 12:07:36+0800, Hsin-Hsiung Wang wrote:
> From: Ran Bi <ran.bi@mediatek.com>
> 
> This add support for the MediaTek MT6358 RTC. Driver using
> compatible data to store different RTC_WRTGR address offset.
> This replace RTC_WRTGR to RTC_WRTGR_MT6323 in mt6323-poweroff
> driver which only needed by armv7 CPU without ATF.
> 
> Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/power/reset/mt6323-poweroff.c |  2 +-
>  drivers/rtc/rtc-mt6397.c              | 23 +++++++++++++++++++----
>  include/linux/mfd/mt6397/rtc.h        |  9 ++++++++-
>  3 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
> index 1caf43d..0532803 100644
> --- a/drivers/power/reset/mt6323-poweroff.c
> +++ b/drivers/power/reset/mt6323-poweroff.c
> @@ -30,7 +30,7 @@ static void mt6323_do_pwroff(void)
>  	int ret;
>  
>  	regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
> -	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
> +	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR_MT6323, 1);
>  
>  	ret = regmap_read_poll_timeout(pwrc->regmap,
>  					pwrc->base + RTC_BBPU, val,
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index cda238d..7f3dfd2 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -9,6 +9,7 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
> @@ -20,7 +21,7 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  	int ret;
>  	u32 data;
>  
> -	ret = regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> +	ret = regmap_write(rtc->regmap, rtc->addr_base + rtc->data->wrtgr, 1);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -269,6 +270,8 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rtc->addr_base = res->start;
>  
> +	rtc->data = of_device_get_match_data(&pdev->dev);
> +
>  	rtc->irq = platform_get_irq(pdev, 0);
>  	if (rtc->irq < 0)
>  		return rtc->irq;
> @@ -325,10 +328,22 @@ static int mt6397_rtc_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
>  			mt6397_rtc_resume);
>  
> +static const struct mtk_rtc_data mt6358_rtc_data = {
> +	.wrtgr = RTC_WRTGR_MT6358,
> +};
> +
> +static const struct mtk_rtc_data mt6397_rtc_data = {
> +	.wrtgr = RTC_WRTGR_MT6397,
> +};
> +
>  static const struct of_device_id mt6397_rtc_of_match[] = {
> -	{ .compatible = "mediatek,mt6323-rtc", },
> -	{ .compatible = "mediatek,mt6397-rtc", },
> -	{ }
> +	{ .compatible = "mediatek,mt6323-rtc",
> +		.data = &mt6397_rtc_data, },
> +	{ .compatible = "mediatek,mt6358-rtc",
> +		.data = &mt6358_rtc_data, },
> +	{ .compatible = "mediatek,mt6397-rtc",
> +		.data = &mt6397_rtc_data, },

This is weirdly indented.

Else,
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
