Return-Path: <linux-pm+bounces-20525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C5A1336B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 07:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8750D3A18A3
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 06:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EF015747D;
	Thu, 16 Jan 2025 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5LKazuZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336B1AB531
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010455; cv=none; b=i3hEKqpLHu29ZIHLxTxpyb39Jac2CakJkjrFZ3w8Jfvuw0v8PyNRHYlkXvdKDea63BiFCKbhvgsB5W6dtzp5xP5LKJ+URKKyFyTQsykO17YJJkhmtBQ9nwnIyYACR+TZClRF6GDwlmcEqNucmUWGEBkSf7miIU8Ind10pHIVZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010455; c=relaxed/simple;
	bh=r2PpCas5cPtaxckIpI74rr9z+eq9g2/AhIPzD8bSwvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jihiVSCK+kycRAiW3A+qrhvWrbVl94+pNB536ctrwUBLHPWykt8Fc9A9ueQZ71KxX2ThvAykBBEQonlKD2y6zIpItOAtb95phsr7P6s1S+6+SNXxSffc1ae8QN0I7TKoMtUwLSBi3iwyjYLDxq7VubJuVB/XMjFRLtttLjBTYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k5LKazuZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21649a7bcdcso8549895ad.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 22:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737010451; x=1737615251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddotAhmsUx/pGdYVR8plo1zj2OojQhO47fmX450ReOM=;
        b=k5LKazuZvWALfACSVOT9GQbFy4zS7gkPEOFEtYMTfTZNpQej3E8ef7cGFIXQ5mCMRS
         YJVLGmYBVZn/Dw/ehMbKzxgtExkOHMdWlFkxt1dOJz/Kt4gMv0KuTlSJEfeLllIc1sJE
         WaE1N2XCeSA8XeDjjDQNbsJVZOiRJrxHdLgWIjtczunJIiSj6oghi56ZM6gsvIcFOPj8
         HpQhUbjwQBwWrrNeA8AqKKqPTy5oIXEfq7IkGa7uir2d9jksYXTsSZEI2sKZiOurktxp
         hwN6YDesbZv1Ms9WzqLDyAKkokY6mfpoeAsRlCdTGId1yCkfjLz7SQoGxiDkfWOPIUad
         doYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737010451; x=1737615251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddotAhmsUx/pGdYVR8plo1zj2OojQhO47fmX450ReOM=;
        b=xScKi6LbIanlE3UyGAG9x1tjRl5LBhNAQitlF0dGAMnZsKktG8y9bVPnpuFNqFJ0zx
         R+mZWemPyhuRAVIPY9SN76cOq206YSOM0G8Y7NVQSfyAmDKfBjoQ9qmfbhrnzpF1XO3p
         53D4LNOn1mpJGz9syLPOgjw+24TKNdSCpu0cqBVAUpJlVIjxm6p9nKuwKrK0a0UWMd2A
         bmIsiU4IThTZ9GC5EOZx4rZUDB2IRJUGZwKgOI8ozjV/pgj74BvRNSspny99CL2iqzKR
         DEvy5FpfYXmlzTh80s2VQi3YR/5Eeyu9xCNYrPKtTnYkb1Ft+KZ88k4zSgFlSOzhwWtb
         68eg==
X-Forwarded-Encrypted: i=1; AJvYcCVViBnPS9e4a8Ud+YFG5p2cNz4tx/+jmfn2qZZiI7djRu1TrStjH6UF5Cf764ANmfwbjBpNYC8Fbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeo2g/WpBm4rlL5oRz5Md3TfBBh7WlWeJCSZDX/AvRkCxUbS2
	XiOt1WU4AGjB6A6dNuYJl4Bjvf/F9i1ceW+IO+AYAI/66V2oG9A//Tmia6vY/Wg=
