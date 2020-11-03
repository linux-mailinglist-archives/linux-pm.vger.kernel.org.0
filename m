Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6342A3CA3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 07:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKCGLO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 01:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCGLM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 01:11:12 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D273C0617A6
        for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2020 22:11:10 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id x6so17737315ljd.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2020 22:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlIW8z0X5obg8vY4Xweuvljds78GDZMW+dPPxgR/ULk=;
        b=l7rQui6867KkA5Jv404JKXa49WHr5vXi4MuUhmhn8CP6fquIGXUPtMxmK2CbbdivsA
         Efayq7GWAeSvgLCffCTBRpc4k+iEfZNSqPY18wxE1xlOH9BOWOftqS0+dIVSsJQeiZqS
         DIWyPP2bmh8vfMDx9ATsTEqxoQU8czxI1YE4C20F17eo6dRMAOVi79o5YBDutvHSR6oo
         HqmlBTqjY1SNqW2cDZrhQmYnMG1qWnpj2+73RHKwCrJZTzYqkSA2idS//uL151G2S5rG
         OzeU55Pl4UCg1j9Nb0w1yiJyh7QFFjHApMqN0FUVj8o6BXu5KYiAbvchg0SCZhBOZdhh
         zb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlIW8z0X5obg8vY4Xweuvljds78GDZMW+dPPxgR/ULk=;
        b=m+CUQms5z+ivfT6EWz0Cx/dypfmvwOWHo+F17CMaePkAsEOC8EaZP3Sx7OOBOHoUqk
         BIXuNlabRxfujYIOSEw0m0lDxWS/zkQMU01Z1MGQ/1Ud6BqmYapBB2qcXPmLFiRI0zbD
         ZqAxhCRSNb+PJC4v7aEqTPJFeyDma5ajHqpWo6CbF2aMSYF+HT06AwZ5dTcycKktbo69
         qvT0JILUonWkcnONteUaNGKM/oargrxwuR8fl97CAejOQQTzhJDz3qohJYJvXzzkqBR3
         YI6nqbDUFT4vqVMaH+S+8kt+udyfUpRVHgpAzL1FTRgWXsxCgx7bJmKpNfWIVFQGRFtv
         pFXw==
X-Gm-Message-State: AOAM531pL3+WEqvkXI3JZy6f+EC4Jpz+gxHzoAcs4h5mJQ4ZqCawEdeo
        HS31nCZ13ATS/39ncm9keoxAaUSEhmT/l3oj6zllrg==
X-Google-Smtp-Source: ABdhPJyqXiabHGV0nyB3mVAo47citVp1NM6i7upi/RVPAxK6kr1iHCrs33ojqy6ahi0HiiQaTznR3O023TCLl1IpOOs=
X-Received: by 2002:a2e:9148:: with SMTP id q8mr8466857ljg.182.1604383868544;
 Mon, 02 Nov 2020 22:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20201027072358.13725-1-victording@google.com> <20201027072358.13725-4-victording@google.com>
 <82f3070691438d3f651d2e5e5fb5499131cdbd15.camel@intel.com>
