Return-Path: <linux-pm+bounces-21443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD8A29F86
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 04:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62693A6EEB
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 03:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEFF146A6F;
	Thu,  6 Feb 2025 03:59:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB03376;
	Thu,  6 Feb 2025 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738814344; cv=none; b=KV+1+SMgRJPatDwpsJrYUseOnCOaUD9r/Kzc74K3a+CDx8lArO5HRQ+9tVCfesM1R2ThzipN0RK/5/uW/zUACltGG0gXGw1Fe6uhYaYO5Nz4MKgSr37PkiG4+3Iq5twvvdHCJcdh65aTydwv2n3Eq4Ov7MAN2KqcX7jAhvvI/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738814344; c=relaxed/simple;
	bh=NXrBsW1o62rRxCZBogrVabt+2lDIaLYgx0RRsmkSp/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mA2RyKrWVHIgfp+2KegiMWwOreILx8MzbJx32ycVLT31lacLJk5HUHqbOZrf0HmFCRtb7Z799B2iGX/bNTVSprTuM/q+Gc8CxCiL4+TGWMA1OJn4++KUvxwYqO1OkYGHvFCbTtLHVUTGhnhEkiP0+G71elyTwTbRNHP5OoGD6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YpNXy0hBBz1V59F;
	Thu,  6 Feb 2025 11:55:14 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A1551A0188;
	Thu,  6 Feb 2025 11:58:52 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Feb
 2025 11:58:52 +0800
Message-ID: <d7acce9e-fafc-4b1d-80f9-2ddc46b5a28d@huawei.com>
Date: Thu, 6 Feb 2025 11:58:51 +0800
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

I have a little question. With the old boost_supported flag as false, it
will fail when you operate the global boost flag. But if you replace it
with the per-policy boost_supported flag, the global boost_enabled flag can
be set to true without any error, even no policy's boost_enabled flag
changed. Is this interface behavior change OK?

