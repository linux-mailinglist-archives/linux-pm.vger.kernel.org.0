Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BE3653F1
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDTIXB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 04:23:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhDTIXA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 04:23:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5CB8B2DD;
        Tue, 20 Apr 2021 08:22:28 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:22:31 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Huang Rui <ray.huang@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jason Bagavatsingham <jason.bagavatsingham@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org
Subject: Re: [PATCH] x86, sched: Fix the AMD CPPC maximum perf on some
 specific generations
Message-ID: <20210420082231.GE2326@zn.tnic>
References: <20210420080943.1045886-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420080943.1045886-1-ray.huang@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 04:09:43PM +0800, Huang Rui wrote:
> Some AMD Ryzen generations has different calculation method on maximum
> perf. 255 is not for all asics, some specific generations used 166 as
> the maximum perf. This patch is to fix the different maximum perf value

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> of AMD CPPC.
> 
> Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
> Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")
> 
> Reported-by: Jason Bagavatsingham <jason.bagavatsingham@gmail.com>
> Tested-by: Jason Bagavatsingham <jason.bagavatsingham@gmail.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Nathan Fontenot <nathan.fontenot@amd.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: x86@kernel.org
> ---
>  arch/x86/kernel/smpboot.c      | 33 ++++++++++++++++++++++++++-
>  drivers/cpufreq/acpi-cpufreq.c | 41 ++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 02813a7f3a7c..705bc5ceb1ea 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -2033,6 +2033,37 @@ static bool intel_set_max_freq_ratio(void)
>  }
>  
>  #ifdef CONFIG_ACPI_CPPC_LIB
> +static u64 amd_get_highest_perf(void)
> +{

	struct cpuinfo_x86 *c = &boot_cpu_data;

and then you can use "c" everywhere.

> +	u64 cppc_max_perf;

u64 for something which fits in a byte?

Also,
	max_perf = 255;

and you can remove the else and default branches below.

> +
> +	switch (boot_cpu_data.x86) {
> +	case 0x17:
> +		if ((boot_cpu_data.x86_model >= 0x30 &&
> +		     boot_cpu_data.x86_model < 0x40) ||
> +		    (boot_cpu_data.x86_model >= 0x70 &&
> +		     boot_cpu_data.x86_model < 0x80))
> +			cppc_max_perf = 166;
> +		else
> +			cppc_max_perf = 255;
> +		break;
> +	case 0x19:
> +		if ((boot_cpu_data.x86_model >= 0x20 &&
> +		     boot_cpu_data.x86_model < 0x30) ||
> +		    (boot_cpu_data.x86_model >= 0x40 &&
> +		     boot_cpu_data.x86_model < 0x70))
> +			cppc_max_perf = 166;
> +		else
> +			cppc_max_perf = 255;
> +		break;
> +	default:
> +		cppc_max_perf = 255;
> +		break;
> +	}
> +
> +	return cppc_max_perf;
> +}

Why is this here and not in arch/x86/kernel/cpu/amd.c?

> +
>  static bool amd_set_max_freq_ratio(void)
>  {
>  	struct cppc_perf_caps perf_caps;



> @@ -2046,8 +2077,8 @@ static bool amd_set_max_freq_ratio(void)
>  		return false;
>  	}
>  
> -	highest_perf = perf_caps.highest_perf;
>  	nominal_perf = perf_caps.nominal_perf;
> +	highest_perf = amd_get_highest_perf();
>  
>  	if (!highest_perf || !nominal_perf) {
>  		pr_debug("Could not retrieve highest or nominal performance\n");
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index d1bbc16fba4b..e5c03360db20 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -630,6 +630,44 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>  #endif
>  
>  #ifdef CONFIG_ACPI_CPPC_LIB
> +
> +static u64 get_amd_max_boost_ratio(unsigned int cpu, u64 nominal_perf)
> +{
> +	u64 boost_ratio, cppc_max_perf;
> +
> +	if (!nominal_perf)
> +		return 0;
> +
> +	switch (boot_cpu_data.x86) {
> +	case 0x17:
> +		if ((boot_cpu_data.x86_model >= 0x30 &&
> +		     boot_cpu_data.x86_model < 0x40) ||
> +		    (boot_cpu_data.x86_model >= 0x70 &&
> +		     boot_cpu_data.x86_model < 0x80))
> +			cppc_max_perf = 166;
> +		else
> +			cppc_max_perf = 255;
> +		break;
> +	case 0x19:
> +		if ((boot_cpu_data.x86_model >= 0x20 &&
> +		     boot_cpu_data.x86_model < 0x30) ||
> +		    (boot_cpu_data.x86_model >= 0x40 &&
> +		     boot_cpu_data.x86_model < 0x70))
> +			cppc_max_perf = 166;
> +		else
> +			cppc_max_perf = 255;
> +		break;
> +	default:
> +		cppc_max_perf = 255;
> +		break;

This chunk is repeated here. Why?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
