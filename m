Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3661F424224
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbhJFQIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhJFQIN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 12:08:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AB8C061753
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 09:06:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m22so10464507wrb.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DwG3TKkoHLRsZlvw7J2WuNQwAH3IO2xZ0zZvAFY9XgQ=;
        b=k+RFZe1BpV83dwWJVGfEagHtyB2krN5IIqdbEPpzyfAGxITS00i5d3TdJGJWY6mBph
         +WX5+O6NaROsL26KMQxISL6DUyddqy7X1fLvugUl6lM9Gk7+7epnbFAbC4bMbUqD9BRc
         vXzJ5KAmWMIP5rAXlonYev+OGRkkURDXsfhwa6i7U80AEGFbaibpl4P6rtSeQq/i3RQp
         3wDrspfCTH5o7QzeGMAn8ebDTbdUt1bUkwcml2fXIXwbs2toRLKAoXgvmJnjNyOeaPWq
         Sj8+cn1I5OVbCGm0PriofljzgYrEFCis2muayfqh/7QvFXxSSrPJOJqqzi6HKtYNdnW3
         KT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwG3TKkoHLRsZlvw7J2WuNQwAH3IO2xZ0zZvAFY9XgQ=;
        b=GJ4OdKNMRRYVQVbSPllmFyjtU1Tva9nfm5I4xhW6ry44QvnfRSTMZ8W0+esJVUZpbz
         j7z36uX0d/N6WUCOnq2SKSW+gNEcPDu9DSEqF+hdhD1h2SJgyDN4DCindmF1dNUnrLvM
         r69oGlQrEaDOnSSECGc+bhXbgJaZhOrhlouxWoIZBeoIFJ8Xk8rKGPFYCbgp2vdw5jwu
         QHq3C8fOC600UySszO3Dw+jGP2P6BfJ832auNYQ4wjwFjHc4DtFXI0fYCfufrmHI7t0p
         FJm6+4kxarSE68yrkYdiWsMm+L1FOQ83HqddqHnHUs5fYvtD91pturrqXdWrr2qVgpWE
         VxwA==
X-Gm-Message-State: AOAM531dgeklsRVU1a/WbY7IYz1J2PQfQ3BeXBewLQo8O+h8IC2wa1wp
        Dq8nhqCAkw48W3wE02yDeYKhmg==
X-Google-Smtp-Source: ABdhPJyCI8J8kbe+yRhuWdSFRn82emOQeO0b0YLL3GukKT0eMyt25B4SvjwIlqJ6k6XDUyW8OYu58Q==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr1878130wrs.84.1633536379085;
        Wed, 06 Oct 2021 09:06:19 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:278:1f59:2992:87fe? ([2a01:e34:ed2f:f020:278:1f59:2992:87fe])
        by smtp.googlemail.com with ESMTPSA id y8sm17477131wrr.21.2021.10.06.09.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 09:06:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20210917072732.611140-1-abailon@baylibre.com>
 <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
 <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
 <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com>
 <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
 <4446577e-c7fa-daeb-e0fe-8a530633ef5d@baylibre.com>
 <d24ce6ec-eced-4e16-eb59-7c87f596ccca@linaro.org>
 <CAJZ5v0iJCS+nRcnHXiprtJsBf6Q4=k4TFcUV2ma_GiK=MttFug@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <03aeb132-bc0c-93f7-c7db-8575a665d2a7@linaro.org>
