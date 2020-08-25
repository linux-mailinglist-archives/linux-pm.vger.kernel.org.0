Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64819250DFC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 03:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgHYBAv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 21:00:51 -0400
Received: from cmta18.telus.net ([209.171.16.91]:40483 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgHYBAu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 21:00:50 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ANKQkLBIzqUs3ANKRkSXKu; Mon, 24 Aug 2020 19:00:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1598317248; bh=TPAEeJ0fBeP2aFmR+oVt6HwbwDzn96uor0hjtlwd2T8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Yk1phhAVAEAxRYPovhek8Q7bZNOECTdm1tKyb3XWfrGIZoDXEs2hN7XJaK9OqX2Mr
         c6RNBGFZZG0r7AtgltyNbHLwbzzlzZQwpMkgzBfWX1rGAIj0arAASvc11q4BFuubFF
         YlWSsXeymsxcLs2Z2ulXSAHhOoqCqloAPXg9ZiqXVDdccAsf4sOtDQ6p/DPdhC4OLE
         KzOENOGxO1I6L2bKMmsn4CrDGJAsg1B/FRqZkZd4ZIXgITgznkAXty/LHA9GDmk7E1
         s5RqoVC4MrjbMPRVWwvAk0K3WOvM1wJSuH1DbxX+lJWzO7fZN1mcnSUJINL39flJLY
         XwkF66jrFSw8w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Mo8sFFSe c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=OI1R5I0srzs5c63PWPAA:9 a=s5HJpPSTBC2b_tEV:21 a=v9_5a6IGdNKjCdap:21
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <4169555.5IIHXK4Dsd@kreacher> <5cf44a75c9f73740d2a22dbfc5c7a57489b1a3ca.camel@linux.intel.com>
In-Reply-To: <5cf44a75c9f73740d2a22dbfc5c7a57489b1a3ca.camel@linux.intel.com>
Subject: RE: [PATCH v2 0/5] cpufreq: intel_pstate: Address some HWP-related oddities
Date:   Mon, 24 Aug 2020 18:00:45 -0700
Message-ID: <002001d67a7b$2b46e1c0$81d4a540$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZ6cjK78PmtilM6Tn+GYmfDVqHOPgABYdpg
X-CMAE-Envelope: MS4wfLr8+jO1ryDZkEEZoeoPkSnT9Lf6+pyuL2V3jMgGXJQ4FrD5zfqTA+Il6rOH1xgF9LY2BEHlqeOuA402VZCrU1eLRHNLh3ZiOaeCEkfcAEAD7cIrACXg
 PnllMfkjUKQaNXjAoxXmf+/Ix+h0MGve8UA6iK9KXIBRnyWRt8+0jysGSLcFQvPolnw7XcEhrVnCo3fFY2PyNxCVdvJud4qJW0i6AkDdGYlmWVfGtw4bJLJg
 5CpRbjQ3q7LDdrN5ejpK7GL6vgH4MD4fNLuCgMpEiJqx2ddVvls4vQuT1RInRE9S
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

I think there is a disconnect between your written
description of what is going on and your supporting MSR reads.

On 2020.08.24 16:56 Srinivas Pandruvada wrote:
> On Mon, 2020-08-24 at 19:39 +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > The v2 is here to address feedback from Doug and one issue found by
> > me.
> >
> > The purpose of this series is to address some peculiarities related
> > to
> > taking CPUs offline/online and switching between different operation
> > modes with HWP enabled that have become visible after allowing the
> > driver to work in the passive mode with HWP enabled in 5.9-rc1 (and
> > one that was there earlier, but can be addressed easily after the
> > changes madein 5.9-rc1).
> >
> > Please refer to the patch changelogs for details.
> >
> > For easier testing/review, the series is available from the git
> > branch at:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  intel_pstate-testing
> >
> 
> Applied these patches to 5.9-rc2

So did I, and the issues I reported the other day are fine now.
I did try a few of the things you were doing.

> 
> - After s3  limits got messed up.
>  # cat /sys/power/mem_sleep
> s2idle [deep]
> 
> - In the dmesg unchecked MSR for HWP register
> 
> 1.
> Before test
> 
> sudo rdmsr -a 0x774
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0d
> 7f002b0c

?? This looks like the MSR
read for further below, and for 
CPU 19 instead of 1.

> cd /sys/devices/system/cpu/intel_pstate/
> [root@otcpl-perf-test-skx-i9 intel_pstate]# grep . *
> hwp_dynamic_boost:0
> max_perf_pct:100
> min_perf_pct:27
> no_turbo:0
> num_pstates:32
> status:active
> turbo_pct:32
> 
> cd ../cpu1/cpufreq/
> [root@otcpl-perf-test-skx-i9 cpufreq]# grep . *
> affected_cpus:1
> base_frequency:3300000
> cpuinfo_max_freq:4300000
> cpuinfo_min_freq:1200000
> cpuinfo_transition_latency:0
> energy_performance_available_preferences:default performance
> balance_performance balance_power power
> energy_performance_preference:balance_performance
> related_cpus:1
> scaling_available_governors:performance powersave
> scaling_cur_freq:1200000
> scaling_driver:intel_pstate
> scaling_governor:powersave
> scaling_max_freq:4300000
> scaling_min_freq:1200000
> scaling_setspeed:<unsupported>
> 
> 
> 2. Now change the EPP
> 
> # echo 127 > energy_performance_preference
> sudo rdmsr -a 0x774
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0d

This looks like the original MSR read.

> 
> Good here
> 
> 3. Offline/online good
> 
> [root@otcpl-perf-test-skx-i9 cpufreq]# echo 0 >
> /sys/devices/system/cpu/cpu1/online
> [root@otcpl-perf-test-skx-i9 cpufreq]# echo ` >
> /sys/devices/system/cpu/cpu1/online
> > echo ` > /sys/devices/system/cpu/cpu1/online ^C
> [root@otcpl-perf-test-skx-i9 cpufreq]# echo 1 >
> /sys/devices/system/cpu/cpu1/online
> 
>  sudo rdmsr -a 0x774
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0d
> 7f002b0c

O.K.

> 
> Good. Online restored the setting
> 
> 4. Now S3
> 
> rtcwake -m mem -s 10

Cool command. I did not know about it.
I tried it.
> 
> All limits are now messed up
> 
> sudo rdmsr -a 0x774
> 80002b0c
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 

Yes, I got the same:

# /home/doug/c/msr-decoder (edited)
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 80002E08 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 :
    min:        8 :        1 :        1 :        1 :        1 :        1 :
    max:       46 :      255 :      255 :      255 :      255 :      255 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:      128 :      128 :      128 :      128 :      128 :      128 :
    act:        0 :        0 :        0 :        0 :        0 :        0 :

> 5. Now switch to passive
> Again bad, some CPU max/min is 0
> 
> sudo rdmsr -a 0x774
> 80002b0d
> 7f002b0f

Hmmm... Now seems to be CPU 1

> 80002b0c
> 80002d0e
> 80002b0c
> 80002b0d
> 80002b0f
> 80002b2b
> 80002b0c
> 80002d1d
> 80000000
> 80002b0c
> 80002b0c
> 80000000
> 80000000
> 80000000
> 80000000
> 80000000
> 80000000
> 80000000

MSR 774 was good for me, but in general my decoder was having troubles.

0x774: IA32_HWP_REQUEST:    CPU 0-5 :
sh: 0: getcwd() failed: No such file or directory
    raw: 80002E2E : 7F002E2E : 80002E2E : 80002E2E : 80002E2E : 80002E2E :
    min:       46 :       46 :       46 :       46 :       46 :       46 :
    max:       46 :       46 :       46 :       46 :       46 :       46 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:      128 :      127 :      128 :      128 :      128 :      128 :
    act:        0 :        0 :        0 :        0 :        0 :        0 : 

> 
> 6.
> Switched back to active to restore back
> 
> Lost EPP setting but rest are good.
> 
> sudo rdmsr -a 0x774
> 80002b0c
> 7f002b0c

And again, now seems to be CPU1.

> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002b0c
> 80002d0d
> 
> 7. S3 again
> 
> rtcwake -m mem -s 10
> 
> Again messed up
> 
>  sudo rdmsr -a 0x774
> 80002b0c
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 8000ff00
> 
> This time dmesg didn't have unchecked MSR in dmesg (I think because I
> didn't change EPP before)
> 
> Thanks,
> Srinivas
> 
> > Thanks,
> > Rafael
> >
> >
> >

