Return-Path: <linux-pm+bounces-25997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB73A97D12
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 04:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07AF3A91BB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23CB263C8C;
	Wed, 23 Apr 2025 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDhl2yhh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227192E403;
	Wed, 23 Apr 2025 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377016; cv=none; b=kMilrLahdFXy8CGVSOWsNmrZHPTvKJzMGLRjLKdvgSBYNcGI4FPtBXadj5NZ+G8F0LIOCl8Wn7nYbjARCOq3SI5svYeC3T0JEvTyrXsxJXVgCyVCE/biQRLl6cDbfB7eRuXeavFE9OtVLZyHfCtfoLyU3h+eFvmhizNUSdQRpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377016; c=relaxed/simple;
	bh=0HEnEiKhFBH7Flm84u46+eSHhyyxIBEQSIMyyrd3BOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HqcAk95f7rAFnvrHS83gcODx8ZUuc1je2xVzMgZVsQInrd15HbMfj4Fu18apS1Tta0JD45KtLYD5yGRMpihL7KFHPGUzZxqgLsBq52hxSreD0EVI9IJnqlQVg5jK2bcctR5NITuoythRHEq6LFNailJXKWU3RahfUjfXLIh5cQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDhl2yhh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4972138b3a.0;
        Tue, 22 Apr 2025 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745377014; x=1745981814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+Wf4+u7uJwlTGwn/zMZrH3GwfDUtebrIzU6/wvzpv0=;
        b=iDhl2yhhcuJRoo7iv9eYsSy5aqN/L1jgWrPo1Yox1dmFwHXOgOLv6MnsVHn6BK9nJE
         Xq2gUWye95GF0ZepNjZlPh+n4a7nsJiG6S7UBDkejpEc6cTYg/Y0IQDPm4AroQbzsMuV
         +y9awDijZex/YWG8n+3QTieg1k50KmmchWW3jfssE0mgjH5JaiB+Yo2BYwcyjFu95BbM
         K5KZzrwCuaBq0TB8L1+GlKh9m7kQwDpaydve8PkpUEPmM7X9DXfYvI6WHIvyrbKIT66J
         rPniarez+6SEonY7OsKKpm+PlyTn9emLahSBzbHep6cJvrPJGzCPNY11MItiZKlnS9ST
         t0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745377014; x=1745981814;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+Wf4+u7uJwlTGwn/zMZrH3GwfDUtebrIzU6/wvzpv0=;
        b=IbfvkOG2pqHjAD6kHyHeDCOeGEuO3E9X+vSeEYajZRzACMyZkCO4MekLEEiCUIB0i7
         JI5t/fNbub7CAwlQh9SduD8BVWlleilc2pFRPhStpuxSvwkN4OTNTzhs2iWX/iPWR1Zh
         MHU7kuAfWJMF7OaiMvs8rncX4gi/132Da3NQUo3d5io6xilOipmjhUV6eIaX9ngmVvTx
         CnLbiE05ZDW8oSnVL4V1rAKf7nsdGtKPlGP5Ho18YKCVW/Ja2fiMNiuSDofWC4FWy38m
         D91cloXg86EgVWvsPQzocIG1BG4u8KjfEM753LEwq0PjxtDDLJdxnNF1H3SJH+U5bMmQ
         c/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXnmHdLTWIAEjBPRHkaFTPMjp9sgidgXUv8I5OSzyN9rdKSb2VLTyFv6oFmuywovsbfePXrxqM7VZCQ6vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23WBUmwgXWfz+l6zqA5PQ39smk5xpDF/ttXRkeb9THEMBzQDF
	sv9xyBuwcyEs5NWXrYvd6bOocEFUzzdpOr0CXHRCutvCtu9ub80Z
X-Gm-Gg: ASbGncvnbIMDw7rlHMQkeIxcgl6GJ0HXmd8bqwfdACZnQHh5jzZxgiXeu6F2xXpO9AO
	c9fUaUagnyoC0vuA4TOh4inONWx+IfjVVk2L9dOxqSY+YRWk+63OBCYTlrWNOp6qynpBYSieIQR
	BSXxUuFWFGXAr2W8sHykwSSowSSIbAVygVDCcfnrYxBrJLUS8iK4quxBoR77YxgFRcxNvskltFq
	JSn8WpaC7ScSy0ZWJZv7SauEDINUwHUet+fJg8VLaenPaBvepCAii7nCzRiy2/JaJrzOj/QO42h
	IOJOJFp00LTDGhCmYrSDSXqdMr7Tp5+Vpkhw5TFvk4jJX/KYKp0g3Q+cc7zmBb/yDFq+mdq7UlT
	RL5dPw+ZxGLRd
