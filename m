Return-Path: <linux-pm+bounces-2554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46F838CAC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 11:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1F31F21D72
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640D5C906;
	Tue, 23 Jan 2024 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cexv6yS4"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357459B57;
	Tue, 23 Jan 2024 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007487; cv=none; b=klHbUECgOEHHHcxGzlBddAzDoumUDAx7h2wykzUC/lCNv1pJSHqNPiiFdYsdr0Bz/oYhNlcMoH/znAvhL3LO6qVKotkwks1tOAOeYScfAGklu2dA/+ZqAGcexaBS5TFp8/HKohoEUGJbN7z0QeD3uf5msiEjYjwTse6dcOb678I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007487; c=relaxed/simple;
	bh=OhYlIvv0TdClu5WH0QRuIrrztntSFUlYkopnAOsdJtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQguF2EIkv0FbIfSdD1OnxH2WSkTDEZ1+/o/vpu0aituz/koRgX5/vDFSB0y8GcGF7m27MkWZVhR4zqqPhyUhkeV2TooTFzLeSHzNzWBLijlt1QYK7G/APcdlmNrG+VxLCdwi7khgRPLZU8duhwFR+pkR33mSwrGEAX02o+jdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cexv6yS4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706007483;
	bh=OhYlIvv0TdClu5WH0QRuIrrztntSFUlYkopnAOsdJtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cexv6yS4R3tpSbE3jKu5P24BNsKL4jw7JKBdU0ekm4MJXoDHnGlbs3uPtuUmRocji
	 YM+8WQT6BS2jIHi2gRQn9+w3aciZBx2YpT8EkcYLSpVqthJdmzO9mzGe4/2Lu9rq38
	 YbfHA8N+XV34V4U+enIw6kpt/SQwrsT++gSosmvoYYeTVgFvwHdJpt8N8t11Tpb2Ck
	 jQryl5zMnjvIXGoHxNxR7F3IrzSqmp7nHrh12zxfGGPd9IlmyuVKefZxPmzMBRY8qC
	 mzriJgCx8okQbCb+mlopGKNuqahYPx4XWN6VLcPnkO3tgsuDuYZogcIXxXubI9Ozvf
	 z21x5bDxGm55Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA9B737820AA;
	Tue, 23 Jan 2024 10:58:02 +0000 (UTC)
Message-ID: <4dd4ac79-e8bc-4d88-92d6-6061dae42092@collabora.com>
Date: Tue, 23 Jan 2024 11:58:02 +0100
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
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
 <20231221124825.149141-2-angelogioacchino.delregno@collabora.com>
 <7417c498-2439-485d-9f78-fbb22f9ce393@linaro.org>
 <33c7d36d-c2f5-477f-946a-6ad926a277d7@collabora.com>
 <9783d2a6-7395-4516-9fd1-d7c42ea35d07@collabora.com>
 <45c3a83f-b049-4ef8-9406-84c149f61667@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <45c3a83f-b049-4ef8-9406-84c149f61667@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/01/24 20:19, Daniel Lezcano ha scritto:
