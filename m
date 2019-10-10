Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2DED33F0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 00:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfJJWaA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 18:30:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33667 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfJJWaA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 18:30:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so3497724pls.0;
        Thu, 10 Oct 2019 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Rq5CoTE2b9CRlBzcczaJbDgzRspVbnY0jyqvQtXOLk=;
        b=F0TXQ8XOSIFR3LftRORcvg6zYvgwuWjXU/vMmsRqPOPJbp6sOmBg8cT/WR2SO4+7n7
         YmoVnNKu6N76Qt8+eZ88+5IydI3fL1sL0ojTwUSN0V50JeV8uqQE7Dpd3/jGR6CUj6dO
         padyHY857EaLkA/6Js8ckRa0uRB6sYPuUvwYdfEQcI/pXCscm9U/3CCyonjBjvAcXloj
         bC8Jcip2EX3aXc7IC7deq7maBynlc80ExvuSzBctzGoHDk6PoErrk56bK+n1e+HWpWHJ
         DOdQQ945k1KQEG58m1UH5ATl38u5n/seJtzaFJugIOauRY7IObLwvl+fBP2dm+XicFy+
         RdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Rq5CoTE2b9CRlBzcczaJbDgzRspVbnY0jyqvQtXOLk=;
        b=GIPzJlX3i9xFUmGQM1NbNuALZfnvsLlN1MGFB/YZp9vP9ST4tTaQ2k0iWJXA++BOrb
         2FtuG/jLx6o8svSKdnWmZ6QZdLU9yAhE5koNwH6kSqVmhKiBnKqyZ/3KeHHPah1bvv3T
         8RkHhVGj1QfT2MM7MKKNPJInyOe/BbpdZzs8TcSURLSpGyLROH/jyW9PQFjQ0TEHq7HU
         SjeRYB8TABQ5qCP5IVjYI1eI3mTHTgtXUjbRf1mU/6JEfvd0vtYtE5I1lvQfIwZTouGG
         bbqtseOb6yaaf7S5ba2938kQuTV108Psfb4qRoq+b8+QhR6/5BlPxdYdoIon3IAorINO
         A/+A==
X-Gm-Message-State: APjAAAWp9GOiXJrsrbVPI8GwUfJD3H0gSNlRfLbQI0jGM4Tv0WDYJHDP
        FPt7Tz4+hMmgCgZygjAqNns=
X-Google-Smtp-Source: APXvYqyTxO9tIPDRTcjUxp64SziEtWMojxOT65LeO0UkvFHvXqwvgTyLxurGAOgkGXCJxq2hsDxzSg==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6mr12111867plk.154.1570746598284;
        Thu, 10 Oct 2019 15:29:58 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h70sm6222740pgc.48.2019.10.10.15.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 15:29:57 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:29:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/36] ARM: s3c: adc: move header to linux/soc/samsung
Message-ID: <20191010222955.GB229325@dtor-ws>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-15-arnd@arndb.de>
 <da32e8a3-cbb3-ea08-1c55-55980b3dc53e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da32e8a3-cbb3-ea08-1c55-55980b3dc53e@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 03:20:32PM -0700, Guenter Roeck wrote:
> On 10/10/19 1:29 PM, Arnd Bergmann wrote:
> > There are multiple drivers using the private adc interface.
> > It seems unlikely that they would ever get converted to iio,
> > so make the current state official by making the header file
> > global.
> > 
> > The s3c2410_ts driver needs a couple of register definitions
> > as well.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> For hwmon:
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

For input:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>


