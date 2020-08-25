Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D6E251BEE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHYPMN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 11:12:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:11547 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgHYPMK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 11:12:10 -0400
IronPort-SDR: UFXd8xJ2a/e69RsTXe9lJh/+yloy76bkUtHrTRxzTQfe69hkYpWQGQ5mJH6ZtVwlKYsMGs6zAy
 IVfCYjXiF7ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136191158"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="136191158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:11:54 -0700
IronPort-SDR: uvR6zCLMdAk2LJ51webBU5H9odU+fT7f0cGUCpaLI7k+n3vyxlKmPF/riiHNDfBYnMl0Q+XP06
 HIZbnWbNXUeg==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="474383039"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.25.243])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:11:54 -0700
Message-ID: <d07cd980439d999b060dccdd16cb44c390cbf66d.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/5] cpufreq: intel_pstate: Address some HWP-related
 oddities
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     'LKML' <linux-kernel@vger.kernel.org>,
        'Linux PM' <linux-pm@vger.kernel.org>
Date:   Tue, 25 Aug 2020 08:11:53 -0700
In-Reply-To: <002001d67a7b$2b46e1c0$81d4a540$@net>
References: <4169555.5IIHXK4Dsd@kreacher>
         <5cf44a75c9f73740d2a22dbfc5c7a57489b1a3ca.camel@linux.intel.com>
         <002001d67a7b$2b46e1c0$81d4a540$@net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

On Mon, 2020-08-24 at 18:00 -0700, Doug Smythies wrote:
> Hi Srinivas,
> 
> I think there is a disconnect between your written
> description of what is going on and your supporting MSR reads.
> 
I reproduced again.
I see the copy paste individual at the first place swapped.
I pasted the full output by direct copy - paste from the screen.

But the issues are still there.

[labuser@otcpl-perf-test-skx-i9 ~]$ sudo -s
[root@otcpl-perf-test-skx-i9 labuser]# rdmsr -a 0x774
80002b0c
80002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002b0c
80002b0c
80002d0d
[root@otcpl-perf-test-skx-i9 labuser]# cd /sys/devices/system/cpu/cpu1
[root@otcpl-perf-test-skx-i9 cpu1]# cd cpufreq/
[root@otcpl-perf-test-skx-i9 cpufreq]# echo 127 >
energy_performance_preference 
[root@otcpl-perf-test-skx-i9 cpufreq]# cat
energy_performance_preference 
127
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -a 0x774
80002b0c
7f002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002b0c
80002b0c
80002d0d
[root@otcpl-perf-test-skx-i9 cpufreq]# echo 0 >
/sys/devices/system/cpu/cpu1/online 
[root@otcpl-perf-test-skx-i9 cpufreq]# echo 1 >
/sys/devices/system/cpu/cpu1/online 
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -a 0x774
80002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002d0c
80002b0c
80002b0c
80002b0c
80002b0c
80002b0c
80002d0d
7f002b0c
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -p 1 0x774
7f002b0c
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -p 19 0x774
80002d0d
[root@otcpl-perf-test-skx-i9 cpufreq]# rtcwake -m mem -s 10
rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Aug 25 15:04:02 2020
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -a 0x774
80002b0c
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
8000ff00
[root@otcpl-perf-test-skx-i9 cpufreq]# dmesg > ~/temp/dmesg.txt
[root@otcpl-perf-test-skx-i9 cpufreq]# cat
energy_performance_preference 
127
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -p 1 0x774
8000ff00
[root@otcpl-perf-test-skx-i9 cpufreq]# echo passive >
/sys/devices/system/
clockevents/  clocksource/  container/    cpu/          edac/         m
achinecheck/ memory/       node/         
[root@otcpl-perf-test-skx-i9 cpufreq]# echo passive >
/sys/devices/system/cpu/intel_pstate/status 
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -a 0x774
80002b0c
7f000000
80000000
80002d0c
80002b0c
80000000
80000000
80002b0c
80000000
80002d0c
80000000
80002b0c
80002b0d
80002d0c
80000000
80000000
80000000
80002b0d
80000000
80000000
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -a 0x774
80002b0c
7f000000
80000000
80002d0c
80002b0c
80000000
80000000
80002b0c
80000000
80002d0c
80000000
80002b0c
80002b0d
80002d0c
80000000
80002b0c
80000000
80002b0d
80000000
80000000

