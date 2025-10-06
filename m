Return-Path: <linux-pm+bounces-35718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD09BBD150
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 07:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5AFE4E18C3
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 05:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C321B9D2;
	Mon,  6 Oct 2025 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8b/XHDu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0D1EDA26
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759728198; cv=none; b=JPV1NGEe16bgUbUP+c02B4r2LPdt3wqx+rQrHaLtBarKyTph4xTJRCczm5Xkwpw6SXMq6km3xWKEzhJJpUlybxFDRU6FU0utFvQonBcQSXk+uygXGW6IEOwKUOTY7ao2qouTWqUUDD1K6+xfiCZnFzedrsX6XLs3ppASjZx6ywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759728198; c=relaxed/simple;
	bh=vXfjRNwlloYHBwLxL5XaZXZvf9qH+3ZodwYEGfh0/dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGTcsOC2qjFz1uh6gZ3iG9EZ07YwxKIEWgtgu2VOOyzZfMkmSxY2nTmZRUpP9qxtPUjGsAUjs3tUYKk7yUHmuc+V3bNYMu2AaxNQMK0yTBeR/SfLOcYaCfB2VayPATJ8U333IuUhc8JQBnxrxaelH/ioIXGVFh3aKiozLCbyROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8b/XHDu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-782bfd0a977so3748630b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 05 Oct 2025 22:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759728196; x=1760332996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vF4ZqN0uUxoi1zOwj+7ew8zoI7Xhv+A+IkW+H78bQIw=;
        b=s8b/XHDu5AgDukaSyMWiviYTYTd/Z+M1OiEQfHGJwwIYqd3unL+tfjA3tFQaZkwpoC
         28xwFu5JNuGZZD8cxgmgIY21DBET5wkF/UJxhegWL5DFWUYWjlrHd7l9I8TgN/Odteu5
         l1YCYKcMxB1o8JAJL6/l3LA/x2fDphU7388Jq54+YC8pDI8CmGlErbdQ0fYNcpe1ak5o
         LCrUqAkVZUHmY/xqU2ii0peYfdXAs+r9/M+k+YgT8ELCyl3HnVD3PfCJqTrL3r3UG8AW
         ZiRziEOCuv+MHlRrJU/IMGBIBxwNNPqAJEviNWB7Z+z8LcY2UWdKEq+A0IWuCvCKbBnA
         MQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759728196; x=1760332996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF4ZqN0uUxoi1zOwj+7ew8zoI7Xhv+A+IkW+H78bQIw=;
        b=rG3j+zGNI4JY6TsWIC6jKVZNXDg4idd+PKPmK/pu+99OUFcRtrRIUWuu6H4uc2Lq3B
         P4uuVnXoGpkvbxioKt36n+m/d5VS76lg4/i1CYpBxU7D+GTBGGG6alnml2puucshkKQu
         n5Kl8P3auZv0AAI24xTGIwNa5kGTluEFFmRpwg42wBYUiCybN6+bjnNzjCXVZTygLOSy
         kqWCjtTkNPxCR8GFWXIVNq5iyD/GhPuYWnx+YUikfYYT7HQYYpxb6qFbqaCfshTTv+3h
         3W+ZM6HSL61I1AcZ4LTkOfk1r8n9qJboGlQWyskaNryz75W2IEHshxviXJvl/TDXw9/C
         KxHw==
X-Forwarded-Encrypted: i=1; AJvYcCX7UWpSyPGiPIjmBQvV0qb2UJ5qMjGzl84B/yjH5ZQ4hXIKVQDpGZXCuz5t6wbFvtKVVWaMSic3WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2vuIqliBaBk5vWMWgPHF6RtJehEKhq33rPa2q0ly4k9xxFzJ
	7KF2c5uqvhZvcAPTl2H/HeHDzwEBSlWfBWh8sH3q7PUqfefKJLh42r8Jh3emLOJWdVaeKbvR+Vf
	0S4UW
X-Gm-Gg: ASbGncu52hPdqT5XbJIP2hX1GHBi1zHVAeoMGD1sT6WNG7p/84WD3LZXf340MoskZ2x
	JJwxMfjWgAzSrZjHjln8LG9eh+lKfMv+NIryf2jcpanylNVV7TZtmhs25Tpl3gKBcxdMifxiaWB
	31ERS/zAKvRVCACWduJAeSAXR4CYg2QKITjmGA0cMjpSIIQQf8SPmEPv8Wnd4HE48l+b3cIpaXY
	x1fa7rIZxySCTJTuK8kQJkXQ2hCWA7I+qDgL6ux2QMDOsNrmi5t3I59c0w6UKncgEe9JCVgC+kr
	MA8U+8Z98t3pAzV4aPIZ7xQ6+A6c1omiAWLbWRUVcLR1Af7wUD8Y4iZDDYJn3Kgnp6tj8HrEhrU
	Ka12pJQmuZdMsfz1P3ezWw7N8aWmxGoS30wFYn+ozMrNJZMX6EJCpxwMZCmc8kJc9LVGkEdE3IQ
	==
X-Google-Smtp-Source: AGHT+IF7w0i+mM+5avfxifuQAzg2P049t/VvsKbSJ0XUnaKBCH9mzCmPYcf4bvDqBXmOibDSoby+UQ==
X-Received: by 2002:a05:6a21:32a1:b0:262:d303:38ab with SMTP id adf61e73a8af0-32b620b189fmr15940805637.33.1759728195718;
        Sun, 05 Oct 2025 22:23:15 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b609f05662bsm10411938a12.39.2025.10.05.22.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 22:23:15 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:53:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s5pv210: fix refcount leak
Message-ID: <20251006052312.hbdcwivheliiigl4@vireshk-i7>
References: <aOLHhZNWnPY03Jqe@homelab>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOLHhZNWnPY03Jqe@homelab>

On 06-10-25, 03:31, Shuhao Fu wrote:
> In function `s5pv210_cpu_init`, a possible refcount inconsistency has
> been identified, causing a resource leak.
> 
> Why it is a bug:
> 1. For every clk_get, there should be a matching clk_put on every
> successive error handling path.
> 2. After calling `clk_get(dmc1_clk)`, variable `dmc1_clk` will not be
> freed even if any error happens.
> 
> How it is fixed: For every failed path, an extra goto label is added to
> ensure `dmc1_clk` will be freed regardlessly.
> 
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 4215621de..ba8a1c964 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -518,7 +518,7 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
>  
>  	if (policy->cpu != 0) {
>  		ret = -EINVAL;
> -		goto out_dmc1;
> +		goto out;
>  	}
>  
>  	/*
> @@ -530,7 +530,7 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
>  	if ((mem_type != LPDDR) && (mem_type != LPDDR2)) {
>  		pr_err("CPUFreq doesn't support this memory type\n");
>  		ret = -EINVAL;
> -		goto out_dmc1;
> +		goto out;
>  	}
>  
>  	/* Find current refresh counter and frequency each DMC */
> @@ -544,6 +544,8 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
>  	cpufreq_generic_init(policy, s5pv210_freq_table, 40000);
>  	return 0;
>  
> +out:
> +	clk_put(dmc1_clk);
>  out_dmc1:
>  	clk_put(dmc0_clk);
>  out_dmc0:

Applied. Thanks.

-- 
viresh

