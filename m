Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE9998EB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfHVQMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 12:12:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43471 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHVQMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 12:12:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so4268556pfn.10;
        Thu, 22 Aug 2019 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEkjYtliGniZ/m3Ryj6awYngP6K9+xT7393wdxLCSBM=;
        b=KrdLY8K1mTHT6yWONO2Q0ZOyMWJ90/xCXMB4tQYxcc8ntKOkBWHWuy/QeZpgt7CcdY
         BDgawH060SVT6JkTRxph+zsH4YXc/XdOqTj6udTkZtmwo4T6M+iO4cqT9c/Zu8KQhlaO
         t+EeaczLgPKduF9mNOuTU/f0Nt/jr8IK/CKPlaG+IRyB4amIqL4BYkqAS57iCfrLd1Iw
         YLT54elj5qIVaxN4zXkNu37NUJuP+S6Lwzci6awPvyEJwJ+tDA/Ly8AG1TVynuan4EA6
         DpeqRBz1S6bAnE1DSZrB1CKRH6W+DO/BF4Bm+lvTI2G2ZDYf/sGQMKai8fHZlcbeigE9
         r4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEkjYtliGniZ/m3Ryj6awYngP6K9+xT7393wdxLCSBM=;
        b=jKSycNM+nBANUc2ky/fJ/rtWeRrldTNL4B2YLHuhRADapSL9XRrS6WijJBcRfgXkxu
         DHRNlKHk6e6Na3nKuqG92Jpp4H5/N64eFLDdHSUFzy1pXyiBuPzGYx8gn9dTPVgcYT6q
         z8ql4xfIyc6B835sTXTQ3RZIJFgYNvIXpxBI8ymgnzhMOcBwBpXxM+8ce2RxI4uc6xdp
         d7+T9+CVJIdIMJ5EAqBYw/VBpR+CDGRclNwjoXVnA9YqW4CPY2AuU9fQhIOOiLfQgTlR
         ZFXehVvRjK395cTxUDkdM6LI5/Von2fs3qYqC0VeQJpTvV+8A6+GKTi1Ibcdt8ItdYLN
         G3XQ==
X-Gm-Message-State: APjAAAW2WfMvbFUFKGAokdiZHZ4ZbMHUDbXPrgkWTstvkjnu9fypoip7
        aS8KXDAWhOUDQ68cTbDSuVQ=
X-Google-Smtp-Source: APXvYqwkPBzz0B40cYs+wJtA9Ka7DPlBs9ShvExq4SGVSq/5AbCM73UQyiYGvqPT6UF0B8A8191VUQ==
X-Received: by 2002:a63:c118:: with SMTP id w24mr11131pgf.347.1566490328606;
        Thu, 22 Aug 2019 09:12:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 185sm45062537pff.54.2019.08.22.09.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:12:07 -0700 (PDT)
Date:   Thu, 22 Aug 2019 09:12:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: register HWMON devices with valid names
Message-ID: <20190822161207.GB6992@roeck-us.net>
References: <20190822150919.18290-1-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822150919.18290-1-romain.izard.pro@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 05:09:19PM +0200, Romain Izard wrote:
> With the introduction of the HWMON compatibility layer to the power
> supply framework in Linux 5.3, all power supply devices' names can be
> used directly to create HWMON devices with the same names.
> 
> But HWMON has rules on allowable names that are different from the power
> supply framework. The dash character is forbidden, as it is used by the
> libsensors library in userspace as a separator, whereas this character
> is used in the device names in more than half of the existing power
> supply drivers. This last case is consistent with the typical naming
> usage with MFD and Device Tree.
> 
> This leads to warnings in the kernel log, with the format:
> 
> power_supply gpio-charger: hwmon: \
> 	'gpio-charger' is not a valid name attribute, please fix
> 
> Add a protection to power_supply_add_hwmon_sysfs() that replaces any
> dash in the device name with an underscore when registering with the
> HWMON framework. Other forbidden characters (star, slash, space, tab,
> newline) are not replaced, as they are not in common use.
> 
> Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  drivers/power/supply/power_supply_hwmon.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> index 51fe60440d12..ebe964bd512c 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -284,6 +284,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
>  	struct device *dev = &psy->dev;
>  	struct device *hwmon;
>  	int ret, i;
> +	const char *name;
>  
>  	if (!devres_open_group(dev, power_supply_add_hwmon_sysfs,
>  			       GFP_KERNEL))
> @@ -334,7 +335,19 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
>  		}
>  	}
>  
> -	hwmon = devm_hwmon_device_register_with_info(dev, psy->desc->name,
> +	name = psy->desc->name;
> +	if (strchr(name, '-')) {
> +		char *new_name;
> +
> +		new_name = devm_kstrdup(dev, name, GFP_KERNEL);
> +		if (!new_name) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +		strreplace(new_name, '-', '_');
> +		name = (const char *) new_name;

Is that typecast necessary ?

Other than that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> +	}
> +	hwmon = devm_hwmon_device_register_with_info(dev, name,
>  						psyhw,
>  						&power_supply_hwmon_chip_info,
>  						NULL);
> -- 
> 2.17.1
> 
