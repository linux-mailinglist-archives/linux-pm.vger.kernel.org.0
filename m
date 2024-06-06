Return-Path: <linux-pm+bounces-8693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2398FE23F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908ED2816DE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0A149DE8;
	Thu,  6 Jun 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOxDOP7u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B11482F9
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664862; cv=none; b=bS910d7l3P1HcKkXXQ9fxjw5ZE/FfM5cA9JIYOLGHXwe3EY4UMbbgPgQoGIm72fM+mil5r2XVKtfoN1igbgRyJX/n61F18taPxd1CDJciAs9jQqA+Hi7a6ksQB//yqI2JIBcHWV/aNPmbGxKc7MSK+0fjnkcnLiyxZljOqVm3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664862; c=relaxed/simple;
	bh=12+HnR3XT9xPMHW0m3i24CxsqNm6L5UZ44D6+dANpSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKne8G+N/v9XIfwgMIbqwH921nzdGNASpidYfonhuUjUc9E8aXZbmg8w1Sv9mgIGIm1fQPrnn8ZHDcXVchHhLeLO9LLa6pS4l7LNuGWVseUmuFMbqAWovun9Aiq7AeZ4XRBgJrUSvUNfg5AOH3LqROfGDhgvcMZg5DRLsMufjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOxDOP7u; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6ce533b6409so510227a12.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717664860; x=1718269660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sL7Vp5jCLEFf3PtEQziMPHphd4q4fdHZEr25V+ICNoI=;
        b=eOxDOP7uWPAWO9WcT9xHF5ZiS+tbER4PUAdpXO3y0gxkin6jwEDflZom4CziVVb43W
         +tRBHWdgRNulqPHdnJC9W/o2oO1nNcqlJN3pvr1+eORiVpbhEjghp/ZJWhJuelLy8O0M
         oNeCn4Xef1czkEdQqP5jqNuqX3ZZkCf0GDANCU5rzytVbjQ9hG7S3hh5Yn6y5oAhbx3P
         7l9X+Mi/hABNDMUgU7euk6VNx+1aJfI2xaGuchLZD2mJ2FE4tUj+zJTp2nmguG3bhp8l
         u2473hxf1cjlk6Q9HDJ5N+I83hE68g1N4W1fGxW9m8+LF4APBZVqJo20TXrcAsbSuutM
         HZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664860; x=1718269660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL7Vp5jCLEFf3PtEQziMPHphd4q4fdHZEr25V+ICNoI=;
        b=Y5pg/kot+z20VeIaIiaiYe6mRpUf4s+qoD3DG7f8fe/lsPbLBAcpFUspiEuxJP4x/B
         KfS3lzlcCwOznNUknhX34KiXcPDBwTjg9K48UrQG1Wxil+8kV8psF9+rF3Wx9nlr1LzN
         HLAXtlRfPSq5Elt40n9VMV25U7pDiituH4bXtynOjY/M5rVEuNmMlxkRnaArtGvz+peR
         sEIynY5CwkUxD6ShvT6Sx+a1lwSg/d9KAbHnRB/EmG23OhQwrW8lEGpXP5b3OvBh8WUI
         34tbEkG7wpr+rsSKsX80B7ss+NGAjQd1VoFbhBVUUnS6o4BVDiNieMBfC1RsiCrByY/u
         Mbaw==
X-Forwarded-Encrypted: i=1; AJvYcCVfu6R5FjqFeIjlYN5+JD7ELuL93v4hdSceSvpOfhkbUKbd9f+Co/sPPOVhIplfC2yrbZGTyQegg1e4J33IILud8u0Q1zB28gA=
X-Gm-Message-State: AOJu0YzvPYurOtpfFFgOnOHP8cpATpS+g3tqrQ1znlURJQRGCZc8wIcz
	9NFTbbj+YBHO0tkcMUM0g6nEAIX1WUCJDxrWXH8wlxZWFWLHVUe7paSTruBlBHGkXaOqgvghPbL
	e
X-Google-Smtp-Source: AGHT+IE4OX1OfiMTpsm6X5p243uV3bc9VV2G5/w8KsBpYY6LPPvpNmK9P4pK/aBv6YBgzmn6wFpBZQ==
X-Received: by 2002:a05:6a20:2d24:b0:1b2:c28b:57ac with SMTP id adf61e73a8af0-1b2c28b59dcmr3704103637.62.1717664859923;
        Thu, 06 Jun 2024 02:07:39 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd372e6esm721988b3a.34.2024.06.06.02.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:07:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:37:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>, beata.michalska@arm.com,
	ionela.voinescu@arm.com
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, hotran@apm.com,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when
 set target
Message-ID: <20240606090737.z3qenphikjs5ijj4@vireshk-i7>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>

Ionela, Beata,

On 30-05-24, 19:08, Riwen Lu wrote:
> From: Riwen Lu <luriwen@kylinos.cn>
> 
> There is a case that desired_perf is exactly the same with the old perf,
> but the actual current freq is not.
> 
> This happened in S3 while the cpufreq governor is set to powersave.
> During cpufreq resume process, the booting CPU's new_freq obtained via
> .get() is the highest frequency, while the policy->cur and
> cpu->perf_ctrls.desired_perf are in the lowest level(powersave
> governor). Causing the warning: "CPU frequency out of sync:", and set
> policy->cur to new_freq. Then the governor->limits() calls
> cppc_cpufreq_set_target() to configures the CPU frequency and returns
> directly because the desired_perf converted from target_freq is the
> same with cpu->perf_ctrls.desired_perf and both are the lowest_perf.
> Since target_freq and policy->cur have been compared in
> __cpufreq_driver_target(), there's no need to compare desired_perf
> and cpu->perf_ctrls.desired_perf again in cppc_cpufreq_set_target()
> to ensure that the CPU frequency is properly configured.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> 
> ---
> v1 -> v2:
>  - Update commit message and email.
> v2 -> v3:
>  - Update patch subject and commit message.
>  - Remove the desired_perf compare logic.
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 15f1d41920a3..337cece61ab5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -295,9 +295,6 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  	int ret = 0;
>  
>  	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
> -	/* Return if it is exactly the same perf */
> -	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
> -		return ret;
>  
>  	cpu_data->perf_ctrls.desired_perf = desired_perf;
>  	freqs.old = policy->cur;

Any objections to this change ?

-- 
viresh