In-Reply-To: <82f3070691438d3f651d2e5e5fb5499131cdbd15.camel@intel.com>
From:   Victor Ding <victording@google.com>
Date:   Tue, 3 Nov 2020 17:10:32 +1100
Message-ID: <CANqTbdaB8Mv+ij2rdprC_=JUt49A_V12-T5TbyidNktah575rw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] powercap: Add AMD Fam17h RAPL support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 2, 2020 at 12:39 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Tue, 2020-10-27 at 07:23 +0000, Victor Ding wrote:
> > This patch enables AMD Fam17h RAPL support for the power capping
> > framework. The support is as per AMD Fam17h Model31h (Zen2) and
> > model 00-ffh (Zen1) PPR.
> >
> > Tested by comparing the results of following two sysfs entries and
> > the
> > values directly read from corresponding MSRs via /dev/cpu/[x]/msr:
> >   /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
> >   /sys/class/powercap/intel-rapl/intel-rapl:0/intel-
> > rapl:0:0/energy_uj
> >
> > Signed-off-by: Victor Ding <victording@google.com>
> > Acked-by: Kim Phillips <kim.phillips@amd.com>
> >
> >
> > ---
> >
> > Changes in v3:
> > By Victor Ding <victording@google.com>
> >  - Rebased to the latest code.
> >  - Created a new rapl_defaults for AMD CPUs.
> >  - Removed redundant setting to zeros.
> >  - Stopped using the fake power limit domain 1.
> >
> > Changes in v2:
> > By Kim Phillips <kim.phillips@amd.com>:
> >  - Added Kim's Acked-by.
> >  - Added Daniel Lezcano to Cc.
> >  - (No code change).
> >
> >  arch/x86/include/asm/msr-index.h     |  1 +
> >  drivers/powercap/intel_rapl_common.c |  6 ++++++
> >  drivers/powercap/intel_rapl_msr.c    | 20 +++++++++++++++++++-
> >  3 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h
> > b/arch/x86/include/asm/msr-index.h
> > index 21917e134ad4..c36a083c8ec0 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -327,6 +327,7 @@
> >  #define MSR_PP1_POLICY                       0x00000642
> >
> >  #define MSR_AMD_RAPL_POWER_UNIT              0xc0010299
> > +#define MSR_AMD_CORE_ENERGY_STATUS           0xc001029a
> >  #define MSR_AMD_PKG_ENERGY_STATUS    0xc001029b
> >
> >  /* Config TDP MSRs */
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 0b2830efc574..bedd780bed12 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1011,6 +1011,10 @@ static const struct rapl_defaults
> > rapl_defaults_cht = {
> >       .compute_time_window = rapl_compute_time_window_atom,
> >  };
> >
> > +static const struct rapl_defaults rapl_defaults_amd = {
> > +     .check_unit = rapl_check_unit_core,
> > +};
> > +
>
> why do we need power_unit and time_unit if we only want to expose the
> energy counter?
AMD's Power Unit MSR provides identical information as Intel's, including
time units, power units, and energy status units. By reusing the check unit
method, we could avoid code duplication as well as easing future enhance-
ment when AMD starts to support power limits.
>
> Plus, in rapl_init_domains(), PL1 is enabled for every RAPL Domain
> blindly, I'm not sure how this is handled on the AMD CPUs.
> Is PL1 invalidated by rapl_detect_powerlimit()? or is it still
> registered as a valid constraint into powercap sysfs I/F?
AMD's CORE_ENERGY_STAT MSR is like Intel's PP0_ENERGY_STATUS;
therefore, PL1 also always exists on AMD. rapl_detect_powerlimit() correctly
markes the domain as monitoring-only after finding power limit MSRs do not
exist.
>
> Currently, the code makes the assumption that there is only on power
> limit if priv->limits[domain_id] not set, we probably need to change
> this if we want to support RAPL domains with no power limit.
The existing code already supports RAPL domains with no power limit: PL1 is
enabled when there is zero or one power limit,
rapl_detect_powerlimit() will then
mark if PL1 is monitoring-only if power limit MSRs do not exist. Both AMD's RAPL
domains are monitoring-only and are correctly marked and handled.
>
> thanks,
> rui
> >  static const struct x86_cpu_id rapl_ids[] __initconst = {
> >       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,         &rapl_default
> > s_core),
> >       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,       &rapl_defaults_core),
> > @@ -1061,6 +1065,8 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = {
> >
> >       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &rapl_defaults_hsw_se
> > rver),
> >       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &rapl_defaults_hsw_se
> > rver),
> > +
> > +     X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> > diff --git a/drivers/powercap/intel_rapl_msr.c
> > b/drivers/powercap/intel_rapl_msr.c
> > index a819b3b89b2f..78213d4b5b16 100644
> > --- a/drivers/powercap/intel_rapl_msr.c
> > +++ b/drivers/powercap/intel_rapl_msr.c
> > @@ -49,6 +49,14 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
> >       .limits[RAPL_DOMAIN_PLATFORM] = 2,
> >  };
> >
> > +static struct rapl_if_priv rapl_msr_priv_amd = {
> > +     .reg_unit = MSR_AMD_RAPL_POWER_UNIT,
> > +     .regs[RAPL_DOMAIN_PACKAGE] = {
> > +             0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
> > +     .regs[RAPL_DOMAIN_PP0] = {
> > +             0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
> > +};
> > +
> >  /* Handles CPU hotplug on multi-socket systems.
> >   * If a CPU goes online as the first CPU of the physical package
> >   * we add the RAPL package to the system. Similarly, when the last
> > @@ -138,7 +146,17 @@ static int rapl_msr_probe(struct platform_device
> > *pdev)
> >       const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
> >       int ret;
> >
> > -     rapl_msr_priv = &rapl_msr_priv_intel;
> > +     switch (boot_cpu_data.x86_vendor) {
> > +     case X86_VENDOR_INTEL:
> > +             rapl_msr_priv = &rapl_msr_priv_intel;
> > +             break;
> > +     case X86_VENDOR_AMD:
> > +             rapl_msr_priv = &rapl_msr_priv_amd;
> > +             break;
> > +     default:
> > +             pr_err("intel-rapl does not support CPU vendor %d\n",
> > boot_cpu_data.x86_vendor);
> > +             return -ENODEV;
> > +     }
> >       rapl_msr_priv->read_raw = rapl_msr_read_raw;
> >       rapl_msr_priv->write_raw = rapl_msr_write_raw;
> >
>
Best regards,
Victor Ding
