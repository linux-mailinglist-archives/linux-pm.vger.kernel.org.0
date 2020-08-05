Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C6723C94E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 11:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgHEJgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 05:36:16 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:43448 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHEJfG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 05:35:06 -0400
Received: by mail-oo1-f65.google.com with SMTP id z10so5766186ooi.10;
        Wed, 05 Aug 2020 02:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cknFGMTHisqsJ8S6a0tn2BBuzfV98+CKybYSpiI5/Z8=;
        b=uQ/GtYm2wYfAJW4o6/v5aNBcOXsxUgY+OY8B/HCQCW9p1xCBdvpreOPlRLneKQuFX8
         yjyTudK1CNVfBYOedNV5peUiE5XM2sv//UXE+rgFd70ifU0LACDSeWGFKvzgaNVYYyd8
         Fa0cuFqsmWluaZOkvwBsJ+pkfhMLuYeWrjyD5a29f/0453H0crgECSHnMWU/i+u/73wM
         xdzuycImOz4EbYT+CpGoX3kF7WaqT998Bpu/pLEJvZ3i7PPbb+GxQTUS2hRkgTpAh1sJ
         p58OrQ2Q4yguCdc/3l1scZsGADZ70xvyoxun5ifMjdWNMw+JtV+yUfYto0b2nkOblH7T
         nGBg==
X-Gm-Message-State: AOAM532+7/06yNyVnWi24XFYm+8GSc85JwgQA4Q/mIjKLsHJOZXwm6Sv
        fjnmuqo5bi7DQMCDLoPEM1F0WS/jcbajvymk2MI=
X-Google-Smtp-Source: ABdhPJyTS26vEw4LN0WnWkbY3aT8Hdud9gu0wLYWUVxubNL4SszBhzLEfpxTiNiAOzfdqJ5v4qGyJstA37wfGE/DuYY=
X-Received: by 2002:a4a:d62c:: with SMTP id n12mr1966554oon.38.1596620105003;
 Wed, 05 Aug 2020 02:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
 <1633168.eVXp6ieOpF@kreacher> <000d01d66a81$59326a50$0b973ef0$@net>
In-Reply-To: <000d01d66a81$59326a50$0b973ef0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Aug 2020 11:34:51 +0200
Message-ID: <CAJZ5v0h7iKvO1-9R_JiVjM8j_a87B=LpTCoaUWRfrhXTRaMMOw@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Implement passive mode with HWP enabled
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

On Tue, Aug 4, 2020 at 7:07 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> I was just writing you about V5 when this V6 came.
>
> On 2020.08.04 08:11 Rafael J. Wysocki wrote:
> ...
> > This is on top of the material already in the mainline.
>
> Oh, should have read that part better,
> but did get there in the end.
> ...
> > v5 -> v6:
> >    * Fix the problem with the EPP setting via sysfs not working with the
> >      performance and powersave governors by stopping and restarting the
> >      governor around the sysfs-based EPP updates in the passive mode.
> >    * Because of that, use the epp_cached field just for avoiding the above
> >      if the new EPP value for the given CPU is the same as the old one.
> >    * Export cpufreq_start/stop_governor() from the core (for the above).
>
> EPP is still not right.
> I am not messing with it at all, just observing via my msr-decoder.

If you are not touching it, then it should not change in the passive mode.

> I booted without any intel_pstate related directives for the
> kernel command line. The below is as expected (performance gov.):

Note that the active mode performance scaling algorithm (which is not
the same as the performance cpufreq governor) sets the EPP to 0 for
all of the CPUs that it is used with and the driver sets the EPP to
255 in ->stop_cpu.

That last bit is questionable, but that's the active mode behavior
which is not changed by the $subject patch.

It would be more reasonable to restore the previous EPP when stopping
CPUs.  Let me cut a v7 with that changed.

> # /home/doug/c/msr-decoder
> How many CPUs?: 6
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
> B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> 1.) 0x19C: IA32_THERM_STATUS: 88450000
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88430000
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable
> 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 109252E : high 46 : guaranteed 37 : efficient 9 : lowest 1
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
>     raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
>     min:       46 :       46 :       46 :       46 :       46 :       46 :
>     max:       46 :       46 :       46 :       46 :       46 :       46 :
>     des:        0 :        0 :        0 :        0 :        0 :        0 :
>     epp:        0 :        0 :        0 :        0 :        0 :        0 :
>     act:        0 :        0 :        0 :        0 :        0 :        0 :
> 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0
>
> and then switched to passive mode later. EPP is not as expected. Expect 0
> (performance mode):
>
> # /home/doug/c/msr-decoder
> How many CPUs?: 6
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
> B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> 1.) 0x19C: IA32_THERM_STATUS: 88440000
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88420000
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable
> 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 : lowest 1
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
>     raw: FF002E2E : FF002E2E : FF002E2E : FF002E2E : FF002E2E : FF002E2E :
>     min:       46 :       46 :       46 :       46 :       46 :       46 :
>     max:       46 :       46 :       46 :       46 :       46 :       46 :
>     des:        0 :        0 :        0 :        0 :        0 :        0 :
>     epp:      255 :      255 :      255 :      255 :      255 :      255 :
>     act:        0 :        0 :        0 :        0 :        0 :        0 :
> 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0

The 0xFF EPP value is what the active mode left behind and the passive
mode doesn't touch the EPP at all.

> Then switched to ondemand governor, and put 100% load on 2 CPUs.
> EPP is not as expected, which I don't actually know what to expect,
> but assume 128:
>
> # /home/doug/c/msr-decoder
> How many CPUs?: 6
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
> B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> 1.) 0x19C: IA32_THERM_STATUS: 883B0000
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 882B0000
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable
> 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B252E : high 46 : guaranteed 37 : efficient 11 : lowest 1
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
>     raw: FF002E09 : FF002E0C : FF002E2E : FF002E08 : FF002E2E : FF002E18 :
>     min:        9 :       12 :       46 :        8 :       46 :       24 :
>     max:       46 :       46 :       46 :       46 :       46 :       46 :
>     des:        0 :        0 :        0 :        0 :        0 :        0 :
>     epp:      255 :      255 :      255 :      255 :      255 :      255 :
>     act:        0 :        0 :        0 :        0 :        0 :        0 :
> 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0

It is still 0xFF as previously (because the passive mode doesn't
change the EPP).

> For what it's worth, Kernel:
>
> 78b39581ed85 (HEAD -> dtemp) cpufreq: intel_pstate: Implement passive mode with HWP enabled
> c0842fbc1b18 (origin/master, origin/HEAD, master) random32: move the pseudo-random 32-bit definitions to prandom.h
> 2baa85d6927d Merge tag 'acpi-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> 04084978003c Merge tag 'pm-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

Thanks!
