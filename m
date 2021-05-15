Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A4D381550
	for <lists+linux-pm@lfdr.de>; Sat, 15 May 2021 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhEODAF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 23:00:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:15292 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233403AbhEODAE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 May 2021 23:00:04 -0400
IronPort-SDR: rQUfj7w0pAHqEJMQhhusUoU0iVLKi4UZCbNbmXV2vdW3OFqbOxEJki9o7LgEW62SXA6PYmPmOG
 vWnhMlfAQY3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="180537404"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="180537404"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 19:58:51 -0700
IronPort-SDR: VXzZ3SCPs+Y7YKF088pl1NPvhoQzjEM7/QokYfHpS0S9eGDOOQZCWm7vsmbUBBGkiv9QuoZ4u8
 l+irjt/gKC2g==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="627540951"
Received: from blegette-mobl1.amr.corp.intel.com ([10.209.146.134])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 19:58:48 -0700
Message-ID: <214234be04103c37c09e4c1cdbcea4b4093e5aaf.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support
 in no-HWP mode
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 14 May 2021 19:58:44 -0700
In-Reply-To: <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz>
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
         <20210513132051.31465-1-ggherdovich@suse.cz>
         <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
         <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-05-14 at 22:33 +0200, Giovanni Gherdovich wrote:
> On Fri, 2021-05-14 at 08:31 -0700, Doug Smythies wrote:
> > Hi All,
> > 
> > Can I on-board to this patch or do you want me to submit another?
> > I want to add COMETLAKE (tested), as below:
> > 
> > ... Doug
> 
> Hello Doug!
> 
> Wait, why you don't want to use HWP? It's such a fantastic
> technology!
> 
> :) I'm just teasing you.
> 
> More seriously: 
> 
> when COMETLAKE is not in that list, can you confirm that if you go
> into the
> BIOS config at boot, and disable HWP from there, then intel_pstate
> does *not* load?
> 
> Does it say "intel_pstate: CPU model not supported" in the dmesg log?
> 
> The control may be somewhere around "power mangement" in the BIOS
> config, and
> may be called "Enable/disable Intel Speed Shift".
> 
> I'm asking because I've just checked on two Dell laptops, one Skylake
> and the
> other Kabylake, and the menu is there in the BIOS config to disable
> HWP,
> but if I disable it... nothing happens. "lscpu" shows all the hwp
> flags as usual:
> 
>     # lscpu | grep Flags | tr ' ' '\n' | grep hwp
>     hwp
>     hwp_notify
>     hwp_act_window
>     hwp_epp
> 
> and turbostat gives me:
> 
>     # turbostat -Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
>     cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
> 
> Which is to say, on the Intel client machines I have, the firmware
> doesn't
> seem to be able to hide HWP from the OS. Buggy BIOS? Maybe, the fact
> of the
> matter is, I wouldn't need to add, say, KABYLAKE to that list, based
> on my
> experience.

When you disable in BIOS on these systems, it just hides HWP control
via ACPI CPC table. It doesn't disable HWP CPU feature.

Thanks,
Srinivas

> 
> The other side of the issue is that, from my understanding, the
> preferred/supported way to disable HWP is to boot with
> intel_pstate=no_hwp,
> and that list is a sort of "known exceptions" that people really
> can't live
> without (it's mostly server CPUs, and mostly because of unfortunate
> firmware
> defaults). Otherwise you'd see the entire intel-family.h file in
> there.
> 
> 
> Cheers,
> Giovanni
> 
> > 
> > On Thu, May 13, 2021 at 6:21 AM Giovanni Gherdovich <
> > ggherdovich@suse.cz> wrote:
> > > Users may disable HWP in firmware, in which case intel_pstate
> > > wouldn't load
> > > unless the CPU model is explicitly supported.
> > > 
> > > Add ICELAKE_X to the list of CPUs that can register intel_pstate
> > > while not
> > > advertising the HWP capability. Without this change, an ICELAKE_X
> > > in no-HWP
> > > mode could only use the acpi_cpufreq frequency scaling driver.
> > > 
> > > See also commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake
> > > servers
> > > support").
> > > 
> > > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > > ---
> > > This replaces 
> > > https://lore.kernel.org/lkml/20210513075930.22657-1-ggherdovich@suse.cz
> > > 
> > >  drivers/cpufreq/intel_pstate.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index f0401064d7aa..28c9733e0dce 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2087,6 +2087,7 @@ static const struct x86_cpu_id
> > > intel_pstate_cpu_ids[] = {
> > >         X86_MATCH(ATOM_GOLDMONT,        core_funcs),
> > >         X86_MATCH(ATOM_GOLDMONT_PLUS,   core_funcs),
> > >         X86_MATCH(SKYLAKE_X,            core_funcs),
> > > +       X86_MATCH(ICELAKE_X,            core_funcs),
> >    +       X86_MATCH(COMETLAKE,          core_funcs),
> > >         {}
> > >  };
> > >  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> > > --
> > > 2.26.2
> > > 
> 


