Return-Path: <linux-pm+bounces-39387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83999CB1C3B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 04:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D33EC301C9D3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 03:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438781C860C;
	Wed, 10 Dec 2025 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RhdvN3S9"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDF8C1F;
	Wed, 10 Dec 2025 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765335705; cv=none; b=a7AMloO8Gl00gWaAAKdCj9FMIVghkGSva8rcUtIMc+q6ocu4sIZ28nL09f1IbK5voUvhPKAPK9lQs9PuK/Y5MobQBo9fcv6bzNnoPAtkbJvO5oYq3+W1HwiB4317KxD0+3VK/rp16TLQmMNrVmP/3vI4qbWPIJDu2mcwlekmLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765335705; c=relaxed/simple;
	bh=P4Hf4zP6vqPRW2Shp3L9stGuEfdOM2tcPMHCdfnLzvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c/x1dt7TnsU+k94k6YkqpJ1WmKrPTNlPIQwWDZZBSlztDzzdl0d9mA0kWIlq+HgDSo6wZLv6+uJYzxb/ehRh/2UBY87uqFB7nC33qagQOszl3acLNfkwXfZ2Mb9pF2RUOYUkNLHQOuk1oQuw1yWz0NLEMFUBG4lY/Tw3+sg0dJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RhdvN3S9; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EdssyuywRcxh4SYIbjsD+sxsKX1U/KH8s68W/Dq95Os=;
	b=RhdvN3S9KCGgcrNEW6mPUiiuSbu6Y6Gg8YTi+7caWaTALg6BZDcWfbd1C/OV4yN4otRPzUtWo
	51jvcRgD4qVSq9LvxGp2ee69bX2hDyWw5LhJrQNbZVWuAgil+dEVARWDr+ldO/2oC/0pSiOMKkN
	e7N7qVHlvGLjcPvAi0HaoBY=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dR0nB17fRzKm6G;
	Wed, 10 Dec 2025 10:59:42 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 079E4140144;
	Wed, 10 Dec 2025 11:01:39 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Dec
 2025 11:01:38 +0800
Message-ID: <416196db-ad73-42d3-8e52-bc120a822f31@huawei.com>
Date: Wed, 10 Dec 2025 11:01:37 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-kernel@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Jie
 Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-2-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251208105933.1369125-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/8 18:59, Pierre Gondois wrote:
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
>  drivers/cpufreq/cpufreq.c | 28 ++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 852e024facc3c..942416f2741b0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1359,6 +1359,11 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	/* Cancel any pending policy->update work before freeing the policy. */
>  	cancel_work_sync(&policy->update);
>  
> +	if (policy->boost_freq_req) {
> +		freq_qos_remove_request(policy->boost_freq_req);
> +		kfree(policy->boost_freq_req);
> +	}
> +
>  	if (policy->max_freq_req) {
>  		/*
>  		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY

If adding boost_freq_req fails, CPUFREQ_CREATE_POLICY notification will
never be sent but CPUFREQ_REMOVE_POLICY notification will be sent here. So
maybe something like this is better:

@@ -1365,17 +1365,28 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
        /* Cancel any pending policy->update work before freeing the policy. */
        cancel_work_sync(&policy->update);
 
-       if (policy->max_freq_req) {
+       if (policy->boost_freq_req) {
                /*
-                * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
+                * Remove boost_freq_req after sending CPUFREQ_REMOVE_POLICY
                 * notification, since CPUFREQ_CREATE_POLICY notification was
-                * sent after adding max_freq_req earlier.
+                * sent after adding boost_freq_req earlier.
                 */
                blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
                                             CPUFREQ_REMOVE_POLICY, policy);
-               freq_qos_remove_request(policy->max_freq_req);
+               freq_qos_remove_request(policy->boost_freq_req);
+               kfree(policy->boost_freq_req);
        }
 
+       if (policy->max_freq_req && !policy->boost_supported) {
+               /*
+                * Send CPUFREQ_REMOVE_POLICY notification here if
+                * boost_freq_req is not present.
+                */
+               blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+                                            CPUFREQ_REMOVE_POLICY, policy);
+       }
+
+       freq_qos_remove_request(policy->max_freq_req);
        freq_qos_remove_request(policy->min_freq_req);
        kfree(policy->min_freq_req);

---
It's a bit verbose, but I can't think of a better way.

> @@ -1476,6 +1481,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
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
>  	} else {
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


