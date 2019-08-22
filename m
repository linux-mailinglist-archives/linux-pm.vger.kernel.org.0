Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D7C98B47
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 08:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfHVGQK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 02:16:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33267 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfHVGQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 02:16:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id p77so6317284wme.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v/3dZSfOdl8S6ZuVsDc0xr8vSJO5wrI3ARNo9NhdoHg=;
        b=dkfEZLhxXG3d1ubAYcYq8AtogXAIdF338g3nRefUV6YxYpPNtII9vo/q6a4qfju9w+
         WhqpuyDe3y0oOpFdrZ/9G8u6coQeL45ErcVJmtuNZbiFUQ/yAaIsLOWZkKKr2GmcW+xH
         0h39wbwkY4CAzaQooIiLxvpzlXzsL20nVbEKzmVUUpy0tH0KYP3oEkDoURZPSzMzNORO
         9WyV2EPR6wNnNuMo7GllUyDscThT1Tb7HZeaQlqdnNPrNCU2Ub6lVMQn041MBcva4P5e
         ZfM1Lr30xbY3dOYL8C/dnzuVKXbUvBIhaQ71mRJojX0Ffx1uioWaSNNLPoZ4xmGE3jxO
         Jn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v/3dZSfOdl8S6ZuVsDc0xr8vSJO5wrI3ARNo9NhdoHg=;
        b=D16QEDv8wczMWvfY6RoqpcXxYwgE9206oL1lIzqL28RhPVFr4bn7Gj8bc8QE/+KLY8
         QA4Q6rMexQxlfxNYTsodICILYiHSKIUYMhem9Xitv4FG5DENStmGf0EtF0/L9IsMIkcz
         pFk1Q2ZJrHciBbKkDE8Bn5q/mwG9YpI9yXvSM18EcC7IRuaM29cWKoVQ44d4T/uZyEnL
         AoNhFKfzn/DWjrzoNG87LbKqQGT0flZc1VD2WLOSQz6egLkTDLv1n5Y4daMtW1yA7OPJ
         ip4Q/dYanEIzs4ByMZwZCTwn3Jdbrp6d+v0iHV8wVO6FOP5uiLR9zsKjrajNzSwqDqOv
         sHrA==
X-Gm-Message-State: APjAAAVAp/RJRXnrowAe+7TlLFoRu5Jt72WwGakzoKUO5c2gZ47JNwHX
        zIrDbRsHHkFVuR8U8WGtYMuk3w==
X-Google-Smtp-Source: APXvYqwxfairnPt8SpfzkQ/D2+XtXx0VQWPZqBg8DRtt4/Gs1XrSDV89wTEK4hLKPPX28GUWHhjf1Q==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr4208570wme.3.1566454565427;
        Wed, 21 Aug 2019 23:16:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:7130:374d:99e8:92fa? ([2a01:e34:ed2f:f020:7130:374d:99e8:92fa])
        by smtp.googlemail.com with ESMTPSA id c1sm1801267wmc.40.2019.08.21.23.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 23:16:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Linus Walleij <linus.walleij@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
