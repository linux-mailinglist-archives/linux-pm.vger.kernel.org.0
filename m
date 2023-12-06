Return-Path: <linux-pm+bounces-751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE980709D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 14:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904C01C209FC
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A63716D;
	Wed,  6 Dec 2023 13:11:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AB39AC;
	Wed,  6 Dec 2023 05:11:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 624921474;
	Wed,  6 Dec 2023 05:12:21 -0800 (PST)
Received: from [10.57.1.114] (unknown [10.57.1.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69AFB3F5A1;
	Wed,  6 Dec 2023 05:11:34 -0800 (PST)
Message-ID: <972bf6bc-20ca-4588-bed0-c95b1b24c552@arm.com>
Date: Wed, 6 Dec 2023 13:12:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powercap: DTPM: Fix the missing cpufreq_cpu_put() calls
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, stable@vger.kernel.org
References: <20231201123205.1996790-1-lukasz.luba@arm.com>
 <CAJZ5v0gYfvJCQ6Tk2Jh8ZYtaJM=sq3Qb6dq28rjYjMNPfJBT_Q@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gYfvJCQ6Tk2Jh8ZYtaJM=sq3Qb6dq28rjYjMNPfJBT_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/5/23 19:54, Rafael J. Wysocki wrote:
> On Fri, Dec 1, 2023 at 1:31 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The policy returned by cpufreq_cpu_get() has to be released with
>> the help of cpufreq_cpu_put() to balance its kobject reference counter
>> properly.
>>
>> Add the missing calls to cpufreq_cpu_put() in the code.
>>
>> Fixes: 0aea2e4ec2a2 ("powercap/dtpm_cpu: Reset per_cpu variable in the release function")
>> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
>> Cc: <stable@vger.kernel.org> # v5.10+
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/powercap/dtpm_cpu.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
>> index 45bb7e2849d7..aac278e162d9 100644
>> --- a/drivers/powercap/dtpm_cpu.c
>> +++ b/drivers/powercap/dtpm_cpu.c
>> @@ -152,6 +152,8 @@ static void pd_release(struct dtpm *dtpm)
>>          if (policy) {
>>                  for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
>>                          per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) = NULL;
>> +
>> +               cpufreq_cpu_put(policy);
>>          }
>>
>>          kfree(dtpm_cpu);
>> @@ -204,12 +206,16 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>>                  return 0;
>>
>>          pd = em_cpu_get(cpu);
>> -       if (!pd || em_is_artificial(pd))
>> -               return -EINVAL;
>> +       if (!pd || em_is_artificial(pd)) {
>> +               ret = -EINVAL;
>> +               goto release_policy;
>> +       }
>>
>>          dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
>> -       if (!dtpm_cpu)
>> -               return -ENOMEM;
>> +       if (!dtpm_cpu) {
>> +               ret = -ENOMEM;
>> +               goto release_policy;
>> +       }
>>
>>          dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
>>          dtpm_cpu->cpu = cpu;
>> @@ -231,6 +237,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>>          if (ret)
>>                  goto out_dtpm_unregister;
>>
>> +       cpufreq_cpu_put(policy);
>>          return 0;
>>
>>   out_dtpm_unregister:
>> @@ -242,6 +249,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>>                  per_cpu(dtpm_per_cpu, cpu) = NULL;
>>          kfree(dtpm_cpu);
>>
>> +release_policy:
>> +       cpufreq_cpu_put(policy);
>>          return ret;
>>   }
>>
>> --
> 
> Applied as 6.7-rc material with the Cc: stable tag fixed.
> 
> Thanks!
> 

Thank you Rafael!

