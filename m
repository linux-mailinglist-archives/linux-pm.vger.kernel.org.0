Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB828B453
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbgJLMEq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 08:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbgJLMEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 08:04:46 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED8C0613D1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 05:04:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a7so17019396lfk.9
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 05:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QecOJJIpChCwDyXx3HayhiFszoIttsDqWMb62K2XmqE=;
        b=mvSuQPVzZtD44qEEOLFnSqqT2uyk2p6WL1sRgpJahbrMoLLbaFmiRoBCynpNmDrmt5
         OGNQvh6lyHfET6VlVcZXKmrgR858brB30H/mBHv95js+qWt880t8DMcNr5LnEYzIApH5
         cjNTOAuiUBtFohBkqK8lxqbb8OQsckz3dY+8dqYkStyyh2gVgSIelHYxJBQUJijotnyN
         urQ8rMmOTfYWpk5JYDkxcoEXizxa46me/21aUs7EDE5WQeU9Z1CZpaTx0+oP28lhnSpH
         y2ao0IiOT9yy5P+qjspb+rUj3nMCRAThdfypzYuPLcDxjyv7IptNXgiJVmh13Gfn1gGf
         lUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QecOJJIpChCwDyXx3HayhiFszoIttsDqWMb62K2XmqE=;
        b=YnB+FU9i8Oq7NF0WozR4s08NZhHYPq/0Ga6wLIY/LHccc7pOLTp/P7jq3LoAwdhoN8
         f6Ime20K2meMJXkf7AN5meKa2GhrRzx5JHljcEu36Zeqwozh1IJfgL2t2f9BG6aH9cgM
         1GExKTg03f0LWGzwYaWUW6ihLWu3MGWifujxQXMeKiae+x0a13trFQkmTuV8IGQsfNls
         OniKtd5E+VmdJN7KmTUO2La9xQkJmxT7QwBtqc4tjayoVgjy5opwp91m7XhZJ4nPqazb
         MTabgaEwwwPK+CaeQGCqi1AhZrHz4v2M2vpsQchvaRA78f7fo7sAVhIHl4lasX05tETA
         6D4w==
X-Gm-Message-State: AOAM532sw1LN8wf7obtUgvtOzxNFvRjiTbtuRXNPQauTAst3s6hdC5gS
        ZH8sXaHwgHTakyuqvO6yydha3nuPKVp9DHuFc4Afvg==
X-Google-Smtp-Source: ABdhPJzNAYTPNzgMXP+cKRSx4rvmcaCS0Ay1Ut0v/rTmNc/NEV0vIZyD97DqJ2NlfxLL1XpvZv8wYtz6sP8jxT0415g=
X-Received: by 2002:a19:c10:: with SMTP id 16mr7500143lfm.459.1602504283998;
 Mon, 12 Oct 2020 05:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201007161439.312534-1-kim.phillips@amd.com> <20201007161439.312534-4-kim.phillips@amd.com>
 <eb8dbbceb2252ebc36e3ed76f7a9efe1612ed2b7.camel@intel.com>