References: <20190717063222.5902-1-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <47cb523f-60ad-750e-4374-6563f8230593@linaro.org>
Date:   Thu, 22 Aug 2019 08:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717063222.5902-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/07/2019 08:32, Linus Walleij wrote:
> At some point there was an attempt to convert the DB8500
> thermal sensor to device tree: a probe path was added
> and the device tree was augmented for the Snowball board.
> The switchover was never completed: instead the thermal
> devices came from from the PRCMU MFD device and the probe
> on the Snowball was confused as another set of configuration
> appeared from the device tree.
> 
> Move over to a device-tree only approach, as we fixed up
> the device trees.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Lee: it'd be great if you could ACK this, it is a file
> with low change rate so we should likely not see any
> collisions.
> ---
>  drivers/mfd/db8500-prcmu.c                   | 53 +-------------------
>  drivers/thermal/Kconfig                      |  2 +-
>  drivers/thermal/db8500_thermal.c             | 30 +++++------
>  include/linux/platform_data/db8500_thermal.h | 29 -----------
>  4 files changed, 17 insertions(+), 97 deletions(-)
>  delete mode 100644 include/linux/platform_data/db8500_thermal.h
> 
> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 3f21e26b8d36..a1e09bf06977 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -36,7 +36,6 @@
>  #include <linux/regulator/db8500-prcmu.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/platform_data/ux500_wdt.h>
> -#include <linux/platform_data/db8500_thermal.h>
>  #include "dbx500-prcmu-regs.h"
>  
>  /* Index of different voltages to be used when accessing AVSData */
> @@ -2982,53 +2981,6 @@ static struct ux500_wdt_data db8500_wdt_pdata = {
>  	.timeout = 600, /* 10 minutes */
>  	.has_28_bits_resolution = true,
>  };
> -/*
> - * Thermal Sensor
> - */
> -
> -static struct resource db8500_thsens_resources[] = {
> -	{
> -		.name = "IRQ_HOTMON_LOW",
> -		.start  = IRQ_PRCMU_HOTMON_LOW,
> -		.end    = IRQ_PRCMU_HOTMON_LOW,
> -		.flags  = IORESOURCE_IRQ,
> -	},
> -	{
> -		.name = "IRQ_HOTMON_HIGH",
> -		.start  = IRQ_PRCMU_HOTMON_HIGH,
> -		.end    = IRQ_PRCMU_HOTMON_HIGH,
> -		.flags  = IORESOURCE_IRQ,
> -	},
> -};
> -
> -static struct db8500_thsens_platform_data db8500_thsens_data = {
> -	.trip_points[0] = {
> -		.temp = 70000,
> -		.type = THERMAL_TRIP_ACTIVE,
> -		.cdev_name = {
> -			[0] = "thermal-cpufreq-0",
> -		},
> -	},
> -	.trip_points[1] = {
> -		.temp = 75000,
> -		.type = THERMAL_TRIP_ACTIVE,
> -		.cdev_name = {
> -			[0] = "thermal-cpufreq-0",
> -		},
> -	},
> -	.trip_points[2] = {
> -		.temp = 80000,
> -		.type = THERMAL_TRIP_ACTIVE,
> -		.cdev_name = {
> -			[0] = "thermal-cpufreq-0",
> -		},
> -	},
> -	.trip_points[3] = {
> -		.temp = 85000,
> -		.type = THERMAL_TRIP_CRITICAL,
> -	},
> -	.num_trips = 4,
> -};

I've been through the DT and I don't understand why there is:

	[ ... ]
        trip0-temp = <70000>;
        trip0-type = "active";
        trip0-cdev-num = <1>;
        trip0-cdev-name0 = "thermal-cpufreq-0";
	[ ... ]

Those bindings already exists for the thermal no?

Why not create a thermal-zone node and then add the values above?

Another point is there are too many trip points, two should be enough,
one for throttling and one for critical, the governor will handle that
properly by stepping the opps.

And one last point is the trip point should be passive, not active.


