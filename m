Return-Path: <linux-pm+bounces-39201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED341CA38DF
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 13:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 282E83071ABA
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479433E36C;
	Thu,  4 Dec 2025 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r5ya2W2W"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF100315D47;
	Thu,  4 Dec 2025 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850149; cv=none; b=Qi1OYnKNf8eHXRUGeSThBpHRbPxM43Afcmmf9Rrb/spqfAMhYFnvk+0Wep/IjOl8Pn+R1FEjLSV3vdncwmfrBappfdbmLSn3ROfct8hLmjh367l6LpU8ZM0s/Qk7EuweeKBbWtTp4DDEOjusj5G5CSN60qRvxIeLVJRF9XnDB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850149; c=relaxed/simple;
	bh=ejCsgYHT0V+jjxe4fr8Q0LHUEJhgSd78ohG8yBc6FCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AZJH0P3hiaOv71w9h6zVVGQC7aY/0o/MWu8ZKxLjfZTbd/PTm+je7wenOse4h+vsUaPM2EA3tCHMrcU/L3XKye5vzTOlkBFZgP6nn2h5DEg75vLRCKibWBz68TABne0E47CdTAxsYfiTKmWyh02L0iN1Hq2++uD16+47KUBiyL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r5ya2W2W; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ySb4VcpQywSPWjFen5U5AFIEZWXUKm4VZjuXBn9IO+8=;
	b=r5ya2W2W/H3BJEsF3YU+7BbJqqh7dCDpjwMS4Hzu9oZEUgbD9k8PIoq6kAcuNAqd9yPJHAvuQ
	eJcvRckHn2N+qQSXRkRAxyIB3AZMv70zVGQq77d6Eei3KHHDrR0UUVCVqaQTBbYHgU8c+W7IafT
	iAxR72aklXOjtZZ9TcSUWbI=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dMYBx6FLlzcb07;
	Thu,  4 Dec 2025 20:06:33 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id BD84818047B;
	Thu,  4 Dec 2025 20:09:03 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 20:09:03 +0800
Message-ID: <6bb8f60f-bbeb-42c7-ac18-e996db6379bd@huawei.com>
Date: Thu, 4 Dec 2025 20:09:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] Revert "cpufreq: Fix re-boost issue after
 hotplugging a CPU"
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-kernel@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Jie
 Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
References: <20251204101344.192678-1-pierre.gondois@arm.com>
 <20251204101344.192678-2-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251204101344.192678-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/4 18:13, Pierre Gondois wrote:
> policy->max_freq_req represents the maximum allowed frequency as
> requested by the policyX/scaling_max_freq sysfs file. This request
> applies to all CPUs of the policy. It is not possible to request
> a per-CPU maximum frequency.
> 
> Thus, the interaction between the policy boost and scaling_max_freq
> settings should be handled by adding a boost specific QoS constraint.
> This will be handled in the following patches.
> 
> This reverts commit 1608f0230510489d74a2e24e47054233b7e4678a.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 852e024facc3c..11b29c7dbea9e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1478,10 +1478,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
> -	} else {
> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -		if (ret < 0)
> -			goto out_destroy_policy;
>  	}
>  
>  	if (cpufreq_driver->get && has_target()) {

I don't think this commit should be reverted individually. These changes
can be included in patch 4, as they are doing the same thing if I
understand it correctly.


