Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A68791032
	for <lists+linux-pm@lfdr.de>; Mon,  4 Sep 2023 04:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjIDCyl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Sep 2023 22:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjIDCyk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Sep 2023 22:54:40 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4501F10F
        for <linux-pm@vger.kernel.org>; Sun,  3 Sep 2023 19:54:36 -0700 (PDT)
X-ASG-Debug-ID: 1693796073-1eb14e751210fa0001-MQbzy6
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id Hq3BSYmG5uhRk7Ev (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 04 Sep 2023 10:54:33 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 10:54:32 +0800
Received: from [10.32.65.158] (10.32.65.158) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 10:54:31 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <ee57634a-3e57-724d-857d-7486f6bc3fe8@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.158
Date:   Mon, 4 Sep 2023 10:54:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] cpufreq: ACPI: add ITMT support when CPPC enabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2] cpufreq: ACPI: add ITMT support when CPPC enabled
CC:     <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
        <LindaChai@zhaoxin.com>
References: <20230808111325.8600-1-TonyWWang-oc@zhaoxin.com>
 <CAJZ5v0h8M-hNJfRTSxtVmfmpF09h9zmNmG-e=iMemzPwsK50Zg@mail.gmail.com>
 <e9b4de96-624e-96a5-0a41-93de36719340@zhaoxin.com>
 <CAJZ5v0j7c2aO7=AQrjnF9_DGLjdqibDdm72Y9BLzFxWEvQhnvw@mail.gmail.com>
