Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284CA2A8482
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 18:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKEROF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 12:14:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:51425 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKEROF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 12:14:05 -0500
IronPort-SDR: vj30GBh/VhvTHhjkeS4eY2J0HNVNLnH3Un+TiPpFKFDMutSH57NGI8kj9JJ6HOYhGUB/S/m5QI
 LOvkT1viYvXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="148702284"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="148702284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 09:14:04 -0800
IronPort-SDR: pUs58wCgXdE9ZD5w6dR91lDrol/v5BDaDas5XjPb9a0s8qbxuKl5+aRn5dMlJQNtj1GHqqzqE+
 D4/t4gLxAIww==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="354361141"
Received: from spandruv-mobl.amr.corp.intel.com ([10.209.112.234])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 09:14:03 -0800
Message-ID: <9ea15f21febf47d5d6f62911fe0141a2ae5d5e2b.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/4] powercap: Add AMD Fam17h RAPL support
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Victor Ding <victording@google.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>, linux-pm@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Date:   Thu, 05 Nov 2020 09:14:01 -0800
In-Reply-To: <CANqTbdafN+NekRN3oO35o-7DXvu1p_9SwH_XVkw1DmbgSk9y6w@mail.gmail.com>
References: <20201027072358.13725-1-victording@google.com>
         <20201027072358.13725-4-victording@google.com>
         <82f3070691438d3f651d2e5e5fb5499131cdbd15.camel@intel.com>
         <CANqTbdaB8Mv+ij2rdprC_=JUt49A_V12-T5TbyidNktah575rw@mail.gmail.com>
         <f7562a2492aa83afa8a3a511428ed1959b8e8c72.camel@linux.intel.com>
         <CANqTbdaePLt-kYdihFzZ1Bjns=OfKwWxiYp5-JwfONm7Ujqi+Q@mail.gmail.com>
         <180b54c84179429af3f09ff38e92e642928a2fdb.camel@linux.intel.com>
         <CANqTbdafN+NekRN3oO35o-7DXvu1p_9SwH_XVkw1DmbgSk9y6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-11-05 at 14:53 +1100, Victor Ding wrote:
> On Wed, Nov 4, 2020 at 1:17 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Wed, 2020-11-04 at 12:43 +1100, Victor Ding wrote:
> > > On Wed, Nov 4, 2020 at 4:09 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > On Tue, 2020-11-03 at 17:10 +1100, Victor Ding wrote:
> > > > > On Mon, Nov 2, 2020 at 12:39 PM Zhang Rui <
> > > > > rui.zhang@intel.com>
> > > > > wrote:
> > > > > > On Tue, 2020-10-27 at 07:23 +0000, Victor Ding wrote:
> > > > > > > This patch enables AMD Fam17h RAPL support for the power
> > > > > > > capping
> > > > > > > framework. The support is as per AMD Fam17h Model31h
> > > > > > > (Zen2)
> > > > > > > and
> > > > > > > model 00-ffh (Zen1) PPR.
> > > > > > > 
> > > > > > > Tested by comparing the results of following two sysfs
> > > > > > > entries
> > > > > > > and
> > > > > > > the
> > > > > > > values directly read from corresponding MSRs via
> > > > > > > /dev/cpu/[x]/msr:
> > > > > > >   /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
> > > > > > >   /sys/class/powercap/intel-rapl/intel-rapl:0/intel-
> > > > > > > rapl:0:0/energy_uj
> > > > 
> > > > Is this for just energy reporting? No capping of power?
> > > Correct, the hardware does not support capping of power.
> > I wonder if there is no capping, is this the right interface?
> > Do you have specific user space, which cares about this?
> We have tools that previously developed to measure energy status
> on Intel via the powercap interface. Powercap is the only interface
> allowing reading RAPL energy counters without requiring MSR access
> privileges. We want to use these tools on AMD with minimal
> modifications.
> I believe the powercap interface should support these counters,
> regardless of the use cases, mainly for two reasons:
> 1. Powercap interface already supports monitoring-only power domains,
> e.g. power limit is locked by BIOS or the (Intel) CPU does not expose
> an
> MSR for certain power domains. The latter is the exact situation on
> AMD;
> 2. As AMD has partially introduced the equivalent of Intel's RAPL, we
> should leverage this opportunity to reduce the divergence in the
> APIs. i.e.
> OS as a hardware abstraction layer should allow users to use the same
> set of APIs to access RAPL features if it issupported on both Intel
> and AMD.
> In this specific case, if users can query for Intel's RAPL counters
> via
> powercap, they should be able to do so as well for AMD's.
> > I think these counters are already exposed via hwmon sysf.
> Yes, they were introduced early this year. However, it is not the
> same as
> the counters exposed via powercap interface: powercap exposes the
> actual value of the energy counters while hwmon adds an accumulation
> layer on top.
> In addition, I don't think Intel's RAPL counters are exposed via
> hwmon;
> therefore: 1. existing fine grade power monitoring tools are not
> based on
> hwmon; 2. new tools cannot query the same set of counters via the
> same
> API so that they have to actively maintain two sets of logic.