>  static const struct mfd_cell common_prcmu_devs[] = {
>  	{
> @@ -3052,10 +3004,7 @@ static const struct mfd_cell db8500_prcmu_devs[] = {
>  	},
>  	{
>  		.name = "db8500-thermal",
> -		.num_resources = ARRAY_SIZE(db8500_thsens_resources),
> -		.resources = db8500_thsens_resources,
> -		.platform_data = &db8500_thsens_data,
> -		.pdata_size = sizeof(db8500_thsens_data),
> +		.of_compatible = "stericsson,db8500-thermal",
>  	},
>  };
>  
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 9966364a6deb..001a21abcc28 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -310,7 +310,7 @@ config DOVE_THERMAL
>  
>  config DB8500_THERMAL
>  	tristate "DB8500 thermal management"
> -	depends on MFD_DB8500_PRCMU
> +	depends on MFD_DB8500_PRCMU && OF
>  	default y
>  	help
>  	  Adds DB8500 thermal management implementation according to the thermal
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index b71a999d17d6..d650ae5fdf2a 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -13,13 +13,24 @@
>  #include <linux/mfd/dbx500-prcmu.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/platform_data/db8500_thermal.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  
>  #define PRCMU_DEFAULT_MEASURE_TIME	0xFFF
>  #define PRCMU_DEFAULT_LOW_TEMP		0
> +#define COOLING_DEV_MAX 8
> +
> +struct db8500_trip_point {
> +	unsigned long temp;
> +	enum thermal_trip_type type;
> +	char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH];
> +};
> +
> +struct db8500_thsens_platform_data {
> +	struct db8500_trip_point trip_points[THERMAL_MAX_TRIPS];
> +	int num_trips;
> +};
>  
>  struct db8500_thermal_zone {
>  	struct thermal_zone_device *therm_dev;
> @@ -301,7 +312,6 @@ static void db8500_thermal_work(struct work_struct *work)
>  	dev_dbg(&pzone->therm_dev->device, "thermal work finished.\n");
>  }
>  
> -#ifdef CONFIG_OF
>  static struct db8500_thsens_platform_data*
>  		db8500_thermal_parse_dt(struct platform_device *pdev)
>  {
> @@ -370,13 +380,6 @@ static struct db8500_thsens_platform_data*
>  	dev_err(&pdev->dev, "Parsing device tree data error.\n");
>  	return NULL;
>  }
> -#else
> -static inline struct db8500_thsens_platform_data*
> -		db8500_thermal_parse_dt(struct platform_device *pdev)
> -{
> -	return NULL;
> -}
> -#endif
>  
>  static int db8500_thermal_probe(struct platform_device *pdev)
>  {
> @@ -386,11 +389,10 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>  	int low_irq, high_irq, ret = 0;
>  	unsigned long dft_low, dft_high;
>  
> -	if (np)
> -		ptrips = db8500_thermal_parse_dt(pdev);
> -	else
> -		ptrips = dev_get_platdata(&pdev->dev);
> +	if (!np)
> +		return -EINVAL;
>  
> +	ptrips = db8500_thermal_parse_dt(pdev);
>  	if (!ptrips)
>  		return -EINVAL;
>  
> @@ -498,13 +500,11 @@ static int db8500_thermal_resume(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id db8500_thermal_match[] = {
>  	{ .compatible = "stericsson,db8500-thermal" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, db8500_thermal_match);
> -#endif
>  
>  static struct platform_driver db8500_thermal_driver = {
>  	.driver = {
> diff --git a/include/linux/platform_data/db8500_thermal.h b/include/linux/platform_data/db8500_thermal.h
> deleted file mode 100644
> index 55e55750a165..000000000000
> --- a/include/linux/platform_data/db8500_thermal.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * db8500_thermal.h - DB8500 Thermal Management Implementation
> - *
> - * Copyright (C) 2012 ST-Ericsson
> - * Copyright (C) 2012 Linaro Ltd.
> - *
> - * Author: Hongbo Zhang <hongbo.zhang@linaro.com>
> - */
> -
> -#ifndef _DB8500_THERMAL_H_
> -#define _DB8500_THERMAL_H_
> -
> -#include <linux/thermal.h>
> -
> -#define COOLING_DEV_MAX 8
> -
> -struct db8500_trip_point {
> -	unsigned long temp;
> -	enum thermal_trip_type type;
> -	char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH];
> -};
> -
> -struct db8500_thsens_platform_data {
> -	struct db8500_trip_point trip_points[THERMAL_MAX_TRIPS];
> -	int num_trips;
> -};
> -
> -#endif /* _DB8500_THERMAL_H_ */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

