Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C719DA12
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404244AbgDCP0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 11:26:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36122 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404024AbgDCP0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 11:26:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so9004205wrs.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2020 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dPsD1P55G+S5RL8TgvwOFMHia5JH83kaO5H6bTOs9Ew=;
        b=IuI4IA95P0M86H0txL7j4mmWPiOBafK8GpR0q1XCTmuM4QneVHPm0C0olucZfE/gCU
         lEaottxJ+YuwPYayhNGfLYrp3Ss1oorSuarJG2njfaLLusj5MZNAppPuoAyePmCWBjHM
         KbRmK6cUTgSDSgn/+LC/AOnNquVF/uwqFmkOZJffC0bJaHx23Ob5z9TcAybugMzHYkeg
         clbcKqxsVEHGUIiOYEs/GG/NtTrYIyYqpDWqv42e/+rxoJc9KQ0X8SImQEqFXlBReiu3
         8QaKWHRhbs9xJqEo3DFkTzBJawi7nKFfvC7VIw6n8w1rZ86VPMVaaNI9hikMQ5EMo0sE
         KEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dPsD1P55G+S5RL8TgvwOFMHia5JH83kaO5H6bTOs9Ew=;
        b=PmB17WmWsgsFflhrmojjg0rDv8zROwP3skDpIy37He+SqXN131ABde6OUWaPLJ+Xzb
         EjkXflUHVWCptEsQexQrpbYVyMbWYHR+Dl2qu3bQFThCoWQX8fMQi1Z04WiEMYzsLIV2
         bJ1V1zUEm1q/jHDUn9z0dnRPYng6OxioNEQ0wxLsOYoc9Jyu4woDtNBm/Mv64FNm8ePB
         ZylFlYGM+1XnyerrM1IdIq4yGq1IkwLgV/MLIaKe3GRL2O+qLcZiUA+CsXa55H+ypOJS
         4TjgaseWm1sOYQTpzUAlQ0VSpT+6toQrf28s+hMYWlWXWYaAX6f7x33IwHCyUkvVVr8k
         YQrg==
X-Gm-Message-State: AGi0PuYknIVJXc3M6ANC8fJAEN+BsO3y2gulH2apKbCXbnOsqp1l9SM9
        UR31htqNwQLn6ak/qGEUj+FlDQ==
X-Google-Smtp-Source: APiQypJRGQ2u7Q9GMA++cCC4/ShVkAWZtF1y/pb0xhjpRHu3OKVOnvsXsR0h8KS8bE1EFR4JLEPgQw==
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr10094536wrt.150.1585927600740;
        Fri, 03 Apr 2020 08:26:40 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cc78:8018:8980:25d8? ([2a01:e34:ed2f:f020:cc78:8018:8980:25d8])
        by smtp.googlemail.com with ESMTPSA id g3sm12595749wrm.66.2020.04.03.08.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 08:26:40 -0700 (PDT)
Subject: Re: [PATCH] thermal: core: Send a sysfs notification on trip points
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org>
 <20200402142116.22869-1-daniel.lezcano@linaro.org>
 <20200403144009.szjoss5ecleisg2f@axis.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e0c819ce-31f4-cee1-c7cc-7ecb73d374a3@linaro.org>
Date:   Fri, 3 Apr 2020 17:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403144009.szjoss5ecleisg2f@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/04/2020 16:40, Vincent Whitchurch wrote:
> On Thu, Apr 02, 2020 at 04:21:15PM +0200, Daniel Lezcano wrote:
>> Currently the userspace has no easy way to get notified when a
>> specific trip point was crossed. There are a couple of
>> approaches:
>>
>> - the userspace polls the sysfs temperature with usually an
>> unacceptable delay between the trip temperature point crossing
>> and the moment it is detected, or a high polling rate with an
>> unacceptable number of wakeup events.
>>
>> - the thermal zone is set to be managed by an userspace governor
>> in order to receive the uevent even if the thermal zone needs to
>> be managed by another governor.
>>
>> These changes allow to send a sysfs notification on the
>> trip_point_*_temp when the temperature is getting higher than the
>> trip point temperature. By this way, the userspace can be
>> notified everytime when the trip point is crossed, this is useful
>> for the thermal Android HAL or for notification to be sent via
>> d-bus.
>>
>> That allows the userspace to manage the applications based on
>> specific alerts on different thermal zones to mitigate the skin
>> temperature, letting the kernel governors handle the high
>> temperature for hardware like the CPU, the GPU or the modem.
>>
>> The temperature can be oscillating around a trip point and the
>> event will be sent multiple times. It is up to the userspace to
>> deal with this situation.
>
> The actual temperature value would also be interesting.  Is there a
> way for userspace to obtain it in a race-free manner when it is
> notified that the trip point has been crossed?