Date:   Wed, 6 Oct 2021 18:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iJCS+nRcnHXiprtJsBf6Q4=k4TFcUV2ma_GiK=MttFug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/10/2021 18:45, Rafael J. Wysocki wrote:
> On Mon, Oct 4, 2021 at 3:42 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 04/10/2021 12:24, Alexandre Bailon wrote:
>>>
>>> On 9/22/21 10:10 AM, Daniel Lezcano wrote:
>>>> On 20/09/2021 15:12, Alexandre Bailon wrote:
>>>>> On 9/17/21 4:03 PM, Daniel Lezcano wrote:
>>>>>> On 17/09/2021 15:33, Alexandre Bailon wrote:
>>>>>>> Hi Daniel,
>>>>>>>
>>>>>>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
>>>>>>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
>>>>>>>>> This series add a virtual thermal sensor.
>>>>>>>>> It could be used to get a temperature using some thermal sensors.
>>>>>>>>> Currently, the supported operations are max, min and avg.
>>>>>>>>> The virtual sensor could be easily extended to support others
>>>>>>>>> operations.
>>>>>>>>>
>>>>>>>>> Note:
>>>>>>>>> Currently, thermal drivers must explicitly register their sensors to
>>>>>>>>> make them
>>>>>>>>> available to the virtual sensor.
>>>>>>>>> This doesn't seem a good solution to me and I think it would be
>>>>>>>>> preferable to
>>>>>>>>> update the framework to register the list of each available sensors.
>>>>>>>> Why must the drivers do that ?
>>>>>>> Because there are no central place where thermal sensor are
>>>>>>> registered.
>>>>>>> The only other way I found was to update thermal_of.c,
>>>>>>> to register the thermal sensors and make them available later to the
>>>>>>> virtual thermal sensor.
>>>>>>>
>>>>>>> To work, the virtual thermal need to get the sensor_data the ops from
>>>>>>> the thermal sensor.
>>>>>>> And as far I know, this is only registered in thermal_of.c, in the
>>>>>>> thermal zone data
>>>>>>> but I can't access it directly from the virtual thermal sensor.
>>>>>>>
>>>>>>> How would you do it ?
>>>>>> Via the phandles when registering the virtual sensor ?
>>>>> As far I know, we can't get the ops or the sensor_data from the phandle
>>>>> of a thermal sensor.
>>>>> The closest solution I found so far would be to aggregate the thermal
>>>>> zones instead of thermal sensors.
>>>>> thermal_zone_device has the data needed and a thermal zone could be find
>>>>> easily using its name.
>>>> Yeah, the concept of the thermal zone and the sensor are very close.
>>>>
>>>> There is the function in thermal_core.h:
>>>>
>>>>   -> for_each_thermal_zone()
>>>>
>>>> You should be able for each 'slave' sensor, do a lookup to find the
>>>> corresponding thermal_zone_device_ops.
>>>>
>>>>> But, using a thermal_zone_device, I don't see how to handle module
>>>>> unloading.
>>>> I think try_module_get() / module_put() are adequate for this situation
>>>> as it is done on an external module and we can not rely on the exported
>>>> symbols.
>>> I don't see how it would be possible to use these functions.
>>> The thermal zone doesn't have the data required to use it.
>>
>> Actually I was able to crash the kernel by doing:
>>
>> console 1:
>>
>> while $(true); do insmod <module> && rmmod <module>; done
>>
>> console 2:
>>
>> while $(true); cat /sys/class/thermal/thermal_zone0/temp; done
>>
>> So there is something wrong already in the thermal framework.
> 
> Hmmm.
> 
>> IMO, the first thing would be to fix this critical issue by getting the
>> sensor module refcount when the thermal zone is enabled and dropping it
>> when it is disabled.
>>
>> With that fixed, perhaps it will possible to get the device associated
>> with the sensor and then try_module_get(dev->driver->owner)
>>
>>> Maybe a more easier way is to use the thermal_zone_device mutex.
>>> If I get a lock before to use the thermal_zone_device ops, I have the
>>> guaranty that module won't be unloaded.
> 
> That would be my approach too.

The mutex is private to the thermal core. The virtual sensor should not
touch it :/

Perhaps, it can work with a private spin_lock with a try_spinlock() ?

>>> When a "thermal of sensor" is unloaded, it calls
>>> thermal_zone_of_sensor_unregister which takes a lock before
>>> update ops.
>>
>> I'm not sure to understand. The goal is to have the refcount on the
>> modules to be incremented when the virtual sensor is using them.
> 
> IMO the goal is to prevent the code from crashing when modules get
> unloaded.  I'm not really sure if refcounts alone are sufficient for
> that.

The problem is in the loop:

+static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
+{
+	struct virtual_thermal_sensor *sensor = data;
+	int max_temp = INT_MIN;
+	int temp;
+	int i;
+
+	for (i = 0; i < sensor->count; i++) {
+		struct thermal_sensor_data *hw_sensor;
+
+		hw_sensor = &sensor->sensors[i];
+		if (!hw_sensor->ops)
+			return -ENODEV;
+
+		hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
+		max_temp = sensor->aggr_temp(max_temp, temp);
+	}
+
+	*temperature = max_temp;
+
+	return 0;
+}

If one of the sensor is unloaded when get_temp is called,
hw_sensor->ops->get_temp will crash.

So the proposal is virtual_sensor_add_sensor() does try_get_module()
and virtual_sensor_remove_sensor() does put_module().

The ref on the 'slave' modules will be release only if the virtual
sensor is unregistered.

So until, the virtual sensor is unregistered, the 'slaves' modules can
not be unloaded.

That is what we find with eg. the wifi modules.

>> Until the virtual sensor is registered, it will prevent the other
>> modules to be unloaded.
> 
> Unless they are forced to unload that is, AFAICS.
> 
> IMO it would be better to make the code survive unloading of a module.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
