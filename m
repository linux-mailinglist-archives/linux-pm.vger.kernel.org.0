Return-Path: <linux-pm+bounces-16629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DD69B3D08
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 22:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A731C22434
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927E1FA25F;
	Mon, 28 Oct 2024 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7IjF1A9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB91F4264;
	Mon, 28 Oct 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152094; cv=none; b=hXBQvHlCzb3Otm8/6MpquPNCSxVER/e0S+EMjwybr5uvJGxTGNheDTkucZxrxwlsOcp3+PpNeJwo6vjVwRqIbV08QlpCPWUAakKAeWwNMqP/Z1/HPsTRmXp3pqORrsth7uazn46RxWv36g6ximXSoJNZYlKBwlCsALc5tnFO1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152094; c=relaxed/simple;
	bh=8bUb1gsfUs6HYEXeSCtfQNzeRCtN2MDHAUHu6MpTaaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn/wMXG+kqeIpI1XbDVqnptiXA+AGxb/B+tIG056jxiLoJnAKmrcCLFFzspvg2epn0szEZ8mkU2rZHjhUjaM/iW7PQxRLvv/BoDX6J2OC3uSdkZPVvLFlVx/mopQskGjMV6yYwakmmcgalZUeNrsRbtnVgT48aBXmr0J2fok9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7IjF1A9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so43728921fa.0;
        Mon, 28 Oct 2024 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730152091; x=1730756891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vm7LQYDlni2urQkZBc5m5nUvilb5Q/Z0+Z8KtPs5hhI=;
        b=f7IjF1A9AGu4Q5LwTAhdbfTRqlRoGkd5lx4zp3pJtClQ7nM+vBNSJljx6TkaqKNSS6
         eBq4Bx7UVOjMtdn+zA6TBSfEx41pVZz3tfgzKV+mBXFxNJuIz0UD4dis3IjO4rxDucwx
         7uADcLr3E4q70lXRZLaBLhS31ta1qsNvpRFjm1Jd3IV0Dw5uYuLZ7jwCGp3J15AH70Nv
         Sj8wxcFbuQZbgTIEaMJaxXhmC0yrp0xFlm3ZvgrBLpLJYm9HiL79UnrkrrBN3YK97h0j
         SUatBuzanHarYlSZWeFc76/9gVhKvbHRYbxmHOYJSR56pZnCFLvxHbZXn6JYKYePr1W4
         g+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152091; x=1730756891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm7LQYDlni2urQkZBc5m5nUvilb5Q/Z0+Z8KtPs5hhI=;
        b=PrDD0bM0ZqAc3iFfyvLwfWdkYnzV02wM7Qtt5We72n5YphpzA+vWAcJmQ3ch4hpOCS
         NpI6a7oNqnC0bwaKupcYZnlbZAx+vwA+Egf6RZyBo4VHysRU8DppMAbeMu6Y5zHLWXrM
         xkPu9CKPTHKwjT6YI+7wYC/y9Sg6tcGs37tqk+c7OkpTVSGK2UlA0w30B9iiaoo9V7bJ
         N/EBMaYK0omFO9sUk/v0DMfX41+J3fZUt84/5z364g0XNg4uDKQoiItnpSyfkS96qz09
         FkQ7lK+soxOeegzA7zv4v6CxnwBdC+N+wJr2BmnL+2REG2ivw/GLy6MmrrY8y8TFwA5B
         beQg==
X-Forwarded-Encrypted: i=1; AJvYcCUGrraoMf9PfI8PbmPT1F4/qmNaC2y0yYedJIxZKRDjjLZAhc6ZHJW3kfHxlvf+5kpN/KF0PWg5NB4=@vger.kernel.org, AJvYcCWmg/mlnsqYOwKx4xg5IoZlzYCfjoM6lchwLvgCLB53DkAG+GphgdjOpTGRRaGSaWPaiLN+wJ0X9J64cco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4I4qq1jUCP2BH8bhdJq/UdQD3Ho0kIov6Cs+1XX9GHhty081
	zbrbIGzDkVulewRyJ4POxwtnWaFiPkIA5soi8jlFBWd6dxhg8vmS
X-Google-Smtp-Source: AGHT+IEKbFNaCuvTqBxgZc8XB5+hJWDhTcNj9FbAmJmzlusH2FK5buZVeTtbcw1XRNdPKO2ibo4uOw==
X-Received: by 2002:a05:651c:b12:b0:2fb:441a:90d with SMTP id 38308e7fff4ca-2fcbdfdb153mr39514281fa.21.1730152090548;
        Mon, 28 Oct 2024 14:48:10 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1b5asm12719301fa.85.2024.10.28.14.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 14:48:08 -0700 (PDT)
Message-ID: <e0fa24bd-95c4-429f-baa0-537653f8f6e9@gmail.com>
Date: Mon, 28 Oct 2024 22:48:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq/amd-pstate: Push adjust_perf vfunc init
 into cpu_init
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20241028145542.1739160-1-superm1@kernel.org>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20241028145542.1739160-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-28 15:55, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> As the driver can be changed in and out of different modes it's possible
> that adjust_perf is assigned when it shouldn't be.
> 
> This could happen if an MSR design is started up in passive mode and then
> switches to active mode.
> 
> To solve this explicitly clear `adjust_perf` in amd_pstate_epp_cpu_init().
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Klara Modin <klarasmodin@gmail.com>
>   drivers/cpufreq/amd-pstate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 206725219d8c9..e480da818d6f5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1504,6 +1504,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>   	}
>   
> +	current_pstate_driver->adjust_perf = NULL;
> +
>   	return 0;
>   
>   free_cpudata1:
> @@ -1866,8 +1868,6 @@ static int __init amd_pstate_init(void)
>   	/* capability check */
>   	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		if (cppc_state != AMD_PSTATE_ACTIVE)
> -			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   	} else {
>   		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>   		static_call_update(amd_pstate_cppc_enable, shmem_cppc_enable);

Both of these patches together also fix the problem I had.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

