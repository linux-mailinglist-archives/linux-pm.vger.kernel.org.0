Return-Path: <linux-pm+bounces-43675-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLv9AqhpqWlN6wAAu9opvQ
	(envelope-from <linux-pm+bounces-43675-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 12:31:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C7B210993
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 12:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9504230490E6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F33388E4F;
	Thu,  5 Mar 2026 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Te+NaBVy"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CF36604C;
	Thu,  5 Mar 2026 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710298; cv=none; b=RhI9HBaqdo8V8lSkky026Yg1QIkGvtCleK9lPlqMMwxSfxLgFwRamP69uMV3KWqa7dYQ9Lh/QxHlOTBljkHV+a+YPecrvDEf3wIZ//kBV0RVncBUWq9kZkyMXDVuDUcLULElDvbxvE5QkqxITd2jWXhHII56PlYLIYxp9QI8Z/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710298; c=relaxed/simple;
	bh=fGxUmjOiAjMtm7gl9bij0Fg8Ep07iktXHhsNUWmIiFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WnSaZYSHpojuqS0VRfqUu7CmMMGm9Gsz/CFLbuNe2Ltv3L7/J3bbz5DwJ6Ap6vWavJdySVXDgiKxzZxvaRzI92ys5q0fMg3NyhcxgOiUpuqY/roklJAQy7JCpt9WAf+cOOa2URG+DSl2NJMeWCCIT4pV7ayzB+7+3VV666U4YAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Te+NaBVy; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hIilMkfMW5OXi/i89zqNVKLEHIH+Fd0h698nHDT0NSY=;
	b=Te+NaBVyHv9lt4VAWb5WLSj6ytfKfIuFWJaHa7anwFFJtU5TtddsVn8f7c9Da3gfQxFEzTkP7
	M/CfRk30ghvXOnasi20OuFogXl6Oxo/kJPhJFXGIALamoZNotsEIe5qlyOnRK1WY8N2ckkzu20J
	6FmYA3f0LpoB2wagJErc6K4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fRS0j6x01zpStZ;
	Thu,  5 Mar 2026 19:26:29 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 45D1440561;
	Thu,  5 Mar 2026 19:31:31 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 19:31:30 +0800
Message-ID: <ae17d031-c20a-4bd3-a3fa-d76af061d14b@huawei.com>
Date: Thu, 5 Mar 2026 19:31:30 +0800
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
	<zhangpengjie2@huawei.com>, Sumit Gupta <sumitg@nvidia.com>, Jie Zhan
	<zhanjie9@hisilicon.com>, Pierre Gondois <pierre.gondois@arm.com>, Prashant
 Malani <pmalani@google.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <54f5795f-2c0b-49f2-a319-216c17657c0f@huawei.com>
 <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Queue-Id: 64C7B210993
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-43675-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Viresh,

I'd be happy to be a part of the reviewers list!

Thanks,
Lifeng

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


