Return-Path: <linux-pm+bounces-10334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67510923BE8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C13C1C20BAD
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169A1591EA;
	Tue,  2 Jul 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTvye0VH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895F2C6B7
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917786; cv=none; b=cPPZt5AWEUG5FSdK7xhhbbEikmlQ8D4L/FPGwyT/pPaBsrhTyl4NvyFim6m/5X/0SuN09XXMnqIzGHWhBWVSRZrtyGIDu3p7RgWMvGezwhrcPt0LijPteuz1CSqiRq4/RSBuT0wldb62Qi795G85Xo3W6pn6x8PSKI6CuQigi2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917786; c=relaxed/simple;
	bh=1myzl7/ReuyURZRVUOadpwvalz9QBb1UC83VgjATMgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlFPPE7La6v5y5fYemE8w43kpZm24VVn5lA06dYjuJB5dJnsL1f7dhUSEksaT89G0pwUpe1ZBkKwkU9tOaXKMkNm7VfG+P/szkquJsqozJJ+/IElPblGaV6i1NJbitvlMR8p1KUrA0xjgb6l1I/OSam6WcGHpofhFpAP4j0b41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTvye0VH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cd628f21cso4183894e87.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719917783; x=1720522583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBFOYeYiQehf+q7ddrFQQ41V9SB1/rmuKYpa9s1NP18=;
        b=hTvye0VHlVY5aLHxweMwUSPhLm2T1Xvs+uQANk7Xy/5joA1yahaBAgmsU+0/HHzwqJ
         CErJi1N/sMtsYXRBEM6qYKJuM6f9CUYQra5N7hyTimg1bZBT179UTybGGuBsM8bEX1+Z
         v55THyFzyafVv9kzdqmees4beCopQUlDMctJmmSDQ/V2wxYyd0ISqciOrIcDU/kvYaYs
         UDU9vW4+q+CTEicxNssLWumkkDhHoBVdt6MkXnWjqpO8liHuhtPhqKUUT4b0xAlKVMgH
         MkmvXzM/7woGKn1+Ale5DbE1jWFmNV03AO17PE/sQfm12uP1R9NC1uX9n65xeSliGem3
         ghjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719917783; x=1720522583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBFOYeYiQehf+q7ddrFQQ41V9SB1/rmuKYpa9s1NP18=;
        b=DEzIrgCbOJv+0LsndUNHEmdCxKkG8jMYwSlXsGtErHrCxFuCYLPGMy87goP21EHqe/
         LzbIjzy+ihqv681kbrAGCtDQsLhH4+9ua1f2YmIQbAxowxN4rPl4srO15Woanjsn/NPz
         NgFuVWUY7b0Frnor5fTOXKPk1ZUOE0koXeSIf2hG1y/Hbmv1XhzlfryjIDeFGeW2pou2
         79+LL+udB/vYJ3S4P1N0JWPvw2n02vHIfK9ySQLr/j4zMayg26FljqHTX91ncBuRwCJ2
         OiJ0m18NugPLQ1B0qjcpdo0EsURYo7rhdUFBZ5xyeWZ+/BFInGhqj1T/DckDJgjPHB36
         REyA==
X-Forwarded-Encrypted: i=1; AJvYcCWdkKqPq973020ZZPkdNgfkImPNqex1r7jZi0dwsGEslzw2xquxuukmlAczyNIKljqOeWperx3RB3s4kgoErcIIWA+WBWICLBg=
X-Gm-Message-State: AOJu0YzyRuT/bbmf6RpXgQW74yeL2tMWsdY29Xi0d4sfn7fLGO68Siow
	ab4FOPYi5Tfhyv+xg5X9AdujjgxooHTs0IMSzxZ2MWllVRoIK2AOrETFRjrvp0I=
X-Google-Smtp-Source: AGHT+IF/Z5m5dzwnYrpm/rBgxVFvZKe6jykrkDc3dwOp7KqdIY6S6UT+aNwIDsWmm5knsXPHwpoWrA==
X-Received: by 2002:a05:6512:1386:b0:52c:9e82:a971 with SMTP id 2adb3069b0e04-52e8264e569mr6250887e87.7.1719917781163;
        Tue, 02 Jul 2024 03:56:21 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de58:360d:d635:3977? ([2a05:6e02:1041:c10:de58:360d:d635:3977])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b0cee27sm193419955e9.48.2024.07.02.03.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 03:56:20 -0700 (PDT)
Message-ID: <1eb7eb88-4230-4803-83fe-415ce0745951@linaro.org>
Date: Tue, 2 Jul 2024 12:56:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org>
 <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
 <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/07/2024 12:22, Rafael J. Wysocki wrote:
> On Tue, Jul 2, 2024 at 11:29 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 01/07/2024 18:26, Rob Herring wrote:
>>> On Thu, Jun 27, 2024 at 10:54:50AM +0200, Daniel Lezcano wrote:
>>>> Currently the thermal framework has 4 trip point types:
>>>>
>>>> - active : basically for fans (or anything requiring energy to cool
>>>>     down)
>>>>
>>>> - passive : a performance limiter
>>>>
>>>> - hot : for a last action before reaching critical
>>>>
>>>> - critical : a without return threshold leading to a system shutdown
>>>>
>>>> A thermal zone monitors the temperature regarding these trip
>>>> points. The old way to do that is actively polling the temperature
>>>> which is very bad for embedded systems, especially mobile and it is
>>>> even worse today as we can have more than fifty thermal zones. The
>>>> modern way is to rely on the driver to send an interrupt when the trip
>>>> points are crossed, so the system can sleep while the temperature
>>>> monitoring is offloaded to a dedicated hardware.
>>>>
>>>> However, the thermal aspect is also managed from userspace to protect
>>>> the user, especially tracking down the skin temperature sensor. The
>>>> logic is more complex than what we found in the kernel because it
>>>> needs multiple sources indicating the thermal situation of the entire
>>>> system.
>>>>
>>>> For this reason it needs to setup trip points at different levels in
>>>> order to get informed about what is going on with some thermal zones
>>>> when running some specific application.
>>>>
>>>> For instance, the skin temperature must be limited to 43°C on a long
>>>> run but can go to 48°C for 10 minutes, or 60°C for 1 minute.
>>>>
>>>> The thermal engine must then rely on trip points to monitor those
>>>> temperatures. Unfortunately, today there is only 'active' and
>>>> 'passive' trip points which has a specific meaning for the kernel, not
>>>> the userspace. That leads to hacks in different platforms for mobile
>>>> and embedded systems where 'active' trip points are used to send
>>>> notification to the userspace. This is obviously not right because
>>>> these trip are handled by the kernel.
>>>>
>>>> This patch introduces the 'user' trip point type where its semantic is
>>>> simple: do nothing at the kernel level, just send a notification to
>>>> the user space.
>>>
>>> Sounds like OS behavior/policy though I guess the existing ones kind are
>>> too. Maybe we should have defined *what* action to take and then the OS
>>> could decide whether what actions to handle vs. pass it up a level.
>>
>> Right
>>
>>> Why can't userspace just ask to be notified at a trip point it
>>> defines?
>>
>> Yes I think it is possible to create a netlink message to create a trip
>> point which will return a trip id.
>>
>> Rafael what do you think ?
> 
> Trips cannot be created on the fly ATM.
> 
> What can be done is to create trips that are invalid to start with and
> then set their temperature via sysfs.  This has been done already for
> quite a while AFAICS.

Yes, I remember that.

I would like to avoid introducing more weirdness in the thermal 
framework which deserve a clear ABI.

What is missing to create new trip points on the fly ?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