X-Gm-Gg: ASbGncsZYPl/eLApPjSDnA0hKtdN0PP3bc2uyZfWtOFdEMtJJGzXgaQXrbig+3LTyz1
	42NTuX0LBjxcDVuDu6+/rAEsZVdZEfcLa/s9qhLDB/bsFEfvlmpBLkZJV6gaMs5+8hHSQrJuCtV
	p086wSqPJ3r7Bs+WzHL9Fu4s9LXqqMOgOc7+AmiJEligeKBJMlqRZbiWkwhCKHF2QnYaWB4xckN
	PdHJrX/7COb17Y488xc1SZjVrSE1WsNYwud6yl/oCgBklJagitpWs0ICZc=
X-Google-Smtp-Source: AGHT+IGFp5JLzMiem2dZ7VuspuEUy7yWk7iQmTq4/Ip/D8hjctysJ0K8DOZViYHWtamoNgklM/21bg==
X-Received: by 2002:a05:6a20:7f8a:b0:1db:de38:294b with SMTP id adf61e73a8af0-1e88d2f6820mr52659182637.38.1737010451411;
        Wed, 15 Jan 2025 22:54:11 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40548489sm10679227b3a.15.2025.01.15.22.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 22:54:10 -0800 (PST)
Date: Thu, 16 Jan 2025 12:24:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH 2/2] cpufreq: Introduce a more generic way to set default
 per-policy boost flag
Message-ID: <20250116065408.kjifylpgse5f3k3h@vireshk-i7>
References: <20250115100123.241110-1-zhenglifeng1@huawei.com>
 <20250115100123.241110-3-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115100123.241110-3-zhenglifeng1@huawei.com>

On 15-01-25, 18:01, Lifeng Zheng wrote:
> In cpufreq_online() of cpufreq.c, the per-policy boost flag is already set
> to mirror the cpufreq_driver boost during init but using freq_table to
> judge if the policy has boost frequency. There are two drawbacks to this
> approach:
> 
> 1. It doesn't work for the cpufreq drivers that do not use a frequency
> table. For now, acpi-cpufreq and amd-pstate have to enable boost in policy
> initialization. And cppc_cpufreq never set policy to boost when going
> online no matter what the cpufreq_driver boost flag is.
> 
> 2. If the cpu goes offline when cpufreq_driver boost enabled and then goes
> online when cpufreq_driver boost disabled, the per-policy boost flag will
> unreasonably remain true.

Yeah, this is a problem. I agree. If the global boost is disabled,
then boost shouldn't be allowed for any of the policies.

> Running set_boost at the end of the online process is a more generic way
> for all cpufreq drivers.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 03ae879d50b9..867bda3decfd 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1409,10 +1409,6 @@ static int cpufreq_online(unsigned int cpu)
>  			goto out_free_policy;
>  		}
>  
> -		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
> -			policy->boost_enabled = true;
> -
>  		/*
>  		 * The initialization has succeeded and the policy is online.
>  		 * If there is a problem with its frequency table, take it
> @@ -1576,6 +1572,18 @@ static int cpufreq_online(unsigned int cpu)
>  	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>  		policy->cdev = of_cpufreq_cooling_register(policy);
>  
> +	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +	if (cpufreq_boost_supported()) {
> +		policy->boost_enabled = cpufreq_boost_enabled();
> +		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);

Maybe we can optimize here and not call set_boost() if policy's
boost_enabled is not changing at all.
        if (policy->boost_enabled != cpufreq_boost_enabled()) {
                policy->boost_enabled = cpufreq_boost_enabled();
                ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
                ...
        }

After this patch, maybe you should simplify the drivers as well, which
take care of enabling/boost at boot time or setting this flag ?

> +		if (ret) {
> +			/* If the set_boost fails, the online operation is not affected */
> +			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
> +				policy->boost_enabled ? "enable" : "disable");
> +			policy->boost_enabled = !policy->boost_enabled;
> +		}
> +	}
> +
>  	pr_debug("initialization complete\n");
>  
>  	return 0;

-- 
viresh

