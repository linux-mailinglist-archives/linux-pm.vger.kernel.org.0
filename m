Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DED3E951B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhHKPx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 11:53:59 -0400
Received: from foss.arm.com ([217.140.110.172]:53490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233507AbhHKPxY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 11:53:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC5851063;
        Wed, 11 Aug 2021 08:53:00 -0700 (PDT)
Received: from [10.57.12.152] (unknown [10.57.12.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A752C3F718;
        Wed, 11 Aug 2021 08:52:58 -0700 (PDT)
Subject: Re: [PATCH V2 9/9] cpufreq: scmi: Use .register_em() callback
To:     Quentin Perret <qperret@google.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1628682874.git.viresh.kumar@linaro.org>
 <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
 <YRPN8zjp1wqkHg6t@google.com> <b02cff82-d242-f783-6f29-78e734f78e26@arm.com>
 <YRPhI3AOAJLpQnjT@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <31d73514-0d60-3239-a727-0ae483f11c31@arm.com>
Date:   Wed, 11 Aug 2021 16:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YRPhI3AOAJLpQnjT@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/11/21 3:39 PM, Quentin Perret wrote:
> On Wednesday 11 Aug 2021 at 15:09:13 (+0100), Lukasz Luba wrote:
>>
>>
>> On 8/11/21 2:17 PM, Quentin Perret wrote:
>>> On Wednesday 11 Aug 2021 at 17:28:47 (+0530), Viresh Kumar wrote:
>>>> Set the newly added .register_em() callback to register with the EM
>>>> after the cpufreq policy is properly initialized.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>    drivers/cpufreq/scmi-cpufreq.c | 55 ++++++++++++++++++++--------------
>>>>    1 file changed, 32 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>>>> index 75f818d04b48..b916c9e22921 100644
>>>> --- a/drivers/cpufreq/scmi-cpufreq.c
>>>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>>>> @@ -22,7 +22,9 @@
>>>>    struct scmi_data {
>>>>    	int domain_id;
>>>> +	int nr_opp;
>>>>    	struct device *cpu_dev;
>>>> +	cpumask_var_t opp_shared_cpus;
>>>
>>> Can we use policy->related_cpus and friends directly in the callback
>>
>> Unfortunately not. This tricky setup code was introduced because we may
>> have a platform with per-CPU policy, so single bit set in
>> policy->related_cpus, but we want EAS to be still working on set
>> of CPUs. That's why we construct temporary cpumask and pass it to EM.
> 
> Aha, I see this now. Hmm, those platforms better have AMUs then,
> otherwise PELT signals will be wonky ...

That's the plan, to have the AMUs. We suggest that, but reality would
tell... ;)

> 
> I was going to suggest using dev_pm_opp_get_sharing_cpus() from the
> callback instead, but maybe that's overkill as we'd need to allocate a
> temporary cpumask and all. So n/m this patch should be fine as is.
> 
