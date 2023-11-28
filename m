Return-Path: <linux-pm+bounces-368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6B7FBC16
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCA128218C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D1359B65;
	Tue, 28 Nov 2023 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AD981A5;
	Tue, 28 Nov 2023 06:01:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D431FB;
	Tue, 28 Nov 2023 06:02:43 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7D003F6C4;
	Tue, 28 Nov 2023 06:01:55 -0800 (PST)
Date: Tue, 28 Nov 2023 14:01:54 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, sumitg@nvidia.com, sudeep.holla@arm.covm,
	will@kernel.org, catalin.marinas@arm.com, viresh.kumar@linaro.org,
	rafael@kernel.org, yang@os.amperecomputing.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into
 cpufreq_verify_current_freq
Message-ID: <ZWXy0h/fFfQh+Rhy@arm.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
 <20231127160838.1403404-3-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127160838.1403404-3-beata.michalska@arm.com>

Hi Beata, Sumit,

On Monday 27 Nov 2023 at 16:08:38 (+0000), Beata Michalska wrote:
> From: Sumit Gupta <sumitg@nvidia.com>
> 
> When available, use arch_freq_get_on_cpu to obtain current frequency
> (usually an average reported over given period of time)
> to better align the cpufreq's view on the current state of affairs.
> This also automatically pulls in the update for cpuinfo_cur_freq sysfs
> attribute, aligning it with the scaling_cur_freq one, and thus providing
> consistent view on relevant platforms.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> [BM: Subject & commit msg]
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8c4f9c2f9c44..109559438f45 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>  {
>  	unsigned int new_freq;
>  
> -	new_freq = cpufreq_driver->get(policy->cpu);
> +	new_freq = arch_freq_get_on_cpu(policy->cpu);
> +	new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);

Given that arch_freq_get_on_cpu() is an average frequency, it does not
seem right to me to trigger the sync & update process of
cpufreq_verify_current_freq() based on it.

cpufreq_verify_current_freq() will at least modify the internal state of
the policy and send PRE and POST notifications, if not do a full frequency
update, based on this average frequency, which is likely different from
the current frequency, even beyond the 1MHz threshold.

While I believe it's okay to return this average frequency in
cpuinfo_cur_freq, I don't think it should be used as an indication of
an accurate current frequency, which is what
cpufreq_verify_current_freq() expects.

Sumit, can you give more details on the issue at [1] and why this change
fixes it?

[1] https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/

Thank you,
Ionela.

>  	if (!new_freq)
>  		return 0;
>  
> -- 
> 2.25.1
> 

