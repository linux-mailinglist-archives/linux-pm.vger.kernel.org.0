Return-Path: <linux-pm+bounces-31857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49929B19B9A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A0C1758E3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 06:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730B13D503;
	Mon,  4 Aug 2025 06:31:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C8EC2;
	Mon,  4 Aug 2025 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289083; cv=none; b=JA1hVgV5ABXx4hgW+76MwZEVqiXXPrV5c6lyKEz2XROKPYU6i9ybVXK94/zT3iMSJI1LxvksUPrZIEQjGfexKkC1K2mls2U/N7/xOSbfF2/CHRZ/m/kiWIN/N7GCIwesQFh7Ym0sTjlgiCR7gsN605m1rkhSa0EyVpnsuGrd2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289083; c=relaxed/simple;
	bh=gFIHgnOsz/b8h8EXosQD4sDckTrb5J/yBlKjPa9pFLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=psWaMT9/QewR/ToXNQEFPHKHKwxc83E1OrZlt+rswJw1FRLJzMozPLrZs+Z/EZVitlDEdG+/MzxVVOcYmc3/e1K1jOY1QZkk068O5+G6zjZ+9KBOT1aQhrCNGoeeErU01FQWNEpuXG9iAe4lHc6kKsTwpYqS1bCCig+P9ihF4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bwRTY4RLHz23jdk;
	Mon,  4 Aug 2025 14:28:49 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id A51651400D6;
	Mon,  4 Aug 2025 14:31:17 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 14:31:16 +0800
Message-ID: <0ce0acbc-99da-925e-145d-3c80558be761@hisilicon.com>
Date: Mon, 4 Aug 2025 14:31:16 +0800
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
To: Beata Michalska <beata.michalska@arm.com>
CC: Bowen Yu <yubowen8@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <lihuisong@huawei.com>,
	<zhenglifeng1@huawei.com>
References: <20250730032312.167062-1-yubowen8@huawei.com>
 <20250730032312.167062-3-yubowen8@huawei.com> <aIsnA4miO8fCJTgs@arm.com>
 <d9aefa22-9566-9db0-a95f-ab50465977f8@hisilicon.com>
 <aIs6d4ebRKkbz0az@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <aIs6d4ebRKkbz0az@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 31/07/2025 17:42, Beata Michalska wrote:
> On Thu, Jul 31, 2025 at 04:52:05PM +0800, Jie Zhan wrote:
>>
>>
>> On 31/07/2025 16:19, Beata Michalska wrote:
>>> Hi Bowen, Jie
>>> On Wed, Jul 30, 2025 at 11:23:12AM +0800, Bowen Yu wrote:
>>>> From: Jie Zhan <zhanjie9@hisilicon.com>
>>>>
>>>> Perf counters could be 0 if the cpu is in a low-power idle state. Just try
>>>> it again next time and update the frequency scale when the cpu is active
>>>> and perf counters successfully return.
>>>>
>>>> Also, remove the FIE source on an actual failure.
>>>>
>>>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>>>> ---
>>>>  drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 904006027df2..e95844d3d366 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -78,12 +78,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>>>>  	struct cppc_cpudata *cpu_data;
>>>>  	unsigned long local_freq_scale;
>>>>  	u64 perf;
>>>> +	int ret;
>>>>  
>>>>  	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
>>>>  	cpu_data = cppc_fi->cpu_data;
>>>>  
>>>> -	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
>>>> +	ret = cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs);
>>>> +	/*
>>>> +	 * Perf counters could be 0 if the cpu is in a low-power idle state.
>>>> +	 * Just try it again next time.
>>>> +	 */
>>>> +	if (ret == -EFAULT)
>>>> +		return;
>>> Which counters are we actually talking about here ?
>>
>> Delivered performance counter and reference performance counter.
>> They are actually AMU CPU_CYCLES and CNT_CYCLES event counters.
> That does track then.
>>
>>>> +
>>>> +	if (ret) {
>>>>  		pr_warn("%s: failed to read perf counters\n", __func__);
>>>> +		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC,
>>>> +						 cpu_data->shared_cpu_map);
>>>>  		return;
>>>>  	}
>>> And the real error here would be ... ?
>>> That makes me wonder why this has been registered as the source of the freq
>>> scale in the first place if we are to hit some serious issue. Would you be able
>>> to give an example of any?
>> If it gets here, that would be -ENODEV or -EIO from cppc_get_perf_ctrs(),
>> which could possibly come from data corruption (no CPC descriptor) or a PCC
>> failure.
>>
>> I can't easily fake an error here, but the above -EFAULT path could
>> happen when it luckily passes the FIE init.
>>
> The change seems reasonable. Though I am wondering if some other errors might be
> rather transient as well ? Like -EIO ?
> Note, I'm not an expert here.
The -EIO from PCC contains much more error cases than this.

