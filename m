Return-Path: <linux-pm+bounces-9655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0529491008C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 11:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0370B1C21A6B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C711A4F1E;
	Thu, 20 Jun 2024 09:40:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137BE47772;
	Thu, 20 Jun 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876416; cv=none; b=MC8k4seIfH/ROiJPbvNudTOHILFIihhQey90Hn4CBijpLTIpwOQwcPWvdB7AdYSzcvT5MyFZSlAjwjIKuJsxoHtnfZYXsogsmAmebWClXfmqwaAOJV2b0wGesbxBqyAsoVP5NIXvcvfhk9QK2aJ/DzSezHMH68Exi9Ou2/G0SfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876416; c=relaxed/simple;
	bh=9MNVSBWbW8OjiSSPD7at3rvyGG4z1twkKtzhezeu9I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz4bYnIMXFMBJBK82y4XcACz+yTQirtcfAq21IN8XypStsYE2Hp0ogE5QtvGAdEU6s/07hgLIgalSEpJ5VMcXnwruMAdpN9zZ53vfUZhhDc0jMWUpF6RpBdeQUX0iPc8KgdvQ692Jk4VLTXCP0rzsvHO50HUOcu3m4Vag9n36Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0634CDA7;
	Thu, 20 Jun 2024 02:40:39 -0700 (PDT)
Received: from [10.1.27.54] (e127648.arm.com [10.1.27.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9433F6A8;
	Thu, 20 Jun 2024 02:40:12 -0700 (PDT)
Message-ID: <8065165f-1c51-4444-ac9a-bc74101ac01a@arm.com>
Date: Thu, 20 Jun 2024 10:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-2-tj@kernel.org>
 <0c0073ef-3fe3-4c9f-9a86-5c42336b3da1@arm.com>
 <ZnMqNHzCaAmolxkK@slm.duckdns.org> <ZnMrVmutooN-YwL1@slm.duckdns.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ZnMrVmutooN-YwL1@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 20:07, Tejun Heo wrote:
> On Wed, Jun 19, 2024 at 08:57:56AM -1000, Tejun Heo wrote:
>> Hello, Christian.
>>
>> On Wed, Jun 19, 2024 at 03:07:32PM +0100, Christian Loehle wrote:
>>>> +	if (sugov_hold_freq(sg_cpu) && next_f < sg_policy->next_freq &&
>>>>  	    !sg_policy->need_freq_update) {
>>>>  		next_f = sg_policy->next_freq;
>>>>  
>>>
>>> Not necessarily related to your changes, but in case you're touching this
>>> again, maybe sugov_hold_freq() could be the last condition?
>>
>> I'll update the patch so that sugov_hold_freq() is the last condition.
> 
> Oh, looking at the code again, this would lead to behavior change, right? It
> changes the period over which non-idleness is measured. Maybe that's okay
> but seems out-of-scope for a refactoring patch. I'll leave it as-is.

It does prevent idle_calls being updated in some cases, but see below I don't
think they are that deliberate anyway.

> 
>>> And do we want something like
>>> #ifdef CONFIG_NO_HZ_COMMON                                                      
>>> else
>>> 	sg_cpu->saved_idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
>>> #endif
>>> here?
>>
>> I have no idea but if something like the above is necessary, it'd probably
>> fit better in the #else definition of sugof_hold_freq() or just move the
>> #ifdef inside the function body so that the common part is outside?
> 
> and ->saved_idle_calls isn't even defined if !NO_HZ_COMMON and is only used
> to determine whether to hold frequency, so the above doesn't seem necessary
> either.

When reading that code again it seems like the right thing to do.
Anyway feel free to ignore, I might pick it up myself.
I'll think it through some more, the question mark was more like an open
question to anyone reading this.

Kind Regards,
Christian

