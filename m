Return-Path: <linux-pm+bounces-39226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBE4CA5DAA
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 02:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2679630213FE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC81E5734;
	Fri,  5 Dec 2025 01:50:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544132DF68;
	Fri,  5 Dec 2025 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899409; cv=none; b=TQkhavKQXtDMnYuwbv0GcmqyYB9tSM63bf4FvEGFul30uqWtDi1VD1u8f/pxQyLl76g11vwMo/6qdLZLMa7IQ3o0L/DH+BwJX3a9Jib9HZDZDr+eQqMnpAVvL/yq3h7mMidwAgtHNwBUln4jBSGk5dkHus1WY13r2Q2XOTbfN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899409; c=relaxed/simple;
	bh=6p8RiLr4LspxOLl/fuqHbZklbyCVfvUSNKBL9FbYdwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OyDQcjvhInc00RwryLlCAMlhHv5HvagxCXEBPrNP1KI7cwHrSFo4cqSuUg5qpcOLdK1tSRZH6QLfPf02Gxk628yA6ZAorkodjJa+q3ytN+WcClXW+4iGpPxnN3IO8vLfe3QJalKjguy2VY0gQPpqtIP3E44LHE9uKk7szUcrTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dMvQw5s19z1prMW;
	Fri,  5 Dec 2025 09:48:08 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 54B491402CC;
	Fri,  5 Dec 2025 09:50:03 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Dec
 2025 09:50:02 +0800
Message-ID: <bad4857d-ba90-4587-b36f-6999fc66a898@hisilicon.com>
Date: Fri, 5 Dec 2025 09:50:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cpufreq: Return -EOPNOTSUPP if no policy is boost
 supported
To: Lifeng Zheng <zhenglifeng1@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20251202072727.1368285-1-zhenglifeng1@huawei.com>
 <20251202072727.1368285-2-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20251202072727.1368285-2-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)


On 12/2/2025 3:27 PM, Lifeng Zheng wrote:
> In cpufreq_boost_trigger_state(), if all the policies are boost
> unsupported, policy_set_boost() will not be called and this function will
> return 0. But it is better to return an error to indicate that the platform
> doesn't support boost.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
LGTM.  Thanks!

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e8d7544b77b8..a4399e5490da 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2806,7 +2806,7 @@ static int cpufreq_boost_trigger_state(int state)
>  {
>  	struct cpufreq_policy *policy;
>  	unsigned long flags;
> -	int ret = 0;
> +	int ret = -EOPNOTSUPP;
>  
>  	/*
>  	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
> @@ -2826,6 +2826,10 @@ static int cpufreq_boost_trigger_state(int state)
>  		if (ret)
>  			goto err_reset_state;
>  	}
> +
> +	if (ret)
> +		goto err_reset_state;
> +
>  	cpus_read_unlock();
>  
>  	return 0;

