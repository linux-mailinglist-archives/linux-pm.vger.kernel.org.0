Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A85D33E1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJJWUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 18:20:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44017 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJJWUf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 18:20:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so3467495plj.10;
        Thu, 10 Oct 2019 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W3mGTs7MOyLjtpnj0PJB9+Bxqcbq+qsvgn2CFvFNE9o=;
        b=vO3NnEQYc9E8PG1a8ibC12yEWFQFOB1Hx8hGQVef2QBix8XnuHV72vGqiqfBByDX1B
         GB+RXlzi1AgV2HLPIJOxN5OEUrNN1gMc6B+upAOBwjnOFaybpjU2MNBFlpCcCVOGVi34
         Bf6J1QQrOp1pBonMzqpVzSZEKhB48Skt12qivYXo9agFB3h/z3YoYoEanyOXvX4+IV0N
         +vsR5ie1bipkap+s8HO1W/rkb8UOmSt4cT41+D8ayYPw5gSVvww3Yd9sdBrCiRcUCAJQ
         rpk2/At5z7IegYM6MLvNuOvrogHp6udXgni3zdPgfxyAPd31wwzen4UN1i9pSZ5MVqTJ
         /JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W3mGTs7MOyLjtpnj0PJB9+Bxqcbq+qsvgn2CFvFNE9o=;
        b=OCU7a1fTOYzo/8aSu78Iyd4qZdLdP9O6eTujN3yvC71Fs7KZKvTlL2jBQrWENaP/Pf
         YRsAbcuPlC1Gby5+WvA4hKwydUqr6aOQkMs5sjIpK7Ng05pUn9XjdrSJNoxteS2a7JFE
         eMr5320e4aW7nIXHpLFJa2rmV6on+zdDNRW1JS4aC7hdWm68EoxYK3ty3IAryKZxAepN
         Z6h2XjVMUKgV+JWyBfs8kaminoWE3lznwa+vbJZsfLXgO6+8x2cMqLooVLjLgVLPTwho
         u6dPxRW3sOhwE84w5UI8iNykyi/XCmwFH16JFxQiLtV9DwQ4DuA13Y+NpP6jC6oQSiQ/
         QQ3A==
X-Gm-Message-State: APjAAAVmw0hv+kQsy+ONLb5lsZgn/0ROol/3IhnP8ORwC6Y6C9DcR7sZ
        syPzSdJ9EQVKLE0IiUPVJ3vBBzvb
X-Google-Smtp-Source: APXvYqxhaE1iUzipXQlVGVyDvINWacWoHayHW9CYbbNozw8zmvHGLekFyPQMOcyuxIEYoAhqKGzqbg==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10mr12162507plb.56.1570746033896;
        Thu, 10 Oct 2019 15:20:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11sm6805064pgd.0.2019.10.10.15.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 15:20:33 -0700 (PDT)
