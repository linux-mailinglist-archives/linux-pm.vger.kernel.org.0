Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3637123D1F2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 22:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHEUHg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 16:07:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:36483 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHEQct (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:49 -0400
IronPort-SDR: cO53RICv57qCwELtiH/zh+D2/S6HjMZiP4bdo4uKKUKCfcLAG4lmfR96POX2ZSqAHHE6cqoe0y
 ZOrK2b055m5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132130292"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="132130292"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 08:38:35 -0700
IronPort-SDR: MwVnVtrt2C/tx36d2PVYk25mSy9GxpN5a4ohnlQ3Xoy1t4nBLUNEc8FID0RYyEZq1ZbKFg2d1P
 Gn7p7mtkaXDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="467506418"
Received: from aavinash-mobl.amr.corp.intel.com ([10.212.76.184])
  by orsmga005.jf.intel.com with ESMTP; 05 Aug 2020 08:38:33 -0700
Message-ID: <ff21e71060b589219c21b46b5e26b6c3aca9f951.camel@linux.intel.com>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Implement passive mode with
 HWP enabled
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 05 Aug 2020 08:38:33 -0700
In-Reply-To: <CAJZ5v0h7iKvO1-9R_JiVjM8j_a87B=LpTCoaUWRfrhXTRaMMOw@mail.gmail.com>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
         <1633168.eVXp6ieOpF@kreacher> <000d01d66a81$59326a50$0b973ef0$@net>
         <CAJZ5v0h7iKvO1-9R_JiVjM8j_a87B=LpTCoaUWRfrhXTRaMMOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-05 at 11:34 +0200, Rafael J. Wysocki wrote:
> Hi Doug,
> 
> On Tue, Aug 4, 2020 at 7:07 PM Doug Smythies <dsmythies@telus.net>
> wrote:
> > Hi Rafael,
> > 
> > 
[...]

> Note that the active mode performance scaling algorithm (which is not
> the same as the performance cpufreq governor) sets the EPP to 0 for
> all of the CPUs that it is used with and the driver sets the EPP to
> 255 in ->stop_cpu.
> 
> That last bit is questionable, but that's the active mode behavior
> which is not changed by the $subject patch.
You need to set the CPU which is going offline to the lowest perf
settings. If not its sibling's performance can never be lowered than
offlined CPUs max/min/epp.

Thanks,
Srinivas


> 
> It would be more reasonable to restore the previous EPP when stopping
> CPUs.  Let me cut a v7 with that changed.
> 
> > # /home/doug/c/msr-decoder
> > How many CPUs?: 6
> > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46
> > :  46 :  46 :
> > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > 1.) 0x19C: IA32_THERM_STATUS: 88450000
> > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination
> > enabled OOB Bit 8 reset OOB Bit 18 reset
> > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88430000
> > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO
> > disable
> > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 109252E : high 46 :
> > guaranteed 37 : efficient 9 : lowest 1
> > 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
> >     raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
> > 00002E2E :
> >     min:       46 :       46 :       46 :       46 :       46
> > :       46 :
> >     max:       46 :       46 :       46 :       46 :       46
> > :       46 :
> >     des:        0 :        0 :        0 :        0 :        0
> > :        0 :
> >     epp:        0 :        0 :        0 :        0 :        0
> > :        0 :
> >     act:        0 :        0 :        0 :        0 :        0
> > :        0 :
> > 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0
> > : lowest 0
> > 
> > and then switched to passive mode later. EPP is not as expected.
> > Expect 0
> > (performance mode):
> > 
> > # /home/doug/c/msr-decoder
> > How many CPUs?: 6
> > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46
> > :  46 :  46 :
> > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > 1.) 0x19C: IA32_THERM_STATUS: 88440000
> > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination
> > enabled OOB Bit 8 reset OOB Bit 18 reset
> > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88420000
> > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO
> > disable
> > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 :
> > guaranteed 37 : efficient 8 : lowest 1
> > 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
> >     raw: FF002E2E : FF002E2E : FF002E2E : FF002E2E : FF002E2E :
> > FF002E2E :
> >     min:       46 :       46 :       46 :       46 :       46
> > :       46 :
> >     max:       46 :       46 :       46 :       46 :       46
> > :       46 :
> >     des:        0 :        0 :        0 :        0 :        0
> > :        0 :
> >     epp:      255 :      255 :      255 :      255 :      255
> > :      255 :
> >     act:        0 :        0 :        0 :        0 :        0
> > :        0 :
> > 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0
> > : lowest 0
> 
> The 0xFF EPP value is what the active mode left behind and the
> passive
> mode doesn't touch the EPP at all.
> 
> > Then switched to ondemand governor, and put 100% load on 2 CPUs.
> > EPP is not as expected, which I don't actually know what to expect,
> > but assume 128:
> > 
> > # /home/doug/c/msr-decoder
> > How many CPUs?: 6
> > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46
> > :  46 :  46 :
> > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > 1.) 0x19C: IA32_THERM_STATUS: 883B0000
> > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination
> > enabled OOB Bit 8 reset OOB Bit 18 reset
> > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 882B0000
> > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO
> > disable
> > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B252E : high 46 :
> > guaranteed 37 : efficient 11 : lowest 1
> > 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
> >     raw: FF002E09 : FF002E0C : FF002E2E : FF002E08 : FF002E2E :
> > FF002E18 :
> >     min:        9 :       12 :       46 :        8 :       46
> > :       24 :
> >     max:       46 :       46 :       46 :       46 :       46
> > :       46 :
> >     des:        0 :        0 :        0 :        0 :        0
> > :        0 :
> >     epp:      255 :      255 :      255 :      255 :      255
> > :      255 :
> >     act:        0 :        0 :        0 :        0 :        0
> > :        0 :
> > 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0
> > : lowest 0
> 
> It is still 0xFF as previously (because the passive mode doesn't
> change the EPP).
> 
> > For what it's worth, Kernel:
> > 
> > 78b39581ed85 (HEAD -> dtemp) cpufreq: intel_pstate: Implement
> > passive mode with HWP enabled
> > c0842fbc1b18 (origin/master, origin/HEAD, master) random32: move
> > the pseudo-random 32-bit definitions to prandom.h
> > 2baa85d6927d Merge tag 'acpi-5.9-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> > 04084978003c Merge tag 'pm-5.9-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> 
> Thanks!

