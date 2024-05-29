Return-Path: <linux-pm+bounces-8328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDAB8D2CAC
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 07:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD831C25099
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 05:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0B15ECED;
	Wed, 29 May 2024 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBAHI0HI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227815CD55
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961018; cv=none; b=FWaMBBbkBULQFWv8jtndre2CW6BRdSMQihF8xexG2tbv4+Zl+Rh2VxBAC0zGp9JPRNy/hMIYt5b7CdUrnluhXyvRYkXANcLwKIaw3PIynuvNBATs6pVpWU6hdy199ShbpxukvXAkpSTZ4oQNXGidCKpTzeJJ6FamdBNCODx8Yn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961018; c=relaxed/simple;
	bh=Qw+SVdZU7dl3Iz5CgVUnpb/7nEuRRMGVLU936J0+5g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trbJPWdZeTyiQMBRiq7tQaJas0j89drE0hBAsbKuoW6n2lxR7v3/zr2c+ifOfTIiaD4jEuxD7gT8pKdx/hkygyOfLFW7TV6YMhvXiuoobczI6ZQ/edc/Ws+X0ZYI+suqMsxUAgNgoag/z9QXAWQHDRoDG9tAwZ20DgLeRqbgVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kBAHI0HI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so1351821a12.0
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716961015; x=1717565815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fXHYZjRxRfJOZA8/qFOHUh7lsjZxW3P4imwmiPFM/Y8=;
        b=kBAHI0HIR5NR8OupfakOwYCA1vmfA8oj0v1Bis5FuXemDoeAa6PNUvol5nadxSAoAK
         S+TFS1jTGb950ilFO19U8YcajhZrGuhwAYsg7SBjLHhgMpVMV7oYqXuYdCiWMN6qhJNl
         yDxY7FMU2cpzDpEN3ok3TAb4ao1+Tr8wHNNCJwSXamxkLJIpDIW4fSHqQ0WjTMicWR4Z
         9pgawkAJsmluKZ8ZCfmzcWdQEHJsL4q0pGLQadMVuuilFOw3M+VDLxicbjx9/AnPn9Mk
         M5rlQ8enKnJqcCYSh+olNMezH+6upIvXPyG2IJrEqs4imay8+SlHMpLdp5R4R33IdY5c
         DYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716961015; x=1717565815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXHYZjRxRfJOZA8/qFOHUh7lsjZxW3P4imwmiPFM/Y8=;
        b=Oino0sCFGz2ZksCkWFhmm5Qgnz6+38kJILFAMhqHOenlGO/xWLBIptoNxhmSA9kSpH
         9cm/sBQ87ZD/Go19draGxS2yzm0a4MqMeC5gND5MBvuHCfw/gEbKqONu2UxzyqZ9TXwD
         oOEVMf8wCrDXfMTTozEaVyWqZ7qriu4t/El/kOKGoDCXPNeEMejq9vOczhtXcGBA+DQo
         eaLNSr6Lrn/rjnujIvOOV+0qUzUSj8tBH5l867Mkc5U/WCQPXRw05hMvs9QfB7hB/WqG
         fQOaEg+RojWKkLhqj077wTR4rEYNferyXngkNHUgucJc7voeB7ei2IQx0AeQxPGvqt4L
         nt7w==
X-Forwarded-Encrypted: i=1; AJvYcCUgcF1l17BFjiwLASz4ihE2ylNOS3eRHeOJnvP+l0sCrQ/9GiCS8HX9MyYiFjo8zkUiQ1F812VUhcJZ5OrPefNpsWTZ4FqTjBQ=
X-Gm-Message-State: AOJu0YxM8GASuA4mFUfbrDjAeOOqWKdAFklEi134SnNZj7JsUMzkwOLz
	/nImnJXil//mnxiYQVFTxPmU/ynjSp+CjTBcPg/Wb8P35dD/KuFtEhJVbdSiodE=
X-Google-Smtp-Source: AGHT+IHJqMoOKjFMIcm+63tMtrDnjBUXXM2u7Q0ZFL9TyjONITAZjYU60TASkrzu36aGe8Wi/11wuw==
X-Received: by 2002:a05:6a20:9188:b0:1af:b1c0:c9eb with SMTP id adf61e73a8af0-1b212e02f4bmr18803674637.45.1716961014999;
        Tue, 28 May 2024 22:36:54 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f989871sm8618473a91.40.2024.05.28.22.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 22:36:54 -0700 (PDT)
Date: Wed, 29 May 2024 11:06:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set
 target
Message-ID: <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
References: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>

On 29-05-24, 11:22, Riwen Lu wrote:
> From: Riwen Lu <luriwen@kylinos.cn>
> 
> There is a case that desired_perf is exactly the same with the old perf,
> but the actual current freq is not. Add a judgment condition to return
> only when the three values are exactly the same.
> 
> This happened in S3 while the cpufreq governor is set to powersave.
> During resume process, the CPU frequency is adjusted to the highest
> perf. For the booting CPU, there's a warning that "CPU frequency out of
> sync:", because the policy->cur is the lowest_perf while the actual
> current frequency is the highest_perf that obtained via
> cppc_cpufreq_get_rate(), then set policy->cur to highest_perf. The
> governor->limits() intent to configure the CPU frequency to lowest_perf
> and the governor->target() returned because the desired_perf is equal to
> cpu->perf_ctrls.desired_perf leaving the actual current frequency and
> policy->cur are remain the highest_perf. Add a judgement that if
> policy->cur is the same with desired_perf to decide whther to return.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> 
> ---
> v1 -> v2:
>  - Update commit message and email.
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 15f1d41920a3..802f7c7c0ad8 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -296,7 +296,8 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
>  	/* Return if it is exactly the same perf */
> -	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
> +	if (desired_perf == cpu_data->perf_ctrls.desired_perf &&
> +	    desired_perf == policy->cur)

From my earlier understanding, desired_perf is a derived interpretation of the
frequency and isn't an actual frequency value which can be compared with
policy->cur.

Shouldn't we compare policy->cur with target_freq instead ? If yes, than the
core must already be doing that somewhere I guess.

-- 
viresh

