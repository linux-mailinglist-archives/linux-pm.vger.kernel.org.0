Return-Path: <linux-pm+bounces-43184-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMUGJntfnmmaUwQAu9opvQ
	(envelope-from <linux-pm+bounces-43184-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 03:33:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9AA190ED9
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 03:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2B943070BCC
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 02:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF082874F8;
	Wed, 25 Feb 2026 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xmzTt8MM"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D7228CA9;
	Wed, 25 Feb 2026 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986808; cv=none; b=tb9hka5eGJL7egstOprr2dcCf+RPYodk2zsC7RRYCS3lUq+wcAnhrvulu7Yntjq+XpcpCu0SWMnTMClrPIlVQwOfTrLttOrqlClDFuPXcTmwhcktpnL0jMK/0BV8yY+FdRDvH5SrEgpPhEKKT5MkPe4PzaU9WLuIPlupkqTJKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986808; c=relaxed/simple;
	bh=ZoCjddNvuEzUOXn5SEMQO9ZdtFPkZpKtvTJArXVvnEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EFxczg9CFD6Vdi9PRQCNF+lYE69NV9Dq1oSDfq608hXeFCYZaHVf/IJA+IOSHnDwjrAuMY7Z6UHbKTWLkBZlriHMOJ6+kTfyQ4vu5ClOdSsGX7uOP2GOGlFT3vyVrpMIDQ0FzecgZ/FVP7FzavT07NAcD48xA7RsINl2pkj4XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xmzTt8MM; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5GzxD61bH6hafFB3uyRVaALtd4AZHQzkqilJDleWmWk=;
	b=xmzTt8MMXEG2g3KLs6zoYU2oEulpDaU0lBBGHfDGFqgFdtKFJhE5gf3IJdgy7y3Vv/ol+ME6O
	V7xEmVY4CjVew6njjKmr91grwYApksL18iO8woIhatYPPCZ74q7TXMKBwOQ90M7IAfAMFHkWZOj
	ugAhRAeiNYAD+u/98ufyD9o=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fLJRm0fDtzKm65;
	Wed, 25 Feb 2026 10:28:36 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 6048140567;
	Wed, 25 Feb 2026 10:33:23 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Feb
 2026 10:33:22 +0800
Message-ID: <01459267-8151-434c-8963-f37ac1eb106a@huawei.com>
Date: Wed, 25 Feb 2026 10:33:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, Christian Loehle
	<christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown
	<lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20260224170828.1635135-1-pierre.gondois@arm.com>
 <20260224170828.1635135-3-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260224170828.1635135-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-43184-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Queue-Id: 8A9AA190ED9
X-Rspamd-Action: no action

On 2/25/2026 1:08 AM, Pierre Gondois wrote:
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
>  drivers/cpufreq/cpufreq.c | 41 ++++++++++++++++++++++++++++++++++-----
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index db414c052658b..52efa4805afee 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1359,17 +1359,25 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
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
> -		freq_qos_remove_request(policy->max_freq_req);
>  	}
>  
> +	if ((policy->max_freq_req && !policy->boost_supported) ||
> +	    policy->boost_freq_req) {

Is this if statement written in the wrong place?

> +		freq_qos_remove_request(policy->boost_freq_req);
> +		kfree(policy->boost_freq_req);
> +	}
> +
> +	if (policy->max_freq_req)
> +		freq_qos_remove_request(policy->max_freq_req);
> +
>  	freq_qos_remove_request(policy->min_freq_req);
>  	kfree(policy->min_freq_req);
>  



