Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20A83B1074
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 01:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFVXUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 19:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVXUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 19:20:12 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FC3C061574;
        Tue, 22 Jun 2021 16:17:56 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so156111otg.1;
        Tue, 22 Jun 2021 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Apo7HvFOUae0jeu1BlraoIMCVf87oiSN4EtBtQKMT4A=;
        b=NjUcEb64fuF18yJQzCQqQPg4tSbvd+sP8zL1dFHF/P5PwiA50SFjEUOlrHsnRAyEL3
         c1NfrQ/Mg6T/6pwa3rooJNh0Pw3nrcEKY4LYNY0GI+cpzLcILMnwUCx49FFdZd5eCQkO
         +p/q19PFoLf+AGB8ELk9FbSHQdL2LfidVdq2+eJhpg1pVVigFQZhJ4lPW9S+xGfXxBgC
         mbXcwGArr8LLzP/c9Z1qVEtWt8xVVGjwJn2H6YdmyoWjr7UqhFLYkGzWksUq1dTWay9Y
         0c0l7MzGeVBvORA2nzWDG0vpECQam3Zh5ik2gYaYqIUhjrisyC+mHdxT9UEEMbgBdJoX
         l7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Apo7HvFOUae0jeu1BlraoIMCVf87oiSN4EtBtQKMT4A=;
        b=Fql04jVA9szXT96iZYJdV/YuTH7lZLIByVa68Q5d5u9821imnk5HIiuGHdjqYX1Ce9
         ZN9SKVJ8RGjTz0sk8nO4tOFiCj1PA69kpGzMCncXjN1o4LpX6cXgzznObDwVa0rwKTxP
         IPkn1tDIXaCHbzW+jlIQCf35fS4bxqANlbqMZbCeXE9qNgatlh2aKsAdQhcCwRx8Seay
         DSd32kr2Sj1byn8QMGPZ80N9bBw+lEGrv60bhZC+Hv13AMrdrdd4CJ0//InXRgxhxWpa
         yaP9/O6nGvttGBxR/4BDWrAYV59ugvQTNkLCFKmTypvwSj2F22YKo34LStYLeUttvXVP
         KfXQ==
X-Gm-Message-State: AOAM5318whwMSC+eKYTNiLv++alqxm0lEFzLzgGhT45nVgjs0HrteG/3
        BdNMLdTwkawtdy/NFkdRrNg=
X-Google-Smtp-Source: ABdhPJwJOFUjT+Gbzya6a48v24DuC7UaiH9+N1uD3DJow5hG0SrLDeaIobioR6hNuwmSCz2cnrhJBg==
X-Received: by 2002:a9d:7f03:: with SMTP id j3mr5093750otq.235.1624403875153;
        Tue, 22 Jun 2021 16:17:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y13sm195876ots.47.2021.06.22.16.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 16:17:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Jun 2021 16:17:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: Support set_trips() of thermal device ops
Message-ID: <20210622231753.GB1299338@roeck-us.net>
References: <20210621213153.28247-1-digetx@gmail.com>
 <20210621213153.28247-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621213153.28247-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 12:31:53AM +0300, Dmitry Osipenko wrote:
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
> ---
>  drivers/hwmon/hwmon.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index fd47ab4e6892..9cb9d814cb88 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -153,8 +153,41 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
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
Please add
	if (!info[i])
		return 0;
here and drop the two checks for info[i] below.

Thanks,
Guenter

> +	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MIN) {
> +		err = chip->ops->write(tdata->dev, hwmon_temp,
> +				       hwmon_temp_min, tdata->index, low);
> +		if (err && err != -EOPNOTSUPP)
> +			return err;
> +	}
> +
> +	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MAX) {
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
> -- 
> 2.30.2
> 
