Return-Path: <linux-pm+bounces-11842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FABB94607D
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 17:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8737F1F21B48
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7413175D48;
	Fri,  2 Aug 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF5xhe84"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAE175D2D;
	Fri,  2 Aug 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612368; cv=none; b=SWzj52MJDWJl30g+RTTMvLsi+rDe7d9WYC3wnKmQK4G6QCL4t866zxPd9jLSyy41tORy+iQ7umnMVRrrp+8XR9UxTmk9+jE4TkylsCMkqh2mlC3FPzFetFIZKhSd/YjQMgzq9/kiOiOWxbk2vJLG4+YDn5AorzptKZaFoKB3zJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612368; c=relaxed/simple;
	bh=m5D3gD/Hy9UKtTCnXqA+30/hEnVScAGJ1UrYeX8hcqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsHHQEig5sAgBHz0uShuDzi8GSp5psusgXQA79goemGagTXUibg0FDMUcJ25ntIQf+Z9GcxWITo05Sc/0EFHQ5zwOwjmb2mkWdbIWuLTeg5tgp3Q9aY+RpMdGV48pozUo5UHreOVAWWCg7qUBXikocACKYIqS+LJzCQ1aEOo5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF5xhe84; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722612368; x=1754148368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m5D3gD/Hy9UKtTCnXqA+30/hEnVScAGJ1UrYeX8hcqE=;
  b=nF5xhe84OdmfD7QJi+1ix/kFk1rDzcT/2F5JOUqivUsz9fD5/EvO4t7i
   fJH1xnMvRI7Erj6FUG4yJQ130ibPSgHtM1FiUpJclHwc++BZPvsUItkSB
   A0EbghM5sZDDW/F+dLkQw5O3z+mPdCluXpR3H65w27N4hiba67xwwj2tZ
   h24moStmP2Ix+gC+/DC+zj8XoHRs6wqXKOgSts9AASdeID3W5xObBg8KT
   NuuOtZ1tv3nLhz9y9SdBG12TyJEB2WZDownuG4yXKr2loli/1Xn142c9J
   2By7ylHVom6uSSayfxQyKOVjuD36ErNP2IahKctMFtd6HwIaZjeRkZQzT
   g==;
