Return-Path: <linux-pm+bounces-20738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C44A1773B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 07:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F929188B455
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 06:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43584199223;
	Tue, 21 Jan 2025 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnEi2klZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1515098A
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737440063; cv=none; b=iay0plbWaReJ5JRznntbNXs/i3l0TSvWZK4TDvMtOfeenUMYfoKPy6h949Idn6Skek/CWTPB/oa7PoFPI39E//bLfU+P0LjyTwK9aP2Q1NJWodjUjV/6A0y+8CBq9PnZ7IzoieAw8N+fWXYRvMngBUIL8zP/KwlvAAIWHWc4Eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737440063; c=relaxed/simple;
	bh=tOc9754UG3lhAfDQr4uToAV7xU+dQ5L/lITnRsYG5YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpxO6py6axVB9QLJel88R8Wu8iZyDCy9fPTK4xlW67xIdiFBJP2ZJlwTshd+GF3JzEVkO7Odsb8b5vcoLSWgoyepOwYwI6hin6r48k+rSTmTbJ/ysSRXu1UuvAN4rN25AXDHpe+y1qZbTTrj9x63/O8G4gRlZq8cvlOwpNq+evw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TnEi2klZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so91202185ad.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 22:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737440061; x=1738044861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmjPJann1XIEGGFPaNRWl1Y2G15HlhN/j8VhpeEEaIo=;
        b=TnEi2klZFiogQLa/e81yS30aCLyIo6t7mKbSAG0uZ9LefgLdiDssbmOhMU6ICVqMQN
         zYGnYe64O8C0awjwyXCjgbaDGSAZ3MIv0V7sWlEaYqUlizJjG8BoeuY+bwNs1EPXFU/I
         NbQm6aUX8YhgTI8bQ1UzSk4YlXRnE89NwENmd3K+5Pxo8sjTo2x8KqZO6IYc1UFONGlE
         WECB+j9xE9arkBKfoYwK9Xrz0trms/lNAPLbWXSzxY3poWCYGnqpulLNO6kYxjjeQSx0
         6sHQPl6CxqFEa8cb3t7ON3DYu66mHjztcnpu6oMvbe/BUjuErTWVVgbBugZEjqhj62pZ
         BIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737440061; x=1738044861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmjPJann1XIEGGFPaNRWl1Y2G15HlhN/j8VhpeEEaIo=;
        b=JcPvF3DRiLmJvi+B38Pk51x7WUxLsFIpHicxYD4N6PD2FgMK4VrmxWjv8iU9cnclZy
         d/fv6YbOKlaEVHcFLBRC61Ue0w3ur1OkmLoPTURHJrhw+tJkYoKPzGjO78kks3gelcDS
         1D+dt7mgDHSygCxHmaLiZo7WxFxYIdEww5iN86WLXwVYHl5/8XTh8O2OV7WHKTp+kyT2
         ihHSMgL2zVyq8uQ9KJwF6CeMzWBliO4ZTRlMYrdxC4h6iD5mHyYZN4ier2kBDXChQAiT
         amvADLT8BKnKcUuhAh9+z14Dil+7hi3A2jGy1OK/rNX4bZpOH47pvCX9SfeVuKufEuQe
         NvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtXMcLubYeqgEVMGTDaPjk4yhEtnDjYpGVvjqzAOPxhNJvi52BOMql9Kuz0/cevYkPF/oe0sE2cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtnEOKKQQCRTZ0N2nuuOQUQBVgwKjYgVFfhVDvCbK6H1bgQOZ
	bHrqbjAjmyixT2iBdZ8We6c7KcUlLC4dIBCxWJo0te//3zhCaao3my9zjkpP3pM=
X-Gm-Gg: ASbGnctjFBh+nU4rHpz3Klhx09nziABQUJPh9ckeX9rS5eO28WOEVzcXBFEJqzW4pq8
	xSGpQhIR7Ub4E2kR1UucoPBlI8Kcvmd8eM4+MaHuMJGsVY5/JB/KJe1BFijGUHBgPrqe25Oat7a
	PTqZ9bndqkRYtE8MxByUajsOm7tVZ0F9P3TwfJjLFWeKYmdTAZSIJ2anNIvPrkrkZ+g/VAU2mQg
	Qjy9rEZujf7EaP6hrch4iHWkeuHzmwro7E8vlrXoEyO5gsdhVnDmacNnGXR37o6oM5Ku4Q1
X-Google-Smtp-Source: AGHT+IGl0vtdmoDV/jQ++7JwPvJso/R8s9mOeIRwDvBcKmdPI5w4RJDnUhjbQQU53NivklMy3V26gw==
X-Received: by 2002:a05:6a20:258b:b0:1e0:ca1c:8581 with SMTP id adf61e73a8af0-1eb214c7b53mr21546347637.21.1737440060815;
        Mon, 20 Jan 2025 22:14:20 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f09besm8108885b3a.27.2025.01.20.22.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 22:14:20 -0800 (PST)
Date: Tue, 21 Jan 2025 11:44:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 4/4] cpufreq: ACPI: Remove set_boost in
 acpi_cpufreq_cpu_init()
Message-ID: <20250121061418.2eiifftsv6q7jxlm@vireshk-i7>
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

There are more cleanups in drivers that can be done though. I will try
that once this series is merged.

-- 
viresh