Content-Language: en-US
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <CAJZ5v0j7c2aO7=AQrjnF9_DGLjdqibDdm72Y9BLzFxWEvQhnvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.32.65.158]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1693796073
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6420
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113635
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/31/23 21:03, Rafael J. Wysocki wrote:
> On Thu, Aug 31, 2023 at 12:19 PM Tony W Wang-oc
> <TonyWWang-oc@zhaoxin.com> wrote:
>>
>>
>> On 8/23/23 04:01, Rafael J. Wysocki wrote:
>>> On Tue, Aug 8, 2023 at 1:13 PM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>>>>
>>>> The _CPC method can get per-core highest frequency.
>>>
>>> Well, not exactly.  A more precise way to say this would be "The
>>> per-core highest frequency can be obtained via CPPC."
>>>
>>
>> Thanks for your reply, will rewrite the commit in next version.
>>
>>>> The highest frequency may varies between cores which mean cores can
>>>
>>> "may vary" and "which means"
>>>
>>>> running at different max frequency, so can use it as a core priority
>>>
>>> "can run", but it would be better to say "may run".
>>>
>>>> and give a hint to scheduler in order to put critical task to the
>>>> higher priority core.
>>>
>>> Well, roughly speaking ...
>>>
>>> You should really talk about ITMT and how it can be hooked up to this.
>>>
>>
>> Ok, Got it.
>>
>>>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>>>> ---
>>>> v1->v2: Fix build errors reported by kernel test robot
>>>>
>>>>  arch/x86/kernel/itmt.c         |  2 ++
>>>>  drivers/cpufreq/acpi-cpufreq.c | 59 ++++++++++++++++++++++++++++++----
>>>>  2 files changed, 54 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
>>>> index ee4fe8cdb857..b49ac8ecbbd6 100644
>>>> --- a/arch/x86/kernel/itmt.c
>>>> +++ b/arch/x86/kernel/itmt.c
>>>> @@ -122,6 +122,7 @@ int sched_set_itmt_support(void)
>>>>
>>>>         return 0;
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(sched_set_itmt_support);
>>>
>>> This requires an ACK from the x86 maintainers.
>>>
>>>>
>>>>  /**
>>>>   * sched_clear_itmt_support() - Revoke platform's support of ITMT
>>>> @@ -181,3 +182,4 @@ void sched_set_itmt_core_prio(int prio, int cpu)
>>>>  {
>>>>         per_cpu(sched_core_priority, cpu) = prio;
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(sched_set_itmt_core_prio);
>>>
>>> And same here.
>>>
>>>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>>>> index b2f05d27167e..5733323e04ac 100644
>>>> --- a/drivers/cpufreq/acpi-cpufreq.c
>>>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>>>> @@ -628,28 +628,35 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>>>>  #endif
>>>>
>>>>  #ifdef CONFIG_ACPI_CPPC_LIB
>>>> -static u64 get_max_boost_ratio(unsigned int cpu)
>>>> +static void cpufreq_get_core_perf(int cpu, u64 *highest_perf, u64 *nominal_perf)
>>>
>>> This is not a cpufreq core function, so please use a different prefix
>>> in its name.
>>>
>>
>> Ok. Will remove the prefix of "cpufreq_".
>>
>>>>  {
>>>>         struct cppc_perf_caps perf_caps;
>>>> -       u64 highest_perf, nominal_perf;
>>>>         int ret;
>>>>
>>>>         if (acpi_pstate_strict)
>>>> -               return 0;
>>>> +               return;
>>>>
>>>>         ret = cppc_get_perf_caps(cpu, &perf_caps);
>>>>         if (ret) {
>>>>                 pr_debug("CPU%d: Unable to get performance capabilities (%d)\n",
>>>>                          cpu, ret);
>>>> -               return 0;
>>>> +               return;
>>>>         }
>>>>
>>>>         if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>>>> -               highest_perf = amd_get_highest_perf();
>>>> +               *highest_perf = amd_get_highest_perf();
>>>>         else
>>>> -               highest_perf = perf_caps.highest_perf;
>>>> +               *highest_perf = perf_caps.highest_perf;
>>>> +
>>>> +       *nominal_perf = perf_caps.nominal_perf;
>>>> +       return;
>>>> +}
>>>>
>>>> -       nominal_perf = perf_caps.nominal_perf;
>>>> +static u64 get_max_boost_ratio(unsigned int cpu)
>>>> +{
>>>> +       u64 highest_perf, nominal_perf;
>>>> +
>>>> +       cpufreq_get_core_perf(cpu, &highest_perf, &nominal_perf);
>>>>
>>>>         if (!highest_perf || !nominal_perf) {
>>>>                 pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
>>>> @@ -663,8 +670,44 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>>>>
>>>>         return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>>>>  }
>>>> +
>>>> +static void cpufreq_sched_itmt_work_fn(struct work_struct *work)
>>>
>>> A similar comment applies here.
>>>
>>>> +{
>>>> +       sched_set_itmt_support();
>>>> +}
>>>> +
>>>> +static DECLARE_WORK(sched_itmt_work, cpufreq_sched_itmt_work_fn);
>>>> +
>>>> +static void cpufreq_set_itmt_prio(int cpu)
>>>> +{
>>>> +       u64 highest_perf, nominal_perf;
>>>> +       static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
>>>> +
>>>> +       cpufreq_get_core_perf(cpu, &highest_perf, &nominal_perf);
>>>> +
>>>> +       sched_set_itmt_core_prio(highest_perf, cpu);
>>>> +
>>>> +       if (max_highest_perf <= min_highest_perf) {
>>>> +               if (highest_perf > max_highest_perf)
>>>> +                       max_highest_perf = highest_perf;
>>>> +
>>>> +               if (highest_perf < min_highest_perf)
>>>> +                       min_highest_perf = highest_perf;
>>>> +
>>>> +               if (max_highest_perf > min_highest_perf) {
>>>> +                       /*
>>>> +                        * This code can be run during CPU online under the
>>>> +                        * CPU hotplug locks, so sched_set_itmt_support()
>>>> +                        * cannot be called from here.  Queue up a work item
>>>> +                        * to invoke it.
>>>> +                        */
>>>> +                       schedule_work(&sched_itmt_work);
>>>> +               }
>>>
>>> This potentially runs before ITMT priorities are set for all CPUs.
>>> Isn't it a problem?
>>>
>>
>> Yes, you are right.
>> Will use schedule_delayed_work(&sched_itmt_work, msecs_to_jiffies(500))
>> to fix this.
> 
> If the ordering matters, it is better to enforce it directly (through
> an explicit code dependency, for example) than to rely on the timing
> to do the right thing.
> 
> If you do the above, then it will not be clear why it is done (a
> comment may help to address that, though) and why the delay is 500 us
> in particular.

Yes, you are right. Rely on the timing is not exactly.
Will find the other way to enforce the order.

Sincerely
TonyWWang-oc
