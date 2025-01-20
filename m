Return-Path: <linux-pm+bounces-20682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7942A1692F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 10:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3651884CB7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDAF1A0714;
	Mon, 20 Jan 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6y/c0Ek"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DF194C67
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737364904; cv=none; b=HGeBykvSuxPP0nMatNL4/Dl84yA8Le1fHGhhDq+O+AR1qXmz34YruAaHuadzHgO3nf2fm3/NqMesOG7fES7IxRrGiM6rOIWnZl9oi8Hg16NMfyrHXON7fUuhBJg1qu7zmkCOG8cU6uva2hQdo6RieOQLwBXYtDiJeBVS3LEzDP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737364904; c=relaxed/simple;
	bh=lMmOchg41CP7NaIBnPQrdW4OS3iZW3ha3mCt8JKYJb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho7WyTPCeWh1aAIG1ePktk0XmCmHkgw8j9NTAwugPPGIEo3S6ZSpVTnR0nepobuVWCfCx4W7fw2jrq7QAnrSix1ITTJ1USKcdJjWm0H58bW5/rZWh+pe/F2oP3ccZmYnouEeNQOt3tPZC46H1l//iBuM4hJuPoJIRXON1Aiqvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I6y/c0Ek; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21628b3fe7dso74273675ad.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 01:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737364902; x=1737969702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai6PVupUMQvAJ1W+oSVRJBiVIXg6Q5nYKxZ5MC5wcFs=;
        b=I6y/c0Ekoj0yqSsM5R1zV5k1JCtSmwn50k+cz3JEktUyHlPWAqkRw76yXyLM1TyGuc
         W+Y1GDvfO+WGhv25jsYjQ4ZjaNGOXXAFQMvH4nz/GMXD6Sb2r6E56b5ekLrcrQs9r8NC
         Igms6RqAnwuRUbBGJI19lk26Ye91m+RHzR7hAjZ3616+scjCGe55Jh6xzW1eQ0WHiQZB
         pUrjvaco37TBKS2o7jQfoZlhyQY8qLt3kXhPCKES02Ko0AmSseyLde59zoAYN5kwBvbs
         Z4UOjgQUBbmRwoWQ0m4FBp7uRk0+8yvlT3iMDVQIidtYUindtT0BcZv6AGVEwZt5fNWA
         shmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737364902; x=1737969702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai6PVupUMQvAJ1W+oSVRJBiVIXg6Q5nYKxZ5MC5wcFs=;
        b=o1b4Lr6EnPF0Vt/g2/Eg1T+FrSgS5FGz5lSVPcu6tmhHAylXhle5mh7U8//0UlfeZ6
         cBbZoMRbOgi9/7I8G/nMdynkPd2oQSKeqSxLf4wHalkk019h1NGT/tdu/kzqzvOV0zY1
         groFuqQYYuKuGvBDQNctU7H4CLgtmOjpqVrO5SjPSSjZ04bi3nzDC0HHf8RB3SH8OGv8
         54nngVwCeH9dzbWTFebaY00bhYSFOqEcBP8L5IGCDFmLPK6+05CHTb5JHJQnB3rOct24
         tB9oqc6Fx1ylom0UwYFP6ZlX4VV1R+mt3BgaUOnsquOb8kdVHvlhoWGZTTYL1F0L0sPs
         IGlw==
X-Forwarded-Encrypted: i=1; AJvYcCUGxiLtnbjkZCR3BiWlduWc4LN30T2ZSKHZtysy3dSGWNFc1ZeWLDn6BBZOidK9WsxjM5qYQZ2Kxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CVFysG828+hQg2DagDNb1UwxJyDbRRQ+21aIBku/TnrA9D0+
	UyqfIK8th3G7YKvt8GsVIT/oPsmQh7TMNDeHSb3A5SUsv6bk4tCfs6kMDqdT0sU=
X-Gm-Gg: ASbGncs+FzXQ7G/DnoKxrQxGrL6Q2D2ySTXMzpodAQlTt6IUpgo+ppzrGODpFNbv3jt
	f5IxF5CSVqNJos+jsO5F+hvnMRsJHApsOJMoDgyavY+JwADHHFaiOFxZAy3qI4AwWIFeoEnkqso
	3UfM0lQaAIaWkC0/b2oVnv+iZu12jXEt8mQLsq5/weYL1ustcA1hGkgAjijwgmQvd0k3+PUZxIz
	yhjYZTmw37lO+Tno2N+e0kKmQgczPuVDSEN3zCrKmPKeZtMSxK0AO9nR6EcEXObVjYQ2VaT
X-Google-Smtp-Source: AGHT+IHb8d+5l4SkIrGb6fy3h/JHnpOEpVC4l/HqIGeNQ78GXLAukucx+vYsPZIiJdZB+o7yM4PFnQ==
X-Received: by 2002:a05:6a00:ad8a:b0:724:bf30:3030 with SMTP id d2e1a72fcca58-72daf7a1f94mr18817619b3a.0.1737364901908;
        Mon, 20 Jan 2025 01:21:41 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f09besm6546813b3a.27.2025.01.20.01.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:21:41 -0800 (PST)
Date: Mon, 20 Jan 2025 14:51:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 1/4] cpufreq: Fix re-boost issue after hotplugging a
 cpu
Message-ID: <20250120092139.p4fsitlwf5ki6td4@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-2-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117101457.1530653-2-zhenglifeng1@huawei.com>

On 17-01-25, 18:14, Lifeng Zheng wrote:
> It turns out that cpuX will stay on the base frequency after performing
> these operations:
> 
> 1. boost all cpus: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> 2. offline the cpu: echo 0 > /sys/devices/system/cpu/cpuX/online
> 
> 3. deboost all cpus: echo 0 > /sys/devices/system/cpu/cpufreq/boost
> 
> 4. online the cpu: echo 1 > /sys/devices/system/cpu/cpuX/online
> 
> 5. boost all cpus again: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> This is because max_freq_req of the policy is not updated during the online
> process, and the value of max_freq_req before the last offline is retained.
> When the CPU is boosted again, freq_qos_update_request() will do nothing
> because the old value is the same as the new one. This causes the CPU stay
> on the base frequency. Update max_freq_req  in cpufreq_online() will solve
> this problem.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1a4cae54a01b..5882d7f5e3c1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1475,6 +1475,10 @@ static int cpufreq_online(unsigned int cpu)
>  
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
> +	} else {
> +		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> +		if (ret < 0)
> +			goto out_destroy_policy;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