X-Google-Smtp-Source: AGHT+IFtlJx10XStyHs04nYnbOwtZVNdhMDnFisSj/PB4Ud4wC+SqrNTpeHIwohi2qENORhLFKwgFQ==
X-Received: by 2002:a05:6a00:179d:b0:736:51a6:78b1 with SMTP id d2e1a72fcca58-73dc14e01bemr22473525b3a.11.1745377014327;
        Tue, 22 Apr 2025 19:56:54 -0700 (PDT)
Received: from ?IPV6:2001:56a:f6b2:4a00:7181:6803:4a12:f331? ([2001:56a:f6b2:4a00:7181:6803:4a12:f331])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90d6c3sm9423992b3a.77.2025.04.22.19.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 19:56:54 -0700 (PDT)
Message-ID: <57625894-6c7e-4bb9-9518-96a62b25f29b@gmail.com>
Date: Tue, 22 Apr 2025 20:56:52 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nicholas Chin <nic.c3.14@gmail.com>
Subject: Re: [PATCH 1/6] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org
References: <cover.1745315548.git.viresh.kumar@linaro.org>
 <7ce4ffb166beef83cf1bd703a41bf91622011585.1745315548.git.viresh.kumar@linaro.org>
Content-Language: en-US
In-Reply-To: <7ce4ffb166beef83cf1bd703a41bf91622011585.1745315548.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-04-22 03:53, Viresh Kumar wrote:
> The boost-related code in cpufreq has undergone several changes over the
> years, but this particular piece remained unchanged and is now outdated.
> 
> The cpufreq core currently manages boost settings during initialization,
> and only when necessary. As such, there's no longer a need to enable
> boost explicitly when entering system suspend.
> 
> Previously, this wasn’t causing issues because boost settings were
> force-updated during policy initialization. However, commit 2b16c631832d
> ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()") changed
> that behavior—correctly—by avoiding unnecessary updates.
> 
> As a result of this change, if boost was disabled prior to suspend, it
> remains disabled on resume as expected. But due to the current code
> forcibly enabling boost at suspend time, the system ends up with boost
> frequencies enabled after resume, even if the global boost flag was
> disabled. This contradicts the intended behavior.
> 
> Don't enable boost on policy exit.
> 
> Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()")
> Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220013
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> This was sent separately earlier. No changes from that.
> 
>  drivers/cpufreq/acpi-cpufreq.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 924314cdeebc..7002e8de8098 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -89,8 +89,9 @@ static bool boost_state(unsigned int cpu)
>  	return false;
>  }
>  
> -static int boost_set_msr(bool enable)
> +static void boost_set_msr_each(void *p_en)
>  {
> +	bool enable = (bool)p_en;
>  	u32 msr_addr;
>  	u64 msr_mask, val;
>  
> @@ -107,7 +108,7 @@ static int boost_set_msr(bool enable)
>  		msr_mask = MSR_K7_HWCR_CPB_DIS;
>  		break;
>  	default:
> -		return -EINVAL;
> +		return;
>  	}
>  
>  	rdmsrl(msr_addr, val);
> @@ -118,14 +119,6 @@ static int boost_set_msr(bool enable)
>  		val |= msr_mask;
>  
>  	wrmsrl(msr_addr, val);
> -	return 0;
> -}
> -
> -static void boost_set_msr_each(void *p_en)
> -{
> -	bool enable = (bool) p_en;
> -
> -	boost_set_msr(enable);
>  }
>  
>  static int set_boost(struct cpufreq_policy *policy, int val)
> @@ -532,15 +525,6 @@ static void free_acpi_perf_data(void)
>  	free_percpu(acpi_perf_data);
>  }
>  
> -static int cpufreq_boost_down_prep(unsigned int cpu)
> -{
> -	/*
> -	 * Clear the boost-disable bit on the CPU_DOWN path so that
> -	 * this cpu cannot block the remaining ones from boosting.
> -	 */
> -	return boost_set_msr(1);
> -}
> -
>  /*
>   * acpi_cpufreq_early_init - initialize ACPI P-States library
>   *
> @@ -931,7 +915,6 @@ static void acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  
>  	pr_debug("%s\n", __func__);
>  
> -	cpufreq_boost_down_prep(policy->cpu);
>  	policy->fast_switch_possible = false;
>  	policy->driver_data = NULL;
>  	acpi_processor_unregister_performance(data->acpi_perf_cpu);

The first two patches in this series appear to work as intended. The boost state (both enabled and disabled) persists across a resume from S3 suspend.

Tested-by: Nicholas Chin <nic.c3.14@gmail.com>

