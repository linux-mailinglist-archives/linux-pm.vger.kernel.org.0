Return-Path: <linux-pm+bounces-24874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C622A7DC4D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D719D3AE595
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94E22155E;
	Mon,  7 Apr 2025 11:31:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E6182D0;
	Mon,  7 Apr 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025465; cv=none; b=MsfyZsOcV8LdPfU+LAblEewpw5tqZAI9oCi/WCA8OsOCGH3B4aiaSNtX6/JFU1xY/seFRO0kNF9XUw3SBrXYyH2wlu6me+v9ry+czgbybyh+Oh6DxJf2/3M3XqYHxswOx9rkicSII5RuLaevGNzuo36PMPo18LQIqibM6BfiE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025465; c=relaxed/simple;
	bh=4q+i9DaKzPSwZJyA6jOX9K9IdtZ5uBZm6fDYnPSG3SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxeVVz4o2/zqbZAnJlXj0XYnaLfNiApO2XV+HUjazVhB+8lllHmTiciD+jfqhsFWVStw8MCNtop1IYSluezDJGUjfYEyYlJXuvLMGP35W6Ce5fiWGEh6fdsNK0HSs5nRkfxb0U2HiCke+WIzOCn4oOAUpUA9rvfkZchhMKHd0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A42106F;
	Mon,  7 Apr 2025 04:31:03 -0700 (PDT)
Received: from bogus (unknown [10.57.41.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E7FC3F59E;
	Mon,  7 Apr 2025 04:31:00 -0700 (PDT)
Date: Mon, 7 Apr 2025 12:30:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: cristian.marussi@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: scmi: Fix null-ptr-deref in
 scmi_cpufreq_get_rate()
Message-ID: <20250407-wondrous-turtle-of-foundation-e92250@sudeepholla>
References: <20250405055447.73925-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405055447.73925-1-bsdhenrymartin@gmail.com>

On Sat, Apr 05, 2025 at 01:54:47PM +0800, Henry Martin wrote:
> cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
> in the policy->cpus mask. scmi_cpufreq_get_rate() does not check for
> this case, which results in a NULL pointer dereference.
> 
> Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.
> 
> Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index c310aeebc8f3..c735f39245bf 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -37,11 +37,17 @@ static struct cpufreq_driver scmi_cpufreq_driver;
>  
>  static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
>  {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> -	struct scmi_data *priv = policy->driver_data;
> +	struct cpufreq_policy *policy;
> +	struct scmi_data *priv;
>  	unsigned long rate;
>  	int ret;
>  
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)

How about `if (unlikely(!policy))` instead ?

With that you can add :

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Both comment and review applies for scpi-cpufreq.c

-- 
Regards,
Sudeep

