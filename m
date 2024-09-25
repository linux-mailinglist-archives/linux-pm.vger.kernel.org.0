Return-Path: <linux-pm+bounces-14660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44760985675
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E492F1F21BFC
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329215C136;
	Wed, 25 Sep 2024 09:36:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E43215A842;
	Wed, 25 Sep 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257018; cv=none; b=ni+ajODTek0WhoczKR03X2c6p4nO/3tvZxETjaW8oDLJIh/5ytqjeCovmYaAkZF6T1wQDdQ0IHV0JyaK3M0+W3KDuQ7JwnwVxzkWaDSQrpbO1tY6r7ClDiY7Q8d9yilHTlIbYCmwCDajN1az7nOLNSM72KBlvbphd+wMu3wq1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257018; c=relaxed/simple;
	bh=m7sp1br/He+JONE9ID5aOPbfkEtsyCydWy2zmhpyNa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oe5mY2pLrEFYmuL4/YIcNga6wwy3CaG3qgP4ufgmCWgpMLYENd7HgtOI4AxLNb3X1u3Oxl/sY4G2VDWAHsiKCf9dnlQI96n80UXLt8c7DT7rVAuPWHSUAHnE/KZ5JnZjZULln1rQKVg/DVcPf2lq8A5fCDueU3z7mo0K/Gb+Zgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C20812FC;
	Wed, 25 Sep 2024 02:37:24 -0700 (PDT)
Received: from [10.1.32.45] (e127648.arm.com [10.1.32.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6ED43F7A6;
	Wed, 25 Sep 2024 02:36:52 -0700 (PDT)
Message-ID: <cf17f56c-0f64-44ef-8cd1-8d57ddcf4668@arm.com>
Date: Wed, 25 Sep 2024 10:36:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/schedutil: Only bind threads if needed
To: Juri Lelli <juri.lelli@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Ingo Molnar <mingo@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
 <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>
 <ac4c9060-e447-46da-9f37-167864a7906f@arm.com>
 <ZvPGacuDDXNa5k62@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ZvPGacuDDXNa5k62@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/24 09:14, Juri Lelli wrote:
> Hi,
> 
> On 12/09/24 17:01, Christian Loehle wrote:
>> On 9/12/24 16:41, Rafael J. Wysocki wrote:
>>> On Thu, Sep 12, 2024 at 3:53 PM Christian Loehle
> 
> ...
> 
>>>> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
>>>> index c62acf509b74..7d4a4edfcfb9 100644
>>>> --- a/kernel/sched/syscalls.c
>>>> +++ b/kernel/sched/syscalls.c
>>>> @@ -1159,6 +1159,9 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
>>>>         if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
>>>>                 return 0;
>>>>
>>>> +       if (dl_entity_is_special(&p->dl))
>>>> +               return 0;
>>>> +
>>>
>>> Care to explain this particular piece?
>>
>> Looks suspicious but the truncated comment below explains it:
>> 	/*
>> 	 * Since bandwidth control happens on root_domain basis,
>> 	 * if admission test is enabled, we only admit -deadline
>> 	 * tasks allowed to run on all the CPUs in the task's
>> 	 * root_domain.
>> 	 */
>> So that would only allow setting it to all CPUs for the relevant
>> platforms unfortunately.
>>
>> That should be fine though since the sugov task is pretty much
>> a dummy in terms of bandwidth / admission control internally, so
>> no harm done to not enforce this when userspace wants to set
>> affinities.
>> ...Unless Juri disagrees.
> 
> Nope, I agree. :)
> 
> Wonder if we should put a comment along the lines of what you said above
> right above the new conditions (so that people will not need to wonder
> about it in the future). But not a strict requirement for me.
> 
> Thanks! (and apologies for the delay in replying)
> Juri

Thank you Juri for taking a look. I agree with the comment, will
do a v2.
Regards,
Christian

