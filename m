Return-Path: <linux-pm+bounces-16949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B29BB52D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DBC282931
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB441B6D03;
	Mon,  4 Nov 2024 12:57:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78906188700;
	Mon,  4 Nov 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725065; cv=none; b=jFMYr5/yY6jxqD9I8/QayEkZV4ygCSCHkclmZtUPPqvWcn0AR7pKTQemzoXM1KJmjUyc1EWN8F0Oo9g61x1GkT73gGB9YeGSSWNsIV3vUo5JPcdMvKuI3s7TdD8QQ4ByAC2wM5MO7+sTil11+WPJUfqJ2vRbrvkQGoiqw2dJ4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725065; c=relaxed/simple;
	bh=WakpZ45SAoJYuFrodrj3caj9Ni7wC0ApyJa4QVHu6x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pQocQHvAqdKGUciDYw4AiT9/Jx7SEPT9eqt/5sns4XiQLRVWWkgylCDPFz6WWsOAbkzahGyUmeRSgEQ9bwtWloJqSa4BflHqoUExPGm3m63pOHsPGMUy2ogfGkueFkuuCAnt/Jpo6LGb7XjmIwob1qgJ6OagvMjLly8INRPHmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56B4AFEC;
	Mon,  4 Nov 2024 04:58:12 -0800 (PST)
Received: from [10.57.56.89] (unknown [10.57.56.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91BD3F6A8;
	Mon,  4 Nov 2024 04:57:40 -0800 (PST)
Message-ID: <9f7a33a6-ac69-4fac-946a-ccb90060d243@arm.com>
Date: Mon, 4 Nov 2024 12:58:57 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Fix wrong return value in
 mtk_cpufreq_get_cpu_power()
To: Jinjie Ruan <ruanjinjie@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, hector.yuan@mediatek.com,
 qperret@google.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241104113615.1397410-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241104113615.1397410-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/4/24 11:36, Jinjie Ruan wrote:
> mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
> em_create_perf_table(), the later zero check for power is not invalid
> as power is uninitialized. As Lukasz suggested, it must return -EINVAL when
> the 'policy' is not found. So return -EINVAL to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Fix the driver instead of em_create_perf_table() as suggested.
> - Update the commit message.
> - Add Suggested-by.
> ---
>   drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 8925e096d5b9..aeb5e6304542 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -62,7 +62,7 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
>   
>   	policy = cpufreq_cpu_get_raw(cpu_dev->id);
>   	if (!policy)
> -		return 0;
> +		return -EINVAL;
>   
>   	data = policy->driver_data;
>   

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

