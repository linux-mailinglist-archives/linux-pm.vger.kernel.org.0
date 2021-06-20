Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E263ADF94
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFTRZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhFTRZq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 13:25:46 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607CC061574;
        Sun, 20 Jun 2021 10:23:32 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id h9so4839721oih.4;
        Sun, 20 Jun 2021 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LrvTjkVod7ZqTOX2SxHZ5L1FsFwkJ4eL7l94Zz04UZo=;
        b=TzDA/sRft6TNK1ciugf5TucJw2rI2kXTH6u1Yb3RaFNbiS2mWwoturz+CWGE75zve9
         cQ2LFIhWo7f26RNlBzX+gAO8Mg2QLv2V5hD90vsL18dnGQakMF2MfhtmkvDe4FLRTvOf
         J6RusToW+IhJMDOfdvsgrimZa3TUxrWSKGlH9TOfMqOxLySNfCwoYtbwh34aYsTtxhim
         8ZrX0IzC5+6HnIu7zolwIB215GYdFsoRz60eN8Pyq0EdxQ7axX5tMRDtB8dAYtFvOzqJ
         cm78QfuR8u+HtldGNXkpZK/QdwyuyNUX+fCu0J2dLZPJyiJLbxuvb1H2i+dGj1j1T1wB
         0OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LrvTjkVod7ZqTOX2SxHZ5L1FsFwkJ4eL7l94Zz04UZo=;
        b=jBjh0PyC0eNVB3KtczdolPbgy9xzjuKnNaCZ/9sDKWaIqorXIDl6+aNVy8pCWFtJg8
         tdpadOKyQeM00frwgJB4VMd7w64L6YIeChf70ozd0xP9ML3DsBbbNRcNSSzNyKrONQSm
         hmN5iKdBlkANqxbBGRMjHRBpJAs6WhzMlOf3G/Upi2dtZcE2JetOlkK29KK/fhtTqjPb
         FghAAZDOiwjl2C9a+rI4GDx3GLNBZXJq30QkHLNhlAmtgtXsam7P2eIWr6Kv+lw5AV5u
         Oq6TEaX6cBTZCpf1gocvuenu2RyF1k4liRBUpxd6UlF0dqHs/H91CjcYHhdeal9rsZlS
         GLKQ==
X-Gm-Message-State: AOAM533vfWimN/hzFgXFRoJdNPFksDfJAxQQgK42WurtdkwJx4Lem7wU
        Mf6FRnnQcut9BltzJiJUEuE=
X-Google-Smtp-Source: ABdhPJwegTeLa7FHsOLXsWou39nL3vS2ZzdvAJp+NrqQlNd+l1KvpstVkJSbAlBuF9py3eV7pQ6sYA==
X-Received: by 2002:aca:5dc6:: with SMTP id r189mr22292580oib.164.1624209811323;
        Sun, 20 Jun 2021 10:23:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l12sm3155282oig.49.2021.06.20.10.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 10:23:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Jun 2021 10:23:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/2] hwmon: Support set_trips() of thermal device ops
Message-ID: <20210620172329.GA3850372@roeck-us.net>
References: <20210620161223.16844-1-digetx@gmail.com>
 <20210620161223.16844-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210620161223.16844-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 20, 2021 at 07:12:22PM +0300, Dmitry Osipenko wrote:
> Support set_trips() callback of thermal device ops. This allows HWMON
> device to operatively notify thermal core about temperature changes, which
> is very handy to have in a case where HWMON sensor is used by CPU thermal
> zone that performs passive cooling and emergency shutdown on overheat.
> Thermal core will be able to react faster to temperature changes.
> 

Why would this require a driver callback, and why can it not be handled
in the hwmon core alone ? The hwmon core could register a set_trip function
if the chip (driver) supports setting low and high limits, and it could
call the appropriate driver functions when hwmon_thermal_set_trips()
is called.

Guenter

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/hwmon/hwmon.c | 12 ++++++++++++
>  include/linux/hwmon.h |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index fd47ab4e6892..4bd39ed86877 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -153,8 +153,20 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
>  	return 0;
>  }
>  
> +static int hwmon_thermal_set_trips(void *data, int low, int high)
> +{
> +	struct hwmon_thermal_data *tdata = data;
> +	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
> +
> +	if (!hwdev->chip->ops->set_trips)
> +		return 0;
> +
> +	return hwdev->chip->ops->set_trips(tdata->dev, tdata->index, low, high);
> +}
> +
>  static const struct thermal_zone_of_device_ops hwmon_thermal_ops = {
>  	.get_temp = hwmon_thermal_get_temp,
> +	.set_trips = hwmon_thermal_set_trips,
>  };
>  
>  static void hwmon_thermal_remove_sensor(void *data)
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 1e8d6ea8992e..7e5afcbf713d 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -390,6 +390,14 @@ enum hwmon_intrusion_attributes {
>   *			Channel number
>   *		@val:	Value to write
>   *		The function returns 0 on success or a negative error number.
> + * @set_trips:	Callback to set temperature trips. Optional.
> + *		Parameters are:
> + *		@dev:	Pointer to hardware monitoring device
> + *		@channel:
> + *			Channel number
> + *		@low:	Low temperature trip
> + *		@high:	High temperature trip
> + *		The function returns 0 on success or a negative error number.
>   */
>  struct hwmon_ops {
>  	umode_t (*is_visible)(const void *drvdata, enum hwmon_sensor_types type,
> @@ -400,6 +408,7 @@ struct hwmon_ops {
>  		    u32 attr, int channel, const char **str);
>  	int (*write)(struct device *dev, enum hwmon_sensor_types type,
>  		     u32 attr, int channel, long val);
> +	int (*set_trips)(struct device *dev, int channel, int low, int high);
>  };
>  
>  /**
> -- 
> 2.30.2
> 
