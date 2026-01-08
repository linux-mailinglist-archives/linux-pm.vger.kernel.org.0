Return-Path: <linux-pm+bounces-40410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38FD00DE6
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 04:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A5B8301E15C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 03:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C258F23ABB9;
	Thu,  8 Jan 2026 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onH5rYAO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AE13635C
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842836; cv=none; b=nQRBLXvpsdbTEyH41OaW/L23w5tk+bJIN+v1vTDcoDzOjHQozhIcJZfminFlhfXQs1OACuq9mCfcB5o7Na8AcgPnUregn6YrCak3tKCYkfHzrI9bFew/031cvYXoAvdCvY8mFsp9GObQ5Q6tYs6thB8QRkieg9iHbiA263yHoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842836; c=relaxed/simple;
	bh=uRRzFOarmIqei7630HqvPZpSNuM3xX6E9wa8HXF9jBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAl4Jhaa0/VCnwdTnCZF2Aup0+ceHDQ7Ih7UM/cm3Qum+Ut4gdwj2v7vtFe0j02ulFdnc4tyvh18CPJp1+gAMFl9r07/IvlpjyIP5EqV3pHpzRCPi/V7W6Vy437W3UNujgymQWIsqn7rPix7Z/Ax8onIVgkU8ct1bMt5TKrGD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onH5rYAO; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29f2676bb21so25604885ad.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 19:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767842834; x=1768447634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu7Pr1Fsv537lLh/d+ZgA1WZ3a8Wch+LwtiH0stf88o=;
        b=onH5rYAOwB/Awl326lldisXnyp7F5KUCpioL61/tZlPYtxZIs8Sv0d2quZJMD4oD3k
         IWK4H3D0NkIfu+BLvLZCCrMFJLDyfcSaXiQ4EdRuFO3rWVg/If4/NYUHwjacb1c77FjA
         N7dg3NpeZotD5Jz+n8O5ju+k2Wuzb6vJQnmJcIh6y2YOhMMXX0pDm8IQUlnpc0YPcSL1
         fONBcDDBEDFMIwRTfAH6JjL1fF3LAmaooYioJZo5qM75scaYrwfJd4eltpBPGe2oUN5X
         8E8/Asm2WRkRi8iZI2sMYH3xB9rwxTntGG5YVdnaQLEH94rNIOAkQYu8Ul+q83ghK3Du
         Gxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842834; x=1768447634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mu7Pr1Fsv537lLh/d+ZgA1WZ3a8Wch+LwtiH0stf88o=;
        b=fd1dcUXz9AUgF9E4X4SzUbjNIO3HGKxQ38hVCGJZFDmdvC7stHjubMLctlyGCK7oby
         dP0NV2AqH6SbO6sIAybv7+PSBZ5C890jX6Ksuh497pIKruLHJ5OGiE6oRNAXdhhagK5m
         PHgTUoakqdI37R0eoObbavX6Is7KuaEUAM6ujuR1V3uyY62FSIbIIq5j5qEIhyULSkZc
         u9ZzyMnGYVNcndOyeBjYtW0zcSsi/7Y+zAScLnJu3R0aXkR3j6UNMQNUgTiUTIwZaDT2
         h4O/JIKylNtFTv0RhfgPiXF3X66YzyUHPtwfaaqpKSClvUoHCUJGV9oDF0pfksx+7V+/
         nMOw==
X-Forwarded-Encrypted: i=1; AJvYcCUW4bfeqffNUFYRanlxqVr9cpHznUWIiVmGlz4A1dXXXasy7/buqLkRKDYFp65BMMaCwiOk0GoZIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKuKCHHW81YdRwHDTGl4cwP5Dl1BERx0t6HE0vAns97+TUW+w
	mU3qIB6jV03Rg4gp8Z15p7gQwPQzRVjpnBL3PYiHIozt7HHn0WdMoUsTDHgPENfpdQ0=
X-Gm-Gg: AY/fxX6Wqq7vTi3XRaL5lWLFqqaiWONRGKyGlqjrX5lBMiLQ3vUBYSYvUluHXAVT+65
	Us96SisJBHBM4InhEj6CzK2GnibHPt6035lpJhXGlT7vUIlH4RRxmlUzWm6z8QqBqvxYHWu8E0h
	/FLm2Y7XmzEvKMhiahuL0yCcF6jJRRQowtFndaO1oayZ40F8B3xu34FqIjp8QC9aH5nWoxMe8iF
	z0YxP2/ehVsJ10GbFGvGe3+4FWit9aG8cC9XnNMCWghXcz57tUt1cxDEyVqx4ur5rkRxcMTDawg
	YX5p8GWAohcQXWY7jozIsZvycmaBYY27bL9cS0JCIBAWINSRX0GjNVVQY929UvmJxUtEPM+VAKZ
	qpW2eU3vNO4nTVDtnT/Rjlun5L5Ku0kPTHrwDF1lyQh29ft87Qi0giHQTN/3vHTLnWcQFrFAyEc
	LcvBIBtqKLT1E=
