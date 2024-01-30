Return-Path: <linux-pm+bounces-2924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6C5841748
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 01:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45423285A1A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 00:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2919F;
	Tue, 30 Jan 2024 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="wwwFuAlg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785F2F2D
	for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2024 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573130; cv=none; b=TztN7M4VP1TwFHCS5gJxHsRPOaRGHUv1Z0D4P+WrzG9wcwvW82I0+rBGwFfp6FhCHawXjR3ztRzcCXKi9uxKtBygaXGN08798kRbfbxY+lelnBFG5T637dfRjcXRB9n/GtSRPiZkQY3Jbtrax7LEeFcmRxP5wMWuq2F4698MG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573130; c=relaxed/simple;
	bh=m+0FwiboCnTUjVYArGv7RhH9oT8oe6HzEysbTX1aTGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAPbrl24M9hofqAip3obaeTUQWH6r7+5CpyWlu+u/PqBwfZwrvA+RWiGKEJwPH97uf0zcF1FLQ592Y/dMfqmbOqtRZ4CaHGe5nGKfDEM1bd8Ebz8poeMEx9Oy2axhg5KeTEK9vi9tBWy6DRll5HPcfCkgDE42I0qzyIFo7c5i10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=wwwFuAlg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eebe7767cso26749125e9.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706573126; x=1707177926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxbSifhVqIOt2/m5QZSeFQNg25CWOD22Pv4LfmhthMA=;
        b=wwwFuAlgXdGlNk/Fd8yxAyxoqzRYrM88nLXFzcu/ZGDxpxe3Qd1/idUSwldAqTOWoI
         1Vbz6lN5D0qiBNR9BSW7PGi6bIr2cTDddmaO4w+Swh7ZLAL8I9pIbp3sfXi47fDUNIRC
         e7kDFfRLtAD13KLWMwP79Ph7ISRDRmyPTFOqTn0j3fy6DhOnIZuPbLIAmKTUJSkK3ceS
         8+xy+3aFuE4tzYaoPsIg9rb3kdH8V/QiiAZpCNHCKae0KkhXMkVErya2frTd+S6lam4a
         n8ulkBTAu/Jf9A9MNh5OmUGCOk/v/2kkrXSnn9aGqYVGLZ7qop6S9cTLDYY3vHlWVI6B
         mF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573126; x=1707177926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxbSifhVqIOt2/m5QZSeFQNg25CWOD22Pv4LfmhthMA=;
        b=HolESopoiWt31W/r/Hvpa+U+ffSmfGx/qehPgSyI9bhqmSoXOwXRm5HT2DxGXHLNsw
         qjEkqctqNHv1RQrazu+7qqUOLvnojJ6cjb2FgzIveAdOfnfnyEB++PWbjMLco+2c/8KG
         22z4aYJG6ehj+NNhYuQ4qNqSgOSfRiaSRyF09+0P6t/+CXQY24FaL/TfQzeBFyi4iSt6
         Hz1R1J8Xb9YwYiaC7SGsKx7o4uHnjFbCF+3OKEvwDl1wGAXHDzH23/q4XGpA/KM5iS9y
         /rbYI0mmshcofk8asqufjMtUV/vE7kfZ7+TMbsFEtlkqDSfV3gQuh4a8pMP2DtBwwmpH
         glqw==
X-Gm-Message-State: AOJu0YxtRkXeAm6MgWhsUScOPjnqtyPSV4xLg8pzKJ/8vOYALlqbkXAF
	YPPXlKujBdwGEqHpKVoUqMHXE9rt4b1+XCpZ3FmdFkq+xLNngZGLDLt2lZmqJMc=
X-Google-Smtp-Source: AGHT+IEcOm4ToE+OjMANypBdoNmKfiC7rumN1mFFCPVcffivoLtpNe7xAo25vCDii/5hc1czCprBwQ==
X-Received: by 2002:a05:600c:4654:b0:40e:b29c:7103 with SMTP id n20-20020a05600c465400b0040eb29c7103mr5917032wmo.8.1706573126220;
        Mon, 29 Jan 2024 16:05:26 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c500600b0040e3488f16dsm11277752wmr.12.2024.01.29.16.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:05:25 -0800 (PST)
Date: Tue, 30 Jan 2024 00:05:24 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/5] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20240130000524.4dlivtwn427csjj5@airbuntu>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109164655.626085-2-vincent.guittot@linaro.org>

On 01/09/24 17:46, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..f4eee3d107f1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2563,6 +2563,40 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpufreq_get_policy);
>  
> +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> +
> +/**
> + * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
> + * @policy: cpufreq policy of the CPUs.
> + *
> + * Update the value of cpufreq pressure for all @cpus in the policy.
> + */
> +static void cpufreq_update_pressure(struct cpufreq_policy *policy)
> +{
> +	unsigned long max_capacity, capped_freq, pressure;
> +	u32 max_freq;
> +	int cpu;
> +
> +	cpu = cpumask_first(policy->related_cpus);
> +	max_freq = arch_scale_freq_ref(cpu);
> +	capped_freq = policy->max;
> +
> +	/*
> +	 * Handle properly the boost frequencies, which should simply clean
> +	 * the cpufreq pressure value.
> +	 */
> +	if (max_freq <= capped_freq) {
> +		pressure = 0;
> +	} else {
> +		max_capacity = arch_scale_cpu_capacity(cpu);
> +		pressure = max_capacity -
> +			   mult_frac(max_capacity, capped_freq, max_freq);
> +	}
> +
> +	for_each_cpu(cpu, policy->related_cpus)
> +		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);

Is this WRITE_ONCE() required? I don't see why. But assuming I missed
something, better pair it with READ_ONCE() in cpufreq_get_pressure()?

Beside that, LGTM

Reviewed-by: Qais Yousef <qyousef@layalina.io>

> +}
> +
>  /**
>   * cpufreq_set_policy - Modify cpufreq policy parameters.
>   * @policy: Policy object to modify.
> @@ -2618,6 +2652,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
>  	trace_cpu_frequency_limits(policy);
>  
> +	cpufreq_update_pressure(policy);
> +
>  	policy->cached_target_freq = UINT_MAX;
>  
>  	pr_debug("new min and max freqs are %u - %u kHz\n",
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index afda5f24d3dd..b1d97edd3253 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
>  bool has_target_index(void);
> +
> +DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
> +static inline unsigned long cpufreq_get_pressure(int cpu)
> +{
> +	return per_cpu(cpufreq_pressure, cpu);
> +}
>  #else
>  static inline unsigned int cpufreq_get(unsigned int cpu)
>  {
> @@ -263,6 +269,10 @@ static inline bool cpufreq_supports_freq_invariance(void)
>  	return false;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline unsigned long cpufreq_get_pressure(int cpu)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_CPU_FREQ_STAT
> -- 
> 2.34.1
> 

