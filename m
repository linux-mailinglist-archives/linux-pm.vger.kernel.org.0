Return-Path: <linux-pm+bounces-25465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1787CA89A41
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192F93B7C76
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F929116F;
	Tue, 15 Apr 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rb7Qeah8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978BC29115C
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712965; cv=none; b=eeFKyIUKVxMgRls9F5CePJIb8FIU5vzFRKfDmwXCypQjMGBn7sGAU3r/MSRFFoKMDUlFZKwA/RaEaMurPlQanxv5R8nikrrcOFcWIWXEyy8LtweJNFs+pu6KlGcmAQR0V2FTdssSLPfGuFlEFpRdFqyC1bfUDdAbB0K7+rcyMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712965; c=relaxed/simple;
	bh=WAJr82FrsHYXu+5YGyk9NIhyBQaipAptPFKzmt+imbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwjPXbTdsPexuoQQRmwcn5euXkYZ/BI6MmMeEdZkgvSmhOiIsVal6dB/DOTxYrJ887r1t7URyryn5HyJ0n+knp+CHyChN74Omb+aOc5zR4CYovnssl1i+pdrnpLOQFo4iV1bu8G0V+FiYAp28K+pq9IBR/v1rqGtlc8P/Q/nPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rb7Qeah8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736bfa487c3so4610026b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744712963; x=1745317763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8WIm7JBhiWCi7fBzix5XYwTayAnxjcDkZHAFyWo6KQ=;
        b=rb7Qeah88j5+c5NjxmMDSqTk0uHshnMD8PdWXA5npeNw3WeAhErUpcYP6r9ANv16wP
         g88SZtupb8KBju8TrPgR6eJfVO0mSPjJQw4UCCJQt9Px/DS10hWmttuhaY7EzB8Uv/Ei
         JHnKglfbZshQ9CNrJcpAKA4UEEAyziYd+kVFdUBXnSo9w6NbXVAVcPUrQuRugPHSEmpx
         pKo7ThO1rBgEon1o98Dnehyhv7QoGMKMpgnV58x5yGH4aPKY9V0uj+7PDnP/AAFvfRBF
         iIqDj25l+pc1CvMPIorxYyxQzUr6F9HLo8GxBcOg7p4d1k44l/T6smt/2j48SAOoMIqy
         t6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744712963; x=1745317763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8WIm7JBhiWCi7fBzix5XYwTayAnxjcDkZHAFyWo6KQ=;
        b=X6Z9dbXTUrB/zDzVqXmQzGc777ohCxzdYsTxmJf58UUgF/BjhCVmHKTcLRaJnlBDzH
         Iy13p4rSa6a0vkY/qbiFyJZtJWun58NyV3gj+4oJXP/o/3Q2JC3wcFnGBW/1j4VDxVDg
         it4L/uS1ZfFAZ2qY4kzML+FKe70hPjh2CiHgBKrNgS54EJXY6GoU3zQjL4nZJB7fGqGK
         OzC97BosmLNONGCL+IX8dLBZYSxJZxtXt7yfY0zXq7Oxs6qk2GJWGTlEB1myclH1whbp
         8nJkECdOcg32XffZoLhoWGwg8j+SlvvKTHdCo8GxpgwLrsqguiK3mfV5ue4LTnqeClfe
         J7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVIlMn+DvBW7NikE+kSnnX/8IO7gy0O4W8mSu86givi5MLU38eF1lMIUYaYTl296Zxc+4tKo9RrDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcdUrlxYT8GDn5Y/HQL6LlRkS7W6EgoPLJpr4mxPJX+lxJXFo
	MmH4/uiO0/Q0MwfHAhJ+fI+DVUE8iYBP0wiePU5XLaB1xxzxocrSww0iZM1qcBs=
X-Gm-Gg: ASbGncuJsJkffxx+VSOKOUgkG07ILLG1vhwJjOfbtEkOt0x/bDdV1NX2txaRsmP2A+t
	wcxWcSlyAbbTQIpiNvFW2anRiYMZ1WkCPuJEWl2PkOQZKTBHpkOO24NvQ9weAzDvNpBp55QuvLl
	oZjMBzUvw0Xb40FZmoddE5of7DMvuJoAyirC61frxYK7IpezvQ/6qsVLfshUfv4gEtl2rNHFTWm
	gOi28cRX57Y1YkROKr5fxYemrzs0ybY6MCxREnAG9z0hc77mPhU9D/ACH0SnMn9AsAd0/TbQr5e
	HnRMfdVMJcDXbJasmzsyxJwyth0JMdf5m5DgoFUgEg==
X-Google-Smtp-Source: AGHT+IEf7wZiquoN/jvqZOk9knw/TvnbgoeeZknmIHERtvY4tqspbW0S/OlAAtvz+bGNryP8Hb453g==
X-Received: by 2002:a05:6a00:a91:b0:736:62a8:e52d with SMTP id d2e1a72fcca58-73bd11fe733mr21565120b3a.12.1744712962726;
        Tue, 15 Apr 2025 03:29:22 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c78a8sm8164229b3a.70.2025.04.15.03.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 03:29:21 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:59:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>, nic.c3.14@gmail.com
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 4/4] cpufreq: ACPI: Remove set_boost in
 acpi_cpufreq_cpu_init()
Message-ID: <20250415102919.rqvukeycue6rmiku@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-5-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117101457.1530653-5-zhenglifeng1@huawei.com>

On 17-01-25, 18:14, Lifeng Zheng wrote:
> At the end of cpufreq_online() in cpufreq.c, set_boost is executed and the
> per-policy boost flag is set to mirror the cpufreq_driver boost. So it is
> not necessary to run set_boost in acpi_cpufreq_cpu_init().
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index c9ebacf5c88e..f4b5e455f173 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -891,11 +891,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
>  		pr_warn(FW_WARN "P-state 0 is not max freq\n");
>  
> -	if (acpi_cpufreq_driver.set_boost) {
> -		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> -		policy->boost_enabled = acpi_cpufreq_driver.boost_enabled;
> -	}
> -
>  	return result;
>  
>  err_unreg:

https://bugzilla.kernel.org/show_bug.cgi?id=220013

"
On kernel 6.13.8, disabling boost by setting
/sys/devices/system/cpu/cpufreq/boost to 0 would persist after
resuming from suspend. After updating to 6.14.2, the system is able to
enter boost states after resuming from suspend despite the boost flag
still being set to 0. Toggling it to 1 and then back to 0 in this
state re-disables boost. My system uses the acpi-cpufreq driver.
"

This bug report is filed and git bisect points to this commit.

Rafael, I think the commit in question did the right thing and there
is something else in the driver that is causing the issue here.

I think the problem here is cpufreq_boost_down_prep(), which gets
called during suspend path and enables the boost.

But since the boost was never enabled from flag's point of view, it
never gets disabled again on resume.

I have suggested following for now to check if this is the case or
not:

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 924314cdeebc..d8599ae7922f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -538,6 +538,7 @@ static int cpufreq_boost_down_prep(unsigned int cpu)
         * Clear the boost-disable bit on the CPU_DOWN path so that
         * this cpu cannot block the remaining ones from boosting.
         */
+       policy->boost_enabled = true;
        return boost_set_msr(1);
 }

-- 
viresh

