Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8584F81DD7
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfHENst (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 09:48:49 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51181 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfHENst (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 09:48:49 -0400
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7169F240015;
        Mon,  5 Aug 2019 13:48:43 +0000 (UTC)
Date:   Mon, 5 Aug 2019 15:48:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: [PATCH v3 03/10] rtc: mt6397: move some common definitions into
 rtc.h
Message-ID: <20190805134842.GG3600@piout.net>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-4-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729174154.4335-4-frank-w@public-files.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/07/2019 19:41:47+0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> move code to separate header-file to reuse definitions later
> in poweroff-driver (drivers/power/reset/mt6323-poweroff.c)
> 
> changes since v2: add missing commit-message

The changelog should be after the --- marker.
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
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
