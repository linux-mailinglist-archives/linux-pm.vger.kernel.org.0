Return-Path: <linux-pm+bounces-9074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE762906924
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7A283F91
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD613F45E;
	Thu, 13 Jun 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1oX6d4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B313F447
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271770; cv=none; b=giisuQGsrKsdu0BacWNswVvekqTCSTRm+VegExgNu29elaGb2M8kw2GgRGTBs4+Km8YeRjaBYSIXnCdMrZAZKjKAQDdj3QbJroAY2UA4nryXi7JmAbfZwHel76LyZ/rmlzrHWobhh3P7g5LfS8WypQAA+4fq6sfHBjA1lU04qSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271770; c=relaxed/simple;
	bh=/csI6K3GGf47jgq9/8chaqlW9Z0I9qjMXHACV/hlBtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4XByuoZcYMmXbIBsAWdexBHboQX6qzInlcx6/Bjsr3IXmmWCQ+doGKMTfodXR7SUgMVKypOq0CUJzkePQu277PPptgETyGzt3vnDO91qIQarNuGFs/LOOIkcL68UtIp8IythUfFwAq8rAP0PZpWuRyiBIeQn77x3fUg1aSbHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G1oX6d4e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-705959a2dfbso584134b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718271768; x=1718876568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cu6cspdF8T8P6HUKOhK2SCIjh0ZPJfUV0xoeJIiJuuI=;
        b=G1oX6d4ezchohFAMWHBC4Cd2sYZFXoMU4b4rIQsub/XCz1UirAAPJkVw5l9wP+7MEb
         f7LA7R7co+sj4KoS52AHm66ZypN0RrJ6p463wqx2957X0uMDIjdrttAH06ZvaculB8zw
         L06haVzgjbb47DGCs394adVGMAKjO0FRm6DGw4vWmhjr3hOibbPHp2KyGYmkQId0/PoA
         Qdz/LFXd6KNBrzFP/RuubV0+tOojinYMYwck9eHjovDjaesnO1Xm4vZ+hYhCryMgHGjM
         tXfmzo5uqgHFw/FcImc9rDErHOmsMrku/l/ah4PC1185v3OA5CslN5ejyKpZaEMnt/+N
         c6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271768; x=1718876568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu6cspdF8T8P6HUKOhK2SCIjh0ZPJfUV0xoeJIiJuuI=;
        b=TUPJNFNK65diRlBXmGjzqQCP9N0uD+NHANdM2rXAefn9Fy0yO/bCnfFy9BgNlSAJYu
         I6NGMNjLqF5J4kxZ4YELg7C54/26e4eQ5hXGIOcKLtYZ+gxFmyPJR1EJNY7/eZ3/ZVzO
         ucqLd96uHMBTe7pkmeDlhCftMF1/9sWSBYiJEXvz/lXBzgay7F9fFxVHkmdRKQZyMXM2
         VEK/y0fS0FX7MFMBJLhJ9Zic1Ie46fRfsZ40NSWm0nBaUo1n7CJLksNLzuA7fEmNzyK/
         jrIJCg3z0u+1RpoQ28+1n+93lEG1tXjd8mvksdkFOzE01ruQ2UHW+IwrnH569noZ3jEx
         nqow==
X-Forwarded-Encrypted: i=1; AJvYcCWv3oQE3HQ6tojQzxml+pdhkNw2PuBpbgSSjUXGXxjQS01QKuPT7jrHKZ4Q7A1ATIXvoAsi01M+NQxQOBItec6FVYf7UamAjQo=
X-Gm-Message-State: AOJu0YyjQJl8m1LOHybD17vOMpSlBheiumDDSoN0ga5wBKEGLl9uL/US
	GcNDz3H56+FPfJ70v+jfQdFcJ/fEztjAsD14n5cuA3nJKblxux/McTQaue5wF+4=
X-Google-Smtp-Source: AGHT+IF5LpX8illGnH4Jh3LBbYZDLJzJWGwRolEuYaWWdqEDgfDtAQKDUpG9IAQVHyZdB2FSGLL+Mw==
X-Received: by 2002:a05:6a00:1913:b0:705:cbcd:ebdc with SMTP id d2e1a72fcca58-705cbcdef6bmr2231556b3a.10.1718271768328;
        Thu, 13 Jun 2024 02:42:48 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96b6f0sm944991b3a.69.2024.06.13.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:42:47 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:12:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>
Cc: ionela.voinescu@arm.com, rafael@kernel.org, pierre.gondois@arm.com,
	beata.michalska@arm.com, hotran@apm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v4] cpufreq/cppc: Remove the desired_perf compare when
 set target
Message-ID: <20240613094245.cidth5miv4zxfg56@vireshk-i7>
References: <OS3P286MB2490EB027398DDB852BE2169B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3P286MB2490EB027398DDB852BE2169B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>

On 12-06-24, 19:46, Riwen Lu wrote:
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
> policy->cur to new_freq.
> 
> Then the governor->limits() calls cppc_cpufreq_set_target() to
> configures the CPU frequency and returns directly because the
> desired_perf converted from target_freq is the same with
> cpu->perf_ctrls.desired_perf and both are the lowest_perf.
> 
> Since target_freq and policy->cur have been compared in
> __cpufreq_driver_target(), there's no need to compare desired_perf and
> cpu->perf_ctrls.desired_perf again in cppc_cpufreq_set_target() to
> ensure that the CPU frequency is properly configured.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

Applied. Thanks.

-- 
viresh

