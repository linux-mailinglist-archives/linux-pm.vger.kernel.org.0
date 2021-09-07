Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC3402C4F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhIGQDT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 12:03:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:29275 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhIGQDS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="217079702"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="217079702"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 09:01:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="546937190"
Received: from jbolland-mobl.gar.corp.intel.com ([10.213.119.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 09:01:31 -0700
Message-ID: <2a1b000cd101737400f6320ef18c0143d3a5145b.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support
 in no-HWP mode
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 07 Sep 2021 09:01:23 -0700
In-Reply-To: <CAAYoRsXK79PspEUh9pqgj2OGQnxQONkEeK-7af3=5frBzAqULQ@mail.gmail.com>
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
         <20210513132051.31465-1-ggherdovich@suse.cz>
         <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
         <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz>
         <CAAYoRsX0xJf1mm1a_YUCzDy86r8q4QE98iVtS1AMLaUx+KTgQQ@mail.gmail.com>
         <CAAYoRsXK79PspEUh9pqgj2OGQnxQONkEeK-7af3=5frBzAqULQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

On Tue, 2021-09-07 at 08:45 -0700, Doug Smythies wrote:
> Hi all,
> 
> Recent ASUS BIOS updates have changed the default system
> response for this old thread, rendering "intel_pstate=no_hwp"
> useless.
> 
> It also raises a question: If BIOS has forced HWP, then how do we
> prevent the acpi-cpufreq driver from being used? Read on.

Does BIOS has option to enable Intel speed shift with no legacy
support?
Then this option will not populate ACPI _PSS table.

> 
> On Fri, May 14, 2021 at 3:12 PM Doug Smythies <dsmythies@telus.net>
> wrote:
> > 
> > On Fri, May 14, 2021 at 1:33 PM Giovanni Gherdovich <  
> > ggherdovich@suse.cz> wrote:
> > > On Fri, 2021-05-14 at 08:31 -0700, Doug Smythies wrote:
> ...
> > > 
> > > when COMETLAKE is not in that list, can you confirm that if you
> > > go into the
> > > BIOS config at boot, and disable HWP from there, then
> > > intel_pstate does *not* load?
> > 
> > Yes, already tested before my original reply.
> > 
> > > Does it say "intel_pstate: CPU model not supported" in the dmesg
> > > log?
> > 
> > That I did not check, but if I boot now with an unmodified kernel
> > 5.13-rc1 (i.e. without this patch):
> > 
> > [    0.369323] intel_pstate: CPU model not supported
> > 
> > > The control may be somewhere around "power mangement" in the BIOS
> > > config, and
> > > may be called "Enable/disable Intel Speed Shift".
> > 
> > Yes.
> > 
> > > I'm asking because I've just checked on two Dell laptops, one
> > > Skylake and the
> > > other Kabylake, and the menu is there in the BIOS config to
> > > disable HWP,
> > > but if I disable it... nothing happens. "lscpu" shows all the hwp
> > > flags as usual:
> > 
> > Motherboard here is ASUS PRIME Z490-A.
> > CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> > 
> > >     # lscpu | grep Flags | tr ' ' '\n' | grep hwp
> > >     hwp
> > >     hwp_notify
> > >     hwp_act_window
> > >     hwp_epp
> > 
> > Here, for some reason I have to do it this way (sudo) or your
> > command
> > doesn't work properly. Results herein confirmed by looking at the
> > "Flags" output manually without filtering:
> > 
> > intel_speed_shift = Disabled in BIOS:
> > 
> > doug@s19:~$ sudo lscpu | tr ' ' '\n' | grep hwp
> > doug@s19:~$
> > 
> > intel_speed_shift = Auto in BIOS
> > 
> > $ sudo lscpu | tr ' ' '\n' | grep hwp
> > hwp
> > hwp_notify
> > hwp_act_window
> > hwp_epp
> > 
> > > and turbostat gives me:
> > > 
> > >     # turbostat -Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
> > >     cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
> > 
> > Here:
> > 
> > intel_speed_shift = Disabled in BIOS:
> > 
> > root@s19:/home/doug#
> > /home/doug/temp-k-git/linux/tools/power/x86/turbostat/turbostat
> > -Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
> > root@s19:/home/doug#
> > 
> > intel_speed_shift = Auto in BIOS (the default setting)
> > 
> > root@s19:/home/doug#
> > /home/doug/temp-k-git/linux/tools/power/x86/turbostat/turbostat
> > -Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
> > cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
> > 
> > or with "intel_pstate=no_hwp"
> > 
> > root@s19:/home/doug#
> > /home/doug/temp-k-git/linux/tools/power/x86/turbostat/turbostat
> > -Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
> > cpu0: MSR_PM_ENABLE: 0x00000000 (No-HWP)
> > 
> > > Which is to say, on the Intel client machines I have, the
> > > firmware doesn't
> > > seem to be able to hide HWP from the OS. Buggy BIOS? Maybe, the
> > > fact of the
> > > matter is, I wouldn't need to add, say, KABYLAKE to that list,
> > > based on my
> > > experience.
> > 
> > My experience (hardware) differs from yours with respect to this.
> > 
> > > The other side of the issue is that, from my understanding, the
> > > preferred/supported way to disable HWP is to boot with
> > > intel_pstate=no_hwp,
> 
> Previous correspondence was with BIOS version 1003. There have been 3
> BIOS
> releases since then (at least that I know of), 2103, 2201, 2301, and
> all of them
> have changed the behaviour of the "Auto" setting for Intel Speed
> Shift
> Technology BIOS setting, forcing it on upon transfer of control to
> the OS.
> 
> Where with "intel_pstate=no_hwp" one used to get 0 for MSR_PM_ENABLE
> (0x770) they now get 1.

So they are forcing Out of band OOB mode. 
Does bit 8 or 18 in MSR 0x1aa is set? 

Thanks,
Srinivas

> 
> That was for my ASUS Z490-P Motherboard.
> For my ASUS Z390-A Motherboard (actually a windows 10 computer now),
> with an older BIOS, things still work properly for
> "intel_pstate=no_hwp", and
> while there is a newer BIOS, I will not install it as it is also not
> possible to
> rollback.
> 
> I have had an escalation in progress with ASUS about this for about a
> month,
> and while they have been responsive we have communications/language
> issues and have yet to even agree that there is an issue.
> 
> I have been working with this incomplete patch:
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index bb4549959b11..7dcc51ee56ea 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> 
>  static int __init intel_pstate_setup(char *str)
>  {
> +       /* The following needs to be conditional on CPUID with EAX 6
> */
> +       /* CPUID.06H:EAX[bit 7], which I do not know how to do. */
> +       /* Avoid doing checking and printing multiple times, */
> +       /* which I do not know why it does. */
> +       if(!force_load){
> +               if(intel_pstate_hwp_is_enabled()){
> +                       pr_info("HWP enabled by BIOS\n");
> +                       force_load = 1;
> +               }
> +       }
>         if (!str)
>                 return -EINVAL;
> 
> -       if (!strcmp(str, "disable"))
> +       if (!strcmp(str, "disable") && !force_load)
>                 no_load = 1;
> -       else if (!strcmp(str, "active"))
> +       if (!strcmp(str, "active") && !no_load)
>                 default_driver = &intel_pstate;
>         else if (!strcmp(str, "passive"))
>                 default_driver = &intel_cpufreq;
> 
> -       if (!strcmp(str, "no_hwp")) {
> +       if (!strcmp(str, "no_hwp") && !force_load) {
>                 pr_info("HWP disabled\n");
>                 no_hwp = 1;
>         }
> 
> Which has troubles when HWP has been disabled by BIOS, but otherwise
> works well.
> 
> HWP Disabled by BIOS:
> 
> doug@s19:~$ sudo dmesg | grep intel_pstate
> [sudo] password for doug:
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.14.0-ipstate4
> root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1
> consoleblank=314 intel_pstate=active intel_pstate=no_hwp
> msr.allow_writes=on cpuidle.governor=teo
> [    0.000000]  intel_pstate_setup+0x24/0x151
> [    0.000000]  intel_pstate_setup+0x24/0x151
> [    0.000000] intel_pstate: HWP disabled
> [    0.051278] Kernel command line:
> BOOT_IMAGE=/boot/vmlinuz-5.14.0-ipstate4
> root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1
> consoleblank=314 intel_pstate=active intel_pstate=no_hwp
> msr.allow_writes=on cpuidle.governor=teo
> [    0.393236] intel_pstate: Intel P-state driver initializing
> 
> HWP force enabled by BIOS, which is the only other option with the
> newer BIOS:
> 
> doug@s19:~$ sudo dmesg | grep intel_pstate
> [sudo] password for doug:
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.14.0-ipstate4
> root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1
> consoleblank=314 intel_pstate=active intel_pstate=no_hwp
> msr.allow_writes=on cpuidle.governor=teo
> [    0.000000] intel_pstate: HWP enabled by BIOS
> [    0.049205] Kernel command line:
> BOOT_IMAGE=/boot/vmlinuz-5.14.0-ipstate4
> root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1
> consoleblank=314 intel_pstate=active intel_pstate=no_hwp
> msr.allow_writes=on cpuidle.governor=teo
> [    0.370662] intel_pstate: Intel P-state driver initializing
> [    0.371590] intel_pstate: HWP enabled
> 
> HWP forced by BIOS, disable intel_pstate:
> 
> doug@s19:~$ sudo dmesg | grep intel_pstate
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.14.0-ipstate4
> root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1
> consoleblank=300 intel_pstate=disable msr.allow_writes=on
> cpuidle.governor=teo
> [    0.000000] intel_pstate: HWP enabled by BIOS
> [    0.049133] Kernel command line:
> BOOT_IMAGE=/boot/vmlinuz-5.14.0-ipstate4
> root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1
> consoleblank=300 intel_pstate=disable msr.allow_writes=on
> cpuidle.governor=teo
> [    0.370519] intel_pstate: Intel P-state driver initializing
> [    0.371451] intel_pstate: HWP enabled
> doug@s19:~$ cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_driver
> intel_pstate
> 
> HWP forced by BIOS, disable intel_pstate:, unpatched kernel 5.14:
> 
> doug@s19:~$ sudo dmesg | grep intel_pstate
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.14.0-stock
> root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1
> consoleblank=300 intel_pstate=disable msr.allow_writes=on
> cpuidle.governor=teo
> [    0.049108] Kernel command line:
> BOOT_IMAGE=/boot/vmlinuz-5.14.0-stock
> root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=1
> consoleblank=300 intel_pstate=disable msr.allow_writes=on
> cpuidle.governor=teo
> doug@s19:~$ cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_driver
> acpi-cpufreq
> doug@s19:~$ sudo rdmsr 0x770
> 1
> 
> Observe the driver ended up as acpi-cpufreq, but with HWP enabled.
> 
> ... Doug