X-Google-Smtp-Source: AGHT+IGWi0WECARHC8sh1t7xnHsqYiwxnwYeP+AKv4h6c8GciQupJD36kPRYTo6CbK8YPrm4jsg9uw==
X-Received: by 2002:a17:903:1b4c:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2a3ee43653cmr44865905ad.19.1767842834139;
        Wed, 07 Jan 2026 19:27:14 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb0dfd29sm6063479b3a.25.2026.01.07.19.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:27:13 -0800 (PST)
Date: Thu, 8 Jan 2026 08:57:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: rahul@summations.net, anup@brainfault.org, 
	leyfoon.tan@starfivetech.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	rafael@kernel.org, sboyd@kernel.org, jms@oss.tenstorrent.com, 
	darshan.prajapati@einfochips.com, charlie@rivosinc.com, dfustini@oss.tenstorrent.com, 
	michal.simek@amd.com, cyy@cyyself.name, jassisinghbrar@gmail.com, 
	andriy.shevchenko@linux.intel.com, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
Message-ID: <5nfljdaewlmafydt5a3jijjlr2krszbnadmjkpkgo7in364yzy@tiejhive2siv>
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
 <20260106092117.3727152-5-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106092117.3727152-5-joshua.yeong@starfivetech.com>

On 06-01-26, 17:21, Joshua Yeong wrote:
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 78702a08364f..9aaa1f71000e 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -4,8 +4,8 @@ menu "CPU Frequency scaling"
>  config CPU_FREQ
>  	bool "CPU Frequency scaling"
>  	help
> -	  CPU Frequency scaling allows you to change the clock speed of 
> -	  CPUs on the fly. This is a nice method to save power, because 
> +	  CPU Frequency scaling allows you to change the clock speed of
> +	  CPUs on the fly. This is a nice method to save power, because
>  	  the lower the CPU clock speed, the less power the CPU consumes.
>  
>  	  Note that this driver doesn't automatically change the CPU
> @@ -65,7 +65,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
>  	select CPU_FREQ_GOV_USERSPACE
>  	help
>  	  Use the CPUFreq governor 'userspace' as default. This allows
> -	  you to set the CPU frequency manually or when a userspace 
> +	  you to set the CPU frequency manually or when a userspace
>  	  program shall be able to set the CPU dynamically without having
>  	  to enable the userspace governor manually.
>  
> @@ -134,7 +134,7 @@ config CPU_FREQ_GOV_USERSPACE
>  	help
>  	  Enable this cpufreq governor when you either want to set the
>  	  CPU frequency manually or when a userspace program shall
> -	  be able to set the CPU dynamically, like on LART 
> +	  be able to set the CPU dynamically, like on LART
>  	  <http://www.lartmaker.nl/>.
>  
>  	  To compile this driver as a module, choose M here: the
> @@ -147,11 +147,11 @@ config CPU_FREQ_GOV_ONDEMAND
>  	select CPU_FREQ_GOV_COMMON
>  	help
>  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
> -	  The governor does a periodic polling and 
> +	  The governor does a periodic polling and
>  	  changes frequency based on the CPU utilization.
>  	  The support for this governor depends on CPU capability to
>  	  do fast frequency switching (i.e, very low latency frequency
> -	  transitions). 
> +	  transitions).
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cpufreq_ondemand.
> @@ -367,4 +367,18 @@ config ACPI_CPPC_CPUFREQ_FIE
>  
>  endif

Unrelated changes ?

> +++ b/drivers/cpufreq/riscv-rpmi-cpufreq.c
> +static int rpmi_cpufreq_probe(struct platform_device *pdev)
> +{

> +fail_free_channel:
> +	mbox_free_channel(mpxy_ctx->chan);
> +
> +	return ret;
> +}
> +
> +static void rpmi_cpufreq_remove(struct platform_device *pdev)
> +{
> +	cpufreq_unregister_driver(&rpmi_perf_cpufreq_driver);

Don't need to free mpxy_ctx->chan ?

-- 
viresh

