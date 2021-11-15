Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95345023F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhKOKWX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 05:22:23 -0500
Received: from foss.arm.com ([217.140.110.172]:53390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhKOKWQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Nov 2021 05:22:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54FC1FB;
        Mon, 15 Nov 2021 02:19:20 -0800 (PST)
Received: from [192.168.1.16] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E6853F70D;
        Mon, 15 Nov 2021 02:19:19 -0800 (PST)
Message-ID: <fe34da7f-7090-bc11-ae1a-5ab228d0cb05@arm.com>
Date:   Mon, 15 Nov 2021 10:19:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1] cpufreq: CPPC: Fix performance/frequency conversion
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
References: <20211022075057.10759-1-Pierre.Gondois@arm.com>
 <CAJZ5v0g4RrpnRfTsBm_Qi2-JM8SQCAH9_7gTM9cB3Rmc0DG4Hg@mail.gmail.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0g4RrpnRfTsBm_Qi2-JM8SQCAH9_7gTM9cB3Rmc0DG4Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Rafael,

On 11/5/21 15:40, Rafael J. Wysocki wrote:
> On Fri, Oct 22, 2021 at 9:51 AM Pierre Gondois <Pierre.Gondois@arm.com> wrote:
>> CPUfreq governors request CPU frequencies using information
>> on current CPU usage. The CPPC driver converts them to
>> performance requests. Frequency targets are computed as:
>>   target_freq = (util / cpu_capacity) * max_freq
>> target_freq is then clamped between [policy->min, policy->max].
>>
>> The CPPC driver converts performance values to frequencies
>> (and vice-versa) using cppc_cpufreq_perf_to_khz() and
>> cppc_cpufreq_khz_to_perf(). These functions both use two different
>> factors depending on the range of the input value. For
>> cppc_cpufreq_khz_to_perf():
>> - (NOMINAL_PERF / NOMINAL_FREQ) or
>> - (LOWEST_PERF / LOWEST_FREQ)
>> and for cppc_cpufreq_perf_to_khz():
>> - (NOMINAL_FREQ / NOMINAL_PERF) or
>> - ((NOMINAL_PERF - LOWEST_FREQ) / (NOMINAL_PERF - LOWEST_PERF))
>>
>> This means the functions are not inverse for some values:
>> (perf_to_khz(khz_to_perf(x)) != x)
>>
>> This patch makes use of one single conversion factor, being
>> (MAX_PERF / MAX_FREQ).
>>
>> As LOWEST_FREQ is not used during conversion, the LOWEST_FREQ
>> advertised through policy->cpuinfo.min_freq might be different
>> from the LOWEST_FREQ value available in the CPPC object,
>> but the conversion will be correct.
> Well, this assumes that there is a linear perf <-> freq mapping which
> is a change in behavior.
The perf <-> freq relation is currently linear on 2 distinct segments.

The patch is also intending handle the case of CPUs whose frequency and
performance values are not proportional.

Example for the current code:
  MAX_FREQ = 1.000.000
  MIN_FREQ = 300.000
  MAX_PERF = 100 ("nominal_perf" in the code)
  MIN_PERF = 40  ("lowest_perf" in the code)
With these values, frequencies and performances are not proportional as
(MAX_FREQ / MAX_PERF) != (MIN_FREQ / MIN_PERF).

A util of 40% gives:
  target_freq = 40% * MAX_FREQ.
cppc_cpufreq_khz_to_perf() then requests:
  target_perf = target_freq * (MIN_PERF / MIN_FREQ)
  target_perf = 40% * 1.000.000 * (40 / 300.000)
  target_perf = 53.3
A performance request of 40 would have been sufficient.

The error comes from the utilization of 2 different factors.
policy->max (frequency) is computed with this factor:
- (MAX_FREQ / MAX_PERF)
and frequency requests are mostly converted to performance
values with this factor:
- (MIN_PERF / MIN_FREQ)

Using one single factor per conversion function, being
(MAX_PERF / MAX_FREQ) for cppc_cpufreq_khz_to_perf():
  target_perf = target_freq * (MAX_PERF / MAX_FREQ)
  target_perf = 40% * 1.000.000 * (100 / 1.000.000)
  target_perf = 40
> While I agree that consistency is a good thing in general, won't this
> cause the values visible via sysfs to change?  And if it does, won't
> it confuse anyone or break anything in user space?
Yes it changes the minimum frequency advertised on sysfs. It might
effectively be confusing. It should be possible to still advertise the
minimum frequency in the ACPI _CPC object while using one conversion
factor, but this will require more changes.
>> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
>> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
>> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 33 ++++++++++-----------------------
>>  1 file changed, 10 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index d4c27022b9c9..d2ac74e7701e 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -302,13 +302,10 @@ static u64 cppc_get_dmi_max_khz(void)
>>  }
>>
>>  /*
>> - * If CPPC lowest_freq and nominal_freq registers are exposed then we can
>> - * use them to convert perf to freq and vice versa
>> - *
>> - * If the perf/freq point lies between Nominal and Lowest, we can treat
>> - * (Low perf, Low freq) and (Nom Perf, Nom freq) as 2D co-ordinates of a line
>> - * and extrapolate the rest
>> - * For perf/freq > Nominal, we use the ratio perf:freq at Nominal for conversion
>> + * The CPPC driver receives frequency requests and translates them to performance
>> + * requests. Thus, frequency values are actually performance values on a frequency
>> + * scale. The conversion is done as:
>> + * target_freq = target_perf * (nominal_freq / nominal_perf)
>>   */
>>  static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
>>                                              unsigned int perf)
>> @@ -317,14 +314,9 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
>>         static u64 max_khz;
>>         u64 mul, div;
>>
>> -       if (caps->lowest_freq && caps->nominal_freq) {
>> -               if (perf >= caps->nominal_perf) {
>> -                       mul = caps->nominal_freq;
>> -                       div = caps->nominal_perf;
>> -               } else {
>> -                       mul = caps->nominal_freq - caps->lowest_freq;
>> -                       div = caps->nominal_perf - caps->lowest_perf;
>> -               }
>> +       if (caps->nominal_freq) {
>> +               mul = caps->nominal_freq;
>> +               div = caps->nominal_perf;
>>         } else {
>>                 if (!max_khz)
>>                         max_khz = cppc_get_dmi_max_khz();
>> @@ -341,14 +333,9 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
>>         static u64 max_khz;
>>         u64  mul, div;
>>
>> -       if (caps->lowest_freq && caps->nominal_freq) {
>> -               if (freq >= caps->nominal_freq) {
>> -                       mul = caps->nominal_perf;
>> -                       div = caps->nominal_freq;
>> -               } else {
>> -                       mul = caps->lowest_perf;
>> -                       div = caps->lowest_freq;
>> -               }
>> +       if (caps->nominal_freq) {
>> +               mul = caps->nominal_perf;
>> +               div = caps->nominal_freq;
>>         } else {
>>                 if (!max_khz)
>>                         max_khz = cppc_get_dmi_max_khz();
>> --
>> 2.17.1
>>
