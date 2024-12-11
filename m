Return-Path: <linux-pm+bounces-19010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14CA9ECB80
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D231A283496
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BBD211A09;
	Wed, 11 Dec 2024 11:44:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942CD238E27;
	Wed, 11 Dec 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917441; cv=none; b=SgXVy0yYXf1OONvOwbNh/KlMLCkjwuWEWbynJ0YsojS12YT4sbfb2JqsBBOvqOD5TXUFPiYFgXEW3DAJGYbCHQ7DFl9ow+WF08j/iNv63a6KOoY2hbFOYpJY3sd7NAQW3kUReGOsMOoyVOA0aPE9/rY3UEbhST0/y+sn22ohOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917441; c=relaxed/simple;
	bh=mo9kAiTvLc24ao3l4ExpOMo+b7f8ffD3Pea6qUFfjDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlvJ++NNlE2XzOCjq0rnQcwOgt/na81q4y+XHRRyL5gKnqqvZPFs5RU0uFfSGGabLdOk4F7ObSXkmA0KNsVHeyssadiG/ZTt9HUKnffPsve3yhxKHkXynGrZkD5ICoM4lwMKsyB1ONdGzVs2vS/Eao84DcoCbkgfOYKvMk55Q3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB20C1063;
	Wed, 11 Dec 2024 03:44:26 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08CC23F5A1;
	Wed, 11 Dec 2024 03:43:55 -0800 (PST)
Message-ID: <f16b11fa-bb2d-4e7e-81f9-80cf3a1f7a6c@arm.com>
Date: Wed, 11 Dec 2024 11:43:53 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for
 EAS
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <2989520.e9J7NaK4W3@rjwysocki.net>
 <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com>
 <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/24 11:29, Rafael J. Wysocki wrote:
> On Wed, Dec 11, 2024 at 11:33 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/29/24 16:00, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make it possible to use EAS with cpufreq drivers that implement the
>>> :setpolicy() callback instead of using generic cpufreq governors.
>>>
>>> This is going to be necessary for using EAS with intel_pstate in its
>>> default configuration.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> This is the minimum of what's needed, but I'd really prefer to move
>>> the cpufreq vs EAS checks into cpufreq because messing around cpufreq
>>> internals in topology.c feels like a butcher shop kind of exercise.
>>
>> Makes sense, something like cpufreq_eas_capable().
>>
>>>
>>> Besides, as I said before, I remain unconvinced about the usefulness
>>> of these checks at all.  Yes, one is supposed to get the best results
>>> from EAS when running schedutil, but what if they just want to try
>>> something else with EAS?  What if they can get better results with
>>> that other thing, surprisingly enough?
>>
>> How do you imagine this to work then?
>> I assume we don't make any 'resulting-OPP-guesses' like
>> sugov_effective_cpu_perf() for any of the setpolicy governors.
>> Neither for dbs and I guess userspace.
>> What about standard powersave and performance?
>> Do we just have a cpufreq callback to ask which OPP to use for
>> the energy calculation? Assume lowest/highest?
>> (I don't think there is hardware where lowest/highest makes a
>> difference, so maybe not bothering with the complexity could
>> be an option, too.)
> 
> In the "setpolicy" case there is no way to reliably predict the OPP
> that is going to be used, so why bother?
> 
> In the other cases, and if the OPPs are actually known, EAS may still
> make assumptions regarding which of them will be used that will match
> the schedutil selection rules, but if the cpufreq governor happens to
> choose a different OPP, this is not the end of the world.

"Not the end of the world" as in the model making incorrect assumptions.
With the significant power-performance overlaps we see in mobile systems
taking sugov's guess while using powersave/performance (the !setpolicy
case) at least will make worse decisions.
See here for reference, first slide.
https://lpc.events/event/16/contributions/1194/attachments/1114/2139/LPC2022_Energy_model_accuracy.pdf

What about the config space, are you fine with everything relying on
CONFIG_CPU_FREQ_GOV_SCHEDUTIL?

