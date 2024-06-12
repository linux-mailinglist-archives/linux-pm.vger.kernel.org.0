Return-Path: <linux-pm+bounces-9004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB046904ECC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 11:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAF21C20995
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C4F16D4E3;
	Wed, 12 Jun 2024 09:09:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF17B33D0;
	Wed, 12 Jun 2024 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183346; cv=none; b=FDuIFdVUJOI2KjNY3D272A2JVwkvmom1EydRcTHwfzjcpx7OGCgFI3lMZkOUVaDlFrIhnQdbg3fr6fiRHlvpVgaDE5stR3dbLrfLFVnRcKsE2ZmFBxPNA0s0hKmVDqOSBOBVs0GZBSRBeEzm4EfLMxu0AB2/Jhx07pOVzFLza+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183346; c=relaxed/simple;
	bh=ekVvXOtgEWGc5upJE6j41XAzTm9If7AcFpwlPUsRGRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYBNn/t6D/fLOmZevU5yBZqYjkJxisLr9YqUGXXI/70NIOZLBCzhaKw950hWb8FVhVC/5GBimitdtHMQ+tcbCFmLvc1araGAvE9rmlqkbsPXhgctGJYESNuuQ58jK0aqgWkJXL4ORU5+kIznATSCK7NFHZyn47OISFQNEWxrZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 479401595;
	Wed, 12 Jun 2024 02:09:27 -0700 (PDT)
Received: from [10.57.69.241] (unknown [10.57.69.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC5043F64C;
	Wed, 12 Jun 2024 02:09:00 -0700 (PDT)
Message-ID: <dd536c45-cf2a-4b00-b1cc-c23e3157a4b8@arm.com>
Date: Wed, 12 Jun 2024 11:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when set
 target
To: Riwen Lu <luriwen@hotmail.com>
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rafael@kernel.org,
 linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
 beata.michalska@arm.com, hotran@apm.com, Riwen Lu <luriwen@kylinos.cn>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Riwen,

This function seems to be the only cpufreq function saving and comparing the
requested frequency with the last requested frequency. This seems to be more the
task of the cpufreq framework than the cpufreq driver.

So FYIW, the patch looks good to me.

On 5/30/24 13:08, Riwen Lu wrote:
> From: Riwen Lu <luriwen@kylinos.cn>
> 
> There is a case that desired_perf is exactly the same with the old perf,
> but the actual current freq is not.
> 
> This happened in S3 while the cpufreq governor is set to powersave.
> During cpufreq resume process, the booting CPU's new_freq obtained via
> .get() is the highest frequency, while the policy->cur and
> cpu->perf_ctrls.desired_perf are in the lowest level(powersave
> governor). Causing the warning: "CPU frequency out of sync:", and set
> policy->cur to new_freq.

(new paragraph)

Then the governor->limits() calls
> cppc_cpufreq_set_target() to configures the CPU frequency and returns
> directly because the desired_perf converted from target_freq is the
> same with cpu->perf_ctrls.desired_perf and both are the lowest_perf.

(new paragraph)

> Since target_freq and policy->cur have been compared in
> __cpufreq_driver_target(), there's no need to compare desired_perf
> and cpu->perf_ctrls.desired_perf again in cppc_cpufreq_set_target()
> to ensure that the CPU frequency is properly configured.

NIT:
Would it be possible to make distinct paragraphs ?

> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> 
> ---
> v1 -> v2:
>   - Update commit message and email.
> v2 -> v3:
>   - Update patch subject and commit message.
>   - Remove the desired_perf compare logic.
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 15f1d41920a3..337cece61ab5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -295,9 +295,6 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>   	int ret = 0;
>   
>   	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
> -	/* Return if it is exactly the same perf */
> -	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
> -		return ret;
>   
>   	cpu_data->perf_ctrls.desired_perf = desired_perf;
>   	freqs.old = policy->cur;