> 
> > ---
> >   arch/arm/mach-s3c64xx/mach-crag6410.c         |  2 +-
> >   arch/arm/mach-s3c64xx/mach-mini6410.c         |  2 +-
> >   arch/arm/mach-s3c64xx/mach-real6410.c         |  2 +-
> >   arch/arm/mach-s3c64xx/mach-smdk6410.c         |  2 +-
> >   arch/arm/plat-samsung/adc.c                   |  2 +-
> >   arch/arm/plat-samsung/devs.c                  |  2 +-
> >   drivers/hwmon/s3c-hwmon.c                     |  2 +-
> >   drivers/input/touchscreen/s3c2410_ts.c        | 37 ++++++++++++++++++-
> >   drivers/power/supply/s3c_adc_battery.c        |  2 +-
> >   .../linux/soc/samsung/s3c-adc.h               |  0
> >   10 files changed, 43 insertions(+), 10 deletions(-)
> >   rename arch/arm/plat-samsung/include/plat/adc.h => include/linux/soc/samsung/s3c-adc.h (100%)
> > 
> > diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> > index da5b50981a14..133453562d23 100644
> > --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> > @@ -57,7 +57,7 @@
> >   #include <plat/keypad.h>
> >   #include <plat/devs.h>
> >   #include <plat/cpu.h>
> > -#include <plat/adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   #include <linux/platform_data/i2c-s3c2410.h>
> >   #include <plat/pm.h>
> >   #include <plat/samsung-time.h>
> > diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
> > index 0dd36ae49e6a..c7140300bd3f 100644
> > --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> > @@ -27,7 +27,7 @@
> >   #include <mach/regs-gpio.h>
> >   #include <mach/gpio-samsung.h>
> > -#include <plat/adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   #include <plat/cpu.h>
> >   #include <plat/devs.h>
> >   #include <plat/fb.h>
> > diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
> > index 0ff88b6859c4..f55097fde94c 100644
> > --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> > @@ -29,7 +29,7 @@
> >   #include <mach/gpio-samsung.h>
> >   #include <mach/irqs.h>
> > -#include <plat/adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   #include <plat/cpu.h>
> >   #include <plat/devs.h>
> >   #include <plat/fb.h>
> > diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > index 95bdcfe95a53..3042f6cbffd9 100644
> > --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > @@ -60,7 +60,7 @@
> >   #include <plat/devs.h>
> >   #include <plat/cpu.h>
> > -#include <plat/adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   #include <linux/platform_data/touchscreen-s3c2410.h>
> >   #include <plat/keypad.h>
> >   #include <plat/samsung-time.h>
> > diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
> > index ee3d5c989a76..623a9774cc52 100644
> > --- a/arch/arm/plat-samsung/adc.c
> > +++ b/arch/arm/plat-samsung/adc.c
> > @@ -20,7 +20,7 @@
> >   #include <linux/regulator/consumer.h>
> >   #include <plat/regs-adc.h>
> > -#include <plat/adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   /* This driver is designed to control the usage of the ADC block between
> >    * the touchscreen and any other drivers that may need to use it, such as
> > diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> > index fd94a35e22f8..ddd90f0bb380 100644
> > --- a/arch/arm/plat-samsung/devs.c
> > +++ b/arch/arm/plat-samsung/devs.c
> > @@ -44,7 +44,7 @@
> >   #include <plat/cpu.h>
> >   #include <plat/devs.h>
> > -#include <plat/adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   #include <linux/platform_data/ata-samsung_cf.h>
> >   #include <plat/fb.h>
> >   #include <plat/fb-s3c2410.h>
> > diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
> > index b490fe3d2ee8..f2703c5460d0 100644
> > --- a/drivers/hwmon/s3c-hwmon.c
> > +++ b/drivers/hwmon/s3c-hwmon.c
> > @@ -20,7 +20,7 @@
> >   #include <linux/hwmon.h>
> >   #include <linux/hwmon-sysfs.h>
> > -#include <plat/adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   #include <linux/platform_data/hwmon-s3c.h>
> >   struct s3c_hwmon_attr {
> > diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> > index b346e7cafd62..1a5a178ea286 100644
> > --- a/drivers/input/touchscreen/s3c2410_ts.c
> > +++ b/drivers/input/touchscreen/s3c2410_ts.c
> > @@ -21,10 +21,43 @@
> >   #include <linux/clk.h>
> >   #include <linux/io.h>
> > -#include <plat/adc.h>
> > -#include <plat/regs-adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   #include <linux/platform_data/touchscreen-s3c2410.h>
> > +#define	S3C2410_ADCCON			(0x00)
> > +#define	S3C2410_ADCTSC			(0x04)
> > +#define	S3C2410_ADCDLY			(0x08)
> > +#define	S3C2410_ADCDAT0			(0x0C)
> > +#define	S3C2410_ADCDAT1			(0x10)
> > +#define	S3C64XX_ADCUPDN			(0x14)
> > +#define	S3C2443_ADCMUX			(0x18)
> > +#define	S3C64XX_ADCCLRINT		(0x18)
> > +#define	S5P_ADCMUX			(0x1C)
> > +#define	S3C64XX_ADCCLRINTPNDNUP		(0x20)
> > +
> > +/* ADCTSC Register Bits */
> > +#define S3C2443_ADCTSC_UD_SEN		(1 << 8)
> > +#define S3C2410_ADCTSC_YM_SEN		(1<<7)
> > +#define S3C2410_ADCTSC_YP_SEN		(1<<6)
> > +#define S3C2410_ADCTSC_XM_SEN		(1<<5)
> > +#define S3C2410_ADCTSC_XP_SEN		(1<<4)
> > +#define S3C2410_ADCTSC_PULL_UP_DISABLE	(1<<3)
> > +#define S3C2410_ADCTSC_AUTO_PST		(1<<2)
> > +#define S3C2410_ADCTSC_XY_PST(x)	(((x)&0x3)<<0)
> > +
> > +/* ADCDAT0 Bits */
> > +#define S3C2410_ADCDAT0_UPDOWN		(1<<15)
> > +#define S3C2410_ADCDAT0_AUTO_PST	(1<<14)
> > +#define S3C2410_ADCDAT0_XY_PST		(0x3<<12)
> > +#define S3C2410_ADCDAT0_XPDATA_MASK	(0x03FF)
> > +
> > +/* ADCDAT1 Bits */
> > +#define S3C2410_ADCDAT1_UPDOWN		(1<<15)
> > +#define S3C2410_ADCDAT1_AUTO_PST	(1<<14)
> > +#define S3C2410_ADCDAT1_XY_PST		(0x3<<12)
> > +#define S3C2410_ADCDAT1_YPDATA_MASK	(0x03FF)
> > +
> > +
> >   #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
> >   #define INT_DOWN	(0)
> > diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
> > index 3d00b35cafc9..60b7f41ab063 100644
> > --- a/drivers/power/supply/s3c_adc_battery.c
> > +++ b/drivers/power/supply/s3c_adc_battery.c
> > @@ -22,7 +22,7 @@
> >   #include <linux/init.h>
> >   #include <linux/module.h>
> > -#include <plat/adc.h>
> > +#include <linux/soc/samsung/s3c-adc.h>
> >   #define BAT_POLL_INTERVAL		10000 /* ms */
> >   #define JITTER_DELAY			500 /* ms */
> > diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/include/linux/soc/samsung/s3c-adc.h
> > similarity index 100%
> > rename from arch/arm/plat-samsung/include/plat/adc.h
> > rename to include/linux/soc/samsung/s3c-adc.h
> > 
> 

-- 
Dmitry
