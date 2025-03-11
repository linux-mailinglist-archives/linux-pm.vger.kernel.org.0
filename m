Return-Path: <linux-pm+bounces-23896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00063A5D128
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 21:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429C117C320
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45594264A6D;
	Tue, 11 Mar 2025 20:51:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF96C264A62
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726291; cv=none; b=e2z2bnd/3jSfNJceREwKcq+B3sE95qKAK3kZ3y/Wh+bSZVWEes6WR5imhAFlGugfsz7LqyBBLKMfTnOm4HkBZltk9j5ZwdhH31DAZtB5uchPmmoSQCN0dKU96E4Er9tK9qxq0TWrfahAdrhmst4VfMjpJaQlyDwWH+3mjHkOM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726291; c=relaxed/simple;
	bh=KkKnr9gpkJQlo3lx51xKQaTielCjCuX+c/eh7pbD1w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwmeFUtIV+ZoN5lWjErpybdTkhNTo3dj1sjXKwdY9GWfyS6AsWNytLREVYqybMI9DJfMLvo/Iwu81mRS3ypFVqnpAmsBG264Cgfzn7U8tmcIAWCBKO7tYSk1MvN5NoKrmLpyPGZpMz9yPSDoqR+7A/RmJWOYWXJm0R4QuDCYLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA685152B;
	Tue, 11 Mar 2025 13:51:38 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56DE3F673;
	Tue, 11 Mar 2025 13:51:26 -0700 (PDT)
Message-ID: <d6de2118-eae1-4abb-818b-b3420732c82a@arm.com>
Date: Tue, 11 Mar 2025 20:51:24 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TEO as default governor ?
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
 <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com>
 <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
 <9b4a15c4-4e0c-43f6-b2ec-e98bc02f67cc@linaro.org>
 <CAJZ5v0iJTB_JTb9YMVBCjd=iOPuCRdNQNLS7wXwHRD4kz5h-Og@mail.gmail.com>
 <03c2833d-d80c-4146-911d-8d1a524a2b13@linaro.org>
 <CAJZ5v0hH+YUKvq8inVacwhuR_hC2jquttWNuc3nBdYRCP_R8dw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hH+YUKvq8inVacwhuR_hC2jquttWNuc3nBdYRCP_R8dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/25 18:51, Rafael J. Wysocki wrote:
> On Tue, Mar 11, 2025 at 7:42 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 11/03/2025 19:26, Rafael J. Wysocki wrote:
>>> On Tue, Mar 11, 2025 at 7:00 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 11/03/2025 18:34, Rafael J. Wysocki wrote:
>>>>> On Tue, Mar 11, 2025 at 5:47 PM Christian Loehle
>>>>> <christian.loehle@arm.com> wrote:
>>>>>>
>>>>>> On 3/11/25 16:31, Daniel Lezcano wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I think we can agree the teo governor is better then the menu governor.
>>>>>>>
>>>>>>> Would it make sense to make the teo governor the default governor ?
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Rafael's position seems to be quite conservative here.
>>>>>> Fact is menu is still the default on many systems.
>>>>>> Even worse, the really bad performance disadvantage when
>>>>>> using menu in an intercept-heavy workload has been fixed by Rafael :)
>>>>>> https://lore.kernel.org/lkml/bc7f915b-8d9f-4e05-9939-8b7ecc078f85@arm.com/
>>>>>>
>>>>>> FWIW I proposed this a while ago:
>>>>>> https://lore.kernel.org/lkml/20240905092645.2885200-3-christian.loehle@arm.com/
>>>>>
>>>>> It will help if one can make a really convincing case for this change
>>>>> (that is, show that menu with the most recent fixes included is really
>>>>> significantly worse on their platform).
>>>>
>>>> For all the platforms I've been testing, the teo governor is always the
>>>> best one.
>>>
>>> Great!  Can you please share any numbers?
>>
>> There are some at a publication doing an evaluation of the irq
>> prediction [1]
>>
>>>> Using the menu governor has also an impact on the user experience as it
>>>> lags on mobile.
>>>
>>> Well, I'm not quite sure what you mean here?
>>
>> For example, the user feels the lag when touching the screen on a mobile
>> or scrolling a document. Changing from menu to teo solves this issue.
>>
>>
>>>> After studying the history of the menu governor few years ago, it
>>>> appeared the menu governor was introduced before the SMP was widely
>>>> used. The strength of the menu governor was the ability to find
>>>> repeating intervals but with he multiplication of the cores, the IPIs
>>>> were introduced which increased the entropy of the busy-idle cycles
>>>> duration, thus making the duration much more random and altering the
>>>> menu governor prediction accuracy.
>>>
>>> While this arguably is the case, menu has also been changed quite a
>>> bit since its introduction.
>>>
>>> What I'm looking for really is a set of numbers showing the difference
>>> and clearly pointing out that teo should be preferred.
>>
>> Ok, let me check if I can find a platform doing energy measurement.
>>
>> I guess x86 is not a good target as the firmware overcomes the kernel
>> decisions right ?
> 
> In many cases, yes, it does.

So do we btw to some extent (arm that is).
The kernel currently has no ultimate and general knowledge if anything
beyond WFI a) has been entered (without observing it's side effects) and
b) when this was done (i.e. how long that request was delayed for).
Even for WFI many platforms have essentially different levels of deepness
the kernel has neither knowledge nor control over (in the general case). [0]
Additionally we have the issue Uffe mentioned of cluster-sleeps, which are
manageable in OSI-mode (like he proposes), but many (I'd say most) platforms
out there are still PC-mode.
The entire cpuidle landscape has become quite nondeterministic I'm afraid.

There should still be workloads where teo performs better, but ultimately
there's also systems+workloads combinations where menu would (now) be
preferred.
(Generally teo still tends to prefer shallower idle states, on mobile that
is quite nice because a) we often are intercept-heavy b) we have quite
efficient WFI and c) for longer idle periods we try to use system suspend
anyway.)

Those are my two cents, without the mentioned menu patches teo was far
ahead in many workloads, now I think it's much more balanced.
I'm happy to revisit this too.

[0]
https://developer.arm.com/documentation/101433/0102/Functional-description/Power-management-/Core-power-modes/Core-dynamic-retention-mode
This has been mentioned previously on LKML to illustrate how WFI != WFI.


