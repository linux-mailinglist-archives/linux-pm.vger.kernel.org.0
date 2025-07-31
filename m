Return-Path: <linux-pm+bounces-31672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F0B16D92
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB6A3BA537
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4729E0FF;
	Thu, 31 Jul 2025 08:32:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE33597E;
	Thu, 31 Jul 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950745; cv=none; b=HRudUxxFCv03X61Y65kJ+bgVvrhb3Sv6IER/wpptCd8kbcFNZqidVu/45HzIG+biIoUiazvpmWJGcPNooEqYJHGD7aPQ2N7N5Ib0zZMHlFU/f6KobjRQN4IMXxFkGb7xJ9i5HzbmIDBmSImanJQOtrT427ZTsWT1UnhWW5LDI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950745; c=relaxed/simple;
	bh=Kiul/mMGKReBseVwQzoqArXcwJF6+YkhmHXvHFsIW6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DFYPdZSc8Z6BxL3H5Nvj2oWdSM9wktHwcX87tsPYacqYF+woL8gmNyM8F4PGqkFofc+4vSMRcwMiL8H5RGzErklhbKkS21klAi6zh1ZQO8hpcJWrr0bY9lozkPmeMNj9It2j/xdHtx7hhxKIWCQs2nf29RQO5l3bKr+mzLhPtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bt2Nf0ygdztT1X;
	Thu, 31 Jul 2025 16:31:14 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id A9030140136;
	Thu, 31 Jul 2025 16:32:16 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Jul
 2025 16:32:15 +0800
Message-ID: <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com>
Date: Thu, 31 Jul 2025 16:32:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
To: Prashant Malani <pmalani@google.com>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Bowen Yu <yubowen8@huawei.com>, <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>, <lihuisong@huawei.com>,
	<zhenglifeng1@huawei.com>, Beata Michalska <beata.michalska@arm.com>, Ionela
 Voinescu <ionela.voinescu@arm.com>
References: <20250730032312.167062-1-yubowen8@huawei.com>
 <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
 <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 31/07/2025 06:34, Prashant Malani wrote:
> Thanks for adding me, Viresh.
> 
> On Tue, 29 Jul 2025 at 23:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> + Prashant/Beata/Ionela
>>
>> On 30-07-25, 11:23, Bowen Yu wrote:
>>> From: Jie Zhan <zhanjie9@hisilicon.com>
>>>
>>> Perf counters could be 0 if the cpu is in a low-power idle state. Just try
>>> it again next time and update the frequency scale when the cpu is active
>>> and perf counters successfully return.
>>>
>>> Also, remove the FIE source on an actual failure.
>>>
>>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>>> ---
>>>  drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 904006027df2..e95844d3d366 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -78,12 +78,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>>>       struct cppc_cpudata *cpu_data;
>>>       unsigned long local_freq_scale;
>>>       u64 perf;
>>> +     int ret;
>>>
>>>       cppc_fi = container_of(work, struct cppc_freq_invariance, work);
>>>       cpu_data = cppc_fi->cpu_data;
>>>
>>> -     if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
>>> +     ret = cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs);
>>> +     /*
>>> +      * Perf counters could be 0 if the cpu is in a low-power idle state.
>>> +      * Just try it again next time.
>>> +      */
> 
> FWIU the performance counters shouldn't be returning 0 in an idle state.
> Per the UEFI spec [1], they increment any time the CPU is active,
> so they should just return their last counter value before they went into idle
> (of course in the FFH case an IPI is performed on the target CPU, so even
> if the CPU was idle, it will get woken up).

Hi Prashant,

The perf counters could return 0 when a CPU is enters a low-power idle
state, e.g. reset or powered down, and the perf counters are in the system
memory space (the target CPU is not woken up unfortunately).

On our platform, and I suppose so on most ARM64 platforms, perf counters
are mapped to AMU counters.  Per ARM spec, AMEVCNTR0 is 0 on reset.  BTW,
that's also why ARM Trusted Firmware needs to save and restore AMU counters
before and after powering down.
https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/extensions/amu/aarch64/amu.c

I hope this explains your confusion.  Then we can carry on discussion if we
reach on this consensus.

Thanks for taking a look!
Jie

> 
> As such it is better to either :
> - Check for idle_cpu() directly and return (see [2] for the function)
> or
> - Always clear the source on encountering an error return value.
> 
> [1] https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#performance-counters
> [2] https://lore.kernel.org/linux-pm/20250619000925.415528-2-pmalani@google.com/
> 
> HTH,
> 
> -Prashant

