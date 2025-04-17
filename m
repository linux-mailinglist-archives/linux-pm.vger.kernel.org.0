Return-Path: <linux-pm+bounces-25588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34FFA91165
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 03:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B62119E088B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F31AB52F;
	Thu, 17 Apr 2025 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh52Sgty"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9274BED;
	Thu, 17 Apr 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854869; cv=none; b=F1yR9RHnTtVQ6L6pypDQxmhFPoPfneQkOj5a4SCYOBqjrTMuO3OHaaMpVwuT2yaABQJD8tPYOIysB6M9Ou7qaIfdWsP2x7TA5GXsG5mHH7ZPpSe9o8uKSg6TxnMEDFFo5Vyf/iceaiKxzirVXrK1EtOe1dSryu8bGAjFeO0mH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854869; c=relaxed/simple;
	bh=QP4ODaNaN1KboXunGpzQyfBrzXtLdX7TP/eL97q/U7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxBrdxpBiv56k23ihmo/HSf/D9gSuJGyhGr75bF+mi8u6wn/4CcZo4YsyhxrfQBRmRsa3tEPIpA5z5qEXppfY/vBCz0dg/6PltNq0+SM6W6QWhJPE85VqlC0W8qwh7kcNDeLQSHJ40Ee7ErINHytzz6VjvWzxiIgy8ZyAbquF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh52Sgty; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227cf12df27so2350275ad.0;
        Wed, 16 Apr 2025 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744854867; x=1745459667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up4XsEv2q453RocDCOXJp7W3nOSAznfroF3bFHl1ywU=;
        b=Lh52SgtyDad1d6C+5d2OBm6Pho6bOwFdeDLpUzf37cCHPmRloym87GWcUM7vUy4poJ
         fl6/AE7xEU3qj68dw7SF//fZe+FWVqsCiD2ZBJfaNl7dO6v7WabVKOxlX6oHoitEXSN6
         OYguwGtilPal5y06W/Dp5jwa0dxlgWqmXgKiPwojZm5Upii898uGib/20V1qknGBU9+P
         ZYJuIDc/DOqgyqsHhCSI0m+5WXHkZHqlXHuaE2pPjGUmnh7Zn05Yt9RUADyfXAhBQ+vr
         NeQi25o656kCWo8Szpov1qjlfiA4uFdUhfyub2vxyDyRlBMiO3C+0N6ctQp82JI49zih
         SYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744854867; x=1745459667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up4XsEv2q453RocDCOXJp7W3nOSAznfroF3bFHl1ywU=;
        b=rsDdmchUyGQ5oxlaRpupazNokEF4vN0EfSkZQqTmRBDh2faMPd4kNsJdVpztYFbCLW
         bMN4iLAAYnFjDMpCtbCeivptYzHK8NwcWz6myZVujr8XVSmqzbrm7RmZ+MWy/ldZfDIv
         yTcQgCq61QxSmowodI7bxM80+ay1jY/wGRVyjdrcLg8QUaUtuexHXwXE+S6DecbrOm6V
         wlpzKYVZcJA23E1WbXaIwCJos6Yb/J3oqxISCVnDbVYKTe5cmxT34+cNMeznzFUKc7a8
         oqR8TK5q0qWgCP262q2sdAc17P5kXyMVHg0/7JtqH294ZEGm2U2dKStImeOmMX7K0CKp
         BHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUt6CWK2Zacq0ClH8QGROUKaKoz/zSWs+wTZJKVJZ+LigU+d4Cn/s27SjX7l8aOFIyfhoxBYDKYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQ5E2zGByJFoV42v5vdQpup2iShYj6yMjGxG2xNpeLjDAtsYv
	Q7vB6+NU1vqAZc0mWZKDtQELi68jLAsdRHfGyftR/xgTW4Nl6Lm+
