Return-Path: <linux-pm+bounces-33590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D706B3F06D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 23:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC554E08E6
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EB31E00A0;
	Mon,  1 Sep 2025 21:18:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F10C13B;
	Mon,  1 Sep 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761482; cv=none; b=MW6j3eQ0NTbbAAApHLDPGn9FiERqriDvp0FR9DzJ9QbS39aGGYdphOozOkTOqHyu5c/D/dnGn+ybMiTyncSt5f1bqo13C+EUtUJW3wPiclalA3fEQ3y2J9XfgPF5rocHETTrxZsIaJGsyYB/0qzy4hfknAWVyQON81p5X5P5CCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761482; c=relaxed/simple;
	bh=FAfUZYd51XKAFsO1yizBYL4+TL7Q4X2J0zPtZaHdsqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtspSlpKJlT/gINengoEaGxPFchObARJivoLcNgyQnfEEbnKZ/El96E+MZkE+7QP1MdYUTc4f15CdlkoIADPCAtJi9KMBSS9Buxzkksy7gdjmdh3ILDNZlirVFqYDha/cG17q5U7wlwb14gC+MxNRZIpZqq0ikhGekfHPIqo4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFA6D1692;
	Mon,  1 Sep 2025 14:17:50 -0700 (PDT)
Received: from [10.57.65.108] (unknown [10.57.65.108])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 838FE3F694;
	Mon,  1 Sep 2025 14:17:57 -0700 (PDT)
Message-ID: <300d135c-fd8e-4c15-bd57-3df2f39c8d25@arm.com>
Date: Mon, 1 Sep 2025 22:17:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: Fix late boot with holes in CPU topology
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
 kenneth.crudup@gmail.com, stable@vger.kernel.org
References: <20250831214357.2020076-1-christian.loehle@arm.com>
 <CAJZ5v0idnFDYviDBusv8hvFD+yH71kL=Q_ARpn5cUBbAg838RQ@mail.gmail.com>
 <dd2e0cdd-ca95-4c83-9397-0606f3899799@arm.com>
 <CAJZ5v0jbOwH7T0StbjQLVeQiYhYU2EMCT+yp8jr8r0p4AwNgkw@mail.gmail.com>
 <CAJZ5v0gOuLJEPm_sG=4xOpqKJ2izY2pbLc7ROq70wvXgtb_m4A@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0gOuLJEPm_sG=4xOpqKJ2izY2pbLc7ROq70wvXgtb_m4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/1/25 20:47, Rafael J. Wysocki wrote:
> On Mon, Sep 1, 2025 at 7:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Sep 1, 2025 at 7:33 PM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> On 9/1/25 17:58, Rafael J. Wysocki wrote:
>>>> On Sun, Aug 31, 2025 at 11:44 PM Christian Loehle
>>>> <christian.loehle@arm.com> wrote:
>>>>>
>>>>> commit e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity
>>>>> adjustment") added a mechanism to handle CPUs that come up late by
>>>>> retrying when any of the `cpufreq_cpu_get()` call fails.
>>>>>
>>>>> However, if there are holes in the CPU topology (offline CPUs, e.g.
>>>>> nosmt), the first missing CPU causes the loop to break, preventing
>>>>> subsequent online CPUs from being updated.
>>>>> Instead of aborting on the first missing CPU policy, loop through all
>>>>> and retry if any were missing.
>>>>>
>>>>> Fixes: e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity adjustment")
>>>>> Suggested-by: Kenneth Crudup <kenneth.crudup@gmail.com>
>>>>> Reported-by: Kenneth Crudup <kenneth.crudup@gmail.com>
>>>>> Closes: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f72b8144d@panix.com/
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>>> ---
>>>>>  kernel/power/energy_model.c | 13 ++++++++-----
>>>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>>>> index ea7995a25780..b63c2afc1379 100644
>>>>> --- a/kernel/power/energy_model.c
>>>>> +++ b/kernel/power/energy_model.c
>>>>> @@ -778,7 +778,7 @@ void em_adjust_cpu_capacity(unsigned int cpu)
>>>>>  static void em_check_capacity_update(void)
>>>>>  {
>>>>>         cpumask_var_t cpu_done_mask;
>>>>> -       int cpu;
>>>>> +       int cpu, failed_cpus = 0;
>>>>>
>>>>>         if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
>>>>>                 pr_warn("no free memory\n");
>>>>> @@ -796,10 +796,8 @@ static void em_check_capacity_update(void)
>>>>>
>>>>>                 policy = cpufreq_cpu_get(cpu);
>>>>>                 if (!policy) {
>>>>> -                       pr_debug("Accessing cpu%d policy failed\n", cpu);
>>>>
>>>> I'm still quite unsure why you want to stop printing this message.  It
>>>> is kind of useful to know which policies have had to be retried, while
>>>> printing the number of them really isn't particularly useful.  And
>>>> this is pr_debug(), so user selectable anyway.
>>>>
>>>> So I'm inclined to retain the line above and drop the new pr_debug() below.
>>>>
>>>> Please let me know if this is a problem.
>>>
>>> For nosmt this leads to a lot of prints every seconds, that's all.
>>> I can resend with the pr_debug for every fail, alternatively print a
>>> cpumask.
>>
>> Printing a cpumask might be better, but it would add some complexity
>> only needed for the printing.
>>
>> Maybe it's just better to not print anything at all.
> 
> I've changed the patch to that effect and tentatively applied it, so
> no need to resend if you agree with this modification.
> 
> Thanks!

All good, thanks!
Yeah I was already leaning towards that now anyway.
I think Kenneth's report (which although he hasn't confirmed would be
that these prints were a red herring for him, they are expected) is
at least an indication that these prints might not be that useful after
all.

