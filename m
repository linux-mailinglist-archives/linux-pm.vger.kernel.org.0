Return-Path: <linux-pm+bounces-5961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63206899B14
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 12:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B661C210FA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E33E16087B;
	Fri,  5 Apr 2024 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4kZtx7H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D518E02
	for <linux-pm@vger.kernel.org>; Fri,  5 Apr 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313830; cv=none; b=O00WvZZFPvutZo5aBcAK0dc8Tkj+ECZ+4xo/Z/8tUpducePj4OBsy0Zw1q6T18XvEUtHPdC8sNDCLtkBBzzonYZJIOa87StLYrwVV4zaj8unM+A/HELXAt6ZSpF/dOWCnqYvPMBbU961Xa+P8z7S9rdwovYfx8Hd4+4bQogHzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313830; c=relaxed/simple;
	bh=7C/5UZ82qZYHIwBYCH/b91zTPm2w3L2sycm6zi6fjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPW6Qe7g9U09QDOVo9cC3UbEQloEOTZvOqV9/fvEi6l+Yr4H01OmDExzfUQud1S+qY+9vIwq9bFIXgSvJupuQV/zGrMptvhw9B2KI28OzQN2HCkwhSgDWmy7lxVs6ohFleJYvPPd5qRfWMVkH+B+q9hyfWhd9HdZ6mTPvBjtGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4kZtx7H; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1118457b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Apr 2024 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712313828; x=1712918628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OV4Gr8neyIZMoii5TkHku5I1pPAWBRVzVd5KTEEicxc=;
        b=Y4kZtx7HEkC1ueRNR9dNRWDHltJCvdIRKr6QtvINdDOW9LJU+bZ6N8Cp/okIPxnME0
         Vm1U2YbPlIXGS6AFqcrgyfYcXQoCSE3Krnj9FEtfngqwB9+Hm8BBd8Y6S8r2ZLypFMB/
         Pm9ENrU+1PlliCJ3h/KUFLYJ/2rk0tiNBEiFOHi4j031EZ2C3riOXS7Fbdta1yggIAr1
         WC4RshRgcDSh4NyICI0Cw+czw9xMMujTbyUSdc5rRtToyZRx7ffFI5CnGSfk9cYKzj1u
         lk4qRKdlqfrlz0wc4r/Ck/uvwHM5nM1jN/urmX0hrNzQPrYzj7aEIMZAYRtlhYCEs2JC
         gGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313828; x=1712918628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV4Gr8neyIZMoii5TkHku5I1pPAWBRVzVd5KTEEicxc=;
        b=O5GQteIyDhAT9FpbWfayO9jVcVOJqA3TCbKGh52ijrTC8vKJYUrKQyKALVhdvihPCl
         taGGp1/0g5DYq708XENB5BFHvms+gc3HsHUX4E1A16s306vsuj9zs3XqdNKhY5xcZSM7
         MMSM2/zvmzN4HZpJaC4AZi0oKA9fGkVsGKU2SXzOBx0jwEctf/mLgIFqQaokGIbx2ksQ
         jVeo2BjFFtOStkvfQZJ73FZLKS4FTxmApgMFAyB5KssRJPscEbKrLtQxPGSF595ENP8N
         +fJHS+81LRuJ0ALRb9w2Fyv01q8w7Ade7rrW9ewT8qeR+TJrkeY0qcVEfelHMY1nqamJ
         takA==
X-Forwarded-Encrypted: i=1; AJvYcCWJx2gISbouc2AKijovdhrEFKx3XOCWDKyrt50lGjFVplF4PmaIfHQZ/n5WAa/D2PfvVa/AsLZkal4VD6qEkBx4thnKGfjziAc=
X-Gm-Message-State: AOJu0YzBWSXU2EKQe9sEtKRfoMH/wppPJ/0obORLLNG+mTik8K8VZ4WO
	+2g1c0FJCuVKWBCEutGVY2qClX5FZ2BBhZpf0x2FKx+QZ6QOt47ydrzRlwIpmQy9e03p6I/7iMj
	G
X-Google-Smtp-Source: AGHT+IEHh74q9CMsOrU6OsYsQfAok8LvDJdvMvAqww4JBXgggCs2EKE/0m+u/9H3FLEhSawgz43Opw==
X-Received: by 2002:a05:6a20:5509:b0:1a3:d618:cfdf with SMTP id ko9-20020a056a20550900b001a3d618cfdfmr937992pzb.26.1712313828015;
        Fri, 05 Apr 2024 03:43:48 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903245200b001e293a6ec19sm1239761pls.230.2024.04.05.03.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:43:47 -0700 (PDT)
Date: Fri, 5 Apr 2024 16:13:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] cppc_cpufreq: Fix possible null pointer dereference
Message-ID: <20240405104345.kcb55mwhdcpdv53x@vireshk-i7>
References: <20240405094005.18545-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405094005.18545-1-amishin@t-argos.ru>

On 05-04-24, 12:40, Aleksandr Mishin wrote:
> cppc_cpufreq_get_rate() and hisi_cppc_cpufreq_get_rate() can be called from
> different places with various parameters. So cpufreq_cpu_get() can return
> null as 'policy' in some circumstances.
> Fix this bug by adding null return check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 64420d9cfd1e..5f7e04e8497b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -741,6 +741,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  {
>  	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -ENODEV;
> +
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	u64 delivered_perf;
>  	int ret;
> @@ -822,6 +825,9 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -ENODEV;
> +
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	u64 desired_perf;
>  	int ret;

Does this compile fine ?

-- 
viresh

