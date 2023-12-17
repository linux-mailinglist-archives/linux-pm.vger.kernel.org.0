Return-Path: <linux-pm+bounces-1253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA14A81617F
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07B62826D4
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A74847A5F;
	Sun, 17 Dec 2023 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="yYfe9oKC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A1481B0
	for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2718a768so22928915e9.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 09:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702835965; x=1703440765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cIBZz+9Ud6h4kU/mqXgJp3NM80hsz9NbcKCQUcqLdM=;
        b=yYfe9oKCJPIbmpkCvdMHCCqKCrhcDuP8dpbvm2Ywgjn4RVT0GHItTtGGNvy+mldLGx
         UyQieeZz2gIijKUKfJk2ZMcD91MQSzye05TTrExRApePHn0obJVMNBROtbaY/mRWhhms
         kNgt7fwtZS9IHIdq+ckudLwr4HOvzqmQa4Y79Mi1k4ysuWOnCktBYghCYH7f/FyXBHI3
         DklumXjAeHkECC6Irupz7chWMrEsQFGoWKhztmsHEi2m+D+UvbwHDK3162f0o+aky9eF
         WFv+PN2eq9Y8JkXiDQHWclRelpc11gmFkUSbeRc0yEAPlfei8bTfOSZZo57+9IYI2fH6
         CfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702835965; x=1703440765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cIBZz+9Ud6h4kU/mqXgJp3NM80hsz9NbcKCQUcqLdM=;
        b=dgCnRyHPRhWQN8s9GAlMJOfsOJg3d+ZiRZWtJ5raHbdfwcvxmkqtPwexacFK3mMW4j
         Ddfdlhe+q8Fuy80ti02IM+9E4u9Mq4JvqGsBWpp5E5sFmGO57neeppbQZIs1UunaHCXc
         jZ9ydiA2mE2FPba1JPYtVmB4IAZhAxmDtXrVYwzK6iOnrxxDZZDdFxdm9TUsJOeeD0z+
         i3dOf4RZhliOssfW1QcK2+bMDx8HK4R8HotpB/9NZOgOfqXH4n9r86kMY3hv+n3O2pEP
         04cvvhNGGYuaTEtK1zjzE6HSAfvUhQTEI4GxeS/lspb/c8S0HoiMKVaYOBsIDrEBGHHX
         vsuQ==
X-Gm-Message-State: AOJu0Yw4McXOrVK39cE2tDVM+E+e5tXc4HklmQwLoKJj9/WQR/slB7CU
	eImdN5Eyc7d3Tdc4PXeAIleDBQ==
X-Google-Smtp-Source: AGHT+IEH1Kva5XjTnuKYjHeiTSyCE4VUP8ykcY7KTTz7SEpUjJYC+JkV131cxDaQNCP1RV+NM1bQQg==
X-Received: by 2002:a05:600c:1f93:b0:40c:4ca8:6ac7 with SMTP id je19-20020a05600c1f9300b0040c4ca86ac7mr6212804wmb.108.1702835964854;
        Sun, 17 Dec 2023 09:59:24 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0040b30be6244sm38365422wmq.24.2023.12.17.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:59:24 -0800 (PST)
Date: Sun, 17 Dec 2023 17:59:23 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 09/23] PM: EM: Use runtime modified EM for CPUs energy
 estimation in EAS
Message-ID: <20231217175923.wxmfocgckpaytptb@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-10-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-10-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:
> The new Energy Model (EM) supports runtime modification of the performance
> state table to better model the power used by the SoC. Use this new
> feature to improve energy estimation and therefore task placement in
> Energy Aware Scheduler (EAS).

nit: you moved the code to use the new runtime em table instead of the one
parsed at boot.

> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 1e618e431cac..94a77a813724 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -238,6 +238,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  				unsigned long max_util, unsigned long sum_util,
>  				unsigned long allowed_cpu_cap)
>  {
> +	struct em_perf_table *runtime_table;
>  	unsigned long freq, scale_cpu;
>  	struct em_perf_state *ps;
>  	int cpu, i;
> @@ -255,7 +256,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	 */
>  	cpu = cpumask_first(to_cpumask(pd->cpus));
>  	scale_cpu = arch_scale_cpu_capacity(cpu);
> -	ps = &pd->table[pd->nr_perf_states - 1];
> +
> +	/*
> +	 * No rcu_read_lock() since it's already called by task scheduler.
> +	 * The runtime_table is always there for CPUs, so we don't check.
> +	 */

WARN_ON(rcu_read_lock_held()) instead?


Cheers

--
Qais Yousef

> +	runtime_table = rcu_dereference(pd->runtime_table);
> +
> +	ps = &runtime_table->state[pd->nr_perf_states - 1];
>  
>  	max_util = map_util_perf(max_util);
>  	max_util = min(max_util, allowed_cpu_cap);
> @@ -265,9 +273,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	 * Find the lowest performance state of the Energy Model above the
>  	 * requested frequency.
>  	 */
> -	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
> -				      pd->flags);
> -	ps = &pd->table[i];
> +	i = em_pd_get_efficient_state(runtime_table->state, pd->nr_perf_states,
> +				      freq, pd->flags);
> +	ps = &runtime_table->state[i];
>  
>  	/*
>  	 * The capacity of a CPU in the domain at the performance state (ps)
> -- 
> 2.25.1
> 

