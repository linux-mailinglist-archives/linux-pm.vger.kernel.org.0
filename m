Return-Path: <linux-pm+bounces-38543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B366C8449D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2218B3A2DEE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD6263F54;
	Tue, 25 Nov 2025 09:46:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FE259CB6
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063974; cv=none; b=q5EtfkB+2YWC/tMjB6o8KFCRIMlRv//FtoKGZBLWKHE/O6F1hn8nRLCm+K3GkqHHLAA2DSKa24ReVUZa9/bnxNXfDopWhb5yj74MlXkh7jWswKjOReyiaCgLwhMSmLkmquI6Cgnh+Gd6/QfhUeYnJVpG+DcPuBMrue6P68xpkng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063974; c=relaxed/simple;
	bh=d03m8D6HOtT9Sr8Z/SwqJevEcIUJ1pBNI0/qfSkcCl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXVBy2yDdaltV0hnpJNtB8XUtsfPayTi051O0m9Z5Vb9KNF1oJ7CRyUxFXu8wB2kzpWDRu3N4pl5Vf1amC1wkIvIx//a2BrWDBe1P8X4QdkXdmXa3LShZzfVaaJSFH6T3G4maOXs89/Gn85xNndHxbK6weGyKfDwOjbvPOex0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96851477;
	Tue, 25 Nov 2025 01:46:04 -0800 (PST)
Received: from [10.57.75.71] (unknown [10.57.75.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55803F66E;
	Tue, 25 Nov 2025 01:46:09 -0800 (PST)
Message-ID: <5ce509d3-0e11-444f-a22e-6c01280dd9af@arm.com>
Date: Tue, 25 Nov 2025 09:46:07 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
To: Vincent Guittot <vincent.guittot@linaro.org>,
 "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "vschneid@redhat.com" <vschneid@redhat.com>,
 "mgorman@suse.de" <mgorman@suse.de>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "bsegall@google.com" <bsegall@google.com>
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
 <71ea7728-6808-4bdf-9437-3746ff8664fc@arm.com>
 <LV3PR11MB8768D5F17B1F9575DE2804B6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAKfTPtChUavg0TYK_BiA9NnR-9_A1nz49kMASf6g8vCwhpJzcg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtChUavg0TYK_BiA9NnR-9_A1nz49kMASf6g8vCwhpJzcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 09:38, Vincent Guittot wrote:
> On Tue, 25 Nov 2025 at 10:23, Kumar, Kaushlendra
> <kaushlendra.kumar@intel.com> wrote:
>>
>> Hi Lukasz,
>>
>> On 11/25/25 XX:XX, Lukasz Luba wrote:
>>> Hi Kaushlendra,
>>>
>>> On 11/25/25 03:24, Kaushlendra Kumar wrote:
>>>> In sugov_next_freq_shared(), the CPU capacity is retrieved only for
>>>> the CPU that triggered the update (sg_cpu->cpu) and then incorrectly
>>>> applied to all CPUs in the shared frequency domain during the loop.On
>>>> heterogeneous systems with CPUs of different capacities sharing a
>>>> frequency domain, this causes incorrect frequency selection.
>>>
>>> How is this possible?
>>> Is it old or new Intel SoC (a chip name would be also welcome)?
>>
>> This is with respect to intel platforms which has E-cores and P-cores.
> 
> Do you mean that they share the same frequency domains ?

Just to get everybody on the same page:
Intel has what's called "favored cores", P-cores that allow for slightly
higher frequencies than the other (same uArch) P-cores.
Rafael's EAS series decided that it wouldn't be worth the effort make EAS
always iterate over an extra cluster (overhead on every wakeup hot-path)
for CPUs where in the bigger picture the difference is negligible.
https://lore.kernel.org/lkml/1592aa65-9dfb-47d6-9bcf-17afd3184a0a@arm.com/
(capacities are 623, 1009 and 1024 here, 1009 and 1024 are lumped into one
cluster.)
I think this isn't unreasonable, as long as this technicality lives inside
of intel_pstate setup code and doesn't escape, like proposed here.
Obviously EAS heavily relies on "1 cluster => 1 capacity" assumption as
mentioned before, even just for max-spare-cap in feec().
Breaking this assumption would require a huge rework, which AFAIU specifically
wasn't was Rafael intended, but I'm sure he'll chime in himself.
So if you really have issues with the different capacities within a cluster
trick that Rafael went with, please just reconsider that instead of trying
to patch things up outside of intel_pstate.

