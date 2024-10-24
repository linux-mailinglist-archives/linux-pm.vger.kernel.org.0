Return-Path: <linux-pm+bounces-16377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C39AE49E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23431283410
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D41D2B21;
	Thu, 24 Oct 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnOlVSIj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF2176AAD
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772236; cv=none; b=PFOueZaIyF1RHxQSK4Qh5yHMmhUz9W1L7vb2ygMJ5khxA5P56lhFvGhmHY2M4A1NGNM6u7NwZ6fX19dbNd2T3KVQ1SaDMHmtcU5SZ6Z3ns8j2/Ubrd4vNG/U8/qWp5LT5k1qHM96PjcGI7JqOZF2wuBYjnO59H/4BSfX+0vspx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772236; c=relaxed/simple;
	bh=yN1CumGrlEoOGTx3OsHnc6OzwiPE2MWwwTJ05SNcsIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6GRabQk4pHeB6CssOjVd9Nj4iSEB7xp9cov9CebEuHSJvenO5koCTY4IBTsCn3EvPuXxHTfkbwgGJ4sCTrxywgjHrjO+0F2P26/xQRQ9QggID4t4d2uTq3lWu92zoa8nhEQQuIaIrmMYKIEDn3wJ9xb1GvcXwdMRBDVcLINgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnOlVSIj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so8347365e9.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729772232; x=1730377032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WqnWzHmMKjcYaGejE3CaceAxDaXho2Bn8Ce4G3bwEI=;
        b=pnOlVSIj5DSw0f0O8JlP3MbZxsmLEBWezCItsIgDWTw4me9fD1jAIvXtoyIoAPPPGd
         p9peB5JfXoZqXr1xM0y82K0ZZOrPObrd3I/5ne/MkgBkM8VKNPkMHC6o+tc11G3QMz+M
         BTdOOnCKDSea0dNVgTeOkhPpGvX0ykFy+4DV9QLRDCc+HCdqNOMJ5YdH1yA1w0JQthoL
         /BHFWaxNjYTkxmRwdVVZGkeF4QAjOYd5azrDXgRpzLkTmCLcPo9VT2zLpIpWWSJBHiCg
         54P8XbRzQ8O+MZvYPonSLQPV+m+bkKdv4/HYqJB5hHsO1Y/C1mY28u+Ntl/bQu1aWeLE
         fObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729772232; x=1730377032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WqnWzHmMKjcYaGejE3CaceAxDaXho2Bn8Ce4G3bwEI=;
        b=OK1J3hJjJrFqfSSi0nwPQfPtTW+xM9VNK1W/khpJv7wsNcNFLR3FDQzyyGLBP+Bnf6
         L4hCcwAIWej+r9McSB9Q1nOYZAb6cGbpV4xjDSO1L+N76DfVLp2A2FYx6EhxyqFm30UZ
         F0YodhDtf87XSZh1MN9V7LAYsCIosvKyIpxJf2PwyVZQboOF8QwXmfRLkxu9AKeunMZD
         viftME3hoODED45PR2kx5nnddyRS1lNomGZdIxKiJWTiteTLaPWSu5WCML9+xKRBYODC
         oPwRhGj3u1Yatezu5hhBsJG2qfZQBP9YsXjKVY/vGwfNDvPH1OtBVgIrpiwhkTaL4Ndr
         JZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWqxbj0JqS10nZUz7l80ObtGSuGj0/JwI0++LQR3iWEn+ofm5o7m73P3EiOvJGgVEEZkWFQK3qmzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVjFUS8VOqbpGNUVCP35sf7rDk2ztTw23/0RylEf1zpgqdjdvK
	RFC5BMqHf/gfwJPzgunbHExLIxnoO7eVew6pM1QcItS36qlR2N04HTYNr/Uq3v0=
X-Google-Smtp-Source: AGHT+IEUyrRxF3GxRrRtZfQCmqiZGXb/j5rR8aZTQFnJSE9gJyplmluufyYqxPIijRPFs/6nHaortw==
X-Received: by 2002:a05:6000:1887:b0:37c:f933:48a9 with SMTP id ffacd0b85a97d-37efcef117cmr4250934f8f.1.1729772232236;
        Thu, 24 Oct 2024 05:17:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b93ea6sm11229217f8f.84.2024.10.24.05.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 05:17:11 -0700 (PDT)
Message-ID: <ed55e542-6f30-4165-afdc-40b31b98d119@linaro.org>
Date: Thu, 24 Oct 2024 14:17:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] thermal/drivers/qcom/lmh: remove false lockdep
 backtrace
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241011-lmh-lockdep-v1-1-495cbbe6fef1@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241011-lmh-lockdep-v1-1-495cbbe6fef1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/2024 07:48, Dmitry Baryshkov wrote:
> Annotate LMH IRQs with lockdep classes so that the lockdep doesn't
> report possible recursive locking issue between LMH and GIC interrupts.
> 
> For the reference:
> 
>         CPU0
>         ----
>    lock(&irq_desc_lock_class);
>    lock(&irq_desc_lock_class);
> 
>   *** DEADLOCK ***
> 
> Call trace:
>   dump_backtrace+0x98/0xf0
>   show_stack+0x18/0x24
>   dump_stack_lvl+0x90/0xd0
>   dump_stack+0x18/0x24
>   print_deadlock_bug+0x258/0x348
>   __lock_acquire+0x1078/0x1f44
>   lock_acquire+0x1fc/0x32c
>   _raw_spin_lock_irqsave+0x60/0x88
>   __irq_get_desc_lock+0x58/0x98
>   enable_irq+0x38/0xa0
>   lmh_enable_interrupt+0x2c/0x38
>   irq_enable+0x40/0x8c
>   __irq_startup+0x78/0xa4
>   irq_startup+0x78/0x168
>   __enable_irq+0x70/0x7c
>   enable_irq+0x4c/0xa0
>   qcom_cpufreq_ready+0x20/0x2c
>   cpufreq_online+0x2a8/0x988
>   cpufreq_add_dev+0x80/0x98
>   subsys_interface_register+0x104/0x134
>   cpufreq_register_driver+0x150/0x234
>   qcom_cpufreq_hw_driver_probe+0x2a8/0x388
>   platform_probe+0x68/0xc0
>   really_probe+0xbc/0x298
>   __driver_probe_device+0x78/0x12c
>   driver_probe_device+0x3c/0x160
>   __device_attach_driver+0xb8/0x138
>   bus_for_each_drv+0x84/0xe0
>   __device_attach+0x9c/0x188
>   device_initial_probe+0x14/0x20
>   bus_probe_device+0xac/0xb0
>   deferred_probe_work_func+0x8c/0xc8
>   process_one_work+0x20c/0x62c
>   worker_thread+0x1bc/0x36c
>   kthread+0x120/0x124
>   ret_from_fork+0x10/0x20
> 
> Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---


Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

