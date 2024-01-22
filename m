Return-Path: <linux-pm+bounces-2508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5AC83724D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 20:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0511C2644E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE453985F;
	Mon, 22 Jan 2024 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOYx5Vzl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0D3CF50
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951146; cv=none; b=Wo9ARZgnHbhNCo4vD39scg9bjIBQPqgHD+PrtLUKxylCItH10jyCObzfMOkFlEa1c/xtToL7Uj84uXUoMAu3v49p9ItKKBHm3V7ImEnPlm9PhcnP6n969rg5kCo90F92wbYHn+wuX0D+gX90lxYoRqKPDBH0stPAzaJuC9ostyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951146; c=relaxed/simple;
	bh=XSUDgtuXxNpkhW2yDS+b0o3+89QZuDc8Zvst5IZ6b7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h51IjnRzh5aqYJxFzOjyHy+dSXlh2lEcxCCXLyLYW6YK9NM1AjqVxog5NiuBrITyBn34gAhRS+WT5d3hsWYmWMHKqk+0fLTmnfDD9tbqfVhch7AWhVqOJLHhsDOtAfE1fY2uOtygwcHDxpYle2B5sakzC8bs3GfKHH4RhY+hoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yOYx5Vzl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e9d288f45so41971755e9.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705951143; x=1706555943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9FQMVlJB1Vojg8ZPFpG9SgluDknPAojvY7olC7F2Nc=;
        b=yOYx5VzlY7Zwmv5nz2pESjJ9iJgrA6yJrjOwDqkvmTuM0XpLxRkrRCzB9zvcb7rLwz
         03uhOWxycGTrb3fYahLQMqe+fOXU7+WbVzN51LSnJ8wUBCAZhESVUJGoRmy2KlQwb/KD
         I7dy8B1Uw9kWObC8Teq5VzwdGesKWYpejrHGxgyJDGkrfDu52Aw3UZ6RbfKhU8lPctzC
         2SxBeMFk3Dm3H4D4ZtRARULJev4eH8sqLkBS3MmyOy51/4bp4aYq5lCJaeGpr87/QM1R
         QdcHfAi/t9rul1fnqiQiVRD43IzGVvVeWwAxAp2CM+296fMR9j8JQZISE2KMq7lJIvq8
         /+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951143; x=1706555943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9FQMVlJB1Vojg8ZPFpG9SgluDknPAojvY7olC7F2Nc=;
        b=McyynRjEFIpEuxIakyG2Kw2367OCrl/ygz7DAn2SGumfCm8CfcRTUUBcNLwu6IOusq
         JYDnz/P+EzarKU6GtAu0LJVQFXj1uXfJvIhqhM6ZdyKweIXIi9abgnlE47mBlZm6zThG
         FhG34hMEb+gmlxZhXamXIu+pqCYdIp399l0e+2HV1EByH99JtB1/gXUxTXE7zPlTuMaz
         i8bUwzB0AjQDxc+PKijafMmemg89B7mcQ0efG54tdshzqkurgCJwEqWw4LIpPoH0ePsR
         KUK987x3bGY73gho2YrCLQIK/kqb72bxq74ZfHJiVJI+5OW4gV0tVekhTHCOWdA9ZYFf
         YZ8g==
X-Gm-Message-State: AOJu0YzL7ia/b8FSItlbeLoYr5iLyTtdVSnjjD7OPQbZO9hVDzncV/gg
	GatNqDxpxXsOrzNx0I0ZnTGeQjVndJe3KQ/wai1bxg71QYpLTIRblxhCICYO000=
X-Google-Smtp-Source: AGHT+IH63xUnqFx6Z8kjFRhgveuot8biTbbHDjUQoc3HRtf8IvAhFj0ksGtyE6jCdAKoz2grUUsn9A==
X-Received: by 2002:a1c:4c02:0:b0:40e:5f22:3d1b with SMTP id z2-20020a1c4c02000000b0040e5f223d1bmr1706026wmf.72.1705951142552;
        Mon, 22 Jan 2024 11:19:02 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k23-20020a05600c0b5700b0040e596320bfsm4080165wmr.0.2024.01.22.11.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 11:19:02 -0800 (PST)
