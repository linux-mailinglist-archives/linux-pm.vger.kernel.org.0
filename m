Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9BE21A97A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 23:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgGIVBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 17:01:19 -0400
Received: from cmta17.telus.net ([209.171.16.90]:40954 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgGIVBS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jul 2020 17:01:18 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id tdfMjniArYgvrtdfNjUXWn; Thu, 09 Jul 2020 15:01:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1594328475; bh=DO1Bu4NVVoKXFJHl4WRTu15YNf8zO2Urudde2JxqiC8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=C4zOU/O3yx44XMRv35z8PHjCaLmnD5r7pb88Sto4Ohe6KkEz+xdWC0tEfu59EuTZ4
         +diYDwHvSuLSOZCytzGQxWM0mF9jSqYtcoks+x+nmXiwEEAQ2cEYrNlMknVAp//RGw
         O0ovoppc+NTt5gxX33LQvy8TD/HqBdSFsfpc6pr8bZpZjZd6sKyqIwi5YfG5x2ta/u
         mMG9in4vpqPNdtc2fj4w6l4KXR0G2t7AeI6wQs5ZGCGi4ojlHK6MLN0fXIADAB3wIs
         /HZE1e7nXJswRBAiFfn8/a6zj7L1BrACM5Ilawc27Gvbw+F8rKm2qAtz93n8eK5CjA
         gx/hcxJyquWJg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=MIQeZ/Rl c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=zMdRSeC2V0WUCyk-5DIA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2016232.ihCVsphvri@kreacher> <2988949.NgUrjYMkJj@kreacher>
In-Reply-To: <2988949.NgUrjYMkJj@kreacher>
Subject: RE: [PATCH 2/2] cpufreq: intel_pstate: Use passive mode by default without HWP
Date:   Thu, 9 Jul 2020 14:01:11 -0700
Message-ID: <000801d65634$14f0ecb0$3ed2c610$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYFAJargBggJ0TwR7qfhutpuszfMhRKzmYA
X-CMAE-Envelope: MS4wfFH9BkYFuVxjO56y8+N3Ib/kkgigvoFuwtSboGqrttZaQE488zlSPJzRQlPGcCGGuMCEUEQKYGj6fkyXedT/ukZxD254yCs1DavUvyWAy2689+fu9Lgj
 m3xHlM7CKmH1BAylD5dLGXco8HrI9ri/eQd1b1zPmAjeIOqOUAJU7hO+iORuwlvSjdcPLFCtRjklPfgXSlzm94m+FdJatqbEcKqXD3WsKrBpI/DjJoDGZY+M
 bD8FK+YAn8mU4dat+RRr0zNVN6hgJco1iyMN5G2SZT1n24wpJe1+0kMDowY0EzTPPHUAbCrb5DCzsr+QM889C5yOuQMMYcQKgtPPv1MKgaLmY6EIYDHwuL6C
 ubMbIIqg5MmPsCX05i0anDYokXSPiA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

As you may or may not recall, I am attempting to untangle
and separate multiple compounding issues around the
intel_pstate driver and HWP (or not).

Until everything is figured out, I am using the following rules:

. never use x86_energy_perf_policy.
. For HWP disabled: never change from active to passive or via versa, but rather do it via boot.
. after boot always check and reset the various power limit log bits that are set.
. never compile the kernel (well, until after any tests), which will set those bits again.
. never run prime95 high heat torture test, which will set those bits again.
. try to never do anything else that will set those bits again.

On 2020.03.28 05:58 Rafael J. Wysocki wrote:
> 
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> After recent changes allowing scale-invariant utilization to be
> used on x86, the schedutil governor on top of intel_pstate in the
> passive mode should be on par with (or better than) the active mode
> "powersave" algorithm of intel_pstate on systems in which
> hardware-managed P-states (HWP) are not used, so it should not be
> necessary to use the internal scaling algorithm in those cases.
> 
> Accordingly, modify intel_pstate to start in the passive mode by
> default if the processor at hand does not support HWP of if the driver
> is requested to avoid using HWP through the kernel command line.
> 
> Among other things, that will allow utilization clamps and the
> support for RT/DL tasks in the schedutil governor to be utilized on
> systems in which intel_pstate is used.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst | 32 ++++++++++++++++-----------
>  drivers/cpufreq/intel_pstate.c                |  3 ++-
>  2 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-
> guide/pm/intel_pstate.rst
> index ad392f3aee06..39d80bc29ccd 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -62,9 +62,10 @@ on the capabilities of the processor.
>  Active Mode
>  -----------
> 
> -This is the default operation mode of ``intel_pstate``.  If it works in this
> -mode, the ``scaling_driver`` policy attribute in ``sysfs`` for all ``CPUFreq``
> -policies contains the string "intel_pstate".
> +This is the default operation mode of ``intel_pstate`` for processors with
> +hardware-managed P-states (HWP) support.  If it works in this mode, the
> +``scaling_driver`` policy attribute in ``sysfs`` for all ``CPUFreq`` policies
> +contains the string "intel_pstate".
> 
>  In this mode the driver bypasses the scaling governors layer of ``CPUFreq`` and
>  provides its own scaling algorithms for P-state selection.  Those algorithms
> @@ -138,12 +139,13 @@ internal P-state selection logic to be less performance-focused.
>  Active Mode Without HWP
>  ~~~~~~~~~~~~~~~~~~~~~~~
> 
> -This is the default operation mode for processors that do not support the HWP
> -feature.  It also is used by default with the ``intel_pstate=no_hwp`` argument
> -in the kernel command line.  However, in this mode ``intel_pstate`` may refuse
> -to work with the given processor if it does not recognize it.  [Note that
> -``intel_pstate`` will never refuse to work with any processor with the HWP
> -feature enabled.]
> +This operation mode is optional for processors that do not support the HWP
> +feature or when the ``intel_pstate=no_hwp`` argument is passed to the kernel in
> +the command line.  The active mode is used in those cases if the
> +``intel_pstate=active`` argument is passed to the kernel in the command line.

???
I can not see anywhere in the code where the kernel command line argument
"intel_pstate=active" is dealt with.

> +In this mode ``intel_pstate`` may refuse to work with processors that are not
> +recognized by it.  [Note that ``intel_pstate`` will never refuse to work with
> +any processor with the HWP feature enabled.]
> 
>  In this mode ``intel_pstate`` registers utilization update callbacks with the
>  CPU scheduler in order to run a P-state selection algorithm, either
> @@ -188,10 +190,14 @@ is not set.
>  Passive Mode
>  ------------
> 
> -This mode is used if the ``intel_pstate=passive`` argument is passed to the
> -kernel in the command line (it implies the ``intel_pstate=no_hwp`` setting too).
> -Like in the active mode without HWP support, in this mode ``intel_pstate`` may
> -refuse to work with the given processor if it does not recognize it.
> +This is the default operation mode of ``intel_pstate`` for processors without
> +hardware-managed P-states (HWP) support.  It is always used if the
> +``intel_pstate=passive`` argument is passed to the kernel in the command line
> +regardless of whether or not the given processor supports HWP.  [Note that the
> +``intel_pstate=no_hwp`` setting implies ``intel_pstate=passive`` if it is used
> +without ``intel_pstate=active``.]

??? as above. I can not see where intel_pstate=active is dealt with in 
the code.

> Like in the active mode without HWP support,
> +in this mode ``intel_pstate`` may refuse to work with processors that are not
> +recognized by it.
> 
>  If the driver works in this mode, the ``scaling_driver`` policy attribute in
>  ``sysfs`` for all ``CPUFreq`` policies contains the string "intel_cpufreq".
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index d2297839374d..b24a5c5ec4f9 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2769,6 +2769,8 @@ static int __init intel_pstate_init(void)
>  		pr_info("Invalid MSRs\n");
>  		return -ENODEV;
>  	}
> +	/* Without HWP start in the passive mode. */
> +	default_driver = &intel_cpufreq;
> 
>  hwp_cpu_matched:
>  	/*
> @@ -2814,7 +2816,6 @@ static int __init intel_pstate_setup(char *str)
>  	if (!strcmp(str, "disable")) {
>  		no_load = 1;
>  	} else if (!strcmp(str, "passive")) {
> -		pr_info("Passive mode enabled\n");
>  		default_driver = &intel_cpufreq;
>  		no_hwp = 1;
>  	}
> --
> 2.16.4

Example 1: i5-9600k (hwp capable) (kernel 5.8-rc4):

Grub:
GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 consoleblank=450 intel_pstate=active intel_pstate=no_hwp cpuidle_sysfs_switch
cpuidle.governor=teo"

/proc/cmdline:
BOOT_IMAGE=/boot/vmlinuz-5.8.0-rc4-stock root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1 consoleblank=450
intel_pstate=active intel_pstate=no_hwp cpuidle_sysfs_switch cpuidle.governor=teo

Result:

doug@s18:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu1/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu2/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu3/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu4/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:intel_cpufreq

Example 2: i7-2600k (does not have hwp) (kernel 5.8-rc1)

Grub:
GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 consoleblank=300 intel_pstate=active cpuidle_sysfs_switch cpuidle.governor=teo"

/proc/cmdline:
BOOT_IMAGE=/boot/vmlinuz-5.8.0-rc1-stock root=UUID=bcbc624b-892b-46ca-9e9e-102daf644170 ro ipv6.disable=1 consoleblank=300
intel_pstate=active cpuidle_sysfs_switch cpuidle.governor=teo

Result:

doug@s15:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu1/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu2/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu3/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu4/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu6/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu7/cpufreq/scaling_driver:intel_cpufreq

... Doug


