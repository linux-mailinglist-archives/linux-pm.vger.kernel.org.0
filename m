Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D36DF1A929
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2019 21:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfEKTEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 May 2019 15:04:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34781 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKTEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 May 2019 15:04:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id w7so4394803plz.1;
        Sat, 11 May 2019 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mGaRnqVCoyCZOIBZ9izPfSHfOocCoIwti//LG4qze0c=;
        b=MI8w5cGx0btx5xiSYFrJJoCJwkyQlKKgVznkYSIQQyeEo51cg4O3QncAEZ2yQ7qAEk
         ClKCFyKB1BtyCtfMJwqORCb+mHsBhx7bTBh5eO8Jp3JnAfuRr3yXyhzH2FdDTyChiPFY
         PE2ibBHBRZGKjU7qWeRcDtASrk8YyzIvVIvPuVYmqf0YuDwlA0xS+6nOJ8q+ejqY5zDc
         9ia25Yc+pKfzsShQKYxWWvitFtb498YlRPX0Hh1mT2kH4erY8pugknQ/Uh8aTUBOkGHQ
         HKxxl0UPHcS5VYEdyxZmQD10jgPJWiCP2rgMNouweQ6cXUE/bgDzk0G/U3cbc4n20Xgp
         savA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mGaRnqVCoyCZOIBZ9izPfSHfOocCoIwti//LG4qze0c=;
        b=oYK29aTCgr3XJTqrLbtU4cnsnDgqMQKdp69GBmYPJcVUp9fLvOgTOg/WCLN7pzCLBH
         zsU/iLUb985r2xFqqPFHN9HCcHxPxz5nY7zJdmV3GMTMEMXUbYMcHWQpgGXbZzVW8KgV
         GbXxeMQAAzHJR7sfsXW+39KzzAiTeM1wg7wcU3Rom8xq2tOeQNTt93f11kKTjOTtCrJp
         ZwzgjRK2EBgGSBuWwWCByFxYDCRq/HZub3JzVZI10BDoIZQI5lSbHstu1rx8lelh4HwE
         avq4DPEHdMhk5YUUHz/4Q/+QOPSXRwpg+NaZGaF1hY78/mTxWEnhk03K59SH6fMTYgMx
         tMpg==
X-Gm-Message-State: APjAAAW6g5jso73lZXqCYBhVrAfawLN8GZt4pvJ32dM/GC3m4VIQcizH
        Ee9i1d2D2FD4zbZDzNHhCzE=
X-Google-Smtp-Source: APXvYqyt/eaU9d15W8IfOa5xOEidfRGbLhiHRr2EdYIRq+a25FXzjyRxhMHBQ2aiAInKd+bzRgMYIg==
X-Received: by 2002:a17:902:20e2:: with SMTP id v31mr21870303plg.138.1557601462677;
        Sat, 11 May 2019 12:04:22 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4a55:a659:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id u38sm9494634pgn.73.2019.05.11.12.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 12:04:22 -0700 (PDT)
Date:   Sat, 11 May 2019 12:04:18 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/6] thermal: Introduce
 devm_thermal_of_cooling_device_register
Message-ID: <20190511190415.GA22816@localhost.localdomain>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
 <1555617500-10862-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555617500-10862-2-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Guenter,

On Thu, Apr 18, 2019 at 12:58:15PM -0700, Guenter Roeck wrote:
> thermal_of_cooling_device_register() and thermal_cooling_device_register()
> are typically called from driver probe functions, and
> thermal_cooling_device_unregister() is called from remove functions. This
> makes both a perfect candidate for device managed functions.
> 
> Introduce devm_thermal_of_cooling_device_register(). This function can
> also be used to replace thermal_cooling_device_register() by passing a NULL
> pointer as device node. The new function requires both struct device *
> and struct device_node * as parameters since the struct device_node *
> parameter is not always identical to dev->of_node.
> 
> Don't introduce a device managed remove function since it is not needed
> at this point.

I don't have any objection on adding this API. Only a minor thing below:


> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/thermal/thermal_core.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h        |  5 +++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6590bb5cb688..e0b530603db6 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1046,6 +1046,55 @@ thermal_of_cooling_device_register(struct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
>  
> +static void thermal_cooling_device_release(struct device *dev, void *res)
> +{
> +	thermal_cooling_device_unregister(
> +				*(struct thermal_cooling_device **)res);
> +}
> +
> +/**
> + * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
> + *					       device
> + * @dev:	a valid struct device pointer of a sensor device.
> + * @np:		a pointer to a device tree node.
> + * @type:	the thermal cooling device type.
> + * @devdata:	device private data.
> + * @ops:	standard thermal cooling devices callbacks.
> + *
> + * This function will register a cooling device with device tree node reference.
> + * This interface function adds a new thermal cooling device (fan/processor/...)
> + * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
> + * to all the thermal zone devices registered at the same time.
> + *
> + * Return: a pointer to the created struct thermal_cooling_device or an
> + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> + */
> +struct thermal_cooling_device *
> +devm_thermal_of_cooling_device_register(struct device *dev,
> +				struct device_node *np,
> +				char *type, void *devdata,
> +				const struct thermal_cooling_device_ops *ops)
> +{
> +	struct thermal_cooling_device **ptr, *tcd;
> +
> +	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
> +	if (IS_ERR(tcd)) {
> +		devres_free(ptr);
> +		return tcd;
> +	}
> +
> +	*ptr = tcd;
> +	devres_add(dev, ptr);
> +
> +	return tcd;
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
> +
>  static void __unbind(struct thermal_zone_device *tz, int mask,
>  		     struct thermal_cooling_device *cdev)
>  {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5f4705f46c2f..43cf4fdd71d4 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -447,6 +447,11 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
>  struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np, char *, void *,
>  				   const struct thermal_cooling_device_ops *);
> +struct thermal_cooling_device *
> +devm_thermal_of_cooling_device_register(struct device *dev,
> +				struct device_node *np,
> +				char *type, void *devdata,
> +				const struct thermal_cooling_device_ops *ops);

We need to stub this in case thermal is not selected.

>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);

Something like:


diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 43cf4fd..9b1b365 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -508,6 +508,14 @@ static inline struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
        char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+                               struct device_node *np,
+                               char *type, void *devdata,
+                               const struct thermal_cooling_device_ops *ops)
+{
+       return ERR_PTR(-ENODEV);
+}
 static inline void thermal_cooling_device_unregister(
        struct thermal_cooling_device *cdev)
 { }
~


If you want I can amend this to your patch and apply it.

Also, do you prefer me to collect only this patch and you would collect hwmon changes,
or are you ok if I collect all the series?

