Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1AE1AC3
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbfJWMha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 08:37:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38769 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbfJWMh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 08:37:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id y8so3339379edu.5;
        Wed, 23 Oct 2019 05:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQZd7Ks2W7nTjayD2ynvN6k8gSwIF6xLtKbZwC/BStI=;
        b=h5PiE9MtiBt0M/t5itZumyrp+4+khDhdAcKtTJBxWZSI4jiJqt66AnfLg1fTDZprIW
         ozBgarjrXMERWr2jnK/IUzmJmojPj12bplAs7ytY5jLkwFmZy10FHUHZfpCFTM1UPito
         6wHxr1smn/eCgeIdDMhKSqwy6TbJDTNdPFZm2mzVDx9wJHbA4FD24GyftvSOWRGksbtg
         8Z4ABPNaHZgIxTNsaebnjcuXC2VsyQyiy0J4WYs7TgnmFNjR0hGGrop8ismT87sGwU4P
         SS/qp2GlPY7VnIwp1X+Us4Ld8Mi8N8Y31DSPyWv0R6npiAhLia0ztSLKKbQ8B9R7SQm1
         u91Q==
X-Gm-Message-State: APjAAAVxGHSKVwHcCOCEm6so3PDhducYXHnoGefAVLsyI32TTirmQyC/
        fUCZVI9juCIEhj8ABcuRHeI=
X-Google-Smtp-Source: APXvYqz9/W6CFefTKhw5teICE7vsX29Qd+eM/1KzbIgnFwyGIGtJWDsVIsuDbHO4JINKZ5tGcXNNFQ==
X-Received: by 2002:a17:906:27c5:: with SMTP id k5mr31969642ejc.173.1571834245072;
        Wed, 23 Oct 2019 05:37:25 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id u18sm130680ejr.67.2019.10.23.05.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:37:24 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:37:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/36] ARM: s3c: adc: move header to linux/soc/samsung
Message-ID: <20191023123722.GD11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-15-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-15-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:59PM +0200, Arnd Bergmann wrote:
> There are multiple drivers using the private adc interface.
> It seems unlikely that they would ever get converted to iio,
> so make the current state official by making the header file
> global.
> 
> The s3c2410_ts driver needs a couple of register definitions
> as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c         |  2 +-
>  arch/arm/mach-s3c64xx/mach-mini6410.c         |  2 +-
>  arch/arm/mach-s3c64xx/mach-real6410.c         |  2 +-
>  arch/arm/mach-s3c64xx/mach-smdk6410.c         |  2 +-
>  arch/arm/plat-samsung/adc.c                   |  2 +-
>  arch/arm/plat-samsung/devs.c                  |  2 +-
>  drivers/hwmon/s3c-hwmon.c                     |  2 +-
>  drivers/input/touchscreen/s3c2410_ts.c        | 37 ++++++++++++++++++-
>  drivers/power/supply/s3c_adc_battery.c        |  2 +-
>  .../linux/soc/samsung/s3c-adc.h               |  0
>  10 files changed, 43 insertions(+), 10 deletions(-)
>  rename arch/arm/plat-samsung/include/plat/adc.h => include/linux/soc/samsung/s3c-adc.h (100%)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> index da5b50981a14..133453562d23 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -57,7 +57,7 @@
>  #include <plat/keypad.h>
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  #include <linux/platform_data/i2c-s3c2410.h>
>  #include <plat/pm.h>
>  #include <plat/samsung-time.h>
> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
> index 0dd36ae49e6a..c7140300bd3f 100644
> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> @@ -27,7 +27,7 @@
>  #include <mach/regs-gpio.h>
>  #include <mach/gpio-samsung.h>
>  
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
>  #include <plat/fb.h>
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
> index 0ff88b6859c4..f55097fde94c 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -29,7 +29,7 @@
>  #include <mach/gpio-samsung.h>
>  #include <mach/irqs.h>
>  
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
>  #include <plat/fb.h>
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> index 95bdcfe95a53..3042f6cbffd9 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -60,7 +60,7 @@
>  
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  #include <linux/platform_data/touchscreen-s3c2410.h>
>  #include <plat/keypad.h>
>  #include <plat/samsung-time.h>
> diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
> index ee3d5c989a76..623a9774cc52 100644
> --- a/arch/arm/plat-samsung/adc.c
> +++ b/arch/arm/plat-samsung/adc.c
> @@ -20,7 +20,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include <plat/regs-adc.h>
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  
>  /* This driver is designed to control the usage of the ADC block between
>   * the touchscreen and any other drivers that may need to use it, such as
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index fd94a35e22f8..ddd90f0bb380 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -44,7 +44,7 @@
>  
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  #include <linux/platform_data/ata-samsung_cf.h>
>  #include <plat/fb.h>
>  #include <plat/fb-s3c2410.h>
> diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
> index b490fe3d2ee8..f2703c5460d0 100644
> --- a/drivers/hwmon/s3c-hwmon.c
> +++ b/drivers/hwmon/s3c-hwmon.c
> @@ -20,7 +20,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  #include <linux/platform_data/hwmon-s3c.h>
>  
>  struct s3c_hwmon_attr {
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index b346e7cafd62..1a5a178ea286 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -21,10 +21,43 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  
> -#include <plat/adc.h>
> -#include <plat/regs-adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  #include <linux/platform_data/touchscreen-s3c2410.h>
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
>  #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
>  
>  #define INT_DOWN	(0)
> diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
> index 3d00b35cafc9..60b7f41ab063 100644
> --- a/drivers/power/supply/s3c_adc_battery.c
> +++ b/drivers/power/supply/s3c_adc_battery.c
> @@ -22,7 +22,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  
> -#include <plat/adc.h>
> +#include <linux/soc/samsung/s3c-adc.h>
>  
>  #define BAT_POLL_INTERVAL		10000 /* ms */
>  #define JITTER_DELAY			500 /* ms */
> diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/include/linux/soc/samsung/s3c-adc.h
> similarity index 100%
> rename from arch/arm/plat-samsung/include/plat/adc.h
> rename to include/linux/soc/samsung/s3c-adc.h

Can you update the name of header guard? __LINUX_SOC_SAMSUNG_S3C_ADC_H?

Best regards,
Krzysztof