X-CSE-ConnectionGUID: dzHrVkPOQz6ji+45wjDtOw==
X-CSE-MsgGUID: H7FrW9LASd+41O0p5BHBfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="38099843"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="38099843"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:26:07 -0700
X-CSE-ConnectionGUID: /QFu6Oe4SdS8i5wTlOih5Q==
X-CSE-MsgGUID: Pmd+rAUTT/uAZirSpnUy8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55352789"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:26:07 -0700
Received: from [10.212.17.69] (kliang2-mobl1.ccr.corp.intel.com [10.212.17.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2E51820BF41F;
	Fri,  2 Aug 2024 08:26:03 -0700 (PDT)
Message-ID: <3956760b-de6e-4726-ac4f-e03738233f73@linux.intel.com>
Date: Fri, 2 Aug 2024 11:26:01 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 rui.zhang@intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, ananth.narayan@amd.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, ravi.bangoria@amd.com
References: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
 <20240730044917.4680-2-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240730044917.4680-2-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dhananjay,

On 2024-07-30 12:49 a.m., Dhananjay Ugwekar wrote:
> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> on AMD processors that support extended CPUID leaf 0x80000026, the
> topology_die_cpumask() and topology_logical_die_id() macros, no longer
> return the package cpumask and package id, instead they return the CCD
> (Core Complex Die) mask and id respectively. This leads to the energy-pkg
> event scope to be modified to CCD instead of package.
> 
> For more historical context, please refer to commit 32fb480e0a2c
> ("powercap/intel_rapl: Support multi-die/package"), which initially changed
> the RAPL scope from package to die for all systems, as Intel systems
> with Die enumeration have RAPL scope as die, and those without die
> enumeration were not affected by it. So, all systems(Intel, AMD, Hygon),
> worked correctly with topology_logical_die_id() until recently, but this
> changed after the "0x80000026 leaf" commit mentioned above.
> 
> Replacing topology_logical_die_id() with topology_physical_package_id()
> conditionally only for AMD and Hygon fixes the energy-pkg event.
> 
> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
> 
> Before:
> $ cat /sys/devices/power/cpumask
> 0,8,16,24,32,40,48,56,64,72,80,88.
> 
> The expected cpumask here is supposed to be just "0", as it is a package
> scope event, only one CPU will be collecting the event for all the CPUs in
> the package.
> 
> After:
> $ cat /sys/devices/power/cpumask
> 0
> 
> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> ---
> Changes in v2:
> * Updated the scope description comment
> * Dont create rapl_pmu_cpumask and rapl_pmu_idx local variables, as they're
>   used only once, instead call the get_* functions directly where needed
> * Check topology_logical_(die/package)_id return value
> --->  arch/x86/events/rapl.c | 47 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 5 deletions(-)

I just posted a patch set to clean up the hotplug code in perf.
https://lore.kernel.org/lkml/20240802151643.1691631-1-kan.liang@linux.intel.com/

With the cleanup patch set, the fix may be simplified as below.

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b70ad880c5bc..801697be4118 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -646,6 +646,10 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.module           = THIS_MODULE;
 	rapl_pmus->pmu.scope            = PERF_PMU_SCOPE_DIE;
 	rapl_pmus->pmu.capabilities     = PERF_PMU_CAP_NO_EXCLUDE;
+
+	if (rapl_pmu_is_pkg_scope())
+		rapl_pmus->pmu.scope = PERF_PMU_SCOPE_PKG;
+
 	return 0;
 }

Could you please take a look at the cleanup patch and give it a try?

Thanks,
Kan
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index b985ca79cf97..7097c0f6a71f 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -103,6 +103,19 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>  	.event_str	= str,							\
>  };
>  
> +/*
> + * RAPL Package energy counter scope:
> + * 1. AMD/HYGON platforms have a per-PKG package energy counter
> + * 2. For Intel platforms
> + *	2.1. CLX-AP is multi-die and its RAPL MSRs are die-scope
> + *	2.2. Other Intel platforms are single die systems so the scope can be
> + *	     considered as either pkg-scope or die-scope, and we are considering
> + *	     them as die-scope.
> + */
> +#define rapl_pmu_is_pkg_scope()				\
> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +
>  struct rapl_pmu {
>  	raw_spinlock_t		lock;
>  	int			n_active;
> @@ -140,9 +153,25 @@ static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  
> +/*
> + * Helper functions to get the correct topology macros according to the
> + * RAPL PMU scope.
> + */
> +static inline unsigned int get_rapl_pmu_idx(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> +					 topology_logical_die_id(cpu);
> +}
> +
> +static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
> +					 topology_die_cpumask(cpu);
> +}
> +
>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>  {
> -	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
> +	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>  
>  	/*
>  	 * The unsigned check also catches the '-1' return value for non
> @@ -552,7 +581,7 @@ static int rapl_cpu_offline(unsigned int cpu)
>  
>  	pmu->cpu = -1;
>  	/* Find a new cpu to collect rapl events */
> -	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
> +	target = cpumask_any_but(get_rapl_pmu_cpumask(cpu), cpu);
>  
>  	/* Migrate rapl events to the new target */
>  	if (target < nr_cpu_ids) {
> @@ -565,6 +594,11 @@ static int rapl_cpu_offline(unsigned int cpu)
>  
>  static int rapl_cpu_online(unsigned int cpu)
>  {
> +	s32 rapl_pmu_idx = get_rapl_pmu_idx(cpu);
> +	if (rapl_pmu_idx < 0) {
> +		pr_err("topology_logical_(package/die)_id() returned a negative value");
> +		return -EINVAL;
> +	}
>  	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>  	int target;
>  
> @@ -579,14 +613,14 @@ static int rapl_cpu_online(unsigned int cpu)
>  		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>  		rapl_hrtimer_init(pmu);
>  
> -		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
> +		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
>  	}
>  
>  	/*
>  	 * Check if there is an online cpu in the package which collects rapl
>  	 * events already.
>  	 */
> -	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
> +	target = cpumask_any_and(&rapl_cpu_mask, get_rapl_pmu_cpumask(cpu));
>  	if (target < nr_cpu_ids)
>  		return 0;
>  
> @@ -675,7 +709,10 @@ static const struct attribute_group *rapl_attr_update[] = {
>  
>  static int __init init_rapl_pmus(void)
>  {
> -	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
> +	int nr_rapl_pmu = topology_max_packages();
> +
> +	if (!rapl_pmu_is_pkg_scope())
> +		nr_rapl_pmu *= topology_max_dies_per_package();
>  
>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)

