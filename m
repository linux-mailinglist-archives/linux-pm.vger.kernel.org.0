Return-Path: <linux-pm+bounces-39916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F90CDC5AC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 14:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1723302B99C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F731691C;
	Wed, 24 Dec 2025 13:26:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815A620DE3;
	Wed, 24 Dec 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766582784; cv=none; b=A0BvXLvF2cYrQTJ0dw0WgZcmlnN8b6YkDdDH9b3baTlM+TLn3QzqGX6S9d95GSpo1lG5KJxX2YWnlzecrlOzafF12P61KL8k5QOkWeBhzUOlgIGsd/YSMMFUClVLtgMbOhHaLFgTBpk1sgdZNkM8lcjC5m57PW96iF80cxVIEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766582784; c=relaxed/simple;
	bh=H+zCL2UnrgIaQDe/zx6zgPOYKGNAmgwr+oXBVxDBVXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxWnPJ0Mg5b/e6Zg1OK7wXR7NuHN64BA5QfVfCF776gDNh4//eZaYTJTczX0x4zomvcJk/5m7L9y37MM7kM9xhFdtt0zEqTD3CMKpxwMffXGqrX44qh4Mdtj0KNXDEhuiG+B15akPz+/gmRFnOX5+dDQBCCbA8YWLVTtB7EWCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD70D339;
	Wed, 24 Dec 2025 05:26:14 -0800 (PST)
Received: from [10.57.46.118] (unknown [10.57.46.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA333F694;
	Wed, 24 Dec 2025 05:26:20 -0800 (PST)
Message-ID: <2463b494-66dd-4f0b-9ce7-4f544a41ecbf@arm.com>
Date: Wed, 24 Dec 2025 13:26:18 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [report] Performance regressions introduced via "cpuidle: menu:
 Remove iowait influence" on 6.12.y
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, rafael.j.wysocki@intel.com,
 daniel.lezcano@linaro.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <c0b5c308-ea18-4736-b507-01cb06cb8dfc@oracle.com>
 <c44a14db-28b6-41f3-984b-bfe67fecfa66@oracle.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <c44a14db-28b6-41f3-984b-bfe67fecfa66@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/24/25 12:18, ALOK TIWARI wrote:
> Hi Christian,
> 
> 
> On 12/3/2025 11:01 PM, ALOK TIWARI wrote:
>> Hi,
>>
>> I’m reporting a performance regression of up to 6% sequential I/O
>> vdbench regression observed on 6.12.y kernel.
>> While running performance benchmarks on v6.12.60 kernel the sequential I/O vdbench metrics are showing a 5-6% performance regression when compared to v6.12.48
>>
>> Bisect root cause commit
>> ========================
>> - commit b39b62075ab4 ("cpuidle: menu: Remove iowait influence")
>>
>> Things work fine again when the previously removed performance- multiplier code is added back.
>>
>> Test details
>> ============
>> The system is connected to a number of disks in disk array using multipathing and directio configuration in the vdbench profile.
>>
>> wd=wd1,sd=sd*,rdpct=0,seekpct=sequential,xfersize=128k
>> rd=128k64T,wd=wd1,iorate=max,elapsed=600,interval=1,warmup=300,threads=64
>>
>>
>> Thanks,
>> Alok
>>
> 
> Just a gentle ping in case this was missed.
> Please let us know if we are missing anything or if there are additional things to consider.
> 

Hi Alok,
indeed it was missed, sorry!
The cpuidle sysfs dumps pre and post test would be interesting like so:
cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
for both would be helpful so I can see what actually changed.
Or a trace with cpu_idle events.
Additionally a latency distribution of the IO requests would be helpful to relate
them to the cpuidle wakeups.

Thanks,
Christian

