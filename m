Return-Path: <linux-pm+bounces-10009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A278E9177D4
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FEF1F222CA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E15A13AD28;
	Wed, 26 Jun 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZ1qhjC/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15436433B3
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378277; cv=none; b=M8vgoRVlesQ2YJD5qjouyEsaNeihHuGIH3OdLRbg+f9AUMwsaTe+ECwzjDyuzHxwfyjnnR7e8r8zYQFV1KsR9Z5LRsKTIG3KcDlUMSHQCoYTu6xnjBQXhmS3wV2XbBsUhCmFbStLI2/Z5JMeY1G65SfzlSIQj2ZXNfBk3D0KFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378277; c=relaxed/simple;
	bh=skwyMGNN0fw+ebl/dDqi4FIcIXc3uWnGZTCXE9j1uHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onbLmDGGW4Gz0gFGQZmhy9V0WRmcRTTMdr4GCqO4WNHwDqjVghkLvdQVM0CxSJAqb/QX6ZH4spWNsX1rSLoZUXP2dVTbhXjhYmKt5/XtCn5HHtoCkBhFSaH/kT/YdfiwUazVWjafXGarbeGfWX3NBZ32ExFUyU3pvXZURE70g0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZ1qhjC/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso5195278a12.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719378275; x=1719983075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cxMSGpNv1kTvboB4aFMLEqH+ogWlfv846WLQjbw9uc=;
        b=eZ1qhjC/UyxsTe6QQgA9r2E1PpVshV51wtsjSMXp/dhllozU3Q9U6j8IGL5X9zQlHj
         lFPMMB+uwkZ/Er8sK+ADMeT4aOml8azuELIkzzfGkUdUJrsu+wOZspSHz45lGFQHXtJj
         mM/Mlmrm5qqMrr5wAWo+lF1IIdfDIpRik46ptXkcwDzOlxXf5ZXmy4XQ0hVM4HOlqsqm
         keLswsV/lVLOAia40JZ4cHf+5wt5UKYrYpzQzUTctQGQkw2BYk/BCU+xUtjOUUiQ/Mme
         KSQ2dzo97P3kCDBEJykelTJcgvcAj6qWa/BORJqbWTsbZnaeSb7jDg5UbPlM6ZuXdYaR
         oGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378275; x=1719983075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cxMSGpNv1kTvboB4aFMLEqH+ogWlfv846WLQjbw9uc=;
        b=UAo+ED7oLHxKkVAMDV0i8Gq4hzrw+m0U+2V+okU3Ty1zM/JxFIlczT79K4FyoCZNry
         Xa5vAJ4E6SQHJK66r50ePqWf0rfwJiVYpwvnEpi332GTNtN3+X8lfr2TUf5HkIgekCQP
         C3Fgp6aMQDKbJDKt3bHSlRz0cBsOcGpBCR89SSHVbZe3/QQGPh/rwKMSojtw6ae8YTuZ
         oe55AsPAA+5qFYTQHIFoJVaMstso7pgDZwX3NA2NEtwkOrwnVyeIdJ2UNYpl46fZBbWC
         Yix65LinI9rrbgc0k57luF8jmcDSPb/YavWJPbNKDH/LskFWeRsLVyAjpBlRtoY6YJo1
         CryA==
X-Gm-Message-State: AOJu0YxKZeHBOVB0Ctol0GntfugZG+p3itEyGKRK+s7t7jigz4ZmPrjd
	U7xtFUAApBE+xBSmIlEhRW9BN/e72gpriuWo7CCTBLTrGFTyOSXPjXmYqT+6No4=
X-Google-Smtp-Source: AGHT+IH1ffAMlnf4O+1IRMn99GAX+tKNZQ2QXZmBlTPwOxY6Bl8UVSCiDfoRWOcXf6iv6iYx74Tevw==
X-Received: by 2002:a05:6a20:6d86:b0:1bd:1e5:c5c5 with SMTP id adf61e73a8af0-1bd01e5cd17mr8248238637.28.1719378275156;
        Tue, 25 Jun 2024 22:04:35 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb321a83sm90357015ad.95.2024.06.25.22.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:04:34 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:34:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] cpufreq: acpi: Mark boost policy as enabled when
 setting boost
Message-ID: <20240626050431.mkhfm6rjexspncpe@vireshk-i7>
References: <20240626041135.1559-1-mario.limonciello@amd.com>
 <20240626041135.1559-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626041135.1559-3-mario.limonciello@amd.com>

On 25-06-24, 23:11, Mario Limonciello wrote:
> When boost is set for CPUs using acpi-cpufreq the policy is not
> updated which can cause boost to be incorrectly not reported.
> 
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> v14->v15:
>  * Use Gautham's suggestion instead
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 37f1cdf46d29..bd3f95a7a4fe 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -139,6 +139,7 @@ static int set_boost(struct cpufreq_policy *policy, int val)
>  			 (void *)(long)val, 1);
>  	pr_debug("CPU %*pbl: Core Boosting %s.\n",
>  		 cpumask_pr_args(policy->cpus), str_enabled_disabled(val));
> +	policy->boost_enabled = val;
>  
>  	return 0;
>  }

This is probably the wrong location to make this change as this
function gets called from cpufreq core too, which also sets the
policy->boost_enabled flag.

You should set this separately in the init() function itself after
set_boost() is called.

-- 
viresh

