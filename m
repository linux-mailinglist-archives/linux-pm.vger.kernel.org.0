Return-Path: <linux-pm+bounces-40830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0746DD1DAE7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57CAC3008F97
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5A32AAB3;
	Wed, 14 Jan 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5jo9mmpr"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB022D7B1;
	Wed, 14 Jan 2026 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384004; cv=none; b=bHObyPV1Fe4pg4fWI12Q1/EuXPN/YfVeCbPYAcaxN6XwZTvVD0BlZHheYY4JREiq7UtJFYvL9SgsTznz0DuqzjRVdYEbIfobFi0IvLHObyzJPONv3AoWcii0LLrVZosTlCx0QTY8v3Y4YZTXcl3rUnY4azgzenTw8w5Dx8+qbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384004; c=relaxed/simple;
	bh=FYk+f+xozHsnGSAS3m4BcQvGM9bggaWnTuTt0y9N9zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uw3zUmnopj/owmvyDXbwgrxQ5rs1FxclsLQ0IAm6TI4I656SaGtpkRuopFe3iO+XND3RiF8JQbmD4j528ibDrfnnqoG/HkdUfiT2vHvDeQSvBzHS3ltZLJHeFg2zgi4gNgtYfjqxWRR6PtCZo0VpF/jLFI0G6zIJm0XGc7USGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5jo9mmpr; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wsrP6mWtwnnMRQXneby0cjMNzQtgd6nlCorz11nyHvw=;
	b=5jo9mmprXSi7Yx1m+9oUlj0CFwIWhbGthF3s5eGT9uFXRGs7gwJr96r8PN3/MI/Uv3WWqqXeb
	h2v4ZKDoaQwtwxJQ0X3udQesufWM6xhK7d+pDeZQH3Clf0VBlbDK6WElYBOIjNw25GIxNEJLnYs
	aqv7MwxxLwPirmBhSWOjnrY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4drh486D3tzcb0B;
	Wed, 14 Jan 2026 17:42:48 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 7314240538;
	Wed, 14 Jan 2026 17:46:33 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 14 Jan
 2026 17:46:32 +0800
Message-ID: <e1b5ad4f-79ef-4c5c-8e4c-b9e7b9598d76@huawei.com>
Date: Wed, 14 Jan 2026 17:46:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] PM/devfreq: Remove unneeded casting for HZ_PER_KHZ
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park
	<kyungmin.park@samsung.com>
References: <20260114093115.276818-1-andriy.shevchenko@linux.intel.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260114093115.276818-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2026/1/14 17:31, Andy Shevchenko wrote:
> HZ_PER_KHZ is defined as UL (unsigned long), no need to repeat that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/devfreq/devfreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 00979f2e0e27..51eb67fba44b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -146,10 +146,9 @@ void devfreq_get_freq_range(struct devfreq *devfreq,
>  					     DEV_PM_QOS_MIN_FREQUENCY);
>  	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>  					     DEV_PM_QOS_MAX_FREQUENCY);
> -	*min_freq = max(*min_freq, (unsigned long)HZ_PER_KHZ * qos_min_freq);
> +	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>  	if (qos_max_freq != PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE)
> -		*max_freq = min(*max_freq,
> -				(unsigned long)HZ_PER_KHZ * qos_max_freq);
> +		*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>  
>  	/* Apply constraints from OPP interface */
>  	*max_freq = clamp(*max_freq, devfreq->scaling_min_freq, devfreq->scaling_max_freq);

Make sense. Thanks!

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

