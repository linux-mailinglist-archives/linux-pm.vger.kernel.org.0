Return-Path: <linux-pm+bounces-31572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA67B15905
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB7E18A10D0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 06:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78E61F3BB5;
	Wed, 30 Jul 2025 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwwhYGYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74D1E7C2E
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857576; cv=none; b=tSXjhtvkvJnD4m1usuhovY9ylf5ca6xUdNOLTwfI1EE83MYr93u1dV3r0ROBnZJCK5iDCvipYu5yD3GGxGw+JYuef53mCYJXupMIX3rIWPcDFK8RkhX3eua2MjgPTnqA6qcNCYZpEC24oAj3sLJf7T5xsHmNV7NCfdboYZRxKKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857576; c=relaxed/simple;
	bh=s3oAeiGMCGpEUY4W0CLVktyAxCLyAnDPTL2QrMiUGXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4+D5F7xtPBR3Z/1YAFo/lqlwIlZjWocVd/Ent8+++hxsJ45cxcdyXhxDNfSzNDvdp7N0b1dGaf9jdBTMf+r/rfHmG3CzyH4nnApSH8qu+ia1E0nFVKAE4LAZWiHpSwOAAYyXv0lqjjW0CCgGHQZe0jVYNypQO5EM9rl4Ke98Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwwhYGYT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso6130118b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753857573; x=1754462373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxqq0Cq3rXpDHMk3wnpPiQiHk/GfScecX6DtSmTnXPU=;
        b=iwwhYGYTGq5VvhZtiC+JbMX1lbXf59xzWjh0EoFZk+Tvz2uL1yJbMvOcFdTR7CCUC+
         hr4NMrfkkLDWhUT67Y2NsLOBy5SDzbXKrDpikowQRXK8PqSDMewwh5AFmPS6B2dQKMXJ
         DMoknMHiQrsNEwTVzhTsC4p6J4lKkBVmL6fPiS3Mu7/3guINLCil2JipvX+jwcAVUcJI
         xJ4BhIyINiCcbod86yCDTxS5MnUDghMknOmXgr1dz2LX2fapVIbKIs+FvI8BrASZToNZ
         j9TRpsCfSoLHKFv+IEF876U/QxYpr2b/VMuviNIltHhJAV/dAuiCqvIpl+cFIuRLMAsw
         nm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753857573; x=1754462373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxqq0Cq3rXpDHMk3wnpPiQiHk/GfScecX6DtSmTnXPU=;
        b=rjj4sXwwELkgHiOzgzbgSN1cEmEjR1jZ0FLITBfsGBHkElYIiZbkixkpBxYBnJ12PU
         5oz+kmlEefO8WckpU0T3GA1GxnE2A9URa645f9L0lNA3Wg1zq1huC90Wb2jUW13x8UXM
         2IdTwGU62BpoRdGnJvIB5FW8NOcvJYcKwTDDpJ0U8txA0V/+Y2z0uy9CxKTcVMSrJFAl
         wfL8AOfNKS6BiuB6qLAHu5mVBU++HFOLOh33GbED5zldG492DF8UT7sZq1swDt7f7kgp
         L3+UTbIRCXKr1Ruk4fq1SNC4hd67nrMwacb2yiWsuTvtWkGT8r4yXSGxR5Ap3EJDesD0
         B00Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc740qcBdmuPinUqy6MPpQFgNsgYm7jvBBsv8QBPP6vWHRvR7n8D8XCzhRV+sWCxY2pQCRZs6czw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8lHWv0EbVi/k1vFReb3HJ7xe5NBTRMDRRUDk/Y5TmzsRanzz
	BjNwmX31KZHfUZsmsfFs6Il5bu6az1dBnbwx3h8RmQq6w5qGGz+fod/YK7Ut9RrTVssKTE1bfnx
	4cZwy
X-Gm-Gg: ASbGncsKiJL6rus5rI1HEC18UgCGzURTwD3ShBt1kznOfcsRWEQ/2dtG3U13x16dv8u
	Gt0qzRqqGegD18Xlstkqnz/JmGBn5gTx4x3hXnC8L8yWa0ZdtOSkjXsmWWqXtAvBRuhvmcUGwd0
	o/oLOHxNnxD5mg4akb7AJUsunRrx5L9NXA1iw0hTdUQS+LrKPhYCPTzl/LxchD+b158ovnM6r+8
	6pfEJx/VJ1hMuQovg/aonH+r2MN4ERCVfxdBYzgngvuJuJtF9BA0LJnUezPY0DmCx5dVDtXCpmk
	5hzC9pXB5h9Yf44I+YWl/4JQdy9yib24ZXUdxnHlIZ6zg57ld9OXClfhU8mUJ/O2r23oPQwy11R
	uWCtg0Z8/7OvIe4hq1qpOy0s=
X-Google-Smtp-Source: AGHT+IHxxY7HQAsnbPM3mEwljLdyelb9+TlSrMF7nkdPAIT593PMDdIyHE4C4wABCZ568IM+pGtllg==
X-Received: by 2002:a05:6a00:4b02:b0:748:2d1d:f7b3 with SMTP id d2e1a72fcca58-76ab30d04c2mr2941003b3a.22.1753857573262;
        Tue, 29 Jul 2025 23:39:33 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76a794e7eebsm1921693b3a.123.2025.07.29.23.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:39:32 -0700 (PDT)
Date: Wed, 30 Jul 2025 12:09:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bowen Yu <yubowen8@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, zhenglifeng1@huawei.com,
	Prashant Malani <pmalani@google.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
Message-ID: <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
References: <20250730032312.167062-1-yubowen8@huawei.com>
 <20250730032312.167062-3-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730032312.167062-3-yubowen8@huawei.com>

+ Prashant/Beata/Ionela

On 30-07-25, 11:23, Bowen Yu wrote:
> From: Jie Zhan <zhanjie9@hisilicon.com>
> 
> Perf counters could be 0 if the cpu is in a low-power idle state. Just try
> it again next time and update the frequency scale when the cpu is active
> and perf counters successfully return.
> 
> Also, remove the FIE source on an actual failure.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 904006027df2..e95844d3d366 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -78,12 +78,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>  	struct cppc_cpudata *cpu_data;
>  	unsigned long local_freq_scale;
>  	u64 perf;
> +	int ret;
>  
>  	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
>  	cpu_data = cppc_fi->cpu_data;
>  
> -	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
> +	ret = cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs);
> +	/*
> +	 * Perf counters could be 0 if the cpu is in a low-power idle state.
> +	 * Just try it again next time.
> +	 */
> +	if (ret == -EFAULT)
> +		return;
> +
> +	if (ret) {
>  		pr_warn("%s: failed to read perf counters\n", __func__);
> +		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC,
> +						 cpu_data->shared_cpu_map);
>  		return;
>  	}
>  
> -- 
> 2.33.0

-- 
viresh

