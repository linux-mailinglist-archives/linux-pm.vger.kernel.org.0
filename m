Return-Path: <linux-pm+bounces-16711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4039B5E76
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 10:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2ADD28448B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957481E1C1C;
	Wed, 30 Oct 2024 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9c+h65K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD31E1A37
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279343; cv=none; b=WctdqF1I0Om1mcw7XPmBgurHxtCZV8tK2AwbvCKisqvoaxkos7yJ1pF6adBpqAYQt6xXNIzKP0pM202Zn/hLd8z573KEGyVVe4isylKeGA4gpFPFeQZ1LCb+/eYvXO0tucEPfyeBoG/OSAjKWLyIn6Qfxjn9QiMaIzx7wUMTxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279343; c=relaxed/simple;
	bh=d3Q+Yytwfe4ckVzNFhYv5nqhXE0KaEIAWOYK18fEHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUgBVIqqWKxB02E8bj73qtT6R1Pflp+QODbUJMYhlShJDMjWnOpsA3Kv7mDkqa7xmaRFd/zo2HPtJPMIFUkuICMJ7HyioWPfKRaY0MC5KBS5d/oNSCEfxon66TK0ENuoD8fgYyDNE7xDlQgc10f7YYz78rjGO5zM2PGEehTgCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R9c+h65K; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso4185357a12.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730279341; x=1730884141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PW7dWJigQBbEpDGe2vAuK8PqZgGZIhZvDH6evlQM/o=;
        b=R9c+h65KmyeLejilQiW4PYGRz7Vd6UcKvgbp1pSkAOHmTwQsm/bRkS3xFitiobMzPn
         X8/bynSfOkTaxcIT0c/YxtG8QypqOmBnmji2ISg+cMN5ZQj199f8ZxZUpDFkCOg9C6sk
         u8noe6ckfchWmCLXeytMxLC82M2Gbpoc8oQWRkmOyT1f5/ii3YoUGfwUiG/aJ1qIiu3A
         ZrA8md00hy6KSaQSRyHe64MuFxNw0DofITlj0P1rt50y0lKH18h8oVbQQobg+Z8wYFwT
         JiBa6FEgbUqQmjAhk+zWjpTICRHGQIzBokGWBrZVUBkj7+iWAZrDaq125In4etWI8OY9
         89Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730279341; x=1730884141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PW7dWJigQBbEpDGe2vAuK8PqZgGZIhZvDH6evlQM/o=;
        b=UTd8YWD4+3dlPRroJ5mxM7E55uB6HpgnZG4hH4XxEjrN4AcA1UHTF2jvYGCG0dWix6
         LEQD+MXw/SHDvkw1N4NHjUNgugcLNdfcUvc6HqU7YkOSKUq+9LtnE0a72uVEDRgg3Uyr
         v2Auk1pqyAcNvFenYQ00F6sBn6g1NoZ8kV1fvvHNC2V4WhV1PTTk7Rq9U9zE1+0KdNIA
         9evLiKibAsG9ej2HZYB5XKhlWW7SyWcuUEkj5VjpJ7kaU4YGqf7FirFWT5yrnsPdBNDh
         5tRTZAbCvNooATnXaznGyPUwqChBpYC6yT4RUHSfA+n8MtWLK1hQVUjEOoWju2sl+ib3
         YjFA==
X-Forwarded-Encrypted: i=1; AJvYcCVvhtNn83jobhGbzV0jxRRHeul3QNBPDYQxIUMYn7Uncgs/SQA36EOB8Z+rhIda00kPutRejIvahw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuv1OTOhm5Ies9mOeppBX9QoR1hkbemAzGSN162p6mk8Zwq1w2
	9JloVPf+6B0MQM8yKa1Ig3ekncHCHoK7elbC+/7pg1YH9OpYH9YcbloHUsF/gQg=
X-Google-Smtp-Source: AGHT+IE/UTz5fNaLTsQYnxAU24zjHRKEz6dWEitgwhKr6IH5FPDOdIQ5v2Yn/2Hrhm8Qg250XXdSJg==
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:1f2f:fbdb with SMTP id adf61e73a8af0-1d9a83ffa57mr20414711637.25.1730279340928;
        Wed, 30 Oct 2024 02:09:00 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e97bsm8755658b3a.34.2024.10.30.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:09:00 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:38:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, Pierre.Gondois@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: CPPC: Fix possible null-ptr-deref for
 cppc_get_cpu_cost()
Message-ID: <20241030090857.xbnpfnpi4hp4emkk@vireshk-i7>
References: <20241030082449.2629861-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030082449.2629861-1-ruanjinjie@huawei.com>

On 30-10-24, 16:24, Jinjie Ruan wrote:
> cpufreq_cpu_get_raw() may return NULL if the cpu is not in
> policy->cpus cpu mask and it will cause null pointer dereference,
> so check NULL for cppc_get_cpu_cost().
> 
> Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 2b8708475ac7..67fa97bbeae7 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -487,6 +487,9 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>  	int step;
>  
>  	policy = cpufreq_cpu_get_raw(cpu_dev->id);
> +	if (!policy)
> +		return 0;
> +
>  	cpu_data = policy->driver_data;
>  	perf_caps = &cpu_data->perf_caps;
>  	max_cap = arch_scale_cpu_capacity(cpu_dev->id);

Applied. Thanks.

-- 
viresh

