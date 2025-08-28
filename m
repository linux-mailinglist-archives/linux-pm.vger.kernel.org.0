Return-Path: <linux-pm+bounces-33321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4303DB3A87B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 19:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038553BBB8C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF9257831;
	Thu, 28 Aug 2025 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="Gi9ehIqj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E581338F36
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402962; cv=none; b=KpH+/Zja31lAbkOAvq4m1NG3nAfmfOnKcrXuAElv5JKfld0p74Y41irMa3WCk3YvDV4tEfaQ2OYXxARFlKIzoW2EMWR2SU5qmarCsbJyCM503+GfvmJOBH0ArkUn3L3+OY/KPZYWRvt8iKsPat9v1yZA3g3CFEbEbPviL/EAME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402962; c=relaxed/simple;
	bh=mEq+MatIoP8t5cH3i0qkzo+GPquzC3/7LEMTgJfAUEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=nGZAjc+HYIChbSN01AyBRgzRXbmCb3iEG6gXPu8/JsTcPQWQsMcQAmOr541pT7782V97qNUlekwRJr46GUtk6GuLy8v8bCaWoxuC8Zjh3K7YQwT4A/Ujj5aaISF9wPHnyY5Yo1K8M+XEmKCsHoNtZJHetx/176pOp+tMu/awiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=Gi9ehIqj; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.8.212] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cCTHq1rLJz4TZv;
	Thu, 28 Aug 2025 13:42:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1756402951; bh=mEq+MatIoP8t5cH3i0qkzo+GPquzC3/7LEMTgJfAUEo=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=Gi9ehIqjMu4Kk8LoOUBY3qFvRw/R3vVgk4soxBmTnSvRLWiC/Ru5cyaMb0TWUtHft
	 dr2ycs4Y8L1Ki31iqkudMdGBpzZt7RA8wrd5avWn0BUIycwi/Wz9o0u/30o1Y6var6
	 TJ0VPWMFakHIwLBxZLJRTVhHl4PppYki80bmvz+8=
Message-ID: <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
Date: Thu, 28 Aug 2025 10:42:28 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU
 topology
To: Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
Content-Language: en-US
Cc: Kenneth C <kenny@panix.com>
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


 > So there's probably a problem here, but presumably your proposal 
breaks the late boot
 > (i.e. what this code was initially supposed to support).

Please explain?

It seems to me (and I really don't know, just guessing here) that if 
there were remaining errors from not getting any further CPU policies 
that the loop would just run thru all CPUs "harmlessly".

Now perhaps to ensure the schedule_delayed_work() gets run, what about a 
flag that gets set if any CPU policy was accessed, and the 
schedule_delayed_work() gets run if it's never set?

-Kenny

On 8/28/25 07:56, Christian Loehle wrote:
> On 8/22/25 06:53, Kenneth Crudup wrote:
>>
>> So I'm testing the "Energy Model" CPU scheduler, which means I need to set "nosmt"; this means I've got "holes" in my CPUs:
>>
>> ----
>> $  ls /dev/cpu | sort -n
>> 0
>> 2
>> 4
>> 6
>> 8
>> 10
>> 12
>> 13
>> 14
>> 15
>> 16
>> 17
>> 18
>> 19
>> ----
>>
>> So in .../kernel/power/energy_model.c , when this line gets to a CPU "hole", it throws an error and breaks out of the loop:
>>
>> ----
>>         policy = cpufreq_cpu_get(cpu);
>>             if (!policy) {
>>                         pr_debug("Accessing cpu%d policy failed\n", cpu);
>>                         schedule_delayed_work(&em_update_work,
>>                                                msecs_to_jiffies(1000));
>>                         break;
>>             }
>> ----
> 
> Hi Kenneth,
> So there's probably a problem here, but presumably your proposal breaks the late boot
> (i.e. what this code was initially supposed to support).
> 
>>
>> ... but I'm thinking (and its working here for me) that a simple "continue" for those three lines handles the "CPU hole" case:
>>
>> ----
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index ea7995a25780..df6cae6f8845 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -795,12 +795,9 @@ static void em_check_capacity_update(void)
>>                          continue;
>>
>>                  policy = cpufreq_cpu_get(cpu);
>> -               if (!policy) {
>> -                       pr_debug("Accessing cpu%d policy failed\n", cpu);
>> -                       schedule_delayed_work(&em_update_work,
>> -                                             msecs_to_jiffies(1000));
>> -                       break;
>> -               }
>> +               if (!policy)
>> +                       continue;
>> +
>>                  cpufreq_cpu_put(policy);
>>
>>                  dev = get_cpu_device(cpu);
>> ----
>>
>> Thoughts?
>>
>> -Kenny
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


