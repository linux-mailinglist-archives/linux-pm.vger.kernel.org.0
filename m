Return-Path: <linux-pm+bounces-31669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24869B16D66
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29015A46B2
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808E21B18B;
	Thu, 31 Jul 2025 08:19:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78E2BD58C;
	Thu, 31 Jul 2025 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949984; cv=none; b=Wu2Xs7r0PfJSJn+/DfqoZ8paP3WEFAKE7FyLqVjyMQnK0n4JDB4ocNv9v5F8StQZe8d1H3DR/1iw+YYY3G2vIBLpo+O5y7HuS0B9sGkFt6qzsxAXSiTFUJTQNMAHVCQ6St9VmwsR5fVzphFVrwDve7y8y15uz6le+PMvcMlVdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949984; c=relaxed/simple;
	bh=oj3P/19FQm3GhzmA7W5xkOFOXCD4j5EfAU62nU5kIRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFBHjCWAmhhS5UjQ43uXn4KQWAF/eduMoctX3bFTuvmdkJYvrdTT/H2/hDLn99a6ruftAbV0ieD97tVsSn2RoKHp0TEz7iRMwhbRpogg0xGIAz2VUcpAQPalmN81QR8R4dQm1FhlmXSkeycYgwuebkDSEvYFtbzeB876ijk9XS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145231D13;
	Thu, 31 Jul 2025 01:19:33 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4B63F673;
	Thu, 31 Jul 2025 01:19:38 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:19:15 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Bowen Yu <yubowen8@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, zhenglifeng1@huawei.com
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
Message-ID: <aIsnA4miO8fCJTgs@arm.com>
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

Hi Bowen, Jie
On Wed, Jul 30, 2025 at 11:23:12AM +0800, Bowen Yu wrote:
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
Which counters are we actually talking about here ?
> +
> +	if (ret) {
>  		pr_warn("%s: failed to read perf counters\n", __func__);
> +		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC,
> +						 cpu_data->shared_cpu_map);
>  		return;
>  	}
And the real error here would be ... ?
That makes me wonder why this has been registered as the source of the freq
scale in the first place if we are to hit some serious issue. Would you be able
to give an example of any?

---
BR
Beata
>  
> -- 
> 2.33.0
> 
> 

