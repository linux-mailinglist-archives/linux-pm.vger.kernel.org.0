Return-Path: <linux-pm+bounces-39198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E1DCA386A
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 13:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C633035D31
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813433ADB3;
	Thu,  4 Dec 2025 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iPwbP2XC"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3302D7814;
	Thu,  4 Dec 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849770; cv=none; b=QMD7wlF5I/Lnl5L7pgn2mhFKOxTKtr0qy/wPsT2NHfJqWQFAtoUroCavvsIdLy6ABHm+rQarHfSsy7afrk8pehmIRakiHUJK+nG3/kLxZQ1yGiZqw42QGAtHJWATvImr5Bj6Siv403zCEKTosABiyBhwnsCcue8lGHugxzIAkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849770; c=relaxed/simple;
	bh=EXy57RfttO5TenCXnxLxgiwEFasRRsIs4T7aw0Y2mvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VmF9A2zs5hs/uncULHynMy1bPoZAUNcBWsYdqzH+2auFTwvNL7M3baywAbK0UAuwyGJ2HRrPA6y1z+X0P9TZkCSl0q7rNzOB6+RmRlrARTRSAaFaOzlRyo4RHzgJ7clpTX/dyiBtRSHLZxohKdZ9K54oPXUvLU6Kv29MmwqPuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iPwbP2XC; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NjFLLY9NUU3vVmlvLEhHGDM6EgMNwO0dz+W3PJGNOYk=;
	b=iPwbP2XCTGI056YcP0xaxuvgvapP7kobcfvD9hwrpPezVXBu22uvZ+A5uTsmcRLmjHa2PJ1WG
	OnLs1LNAxvIBOa1T/fN+mC4W0jwM8Lklj8OurzII6gRogi8LYwtYqvEqCvSd8YFoUa9a0l6Iul0
	yP7rL5kWRYaG8eFZvJ5aRRA=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dMY3m5Rq9zpSvc;
	Thu,  4 Dec 2025 20:00:20 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A8241401F0;
	Thu,  4 Dec 2025 20:02:42 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 20:02:41 +0800
Message-ID: <5dded7af-51fc-4766-957b-1af044c52159@huawei.com>
Date: Thu, 4 Dec 2025 20:02:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] cpufreq: Centralize boost freq QoS requests
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-kernel@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Jie
 Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
References: <20251204101344.192678-1-pierre.gondois@arm.com>
 <20251204101344.192678-4-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251204101344.192678-4-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/4 18:13, Pierre Gondois wrote:
> policy_set_boost() calls the cpufreq set_boost callback.
> Update the newly added boost_freq_req request from there:
> - whenever boost is toggled
> - to cover all possible paths
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 23f64346b80f8..9d98b98e7981c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -603,10 +603,16 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>  	policy->boost_enabled = enable;
>  
>  	ret = cpufreq_driver->set_boost(policy, enable);
> -	if (ret)
> +	if (ret) {
>  		policy->boost_enabled = !policy->boost_enabled;
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
> +	if (ret < 0)

I think policy->boost_enabled should be set to !policy->boost_enabled here,
too. It'll be confusing if users got an error but set the enabled flag
successfully.

> +		return ret;
> +
> +	return 0;
>  }
>  
>  static ssize_t store_local_boost(struct cpufreq_policy *policy,


