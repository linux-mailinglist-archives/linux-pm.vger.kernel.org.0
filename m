Return-Path: <linux-pm+bounces-15730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F79A0100
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 07:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E341F247F8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0765818C33C;
	Wed, 16 Oct 2024 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9Pub590"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43B18C331
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058375; cv=none; b=E+ADGCqPNcqCjAk2nEkbUTWK1MhTYgVNPvp+fcAHV/rcmCyaLWk+9PbVN/8lxXg/cxLXwfdZc6TPDCHyAqW0qWNQoERPOt7CUf19N459ICu6VLoMuoK3jQfatM7g0w7VAIWt81hdV2d82GriDPBiO+ZqWZmltTcfbQ4P8SstLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058375; c=relaxed/simple;
	bh=VWK4U/i8gUcds76RyMyEeEuiDy0+2wEwZXNMbfzpgPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQBLPl+axOi9FUC7AcyvMe3JPompbLdd7+suhhyZS5k1nPJO4blfwB2dD1QSYeHxB/aqw0EvW1/5I8IC5qw3A0oZ1T+Bb2f3s5DEBG3qmOcK61HaWufaUKRahAxTKlr81VGZE/+PR5ip2Mbghn+nQOg34LppSNxyo3FQkNKuTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n9Pub590; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e625b00bcso2317863b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 22:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729058373; x=1729663173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rXbSaoRM3I91C8i3phm7sHDz+HHlGYglaP+SNKnxuk=;
        b=n9Pub590uhX2mVwl3DdLG73eCptt9DQalEIef5/Fi857u55pbxxSho2mNPs+3Zxtw1
         HGJCsogmON89Mb/iBIwn6NZalXR108q0Oj3GvNAx4eYpuzA1As+JasshPMl8+LaXA8GM
         7ttzA/4lwE2d0ul3c1LrX6DIMYLRoa4TshIT+AHW1SYXNnnNlCyrof0hN26XO8BtvnWM
         1prxz+tuz6xH3YIN5EBbswiFz6F4P0a/+pjxFniuXjkJA9N7azG56lopVV5EffJjovog
         qsQAmm8l3JA1b9l+XIbEF4Bh9xwUdDibWEQuMt8ktEeL4m4A06eWkUe7PHJAwklrAU7O
         cmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729058373; x=1729663173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rXbSaoRM3I91C8i3phm7sHDz+HHlGYglaP+SNKnxuk=;
        b=ZNAxsUVXenSeEAXPPtOymtDajGOQZPUxQR5196ZlCFBJpmlcGL3ddxGJfdXPHOfJeh
         L4/t7p+GgQyvgdFcPfcJ5fdLvFv8tuCNjhbdReVi6oKkIDQ0i/OZFbm9+Y8ui9VM5E+d
         Yow72bHFq9knygww0zQm5ihrE0m6A61APgHslKgrbpF7G0FnIV1uNW7FjeZvF2eEkkbf
         omXkcB+OddsYcQV6+ZfBRH2nu1icOiQLPhh6SS/Z3f3l8uCzAVNtNAF+eRqnccN9Cf0+
         T+ihnxsvMO23+iBZ+3e1ISKKRGT4Y6MAgZLPNp/MBZAgg8Wn6aA4EwC1gbYtIprIh+SE
         kJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVZDbg2htJZIJIvfW+Cf7MJ42yUDLUh2jMIf2wBCEzRm6dU+4NYD9g6Jos8IzyXLAd/MP+USNpAdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5JyOaGSM6GGseu55sE18TMHnkIwKvF8bjMgj+Ut8ct6EfeBnZ
	274b0f4BD+NlD+/mv8LeQbdHg4bEJ3Jh2+8xvW54y3KPAmdu1oKv04TggLgHPKo=
X-Google-Smtp-Source: AGHT+IHxy9OWThf9MgRvmZDpDpf2hJTqNvgcWsu7qq0YeFBzyE3RSWwmvlEXJG8I0L8nUOp3N1UmOA==
X-Received: by 2002:a05:6a00:1797:b0:71e:7c25:8217 with SMTP id d2e1a72fcca58-71e7c2591demr4729926b3a.25.1729058373527;
        Tue, 15 Oct 2024 22:59:33 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508b1asm2316879b3a.192.2024.10.15.22.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 22:59:32 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:29:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuan Can <yuancan@huawei.com>
Cc: jiaxun.yang@flygoat.com, rafael@kernel.org, ralf@linux-mips.org,
	wuzhangjin@gmail.com, linux-mips@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: loongson2: Unregister platform_driver on failure
Message-ID: <20241016055930.zhup3ecjrm4k24cn@vireshk-i7>
References: <20241015131337.20159-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131337.20159-1-yuancan@huawei.com>

On 15-10-24, 21:13, Yuan Can wrote:
> When cpufreq_register_driver() returns error, the cpufreq_init() returns
> without unregister platform_driver, fix by add missing
> platform_driver_unregister() when cpufreq_register_driver() failed.
> 
> Fixes: f8ede0f700f5 ("MIPS: Loongson 2F: Add CPU frequency scaling support")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index 6a8e97896d38..1291db067559 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -153,6 +153,9 @@ static int __init cpufreq_init(void)
>  		cpu_wait = loongson2_cpu_wait;
>  	}
>  
> +	if (ret)
> +		platform_driver_unregister(&platform_driver);
> +
>  	return ret;

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 6a8e97896d38..6f8f647efded 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -147,8 +147,9 @@ static int __init cpufreq_init(void)
                                  CPUFREQ_TRANSITION_NOTIFIER);
 
        ret = cpufreq_register_driver(&loongson2_cpufreq_driver);
-
-       if (!ret && !nowait) {
+       if (ret) {
+               platform_driver_unregister(&platform_driver);
+       } else if (!nowait) {
                saved_cpu_wait = cpu_wait;
                cpu_wait = loongson2_cpu_wait;
        }

Maybe a bit like this instead ?

-- 
viresh

