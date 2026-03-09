Return-Path: <linux-pm+bounces-43947-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOjFIJnIrmlwIwIAu9opvQ
	(envelope-from <linux-pm+bounces-43947-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 14:18:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5EA2398ED
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 14:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774FC301D31D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9D3BD63D;
	Mon,  9 Mar 2026 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ahxV4F83";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ahxV4F83"
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2C3A784A;
	Mon,  9 Mar 2026 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062212; cv=none; b=H9EK61qlyUDWyhRBavoDkN7jMsFZTbm/cvEaaLAbSuphr4ThrMfqnnkMqtK9ravV/P7P4DeglrChg7bT4OegnBtKwY5kGIR0WVrGtiYnT7qbzsozXF0AQtRzxmuMl5epbhcmmsRIoO8phpYbub/W6+bq1XQ2pE7wH/cYSShy4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062212; c=relaxed/simple;
	bh=wJwugbRgqFOHNPlHlPF68MggMu+4oJyf1WUdsMlt9yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u7Z6JaWeW1FRXi5gStfYiAMBJrrw29Yf4AQEy/rBhPsSSEdsq5vZ7D/gSwbPUXqRly31Ay119m595TKWXSD/aDIoLvVzRW+YVsuOM4DzoGoQUIjMZKIJ65uFdPGAw1CayzQcEDASbMXS4bA6I6nRDv9ihkNJ3w3AY/5pXXlJviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ahxV4F83; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ahxV4F83; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cOmi8bAuyMgB0EMW00zps6J5Y/uiGByXgMs5pCC52g0=;
	b=ahxV4F83TbNwfqf05udkC+p34Yfd4MXevA/X8fs49ZBZPTDSUP4BbjI+Nl78zz5+refe2d9D5
	MogVMd75ukpy9+0tRo9XZi5AUnFCZJRz5wQ4m9Gg79EriVX3UmcT/tLC3Enbk1ZG+06qtjOIii8
	+iedOGZU/A5o/7pXXocY99c=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fTyFM0l6Sz1BFxb;
	Mon,  9 Mar 2026 21:16:07 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cOmi8bAuyMgB0EMW00zps6J5Y/uiGByXgMs5pCC52g0=;
	b=ahxV4F83TbNwfqf05udkC+p34Yfd4MXevA/X8fs49ZBZPTDSUP4BbjI+Nl78zz5+refe2d9D5
	MogVMd75ukpy9+0tRo9XZi5AUnFCZJRz5wQ4m9Gg79EriVX3UmcT/tLC3Enbk1ZG+06qtjOIii8
	+iedOGZU/A5o/7pXXocY99c=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fTy8P013YzLlSV;
	Mon,  9 Mar 2026 21:11:49 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D56340565;
	Mon,  9 Mar 2026 21:16:43 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 21:16:42 +0800
Message-ID: <bdf22931-ec91-48e5-8050-ab4c899b5860@huawei.com>
Date: Mon, 9 Mar 2026 21:16:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: Jie Zhan <zhanjie9@hisilicon.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <cd08cee4-7923-459e-ad75-164c258a189e@hisilicon.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <cd08cee4-7923-459e-ad75-164c258a189e@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)
X-Rspamd-Queue-Id: 9B5EA2398ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-43947-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangpengjie2@huawei.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Jie,

On 3/5/2026 9:49 PM, Jie Zhan wrote:
>
> On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
>> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
>> linear performance scaling. Performance levels below this threshold
>> are typically inefficient and should not be used by default.
>>
>> Currently, the QoS minimum request is initialized to 0. This defaults
> I'm more curious on the original commit that overrides the policy->min set
> by driver, which is:
> 521223d8b3ec ("cpufreq: Fix initialization of min and max frequency QoS requests")
>
> The changelog says:
> "The min and max frequency QoS requests in the cpufreq core are initialized
> to whatever the current min and max frequency values are at the init time,
> but if any of these values change later (for example, cpuinfo.max_freq is
> updated by the driver), these initial request values will be limiting the
> CPU frequency unnecessarily unless they are changed by user space via
> sysfs."
>
> So, instead of doing what the patch did, what about calling
> freq_qos_update_request(policy->max_freq_req, xxx) when cpuinfo.max_freq is
> updated?
>
> Jie

Thanks for pointing this out.

I think commit 521223d8b3ec intentionally changed the semantics of the
core min/max QoS requests so that they no longer reflect the initial
policy limits set by the driver. Instead, they stay at the default
"no constraint" values until user space (or another QoS client) updates
them. That makes sense for the problem described in that changelog.

What my patch is trying to address is a slightly different issue in
cppc_cpufreq: the driver currently treats `lowest_nonlinear_perf` as
the default minimum policy floor, but with the current core semantics
that floor is not represented explicitly and gets lost during policy
initialization.

So I agree that calling freq_qos_update_request() when
cpuinfo.min_freq/max_freq changes is the right approach for stale
request updates, but I am not sure it addresses the question
for `lowest_nonlinear_perf` itself:

Should it be modeled as a hard driver constraint, or only as the
default minimum policy value that user space may still lower explicitly?

My patch assumes the latter, although I agree the current implementation
is not the cleanest way to express it.

Thanks,
         Pengjie


>> the performance floor to the absolute "Lowest Performance" state
>> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
>> an inefficient range unnecessarily.
>>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>> ---
>> Changes in v2:
>>    - Renamed the patch subject to better reflect the logic change.
>>    - Updated the commit log to clarify ACPI spec details.
>> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 7e8042efedd1..4a3031d9fcf4 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>   	return target_freq;
>>   }
>>   
>> -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>>   {
>> -	cpufreq_verify_within_cpu_limits(policy);
>> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>> +					      cpufreq_cpu_get(policy_data->cpu);
>> +		struct cppc_cpudata *cpu_data;
>> +
>> +		if (!policy)
>> +			return -EINVAL;
>> +
>> +		cpu_data = policy->driver_data;
>> +		policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
>> +			cpu_data->perf_caps.lowest_nonlinear_perf);
>> +	}
>> +
>> +	cpufreq_verify_within_cpu_limits(policy_data);
>> +
>>   	return 0;
>>   }
>>   

