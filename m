Return-Path: <linux-pm+bounces-26784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1EFAADDEB
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F683AE455
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984225A33E;
	Wed,  7 May 2025 12:00:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A6D233145;
	Wed,  7 May 2025 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619200; cv=none; b=qNgB3/vAmNt4x5hhzHYn9dix16faj3Z7XerLiL9wcvBWpfHBerYb7JCGatFjuMYpwu8c41RztdaBv3z4BWoLL+5bQPwZLaiPbaSy5Jd2A05qipfYcvcUmGKS74pZ+jNSDgCg4xWtkYXa++WOU2x71Rbx0YskB6cCtjZ04AYprf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619200; c=relaxed/simple;
	bh=8RO7qb8A2o2/SWPKRVHIg+XW346Qu4M2ikcfzJXF/Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2wEOUei0Cu7GSYxID4w0Qxx62sjiAoP2weRd0iRaicBae5eW6Q7iLYdGFN2ElpAqdKvd8bm4BSFEtl4dCJuABVmB+0uwfU88naQXshtR/4ML0SYoC8/PoDHphwfk4tMamnnF/QyALXI7lgMEchSZ5yhZzOpn+L/KnJF9sF20rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B3C6339;
	Wed,  7 May 2025 04:59:46 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 476B23F5A1;
	Wed,  7 May 2025 04:59:54 -0700 (PDT)
Date: Wed, 7 May 2025 12:59:45 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@oss.nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3] cpufreq: scmi: Skip SCMI devices that aren't used by
 the CPUs
Message-ID: <aBtLMYqcnwacGJuy@pluto>
References: <20250428144728.871404-1-quic_mdtipton@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428144728.871404-1-quic_mdtipton@quicinc.com>

On Mon, Apr 28, 2025 at 07:47:28AM -0700, Mike Tipton wrote:
> Currently, all SCMI devices with performance domains attempt to register
> a cpufreq driver, even if their performance domains aren't used to
> control the CPUs. The cpufreq framework only supports registering a
> single driver, so only the first device will succeed. And if that device
> isn't used for the CPUs, then cpufreq will scale the wrong domains.
> 

Hi,

bit of lagging behind, my bad.


> To avoid this, return early from scmi_cpufreq_probe() if the probing
> SCMI device isn't referenced by the CPU device phandles.
> 
> This keeps the existing assumption that all CPUs are controlled by a
> single SCMI device.
> 
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v3:
> - Use dev_of_node(dev) instead of dev->of_node.
> - Sanity check scmi_np.
> - Pick up Reviewed-by from Peng.
> - Link to v2: https://lore.kernel.org/all/20250421195206.3736128-1-quic_mdtipton@quicinc.com/
> 
> Changes in v2:
> - Return -ENODEV instead of 0 for irrelevant devices.
> - Link to v1: https://lore.kernel.org/all/20250411212941.1275572-1-quic_mdtipton@quicinc.com/
> 
>  drivers/cpufreq/scmi-cpufreq.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 944e899eb1be..b63992de9fc7 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -393,6 +393,35 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
>  	.set_boost	= cpufreq_boost_set_sw,
>  };
>  
> +static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
> +{
> +	struct device_node *scmi_np = dev_of_node(scmi_dev);
> +	struct device_node *np;
> +	struct device *cpu_dev;
> +	int cpu, idx;
> +
> +	if (!scmi_np)
> +		return false;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_dev = get_cpu_device(cpu);
> +		if (!cpu_dev)
> +			continue;
> +
> +		np = dev_of_node(cpu_dev);
> +
> +		if (of_parse_phandle(np, "clocks", 0) == scmi_np)

Shouldn't this, on Success, be released by an of_node_put() (or, BETTER,
by some OF-related cleanup.h magic...)

> +			return true;
> +
> +		idx = of_property_match_string(np, "power-domain-names", "perf");
> +
> +		if (of_parse_phandle(np, "power-domains", idx) == scmi_np)

Same.

> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  {
>  	int ret;
> @@ -401,7 +430,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  
>  	handle = sdev->handle;
>  
> -	if (!handle)
> +	if (!handle || !scmi_dev_used_by_cpus(dev))
>  		return -ENODEV;
>  
>  	scmi_cpufreq_driver.driver_data = sdev;

Other than the above glitches, LGTM.
(I gave it a go on JUNO and some emulated setup..)

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

