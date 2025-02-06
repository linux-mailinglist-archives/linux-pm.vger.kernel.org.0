Return-Path: <linux-pm+bounces-21446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45572A2A0E6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 07:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9953A1E24
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3422370F;
	Thu,  6 Feb 2025 06:27:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65192561D;
	Thu,  6 Feb 2025 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823275; cv=none; b=crMrpwaqngQD7/YcAkZGrnbut1evD0sGR8dgsxafIn00ZsMo6JPGRBql0p1cYh7uRHJ9dqdkyOXJHqX7htwi9OS44uIT6GqUmzwQXHcwztN459Aiu2+7jorEQoPyYZIOZhfykokKmj02shk9EZ0iEDOxNtuwimORXwIzF2Ra8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823275; c=relaxed/simple;
	bh=YBHaTZW+tpKp36RzIrAFZSbRfY45BlzSnxis70lzJM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c9nGgK6QNkrEeJc6u2OPQvMndeXxeHupk44SbtMXoS00sW6ub/7ndUtbAgjuYI4twRxE42xhKT7ygIBZzOBJx/sdNacdusy2Xq0bmAonevEHTZoWrGP2ljAFOS9hXHCT6sKF8TXxWFc0ObWm9oKMer2ovqN77JE3sc1hxaJfSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YpRsm60Jrz22mPq;
	Thu,  6 Feb 2025 14:25:00 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 04AF41A016C;
	Thu,  6 Feb 2025 14:27:47 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Feb
 2025 14:27:46 +0800
Message-ID: <78c6dbea-ccbc-4380-a6e9-96dd76deb999@huawei.com>
Date: Thu, 6 Feb 2025 14:27:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] cpufreq: cppc: Set policy->boost_supported
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
 <c744751c8f61cae509959270176ebdef77326ba2.1737707712.git.viresh.kumar@linaro.org>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <c744751c8f61cae509959270176ebdef77326ba2.1737707712.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/24 16:58, Viresh Kumar wrote:

> With a later commit, the cpufreq core will call the ->set_boost()
> callback only if the policy supports boost frequency. The
> boost_supported flag is set by the cpufreq core if policy->freq_table is
> set and one or more boost frequencies are present.
> 
> For other drivers, the flag must be set explicitly.
> 
> With this, the local variable boost_supported isn't required anymore.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7fa89b601d2a..08117fb9c1eb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -34,8 +34,6 @@
>   */
>  static LIST_HEAD(cpu_data_list);
>  
> -static bool boost_supported;
> -
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> @@ -653,7 +651,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	 * is supported.
>  	 */
>  	if (caps->highest_perf > caps->nominal_perf)
> -		boost_supported = true;
> +		policy->boost_supported = true;
>  
>  	/* Set policy->cur to max now. The governors will adjust later. */
>  	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
> @@ -791,11 +789,6 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>  	int ret;
>  
> -	if (!boost_supported) {
> -		pr_err("BOOST not supported by CPU or firmware\n");
> -		return -EINVAL;
> -	}
> -
>  	if (state)
>  		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
>  	else

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