X-Gm-Gg: ASbGncveSCb+xJOQx5YYHFxXncbAzBWsPr0wfmF5GLlUTb9XQpWT6hI7Ustzly6Gpf/
	tHIhPwLpIjoQ+Ar2u7onBpg9wudxvv3iq8Jis1U3WIUbQo1BMbwIEh2Z0FGdHgEKs/pWm6Ja+G8
	6nHlH2VvoTyyQtNi5HqhxSopNBAlpeBZVJ5R9dHGYEviiuyclJAcxdf0NqbT+IDcuNQ+8v7b07b
	PU/mX3yvWSS7u2Pfy3a8CFS3+htqadyS1I+Aet5VEfCtEfJ1wq6YrzrMOYGF9EPaZRp0qi4h4Xs
	wIUzJoSzJsFhyqXK0qmj7T0F40wZYwENepGQKOQvpuaP04FNV7jZNTH06UjV
X-Google-Smtp-Source: AGHT+IH5yEEayLyYxk+VP2FS/dUd6X0Bn606MWyZXsomwPQlIQWlOA1vA3Id4BOZpHp2g0hyQDW11A==
X-Received: by 2002:a17:902:d50e:b0:220:cfb7:56eb with SMTP id d9443c01a7336-22c41db324dmr14047535ad.26.1744854867121;
        Wed, 16 Apr 2025 18:54:27 -0700 (PDT)
Received: from Inspiron5000.localdomain ([2001:56a:f6b2:4a00:7181:6803:4a12:f331])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe692dsm21647555ad.224.2025.04.16.18.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:54:26 -0700 (PDT)
From: Nicholas Chin <nic.c3.14@gmail.com>
To: viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	nic.c3.14@gmail.com,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	vincent.guittot@linaro.org,
	zhenglifeng1@huawei.com
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
Date: Wed, 16 Apr 2025 19:54:17 -0600
Message-ID: <20250417015424.36487-1-nic.c3.14@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
> remains disabled on resume—as expected. But due to the current code
> forcibly enabling boost at suspend time, the system ends up with boost
> frequencies enabled after resume, even if the global boost flag was
> disabled. This contradicts the intended behavior.
> 
> Fix this by not enabling boost on policy exit.
> 
> Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()")
> Closes:https://bugzilla.kernel.org/show_bug.cgi?id=220013
> Reported-by: Nicholas Chin<nic.c3.14@gmail.com>
> Signed-off-by: Viresh Kumar<viresh.kumar@linaro.org>
> ---
> drivers/cpufreq/acpi-cpufreq.c | 23 +++--------------------
> 1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 924314cdeebc..85b5a88f723f 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -89,8 +89,9 @@ static bool boost_state(unsigned int cpu)
>       return false;
> }
> 
> -static int boost_set_msr(bool enable)
> +static void boost_set_msr_each(void *p_en)
> {
> +	bool enable = (bool) p_en;
>       u32 msr_addr;
>       u64 msr_mask, val;
> 
> @@ -107,7 +108,7 @@ static int boost_set_msr(bool enable)
>   	      msr_mask = MSR_K7_HWCR_CPB_DIS;
>   	      break;
>       default:
> -		return -EINVAL;
> +		return;
>       }
> 
>       rdmsrl(msr_addr, val);
> @@ -118,14 +119,6 @@ static int boost_set_msr(bool enable)
>   	      val |= msr_mask;
> 
>       wrmsrl(msr_addr, val);
> -	return 0;
> -}
> -
> -static void boost_set_msr_each(void *p_en)
> -{
> -	bool enable = (bool) p_en;
> -
> -	boost_set_msr(enable);
> }
> 
> static int set_boost(struct cpufreq_policy *policy, int val)
> @@ -532,15 +525,6 @@ static void free_acpi_perf_data(void)
>       free_percpu(acpi_perf_data);
> }
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
> /*
>  * acpi_cpufreq_early_init - initialize ACPI P-States library
>  *
> @@ -931,7 +915,6 @@ static void acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> 
>       pr_debug("%s\n", __func__);
> 
> -	cpufreq_boost_down_prep(policy->cpu);
>       policy->fast_switch_possible = false;
>       policy->driver_data = NULL;
>       acpi_processor_unregister_performance(data->acpi_perf_cpu);

Unfortunately the issue I reported still seems to be present after applying this patch. Upon resuming from suspend, the system is still entering boost states descpite the boost flag being set to 0.

