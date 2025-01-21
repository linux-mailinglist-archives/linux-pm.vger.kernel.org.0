Return-Path: <linux-pm+bounces-20767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D0A17C20
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E749D3AA617
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD21F0E4E;
	Tue, 21 Jan 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6Q+sJEU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EE1B0F1E
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456432; cv=none; b=GGv+7vvICujYzOtoeJ2mVfr+mGy6x3Op+aGk3o+71FvKIwx2adIQoRfRrprlEw+9mxeq9672VAQ6Wm5Nz/syAj0q4TcrPH/LtV9HOpJmFDCtPYnTHk1iV5SUydKBPFg2QA3jty6eNBGErXTlSq7pmQZCweA088KGh2/Y6KtKEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456432; c=relaxed/simple;
	bh=+fd2yRoaWy8/CsT63oeO+/Q4Bx7nhqOv5NbE/3BTWfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOK6+T0sW+bKpIhgmuCD+5LBC18elPfTKICHwYVqlzQLxya25mfV3mx/IT9cEIu9WEPQ/uYWKMp2tSagtJMlqGidVQpsoqbDiEcd7sZhoWbZg6w+qZ2hciSg0E4FfD/KEqEfPxS/6FQ3Le34CCcPgkY7luiqbC8pgSFDmb7uUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6Q+sJEU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2156e078563so70237555ad.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 02:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737456429; x=1738061229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjjne0E3+H0DxvpYvXQJEPPLzeITfjRK1it/y9/KiaE=;
        b=j6Q+sJEUFQgNoBoTS2iofsvVLrPDonT9XoKheCG65TmsuldRjl+dP38yLXpegApV2D
         eecv+idHEo4t4fq2nv0gDNlTBShMbYk46mdN9MFg2+peXsUXrotUUMJtRSVO1Wte9GZI
         OeFLbAPwjaeYs1AVe3zfMKEr3zslV5izab9nNxNZsdYXEAJe7F0VbYnb9140pY9qjIjj
         2sdTxX9XCbHsMp2SsdUGUHSkDlNTO5F5tPWF0sJS4NtTGZ6Tl2v5sfQDmx3HzLjkq6Io
         xzKdfPs5jMOL7bWBtOnWi90NZKhFnDIB0KU1dqwwKYHGB5DhVB4jYi7K9saY+o8udKxI
         Oy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737456429; x=1738061229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjjne0E3+H0DxvpYvXQJEPPLzeITfjRK1it/y9/KiaE=;
        b=UPNsyEyWA3MAyWEWDBqPuVJvOS2JiNxzNea/B8sn5dKNSvk/36LsSllMq7T+BFYcla
         JjubmxFSfTxlMCBctc3aMy6MQkdK77gnHCoHpQC+/XqpFOLbMadbTcxWkRbXb8CUK851
         WssiMTVf3JnmTtE9lUqEXjylvPb5gkV9hmhK86qcpWm1fBrTenQ6fwaRz0AjryrzLI3P
         JRyBWp4ckrJ4lOBxMmsM7KJA3/LrfVreff7QMew20foX3zdE8Ip+ANPZ9AJkh0zEtXbA
         fAT4DIxmE/CGj37m6uynlUdfzZF18KJ0ppa0ChDK8Zc2Dtwog4S6aaeUyRkyX8VICV7E
         TN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaAP5szc0Dl9t/BlEDbXGPISyI2A1fwcwGkG5/UnWB6tI/Zy1u4wKSOM2IOnIeL5MhELO1pOTxDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhhpeeZxeEhD4nM2JPm1cU+jzNnWVxPT2MkSNIiqV75lCNCe6L
	loNeUGC1Ruo5LoXJcvm0GQKDRJg7EvTGrt6NAiEtfQ3PHg5xnf/iXepgNvliEqc=
X-Gm-Gg: ASbGncvRY4nm/JcIUcrmY/pOLCiJeAmO+mF51dcLGtNvqlfa0rInH+bslSzzidkwpqS
	XEUDLEDZGG6GqiE0aHQdVL9WuG4dHqbikzgj4ivrtD7+dB1GtfrCgLg2g6VZG/tbjfVeZMyMtDG
	NGPxVbFU9Sb0scGBq2K8eDBWVBlg7bWGeJsdkmi/Ed+Yg/QjWkXLcu5vikWx238NQ8HQsX2yUJM
	D9bD8f/vbrdZc/Gemskl6wO0QUWVw9tMJmvO0eMruzbGRxodrPeCtxamtn2t0g+AfG/ZiD/NotK
	Bf29ojk=
X-Google-Smtp-Source: AGHT+IGJD1dOPoV4WHlzi5WBxwqsVI7hrl9CV1yzciPVE32NItswuJUQXBovrfqj5yvKVARoiyBnQw==
X-Received: by 2002:a17:903:11cd:b0:215:b5c6:9ee8 with SMTP id d9443c01a7336-21c351d3065mr220669285ad.7.1737456429087;
        Tue, 21 Jan 2025 02:47:09 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba3f8sm76268275ad.97.2025.01.21.02.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 02:47:08 -0800 (PST)
Date: Tue, 21 Jan 2025 16:17:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121084435.2839280-2-beata.michalska@arm.com>

On 21-01-25, 08:44, Beata Michalska wrote:
> Allow arch_freq_get_on_cpu to return an error for cases when retrieving
> current CPU frequency is not possible, whether that being due to lack of
> required arch support or due to other circumstances when the current
> frequency cannot be determined at given point of time.
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 2 +-
>  arch/x86/kernel/cpu/proc.c       | 7 +++++--
>  drivers/cpufreq/cpufreq.c        | 8 ++++----
>  include/linux/cpufreq.h          | 2 +-
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index f642de2ebdac..6cf31a1649c4 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -498,7 +498,7 @@ void arch_scale_freq_tick(void)
>   */
>  #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
>  
> -unsigned int arch_freq_get_on_cpu(int cpu)
> +int arch_freq_get_on_cpu(int cpu)
>  {
>  	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
>  	unsigned int seq, freq;
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 41ed01f46bd9..d79f5845a463 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>  
>  	if (cpu_has(c, X86_FEATURE_TSC)) {
> -		unsigned int freq = arch_freq_get_on_cpu(cpu);
> +		int freq = arch_freq_get_on_cpu(cpu);
>  
> -		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
> +		if (freq <= 0)
> +			seq_puts(m, "cpu MHz\t\t: Unknown\n");
> +		else
> +			seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
>  	}
>  
>  	/* Cache size */
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 418236fef172..6f45684483c4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -728,18 +728,18 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
>  show_one(scaling_min_freq, min);
>  show_one(scaling_max_freq, max);
>  
> -__weak unsigned int arch_freq_get_on_cpu(int cpu)
> +__weak int arch_freq_get_on_cpu(int cpu)
>  {
> -	return 0;
> +	return -EOPNOTSUPP;
>  }
>  
>  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  {
>  	ssize_t ret;
> -	unsigned int freq;
> +	int freq;
>  
>  	freq = arch_freq_get_on_cpu(policy->cpu);
> -	if (freq)
> +	if (freq > 0)

>= ?

Since we can return error now, 0 should be considered a valid
frequency value ?

>  		ret = sysfs_emit(buf, "%u\n", freq);
>  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>  		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 7fe0981a7e46..02fd4746231d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1184,7 +1184,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>  }
>  #endif
>  
> -extern unsigned int arch_freq_get_on_cpu(int cpu);
> +extern int arch_freq_get_on_cpu(int cpu);
>  
>  #ifndef arch_set_freq_scale
>  static __always_inline
> -- 
> 2.25.1

-- 
viresh