Subject: Re: [PATCH 15/36] ARM: s3c: adc: move header to linux/soc/samsung
To:     Arnd Bergmann <arnd@arndb.de>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-15-arnd@arndb.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <da32e8a3-cbb3-ea08-1c55-55980b3dc53e@roeck-us.net>
Date:   Thu, 10 Oct 2019 15:20:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010203043.1241612-15-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/10/19 1:29 PM, Arnd Bergmann wrote:
> There are multiple drivers using the private adc interface.
> It seems unlikely that they would ever get converted to iio,
> so make the current state official by making the header file
> global.
> 
> The s3c2410_ts driver needs a couple of register definitions
> as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/mach-s3c64xx/mach-crag6410.c         |  2 +-
>   arch/arm/mach-s3c64xx/mach-mini6410.c         |  2 +-
>   arch/arm/mach-s3c64xx/mach-real6410.c         |  2 +-
>   arch/arm/mach-s3c64xx/mach-smdk6410.c         |  2 +-
>   arch/arm/plat-samsung/adc.c                   |  2 +-
>   arch/arm/plat-samsung/devs.c                  |  2 +-
>   drivers/hwmon/s3c-hwmon.c                     |  2 +-
>   drivers/input/touchscreen/s3c2410_ts.c        | 37 ++++++++++++++++++-
>   drivers/power/supply/s3c_adc_battery.c        |  2 +-
>   .../linux/soc/samsung/s3c-adc.h               |  0
>   10 files changed, 43 insertions(+), 10 deletions(-)
>   rename arch/arm/plat-samsung/include/plat/adc.h => include/linux/soc/samsung/s3c-adc.h (100%)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> index da5b50981a14..133453562d23 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -57,7 +57,7 @@
>   #include <plat/keypad.h>
>   #include <plat/devs.h>
>   #include <plat/cpu.h>
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   #include <linux/platform_data/i2c-s3c2410.h>
>   #include <plat/pm.h>
>   #include <plat/samsung-time.h>
> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
> index 0dd36ae49e6a..c7140300bd3f 100644
> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> @@ -27,7 +27,7 @@
>   #include <mach/regs-gpio.h>
>   #include <mach/gpio-samsung.h>
>   
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   #include <plat/cpu.h>
>   #include <plat/devs.h>
>   #include <plat/fb.h>
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
> index 0ff88b6859c4..f55097fde94c 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -29,7 +29,7 @@
>   #include <mach/gpio-samsung.h>
>   #include <mach/irqs.h>
>   
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   #include <plat/cpu.h>
>   #include <plat/devs.h>
>   #include <plat/fb.h>
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> index 95bdcfe95a53..3042f6cbffd9 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -60,7 +60,7 @@
>   
>   #include <plat/devs.h>
>   #include <plat/cpu.h>
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   #include <linux/platform_data/touchscreen-s3c2410.h>
>   #include <plat/keypad.h>
>   #include <plat/samsung-time.h>
> diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
> index ee3d5c989a76..623a9774cc52 100644
> --- a/arch/arm/plat-samsung/adc.c
> +++ b/arch/arm/plat-samsung/adc.c
> @@ -20,7 +20,7 @@
>   #include <linux/regulator/consumer.h>
>   
>   #include <plat/regs-adc.h>
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   
>   /* This driver is designed to control the usage of the ADC block between
>    * the touchscreen and any other drivers that may need to use it, such as
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index fd94a35e22f8..ddd90f0bb380 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -44,7 +44,7 @@
>   
>   #include <plat/cpu.h>
>   #include <plat/devs.h>
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   #include <linux/platform_data/ata-samsung_cf.h>
>   #include <plat/fb.h>
>   #include <plat/fb-s3c2410.h>
> diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
> index b490fe3d2ee8..f2703c5460d0 100644
> --- a/drivers/hwmon/s3c-hwmon.c
> +++ b/drivers/hwmon/s3c-hwmon.c
> @@ -20,7 +20,7 @@
>   #include <linux/hwmon.h>
>   #include <linux/hwmon-sysfs.h>
>   
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   #include <linux/platform_data/hwmon-s3c.h>
>   
>   struct s3c_hwmon_attr {
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index b346e7cafd62..1a5a178ea286 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -21,10 +21,43 @@
>   #include <linux/clk.h>
>   #include <linux/io.h>
>   
> -#include <plat/adc.h>
> -#include <plat/regs-adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   #include <linux/platform_data/touchscreen-s3c2410.h>
>   
> +#define	S3C2410_ADCCON			(0x00)
> +#define	S3C2410_ADCTSC			(0x04)
> +#define	S3C2410_ADCDLY			(0x08)
> +#define	S3C2410_ADCDAT0			(0x0C)
> +#define	S3C2410_ADCDAT1			(0x10)
> +#define	S3C64XX_ADCUPDN			(0x14)
> +#define	S3C2443_ADCMUX			(0x18)
> +#define	S3C64XX_ADCCLRINT		(0x18)
> +#define	S5P_ADCMUX			(0x1C)
> +#define	S3C64XX_ADCCLRINTPNDNUP		(0x20)
> +
> +/* ADCTSC Register Bits */
> +#define S3C2443_ADCTSC_UD_SEN		(1 << 8)
> +#define S3C2410_ADCTSC_YM_SEN		(1<<7)
> +#define S3C2410_ADCTSC_YP_SEN		(1<<6)
> +#define S3C2410_ADCTSC_XM_SEN		(1<<5)
> +#define S3C2410_ADCTSC_XP_SEN		(1<<4)
> +#define S3C2410_ADCTSC_PULL_UP_DISABLE	(1<<3)
> +#define S3C2410_ADCTSC_AUTO_PST		(1<<2)
> +#define S3C2410_ADCTSC_XY_PST(x)	(((x)&0x3)<<0)
> +
> +/* ADCDAT0 Bits */
> +#define S3C2410_ADCDAT0_UPDOWN		(1<<15)
> +#define S3C2410_ADCDAT0_AUTO_PST	(1<<14)
> +#define S3C2410_ADCDAT0_XY_PST		(0x3<<12)
> +#define S3C2410_ADCDAT0_XPDATA_MASK	(0x03FF)
> +
> +/* ADCDAT1 Bits */
> +#define S3C2410_ADCDAT1_UPDOWN		(1<<15)
> +#define S3C2410_ADCDAT1_AUTO_PST	(1<<14)
> +#define S3C2410_ADCDAT1_XY_PST		(0x3<<12)
> +#define S3C2410_ADCDAT1_YPDATA_MASK	(0x03FF)
> +
> +
>   #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
>   
>   #define INT_DOWN	(0)
> diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
> index 3d00b35cafc9..60b7f41ab063 100644
> --- a/drivers/power/supply/s3c_adc_battery.c
> +++ b/drivers/power/supply/s3c_adc_battery.c
> @@ -22,7 +22,7 @@
>   #include <linux/init.h>
>   #include <linux/module.h>
>   
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>   
>   #define BAT_POLL_INTERVAL		10000 /* ms */
>   #define JITTER_DELAY			500 /* ms */
> diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/include/linux/soc/samsung/s3c-adc.h
> similarity index 100%
> rename from arch/arm/plat-samsung/include/plat/adc.h
> rename to include/linux/soc/samsung/s3c-adc.h
> 

