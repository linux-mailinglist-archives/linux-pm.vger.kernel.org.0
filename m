Return-Path: <linux-pm+bounces-2336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8E83169F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 11:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81D9286F31
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 10:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FC208B7;
	Thu, 18 Jan 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Itg28zgb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2E208B1
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573525; cv=none; b=e+mr+rKXc6nkoa+IXm5WzVw3O0ZjWSENXdtYiNvXIJ97DWgFhzo8N/YA9AKOMZfnYXBZfa9YfnNcHkuNcTVZNDl+x/FJXhNA5VInLN+ZAdSte3qjS8ui641EI+P3RlNgSxVsnsrmEAFphfA5Trtp6/4+EGijqk+wIAAJESxLeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573525; c=relaxed/simple;
	bh=/RFwUn+L0XLDZ7pWLxpNfofMNxLhWSzgFGWFnuu6l7g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=sphq0RDMp5PZZerW0JqqcbeNJNF6ts4wDHPAe7igBoNACeegJjYkmtwCKEwhOl/11jkTPtV9m/B1N1VxSGhwieTqHtYyjjGGQD99RJzdQ9LiDNaXlFNWIZMtMuvkH4m+yQXvCc3VDarV46PSgGUJ+fvchzIs6tgKzE9O5HRMh28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Itg28zgb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e80046264so41905695e9.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705573522; x=1706178322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k24AhmjnPQLUkt/JHxUombKI/HErYrcObQB7jooRJW4=;
        b=Itg28zgbAiobG6CaGW8XXHi9l8yqAmZnIRLFrtcT4AguRL0pAPlTv2Nwv/94/fStA7
         GY6bpbYpansyrlOVMbLKk+geOWbsHAQzBG7cw8Fxb5jPdQBFDch71gswxHwbCCUl5V9s
         Ar9VO66iZVvbwRZTkbDE6eG+oZbKAdh+aLGseZ2w0cYiEztsQVctTW+vZrr3mps4eQW5
         6qpcuPd5KFKDiHmLhndN6Xnd6U/97UDRfcb3YERRP3Ds4m1RJPgITkP4lefj6q1ednHD
         Eru5BU9giwtmVR1c9RAaRqwwhIvn3DU4QJPsgXfxLeVlQ+VCIvXRcw/KX3PmQeAJjM9m
         8KWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705573522; x=1706178322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k24AhmjnPQLUkt/JHxUombKI/HErYrcObQB7jooRJW4=;
        b=aA1SLZS0fOEPO8mvdEN96kHX2e0gOD5X2xENRLBqC+KhoZBRz0dInymzEBif99KYHz
         BhhdRToJY6c+np/RLop43N8p/6OigkINxTEar6GLw60kUqoGMRAxBw0bIfoRT7dSSp5P
         aNsC7YC+pYeIKapRRxJtnC0ZT+1bF69zjQnrZlM3xBQHzgJ8Tt5A1i62fXRMUDo8vJW6
         sLOyYuDryrpk98Hx2rn3Z1p9hV2mdFjclWey++VwoZcTSRbNBC5y+/VLaGKN0y6lYbW7
         OHAm3AQm1MSh2ppuLDuRA7si3R5XbZxKX+wKyiHmdqdz6FVc/8xr5TFxnSu6gMXv/j1j
         941w==
X-Gm-Message-State: AOJu0YxVsW0B3+/Kp2mNYd/7zGVRyUfr+qAK0G2gEmU9HfyhLXsEwVvV
	kN51VxC5+wajiTm7QdzA64WxptGULJfLOKY55boUGULgCGLYeoPrmJ4JOyFxpaY=
X-Google-Smtp-Source: AGHT+IF4bLefSoM6uIHKG8sWTgKDhMveu6Af4+VzJmMLqaVejII33G863Jt6Vt6G1Vxe88xp58QBUQ==
X-Received: by 2002:a05:600c:6997:b0:40e:4ad9:666a with SMTP id fp23-20020a05600c699700b0040e4ad9666amr380238wmb.48.1705573522235;
        Thu, 18 Jan 2024 02:25:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:a2f4:93df:1b67:8ad0? ([2a05:6e02:1041:c10:a2f4:93df:1b67:8ad0])
        by smtp.googlemail.com with ESMTPSA id j17-20020a05600c1c1100b0040c46719966sm29161534wms.25.2024.01.18.02.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 02:25:21 -0800 (PST)
Message-ID: <41b284d7-e31f-48b5-8b21-0dca3e23cb1c@linaro.org>
Date: Thu, 18 Jan 2024 11:25:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
 <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com>
 <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
 <921c2f90-fb8b-4e70-9e3d-6e185fec03b6@linaro.org>
 <CAJZ5v0h+93YBsYsA5rOvzp+b3JMGyjUStHA=J8P7ynv+-ym-4g@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h+93YBsYsA5rOvzp+b3JMGyjUStHA=J8P7ynv+-ym-4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/01/2024 19:49, Rafael J. Wysocki wrote:
