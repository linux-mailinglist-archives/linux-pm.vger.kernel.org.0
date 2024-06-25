Return-Path: <linux-pm+bounces-9928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D0F915EEC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 08:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60332833CC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB471CFB6;
	Tue, 25 Jun 2024 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+ja9xb6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD370145FEA
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297009; cv=none; b=bNDL+gOwhWcMLgnhc99YHdCt3KsaldsBy1fAaEkce0hZnD1TpNuMZZTVwsIB65D0HZBGmqyK3JebjKq+un5DGvTsVGRRXWZFl/vLxk2ENIyxM5ie7sN7IHVjW0q2C6MTlyhNdAjdSqxdjChC/4H7FI3QhAnuF3TMEAJXVjvuzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297009; c=relaxed/simple;
	bh=SF5BJKWFWmKExxbuKvOd847HT2mi+5PALLHDQ9FplP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrH49GxWSwnG+ktFl4drO7nSMoQZdHraK+2ehrlT+bOB8Bc7lQ8U4PtIOLw2uA0Ddhm85+LmZ8OE0nW1CfvzzB8i/V5ZAIyBifm0OIyMYhF3+bf2dAogHQ11KFuS4yBhcfSvKF2s0coJP9FVcINRlXYS6VXXMcbZlNxkWwL8G/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+ja9xb6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f65a3abd01so41727615ad.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 23:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719297007; x=1719901807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLin2eJs4fK1IkzV9qGoXjaBN4ecsPke1odNMFmCj5A=;
        b=A+ja9xb6Vqgxbouvx+E/s0s+9YhF/lBCHuQcSDc9tdxzwwoujk4dTbSr8SWJL1R65Z
         7O5ulbpAZu+MFe10ln7IpW/mSUd74Isc9nZut3NhN6q2n/UiJxqGjMCEhuJQfwHLEmVP
         9wbP/2F9paYiKeg/mTy37dAZ0QyNLs5O5f6ZB6L59/YxjhAQ2aj1zuLoLK0QCMMejZn3
         5f32zOPjhaPTfrIFsTOcBr/bQlBpTjLUYgceVq+g7BDB/TQAjovhhaMq7EK8/i4ctIBp
         8zWlirMI1EjpeXPsI1xjKo9xJ589G4PniEABl+n4FWB/XSH3dba2yAqVISItPa/6zA+0
         3sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719297007; x=1719901807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLin2eJs4fK1IkzV9qGoXjaBN4ecsPke1odNMFmCj5A=;
        b=X8IP3QAEmn4PlusfaWJ05SVgyCD9zId29wqI4qtkYWmiWP7i8T72Iw2JJ7drI6ebY0
         jC1v9VHoH9rwpXJ38CSxFmBdYme3vQ8fN2foZY4yUS88nP39A1bLGTLq3iNHVi/ezkJW
         1BQbTjewkcBq3TzHGUcC3FsaSunZtpLtimon8udDqUSY7VfwW3tptXaf2siSlG2oEPJM
         OnoG5192FMFJ53svxg6kEXg5SjFDM0NDkOH3gunFelK4sHI2deZVvuXfYhR4dL6t/9OV
         koJH77RX80/uLLAdm5t30xaSfSJN/iNPBdWctFZq7EET1WNLlU8m4PC3tbtwRV/tTxJ6
         fqxw==
X-Forwarded-Encrypted: i=1; AJvYcCUeHT1wY5dIHmy5MdtnChQj5iW3YhFoLmpYCmgUQnYjd5NQBl6woNDq/yeB+dVd89zQUjfNRMNurYx8OgkP2TPbC1OrBX/yZ7s=
X-Gm-Message-State: AOJu0YyuDnW0GMIG79GC5E6wWhWg1I1wSLke4i16EIulS0xXJLLYgM4q
	d+ZQiqsqdF7sl7eFvYfPxZS12FbNP7nBFes0Adj5qi8C7TtXd4DkknygI0F9YzI=
X-Google-Smtp-Source: AGHT+IFD1DL2jJ714UXhfgjkqXeHVgdsJQOr9iY3AH/d5pK2zsCZXOxdTVMtxl8nbgP08EDslfAtBA==
X-Received: by 2002:a17:902:ea11:b0:1f6:ed74:b4e3 with SMTP id d9443c01a7336-1fa23bd1c18mr92983405ad.3.1719297006803;
        Mon, 24 Jun 2024 23:30:06 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6ba7sm73340125ad.168.2024.06.24.23.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 23:30:06 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:00:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
	Linux PM <linux-pm@vger.kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
Message-ID: <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624213400.67773-6-mario.limonciello@amd.com>

On 24-06-24, 16:34, Mario Limonciello wrote:
> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
> policy incorrectly when boost has been enabled by the platform firmware
> initially even if a driver sets the policy up.
> 
> This is because there are no discrete entries in the frequency table.
> Update that code to only run when a frequency table is present.
> 
> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..32c119614710 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>  		}
>  
>  		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		if (policy->freq_table)
> +			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);

I am not sure if I understand the problem properly here. Can you
please explain a bit in detail ?

-- 
viresh

