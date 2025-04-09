Return-Path: <linux-pm+bounces-25021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F686A82C24
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 18:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD7F1893B68
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F672641C6;
	Wed,  9 Apr 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KkiOXpox"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB125E801
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215183; cv=none; b=kzcdXJ+cyPzBax9NEAGz1ly7ySZU4z3ASIuTTtlq/W+9L2ejUqx5cGnwGWpOlNdDJJpB3Z9Nyt2D1AJy7US0nERQdImEdi2jVjkXlv+X8HjjonG7732Fdx7HzW99zuizx00XNh2Gr02zEVxnQoo/bMNn3Je3LO1TIQzv8rxnbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215183; c=relaxed/simple;
	bh=g4sPkyUfQbqmXduEIf7ptrQ33g79m+Ssct92jkbx3fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpbWiNrfIPJU5wRCkkHsp+fRHxUhhr3OFSM2loer+WjHRnuYM6ZZ+XDg0h2xIlfyJ9K0kjRgA+yg66BwIJmuWG83TzdAm0bMwhDgZPaBfR1/pZxtmlQTcLOTRIQkQhFlb9b3m8htATs5ZmwfxZTob1bxDhiecuNdLMH2bETe1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KkiOXpox; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so6973985e9.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Apr 2025 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1744215178; x=1744819978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sKt23q2aQtmSrPCYvx6HeAh8otmPNdy3C8vHeYH6wc=;
        b=KkiOXpoxYyU3fYzfwhNApKAzUJIkBfwUt8TifUQal4wKZR2k+xfnnOiS02Tp5tY2Sd
         xNXdEx/nJ+UQLRnh61DVHmI3pUxk5r1EFUdhbz95qHW5YY8IcM4f3UmWUk0OyM87Lxvc
         Q5nZTcCYXBGCOcUKp1YHoFmxNQ/5Rmky+uLYLhXWKXaDb+TaF5WSvUTPKR21levjfT/B
         mrd9Y+Dkrz/FyO2ntKkqsAaicYYrUpmmlmygEPbpc8B+UIhe9IGesfKt86vQ//vUvEcR
         7Lq/5mVmCtPel/KaJEMdg996JdM/SuhK4M1SO8wItJBYG7HmgBggOt1mVgFGTlbRKPlY
         q44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744215178; x=1744819978;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sKt23q2aQtmSrPCYvx6HeAh8otmPNdy3C8vHeYH6wc=;
        b=Buol85OrRhXazVm1RHKSECbY2vgrZeFXXc0+DiTOd4dupxFNzjuHuPcthC4It2QMYD
         DGdK+Lyycq8j4Vl4eGTdY008SEzKa0G5icVtHdN0nM0tg9gJqqmfeQv0pOaTa0ggddAy
         V7arhi+YC3odJPdDGN9udYhNuuVqCtx9JryY3g6fYEblzfubHGhNwyyT354gZvoCFSdy
         AeLZCO9b06ZI/iJObxQKUDSnohbhB7xu1MLsnD3mxm7G2UwLEZXxbS65mA0azQn0T66d
         XSwAiIDckJS9+KTnkTs1IeV5OfA5TTOXStg7rqXsJHvT5F48qY2MHnyx9vHsbvG3JRc8
         kEOg==
X-Forwarded-Encrypted: i=1; AJvYcCXvj+2KwsoqVKuYhB879Wh5aEiySQ8GNFYyNvqgsok+H3w9gWy7WPexWBeem/yPwwHl42CGatPMVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyENGMWUEjhuPdPuO0B4/VAR+TfncvPjQe+AUVuhra7be9dg9kL
	rnTJldEKhKD0gOPylebC+nKbD81rqOkr2WHwqUpXYTYFbWPsnfy7PD5IbIuuER0=
X-Gm-Gg: ASbGncsuw8KWTNZIKSKn6RoIDeQdtysRJTIRvP1Vtr+1mSI6usMWPvbzwZDZVAQ5Ps9
	0vDBRTrQKjL0B4mtHcIgvhH5m+3ccR2KC98aTvHTM4AzBTy8ePh9h0q6GTLJWv92QVwwKsdEkOW
	JRWA3GmNFz6ajbRq9rd6QqynfPJ0QBgGJTt0KZa0HethJOb/M/vyROnGtVqIVzeMQj6bocc4/yJ
	gPzd9JK1INyah1GJTopb0SyLXc+4UX40MxGe/Uj+KyidgJycfDuBQTS1XcaXY6bRoYKpTJxuSn9
	p08DCL/JU80e86f/4/mGkI576Ns4sAiHfbQWoV60Cz+1PrmuLWB3GN2mk+4=
X-Google-Smtp-Source: AGHT+IEY3oLmF7VcjnruHjGtnDoJJv8mz1b2Hq5Ozgdhln6XAv+aAD3h2eFvJP3GOUFwt2xhYEhXZQ==
X-Received: by 2002:a7b:c44d:0:b0:43c:ec72:3daf with SMTP id 5b1f17b1804b1-43f0e6496b5mr70904115e9.14.1744215177772;
        Wed, 09 Apr 2025 09:12:57 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc99sm24579475e9.29.2025.04.09.09.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 09:12:57 -0700 (PDT)
