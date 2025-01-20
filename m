Return-Path: <linux-pm+bounces-20679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E92A168A9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42D03A00DC
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00FF1B6CEC;
	Mon, 20 Jan 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlOAU3WR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3831A073F
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363667; cv=none; b=uJ1ao2yQA/LP0NSfunjZ4WJVouB6ClZkaxeFPhgOGPszS6DoTdQYK8aaHFU8n0oV2vSncy2qFvihQkP4eHCwGN3gg+J6rkcbkKorxhqh0Gh7o7OUGrc06aGIax9tgndDFc7PvywrsDHe9Yn75Z/AYZ9szJsUtrwpcF/Xsf1wqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363667; c=relaxed/simple;
	bh=N38qZoCHcgqzJ2cloh8L9PRfDVNTtK1+A7StBJyL13w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU7VJit91smojV6YDKhnimYpef5HXY0OT9Mk93RWVdcV9zEXKqAIki7rke8uahgoT2b8r1PN7ld/KaPyf+FCi279suZAReJwdfXzmJPvVm1piWr2hvOOjuTfvEG8eoNtw2Vd0ixA/Pr39wxl9IOX6JZ/hht/ci6inev/0ApJlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HlOAU3WR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so7296617a91.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 01:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737363665; x=1737968465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Itnj3IOrEs6gi3JiCfTY/60+x3xztEOPRsyrRqJIyY=;
        b=HlOAU3WRdAafNDndOnhfCPWSS0ujMirIp0E75WPnoB2oTrDg+Xd8m6FjJe8fqm40m2
         8tzx1cQIww8JujUwLRuL5qYrGnzrfeiv0RRVXW0q1dRFlQAxV+g+FUHeyz0Q0J8+DdSX
         YSWYnUHjyCqJO0F17p1vHazw3fWaR5DuB8zgJ8KEVyiq9u8g80izZ9utMeCoKQdu4zK4
         sQpN9RWj4csmuwpc8OY+hOm36gx3hQGuDOmaTjlOnklbRTSDXVRwkib2nov/vF6KfKxv
         WUp42/5yDpCvyg+60ZhBWF593+C0ANPiRa4paaSUA4A5dnSjFKZ3m7qD2D4LdL62WWQ/
         N5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363665; x=1737968465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Itnj3IOrEs6gi3JiCfTY/60+x3xztEOPRsyrRqJIyY=;
        b=uXKecdwHp1SH3cYgvzMmbAwPAV3rifAmzyNokeKNCuHl2VGKUWSlL26eEaIbxYjiT2
         llwlXrgY38WKzBRK0fTM4F5qglHlSy32YHhEPs9qYYbccVxyjwoE+9+tCUBBCjKPuLGo
         +81qDOxoXwbRY/idEHEblqISbSu41y3fYT2pa3B4jug6AskisO2NB29jaYJz1G7DWevr
         WiFIKt6pE/gOG9somhqv+0LXoSEmKlQJ0illQbAvjJa8Go6JU43M+7dKB1cHWZLjHMEG
         uiewfhbMcHub7KDp9HTdly871ZIubkcNu190bHRC2RDPAgAvZrvpWi4IlYe4fdv/fk5G
         yXDg==
X-Forwarded-Encrypted: i=1; AJvYcCUnFQoL6H+8TRQMlbIHUz4dNJltGVf4zqawcTh+xnVYg6XzFvV+CwmeFVTYClaW4+m4JyzCF5YFMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9bOjlENGD9pb6SzLwPUDSlLh5n9mAmdE0SJIEHBRc2ce1YtN
	rzcORATW6JqGTmp1fAFV+7cOk+1LcZjkzBjBIMo40VhUnhb0xzIIFXfXnKDSAYA=
X-Gm-Gg: ASbGncv08OnvXeL97LfiofM5ISRh1JwLdcmPKKQTsqTwaNNyZ4FRCkUe12YaPADqnz0
	rdmGNuIMDAx7UNbofSBsKwQmo2sQnfEfphHrlvC9s9VeqDwHmfcTJwmrqT8U7vIk48tEhY/ZXPN
	O2Je6mqQnQEQffIN339VmEZt0KCAUwHFSG0222elJeASmS596hJWztCFdoRFVXfwazM1fR+Hqgm
	TY+gc5laCZtFDEdx8a/l0EjCKg8pVqqPhxGbVjWphAYwYLe6fp7+PO/AJ1T4SkMR4Iz2hvH
X-Google-Smtp-Source: AGHT+IFALmijJfFaLhV1Mkvb2L6OTEoGi+Wz2LmZuokbQl05UuRJVPCcuD5yRIFcPpr2fW23WrgIOg==
X-Received: by 2002:a05:6a00:3018:b0:725:df1a:275 with SMTP id d2e1a72fcca58-72dafbd97b0mr18464265b3a.23.1737363665248;
        Mon, 20 Jan 2025 01:01:05 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabab64b8sm6557870b3a.166.2025.01.20.01.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:01:04 -0800 (PST)
Date: Mon, 20 Jan 2025 14:31:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set
 default per-policy boost flag
Message-ID: <20250120090102.erm2ffkbnwa5vraa@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-3-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117101457.1530653-3-zhenglifeng1@huawei.com>

On 17-01-25, 18:14, Lifeng Zheng wrote:
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
> 
> Running set_boost at the end of the online process is a more generic way
> for all cpufreq drivers.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5882d7f5e3c1..5a3566c2eb8d 100644
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
> @@ -1573,6 +1569,18 @@ static int cpufreq_online(unsigned int cpu)
>  	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>  		policy->cdev = of_cpufreq_cooling_register(policy);
>  
> +	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +	if (policy->boost_enabled != cpufreq_boost_enabled()) {
> +		policy->boost_enabled = cpufreq_boost_enabled();
> +		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);

I though you agreed to do some optimization here ?

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
> -- 
> 2.33.0

-- 
viresh

