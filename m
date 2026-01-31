Return-Path: <linux-pm+bounces-41818-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +mqfA1x+fWmlSQIAu9opvQ
	(envelope-from <linux-pm+bounces-41818-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 05:00:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A664CC09C6
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 05:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDBA1300EA94
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807E1FE44B;
	Sat, 31 Jan 2026 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5jyf1Gsa"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3741B425C;
	Sat, 31 Jan 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769832022; cv=none; b=JvSLMLVr7CkUGUNbd455H22Gqf80nFW+6Q8UNgfgtii19MikdZsA74V3WGeLdO/0Eh81DopDDkz4eDVHubm1FQBlFTx1ZlwFZ/+P/jgQG0f/GTCTwR0UXeiNmwG7vcti2ALUMMY30von9cZedVRc6US/GVmOdBMLkWTrzr1DaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769832022; c=relaxed/simple;
	bh=z3tlrUPooP82+V0BbAiKe3K7BUau6mwWfv+4LeX9jC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+G0eKjAtrN4FJS3tLho2GgCtwCYEUqKDTOcRwccY0nbzVPSJ94eJ+pGUzi74VTXeUUuQNsfgXurvnN0gTHzt+W+JUd+YdBl1uR/u37Xv3K94PC4YecV/YO0lsVaNo9JnSiwvf1SWICTv3WTWdrl0SE0KZWUCKFTazMV2K6JW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5jyf1Gsa; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3XJedK4MmDnR2JyB787ezHU0nCGdc2HUxXtDSyYjRMA=;
	b=5jyf1GsaT2tzcC7y9WYys6GjT9+RZCfDyuu3a7E8JV6TN73NbpFPvR8iS+ybQ6CyhRJctlxpj
	xG1kli3l9Nq6sLvTFdTOJoBxU8VewA/VqebfWHaShlMeB4xcc3m7NcQqfJNwOYOxqOu1cHNoVCJ
	mLyy0l213rgKOeZy7bdMA+s=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f2zZv2QcwzKm6D;
	Sat, 31 Jan 2026 11:56:39 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id A9A074048B;
	Sat, 31 Jan 2026 12:00:09 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Jan
 2026 12:00:08 +0800
Message-ID: <28f83199-557f-4305-baf5-01fb4fe2cd2c@huawei.com>
Date: Sat, 31 Jan 2026 12:00:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>
CC: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Christian Loehle <christian.loehle@arm.com>,
	<sumitg@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260126101826.94030-1-pierre.gondois@arm.com>
 <20260126101826.94030-3-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260126101826.94030-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)
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
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-41818-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A664CC09C6
X-Rspamd-Action: no action

On 2026/1/26 18:18, Pierre Gondois wrote:
> The Power Management Quality of Service (PM QoS) allows to
> aggregate constraints from multiple entities. It is currently
> used to manage the min/max frequency of a given policy.
> 
> Frequency constraints can come for instance from:
> - Thermal framework: acpi_thermal_cpufreq_init()
> - Firmware: _PPC objects: acpi_processor_ppc_init()
> - User: by setting policyX/scaling_[min|max]_freq
> The minimum of the max frequency constraints is used to compute
> the resulting maximum allowed frequency.
> 
> When enabling boost frequencies, the same frequency request object
> (policy->max_freq_req) as to handle requests from users is used.
> As a result, when setting:
> - scaling_max_freq
> - boost
> The last sysfs file used overwrites the request from the other
> sysfs file.
> 
> To avoid this, create a per-policy boost_freq_req to save the boost
> constraints instead of overwriting the last scaling_max_freq
> constraint.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 40 ++++++++++++++++++++++++++++++++++-----
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index db414c052658b..c8fb4c6656e94 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1359,17 +1359,24 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	/* Cancel any pending policy->update work before freeing the policy. */
>  	cancel_work_sync(&policy->update);
>  
> -	if (policy->max_freq_req) {
> +	if (policy->max_freq_req || policy->boost_freq_req) {
>  		/*
> -		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
> -		 * notification, since CPUFREQ_CREATE_POLICY notification was
> -		 * sent after adding max_freq_req earlier.
> +		 * Remove max/boost _freq_req after sending CPUFREQ_REMOVE_POLICY
> +		 * notification, since CPUFREQ_CREATE_POLICY notification was sent
> +		 * after adding max/boost _freq_req earlier.
>  		 */
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  					     CPUFREQ_REMOVE_POLICY, policy);

As we discussed in [1], CPUFREQ_REMOVE_POLICY notification will be sent
here without sending CPUFREQ_CREATE_POLICY notification before if adding
boost_freq_req fails.

[1] https://lore.kernel.org/all/a615ab13-bd54-4051-ae61-2bfe8b59427e@arm.com/

> -		freq_qos_remove_request(policy->max_freq_req);
>  	}
>  
> +	if (policy->boost_freq_req) {
> +		freq_qos_remove_request(policy->boost_freq_req);
> +		kfree(policy->boost_freq_req);
> +	}
> +
> +	if (policy->max_freq_req)
> +		freq_qos_remove_request(policy->max_freq_req);
> +

Thses two 'if's are unnecessary. It's OK to call freq_qos_remove_request
and kfree when the QoS request is NULL.

>  	freq_qos_remove_request(policy->min_freq_req);
>  	kfree(policy->min_freq_req);
>  
> @@ -1479,6 +1486,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  			goto out_destroy_policy;
>  		}
>  
> +		if (policy->boost_supported) {
> +			policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
> +							 GFP_KERNEL);
> +			if (!policy->boost_freq_req) {
> +				ret = -ENOMEM;
> +				goto out_destroy_policy;
> +			}
> +
> +			ret = freq_qos_add_request(&policy->constraints,
> +						   policy->boost_freq_req,
> +						   FREQ_QOS_MAX,
> +						   FREQ_QOS_MAX_DEFAULT_VALUE);
> +			if (ret < 0) {
> +				/*
> +				 * So we don't call freq_qos_remove_request() for an
> +				 * uninitialized request.
> +				 */
> +				kfree(policy->boost_freq_req);
> +				policy->boost_freq_req = NULL;
> +				goto out_destroy_policy;
> +			}
> +		}
> +
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
>  	}
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 0465d1e6f72ac..c292a6a19e4f5 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>  	struct freq_constraints	constraints;
>  	struct freq_qos_request	*min_freq_req;
>  	struct freq_qos_request	*max_freq_req;
> +	struct freq_qos_request *boost_freq_req;
>  
>  	struct cpufreq_frequency_table	*freq_table;
>  	enum cpufreq_table_sorting freq_table_sorted;