> On Wed, Jan 17, 2024 at 5:57 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 10/01/2024 13:48, Rafael J. Wysocki wrote:
>>> Hi Manaf,
>>>
>>> On Wed, Jan 10, 2024 at 9:17 AM Manaf Meethalavalappu Pallikunhi
>>> <quic_manafm@quicinc.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> On 1/9/2024 7:12 PM, Rafael J. Wysocki wrote:
>>>>
>>>> On Sat, Jan 6, 2024 at 8:16 PM Manaf Meethalavalappu Pallikunhi
>>>> <quic_manafm@quicinc.com> wrote:
>>>>
>>>> The commit 2e38a2a981b2("thermal/core: Add a generic
>>>> thermal_zone_set_trip() function") adds the support to update
>>>> trip hysteresis even if set_trip_hyst() operation is not defined.
>>>> But during hysteresis attribute creation, if this operation is
>>>> defined then only it enables hysteresis write access. It leads
>>>> to a case where hysteresis sysfs will be read only for a thermal
>>>> zone when its set_trip_hyst() operation is not defined.
>>>>
>>>> Which is by design.
>>>>
>>>> I think it is regression after recent re-work. If a sensor is registered with thermal framework via thermal_of,
>>>>
>>>> sensor driver doesn't need to know the trip configuration and nothing to do with set_trip_hyst() in driver.
>>>>
>>>> Without this change, if a sensor needs to be monitored from userspace(trip/hysteresis),
>>>
>>> What exactly do you mean by "monitored" here?
>>>
>>>> it is enforcing sensor driver to add  dummy set_trip_hyst() operation. Correct me otherwise
>>>
>>> With the current design, whether or not trip properties can be updated
>>> by user space is a thermal zone property expressed by the presence of
>>> the set_trip_* operations, so yes, whoever registers the thermal zone
>>> needs to provide those so that user space can update the trip
>>> properties.
>>>
>>>> For some thermal zone types (eg. acpi), updating trip hysteresis via
>>>> sysfs might lead to incorrect behavior.
>>>>
>>>> To address this issue, is it okay to  guard  hysteresis write permission under CONFIG_THERMAL_WRITABLE_TRIPS defconfig ?
>>>
>>> Not really, because it would affect all of the thermal zones then.
>>
>> It seems like there is an inconsistency here with the writable trip
>> points and the writable hysteresis [1].
>>
>> My understanding is it does not make sense to have the hysteresis
>> writable even if the driver has a hysteresis dedicated ops. The code
>> allowing to change the hysteresis was done regardless the consistency
>> with the trip temperature change and writable trip points kernel option IMO.
>>
>> It would make sense to have:
>>
>> if enabled(CONFIG_WRITABLE_TRIP_POINT)
>>    -> trip_temp RW
>>    -> trip_hyst RW
>> else
>>    -> trip temp RO
>>    -> trip hyst RO
>> fi
>>
>> But if the interface exists since a long time, we may not want to change
>> it, right ?
> 
> If the platform firmware implements hysteresis by changing trip
> temperature (as recommended by the ACPI specification, for example),
> modifying the trip hysteresis via sysfs is simply incorrect and user
> space may not know that.
> 
>> However, we can take the opportunity to introduce a new 'user' trip
>> point type in order to let the userspace to have dedicated trip point
>> and receive temperature notifications [2]
>>
>>> TBH, the exact scenario in which user space needs to update trip
>>> hysteresis is not particularly clear to me, so can you provide some
>>> more details, please?
>>
>> IIUC changing the hysteresis value is useful because the temperature
>> speed will vary given the thermal contribution of the components
>> surrounding the thermal zone, that includes the ambient temperature.
>>
>> However, that may apply to slow speed temperature sensor like the skin
>> temperature sensor where we may to do small hysteresis variation.
>>
>> The places managed by the kernel have an insane temperature transition
>> speed. The userspace is unable to follow this speed and manage the
>> hysteresis on the fly.
>>
>> So that brings us to userspace trip point handling again.
> 
> Well, I've already said that whether hysteresis can be modified via
> sysfs is a property of a thermal zone.

> It may as well be a trip property, for example expressed via a (new)
> trip flag set in the trips table used for thermal zone registration.

Yes, a trip property makes more sense.

I'm a bit lost about WRITABLE_TRIP_POINT, writable hysteresis, read-only 
temperature trip.

Can we have a hysteresis writable but not the temperature ?

You mentioned above "modifying the trip hysteresis via sysfs is simply 
incorrect", so shall we allow that at the end?

Is it possible to recap the situation?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


