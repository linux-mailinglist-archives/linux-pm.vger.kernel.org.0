Return-Path: <linux-pm+bounces-24682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BDDA7766D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1717A30F8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1581E9B32;
	Tue,  1 Apr 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdB9YS7V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F75B673
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496218; cv=none; b=eCgQCxuVrzcfHjqXefeKqR7G7za+79viYFBF+dXLkttEiC4LEha99vwiTf9yeDgDrGZP7VYLRZygmXS0fRFypg7a+CCPdbbIR5YbKHKh+6578sm/y5wSWSa6bf+tOk8cW58zPbMEa80M553rgxM76PsozHTCKAdsMywoEzyoH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496218; c=relaxed/simple;
	bh=+PdOQY9G4Z+V6nM+cOHShiUAWSWzkcANFdjWh390aHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQotHt1x0ZY+h5eAxiHj1J04YF8tcDazlgqYQdbv6jTmJZOOjnGNa+UdjDSJGgc2PMJ0qKdUbjCc/RGWpFsRN+T5p6YaTHAWoieDjI2UNBLnlXH48etxZKFj5k3gCu+WgcWV31ynww8k5W+qcC5v2EJF8IzGUztzhqNXoci6/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdB9YS7V; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso96971945ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743496215; x=1744101015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVkJHao0eWoC+KfJ0cgjojVWmT2IzBUFiYW5OYDGp1w=;
        b=RdB9YS7VqY2nHJqeUpRh2TAMJKw4VGicu5mNDVuCviRPu1ma2upOejqYQUai7YNQY0
         K7ZUM8y/Xb0qDyUGFRhnANWqfKc+7SO4CQxkhNUNSM15A7gCoRKtIVNufogbjd67JKut
         V2QfKHo3GPLfQCmGtnD/59vwl+1mpC67Oz22wCugFxd9vamJ16rC1rzP/2OTSWLLEGL4
         r1Cc5rrobh1juqPBNNWkrWkC78q6Q+W9kIxVHFf4r6iEkpU7aE1VgIo82jnp0nCz2hqe
         OVl3zCm8QtuzbfiaU5WRuwug4c2WOM8uYV8vmMHHD7AwGyVMIpZ1u5FVYDICuuxO5VDV
         08aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743496215; x=1744101015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVkJHao0eWoC+KfJ0cgjojVWmT2IzBUFiYW5OYDGp1w=;
        b=KcTVFTkAlGpzMhjOlJy2QrboiJkxshnTPXb/wgv4pkrsxyjl84okvft2hh7O0QNWYd
         5Yw0qG2A4km5H1tt6MXKAk9ynm8iE4pg7tu8YCZfAhFt5+fx/bzPrbidFfwY4tWX53j3
         igHpf4g1zU91Msed8AdIleASE8Hgd0nuoSqv5En/P4BRedDJFISEKplu5iDg+5eq2XOh
         451lCi8QBaZYKZ4ANbqh5Th0dVOPUGnvqN0qrSFvljAlBC6N4koeIC6hzUg+0brZQBbH
         EIgVTMb+yBZNuneP/rcuF5Thfy8FJpRZ9C+GjqFQlse8fahp9Dk7gtttsC70f7HaB6Co
         q6TA==
X-Gm-Message-State: AOJu0YxNKAiXkB7eBNz9w/LFTozscOIPIJ5KziM6sdVFhjjXd54qrhy+
	0CeW1iVgzQo2RGHpVu98RC6DBxApPzVeGp35yIgDAfbr8YQSLi0wygdW/Z70t/s=
X-Gm-Gg: ASbGnctZsLt1tnrIand1lBBH0kivFOMmOzZM5wqy38v4j7QSM5ux8s98ciFy0+74+fR
	hs9WmxMgjmVGMqj9R1s1XnouJydRTgV3SYlGeBX2ToEiyXLMKMwtbGLv2x/sZoCNqK33J1AbZvO
	4H1I+czBQNOkk82yrJbunqSQPFp5MMwh55plk2X+L18m3xJw1gzaOe9WuYkQQAYicig01pBPo4l
	e1zW6qXZkw8tjCwaRiFNt0KuGMv89Jj0EbQ/0lyw9zIo1JbStHxNjtgqRF9H/ri4W4HpuB7lmeS
	Dt1b9YTUdVvkhDFsIrP7iHP6PR7zg9VslBYujqKGHzZKU9w7UegTDghC
X-Google-Smtp-Source: AGHT+IFcco3jmVd5+UMh72jl4ZYzaglj69gHooBlOcDmi7HxtLW7NW9Xm2Hy0zPWOtCvcc2s0O+1tg==
X-Received: by 2002:a17:903:40cc:b0:21f:40de:ae4e with SMTP id d9443c01a7336-2292ee6363dmr168754105ad.9.1743496215410;
        Tue, 01 Apr 2025 01:30:15 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1df12csm82615935ad.191.2025.04.01.01.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:30:14 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:00:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v1 01/10] cpufreq: Reference count policy in
 cpufreq_update_limits()
Message-ID: <20250401083012.vjwkxjkmd5afyqjt@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <1928789.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1928789.tdWV9SEqCh@rjwysocki.net>

On 28-03-25, 21:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since acpi_processor_notify() can be called before registering a cpufreq
> driver or even in cases when a cpufreq driver is not registered at all,
> cpufreq_update_limits() needs to check if a cpufreq driver is present
> and prevent it from being unregistered.
> 
> For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
> policy pointer for the given CPU and reference count the corresponding
> policy object, if present.
> 
> Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling of _PPC updates")
> Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
> Reporetd-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com> 
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2781,6 +2781,12 @@
>   */
>  void cpufreq_update_limits(unsigned int cpu)
>  {
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return;
> +
>  	if (cpufreq_driver->update_limits)
>  		cpufreq_driver->update_limits(cpu);
>  	else

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

