Return-Path: <linux-pm+bounces-42193-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E6RE5eVhWk7DwQAu9opvQ
	(envelope-from <linux-pm+bounces-42193-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 08:17:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6169FAE47
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 08:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1EEE300D157
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59B2EBB90;
	Fri,  6 Feb 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cZbaltov"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8452266B72;
	Fri,  6 Feb 2026 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362259; cv=none; b=CN+2NVGS6ASXwpiPTVNgeQjehm23C2dpU9WUPRQ9svmklgM0n1XFigXMqAG0ly4hTtiUayT3zjrKdF0neZ2TmVZopYnteGeAEdYR4H8Sdh4vxsrO4ce85UxkSXn+k7YJruq7YU7pIOXdGCV9G4NUaPLHDH4N26Wpexr3EXpwFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362259; c=relaxed/simple;
	bh=55JrrP6ZCdz1PmtIb8/wkJ2nvRfJiFp0wtRT83waXEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mZkZ0yOtg2b/3H8Vd9j8nKEAX1S2PM7L45eG8HJAkFakaeGl0Y3ZtWiynkXisRyydmn8EYQ2MY8Wrfc9Imtl5JrqVURd5D9g+j75HEGEu5oWijMzoJVXefLNs3jg45sH+6UdZnRZVnZ0Nml3SDTD8oz1+G3KYu3qNucNM2EK2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cZbaltov; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WqFqsrNUfk7v30eJycZT2m37sawRQ6vSY5xz72oh79M=;
	b=cZbaltovPiXPFAY2d6zEb8XahGuD4J9IOnTSu9yta60X5Gvh0qF0HRnMjpOYsCfP9gyOI8/El
	Iop9UBBJUynb3wQfjlhLdxUbagSU4LjgT96pliIIiK+jPmbEmDg8y+hIjEstqoU2rsF21v6idnU
	cmLS60TKN20UmS9nV4AYILI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f6lfs2dhWz1T4Fj;
	Fri,  6 Feb 2026 15:13:09 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DAAD2012A;
	Fri,  6 Feb 2026 15:17:34 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 15:17:33 +0800
Message-ID: <8c174633-4005-4e52-bb6b-9e9c6181b12b@huawei.com>
Date: Fri, 6 Feb 2026 15:17:33 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cpufreq: Remove per-CPU QoS constraint
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
 <20260126101826.94030-2-pierre.gondois@arm.com>
 <f1ffeb2e-d235-454e-8425-490ea2d076e9@huawei.com>
 <1a9295be-49ee-4fc5-acfa-ac353c8c56e5@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <1a9295be-49ee-4fc5-acfa-ac353c8c56e5@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-42193-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: E6169FAE47
X-Rspamd-Action: no action

On 2026/2/5 21:59, Pierre Gondois wrote:
> 
> On 1/31/26 04:28, zhenglifeng (A) wrote:
>> On 2026/1/26 18:18, Pierre Gondois wrote:
>>> policy->max_freq_req represents the maximum allowed frequency as
>>> requested by the policyX/scaling_max_freq sysfs file. This request
>>> applies to all CPUs of the policy. It is not possible to request
>>> a per-CPU maximum frequency.
>>>
>>> Thus, the interaction between the policy boost and scaling_max_freq
>>> settings should be handled by adding a boost specific QoS constraint.
>>> This will be handled in the following patches.
>>>
>>> This patch reverts of:
>>> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
>>> a CPU")
>>>
>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>> ---
>>>   drivers/cpufreq/cpufreq.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 4472bb1ec83c7..db414c052658b 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>             blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>>                   CPUFREQ_CREATE_POLICY, policy);
>>> -    } else {
>>> -        ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>>> -        if (ret < 0)
>>> -            goto out_destroy_policy;
>> I think this shouldn't be the first patch. This can be removed only after
>> adding boost_freq_req, otherwise it's letting the problem out again.
> 
> 
> Would it be ok to change the order of the patches (i.e. patch 1 and 2) instead of melding this change in another patch ?
> 

I tested the patch on my machine, and it seems the original problem no
longer exists. So I now think it's OK to revert this commit.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

> 