Fine with me. I think eventually the power capping interface will be
supported.

Thanks,
Srinivas

> > Thanks,
> > Srinivas
> > 
> > > > Thanks,
> > > > Srinivas
> > > > 
> > > > 
> > > > > > > Signed-off-by: Victor Ding <victording@google.com>
> > > > > > > Acked-by: Kim Phillips <kim.phillips@amd.com>
> > > > > > > 
> > > > > > > 
> > > > > > > ---
> > > > > > > 
> > > > > > > Changes in v3:
> > > > > > > By Victor Ding <victording@google.com>
> > > > > > >  - Rebased to the latest code.
> > > > > > >  - Created a new rapl_defaults for AMD CPUs.
> > > > > > >  - Removed redundant setting to zeros.
> > > > > > >  - Stopped using the fake power limit domain 1.
> > > > > > > 
> > > > > > > Changes in v2:
> > > > > > > By Kim Phillips <kim.phillips@amd.com>:
> > > > > > >  - Added Kim's Acked-by.
> > > > > > >  - Added Daniel Lezcano to Cc.
> > > > > > >  - (No code change).
> > > > > > > 
> > > > > > >  arch/x86/include/asm/msr-index.h     |  1 +
> > > > > > >  drivers/powercap/intel_rapl_common.c |  6 ++++++
> > > > > > >  drivers/powercap/intel_rapl_msr.c    | 20
> > > > > > > +++++++++++++++++++-
> > > > > > >  3 files changed, 26 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/arch/x86/include/asm/msr-index.h
> > > > > > > b/arch/x86/include/asm/msr-index.h
> > > > > > > index 21917e134ad4..c36a083c8ec0 100644
> > > > > > > --- a/arch/x86/include/asm/msr-index.h
> > > > > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > > > > @@ -327,6 +327,7 @@
> > > > > > >  #define MSR_PP1_POLICY                       0x00000642
> > > > > > > 
> > > > > > >  #define MSR_AMD_RAPL_POWER_UNIT              0xc0010299
> > > > > > > +#define MSR_AMD_CORE_ENERGY_STATUS           0xc001029a
> > > > > > >  #define MSR_AMD_PKG_ENERGY_STATUS    0xc001029b
> > > > > > > 
> > > > > > >  /* Config TDP MSRs */
> > > > > > > diff --git a/drivers/powercap/intel_rapl_common.c
> > > > > > > b/drivers/powercap/intel_rapl_common.c
> > > > > > > index 0b2830efc574..bedd780bed12 100644
> > > > > > > --- a/drivers/powercap/intel_rapl_common.c
> > > > > > > +++ b/drivers/powercap/intel_rapl_common.c
> > > > > > > @@ -1011,6 +1011,10 @@ static const struct rapl_defaults
> > > > > > > rapl_defaults_cht = {
> > > > > > >       .compute_time_window =
> > > > > > > rapl_compute_time_window_atom,
> > > > > > >  };
> > > > > > > 
> > > > > > > +static const struct rapl_defaults rapl_defaults_amd = {
> > > > > > > +     .check_unit = rapl_check_unit_core,
> > > > > > > +};
> > > > > > > +
> > > > > > 
> > > > > > why do we need power_unit and time_unit if we only want to
> > > > > > expose
> > > > > > the
> > > > > > energy counter?
> > > > > AMD's Power Unit MSR provides identical information as
> > > > > Intel's,
> > > > > including
> > > > > time units, power units, and energy status units. By reusing
> > > > > the
> > > > > check unit
> > > > > method, we could avoid code duplication as well as easing
> > > > > future
> > > > > enhance-
> > > > > ment when AMD starts to support power limits.
> > > > > > Plus, in rapl_init_domains(), PL1 is enabled for every RAPL
> > > > > > Domain
> > > > > > blindly, I'm not sure how this is handled on the AMD CPUs.
> > > > > > Is PL1 invalidated by rapl_detect_powerlimit()? or is it
> > > > > > still
> > > > > > registered as a valid constraint into powercap sysfs I/F?
> > > > > AMD's CORE_ENERGY_STAT MSR is like Intel's PP0_ENERGY_STATUS;
> > > > > therefore, PL1 also always exists on AMD.
> > > > > rapl_detect_powerlimit()
> > > > > correctly
> > > > > markes the domain as monitoring-only after finding power
> > > > > limit
> > > > > MSRs
> > > > > do not
> > > > > exist.
> > > > > > Currently, the code makes the assumption that there is only
> > > > > > on
> > > > > > power
> > > > > > limit if priv->limits[domain_id] not set, we probably need
> > > > > > to
> > > > > > change
> > > > > > this if we want to support RAPL domains with no power
> > > > > > limit.
> > > > > The existing code already supports RAPL domains with no power
> > > > > limit:
> > > > > PL1 is
> > > > > enabled when there is zero or one power limit,
> > > > > rapl_detect_powerlimit() will then
> > > > > mark if PL1 is monitoring-only if power limit MSRs do not
> > > > > exist.
> > > > > Both
> > > > > AMD's RAPL
> > > > > domains are monitoring-only and are correctly marked and
> > > > > handled.
> > > > > > thanks,
> > > > > > rui
> > > > > > >  static const struct x86_cpu_id rapl_ids[] __initconst =
> > > > > > > {
> > > > > > >       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,         &ra
> > > > > > > pl_d
> > > > > > > efau
> > > > > > > lt
> > > > > > > s_core),
> > > > > > >       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,       &ra
> > > > > > > pl_d
> > > > > > > efau
> > > > > > > lts_core),
> > > > > > > @@ -1061,6 +1065,8 @@ static const struct x86_cpu_id
> > > > > > > rapl_ids[]
> > > > > > > __initconst = {
> > > > > > > 
> > > > > > >       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &ra
> > > > > > > pl_d
> > > > > > > efau
> > > > > > > lts_hsw_se
> > > > > > > rver),
> > > > > > >       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &ra
> > > > > > > pl_d
> > > > > > > efau
> > > > > > > lts_hsw_se
> > > > > > > rver),
> > > > > > > +
> > > > > > > +     X86_MATCH_VENDOR_FAM(AMD, 0x17,
> > > > > > > &rapl_defaults_amd),
> > > > > > >       {}
> > > > > > >  };
> > > > > > >  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> > > > > > > diff --git a/drivers/powercap/intel_rapl_msr.c
> > > > > > > b/drivers/powercap/intel_rapl_msr.c
> > > > > > > index a819b3b89b2f..78213d4b5b16 100644
> > > > > > > --- a/drivers/powercap/intel_rapl_msr.c
> > > > > > > +++ b/drivers/powercap/intel_rapl_msr.c
> > > > > > > @@ -49,6 +49,14 @@ static struct rapl_if_priv
> > > > > > > rapl_msr_priv_intel
> > > > > > > = {
> > > > > > >       .limits[RAPL_DOMAIN_PLATFORM] = 2,
> > > > > > >  };
> > > > > > > 
> > > > > > > +static struct rapl_if_priv rapl_msr_priv_amd = {
> > > > > > > +     .reg_unit = MSR_AMD_RAPL_POWER_UNIT,
> > > > > > > +     .regs[RAPL_DOMAIN_PACKAGE] = {
> > > > > > > +             0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
> > > > > > > +     .regs[RAPL_DOMAIN_PP0] = {
> > > > > > > +             0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
> > > > > > > +};
> > > > > > > +
> > > > > > >  /* Handles CPU hotplug on multi-socket systems.
> > > > > > >   * If a CPU goes online as the first CPU of the physical
> > > > > > > package
> > > > > > >   * we add the RAPL package to the system. Similarly,
> > > > > > > when
> > > > > > > the
> > > > > > > last
> > > > > > > @@ -138,7 +146,17 @@ static int rapl_msr_probe(struct
> > > > > > > platform_device
> > > > > > > *pdev)
> > > > > > >       const struct x86_cpu_id *id =
> > > > > > > x86_match_cpu(pl4_support_ids);
> > > > > > >       int ret;
> > > > > > > 
> > > > > > > -     rapl_msr_priv = &rapl_msr_priv_intel;
> > > > > > > +     switch (boot_cpu_data.x86_vendor) {
> > > > > > > +     case X86_VENDOR_INTEL:
> > > > > > > +             rapl_msr_priv = &rapl_msr_priv_intel;
> > > > > > > +             break;
> > > > > > > +     case X86_VENDOR_AMD:
> > > > > > > +             rapl_msr_priv = &rapl_msr_priv_amd;
> > > > > > > +             break;
> > > > > > > +     default:
> > > > > > > +             pr_err("intel-rapl does not support CPU
> > > > > > > vendor
> > > > > > > %d\n",
> > > > > > > boot_cpu_data.x86_vendor);
> > > > > > > +             return -ENODEV;
> > > > > > > +     }
> > > > > > >       rapl_msr_priv->read_raw = rapl_msr_read_raw;
> > > > > > >       rapl_msr_priv->write_raw = rapl_msr_write_raw;
> > > > > > > 
> > > > > Best regards,
> > > > > Victor Ding
> > > Best regards,
> > > Victor Ding
> Best regards,
> Victor Ding

