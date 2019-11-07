Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F395F2E77
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfKGMtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 07:49:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50688 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbfKGMtY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 07:49:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so1558087wmh.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 04:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yB0+vOBvHwx/D3I2UiXTXFnXliRC0mQvEhKkj9Rooo=;
        b=G6akXD1D1z24z5ZgA7LdIC/4i+lpXjTanyXmHIaqLo1YW9zyAl0XQEqv9ARvyy+iGN
         VTNFnosP5NO2b0lbeNdaFBsHwXHwCYw6Pq7cQc5t5J43RiouDiykin77N7GkcYP5I3tM
         lLs6RjrVlbYDRozRFI5EWKHSJc0xdp+R/So1EYHwYOd1Z+ttJuUWVv3TW5jMyUd2Flsj
         YT2JTb/6xDg0eBRSvmsPofuYSWcW1arDy3nEXSUD66HmrGJ/YtpkIuzShnTZmhXSQx8c
         rcYS4sy4YOSHzUEN/5VxYsPW0jCAvi8DBwZIf/clT6qT8LFKkFzHuqgxmvDhGubmR/lj
         xyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5yB0+vOBvHwx/D3I2UiXTXFnXliRC0mQvEhKkj9Rooo=;
        b=dTY9kYD/zeOoPP3a17r2czVOXG7b+Dhh4tYpYy/jw6rvt8eCOZ+l9Lqa4JYyMK0Xbb
         0fYMjL45R8sR53CMilEjtUOMdS2bjGE7wMdtkgxmSS3Eqsbhyq9oWtdOJKCVyU1ZIZ4M
         YGikjb5uGw8cfWxwwQVmogZy1i0Wb2cnRn4O9r3z909N4B545QNfhQIuOyVeWLIW952t
         PX7BqqgKB5hpMaKu3VvoTJjdUXWzAuKUOXbX3O951ayaDbzZsgTXiZopdvVto5IBqjHV
         KQlkklr7USsmmKZIWkba+dw3tmrqacUKdK4E74CkUfHk1vC86sQ4/cXqCetE5CE4qWYQ
         Ae1g==
X-Gm-Message-State: APjAAAUCtIRIzd9PNr0pFPFyTGn1+7y+FReeXU+ahLJHl4xPUUdgp62D
        a7uJuLuqCa3Rzm0gFTbEgeO+V3hOo8g=
X-Google-Smtp-Source: APXvYqyhSJJOeLF2gtAM4DoTTK6JGO2XysG4GO4I/EBpPC/IohaMR+iXQArvzBas+J0Ux9KLGb9jMQ==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr2893311wmi.114.1573130959252;
        Thu, 07 Nov 2019 04:49:19 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:79c2:dbff:63d2:c1f9? ([2a01:e34:ed2f:f020:79c2:dbff:63d2:c1f9])
        by smtp.googlemail.com with ESMTPSA id m9sm2083714wro.66.2019.11.07.04.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 04:49:18 -0800 (PST)
Subject: Re: [PATCH] of-thermal: Disable polling when interrupt property is
 found in DT
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <cover.1571181041.git.amit.kucheria@linaro.org>
 <1b53ef537203e629328285b4597a09e4a586d688.1571181041.git.amit.kucheria@linaro.org>
 <ed9ef9e3-a8c3-90bf-4e71-8959b2ff94d2@linaro.org>
 <CAHLCerO49=iensdHC=dP-y0Pk_24AYEO53Zw=K5OjtNhmOyUpA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <05ac0f40-e82f-629c-c433-86090041798e@linaro.org>