Message-ID: <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
Date: Wed, 9 Apr 2025 19:12:56 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org,
 ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 geert@linux-m68k.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
 <2025021539-untrained-prompter-a48f@gregkh>
 <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
 <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
 <20250305140309.744866b2@jic23-huawei> <Z8k8lDxA53gUJa0n@google.com>
 <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
 <20250330163129.02f24afb@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250330163129.02f24afb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Rafael,

On 30.03.2025 18:31, Jonathan Cameron wrote:
> On Thu, 27 Mar 2025 18:47:53 +0200
> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> 
>> Hi, Rafael,
>>
>> On 06.03.2025 08:11, Dmitry Torokhov wrote:
>>> On Wed, Mar 05, 2025 at 02:03:09PM +0000, Jonathan Cameron wrote:  
>>>> On Wed, 19 Feb 2025 14:45:07 +0200
>>>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>>>  
>>>>> Hi, Daniel, Jonathan,
>>>>>
>>>>> On 15.02.2025 15:51, Claudiu Beznea wrote:  
>>>>>> Hi, Greg,
>>>>>>
>>>>>> On 15.02.2025 15:25, Greg KH wrote:    
>>>>>>> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:    
>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>
>>>>>>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
>>>>>>>> clocks are managed through PM domains. These PM domains, registered on
>>>>>>>> behalf of the clock controller driver, are configured with
>>>>>>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
>>>>>>>> clocks are enabled/disabled using runtime PM APIs. The power domains may
>>>>>>>> also have power_on/power_off support implemented. After the device PM
>>>>>>>> domain is powered off any CPU accesses to these domains leads to system
>>>>>>>> aborts.
>>>>>>>>
>>>>>>>> During probe, devices are attached to the PM domain controlling their
>>>>>>>> clocks and power. Similarly, during removal, devices are detached from the
>>>>>>>> PM domain.
>>>>>>>>
>>>>>>>> The detachment call stack is as follows:
>>>>>>>>
>>>>>>>> device_driver_detach() ->
>>>>>>>>   device_release_driver_internal() ->
>>>>>>>>     __device_release_driver() ->
>>>>>>>>       device_remove() ->
>>>>>>>>         platform_remove() ->
>>>>>>>> 	  dev_pm_domain_detach()
>>>>>>>>
>>>>>>>> During driver unbind, after the device is detached from its PM domain,
>>>>>>>> the device_unbind_cleanup() function is called, which subsequently invokes
>>>>>>>> devres_release_all(). This function handles devres resource cleanup.
>>>>>>>>
>>>>>>>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
>>>>>>>> cleanup process triggers the action or reset function for disabling runtime
>>>>>>>> PM. This function is pm_runtime_disable_action(), which leads to the
>>>>>>>> following call stack of interest when called:
>>>>>>>>
>>>>>>>> pm_runtime_disable_action() ->
>>>>>>>>   pm_runtime_dont_use_autosuspend() ->
>>>>>>>>     __pm_runtime_use_autosuspend() ->
>>>>>>>>       update_autosuspend() ->
>>>>>>>>         rpm_idle()
>>>>>>>>
>>>>>>>> The rpm_idle() function attempts to resume the device at runtime. However,
>>>>>>>> at the point it is called, the device is no longer part of a PM domain
>>>>>>>> (which manages clocks and power states). If the driver implements its own
>>>>>>>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
>>>>>>>> driver - while also relying on the power domain subsystem for power
>>>>>>>> management, rpm_idle() will invoke the driver's runtime PM API. However,
>>>>>>>> since the device is no longer part of a PM domain at this point, the PM
>>>>>>>> domain's runtime PM APIs will not be called. This leads to system aborts on
>>>>>>>> Renesas SoCs.
>>>>>>>>
>>>>>>>> Another identified case is when a subsystem performs various cleanups
>>>>>>>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
>>>>>>>> A known example is the thermal subsystem, which may call driver-specific
>>>>>>>> APIs to disable the thermal device. The relevant call stack in this case
>>>>>>>> is:
>>>>>>>>
>>>>>>>> device_driver_detach() ->
>>>>>>>>   device_release_driver_internal() ->
>>>>>>>>     device_unbind_cleanup() ->
>>>>>>>>       devres_release_all() ->
>>>>>>>>         devm_thermal_of_zone_release() ->
>>>>>>>> 	  thermal_zone_device_disable() ->
>>>>>>>> 	    thermal_zone_device_set_mode() ->
>>>>>>>> 	      struct thermal_zone_device_ops::change_mode()
>>>>>>>>
>>>>>>>> At the moment the driver-specific change_mode() API is called, the device
>>>>>>>> is no longer part of its PM domain. Accessing its registers without proper
>>>>>>>> power management leads to system aborts.
>>>>>>>>
>>>>>>>> Open a devres group before calling the driver probe, and close it
>>>>>>>> immediately after the driver remove function is called and before
>>>>>>>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
>>>>>>>> reset functions are executed immediately after the driver remove function
>>>>>>>> completes. Additionally, it prevents driver-specific runtime PM APIs from
>>>>>>>> being called when the device is no longer part of its power domain.
>>>>>>>>
>>>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Hi,  
>>>>
>>>> Hi Claudiu, Greg,
>>>>
>>>> Sorry, I missed this thread whilst travelling and only saw it because
>>>> of reference from the in driver solution.
>>>>  
>>>>>>>>
>>>>>>>> Although Ulf gave its green light for the approaches on both IIO [1],
>>>>>>>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
>>>>>>>> approaches in [1], [2] as he considered it may lead to dificult to
>>>>>>>> maintain code and code opened to subtle bugs (due to the potential of
>>>>>>>> mixing devres and non-devres calls). He pointed out a similar approach
>>>>>>>> that was done for the I2C bus [4], [5].
>>>>>>>>
>>>>>>>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
>>>>>>>> patch tries to revive it by proposing a similar approach that was done
>>>>>>>> for the I2C bus.
>>>>>>>>
>>>>>>>> Please let me know you input.    
>>>>>>>
>>>>>>> I'm with Jonathan here, the devres stuff is getting crazy here and you
>>>>>>> have drivers mixing them and side affects happening and lots of
>>>>>>> confusion.  Your change here is only going to make it even more
>>>>>>> confusing, and shouldn't actually solve it for other busses (i.e. what
>>>>>>> about iio devices NOT on the platform bus?)    
>>>>
>>>> In some cases they are already carrying the support as per the link
>>>> above covering all i2c drivers.  I'd like to see a generic solution and
>>>> I suspect pushing it to the device drivers rather than the bus code
>>>> will explode badly and leave us with subtle bugs where people don't
>>>> realise it is necessary. 
>>>>
>>>> https://lore.kernel.org/all/20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com/
>>>> is a lot nastier looking than what we have here. I'll review that in a minute
>>>> to show that it need not be that bad, but none the less not pleasant.
>>>>
>>>> +CC linux-iio to join up threads and Dmitry wrt to i2c case (and HID that does
>>>> similar)  
>>>
>>> We should not expect individual drivers handle this, because this is a
>>> layering violation: they need to know implementation details of the bus
>>> code to know if the bus is using non-devres managed resources, and
>>> adjust their behavior. Moving this into driver core is also not
>>> feasible, as not all buses need it. So IMO this should belong to
>>> individual bus code.
>>>
>>> Instead of using devres group a bus may opt to use
>>> devm_add_action_or_reset() and other devm APIs to make sure bus'
>>> resource unwinding is carried in the correct order relative to freeing
>>> driver-owned resources.  
>>
>> Can you please let us know your input on the approach proposed in this
>> patch? Or if you would prefer devm_add_action_or_reset() as suggested by
>> Dmitry? Or if you consider another approach would fit better?
>>
>> Currently there were issues identified with the rzg2l-adc driver (driver
>> based solution proposed in [1]) and with the rzg3s thermal driver (solved
>> by function rzg3s_thermal_probe() from [2]).
>>
>> As expressed previously by Jonathan and Dimitry this is a common problem
>> and as the issue is due to a call in the bus driver, would be better and
>> simpler to handle it in the bus driver. Otherwise, individual drivers would
>> have to be adjusted in a similar way.
>>
> 
> Rafael,
> 
> Greg suggested we ask for your input on the right option:
> 
> https://lore.kernel.org/all/2025032703-genre-excitable-9473@gregkh/
> (that thread has the other option).

