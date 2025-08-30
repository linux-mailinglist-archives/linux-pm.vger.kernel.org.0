Return-Path: <linux-pm+bounces-33443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95CFB3C7CC
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 06:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597BB7B90D1
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 04:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB32773F8;
	Sat, 30 Aug 2025 04:11:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A78128395;
	Sat, 30 Aug 2025 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756527070; cv=none; b=bmuMWtBRJVAtWp6RxcdJG0z/vpGguR9iYTdpszvmqhA8B6YV66y1rqz1qOj5YHeC1wQl+L2uKVKyPIYF7K4NWgRiX0ppvlPCQRSzmQXGu5644vBSq1TR+V6CTeTumvE/jcrlwTVaImpJjisdJpOxFjQuYMKB0jQRAEOAFWufKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756527070; c=relaxed/simple;
	bh=J4d0MFDjBjezhD52aa98781cRNE9lgE58Y/45hrGuW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YRinPkOyQnZYRg00PdHMx+aQz8nopDz93ZHqO0G4V3BVXtOYq5MVfI00akrmP3DZqyu936viwvgzf82OJIgeCPLuFtDU9sfvvgivQiwxZY4KK4ISz9uvGrspwoM4uDJq4CaixPiOYnwfu+Rq0LfUntc5KN88V26ZdluBOqT2AoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cDMBS1wCKz14Mfm;
	Sat, 30 Aug 2025 12:10:56 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A2A3180485;
	Sat, 30 Aug 2025 12:11:04 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 30 Aug
 2025 12:11:03 +0800
Message-ID: <4639ba1d-110b-9000-f2a9-7bb1cacf8d63@hisilicon.com>
Date: Sat, 30 Aug 2025 12:11:03 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 2/3] cpufreq: Add a new function to get cpufreq policy
 without checking if the CPU is online
To: Lifeng Zheng <zhenglifeng1@huawei.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<beata.michalska@arm.com>, <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <linhongye@h-partners.com>
References: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
 <20250819072931.1647431-3-zhenglifeng1@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250819072931.1647431-3-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 19/08/2025 15:29, Lifeng Zheng wrote:
> cpufreq_cpu_get_raw() gets cpufreq policy only if the CPU is in
> policy->cpus mask, which means the CPU is already online. But in some
> cases, the policy is needed before the CPU is added to cpus mask. Add a
> function to get the policy in these cases.
> 
LGTM.

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ++++++
>  include/linux/cpufreq.h   | 5 +++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..78ca68ea754d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -198,6 +198,12 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
>  
> +struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu)
> +{
> +	return per_cpu(cpufreq_cpu_data, cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_cpu_policy);
> +
>  unsigned int cpufreq_generic_get(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 95f3807c8c55..26b3c3310d5b 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -205,6 +205,7 @@ struct cpufreq_freqs {
>  
>  #ifdef CONFIG_CPU_FREQ
>  struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
> +struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu);
>  struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
>  void cpufreq_cpu_put(struct cpufreq_policy *policy);
>  #else
> @@ -212,6 +213,10 @@ static inline struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>  {
>  	return NULL;
>  }
> +static inline struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu)
> +{
> +	return NULL;
> +}
>  static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>  {
>  	return NULL;

