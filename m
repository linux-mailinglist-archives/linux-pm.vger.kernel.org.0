Return-Path: <linux-pm+bounces-17298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063379C3774
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 05:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5FE281744
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 04:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347614A4E0;
	Mon, 11 Nov 2024 04:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LR4h4VKG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB81474B7
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 04:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298565; cv=none; b=IiHtzeVpKlbcCC9wkKE/Z8t5qc5QDsurC/0TYlcTtgXbPWJE782nOlrZ415h7j1DZAEqd2DDz+va5tmeR9zmWBMNxGQVAn4oXQjsKWIK2vQOp5Y1wUIjaL9Z+C8WQ0QWNTl7C/b/GA+57fJmDdwjNsQrd3MOtINytXbnrvGfaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298565; c=relaxed/simple;
	bh=mYBTEuiSJ0jD+VgkqYsfn2c6tAoi5lC1/T+8ZbsPP0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIkazwal1uWIW31mycgJkM4EqB/EyqEZDRHX8QidExjPPVWbi+tN2AHjjw8SATMqolZgSba6n+m20XneiXuwq+qE5VNfjKM6fRafQ4X1805AFmo8beKDuZKmvIJIodag/y7BngTDBbLYZAb1ty/xSwVMNjCbSSKfaCnVYU71RLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LR4h4VKG; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5eb73ec1e1aso1964475eaf.2
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2024 20:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731298563; x=1731903363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jplSrMsOoMOyli3KPjS4DKbZXz0uuOFAXmT0YXTasvo=;
        b=LR4h4VKGrozDqdHWGzX3MsE1EUQ1/8Rdbek/CPaU1CFPwOu2/VkVY+ORQSCwKLlLzV
         isT+m5YTVY+mOq9GgoDKF9Utqgw36bJHZyZ+0C5kwFVwlsxvjwwiTbtnKkxp0AYLvCkc
         XyIqQnvqOsz5vqHvOqLXaEv0NfXLoIzuwufTSwl3Ba/Cv8jDjWMdEoe6PuFh28VgB8M6
         9l3dSKPTqTp8+teskWRXxnlb9vEXPXKTWxZhMR2OXb9dSZOhivNq3hfUz+zUIYl8smZ/
         2VXsyP+6uvR37qYYlc2WKnY1QRV/OoN7kolzUuHQCYopRLDsVtmIVsM8pl9Ny8uIHHBe
         DiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298563; x=1731903363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jplSrMsOoMOyli3KPjS4DKbZXz0uuOFAXmT0YXTasvo=;
        b=lEPQm5tRSU87zLGG4R+qDXSgNnWrNQtXB4/KXgsJimohMSbxtjvg+LJj1T8XyVN+aN
         9Covh/cB3QRRcrSQ2XthX6uJATNEyAHJXGVI7rymOhWtaG+mAfoX5NuDXW4J/Mbu1vK4
         9X8U6jDld2eJ+dnvPw9qNeCBtTbyNuLkSA8uYpFMIgK21nbLGKTe6NaLYU2eQr+vRDDL
         5pmY9lN/S6GT8+TtxinNIJ2bIaKnoTob0zn7SQTivRm8/Xplut0TSnKMZ5jZAHSdu2Mb
         yRMlKmELrrlzXA4THAwuRY7RiL5pmyksDMuPQBuU74PUOY9c3tjIJa1GeLRZL7z3rAjU
         N4jA==
X-Forwarded-Encrypted: i=1; AJvYcCXBp+r6jLjuzq8Uqx8T2mtWcY6n5wgu6s7K7U/XTUdb2jPgB+KlTSlQnE3jPhXhbbPGS5sW5eioyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcTnkK88TreT19fcg1s0XR2YKPbvhKvTM9nFT2T9MpJs5A6HZ
	Y8j5p8qvQi8ombTmnfb3GBMRSllPpm0bkq5Gq/CeT8ISAYufiIcKBmNoHNsz7kM=
X-Google-Smtp-Source: AGHT+IHcqA8D6nO2E7MyRA05VHTtBPZ63FNqPboNko9ET5NxSy8IUL0tKnDGbcDbDKdyRIItXf2XMw==
X-Received: by 2002:a05:6871:5c7:b0:288:9adc:3670 with SMTP id 586e51a60fabf-2956026ec80mr9332958fac.29.1731298563084;
        Sun, 10 Nov 2024 20:16:03 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65a271sm7555411a12.71.2024.11.10.20.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:16:02 -0800 (PST)
Date: Mon, 11 Nov 2024 09:46:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, qperret@google.com
Subject: Re: [PATCH -next] cpufreq: CPPC: Fix wrong return value in
 cppc_get_cpu_cost()
Message-ID: <20241111041600.5ip2lpq4lbsf6oh5@vireshk-i7>
References: <20241106011238.2407104-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106011238.2407104-1-ruanjinjie@huawei.com>

On 06-11-24, 09:12, Jinjie Ruan wrote:
> cppc_get_cpu_cost() return 0 if the policy is NULL. Then in
> em_compute_costs(), the later zero check for cost is not valid
> as cost is uninitialized. As Quentin pointed out, kernel energy model
> core check the return value of get_cost() first, so if the callback
> failed it should tell the core. Return -EINVAL to fix it.
> 
> Fixes: 1a1374bb8c59 ("cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/c4765377-7830-44c2-84fa-706b6e304e10@stanley.mountain/
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Quentin Perret <qperret@google.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index aa5dd194fc5b..cdc569cf7743 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -475,7 +475,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>  
>  	policy = cpufreq_cpu_get_raw(cpu_dev->id);
>  	if (!policy)
> -		return 0;
> +		return -EINVAL;
>  
>  	cpu_data = policy->driver_data;
>  	perf_caps = &cpu_data->perf_caps;

Applied. Thanks.

-- 
viresh

