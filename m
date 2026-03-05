Return-Path: <linux-pm+bounces-43656-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HcoKS0qqWkL2gAAu9opvQ
	(envelope-from <linux-pm+bounces-43656-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 08:01:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB5720C0AF
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 08:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E799D3026BF9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA630ACE6;
	Thu,  5 Mar 2026 07:00:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559681DF742;
	Thu,  5 Mar 2026 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694043; cv=none; b=MiUAxpXtd1VflIVHESYxdsYN+iiYOaC2CAIAoen9EfZbiNPybXQCbbs0K/1NhMG3qj9Agvqp06OFWoq/tCMy9mdYb+5T9ThJS3WTqWfqA8+Xo3AISDuONHOZryX7T0RfHNlEOeS6JLK7FyIp84UzVOZTbh6EVQFuQsK1z6iMQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694043; c=relaxed/simple;
	bh=xl0zACBZtanATNvK45qwZ+mHQ2zZocrgb1ymP4/IDp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l/HjemL4UBMW93o8ep0UJXV1RN+u2P4C9LlTQSiCB/wui1n5jeEX44yPHPHjIMGayY8RXm4hPwucxBJtkIMKnIIaYHt1k7YQQfHMJ2XoWRVSBYIMWyeYwtRRbIf5a3yJsHtqeioa5RiFdjIm4xTZPGFn1kjDiuivY0ZvGonNAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fRL0c0tR8znTVx;
	Thu,  5 Mar 2026 14:56:00 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 408CF40567;
	Thu,  5 Mar 2026 15:00:36 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 15:00:35 +0800
Message-ID: <8af0818e-7f98-4bb0-96b9-d34368e9b58f@hisilicon.com>
Date: Thu, 5 Mar 2026 15:00:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: Viresh Kumar <viresh.kumar@linaro.org>, "zhangpengjie (A)"
	<zhangpengjie2@huawei.com>, Sumit Gupta <sumitg@nvidia.com>, Pierre Gondois
	<pierre.gondois@arm.com>, Prashant Malani <pmalani@google.com>, Ionela
 Voinescu <ionela.voinescu@arm.com>, <beata.michalska@arm.com>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <linhongye@h-partners.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <54f5795f-2c0b-49f2-a319-216c17657c0f@huawei.com>
 <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)
X-Rspamd-Queue-Id: ADB5720C0AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjie9@hisilicon.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43656-lists,linux-pm=lfdr.de];
	NEURAL_HAM(-0.00)[-0.993];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Viresh,

I'm happy with rewiewing or maintaining this.
We're consistently using the CPPC cpufreq driver for our SoCs.

BTW, will take a look at Pengjie's patches soon!

Thanks,
Jie

On 3/5/2026 2:32 PM, Viresh Kumar wrote:
> Added few more people
> 
> I think we should updated MAINTAINERS with a list of reviewers or maintainers
> for the CPPC driver. Who all want to be part of the reviewers list ?
> 
> On 03-03-26, 20:03, zhangpengjie (A) wrote:
>> Just a gentle ping on this patch.
>> Thanks, Pengjie
>>
>> On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
>>> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
>>> linear performance scaling. Performance levels below this threshold
>>> are typically inefficient and should not be used by default.
>>>
>>> Currently, the QoS minimum request is initialized to 0. This defaults
>>> the performance floor to the absolute "Lowest Performance" state
>>> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
>>> an inefficient range unnecessarily.
>>>
>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>> ---
>>> Changes in v2:
>>>    - Renamed the patch subject to better reflect the logic change.
>>>    - Updated the commit log to clarify ACPI spec details.
>>> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 7e8042efedd1..4a3031d9fcf4 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>   	return target_freq;
>>>   }
>>> -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>>>   {
>>> -	cpufreq_verify_within_cpu_limits(policy);
>>> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>> +					      cpufreq_cpu_get(policy_data->cpu);
>>> +		struct cppc_cpudata *cpu_data;
>>> +
>>> +		if (!policy)
>>> +			return -EINVAL;
>>> +
>>> +		cpu_data = policy->driver_data;
>>> +		policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
>>> +			cpu_data->perf_caps.lowest_nonlinear_perf);
>>> +	}
>>> +
>>> +	cpufreq_verify_within_cpu_limits(policy_data);
>>> +
>>>   	return 0;
>>>   }
> 

