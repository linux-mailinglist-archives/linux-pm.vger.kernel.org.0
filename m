Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249D5969B4
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 21:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfHTTsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 15:48:07 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:32845 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfHTTsH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 15:48:07 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id DE91D60004;
        Tue, 20 Aug 2019 19:48:03 +0000 (UTC)
Date:   Tue, 20 Aug 2019 21:48:03 +0200
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
Subject: Re: [PATCH v6 05/13] rtc: mt6397: move some common definitions into
 rtc.h
Message-ID: <20190820194803.GW3545@piout.net>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-6-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818135611.7776-6-frank-w@public-files.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/08/2019 15:56:03+0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> move code to separate header-file to reuse definitions later
> in poweroff-driver (drivers/power/reset/mt6323-poweroff.c)
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> changes since v5: none
> changes since v4: none
> changes since v3: none
> changes since v2: add missing commit-message
> ---
>  drivers/rtc/rtc-mt6397.c       | 55 +-------------------------
>  include/linux/mfd/mt6397/rtc.h | 71 ++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 54 deletions(-)
>  create mode 100644 include/linux/mfd/mt6397/rtc.h
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index b46ed4dc7015..c08ee5edf865 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -9,60 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
> -#include <linux/irqdomain.h>
> -#include <linux/platform_device.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
> -#include <linux/io.h>
> -#include <linux/mfd/mt6397/core.h>
> -
> -#define RTC_BBPU		0x0000
> -#define RTC_BBPU_CBUSY		BIT(6)
> -
> -#define RTC_WRTGR		0x003c
> -
> -#define RTC_IRQ_STA		0x0002
> -#define RTC_IRQ_STA_AL		BIT(0)
> -#define RTC_IRQ_STA_LP		BIT(3)
> -
> -#define RTC_IRQ_EN		0x0004
> -#define RTC_IRQ_EN_AL		BIT(0)
> -#define RTC_IRQ_EN_ONESHOT	BIT(2)
> -#define RTC_IRQ_EN_LP		BIT(3)
> -#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
> -
> -#define RTC_AL_MASK		0x0008
> -#define RTC_AL_MASK_DOW		BIT(4)
> -
> -#define RTC_TC_SEC		0x000a
> -/* Min, Hour, Dom... register offset to RTC_TC_SEC */
> -#define RTC_OFFSET_SEC		0
> -#define RTC_OFFSET_MIN		1
> -#define RTC_OFFSET_HOUR		2
> -#define RTC_OFFSET_DOM		3
> -#define RTC_OFFSET_DOW		4
> -#define RTC_OFFSET_MTH		5
> -#define RTC_OFFSET_YEAR		6
> -#define RTC_OFFSET_COUNT	7
> -
> -#define RTC_AL_SEC		0x0018
> -
> -#define RTC_PDN2		0x002e
> -#define RTC_PDN2_PWRON_ALARM	BIT(4)
> -
> -#define RTC_MIN_YEAR		1968
> -#define RTC_BASE_YEAR		1900
> -#define RTC_NUM_YEARS		128
> -#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
> -
> -struct mt6397_rtc {
> -	struct device		*dev;
> -	struct rtc_device	*rtc_dev;
> -	struct mutex		lock;
> -	struct regmap		*regmap;
> -	int			irq;
> -	u32			addr_base;
> -};
> +#include <linux/mfd/mt6397/rtc.h>
>  
>  static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  {
> diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
> new file mode 100644
> index 000000000000..b702c29e8c74
> --- /dev/null
> +++ b/include/linux/mfd/mt6397/rtc.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2014-2018 MediaTek Inc.
> + *
> + * Author: Tianping.Fang <tianping.fang@mediatek.com>
> + *        Sean Wang <sean.wang@mediatek.com>
> + */
> +
> +#ifndef _LINUX_MFD_MT6397_RTC_H_
> +#define _LINUX_MFD_MT6397_RTC_H_
> +
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +
> +#define RTC_BBPU               0x0000
> +#define RTC_BBPU_CBUSY         BIT(6)
> +#define RTC_BBPU_KEY            (0x43 << 8)
> +
> +#define RTC_WRTGR              0x003c
> +
> +#define RTC_IRQ_STA            0x0002
> +#define RTC_IRQ_STA_AL         BIT(0)
> +#define RTC_IRQ_STA_LP         BIT(3)
> +
> +#define RTC_IRQ_EN             0x0004
> +#define RTC_IRQ_EN_AL          BIT(0)
> +#define RTC_IRQ_EN_ONESHOT     BIT(2)
> +#define RTC_IRQ_EN_LP          BIT(3)
> +#define RTC_IRQ_EN_ONESHOT_AL  (RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
> +
> +#define RTC_AL_MASK            0x0008
> +#define RTC_AL_MASK_DOW                BIT(4)
> +
> +#define RTC_TC_SEC             0x000a
> +/* Min, Hour, Dom... register offset to RTC_TC_SEC */
> +#define RTC_OFFSET_SEC         0
> +#define RTC_OFFSET_MIN         1
> +#define RTC_OFFSET_HOUR                2
> +#define RTC_OFFSET_DOM         3
> +#define RTC_OFFSET_DOW         4
> +#define RTC_OFFSET_MTH         5
> +#define RTC_OFFSET_YEAR                6
> +#define RTC_OFFSET_COUNT       7
> +
> +#define RTC_AL_SEC             0x0018
> +
> +#define RTC_PDN2               0x002e
> +#define RTC_PDN2_PWRON_ALARM   BIT(4)
> +
> +#define RTC_MIN_YEAR           1968
> +#define RTC_BASE_YEAR          1900
> +#define RTC_NUM_YEARS          128
> +#define RTC_MIN_YEAR_OFFSET    (RTC_MIN_YEAR - RTC_BASE_YEAR)
> +
> +#define MTK_RTC_POLL_DELAY_US  10
> +#define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
> +
> +struct mt6397_rtc {
> +	struct device           *dev;
> +	struct rtc_device       *rtc_dev;
> +
> +	/* Protect register access from multiple tasks */
> +	struct mutex            lock;
> +	struct regmap           *regmap;
> +	int                     irq;
> +	u32                     addr_base;
> +};
> +
> +#endif /* _LINUX_MFD_MT6397_RTC_H_ */
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
