Return-Path: <linux-pm+bounces-25998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F95A97D16
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 04:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF6417D22D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 02:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB88264616;
	Wed, 23 Apr 2025 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSmmJD14"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F2264614;
	Wed, 23 Apr 2025 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377045; cv=none; b=NZtw8UeQ1uLT4xSTo/OH1L8UOeONZCdzJiTABft/Jw8Mq4bALXcEVtkjPMe2u/mFRnWy+x8xJJVHc0nFs0F1LtkAik0WhZ3TuiygCRyA2O1l2DSlpgCRqKdgLdi5B3Wfz9PC8d4pRpyFBtCsz7yarTpRyUjmhE7X9WaJB4FAZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377045; c=relaxed/simple;
	bh=g/gbn7A6cZ+FC1ptKgjenHq9YU3nzme2+BFBotu9TaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAT/E5tIdMOWQliPPIBC5hXrlKMO/D9MSjTfU/Rpk2NVQp7LY6i4wrm5+2VxAhXNaExA4LVgohKdkVKuF/26HG00TViKujx+0zq6tDq4ZBBA20hFNLJNua9DTQo4YxbtXW7Asa1EIam1/o6LQQtPkRoKf/FwEK+0y1l+ZG/WJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSmmJD14; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c277331eso510809b3a.1;
        Tue, 22 Apr 2025 19:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745377043; x=1745981843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKWchauYEfB2oukRGA1LcQGAR3/VAz4QEa9G/xeNelk=;
        b=jSmmJD14uk+Exytak/RxfcJpfVhF49Iemf4qR1vD4voCe0Vab9MjIAP7FEF8pAO6aq
         PXFxodJjbxwODucnt+N0X+cXKH0weKCIsUPauZjVacay+Sxkn5fYYjPI9ihk+VqrbZtx
         7hSWxR6SZEBM5jBIrx6Qy3t10ybP+BkzErOCmPI2ghf3iG8SsT0kUNrPEseQOLsgQiAb
         HsxKmVQjrk4EM3r4mQHJwQ9Ev/eu6mfydLzpL6dGVNJ1EqbMWUuRVpmr26pXjE2HbxYC
         MHrqdPl8Cs7I/KLOHyVi60fVVfwTE6FkbP4LUBYRjgFp0vN620OpFoJ5Kmlq9qw0zw7B
         0qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745377043; x=1745981843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKWchauYEfB2oukRGA1LcQGAR3/VAz4QEa9G/xeNelk=;
        b=qBGMQcTVfEozJdSt9YcdAZUbJZSGyINCkRi60HiksBnF39D/iZ54TpUbuMV1e30ca7
         7joosY1p539Dv3dCExdNxTNzTfMBMSlyRm+2CbLmXfUFl3aR9EqXnHjORlxu3KIDUADk
         sgRBOB41FLnbAsgaha7GVAtQp4JubmN6j7t5WkKM3kEzNA7jIs3aCmgKraDW4V3e5lrp
         8UC05vp5ovyiL08Bo/DsCDNw4/EfQZebUGy1I4EGRlLBpq7GjFO3Sk+7W2tTvKpWBeID
         Q5x8S60OEDNrZeD75SQe3vAYZ/G0CjeIY+D2rezUDVPf0UTKhgMgJcGJIhRAc0R28QKs
         BdhA==
X-Forwarded-Encrypted: i=1; AJvYcCX292DpeMQbWvL/uHHZwFI/TTS5zqllouC6WiLA7a8QNs2iOsL4a7xuhUDIl0KZGn9eg6itBzN8LUVEk6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgvQO4Cqkn7PcmCkHPYCc8stEM9RK1A5AK2X0yaR7pIuhLqRk
	b42g8HMelZY6gHqZtYKHiMG+7Wdfn9uCJ7JV6TpKcnSmsMgDvKtUlRUR3UmC
X-Gm-Gg: ASbGncsi8AGBLclXsnwmigR0Og0PCNbbdJI0Q1vH1IkREEr/h4y4Hoo9sDwnQ6t++c5
	PJK5onR05nEn+H2wbwwtgA4qjhvn2tThTOi97IP3/HsHnk4UeALPw+hUCXFVwyi7u5+y6wdHcEB
	GL70zr3QeHmK7Dc1aAFyLtcSsf/8rHOFxWcaUaow8fctOvpKCIBW28qIOTvAeZKt7g+iuw6U+Xe
	lEsGAdyz0FEKw9M9WU8PMmIyWlBEGkcxXnvmtj0fWnWV/UkmpGLt0YJmkmRWFiXPkgi5nNJIoiu
	zg8D+QBHhF3F3G71Zk9y4/OmbVRECfhrCH57vMslrfTSH+sTNNCzAJbzPeSVMb6EI50w+1v18AY
	IgSZKZm7+Oqih
X-Google-Smtp-Source: AGHT+IE33MRUAYYmMd33jJ5efewE5f3KJ0s+kNpk5dooQ3cQarABcgDINtWHATMZoSWtmHFLqMfazw==
X-Received: by 2002:a05:6a21:501a:b0:1f0:e2d0:fb65 with SMTP id adf61e73a8af0-2042e55d3f6mr1235966637.2.1745377043371;
        Tue, 22 Apr 2025 19:57:23 -0700 (PDT)
Received: from ?IPV6:2001:56a:f6b2:4a00:7181:6803:4a12:f331? ([2001:56a:f6b2:4a00:7181:6803:4a12:f331])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8c023esm9436170b3a.34.2025.04.22.19.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 19:57:23 -0700 (PDT)
Message-ID: <1b914523-5b26-4fc0-b5c5-4b2f90ffaa3d@gmail.com>
Date: Tue, 22 Apr 2025 20:57:22 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] cpufreq: acpi: Re-sync CPU boost state on system
 resume
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org
References: <cover.1745315548.git.viresh.kumar@linaro.org>
 <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Nicholas Chin <nic.c3.14@gmail.com>
In-Reply-To: <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-04-22 03:53, Viresh Kumar wrote:
> During suspend/resume cycles, platform firmware may alter the CPU boost
> state.
> 
> If boost is disabled before suspend, it correctly remains off after
> resume. However, if firmware re-enables boost during suspend, the system
> may resume with boost frequencies enabled—even when the boost flag was
> originally disabled. This violates expected behavior.
> 
> Ensure the boost state is re-synchronized with the kernel policy during
> system resume to maintain consistency.
> 
> Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()")
> Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220013
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 7002e8de8098..0ffabf740ff5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -893,8 +893,19 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
>  		pr_warn(FW_WARN "P-state 0 is not max freq\n");
>  
> -	if (acpi_cpufreq_driver.set_boost)
> -		policy->boost_supported = true;
> +	if (acpi_cpufreq_driver.set_boost) {
> +		if (policy->boost_supported) {
> +			/*
> +			 * The firmware may have altered boost state while the
> +			 * CPU was offline (for example during a suspend-resume
> +			 * cycle).
> +			 */
> +			if (policy->boost_enabled != boost_state(cpu))
> +				set_boost(policy, policy->boost_enabled);
> +		} else {
> +			policy->boost_supported = true;
> +		}
> +	}
>  
>  	return result;
>  

The first two patches in this series appear to work as intended. The boost state (both enabled and disabled) persists across a resume from S3 suspend.

Tested-by: Nicholas Chin <nic.c3.14@gmail.com>


