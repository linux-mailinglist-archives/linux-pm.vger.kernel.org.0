Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAA3B311A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFXOSE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 10:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFXOSE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 10:18:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C873C061574;
        Thu, 24 Jun 2021 07:15:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so3925435otk.7;
        Thu, 24 Jun 2021 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nZjVyzZsb81wztakP7Xrxylxn59FboylSwahYy/4064=;
        b=sY+1LZiod5ob1CQgRJB49BxZQt5g2B77cLoV3iMQxICp1nnaVf8oxKjngOrjsyWZ3z
         rUGnAOSRVwdaLMMXdQlAQK7DSb/IF+r9BXtlfS8oAtNnZ7JJUubjKT3HSMfIQevmAU1G
         dDpivzr2g3iyUhCBKwBBzRyNkiEXnUh99SEWPoXB2tLgq66EnL3fuOoQWkXNsaJTyuli
         HWJhJ2FBaGGvXpAtxs1QaFQdcF17CLjK1FERXD0xqFDukik5gF9F1vlqPibrsBnHWx+/
         R4Zl/ETxWJisg0MV4BnBAzCV1oUxytzlKMhU+ITxS6RoDl/BcqVzvYS+baeqgyebHU84
         d5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nZjVyzZsb81wztakP7Xrxylxn59FboylSwahYy/4064=;
        b=IgVZNJ595K9u8+hcW2HUzGt/MWic3sm3dv4OlifJdk0fBHdvDPqEiElYyLru4iWpYM
         tr46Ml/S9EFib7DjrodVoYN9VzPwH0XuicO+A7Zh/D7/OXmtZY4VCi28uLP2ihhAKQEV
         9saa40HTtnBqtQP58L+LknpR2YHnsptcGzeoXivV/n5epa8FXsANOtAw1OLROgJ4ItO2
         B9Mm8tvOQaifnD++qDHjZfoem+Vlx6xlHTgvcQVHqXx/HuoXMMVXARt5BTAcvN9nNcXw
         1zlnnTpYgX8AbLbZYYaQamtZS6q2dcVoyiN/o+rupSoYPIshvUvFmhaA6aoZJBJgEKJU
         CTag==
X-Gm-Message-State: AOAM531Tg9uiknpIW0O8ZC9376kqByEMrfPG+2fjyPtP0BWYs9cE30qy
        WvT0xP5d3vnfN5GHD31rPHI=
X-Google-Smtp-Source: ABdhPJyOYwSFZ9SagWIpjFLYG7gIV01mU7gqgRWWiAKmJAFo2SFbLpyPScHulTrk8tZi5uVy9kG5Kg==
X-Received: by 2002:a9d:6508:: with SMTP id i8mr4596161otl.368.1624544143599;
        Thu, 24 Jun 2021 07:15:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm726900otl.27.2021.06.24.07.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 07:15:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Jun 2021 07:15:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 2/2] hwmon: Support set_trips() of thermal device ops
Message-ID: <20210624141541.GA3709721@roeck-us.net>
References: <20210623042231.16008-1-digetx@gmail.com>
 <20210623042231.16008-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623042231.16008-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 23, 2021 at 07:22:31AM +0300, Dmitry Osipenko wrote:
> Support set_trips() callback of thermal device ops. This allows HWMON
> device to operatively notify thermal core about temperature changes, which
> is very handy to have in a case where HWMON sensor is used by CPU thermal
> zone that performs passive cooling and emergency shutdown on overheat.
> Thermal core will be able to react faster to temperature changes.
> 
> The set_trips() callback is entirely optional. If HWMON sensor doesn't
> support setting thermal trips, then the callback is a NO-OP. The dummy
> callback has no effect on the thermal core. The temperature trips are
> either complement the temperature polling mechanism of thermal core or
> replace the polling if sensor can set the trips and polling is disabled
> by a particular device in a device-tree.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index fd47ab4e6892..8d3b1dae31df 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -153,8 +153,44 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
>  	return 0;
>  }
>  
> +static int hwmon_thermal_set_trips(void *data, int low, int high)
> +{
> +	struct hwmon_thermal_data *tdata = data;
> +	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
> +	const struct hwmon_chip_info *chip = hwdev->chip;
> +	const struct hwmon_channel_info **info = chip->info;
> +	unsigned int i;
> +	int err;
> +
> +	if (!chip->ops->write)
> +		return 0;
> +
> +	for (i = 0; info[i] && info[i]->type != hwmon_temp; i++)
> +		continue;
> +
> +	if (!info[i])
> +		return 0;
> +
> +	if (info[i]->config[tdata->index] & HWMON_T_MIN) {
> +		err = chip->ops->write(tdata->dev, hwmon_temp,
> +				       hwmon_temp_min, tdata->index, low);
> +		if (err && err != -EOPNOTSUPP)
> +			return err;
> +	}
> +
> +	if (info[i]->config[tdata->index] & HWMON_T_MAX) {
> +		err = chip->ops->write(tdata->dev, hwmon_temp,
> +				       hwmon_temp_max, tdata->index, high);
> +		if (err && err != -EOPNOTSUPP)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct thermal_zone_of_device_ops hwmon_thermal_ops = {
>  	.get_temp = hwmon_thermal_get_temp,
> +	.set_trips = hwmon_thermal_set_trips,
>  };
>  
>  static void hwmon_thermal_remove_sensor(void *data)