Date:   Thu, 7 Nov 2019 13:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerO49=iensdHC=dP-y0Pk_24AYEO53Zw=K5OjtNhmOyUpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/11/2019 07:26, Amit Kucheria wrote:
> On Wed, Oct 30, 2019 at 12:21 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 16/10/2019 01:13, Amit Kucheria wrote:
>>> Currently, in order to enable interrupt-only mode, one must set
>>> polling-delay-passive and polling-delay properties in the DT to 0,
>>> otherwise the thermal framework will continue to setup a periodic timers
>>> to monitor the thermal zones.
>>>
>>> Change the behaviour, so that on DT-based systems, we no longer have to
>>> set the properties to zero if we find an 'interrupt' property in the
>>> sensor.
>>>
>>> Following data shows the number of times
>>> thermal_zone_device_set_polling() is invoked with and without this
>>> patch. So the patch achieves the same behaviour as setting the delay
>>> properties to 0.
>>>
>>> Current behaviour (without setting delay properties to 0):
>>>   FUNC                              COUNT
>>>   thermal_zone_device_update          302
>>>   thermal_zone_device_set_pollin     7911
>>>
>>> Current behaviour (with delay properties set to 0):
>>>   FUNC                              COUNT
>>>   thermal_zone_device_update            3
>>>   thermal_zone_device_set_pollin        6
>>>
>>> With this patch (without setting delay properties to 0):
>>>   FUNC                              COUNT
>>>   thermal_zone_device_update            3
>>>   thermal_zone_device_set_pollin        6
>>>
>>> Suggested-by: Stephen Boyd <swboyd@chromium.org>
>>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>>> ---
>>>  drivers/thermal/of-thermal.c | 15 +++++++++++++--
>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>>> index dc5093be553e..79ad587462b1 100644
>>> --- a/drivers/thermal/of-thermal.c
>>> +++ b/drivers/thermal/of-thermal.c
>>> @@ -412,7 +412,8 @@ static struct thermal_zone_device_ops of_thermal_ops = {
>>>  static struct thermal_zone_device *
>>>  thermal_zone_of_add_sensor(struct device_node *zone,
>>>                          struct device_node *sensor, void *data,
>>> -                        const struct thermal_zone_of_device_ops *ops)
>>> +                        const struct thermal_zone_of_device_ops *ops,
>>> +                        bool force_interrupts)
>>>  {
>>>       struct thermal_zone_device *tzd;
>>>       struct __thermal_zone *tz;
>>> @@ -433,6 +434,11 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>>>       tzd->ops->get_temp = of_thermal_get_temp;
>>>       tzd->ops->get_trend = of_thermal_get_trend;
>>>
>>> +     if (force_interrupts) {
>>> +             tz->passive_delay = 0;
>>> +             tz->polling_delay = 0;
>>> +     }
>>> +
>>>       /*
>>>        * The thermal zone core will calculate the window if they have set the
>>>        * optional set_trips pointer.
>>> @@ -486,6 +492,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>>>  {
>>>       struct device_node *np, *child, *sensor_np;
>>>       struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
>>> +     bool force_interrupts = false;
>>>
>>>       np = of_find_node_by_name(NULL, "thermal-zones");
>>>       if (!np)
>>> @@ -498,6 +505,9 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>>>
>>>       sensor_np = of_node_get(dev->of_node);
>>>
>>> +     if (of_find_property(sensor_np, "interrupts", NULL))
>>> +             force_interrupts = true;
>>> +
>>
>> This is hackish. It does cover only DT drivers.
> 
> OK.
> 
>> It would be cleaner to add a specific flag describing the thermal sensor
>> driver mode and then in the core code do not start the timers if the
>> associated works in interrupt.
>>
>> Moreover the interrupt mode can be used to activate faster the passive
>> delay monitoring after reaching a threshold like the hikey and hikey960.
>> So this patch will disable the mitigation on those boards. This is
>> another argument to add flags for the thermal sensor mode.
>>
> 
> So each driver then needs to set this flag at interrupt registration
> time. Or do you want to set that automatically in core code with some
> wrapper function?

I'm not sure. Actually the 'mode' is now different from what we had
previously as we can use the interrupt mode and polling mode used
together, it is no longer 'enabled' / 'disabled'.

We can have the following:

 -------------------------------------------------------------
| interrupt  |  passive interrupt | polling | passive polling |
 -------------------------------------------------------------
|      X     |                    |         |        X        |
 -------------------------------------------------------------
|      X     |          X         |         |                 |
 -------------------------------------------------------------
|            |                    |    X    |        X        |
 -------------------------------------------------------------

The set_mode should be changed first in the of-thermal IMO, so we end up
with something:

#define THERMAL_DEVICE_MODE_SHUTDOWN 0x0
#define THERMAL_DEVICE_MODE_POLL 0x1
#define THERMAL_DEVICE_MODE_POLL_PASSIVE 0x2
#define THERMAL_DEVICE_MODE_INTERRUPT 0x4
#define THERMAL_DEVICE_MODE_INTERRUPT_PASSIVE 0x8

#define THERMAL_DEVICE_DISABLED THERMAL_DEVICE_MODE_SHUTDOWN
#define THERMAL_DEVICE_ENABLED
	THERMAL_DEVICE_MODE_POLL|THERMAL_DEVICE_MODE_POLL_PASSIVE

Then the function of_thermal_set_mode can be changed accordingly:

	tz->polling_delay = 0;
	tz->passive_delay = 0;

	if (mode & THERMAL_DEVICE_MODE_POLL)
		tz->polling_delay = data->polling_delay;

	if (mode & THERMAL_DEVICE_MODE_POLL_PASSIVE)
		tz->passive_delay = data->passive_delay;

Then the drivers can call the tz's set_mode callback with the right
parameter.

But as I previously commented, that will be only for DT drivers. IMHO,
it may make sense to add a mode field in the thermal_zone_device
structure and a thermal_zone_set_mode() function (and take the
opportunity to kill the set_mode callbacks in of-thermal and
acpi/thermal.c as they are pointless with the new function).

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