Can you please let us know your opinion on this?

Thank you,
Claudiu

> 
> Jonathan
> 
>> Thank you,
>> Claudiu
>>
>> [1]
>> https://lore.kernel.org/all/20250324122627.32336-2-claudiu.beznea.uj@bp.renesas.com/
>> [2]
>> https://lore.kernel.org/all/20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com/
>>
>>>   
>>>>  
>>>>>>
>>>>>> You're right, other busses will still have this problem.
>>>>>>     
>>>>>>>
>>>>>>> Why can't your individual driver handle this instead?    
>>>>
>>>> In my mind because it's the bus code that is doing the unexpected part by
>>>> making calls in the remove path that are effectively not in the same order
>>>> as probe because they occur between driver remove and related devres cleanup
>>>> for stuff registered in probe.
>>>>  
>>>>>>
>>>>>> Initially I tried it at the driver level by using non-devres PM runtime
>>>>>> enable API but wasn't considered OK by all parties.
>>>>>>
>>>>>> I haven't thought about having devres_open_group()/devres_close_group() in
>>>>>> the driver itself but it should work.    
>>>>>
>>>>> Are you OK with having the devres_open_group()/devres_close_group() in the
>>>>> currently known affected drivers (drivers/iio/adc/rzg2l_adc.c and the
>>>>> proposed drivers/thermal/renesas/rzg3s_thermal.c [1]) ?  
>>>>
>>>> I guess it may be the best of a bunch of not particularly nasty solutions...  
>>>
>>> We need to update _ALL_ platform drivers using devm then, and this is
>>> clearly not scalable.
>>>
>>> Thanks.
>>>   
>>
> 


