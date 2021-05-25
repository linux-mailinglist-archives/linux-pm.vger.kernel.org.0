Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB73438FFBC
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhEYLI7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhEYLI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 07:08:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C900C061574;
        Tue, 25 May 2021 04:07:28 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z3so29882531oib.5;
        Tue, 25 May 2021 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJPrkhVEd18V073l/3CR0WNK0yMJIf5wbnLrpg5VWAU=;
        b=fJUvcZvPSIPIdKHd4EnQLdTE2E7mVlMb35WHJaS8TZXTmQXh+L0paIKAkpJF0NDaGx
         HOOd7NJd/N13z3P2WJNzx+DFv9bYnHM1PTdyWIM37Cgbc0drBLlX58BuAtMBhH1n5kv2
         ciGVO3TgeoePDct4xtVjmQD/XZRUIcDHkJpYf3fVb6AeJ87HYie0EevkNQblzIFdgFwr
         ++pe/ZqMBznKzvS3oC3+xyVUeMhkjwL6kQ1jRQpkHbUnnTphPwVIvgmFnUfRI2ZpE/pX
         9sdp6SlscLFyunzqg2Cs57r8eBedTY6Wumjr3yvEshAIXJApyATLObHgnxYGwdPgWIPT
         ktgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJPrkhVEd18V073l/3CR0WNK0yMJIf5wbnLrpg5VWAU=;
        b=rUZK7Z1DhcCrO/5/KgIA1vOwJCIR6wOSVmHjONZoVwqqGoym8Am+VC/yPVUX0GSng4
         zgqezdY6a+RSOvPpEDdIXbfErWx3YBSk+S51XewNltgMbvS4Os+OJjY8NZxqUHX2RQjI
         XrLb7r3fc/U1mXl+nZvcYg4yKKmHzEqwO8XWH12VKAQAo5wCQIJ8yfnw+Hipd9xb37B7
         qYm1biEAe9rUUNzf2opFgScaN84gm8guuwYVA15VggFBwnLIcv3tZiUclc8pZgu90IqB
         9fbpkbOT9y7vc+gCugKtJAZZB4Fda1pYh2kHukHwCWZwGlNrv7xqe3bbf4xAVJR7hYIO
         NdEw==
X-Gm-Message-State: AOAM531IHlkfcsV+xzB/i3c285kwA8vEu+W5gW22OsktrGuhutqzR+jd
        zUvPi/BA1Ff1KcyEpcIb1MlSPm6SMLA=
X-Google-Smtp-Source: ABdhPJwtDlKwkY13mhCB+bTksAKK6uog4x92QJ/ol6r6jpIPOGHCWy48oUBWQllRCfTnvfw+RIwLrA==
X-Received: by 2002:a05:6808:10d4:: with SMTP id s20mr14021602ois.70.1621940847265;
        Tue, 25 May 2021 04:07:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f21sm3403341oou.24.2021.05.25.04.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 04:07:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/9] watchdog: bd70528 drop bd70528 support
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-power@fi.rohmeurope.com,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
 <994d2e374262c3f59f4465c03ef23d3116120778.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa9b4b9f-4a2d-d95a-eaa6-89aa153d0cbb@roeck-us.net>
