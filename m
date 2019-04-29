Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7499EBB2
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfD2UgE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 16:36:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37540 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfD2UgE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 16:36:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so5722592pgc.4;
        Mon, 29 Apr 2019 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aQaqg8n11LTvm5vgZKeyx2tFWtUvX340MWVQ2ZQAFyA=;
        b=dSUobK+DXRH2sVOu2iXMR7VH8/2LlmUWaaSBlNYC/HoBob4bkwOICX7x0L5u8OcVGs
         arARjMKqkDrnYnhAIGvrjfBvrPpdyld6LvAI4VQjZ90R0Xrye0Ya1OKK6Z9exyLMJba4
         TYDOxRi77m6PVr6DGpaBkcCK+tAha+SdZgojzP02XWfZUDoFX057IT1yxXA/XEhFI9Zs
         7GKGFh/FghRXDKxeFFuj3kFX51qWBds2B2pWqPzHfQ8RgERAfVhvPINDnyD9b6GtUw2m
         ttw/SwL26MQIhDo7ppOiUJ78wuDkGVVIYkIW4J/kbOTXe/FRIVC/tFoUeZb1dQQNnPRx
         m2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aQaqg8n11LTvm5vgZKeyx2tFWtUvX340MWVQ2ZQAFyA=;
        b=T/tENgSC5XaVxKsVTVPVJsOXhswZCQ5xnUuG7/mtj3g97+58/ENJeuwzg0J9SS4ZJ8
         b3H/wK5DCgHdHCOXP1Tb5K80EHt2kI771gVD4EEUuojbnhax7cGepv2nNJdHmomB+J94
         YRx17+Pxxn9WAGrGTwgl8PLOjaZeEcZU/mURVueGrQGIfku/Qv9EnMFyqlSPF4eZpbXC
         ykW68dtKbIhef0zkcIdgUdxTJ5s8qMtj6a/WfWnagMnfnPAzLEVNQUnQkhw8TOt+9Yb8
         kEPksLzypROfvSkQQhYSrS5jvJtaR3N1ojCviuLRn7xkqi8YE+UkaX1WdL54g62WDzgp
         ELBg==
X-Gm-Message-State: APjAAAUwLJzIDdJKSy9dmUs3BX5D48RWGN4ZI4wQDd8Hzqyp1/YGra5n
        6EYtCRT9FrBuPY5FuRglO0k=
X-Google-Smtp-Source: APXvYqyLz79xpU6eXxb4s9kzibnGWdrYGDGhHrxCft7BF2L8e4wizIhUij9qgmEpkioHa+USqjfHiA==
X-Received: by 2002:a63:6b08:: with SMTP id g8mr61481224pgc.211.1556570163738;
        Mon, 29 Apr 2019 13:36:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e186sm4104197pfa.150.2019.04.29.13.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:36:02 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:36:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] power: supply: Add driver for Microchip UCS1002
Message-ID: <20190429203601.GA22613@roeck-us.net>
References: <20190429195349.20335-1-andrew.smirnov@gmail.com>
 <20190429195349.20335-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429195349.20335-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 12:53:48PM -0700, Andrey Smirnov wrote:
> Add driver for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation. The driver exposed a power supply
> device to control/monitor various parameter of the device as well as a
> regulator to allow controlling VBUS line.
> 
> Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/Kconfig         |   9 +
>  drivers/power/supply/Makefile        |   1 +
>  drivers/power/supply/ucs1002_power.c | 646 +++++++++++++++++++++++++++
>  3 files changed, 656 insertions(+)
>  create mode 100644 drivers/power/supply/ucs1002_power.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..c614c8a196f3 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
>  	 Say Y here to enable support for fuel gauge with SC27XX
>  	 PMIC chips.
>  
> +config CHARGER_UCS1002
> +        tristate "Microchip UCS1002 USB Port Power Controller"
> +	depends on I2C
> +	depends on OF
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for Microchip UCS1002 Programmable
> +	  USB Port Power Controller with Charger Emulation.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b731c2a9b695..c56803a9e4fe 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
> +obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> new file mode 100644
> index 000000000000..677f20a4d76f
> --- /dev/null
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -0,0 +1,646 @@
...
> +
> +static enum power_supply_usb_type ucs1002_usb_types[] = {
> +	POWER_SUPPLY_USB_TYPE_PD,
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +};
> +
> +static int ucs1002_set_usb_type(struct ucs1002_info *info, int val)
> +{
> +	unsigned int mode;
> +
> +	if (val >= ARRAY_SIZE(ucs1002_usb_types))
> +		return -EINVAL;
> +
I hate to bring it up that late, but I don't see a check
against val being negative anywhere in the calling code.

Guenter
