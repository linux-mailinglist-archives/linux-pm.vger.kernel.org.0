Return-Path: <linux-pm+bounces-20683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2AA16990
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 10:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CF81882166
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D21AB6D4;
	Mon, 20 Jan 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVkFZF23"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C7192B9D
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365333; cv=none; b=nnnytEPZo0CxJ173lCCrDo0PDQjT2slpga9CQ9E0x9aX8pwK7XvBymu2O4Uz7nFc1wM7YnkA2siHO/Duo4iauVifH55R4oyufZqf6BUb32Hp4O0XmV0VYH1wHxzZWUQgwu303ImPD63TFiw9WPmZnnwm9asbfPjg9/c9H+LxDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365333; c=relaxed/simple;
	bh=ULqpFTo5G+Y9yHRzfwOwuoDAYRMIuwyayQz3X1Wqdg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOeobx0srVxiOtlKR4HS1o+eCsP++opTTc4bdtHdhXkmvq7dDAn+Yatyh1KbAReaFyvgRGlwibAb3sn2HpTO67zyuutYhc+24u0Lv2H/3P+4xDidxjl6BPgQxW5A6Mna6Ntl8EfgV9UN/sSBrLq+0nDdPPIR88zkHcpQWcNBJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KVkFZF23; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so5534640a91.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737365331; x=1737970131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUjdCS3nXIZ4PUVy4dKxsUED4eoy/O9Us2FZ86S217o=;
        b=KVkFZF237KJSbhx02OBQki/ngIVJpBNLwHiYl8qmhcLfLQgznYpY7KGvFQkyRFrRTp
         H3TxfNcY4bhupRQtSodSigbXEHH/hxhgOshg9JEcFkdELXlHbSco6jjExQ/mP6Qllz6w
         wqpKghdVCo7w53cshfWCqZnSL1oaTJt2N9LjxBtrev6RWf44UFQlfelI5n/+kIuSJCHc
         YEkhIDbf2WcbfENwy146NDPO11YLT1R6ARCWlrAU+JfxBdntxAmEdgG3ZtwepzUIKhbo
         PP6BWqOyAWRAgzqjU1/X7VYOdDXa+llJC6Vn1J3XRruT210V3M6T+Ftinx1AW0fS/8lH
         sbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737365331; x=1737970131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUjdCS3nXIZ4PUVy4dKxsUED4eoy/O9Us2FZ86S217o=;
        b=ucJkWIU/AW/HiUXQWx5Ikl13PSIHW2spfQL/lppK31Fw+6mg6kjhvE/drb4ox4Tt2p
         N/IU9X3whWUWxY9g6mlGC3pXmeQkYxeGRwW1L5U1XyQpjUm29LO5oqWazfw/vTat+eM2
         UKYd45Cdmzy4Fp3TVB0wk7sC7Nn8rs9U7Lv+ktmJIc9agadAADKtJQ4RAj/POvD6Wpmf
         EP3FkTv8I+X5macGY+4eYu267zUvKKMUBjf7B3MfNOZtKP2fGXh90MJOpOXBTno+xeRZ
         Gw2yfpGBjY/3hxWyuEvAm593XeGNWGarkuVJJfesGznG6y3mQGNx1O3S6nEc4OdVq/js
         MYlg==
X-Forwarded-Encrypted: i=1; AJvYcCWYLBDV9WrfgR2rgNXwz7hWL66tGuLcYO65ajKS/jz8GBjTs5R9Xco6OPXEcrcK7fbSlWjw4aIxQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3TYQ2EkI87vi3aeP2uEDYwgW0OttvwFGDZpe8CDBDtzKjXW6
	FYaxxLyjNAwmeSQcPndO+nFzCWWE6LuKeHiSfWdmgYGfo5RZPDtd7oKs0u4RNcc=
X-Gm-Gg: ASbGnctTREWXK8AbsiNZvdpQkYbKDzZVCErkagIGWw88dA6E4GbUdiDvZZublTikVAi
	/TwOnW5MzAIpQxU4HsnavIM98HJH5Kk0n46QsQAHvoQW7wCvxoctGOv8WtUoFwd4WODvbn4Tc3j
	kHBCwc3MqtAnLuYvfd5YyiNgK3KDI6XKRu7U4+5bs17jhByYyV23/gkQaqFZpPxOnFHWUsJ35S/
	LgYiI7RymXjgnZXkOvnrHYxDsgAbq5RUetl3to4Z4NRgEt2XiS6ZChm+PQKDALeTP2nYYJa
X-Google-Smtp-Source: AGHT+IGLaAWB0JbO37vkCCoYLvAUNz8zvcYliLGoJTNIcyiak44Saxq5DrWL+/b5hretSH7ReRMhNA==
X-Received: by 2002:a05:6a00:3493:b0:725:9cc4:2354 with SMTP id d2e1a72fcca58-72daf950b6fmr17143288b3a.10.1737365329755;
        Mon, 20 Jan 2025 01:28:49 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab5e0dd0sm6596275b3a.0.2025.01.20.01.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:28:49 -0800 (PST)
Date: Mon, 20 Jan 2025 14:58:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 3/4] cpufreq: CPPC: Fix wrong max_freq in policy
 initialization
Message-ID: <20250120092847.3qvayop636xceewc@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-4-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117101457.1530653-4-zhenglifeng1@huawei.com>

On 17-01-25, 18:14, Lifeng Zheng wrote:
> In policy initialization, policy->max and policy->cpuinfo.max_freq always
> set to the value calculated from caps->nominal_perf. This will cause the
> frequency stay on base frequency even if the policy is already boosted when
> a CPU is going online. Fix this by using policy->boost_enabled to determine
> which value should be set.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bd8f75accfa0..7fa89b601d2a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -611,7 +611,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>  	 */
>  	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> -	policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
> +	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> +						caps->highest_perf : caps->nominal_perf);
>  
>  	/*
>  	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
> @@ -619,7 +620,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	 * nonlinear perf
>  	 */
>  	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
> -	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
> +	policy->cpuinfo.max_freq = policy->max;
>  
>  	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>  	policy->shared_type = cpu_data->shared_type;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

