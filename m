Return-Path: <linux-pm+bounces-20501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85ACA12BAD
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 20:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289801887EA4
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20B01D54E3;
	Wed, 15 Jan 2025 19:20:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBB86350;
	Wed, 15 Jan 2025 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968836; cv=none; b=AjrKqOVC8FyVWoJ8aAD3+6sLeKd1QilIVpfTg4il+h19tuOmMXbKQJHSdms9r6q1ZFUkGfAL97mv6sU9xBOgMXm5+sbSxOWvQEE93Zf76aZATlvdlkasoIqwehexeKsZndoPUbuIzuXRu50L6+RfYNtKC0JKhk78L/a0urYbDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968836; c=relaxed/simple;
	bh=I1O/C1Or8EGJzFxToggNg+3O2u+busIM/+ma0hWmsTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjzLCrRosdfpem3m+5noPyu43AcefKeBcXjNJ4qJML3z1X/tU39x3tATBxt8+X2Fj5VsD3sLdg2YlAEre89JVSHIPlVekAPjcP8XCBthNqmZ50ZeuYmRrjPDbKivOdjM5uCVsylHLTyCPgFlGJ8ICTUvlyYLK7WAaG+vSoPmsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD46912FC;
	Wed, 15 Jan 2025 11:21:02 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3548C3F73F;
	Wed, 15 Jan 2025 11:20:33 -0800 (PST)
Message-ID: <a44d8a62-8753-4efb-8c3a-f9c3cdc1dabc@arm.com>
Date: Wed, 15 Jan 2025 19:20:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <1907276.tdWV9SEqCh@rjwysocki.net>
 <8959e72a-600d-427a-9ab2-54f14b056766@arm.com>
 <CAJZ5v0iVOg5CnYo8OQ5E8VGLdn4cvVdFFQqpOgpWvij4a4cdxQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0iVOg5CnYo8OQ5E8VGLdn4cvVdFFQqpOgpWvij4a4cdxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/15/25 15:54, Rafael J. Wysocki wrote:
> On Wed, Jan 15, 2025 at 3:46 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 1/13/25 18:36, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Since constraint_idx may be 0, the candidate state index may change to 0
>>> after assigning constraint_idx to it, so first check if it is greater
>>> than constraint_idx (and update it if so) and then check it against 0.
>>
>> So the reason I've left this where it was is because the prev_intercept_idx
>> was supposed to query the sleep length if we're in an majority-intercept
>> period and then it makes sense to query the sleep length (to detect such
>> a period being over).
>> A constraint_idx == 0 scenario doesn't need the intercept-machinery to
>> work at all, why are we querying the sleep length then?
> 
> In case the constraint is different next time and it's better to know
> the sleep length to properly classify the wakeup.

I would hope constraints change nowhere near as frequently as
idle entry / exit happen, is your experience different?

> 
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> This is a rebased variant of
>>>
>>> https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/
>>>
>>> ---
>>>  drivers/cpuidle/governors/teo.c |   15 ++++++++-------
>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> --- a/drivers/cpuidle/governors/teo.c
>>> +++ b/drivers/cpuidle/governors/teo.c
>>> @@ -428,6 +428,14 @@
>>>                               break;
>>>               }
>>>       }
>>> +
>>> +     /*
>>> +      * If there is a latency constraint, it may be necessary to select an
>>> +      * idle state shallower than the current candidate one.
>>> +      */
>>> +     if (idx > constraint_idx)
>>> +             idx = constraint_idx;
>>> +
>>>       if (!idx && prev_intercept_idx) {
>>>               /*
>>>                * We have to query the sleep length here otherwise we don't
>>> @@ -439,13 +447,6 @@
>>>       }
>>>
>>>       /*
>>> -      * If there is a latency constraint, it may be necessary to select an
>>> -      * idle state shallower than the current candidate one.
>>> -      */
>>> -     if (idx > constraint_idx)
>>> -             idx = constraint_idx;
>>> -
>>> -     /*
>>
>> We could leave this here and just do goto end;?
> 
> Why would this be better?

Saves querying the sleep length in case of constraint_idx == 0, i.e.
qos request to be very latency-sensitive and us actually adding latency
here.