> On 2020.08.24 16:56 Srinivas Pandruvada wrote:
> > On Mon, 2020-08-24 at 19:39 +0200, Rafael J. Wysocki wrote:
> > > Hi All,
> > > 
> > > The v2 is here to address feedback from Doug and one issue found
> > > by
> > > me.
> > > 
> > > The purpose of this series is to address some peculiarities
> > > related
> > > to
> > > taking CPUs offline/online and switching between different
> > > operation
> > > modes with HWP enabled that have become visible after allowing
> > > the
> > > driver to work in the passive mode with HWP enabled in 5.9-rc1
> > > (and
> > > one that was there earlier, but can be addressed easily after the
> > > changes madein 5.9-rc1).
> > > 
> > > Please refer to the patch changelogs for details.
> > > 
> > > For easier testing/review, the series is available from the git
> > > branch at:
> > > 
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
> > > pm.git \
> > >  intel_pstate-testing
> > > 
> > 
> > Applied these patches to 5.9-rc2
> 
> So did I, and the issues I reported the other day are fine now.
> I did try a few of the things you were doing.
> 
> > - After s3  limits got messed up.
> >  # cat /sys/power/mem_sleep
> > s2idle [deep]
> > 
> > - In the dmesg unchecked MSR for HWP register
> > 
> > 1.
> > Before test
> > 
> > sudo rdmsr -a 0x774
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0d
> > 7f002b0c
> 
> ?? This looks like the MSR
> read for further below, and for 
> CPU 19 instead of 1.
> 
> > cd /sys/devices/system/cpu/intel_pstate/
> > [root@otcpl-perf-test-skx-i9 intel_pstate]# grep . *
> > hwp_dynamic_boost:0
> > max_perf_pct:100
> > min_perf_pct:27
> > no_turbo:0
> > num_pstates:32
> > status:active
> > turbo_pct:32
> > 
> > cd ../cpu1/cpufreq/
> > [root@otcpl-perf-test-skx-i9 cpufreq]# grep . *
> > affected_cpus:1
> > base_frequency:3300000
> > cpuinfo_max_freq:4300000
> > cpuinfo_min_freq:1200000
> > cpuinfo_transition_latency:0
> > energy_performance_available_preferences:default performance
> > balance_performance balance_power power
> > energy_performance_preference:balance_performance
> > related_cpus:1
> > scaling_available_governors:performance powersave
> > scaling_cur_freq:1200000
> > scaling_driver:intel_pstate
> > scaling_governor:powersave
> > scaling_max_freq:4300000
> > scaling_min_freq:1200000
> > scaling_setspeed:<unsupported>
> > 
> > 
> > 2. Now change the EPP
> > 
> > # echo 127 > energy_performance_preference
> > sudo rdmsr -a 0x774
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0d
> 
> This looks like the original MSR read.
> 
> > Good here
> > 
> > 3. Offline/online good
> > 
> > [root@otcpl-perf-test-skx-i9 cpufreq]# echo 0 >
> > /sys/devices/system/cpu/cpu1/online
> > [root@otcpl-perf-test-skx-i9 cpufreq]# echo ` >
> > /sys/devices/system/cpu/cpu1/online
> > > echo ` > /sys/devices/system/cpu/cpu1/online ^C
> > [root@otcpl-perf-test-skx-i9 cpufreq]# echo 1 >
> > /sys/devices/system/cpu/cpu1/online
> > 
> >  sudo rdmsr -a 0x774
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0d
> > 7f002b0c
> 
> O.K.
> 
> > Good. Online restored the setting
> > 
> > 4. Now S3
> > 
> > rtcwake -m mem -s 10
> 
> Cool command. I did not know about it.
> I tried it.
> > All limits are now messed up
> > 
> > sudo rdmsr -a 0x774
> > 80002b0c
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 
> 
> Yes, I got the same:
> 
> # /home/doug/c/msr-decoder (edited)
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
>     raw: 80002E08 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 :
> 8000FF01 :
>     min:        8 :        1 :        1 :        1 :        1
> :        1 :
>     max:       46 :      255 :      255 :      255 :      255
> :      255 :
>     des:        0 :        0 :        0 :        0 :        0
> :        0 :
>     epp:      128 :      128 :      128 :      128 :      128
> :      128 :
>     act:        0 :        0 :        0 :        0 :        0
> :        0 :
> 
> > 5. Now switch to passive
> > Again bad, some CPU max/min is 0
> > 
> > sudo rdmsr -a 0x774
> > 80002b0d
> > 7f002b0f
> 
> Hmmm... Now seems to be CPU 1
> 
> > 80002b0c
> > 80002d0e
> > 80002b0c
> > 80002b0d
> > 80002b0f
> > 80002b2b
> > 80002b0c
> > 80002d1d
> > 80000000
> > 80002b0c
> > 80002b0c
> > 80000000
> > 80000000
> > 80000000
> > 80000000
> > 80000000
> > 80000000
> > 80000000
> 
> MSR 774 was good for me, but in general my decoder was having
> troubles.
> 
> 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
> sh: 0: getcwd() failed: No such file or directory
>     raw: 80002E2E : 7F002E2E : 80002E2E : 80002E2E : 80002E2E :
> 80002E2E :
>     min:       46 :       46 :       46 :       46 :       46
> :       46 :
>     max:       46 :       46 :       46 :       46 :       46
> :       46 :
>     des:        0 :        0 :        0 :        0 :        0
> :        0 :
>     epp:      128 :      127 :      128 :      128 :      128
> :      128 :
>     act:        0 :        0 :        0 :        0 :        0
> :        0 : 
> 
> > 6.
> > Switched back to active to restore back
> > 
> > Lost EPP setting but rest are good.
> > 
> > sudo rdmsr -a 0x774
> > 80002b0c
> > 7f002b0c
> 
> And again, now seems to be CPU1.
> 
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002b0c
> > 80002d0d
> > 
> > 7. S3 again
> > 
> > rtcwake -m mem -s 10
> > 
> > Again messed up
> > 
> >  sudo rdmsr -a 0x774
> > 80002b0c
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 8000ff00
> > 
> > This time dmesg didn't have unchecked MSR in dmesg (I think because
> > I
> > didn't change EPP before)
> > 
> > Thanks,
> > Srinivas
> > 
> > > Thanks,
> > > Rafael
> > > 
> > > 
> > > 

