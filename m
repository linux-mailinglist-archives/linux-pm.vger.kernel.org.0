Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65E92880D1
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 05:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbgJIDrI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 23:47:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:45050 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbgJIDrE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 23:47:04 -0400
IronPort-SDR: F077Jr5OoVg0nqG/mvl27ElFGhSYWneGSNjw3OqKq9ZAr2gXQSRt8WKOM1gzpOznCR1ToUWVUe
 UoZFx6ZKXuTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="229624611"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="229624611"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 20:47:03 -0700
IronPort-SDR: 8pzXGi/5bXFkGJAoJ22yWbHBmItVfVqSQt2Dh/be408N1Vo/492DiaQeDUwQqik80o7Bw85QBg
 OCFyiAbwiWZA==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="519574637"
Received: from unknown (HELO rzhang1-mobile) ([10.255.29.238])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 20:46:58 -0700
Message-ID: <eb8dbbceb2252ebc36e3ed76f7a9efe1612ed2b7.camel@intel.com>
Subject: Re: [PATCH v2 3/4] powercap: Add AMD Fam17h RAPL support
From:   Zhang Rui <rui.zhang@intel.com>
To:     Kim Phillips <kim.phillips@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Victor Ding <victording@google.com>, linux-pm@vger.kernel.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Date:   Fri, 09 Oct 2020 11:46:55 +0800
In-Reply-To: <20201007161439.312534-4-kim.phillips@amd.com>
References: <20201007161439.312534-1-kim.phillips@amd.com>
         <20201007161439.312534-4-kim.phillips@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-10-07 at 11:14 -0500, Kim Phillips wrote:
> From: Victor Ding <victording@google.com>
> 
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
> Cc: Victor Ding <victording@google.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: x86@kernel.org
> ---
> Kim's changes from Victor's original submission:
> 
> 
https://lore.kernel.org/lkml/20200729205144.3.I01b89fb23d7498521c84cfdf417450cbbfca46bb@changeid/
> 
>  - Added my Acked-by.
>  - Added Daniel Lezcano to Cc.
> 
>  arch/x86/include/asm/msr-index.h     |  1 +
>  drivers/powercap/intel_rapl_common.c |  2 ++
>  drivers/powercap/intel_rapl_msr.c    | 27
> ++++++++++++++++++++++++++-
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h
> b/arch/x86/include/asm/msr-index.h
> index f1b24f1b774d..c0646f69d2a5 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -324,6 +324,7 @@
>  #define MSR_PP1_POLICY			0x00000642
>  
>  #define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
> +#define MSR_AMD_CORE_ENERGY_STATUS	0xc001029a
>  #define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
>  
>  /* Config TDP MSRs */
> diff --git a/drivers/powercap/intel_rapl_common.c
> b/drivers/powercap/intel_rapl_common.c
> index 983d75bd5bd1..6905ccffcec3 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1054,6 +1054,8 @@ static const struct x86_cpu_id rapl_ids[]
> __initconst = {
>  
>  	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_se
> rver),
>  	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_se
> rver),
> +
> +	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_core),

I double if we can use rapl_defaults_core here.

static const struct rapl_defaults rapl_defaults_core = {
        .floor_freq_reg_addr = 0,
        .check_unit = rapl_check_unit_core,
        .set_floor_freq = set_floor_freq_default,
        .compute_time_window = rapl_compute_time_window_core,
};

        .floor_freq_reg_addr = 0,
is redundant here, even for rapl_defaults_core, we can remove it.

        .check_unit = rapl_check_unit_core,
the Intel UNIT MSR supports three units including Energy/Power/Time.
From the change below, only the energy counter is supported, so you may
need to confirm if all the three units are supported or not.

        .set_floor_freq = set_floor_freq_default,this function sets PL1_CLAMP bit on RAPL_DOMAIN_REG_LIMIT, but RAPL_DOMAIN_REG_LIMIT is not supported on the AMD cpus.

        .compute_time_window = rapl_compute_time_window_core,
this is used for setting the power limits, which is not supported on
the AMD cpus.

IMO, it's better to use a new rapl_defaults that contains valid
callbacks for AMD cpus.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> diff --git a/drivers/powercap/intel_rapl_msr.c
> b/drivers/powercap/intel_rapl_msr.c
> index c68ef5e4e1c4..dcaef917f79d 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -48,6 +48,21 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
>  	.limits[RAPL_DOMAIN_PACKAGE] = 2,
>  };
>  
> +static struct rapl_if_priv rapl_msr_priv_amd = {
> +	.reg_unit = MSR_AMD_RAPL_POWER_UNIT,
> +	.regs[RAPL_DOMAIN_PACKAGE] = {
> +		0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
> +	.regs[RAPL_DOMAIN_PP0] = {
> +		0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
> +	.regs[RAPL_DOMAIN_PP1] = {
> +		0, 0, 0, 0, 0 },
> +	.regs[RAPL_DOMAIN_DRAM] = {
> +		0, 0, 0, 0, 0 },
> +	.regs[RAPL_DOMAIN_PLATFORM] = {
> +		0, 0, 0, 0, 0},

I don't think you need to set the PP1/DRAM/PLATFORM registers to 0 explicitly if they are not supported.

> +	.limits[RAPL_DOMAIN_PACKAGE] = 1,


Is Pkg Domain PL1 really supported?
At least according to this patch, I don't think so. So if power limit
is supported, it is better to add the support in this patch altogether.

If no, we're actually exposing energy counters only. If this is the
case, I'm not sure if it is proper to do this in powercap class because
we can not do powercap actually. Or at least, if we want to support
power zones with no power limits, we should enhance the code to
support this rather than fake a power limit.

thanks,
rui
> +};
> +
>  /* Handles CPU hotplug on multi-socket systems.
>   * If a CPU goes online as the first CPU of the physical package
>   * we add the RAPL package to the system. Similarly, when the last
> @@ -137,7 +152,17 @@ static int rapl_msr_probe(struct platform_device
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



IF