Message-ID: <45c3a83f-b049-4ef8-9406-84c149f61667@linaro.org>
Date: Mon, 22 Jan 2024 20:19:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/26] thermal: Introduce
 thermal_zone_device_register() and params structure
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
 <20231221124825.149141-2-angelogioacchino.delregno@collabora.com>
 <7417c498-2439-485d-9f78-fbb22f9ce393@linaro.org>
 <33c7d36d-c2f5-477f-946a-6ad926a277d7@collabora.com>
 <9783d2a6-7395-4516-9fd1-d7c42ea35d07@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9783d2a6-7395-4516-9fd1-d7c42ea35d07@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/01/2024 10:39, AngeloGioacchino Del Regno wrote:
> Il 16/01/24 10:58, AngeloGioacchino Del Regno ha scritto:
>> Il 15/01/24 13:39, Daniel Lezcano ha scritto:
>>> On 21/12/2023 13:48, AngeloGioacchino Del Regno wrote:
>>>> In preparation for extending the thermal zone devices to actually have
>>>> a name and disambiguation of thermal zone types/names, introduce a new
>>>> thermal_zone_device_params structure which holds all of the parameters
>>>> that are necessary to register a thermal zone device, then add a new
>>>> function thermal_zone_device_register().
>>>>
>>>> The latter takes as parameter the newly introduced structure and is
>>>> made to eventually replace all usages of the now deprecated function
>>>> thermal_zone_device_register_with_trips() and of
>>>> thermal_tripless_zone_device_register().
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>   drivers/thermal/thermal_core.c | 27 +++++++++++++++++++++++++++
>>>>   include/linux/thermal.h        | 33 +++++++++++++++++++++++++++++++++
>>>>   2 files changed, 60 insertions(+)
>>>>
>>>> diff --git a/drivers/thermal/thermal_core.c 
>>>> b/drivers/thermal/thermal_core.c
>>>> index e5434cdbf23b..6be508eb2d72 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -1235,6 +1235,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>>>>    *           whether trip points have been crossed (0 for interrupt
>>>>    *           driven systems)
>>>>    *
>>>> + * This function is deprecated. See thermal_zone_device_register().
>>>> + *
>>>>    * This interface function adds a new thermal zone device (sensor) to
>>>>    * /sys/class/thermal folder as thermal_zone[0-*]. It tries to 
>>>> bind all the
>>>>    * thermal cooling devices registered at the same time.
>>>> @@ -1409,6 +1411,7 @@ thermal_zone_device_register_with_trips(const 
>>>> char *type, struct thermal_trip *t
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
>>>> +/* This function is deprecated. See thermal_zone_device_register(). */
>>>>   struct thermal_zone_device *thermal_tripless_zone_device_register(
>>>>                       const char *type,
>>>>                       void *devdata,
>>>> @@ -1420,6 +1423,30 @@ struct thermal_zone_device 
>>>> *thermal_tripless_zone_device_register(
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
>>>> +/**
>>>> + * thermal_zone_device_register() - register a new thermal zone device
>>>> + * @tzdp:    Parameters of the new thermal zone device
>>>> + *        See struct thermal_zone_device_register.
>>>> + *
>>>> + * This interface function adds a new thermal zone device (sensor) to
>>>> + * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind 
>>>> all the
>>>> + * thermal cooling devices registered at the same time.
>>>> + * thermal_zone_device_unregister() must be called when the device 
>>>> is no
>>>> + * longer needed. The passive cooling depends on the .get_trend() 
>>>> return value.
>>>> + *
>>>> + * Return: a pointer to the created struct thermal_zone_device or an
>>>> + * in case of error, an ERR_PTR. Caller must check return value with
>>>> + * IS_ERR*() helpers.
>>>> + */
>>>> +struct thermal_zone_device *thermal_zone_device_register(struct 
>>>> thermal_zone_device_params *tzdp)
>>>> +{
>>>> +    return thermal_zone_device_register_with_trips(tzdp->type, 
>>>> tzdp->trips, tzdp->num_trips,
>>>> +                               tzdp->mask, tzdp->devdata, tzdp->ops,
>>>> +                               &tzdp->tzp, tzdp->passive_delay,
>>>> +                               tzdp->polling_delay);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(thermal_zone_device_register);
>>>> +
>>>>   void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
>>>>   {
>>>>       return tzd->devdata;
>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>> index 98957bae08ff..c6ed33a7e468 100644
>>>> --- a/include/linux/thermal.h
>>>> +++ b/include/linux/thermal.h
>>>> @@ -258,6 +258,33 @@ struct thermal_zone_params {
>>>>       int offset;
>>>>   };
>>>> +/**
>>>> + * struct thermal_zone_device_params - parameters for a thermal 
>>>> zone device
>>>> + * @type:        the thermal zone device type
>>>> + * @tzp:        thermal zone platform parameters
>>>> + * @ops:        standard thermal zone device callbacks
>>>> + * @devdata:        private device data
>>>> + * @trips:        a pointer to an array of thermal trips, if any
>>>> + * @num_trips:        the number of trip points the thermal zone 
>>>> support
>>>> + * @mask:        a bit string indicating the writeablility of trip 
>>>> points
>>>> + * @passive_delay:    number of milliseconds to wait between polls 
>>>> when
>>>> + *            performing passive cooling
>>>> + * @polling_delay:    number of milliseconds to wait between polls 
>>>> when checking
>>>> + *            whether trip points have been crossed (0 for interrupt
>>>> + *            driven systems)
>>>> + */
>>>> +struct thermal_zone_device_params {
>>>> +    const char *type;
>>>> +    struct thermal_zone_params tzp;
>>>> +    struct thermal_zone_device_ops *ops;
>>>> +    void *devdata;
>>>> +    struct thermal_trip *trips;
>>>> +    int num_trips;
>>>> +    int mask;
>>>> +    int passive_delay;
>>>> +    int polling_delay;
>>>> +};
>>>
>>>  From my POV, this "struct thermal_zone_params" has been always a 
>>> inadequate and catch-all structure. It will confuse with 
>>> thermal_zone_device_params
>>>
>>> I suggest to cleanup a bit that by sorting the parameters in the 
>>> right structures where the result could be something like:
>>>
>>> eg.
>>>
>>> struct thermal_zone_params {
>>>
>>>      const char *type;
>>>      struct thermal_zone_device_ops *ops;
>>>      struct thermal_trip *trips;
>>>      int num_trips;
>>>
>>>      int passive_delay;
>>>      int polling_delay;
>>>
>>>      void *devdata;
>>>          bool no_hwmon;
>>> };
>>>
>>> struct thermal_governor_ipa_params {
>>>          u32 sustainable_power;
>>>          s32 k_po;
>>>          s32 k_pu;
>>>          s32 k_i;
>>>          s32 k_d;
>>>          s32 integral_cutoff;
>>>          int slope;
>>>          int offset;
>>> };
>>>
>>> struct thermal_governor_params {
>>>      char governor_name[THERMAL_NAME_LENGTH];
>>>      union {
>>>          struct thermal_governor_ipa_params ipa_params;
>>>      };
>>> };
>>>
>>> struct thermal_zone_device_params {
>>>      struct thermal_zone_params *tzp;
>>>      struct thermal_governor_params *tgp;
>>> }
>>>
>>> No functional changes just code reorg, being a series to be submitted 
>>> before the rest on these RFC changes (2->26)
>>>
>>
>> Could work. It's true that thermal_zone_params is a catch-all 
>> structure, and it's
>> not really the best... but I also haven't checked how complex and/or 
>> how much time
>> would your proposed change take.
>>
>> Shouldn't take much as far as I can foresee, but I really have to 
>> check a bit.
>> If I'm right as in it's not something huge, the next series will 
>> directly have
>> this stuff sorted - if not, I'll reach to you.
>>
> 
> So... I've checked the situation and coded some.
> 
> I came to the conclusion that doing it as suggested is possible but 
> realistically
> suboptimal, because that will need multiple immutable branches to 
> actually end up
> in upstream as changes would otherwise break kernel build.
> 
> Then, here I am suggesting a different way forward, while still 
> performing this
> much needed cleanup and reorganization:
> 
> First, we introduce thermal_zone_device_register() and params structure 
> with
> this commit, which will have
> 
> /* Structure to define Thermal Zone parameters */
> struct thermal_zone_params {
>      /* Scheduled for removal - see struct thermal_zone_governor_params. */
>      char governor_name[THERMAL_NAME_LENGTH];

Take the opportunity to introduce a patch before doing a change to:

	const char *governor_name;

AFAICS, there is no place in the kernel where it is not a const char * 
assignation which is by the way wrong:

	char governor_name[THERMAL_NAME_LENGTH];
	governor_name = "step_wise";

	:)

>      /* Scheduled for removal - see struct thermal_zone_governor_params. */
>      bool no_hwmon;
> 
>      /*
>       * Sustainable power (heat) that this thermal zone can dissipate in
>       * mW
>       */
>      u32 sustainable_power;
> 
>      /*
>       * Proportional parameter of the PID controller when
>       * overshooting (i.e., when temperature is below the target)
>       */
>      s32 k_po;
> 
>      /*
>       * Proportional parameter of the PID controller when
>       * undershooting
>       */
>      s32 k_pu;
> 
>      /* Integral parameter of the PID controller */
>      s32 k_i;
> 
>      /* Derivative parameter of the PID controller */
>      s32 k_d;
> 
>      /* threshold below which the error is no longer accumulated */
>      s32 integral_cutoff;
> 
>      /*
>       * @slope:    slope of a linear temperature adjustment curve.
>       *         Used by thermal zone drivers.
>       */
>      int slope;
>      /*
>       * @offset:    offset of a linear temperature adjustment curve.
>       *         Used by thermal zone drivers (default 0).
>       */
>      int offset;
> };
> 
> struct thermal_governor_params {
>      char governor_name[THERMAL_NAME_LENGTH];

	const char *governor_name;

>      struct thermal_zone_params ipa_params;
> };
> 
> struct thermal_zone_platform_params {

The name sounds inadequate.

May be just thermal_zone_params ?

>      const char *type;
>      struct thermal_zone_device_ops *ops;

Move the ops in the thermal_zone_device_params

>      struct thermal_trip *trips;
>      int num_trips;
>      int mask;
> 
>      int passive_delay;
>      int polling_delay;
> 
>      void *devdata;

And devdata also in the thermal_zone_device_params

>      bool no_hwmon;
> };
> 
> 
> struct thermal_zone_device_params {
>      struct thermal_zone_platform_params tzp;
>      struct thermal_governor_params *tgp;
> };
> 
> (Note that the `no_hwmon` and `governor_name` are *temporarily* 
> duplicated, but
> there are good reasons to do that!)
> 
> Drivers will follow with the migration to `thermal_zone_device_register()`,
> and that will be done *strictly* like so:
> 
> struct thermal_zone_device_params tzdp = {
>      .tzp = {
>          .type = "acerhdf",
>          .tzp = { .governor_name = "bang_bang" },
>          .ops = &acerhdf_dev_ops,
>          .trips = trips,
>          .num_trips = ARRAY_SIZE(trips),
>          .polling_delay = kernelmode ? interval * 1000 : 0,
>          /* devdata, no_hwmon go here later in the code */
>      },
>      .tgp = { .governor_name = "bang_bang" }
> };
> 
> Notice how in this case we're never *ever* referencing to any struct name,
> apart from struct thermal_zone_device_params (meaning, I'm never creating
> vars/pointers to struct thermal_zone_platform_params).
> 
> If we follow this style, at least temporarily and at least during this 
> cleanup,
> we will end up with a plan such that:
> 
> 1. In the first merge window:
>     - Drivers get migrated to thermal_zone_device_register()
>     - Functions register_with_trips()/tripless get deprecated but not 
> yet removed
 >
> 2. In the next merge window (expecting all users updated from the first 
> window):
>     - Functions register_with_trips/tripless get removed (<- no more 
> external refs
>       to struct thermal_zone_params, which can be then safely renamed!)
>     - Duplicated members governor_name and no_hwmon get removed from
>       struct thermal_zone_params
>     - Some structures get renamed to give them the proposed better names 
> (which
>       I also genuinely like)
>     - Only Thermal API internal changes, as users (all the ones that are 
> not in
>       drivers/thermal/) won't need to get updated at all!
>       ... and that's why I said "strictly like so" in the example up there.
> 
> I think that this is the best strategy, for both ease of merging the 
> changes and
> internal reorganization.
> 
> Sure in the first merge window we'll be wasting a byte or two, but I am 
> confident
> in that this is a very low price to pay - and even better, only 
> temporarily - for
> other bigger benefits.
> 
> What do you think?

Sounds like a plan :)



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