In-Reply-To: <eb8dbbceb2252ebc36e3ed76f7a9efe1612ed2b7.camel@intel.com>
From:   Victor Ding <victording@google.com>
Date:   Mon, 12 Oct 2020 23:04:08 +1100
Message-ID: <CANqTbdbeaZ6wtEVFiWHu9TCEMV4G36T9Tqf=C8nz89DPLq7t3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] powercap: Add AMD Fam17h RAPL support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 9, 2020 at 2:47 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Wed, 2020-10-07 at 11:14 -0500, Kim Phillips wrote:
> > From: Victor Ding <victording@google.com>
> >
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
> > Cc: Victor Ding <victording@google.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
> > Cc: LKML <linux-kernel@vger.kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: x86@kernel.org
> > ---
> > Kim's changes from Victor's original submission:
> >
> >
> https://lore.kernel.org/lkml/20200729205144.3.I01b89fb23d7498521c84cfdf417450cbbfca46bb@changeid/
> >
> >  - Added my Acked-by.
> >  - Added Daniel Lezcano to Cc.
> >
> >  arch/x86/include/asm/msr-index.h     |  1 +
> >  drivers/powercap/intel_rapl_common.c |  2 ++
> >  drivers/powercap/intel_rapl_msr.c    | 27
> > ++++++++++++++++++++++++++-
> >  3 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h
> > b/arch/x86/include/asm/msr-index.h
> > index f1b24f1b774d..c0646f69d2a5 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -324,6 +324,7 @@
> >  #define MSR_PP1_POLICY                       0x00000642
> >
> >  #define MSR_AMD_RAPL_POWER_UNIT              0xc0010299
> > +#define MSR_AMD_CORE_ENERGY_STATUS   0xc001029a
> >  #define MSR_AMD_PKG_ENERGY_STATUS    0xc001029b
> >
> >  /* Config TDP MSRs */
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 983d75bd5bd1..6905ccffcec3 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1054,6 +1054,8 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = {
> >
> >       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &rapl_defaults_hsw_se
> > rver),
> >       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &rapl_defaults_hsw_se
> > rver),
> > +
> > +     X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_core),
>
> I double if we can use rapl_defaults_core here.
>
> static const struct rapl_defaults rapl_defaults_core = {
>         .floor_freq_reg_addr = 0,
>         .check_unit = rapl_check_unit_core,
>         .set_floor_freq = set_floor_freq_default,
>         .compute_time_window = rapl_compute_time_window_core,
> };
>
>         .floor_freq_reg_addr = 0,
> is redundant here, even for rapl_defaults_core, we can remove it.
>
>         .check_unit = rapl_check_unit_core,
> the Intel UNIT MSR supports three units including Energy/Power/Time.
> From the change below, only the energy counter is supported, so you may
> need to confirm if all the three units are supported or not.
>
>         .set_floor_freq = set_floor_freq_default,this function sets PL1_CLAMP bit on RAPL_DOMAIN_REG_LIMIT, but RAPL_DOMAIN_REG_LIMIT is not supported on the AMD cpus.
>
>         .compute_time_window = rapl_compute_time_window_core,
> this is used for setting the power limits, which is not supported on
> the AMD cpus.
>
> IMO, it's better to use a new rapl_defaults that contains valid
> callbacks for AMD cpus.
Good point. The only reason why I proposed to re-use rapl_defaults_core was
that "check_unit" is the only function needed here, and it is the same
as Intel's.
The rest of callbacks are not used at all since setting the power limits is not
supported on AMD CPUs. Let's create a new callback for AMD. It should be like:
static const struct rapl_defaults rapl_defaults_amd = {
         .check_unit = rapl_check_unit_core,
};
The AMD UNIT MSR behaves the same as Intel's: [3:0] is Power Units, [12:8] is
Energy Status Units, and [19:16] is Time Units.
>
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> > diff --git a/drivers/powercap/intel_rapl_msr.c
> > b/drivers/powercap/intel_rapl_msr.c
> > index c68ef5e4e1c4..dcaef917f79d 100644
> > --- a/drivers/powercap/intel_rapl_msr.c
> > +++ b/drivers/powercap/intel_rapl_msr.c
> > @@ -48,6 +48,21 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
> >       .limits[RAPL_DOMAIN_PACKAGE] = 2,
> >  };
> >
> > +static struct rapl_if_priv rapl_msr_priv_amd = {
> > +     .reg_unit = MSR_AMD_RAPL_POWER_UNIT,
> > +     .regs[RAPL_DOMAIN_PACKAGE] = {
> > +             0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
> > +     .regs[RAPL_DOMAIN_PP0] = {
> > +             0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
> > +     .regs[RAPL_DOMAIN_PP1] = {
> > +             0, 0, 0, 0, 0 },
> > +     .regs[RAPL_DOMAIN_DRAM] = {
> > +             0, 0, 0, 0, 0 },
> > +     .regs[RAPL_DOMAIN_PLATFORM] = {
> > +             0, 0, 0, 0, 0},
>
> I don't think you need to set the PP1/DRAM/PLATFORM registers to 0 explicitly if they are not supported.
Good suggestion. Let's remove the zeros.
>
> > +     .limits[RAPL_DOMAIN_PACKAGE] = 1,
>
>
> Is Pkg Domain PL1 really supported?
> At least according to this patch, I don't think so. So if power limit
> is supported, it is better to add the support in this patch altogether.
>
> If no, we're actually exposing energy counters only. If this is the
> case, I'm not sure if it is proper to do this in powercap class because
> we can not do powercap actually. Or at least, if we want to support
> power zones with no power limits, we should enhance the code to
> support this rather than fake a power limit.
>
Correct, this is solely to expose energy counters. Many existing tools
are built on
top of powercap's sysfs to query energy counters, even though they don't set the
power limit. Exposing the energy counters through the same powercap interface
allows these tools built for Intel run seamlessly on AMD. Hence, I
believe powercap
is the best place to expose AMD's energy counters.

I like your idea of enhancing the code to avoid using a fake power
limit. I'll make
the update.
> thanks,
> rui
> > +};
> > +
> >  /* Handles CPU hotplug on multi-socket systems.
> >   * If a CPU goes online as the first CPU of the physical package
> >   * we add the RAPL package to the system. Similarly, when the last
> > @@ -137,7 +152,17 @@ static int rapl_msr_probe(struct platform_device
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
>
>
> IF
>
>
>
Best regards,
Victor Ding
