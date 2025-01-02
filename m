Return-Path: <linux-pm+bounces-19881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BFE9FF7A8
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB0F3A182C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04381A8419;
	Thu,  2 Jan 2025 09:48:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9AD1A8416;
	Thu,  2 Jan 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735811317; cv=none; b=Aoexv6Di3KgwvwtgJSOvDeAfmA98Ft4zPejsFknckLQH356I6PvsQzj8TqDX/a+Ad+JOKeKNoECKCHOIGJRqumJ2JXHcwSISKVIbIjKSPPyK2W+fY7FpGCDML7VOcoXcRMA1VQ8OAz6cCGKiliLvko46P8yzbiw/XTxAO79IVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735811317; c=relaxed/simple;
	bh=fAymzws3Ml3bKlqGpAPIeAh6rOvf51h36pdJ5y1pYlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ4z4/K0dZXWc4TdB+mtcvurPFJD+kH1WFZ9+WISnNXM3msyBCFUFK0gG3uJXunP2ECXH8iewhLqQckJ6YJJ+iOcwV1CmWV/fXo0x1/5nxVdriNF2J8YwEi1TsIWw10lMUu4lS5iPfs3gdiOERn4+HgwIjVfluyeikXPaO1fUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB5811FB;
	Thu,  2 Jan 2025 01:49:01 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B008E3F59E;
	Thu,  2 Jan 2025 01:48:31 -0800 (PST)
Date: Thu, 2 Jan 2025 09:48:28 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Charles Han <hanchunchao@inspur.com>
Cc: <cristian.marussi@arm.com>, <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <viresh.kumar@linaro.org>,
	<arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: scpi: Prevent null pointer dereference in
 scpi_cpufreq_get_rate()
Message-ID: <Z3Zg7PHdGAzXsyMg@bogus>
References: <20241230093159.258813-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230093159.258813-1-hanchunchao@inspur.com>

On Mon, Dec 30, 2024 at 05:31:59PM +0800, Charles Han wrote:
> cpufreq_cpu_get_raw() may return NULL if the cpu is not in
> policy->cpus cpu mask and it will cause null pointer dereference.
> Prevent null pointer dereference in scpi_cpufreq_get_rate().
>

Can you please fix such occurrences in other places too ?
I see it in apple-soc-cpufreq.c and scmi-cpufreq.c as well.

> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index cd89c1b9832c..c888ed3a0de9 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -30,6 +30,9 @@ static struct scpi_ops *scpi_ops;
>  static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> +	if (unlikely(!policy))
> +		return 0;
> +
>  	struct scpi_data *priv = policy->driver_data;
>  	unsigned long rate = clk_get_rate(priv->clk);
>  

-- 
Regards,
Sudeep

