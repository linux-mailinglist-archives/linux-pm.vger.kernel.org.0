Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23C3403271
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 04:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhIHCFv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 22:05:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:12808 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234035AbhIHCFu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Sep 2021 22:05:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="220418058"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="220418058"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 19:04:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="648304625"
Received: from sbhowmik-mobl.gar.corp.intel.com ([10.215.126.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 19:04:36 -0700
Message-ID: <7abae13c235d74f4789cd93c6c6b0cbf69df243d.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support
 in no-HWP mode
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 07 Sep 2021 19:04:33 -0700
In-Reply-To: <CAAYoRsVeMCivVBp-q_9N23BDOVvkc8ZLS3mubnz+4TREZ9Cz_A@mail.gmail.com>
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
         <20210513132051.31465-1-ggherdovich@suse.cz>
         <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
         <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz>
         <CAAYoRsX0xJf1mm1a_YUCzDy86r8q4QE98iVtS1AMLaUx+KTgQQ@mail.gmail.com>
         <CAAYoRsXK79PspEUh9pqgj2OGQnxQONkEeK-7af3=5frBzAqULQ@mail.gmail.com>
         <2a1b000cd101737400f6320ef18c0143d3a5145b.camel@linux.intel.com>
         <CAAYoRsVeMCivVBp-q_9N23BDOVvkc8ZLS3mubnz+4TREZ9Cz_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-09-07 at 13:16 -0700, Doug Smythies wrote:
> Hi Srinivas, Thank you for your reply.
> 
> On Tue, Sep 7, 2021 at 9:01 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Tue, 2021-09-07 at 08:45 -0700, Doug Smythies wrote:
> > > 
> > > Recent ASUS BIOS updates have changed the default system
> > > response for this old thread, rendering "intel_pstate=no_hwp"
> > > useless.
> > > 
> > > It also raises a question: If BIOS has forced HWP, then how do we
> > > prevent the acpi-cpufreq driver from being used? Read on.
> > 
> > Does BIOS has option to enable Intel speed shift with no legacy
> > support?
> > Then this option will not populate ACPI _PSS table.
> 
> The option is there no matter what.
> I have tried every variation of legacy or no legacy that
> I can find. Currently:
> Current boot mode:   UEFI Firmware mode
> SecureBoot:          disabled
> 
> > 
> > > 
> > > On Fri, May 14, 2021 at 3:12 PM Doug Smythies < 
> > > dsmythies@telus.net>
> > > wrote:
> > > > 
> > > > On Fri, May 14, 2021 at 1:33 PM Giovanni Gherdovich <
> > > > ggherdovich@suse.cz> wrote:
> > > > > On Fri, 2021-05-14 at 08:31 -0700, Doug Smythies wrote:
> > > ...
> > > > > 
> ...
> > > Previous correspondence was with BIOS version 1003. There have
> > > been 3
> > > BIOS
> > > releases since then (at least that I know of), 2103, 2201, 2301,
> > > and
> > > all of them
> > > have changed the behaviour of the "Auto" setting for Intel Speed
> > > Shift
> > > Technology BIOS setting, forcing it on upon transfer of control
> > > to
> > > the OS.
> > > 
> > > Where with "intel_pstate=no_hwp" one used to get 0 for
> > > MSR_PM_ENABLE
> > > (0x770) they now get 1.
> > 
> > So they are forcing Out of band OOB mode.
> > Does bit 8 or 18 in MSR 0x1aa is set?
> 
> No.

So there is no legacy path. I think you are working with their support.
In HWP mode does setting scaling min/max frequency has any impact?

Thanks,
Srinivas

> 
> Here is the output from my msr reader/decoder program.
> Kernel 5.14 (unpatched).
> intel_pstate=disable
> BIOS setting "Auto" for Intel Speed Shift,
> Driver: acpi-cpufreq
> 
> doug@s19:~$ sudo c/msr-decoder
> How many CPUs?: 12
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-11 :  45 :  45 :  45 :  45 :
> 45 :  45 :  45 :  45 :  45 :  45 :  45 :  45 :
> B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> 1.) 0x19C: IA32_THERM_STATUS: 88450000
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination
> enabled
> OOB Bit 8 reset OOB Bit 18 reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88410000
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO
> disable
> 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B2930 : high 48 :
> guaranteed 41 : efficient 11 : lowest 1
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-11 :
>     raw: 80003001 : 80003001 : 80003001 : 80003001 : 80003001 :
> 80003001 : 80003001 : 80003001 : 80003001 : 80003001 : 80003001 :
> 80003001 :
>     min:        1 :        1 :        1 :        1 :        1 :
> 1 :        1 :        1 :        1 :        1 :        1 :        1 :
>     max:       48 :       48 :       48 :       48 :       48 :
> 48 :       48 :       48 :       48 :       48 :       48 :       48
> :
>     des:        0 :        0 :        0 :        0 :        0 :
> 0 :        0 :        0 :        0 :        0 :        0 :        0 :
>     epp:      128 :      128 :      128 :      128 :      128 :
> 128 :      128 :      128 :      128 :      128 :      128 :      128
> :
>     act:        0 :        0 :        0 :        0 :        0 :
> 0 :        0 :        0 :        0 :        0 :        0 :        0 :
> 7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient 0 :
> lowest 0
> 
> ...
> 
> ... Doug


