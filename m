Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D63D2A22C5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 02:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKBBjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 20:39:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:45500 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbgKBBjC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Nov 2020 20:39:02 -0500
IronPort-SDR: rIjOXY+Yz5Xv9m6Ihm7qMvgcvO7REgpmlhgcdK9mEzByUwBna0p0TqZletCs0cP4t565sHmoEJ
 sPGGsjrH9I4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="165319875"
X-IronPort-AV: E=Sophos;i="5.77,443,1596524400"; 
   d="scan'208";a="165319875"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 17:39:01 -0800
IronPort-SDR: LFMIr1zu/oliBLh3ySTjzuHQ4khJtZSinb8FNHnzVxqZOJEI4gY86pUnz+Q3qei8Ryibb+c1Ww
 /Cu8EvqbhgJw==
X-IronPort-AV: E=Sophos;i="5.77,443,1596524400"; 
   d="scan'208";a="537829731"
Received: from unknown (HELO rzhang1-mobile) ([10.255.28.218])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 17:38:55 -0800
Message-ID: <82f3070691438d3f651d2e5e5fb5499131cdbd15.camel@intel.com>
Subject: Re: [PATCH v3 3/4] powercap: Add AMD Fam17h RAPL support
From:   Zhang Rui <rui.zhang@intel.com>
To:     Victor Ding <victording@google.com>, linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>, linux-pm@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Date:   Mon, 02 Nov 2020 09:38:53 +0800
In-Reply-To: <20201027072358.13725-4-victording@google.com>
References: <20201027072358.13725-1-victording@google.com>
         <20201027072358.13725-4-victording@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-10-27 at 07:23 +0000, Victor Ding wrote:
> This patch enables AMD Fam17h RAPL support for the power capping
> framework. The support is as per AMD Fam17h Model31h (Zen2) and
> model 00-ffh (Zen1) PPR.
> 
> Tested by comparing the results of following two sysfs entries and
> the
> values directly read from corresponding MSRs via /dev/cpu/[x]/msr:
>   /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
>   /sys/class/powercap/intel-rapl/intel-rapl:0/intel-
> rapl:0:0/energy_uj
> 
> Signed-off-by: Victor Ding <victording@google.com>
> Acked-by: Kim Phillips <kim.phillips@amd.com>
> 
> 
> ---
> 
> Changes in v3:
> By Victor Ding <victording@google.com>
>  - Rebased to the latest code.
>  - Created a new rapl_defaults for AMD CPUs.
>  - Removed redundant setting to zeros.
>  - Stopped using the fake power limit domain 1.
> 
> Changes in v2:
> By Kim Phillips <kim.phillips@amd.com>:
>  - Added Kim's Acked-by.
>  - Added Daniel Lezcano to Cc.
>  - (No code change).
> 
>  arch/x86/include/asm/msr-index.h     |  1 +
>  drivers/powercap/intel_rapl_common.c |  6 ++++++
>  drivers/powercap/intel_rapl_msr.c    | 20 +++++++++++++++++++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h
> b/arch/x86/include/asm/msr-index.h
> index 21917e134ad4..c36a083c8ec0 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -327,6 +327,7 @@
>  #define MSR_PP1_POLICY			0x00000642
>  
>  #define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
> +#define MSR_AMD_CORE_ENERGY_STATUS		0xc001029a
>  #define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
>  
>  /* Config TDP MSRs */
> diff --git a/drivers/powercap/intel_rapl_common.c
> b/drivers/powercap/intel_rapl_common.c
> index 0b2830efc574..bedd780bed12 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1011,6 +1011,10 @@ static const struct rapl_defaults
> rapl_defaults_cht = {
>  	.compute_time_window = rapl_compute_time_window_atom,
>  };
>  
> +static const struct rapl_defaults rapl_defaults_amd = {
> +	.check_unit = rapl_check_unit_core,
> +};
> +

why do we need power_unit and time_unit if we only want to expose the
energy counter?

Plus, in rapl_init_domains(), PL1 is enabled for every RAPL Domain
blindly, I'm not sure how this is handled on the AMD CPUs.
Is PL1 invalidated by rapl_detect_powerlimit()? or is it still
registered as a valid constraint into powercap sysfs I/F?

Currently, the code makes the assumption that there is only on power
limit if priv->limits[domain_id] not set, we probably need to change
this if we want to support RAPL domains with no power limit.

thanks,
rui
>  static const struct x86_cpu_id rapl_ids[] __initconst = {
>  	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&rapl_default
> s_core),
>  	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&rapl_defaults_core),
> @@ -1061,6 +1065,8 @@ static const struct x86_cpu_id rapl_ids[]
> __initconst = {
>  
>  	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_se
> rver),
>  	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_se
> rver),
> +
> +	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> diff --git a/drivers/powercap/intel_rapl_msr.c
> b/drivers/powercap/intel_rapl_msr.c
> index a819b3b89b2f..78213d4b5b16 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -49,6 +49,14 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
>  	.limits[RAPL_DOMAIN_PLATFORM] = 2,
>  };
>  
> +static struct rapl_if_priv rapl_msr_priv_amd = {
> +	.reg_unit = MSR_AMD_RAPL_POWER_UNIT,
> +	.regs[RAPL_DOMAIN_PACKAGE] = {
> +		0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
> +	.regs[RAPL_DOMAIN_PP0] = {
> +		0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
> +};
> +
>  /* Handles CPU hotplug on multi-socket systems.
>   * If a CPU goes online as the first CPU of the physical package
>   * we add the RAPL package to the system. Similarly, when the last
> @@ -138,7 +146,17 @@ static int rapl_msr_probe(struct platform_device
> *pdev)
>  	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
>  	int ret;
>  
> -	rapl_msr_priv = &rapl_msr_priv_intel;
> +	switch (boot_cpu_data.x86_vendor) {
> +	case X86_VENDOR_INTEL:
> +		rapl_msr_priv = &rapl_msr_priv_intel;
> +		break;
> +	case X86_VENDOR_AMD:
> +		rapl_msr_priv = &rapl_msr_priv_amd;
> +		break;
> +	default:
> +		pr_err("intel-rapl does not support CPU vendor %d\n",
> boot_cpu_data.x86_vendor);
> +		return -ENODEV;
> +	}
>  	rapl_msr_priv->read_raw = rapl_msr_read_raw;
>  	rapl_msr_priv->write_raw = rapl_msr_write_raw;
>  