Date:   Tue, 25 May 2021 04:07:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <994d2e374262c3f59f4465c03ef23d3116120778.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/25/21 3:14 AM, Matti Vaittinen wrote:
> The only known BD70528 use-cases are such that the PMIC is controlled
> from separate MCU which is not running Linux. I am not aware of
> any Linux driver users. Furthermore, it seems there is no demand for
> this IC. Let's ease the maintenance burden and drop the driver. We can
> always add it back if there is sudden need for it.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Please let me know if some of you think the driver is needed.
> ---
>   drivers/watchdog/Kconfig       |  12 --
>   drivers/watchdog/Makefile      |   1 -
>   drivers/watchdog/bd70528_wdt.c | 291 ---------------------------------
>   3 files changed, 304 deletions(-)
>   delete mode 100644 drivers/watchdog/bd70528_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 355100dad60a..26824ac6c5bc 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -160,18 +160,6 @@ config SOFT_WATCHDOG_PRETIMEOUT
>   	  watchdog. Be aware that governors might affect the watchdog because it
>   	  is purely software, e.g. the panic governor will stall it!
>   
> -config BD70528_WATCHDOG
> -	tristate "ROHM BD70528 PMIC Watchdog"
> -	depends on MFD_ROHM_BD70528
> -	select WATCHDOG_CORE
> -	help
> -	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
> -	  cause system reset.
> -
> -	  Say Y here to include support for the ROHM BD70528 watchdog.
> -	  Alternatively say M to compile the driver as a module,
> -	  which will be called bd70528_wdt.
> -
>   config BD957XMUF_WATCHDOG
>   	tristate "ROHM BD9576MUF and BD9573MUF PMIC Watchdog"
>   	depends on MFD_ROHM_BD957XMUF
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a7eade8b4d45..1838df3ed650 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -203,7 +203,6 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
>   obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>   
>   # Architecture Independent
> -obj-$(CONFIG_BD70528_WATCHDOG) += bd70528_wdt.o
>   obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
>   obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>   obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
> deleted file mode 100644
> index 0170b37e6674..000000000000
> --- a/drivers/watchdog/bd70528_wdt.c
> +++ /dev/null
> @@ -1,291 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (C) 2018 ROHM Semiconductors
> -// ROHM BD70528MWV watchdog driver
> -
> -#include <linux/bcd.h>
> -#include <linux/kernel.h>
> -#include <linux/mfd/rohm-bd70528.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/platform_device.h>
> -#include <linux/regmap.h>
> -#include <linux/watchdog.h>
> -
> -/*
> - * Max time we can set is 1 hour, 59 minutes and 59 seconds
> - * and Minimum time is 1 second
> - */
> -#define WDT_MAX_MS	((2 * 60 * 60 - 1) * 1000)
> -#define WDT_MIN_MS	1000
> -#define DEFAULT_TIMEOUT	60
> -
> -#define WD_CTRL_MAGIC1 0x55
> -#define WD_CTRL_MAGIC2 0xAA
> -
> -struct wdtbd70528 {
> -	struct device *dev;
> -	struct regmap *regmap;
> -	struct rohm_regmap_dev *mfd;
> -	struct watchdog_device wdt;
> -};
> -
> -/**
> - * bd70528_wdt_set - arm or disarm watchdog timer
> - *
> - * @data:	device data for the PMIC instance we want to operate on
> - * @enable:	new state of WDT. zero to disable, non zero to enable
> - * @old_state:	previous state of WDT will be filled here
> - *
> - * Arm or disarm WDT on BD70528 PMIC. Expected to be called only by
> - * BD70528 RTC and BD70528 WDT drivers. The rtc_timer_lock must be taken
> - * by calling bd70528_wdt_lock before calling bd70528_wdt_set.
> - */
> -int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_state)
> -{
> -	int ret, i;
> -	unsigned int tmp;
> -	struct bd70528_data *bd70528 = container_of(data, struct bd70528_data,
> -						 chip);
> -	u8 wd_ctrl_arr[3] = { WD_CTRL_MAGIC1, WD_CTRL_MAGIC2, 0 };
> -	u8 *wd_ctrl = &wd_ctrl_arr[2];
> -
> -	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &tmp);
> -	if (ret)
> -		return ret;
> -
> -	*wd_ctrl = (u8)tmp;
> -
> -	if (old_state) {
> -		if (*wd_ctrl & BD70528_MASK_WDT_EN)
> -			*old_state |= BD70528_WDT_STATE_BIT;
> -		else
> -			*old_state &= ~BD70528_WDT_STATE_BIT;
> -		if ((!enable) == (!(*old_state & BD70528_WDT_STATE_BIT)))
> -			return 0;
> -	}
> -
> -	if (enable) {
> -		if (*wd_ctrl & BD70528_MASK_WDT_EN)
> -			return 0;
> -		*wd_ctrl |= BD70528_MASK_WDT_EN;
> -	} else {
> -		if (*wd_ctrl & BD70528_MASK_WDT_EN)
> -			*wd_ctrl &= ~BD70528_MASK_WDT_EN;
> -		else
> -			return 0;
> -	}
> -
> -	for (i = 0; i < 3; i++) {
> -		ret = regmap_write(bd70528->chip.regmap, BD70528_REG_WDT_CTRL,
> -				   wd_ctrl_arr[i]);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &tmp);
> -	if ((tmp & BD70528_MASK_WDT_EN) != (*wd_ctrl & BD70528_MASK_WDT_EN)) {
> -		dev_err(bd70528->chip.dev,
> -			"Watchdog ctrl mismatch (hw) 0x%x (set) 0x%x\n",
> -			tmp, *wd_ctrl);
> -		ret = -EIO;
> -	}
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL(bd70528_wdt_set);
> -
> -/**
> - * bd70528_wdt_lock - take WDT lock
> - *
> - * @data:	device data for the PMIC instance we want to operate on
> - *
> - * Lock WDT for arming/disarming in order to avoid race condition caused
> - * by WDT state changes initiated by WDT and RTC drivers.
> - */
> -void bd70528_wdt_lock(struct rohm_regmap_dev *data)
> -{
> -	struct bd70528_data *bd70528 = container_of(data, struct bd70528_data,
> -						 chip);
> -
> -	mutex_lock(&bd70528->rtc_timer_lock);
> -}
> -EXPORT_SYMBOL(bd70528_wdt_lock);
> -
> -/**
> - * bd70528_wdt_unlock - unlock WDT lock
> - *
> - * @data:	device data for the PMIC instance we want to operate on
> - *
> - * Unlock WDT lock which has previously been taken by call to
> - * bd70528_wdt_lock.
> - */
> -void bd70528_wdt_unlock(struct rohm_regmap_dev *data)
> -{
> -	struct bd70528_data *bd70528 = container_of(data, struct bd70528_data,
> -						 chip);
> -
> -	mutex_unlock(&bd70528->rtc_timer_lock);
> -}
> -EXPORT_SYMBOL(bd70528_wdt_unlock);
> -
> -static int bd70528_wdt_set_locked(struct wdtbd70528 *w, int enable)
> -{
> -	return bd70528_wdt_set(w->mfd, enable, NULL);
> -}
> -
> -static int bd70528_wdt_change(struct wdtbd70528 *w, int enable)
> -{
> -	int ret;
> -
> -	bd70528_wdt_lock(w->mfd);
> -	ret = bd70528_wdt_set_locked(w, enable);
> -	bd70528_wdt_unlock(w->mfd);
> -
> -	return ret;
> -}
> -
> -static int bd70528_wdt_start(struct watchdog_device *wdt)
> -{
> -	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> -
> -	dev_dbg(w->dev, "WDT ping...\n");
> -	return bd70528_wdt_change(w, 1);
> -}
> -
> -static int bd70528_wdt_stop(struct watchdog_device *wdt)
> -{
> -	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> -
> -	dev_dbg(w->dev, "WDT stopping...\n");
> -	return bd70528_wdt_change(w, 0);
> -}
> -
> -static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
> -				   unsigned int timeout)
> -{
> -	unsigned int hours;
> -	unsigned int minutes;
> -	unsigned int seconds;
> -	int ret;
> -	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> -
> -	seconds = timeout;
> -	hours = timeout / (60 * 60);
> -	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
> -	if (hours)
> -		seconds -= (60 * 60);
> -	minutes = seconds / 60;
> -	seconds = seconds % 60;
> -
> -	bd70528_wdt_lock(w->mfd);
> -
> -	ret = bd70528_wdt_set_locked(w, 0);
> -	if (ret)
> -		goto out_unlock;
> -
> -	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_HOUR,
> -				 BD70528_MASK_WDT_HOUR, hours);
> -	if (ret) {
> -		dev_err(w->dev, "Failed to set WDT hours\n");
> -		goto out_en_unlock;
> -	}
> -	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_MINUTE,
> -				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
> -	if (ret) {
> -		dev_err(w->dev, "Failed to set WDT minutes\n");
> -		goto out_en_unlock;
> -	}
> -	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_SEC,
> -				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
> -	if (ret)
> -		dev_err(w->dev, "Failed to set WDT seconds\n");
> -	else
> -		dev_dbg(w->dev, "WDT tmo set to %u\n", timeout);
> -
> -out_en_unlock:
> -	ret = bd70528_wdt_set_locked(w, 1);
> -out_unlock:
> -	bd70528_wdt_unlock(w->mfd);
> -
> -	return ret;
> -}
> -
> -static const struct watchdog_info bd70528_wdt_info = {
> -	.identity = "bd70528-wdt",
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> -};
> -
> -static const struct watchdog_ops bd70528_wdt_ops = {
> -	.start		= bd70528_wdt_start,
> -	.stop		= bd70528_wdt_stop,
> -	.set_timeout	= bd70528_wdt_set_timeout,
> -};
> -
> -static int bd70528_wdt_probe(struct platform_device *pdev)
> -{
> -	struct rohm_regmap_dev *bd70528;
> -	struct wdtbd70528 *w;
> -	int ret;
> -	unsigned int reg;
> -
> -	bd70528 = dev_get_drvdata(pdev->dev.parent);
> -	if (!bd70528) {
> -		dev_err(&pdev->dev, "No MFD driver data\n");
> -		return -EINVAL;
> -	}
> -	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
> -	if (!w)
> -		return -ENOMEM;
> -
> -	w->regmap = bd70528->regmap;
> -	w->mfd = bd70528;
> -	w->dev = &pdev->dev;
> -
> -	w->wdt.info = &bd70528_wdt_info;
> -	w->wdt.ops =  &bd70528_wdt_ops;
> -	w->wdt.min_hw_heartbeat_ms = WDT_MIN_MS;
> -	w->wdt.max_hw_heartbeat_ms = WDT_MAX_MS;
> -	w->wdt.parent = pdev->dev.parent;
> -	w->wdt.timeout = DEFAULT_TIMEOUT;
> -	watchdog_set_drvdata(&w->wdt, w);
> -	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
> -
> -	ret = bd70528_wdt_set_timeout(&w->wdt, w->wdt.timeout);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
> -		return ret;
> -	}
> -
> -	bd70528_wdt_lock(w->mfd);
> -	ret = regmap_read(w->regmap, BD70528_REG_WDT_CTRL, &reg);
> -	bd70528_wdt_unlock(w->mfd);
> -
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to get the watchdog state\n");
> -		return ret;
> -	}
> -	if (reg & BD70528_MASK_WDT_EN) {
> -		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
> -		set_bit(WDOG_HW_RUNNING, &w->wdt.status);
> -	}
> -
> -	ret = devm_watchdog_register_device(&pdev->dev, &w->wdt);
> -	if (ret < 0)
> -		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static struct platform_driver bd70528_wdt = {
> -	.driver = {
> -		.name = "bd70528-wdt"
> -	},
> -	.probe = bd70528_wdt_probe,
> -};
> -
> -module_platform_driver(bd70528_wdt);
> -
> -MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> -MODULE_DESCRIPTION("BD70528 watchdog driver");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:bd70528-wdt");
> 

