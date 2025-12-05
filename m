Return-Path: <linux-pm+bounces-39227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA162CA5DB0
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 02:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4553A3042280
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B28217722;
	Fri,  5 Dec 2025 01:50:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468F1E572F;
	Fri,  5 Dec 2025 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899449; cv=none; b=NbPGAFAph4r2o6HEDjV1rPIqzS/cNdR0JMgiixye6c6mENEO47B1Hjo93G9SH8J2tnxakVgCUPsS2buv3XQFrOK7eppu6g+a1zL7UXET1smb7b/Objl2j2TTJueP2+tbwwJO20yjqGUfgKoioHdKIRK/qeuk2bT5NuQSLssaGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899449; c=relaxed/simple;
	bh=eMiOMB4mwKKJXPnUMO3tg1y/OGSZWM7FGGMRhKR+mMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m/rSkE15oaZhWPFhurAl9+N/wn8DZl+boaGk1r7swMU/kxxA3ABLekQBWjAiGAz3WAPMOXsLy/TCmvSiwOY/RFrQOOI6Pxt6/8Li0tEXwkgk8qPKDV/f09n5ZNAtrJykPJOgYh8m8ay/BkNNRmuQPnHsy6eHB3aCKwWbjh0zwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dMvRk1YlvzKm4c;
	Fri,  5 Dec 2025 09:48:50 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 0863D1A0188;
	Fri,  5 Dec 2025 09:50:44 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Dec
 2025 09:50:43 +0800
Message-ID: <744b0c91-4164-4532-a4f3-3496141fd869@hisilicon.com>
Date: Fri, 5 Dec 2025 09:50:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: cpufreq_boost_trigger_state()
 optimization
To: Lifeng Zheng <zhenglifeng1@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20251202072727.1368285-1-zhenglifeng1@huawei.com>
 <20251202072727.1368285-3-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20251202072727.1368285-3-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 12/2/2025 3:27 PM, Lifeng Zheng wrote:
> Optimize the error handling branch code in cpufreq_boost_trigger_state().
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
LGTM.  Thanks!

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a4399e5490da..a2507a5b42d9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2823,19 +2823,14 @@ static int cpufreq_boost_trigger_state(int state)
>  			continue;
>  
>  		ret = policy_set_boost(policy, state);
> -		if (ret)
> -			goto err_reset_state;
> +		if (unlikely(ret))
> +			break;
>  	}
>  
> -	if (ret)
> -		goto err_reset_state;
> -
>  	cpus_read_unlock();
>  
> -	return 0;
> -
> -err_reset_state:
> -	cpus_read_unlock();
> +	if (likely(!ret))
> +		return 0;
>  
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  	cpufreq_driver->boost_enabled = !state;

