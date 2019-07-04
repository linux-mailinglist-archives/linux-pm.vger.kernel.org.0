Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56A15F640
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGDKDg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 06:03:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10679 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727385AbfGDKDc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 06:03:32 -0400
X-UUID: e1d4251ec8204cbf9f1ee152e63b0ed9-20190704
X-UUID: e1d4251ec8204cbf9f1ee152e63b0ed9-20190704
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ran.bi@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 924325187; Thu, 04 Jul 2019 18:03:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 4 Jul
 2019 18:03:12 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 4 Jul 2019 18:03:09 +0800
Message-ID: <1562234589.19751.16.camel@mhfsdcap03>
Subject: Re: [PATCH v2 5/7] power: reset: add driver for mt6323 poweroff
From:   Ran Bi <ran.bi@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ran Bi <ran.bi@mediatek.com>
Date:   Thu, 4 Jul 2019 18:03:09 +0800
In-Reply-To: <20190703164822.17924-6-frank-w@public-files.de>
References: <20190703164822.17924-1-frank-w@public-files.de>
         <20190703164822.17924-6-frank-w@public-files.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 5DE4835C1875B5950092AA7126EE354752A756CA69AC4641991F64CEFDA4E85A2000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-07-03 at 18:48 +0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/power/reset/Kconfig           | 10 +++
>  drivers/power/reset/Makefile          |  1 +
>  drivers/power/reset/mt6323-poweroff.c | 97 +++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h       |  2 +
>  4 files changed, 110 insertions(+)
>  create mode 100644 drivers/power/reset/mt6323-poweroff.c
> 
> --
> 2.17.1
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 980951dff834..492678e22088 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -140,6 +140,16 @@ config POWER_RESET_LTC2952
>  	  This driver supports an external powerdown trigger and board power
>  	  down via the LTC2952. Bindings are made in the device tree.
> 
> +config POWER_RESET_MT6323
> +       bool "MediaTek MT6323 power-off driver"
> +       depends on MFD_MT6397
> +       help
> +         The power-off driver is responsible for externally shutdown down
> +         the power of a remote MediaTek SoC MT6323 is connected to through
> +         controlling a tiny circuit BBPU inside MT6323 RTC.
> +
> +         Say Y if you have a board where MT6323 could be found.
> +
>  config POWER_RESET_QNAP
>  	bool "QNAP power-off driver"
>  	depends on OF_GPIO && PLAT_ORION
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 0aebee954ac1..94eaceb01d66 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QCOM_PON) += qcom-pon.o
>  obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
> diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
> new file mode 100644
> index 000000000000..1caf43d9e46d
> --- /dev/null
> +++ b/drivers/power/reset/mt6323-poweroff.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Power off through MediaTek PMIC
> + *
> + * Copyright (C) 2018 MediaTek Inc.
> + *
> + * Author: Sean Wang <sean.wang@mediatek.com>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6397/rtc.h>
> +
> +struct mt6323_pwrc {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	u32 base;
> +};
> +
> +static struct mt6323_pwrc *mt_pwrc;
> +
> +static void mt6323_do_pwroff(void)
> +{
> +	struct mt6323_pwrc *pwrc = mt_pwrc;
> +	unsigned int val;
> +	int ret;
> +
> +	regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
> +	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
> +
> +	ret = regmap_read_poll_timeout(pwrc->regmap,
> +					pwrc->base + RTC_BBPU, val,
> +					!(val & RTC_BBPU_CBUSY),
> +					MTK_RTC_POLL_DELAY_US,
> +					MTK_RTC_POLL_TIMEOUT);
> +	if (ret)
> +		dev_err(pwrc->dev, "failed to write BBPU: %d\n", ret);
> +
> +	/* Wait some time until system down, otherwise, notice with a warn */
> +	mdelay(1000);
> +
> +	WARN_ONCE(1, "Unable to power off system\n");
> +}
> +
> +static int mt6323_pwrc_probe(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
> +	struct mt6323_pwrc *pwrc;
> +	struct resource *res;
> +
> +	pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
> +	if (!pwrc)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwrc->base = res->start;
> +	pwrc->regmap = mt6397_chip->regmap;
> +	pwrc->dev = &pdev->dev;
> +	mt_pwrc = pwrc;
> +
> +	pm_power_off = &mt6323_do_pwroff;

We had implement MT8173 poweroff function in arm-trusted-firmware's PSCI
plat_system_off() function. MT8173 SoC is using PMIC MT6397. (Ref:
https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8173/plat_pm.c and https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8173/drivers/rtc) Do you think it's better to implement poweroff function into arm-trusted-firmware compared to hijack pm_poweroff() function in Kernel? Right now, we are doing the upstream of other PMIC chip like MT6358's poweroff function in arm-trusted-firmware too.

> +
> +	return 0;
> +}
> +
> +static int mt6323_pwrc_remove(struct platform_device *pdev)
> +{
> +	if (pm_power_off == &mt6323_do_pwroff)
> +		pm_power_off = NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mt6323_pwrc_dt_match[] = {
> +	{ .compatible = "mediatek,mt6323-pwrc" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);
> +
> +static struct platform_driver mt6323_pwrc_driver = {
> +	.probe          = mt6323_pwrc_probe,
> +	.remove         = mt6323_pwrc_remove,
> +	.driver         = {
> +		.name   = "mt6323-pwrc",
> +		.of_match_table = mt6323_pwrc_dt_match,
> +	},
> +};
> +
> +module_platform_driver(mt6323_pwrc_driver);
> +
> +MODULE_DESCRIPTION("Poweroff driver for MT6323 PMIC");
> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
> index 25a95e72179b..652da61e3711 100644
> --- a/include/linux/mfd/mt6397/core.h
> +++ b/include/linux/mfd/mt6397/core.h
> @@ -7,6 +7,8 @@
>  #ifndef __MFD_MT6397_CORE_H__
>  #define __MFD_MT6397_CORE_H__
> 
> +#include <linux/mutex.h>
> +
>  enum mt6397_irq_numbers {
>  	MT6397_IRQ_SPKL_AB = 0,