No and IMO that would not make sense because even if there is a
guarantee you have the temperature with the notification, one micro
second later it could be less than the trip point. The content of the
trip point file is the temperature you can rely on as a start of the
sampling.

The trip point notification must be the trigger to start reading the
temperatures and the polling sampling gives the accuracy of the results.

The hysteresis value can reduce the oscillation with the notifications
but the userspace must ensure in any case it is able to deal with
multiple notifications.

There are some plans to create a new mechanism to notify and pass data
from kernel space to user space via a kfifo but that is fairly new
framework with a lot of cleanup before in the thermal core.


>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c index c06550930979..3cbdd20252ab
>> 100644 --- a/drivers/thermal/thermal_core.c +++
>> b/drivers/thermal/thermal_core.c @@ -407,6 +407,19 @@ static void
>> handle_critical_trips(struct thermal_zone_device *tz, } }
>>
>> +static int thermal_trip_crossed(struct thermal_zone_device *tz,
>> int trip) +{ +	int trip_temp; + +	tz->ops->get_trip_temp(tz,
>> trip, &trip_temp); + +	if (tz->last_temperature ==
>> THERMAL_TEMP_INVALID) +		return 0; + +	return
>> ((tz->last_temperature < trip_temp)) && +		(tz->temperature >=
>> trip_temp));
>
> drivers/thermal/thermal_core.c: In function
> ‘thermal_trip_crossed’: drivers/thermal/thermal_core.c:425:33:
> error: expected ‘;’ before ‘)’ token (tz->temperature >=
> trip_temp)); ^ drivers/thermal/thermal_core.c:425:33: error:
> expected statement before ‘)’ token

Yep, I will fix that.

Thanks for reporting.

>> +} + static void handle_thermal_trip(struct thermal_zone_device
>> *tz, int trip) { enum thermal_trip_type type; @@ -417,6 +430,16
>> @@ static void handle_thermal_trip(struct thermal_zone_device
>> *tz, int trip)
>>
>> tz->ops->get_trip_type(tz, trip, &type);
>>
>> +	/* +	 * This condition will be true everytime the temperature
>> is +	 * greater than the trip point and the previous temperature
>> +	 * was below. In this case notify the userspace via a sysfs +
>> * event on the trip point. +	 */ +	if (thermal_trip_crossed(tz,
>> trip)) +		sysfs_notify(&tz->device.kobj, NULL, +
>> tz->trip_temp_attrs[trip].attr.attr.name);
>
> Normally sysfs_notify() is used to notify userspace that the value
> of the sysfs file has changed, but in this case it's being used on
> a sysfs file whose value never changes.  I don't know if there are
> other drivers that do something similar.

I think so:

eg.

drivers/hwmon/adt7x10.c:
	sysfs_notify(&dev->kobj, NULL, "temp1_max_alarm");
drivers/hwmon/adt7x10.c:
	sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
drivers/hwmon/adt7x10.c:
	sysfs_notify(&dev->kobj, NULL, "temp1_crit_alarm");

drivers/hwmon/abx500.c:
	sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
drivers/hwmon/abx500.c:
	sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);

drivers/hwmon/stts751.c:
	sysfs_notify(&priv->dev->kobj, NULL, "temp1_max_alarm");
drivers/hwmon/stts751.c:
	sysfs_notify(&priv->dev->kobj, NULL, "temp1_min_alarm");

There are also some other places I believe they are doing the same like:

drivers/md/md.c:
	sysfs_notify(&mddev->kobj, NULL, "sync_completed");
drivers/md/md.c:
	sysfs_notify(&mddev->kobj, NULL, "degraded");


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
