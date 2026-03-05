Return-Path: <linux-pm+bounces-43682-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJebE7qKqWl3/AAAu9opvQ
	(envelope-from <linux-pm+bounces-43682-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 14:52:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5CD212CED
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCFC230C9DCF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319CA39E6C9;
	Thu,  5 Mar 2026 13:50:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5D37F725;
	Thu,  5 Mar 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718619; cv=none; b=udmcawZrMDWflzcC3ccx9s2Ms7JChL4FJwcIbYRjO0cUYv7wYmXqDoifYvbBwGecrQpjzpK+3Or4BHLm9SOPvLQMcXCNCDcFyRD2QgzR587cv9sSji7EH+XNdKXydA38Ut2LSgEj9S5IPjfJ0aU1QS+sxf9n96Z1rLnLDGnMtOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718619; c=relaxed/simple;
	bh=Lo9sWk2d4Crju6juSoEfno/B1Z42ubDdTdPOYRtuV1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XIi/KJq8aoUK3vAI2Ah0UbJN3rwy3XxlXjyagwa3pEz/BtCZ9zYs1zl23scAX9t+EI1sunuKSLeAiQlUGPXV0zYJlJ0/wNoeBTHcZEdy+Zl4+3zHBvCbwc07nHuhiAIIYsjANYPCrWem7kJWTwDuiXIYmqDSk+SJ5Fzihf++0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fRW9l3Whjz1BFPQ;
	Thu,  5 Mar 2026 21:49:31 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fRW4Q5mC5zpT0b;
	Thu,  5 Mar 2026 21:44:54 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 43BBF40561;
	Thu,  5 Mar 2026 21:49:56 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 21:49:55 +0800
Message-ID: <cd08cee4-7923-459e-ad75-164c258a189e@hisilicon.com>
Date: Thu, 5 Mar 2026 21:49:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: Pengjie Zhang <zhangpengjie2@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260213100633.15413-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)
X-Rspamd-Queue-Id: 6B5CD212CED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjie9@hisilicon.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43682-lists,linux-pm=lfdr.de];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
> linear performance scaling. Performance levels below this threshold
> are typically inefficient and should not be used by default.
> 
> Currently, the QoS minimum request is initialized to 0. This defaults
I'm more curious on the original commit that overrides the policy->min set
by driver, which is:
521223d8b3ec ("cpufreq: Fix initialization of min and max frequency QoS requests")

The changelog says:
"The min and max frequency QoS requests in the cpufreq core are initialized
to whatever the current min and max frequency values are at the init time,
but if any of these values change later (for example, cpuinfo.max_freq is
updated by the driver), these initial request values will be limiting the
CPU frequency unnecessarily unless they are changed by user space via
sysfs."

So, instead of doing what the patch did, what about calling
freq_qos_update_request(policy->max_freq_req, xxx) when cpuinfo.max_freq is
updated?

Jie

> the performance floor to the absolute "Lowest Performance" state
> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
> an inefficient range unnecessarily.
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
> Changes in v2:
>   - Renamed the patch subject to better reflect the logic change.
>   - Updated the commit log to clarify ACPI spec details.
> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e8042efedd1..4a3031d9fcf4 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>  	return target_freq;
>  }
>  
> -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>  {
> -	cpufreq_verify_within_cpu_limits(policy);
> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> +					      cpufreq_cpu_get(policy_data->cpu);
> +		struct cppc_cpudata *cpu_data;
> +
> +		if (!policy)
> +			return -EINVAL;
> +
> +		cpu_data = policy->driver_data;
> +		policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
> +			cpu_data->perf_caps.lowest_nonlinear_perf);
> +	}
> +
> +	cpufreq_verify_within_cpu_limits(policy_data);
> +
>  	return 0;
>  }
>  