> On 18/01/2024 10:39, AngeloGioacchino Del Regno wrote:
>> Il 16/01/24 10:58, AngeloGioacchino Del Regno ha scritto:
>>> Il 15/01/24 13:39, Daniel Lezcano ha scritto:
>>>> On 21/12/2023 13:48, AngeloGioacchino Del Regno wrote:
>>>>> In preparation for extending the thermal zone devices to actually have
>>>>> a name and disambiguation of thermal zone types/names, introduce a new
>>>>> thermal_zone_device_params structure which holds all of the parameters
>>>>> that are necessary to register a thermal zone device, then add a new
>>>>> function thermal_zone_device_register().
>>>>>
>>>>> The latter takes as parameter the newly introduced structure and is
>>>>> made to eventually replace all usages of the now deprecated function
>>>>> thermal_zone_device_register_with_trips() and of
>>>>> thermal_tripless_zone_device_register().
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>>> <angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>>   drivers/thermal/thermal_core.c | 27 +++++++++++++++++++++++++++
>>>>>   include/linux/thermal.h        | 33 +++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 60 insertions(+)
>>>>>
>>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>>>> index e5434cdbf23b..6be508eb2d72 100644
>>>>> --- a/drivers/thermal/thermal_core.c
>>>>> +++ b/drivers/thermal/thermal_core.c
>>>>> @@ -1235,6 +1235,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>>>>>    *           whether trip points have been crossed (0 for interrupt
>>>>>    *           driven systems)
>>>>>    *
>>>>> + * This function is deprecated. See thermal_zone_device_register().
>>>>> + *
>>>>>    * This interface function adds a new thermal zone device (sensor) to
>>>>>    * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
>>>>>    * thermal cooling devices registered at the same time.
>>>>> @@ -1409,6 +1411,7 @@ thermal_zone_device_register_with_trips(const char 
>>>>> *type, struct thermal_trip *t
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
>>>>> +/* This function is deprecated. See thermal_zone_device_register(). */
>>>>>   struct thermal_zone_device *thermal_tripless_zone_device_register(
>>>>>                       const char *type,
>>>>>                       void *devdata,
>>>>> @@ -1420,6 +1423,30 @@ struct thermal_zone_device 
>>>>> *thermal_tripless_zone_device_register(
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
>>>>> +/**
>>>>> + * thermal_zone_device_register() - register a new thermal zone device
>>>>> + * @tzdp:    Parameters of the new thermal zone device
>>>>> + *        See struct thermal_zone_device_register.
>>>>> + *
>>>>> + * This interface function adds a new thermal zone device (sensor) to
>>>>> + * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
>>>>> + * thermal cooling devices registered at the same time.
>>>>> + * thermal_zone_device_unregister() must be called when the device is no
>>>>> + * longer needed. The passive cooling depends on the .get_trend() return value.
>>>>> + *
>>>>> + * Return: a pointer to the created struct thermal_zone_device or an
>>>>> + * in case of error, an ERR_PTR. Caller must check return value with
>>>>> + * IS_ERR*() helpers.
>>>>> + */
>>>>> +struct thermal_zone_device *thermal_zone_device_register(struct 
>>>>> thermal_zone_device_params *tzdp)
>>>>> +{
>>>>> +    return thermal_zone_device_register_with_trips(tzdp->type, tzdp->trips, 
>>>>> tzdp->num_trips,
>>>>> +                               tzdp->mask, tzdp->devdata, tzdp->ops,
>>>>> +                               &tzdp->tzp, tzdp->passive_delay,
>>>>> +                               tzdp->polling_delay);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(thermal_zone_device_register);
>>>>> +
>>>>>   void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
>>>>>   {
>>>>>       return tzd->devdata;
>>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>>> index 98957bae08ff..c6ed33a7e468 100644
>>>>> --- a/include/linux/thermal.h
>>>>> +++ b/include/linux/thermal.h
>>>>> @@ -258,6 +258,33 @@ struct thermal_zone_params {
>>>>>       int offset;
>>>>>   };
>>>>> +/**
>>>>> + * struct thermal_zone_device_params - parameters for a thermal zone device
>>>>> + * @type:        the thermal zone device type
>>>>> + * @tzp:        thermal zone platform parameters
>>>>> + * @ops:        standard thermal zone device callbacks
>>>>> + * @devdata:        private device data
>>>>> + * @trips:        a pointer to an array of thermal trips, if any
>>>>> + * @num_trips:        the number of trip points the thermal zone support
>>>>> + * @mask:        a bit string indicating the writeablility of trip points
>>>>> + * @passive_delay:    number of milliseconds to wait between polls when
>>>>> + *            performing passive cooling
>>>>> + * @polling_delay:    number of milliseconds to wait between polls when checking
>>>>> + *            whether trip points have been crossed (0 for interrupt
>>>>> + *            driven systems)
>>>>> + */
>>>>> +struct thermal_zone_device_params {
>>>>> +    const char *type;
>>>>> +    struct thermal_zone_params tzp;
>>>>> +    struct thermal_zone_device_ops *ops;
>>>>> +    void *devdata;
>>>>> +    struct thermal_trip *trips;
>>>>> +    int num_trips;
>>>>> +    int mask;
>>>>> +    int passive_delay;
>>>>> +    int polling_delay;
>>>>> +};
>>>>
>>>>  From my POV, this "struct thermal_zone_params" has been always a inadequate 
>>>> and catch-all structure. It will confuse with thermal_zone_device_params
>>>>
>>>> I suggest to cleanup a bit that by sorting the parameters in the right 
>>>> structures where the result could be something like:
>>>>
>>>> eg.
>>>>
>>>> struct thermal_zone_params {
>>>>
>>>>      const char *type;
>>>>      struct thermal_zone_device_ops *ops;
>>>>      struct thermal_trip *trips;
>>>>      int num_trips;
>>>>
>>>>      int passive_delay;
>>>>      int polling_delay;
>>>>
>>>>      void *devdata;
>>>>          bool no_hwmon;
>>>> };
>>>>
>>>> struct thermal_governor_ipa_params {
>>>>          u32 sustainable_power;
>>>>          s32 k_po;
>>>>          s32 k_pu;
>>>>          s32 k_i;
>>>>          s32 k_d;
>>>>          s32 integral_cutoff;
>>>>          int slope;
>>>>          int offset;
>>>> };
>>>>
>>>> struct thermal_governor_params {
>>>>      char governor_name[THERMAL_NAME_LENGTH];
>>>>      union {
>>>>          struct thermal_governor_ipa_params ipa_params;
>>>>      };
>>>> };
>>>>
>>>> struct thermal_zone_device_params {
>>>>      struct thermal_zone_params *tzp;
>>>>      struct thermal_governor_params *tgp;
>>>> }
>>>>
>>>> No functional changes just code reorg, being a series to be submitted before 
>>>> the rest on these RFC changes (2->26)
>>>>
>>>
>>> Could work. It's true that thermal_zone_params is a catch-all structure, and it's
>>> not really the best... but I also haven't checked how complex and/or how much time
>>> would your proposed change take.
>>>
>>> Shouldn't take much as far as I can foresee, but I really have to check a bit.
>>> If I'm right as in it's not something huge, the next series will directly have
>>> this stuff sorted - if not, I'll reach to you.
>>>
>>
>> So... I've checked the situation and coded some.
>>
>> I came to the conclusion that doing it as suggested is possible but realistically
>> suboptimal, because that will need multiple immutable branches to actually end up
>> in upstream as changes would otherwise break kernel build.
>>
>> Then, here I am suggesting a different way forward, while still performing this
>> much needed cleanup and reorganization:
>>
>> First, we introduce thermal_zone_device_register() and params structure with
>> this commit, which will have
>>
>> /* Structure to define Thermal Zone parameters */
>> struct thermal_zone_params {
>>      /* Scheduled for removal - see struct thermal_zone_governor_params. */
>>      char governor_name[THERMAL_NAME_LENGTH];
> 
> Take the opportunity to introduce a patch before doing a change to:
> 
>      const char *governor_name;
> 

Agreed!

> AFAICS, there is no place in the kernel where it is not a const char * assignation 
> which is by the way wrong:
> 
>      char governor_name[THERMAL_NAME_LENGTH];
>      governor_name = "step_wise";
> 
>      :)
> 
>>      /* Scheduled for removal - see struct thermal_zone_governor_params. */
>>      bool no_hwmon;
>>
>>      /*
>>       * Sustainable power (heat) that this thermal zone can dissipate in
>>       * mW
>>       */
>>      u32 sustainable_power;
>>
>>      /*
>>       * Proportional parameter of the PID controller when
>>       * overshooting (i.e., when temperature is below the target)
>>       */
>>      s32 k_po;
>>
>>      /*
>>       * Proportional parameter of the PID controller when
>>       * undershooting
>>       */
>>      s32 k_pu;
>>
>>      /* Integral parameter of the PID controller */
>>      s32 k_i;
>>
>>      /* Derivative parameter of the PID controller */
>>      s32 k_d;
>>
>>      /* threshold below which the error is no longer accumulated */
>>      s32 integral_cutoff;
>>
>>      /*
>>       * @slope:    slope of a linear temperature adjustment curve.
>>       *         Used by thermal zone drivers.
>>       */
>>      int slope;
>>      /*
>>       * @offset:    offset of a linear temperature adjustment curve.
>>       *         Used by thermal zone drivers (default 0).
>>       */
>>      int offset;
>> };
>>
>> struct thermal_governor_params {
>>      char governor_name[THERMAL_NAME_LENGTH];
> 
>      const char *governor_name;
> 
>>      struct thermal_zone_params ipa_params;
>> };
>>
>> struct thermal_zone_platform_params {
> 
> The name sounds inadequate.
> 
> May be just thermal_zone_params ?
> 

It's not the best, but the plan is to change the struct name in the second cycle,
as keeping the thermal_zone_params struct named as it is right now is essential
to avoid immutable branches.

window 1: Reorganization with temporary struct names -> no immutable branches
window 2: Cleanup and rename -> no immutable branches

Any change from the window 2 part brought to window 1 would need immutable
branches all around... so I really can't call it "thermal_zone_params" in
window 1.

Perhaps I can change the _platform_ name to something else, but still needs
to be different from "thermal_zone_params"...

>>      const char *type;
>>      struct thermal_zone_device_ops *ops;
> 
> Move the ops in the thermal_zone_device_params
> 
>>      struct thermal_trip *trips;
>>      int num_trips;
>>      int mask;
>>
>>      int passive_delay;
>>      int polling_delay;
>>
>>      void *devdata;
> 
> And devdata also in the thermal_zone_device_params
> 

Ok! :-)

>>      bool no_hwmon;
>> };
>>
>>
>> struct thermal_zone_device_params {
>>      struct thermal_zone_platform_params tzp;
>>      struct thermal_governor_params *tgp;
>> };
>>
>> (Note that the `no_hwmon` and `governor_name` are *temporarily* duplicated, but
>> there are good reasons to do that!)
>>
>> Drivers will follow with the migration to `thermal_zone_device_register()`,
>> and that will be done *strictly* like so:
>>
>> struct thermal_zone_device_params tzdp = {
>>      .tzp = {
>>          .type = "acerhdf",
>>          .tzp = { .governor_name = "bang_bang" },
>>          .ops = &acerhdf_dev_ops,
>>          .trips = trips,
>>          .num_trips = ARRAY_SIZE(trips),
>>          .polling_delay = kernelmode ? interval * 1000 : 0,
>>          /* devdata, no_hwmon go here later in the code */
>>      },
>>      .tgp = { .governor_name = "bang_bang" }
>> };
>>
>> Notice how in this case we're never *ever* referencing to any struct name,
>> apart from struct thermal_zone_device_params (meaning, I'm never creating
>> vars/pointers to struct thermal_zone_platform_params).
>>
>> If we follow this style, at least temporarily and at least during this cleanup,
>> we will end up with a plan such that:
>>
>> 1. In the first merge window:
>>     - Drivers get migrated to thermal_zone_device_register()
>>     - Functions register_with_trips()/tripless get deprecated but not yet removed
>  >
>> 2. In the next merge window (expecting all users updated from the first window):
>>     - Functions register_with_trips/tripless get removed (<- no more external refs
>>       to struct thermal_zone_params, which can be then safely renamed!)
>>     - Duplicated members governor_name and no_hwmon get removed from
>>       struct thermal_zone_params
>>     - Some structures get renamed to give them the proposed better names (which
>>       I also genuinely like)
>>     - Only Thermal API internal changes, as users (all the ones that are not in
>>       drivers/thermal/) won't need to get updated at all!
>>       ... and that's why I said "strictly like so" in the example up there.
>>
>> I think that this is the best strategy, for both ease of merging the changes and
>> internal reorganization.
>>
>> Sure in the first merge window we'll be wasting a byte or two, but I am confident
>> in that this is a very low price to pay - and even better, only temporarily - for
>> other bigger benefits.
>>
>> What do you think?
> 
> Sounds like a plan :)
> 
> 

Cool. It's time to write a good non-RFC series then!

Cheers,
Angelo



