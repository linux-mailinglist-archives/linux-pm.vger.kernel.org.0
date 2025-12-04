Return-Path: <linux-pm+bounces-39197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC364CA37B6
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 236B2301738F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EBC2F25F0;
	Thu,  4 Dec 2025 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IMgP9Rqq"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94E2C08D0;
	Thu,  4 Dec 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849031; cv=none; b=iVbOziPv/BTXGSfHav9218YT2ejV1dY3fqOWBCUAkS5ewzk1/v/PaGvU8qYtvlNaDuMH7krlvzC5q10wpvnAQABE1y1R9tGMnyxczgoXUxeG+OXoEKBz1ulBzIn7SORweSriis4SJ6fXWmojXWGsj+SlgfUvQH9xcYWe6djxL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849031; c=relaxed/simple;
	bh=lThXzWYmXcZ3gpSxBohvbapXKi045t4JMgKRquj3SXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=surdiDpcr/wU1jbDsUS4QAnWGM9jrZ+aKwIZrcpFr2VFkjXiBdkLtydFJIcgOt5WLI1I3t2f09xa6qao0JWF/KaddJvxwaztyEogaOANNcSPhaRIjPGLG7+Zkk/fI1cSYZNq82HMI1SCL1FXx2OEeYx21z4FpVVrwqd4Mety8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IMgP9Rqq; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aQ8PT4t/IbhLw5Egcdeo8SIqAZa+ebhhoHKQOPuhdIs=;
	b=IMgP9RqqcmqitzoKdK/Gcxw534BIWe0/CPv2NK/TqqGnQtaBTTLN0DShfdLAxpQmTVVBnJhL6
	ahuo/HfIt0xxybvNmytvDi4E7J9d01AKAp5gks0T2/BOIGpY3JBkYdWgD141kIxrVIplIZU72K1
	PqurqFXlhzFDyGJrir4AR1A=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dMXp60r20z1T4GD;
	Thu,  4 Dec 2025 19:48:30 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 2644A180488;
	Thu,  4 Dec 2025 19:50:24 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 19:50:23 +0800
Message-ID: <080d40e0-f004-42dc-aecc-3c3af291d374@huawei.com>
Date: Thu, 4 Dec 2025 19:50:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-kernel@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Jie
 Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
References: <20251204101344.192678-1-pierre.gondois@arm.com>
 <20251204101344.192678-3-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251204101344.192678-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/4 18:13, Pierre Gondois wrote:
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
>  drivers/cpufreq/cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 11b29c7dbea9e..23f64346b80f8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1370,6 +1370,18 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  		freq_qos_remove_request(policy->max_freq_req);
>  	}
>  
> +	if (policy->boost_freq_req) {
> +		/*
> +		 * Remove boost_freq_req after sending CPUFREQ_REMOVE_POLICY
> +		 * notification, since CPUFREQ_CREATE_POLICY notification was
> +		 * sent after adding boost_freq_req earlier.
> +		 */
> +		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> +					     CPUFREQ_REMOVE_POLICY, policy);

The CPUFREQ_REMOVE_POLICY notification is sent before removing
max_freq_req, I don't think it should be sent again here.

> +		freq_qos_remove_request(policy->boost_freq_req);
> +		kfree(policy->boost_freq_req);
> +	}
> +

I think boost_freq_req should be removed before removing max_freq_req,
since it was added after adding max_freq_req as shown below.

>  	freq_qos_remove_request(policy->min_freq_req);
>  	kfree(policy->min_freq_req);
>  
> @@ -1476,6 +1488,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  			goto out_destroy_policy;
>  		}
>  
> +		if (policy->boost_supported) {
> +			policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
> +				GFP_KERNEL);
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


