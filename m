Return-Path: <linux-pm+bounces-16691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B0A9B5A42
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 04:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40E1B218A5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 03:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35D198837;
	Wed, 30 Oct 2024 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SouUv5tS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3068218B09
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 03:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258377; cv=none; b=AmNCKdZ6mMbrt0x72O6MBEIxT5f68S4QHYwzfsFixfle3l64g9jpnQMsONMuHzC6Oi1UtJNKWYbEw+X+dNfqpcPyclXG8Q+da2lihpHAHPKAm83CeT1kVRnPGmp+j6Ya//RpSb9KRYVKv7/zaz9bzl174Li9QyKqs/T4jVAF1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258377; c=relaxed/simple;
	bh=0TirbDMcHYPL5m6+j/2iCqfqiLEHJ+yA6VrynrkufZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQoosf1xE1SeFFNOrcGjTWq01CcUO+aP0eOKGzdAQOhHWJQQqUgEbLqPp/C2htAor2O5JgYKSRQFuKY8jzq2HEN+0QXakTF2mrOXx6uuGYz8ugR137/YvzzUQFdcOCmZdfzbJpAbIKGxsnrXvz+8rC71BIuCpZFN8NjF1mVsCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SouUv5tS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ed67cfc1fcso3875345a12.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730258374; x=1730863174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/m/pMKA42hUrPTBvxDfREd2O6bHEOtjTTtMPu4AReeE=;
        b=SouUv5tSLuYLSLMl9kIlJWVsoQ4PEW49hBEWBn5mKMc3WpYUVJtOCkm0YnyF8E1aSA
         09Crh5kMd/clEUQt2pAn4kKQsSkqMbcmol7UiCkhGJU0SbSPSCD9yRicrR1OjMlIFVcA
         5BOJf8pMrNU0LJx3Obu4O5fHbE0gtY27yuOjU6Z6GKg9vQ85I5RLE4VU0TH8Kh1kwdRH
         cT4RSYXBuItjjsGSx6AGD2VAlZtt/UfErFvRMNzHXQ5D+HkLMChax6ECx5x5c7acYsUH
         Oo1h97hVyeKiuV2A+FPIZ3HeKMlF7D+eoLH1I8Rhb2glwjzxTpKT6hHBddMyv4j/zjHh
         FkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730258374; x=1730863174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m/pMKA42hUrPTBvxDfREd2O6bHEOtjTTtMPu4AReeE=;
        b=BpRrSx2nBeCEiyDVABFGEAm/IqtUm4ZD9s72gdj9l2hKn83erUpcF3jFkMvkzqIefF
         VD2YStr4ned0oiEsal577uKMx+acWVGuLKT+diXb3XgTpuk9EfxQvyiB+sXvD1J92HlR
         FIuNzXqdTkiD43OHcECXLCoP8t0J+vJTTmiYT340nSt+1S0oBMGCPZnNUTSG5aCjXCOB
         1AaDYQacdCOAHfPlHx/5DzsEfV2N2eSaWLH+vRVUTzOBwY1M/BknxaJaVwNRquhN6hgM
         +5ey1dGw+qnVNm4s9hs3FjbW3udgU5O6ra3EBDokQtNzv5oSDEkFEDJDCOGGBfYQ7yTC
         +z7g==
X-Forwarded-Encrypted: i=1; AJvYcCXg6MPzZObiwloKYj+4395btNE4dk2w9NDqjgGRqKaaYgMZ6KfKKqni7urUegzMS7EMzB70WLTr3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpuyjZC6lsDVftdtmT32Tk+Esz2BV4Z3cTYXxWbwxJ94ZrE8r
	qKogy1gRDCXMKPIIAUe8HBfVmnK0wmqdokmo7flrb2F9ZOYonp5V3WR1QgO3IBs=
X-Google-Smtp-Source: AGHT+IGx2HRuW/n17CdE1e0r2AJfer/8GdFjj5WJLHmVY6odjrUOSRhJHSNs1GfiMM45GLtews0p7w==
X-Received: by 2002:a05:6a20:9f04:b0:1d9:911:af03 with SMTP id adf61e73a8af0-1d9eeeab5camr3116677637.49.1730258374587;
        Tue, 29 Oct 2024 20:19:34 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0bc94sm8319431b3a.119.2024.10.29.20.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 20:19:33 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:49:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, Pierre.Gondois@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: CPPC: Fix possible null-ptr-deref for
 cpufreq_cpu_get_raw()
Message-ID: <20241030031932.ymb46qimoaymiibm@vireshk-i7>
References: <20241030012019.357039-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030012019.357039-1-ruanjinjie@huawei.com>

On 30-10-24, 09:20, Jinjie Ruan wrote:
> cpufreq_cpu_get_raw() may return NULL if the cpu is not in
> policy->cpus cpu mask and it will cause null pointer dereference.
> 
> Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 2b8708475ac7..01c24c0ee9b3 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -420,6 +420,9 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>  	struct cppc_cpudata *cpu_data;
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

