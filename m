Return-Path: <linux-pm+bounces-25338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD9A87549
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 03:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D820188EAA5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 01:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D41F17A303;
	Mon, 14 Apr 2025 01:35:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0C17A2EA;
	Mon, 14 Apr 2025 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744594511; cv=none; b=EYgpv6i1fPKSb+K4s9cDAvy2IcBG+DMXa9Zv0dPAL6n+wMoZCDcfFG9keib0W8ZREEASIuJIBuI7eY9Rngg+mFbyiHayufJW2C2idVuxqjAQHH8TiSF+g6kmeVvB44KC6BLnjO8LcqebnHmtpp3+tuEmMV9IWLi0qV/FUN2yjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744594511; c=relaxed/simple;
	bh=CBAvm1+dSagG1OXbFKj8zpy52RWsL456kA7GUFDYlZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XHfqjFbTE4mRI35//VV8Bdi1QADyqrs6fuPtFX3SL5RxDcoSdO/d6l0kjo3DMzm2H30AzRbdizPg7xF5+NJJYO0itAHYNN3/YghlQcULPATTCdQ+uSm3WM9rmSq8ZuSQaCYaS6ksl/RdRdLv6wXQj7yftuuZQyTSF9qvMXBG3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZbVGD2B91zsSgt;
	Mon, 14 Apr 2025 09:35:00 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8994318005F;
	Mon, 14 Apr 2025 09:35:05 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Apr
 2025 09:35:05 +0800
Message-ID: <23466140-5d0c-435f-8e73-d1c4826930ec@huawei.com>
Date: Mon, 14 Apr 2025 09:35:03 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: Fix invalid return value in .get()
 callback
To: Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <stable@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>
References: <20250413101142.125173-1-maz@kernel.org>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250413101142.125173-1-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/13 18:11, Marc Zyngier wrote:

> Returning a negative error code in a function with an unsigned
> return type is a pretty bad idea. It is probably worse when the
> justification for the change is "our static analisys tool found it".
> 
> Fixes: cf7de25878a1 ("cppc_cpufreq: Fix possible null pointer dereference")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b3d74f9adcf0b..cb93f00bafdba 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -747,7 +747,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  	int ret;
>  
>  	if (!policy)
> -		return -ENODEV;
> +		return 0;
>  
>  	cpu_data = policy->driver_data;
>  

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

