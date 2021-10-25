Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9D438EC5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 07:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJYF1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 01:27:19 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:65482 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhJYF1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 01:27:18 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 01:27:18 EDT
IronPort-Data: =?us-ascii?q?A9a23=3AskOxJaKpqPgquwwsFE+RYZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHCw0zIj1WZSx2NOCGuDOKuIM2LxeY0laYy38kIAuJPdm4NqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjQHOakUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssItO?=
 =?us-ascii?q?snqz6f0tirrz6bVXI1CoQAvL7xEEd/UTe0Y5iXBYYQUVKjzSA2dR419xJsbSxT?=
 =?us-ascii?q?x0oN+vCgozxVjECSn4hYPIuFLjvZCLXXdao50Hddmrww/RjF2kqMIkF4aBxDH0?=
 =?us-ascii?q?m3ecCKTYMcBmYwfq/xr6hV/dlis0LKMjtIZNZu3d8wDWfBvEjKbjHTqPAzdxVx?=
 =?us-ascii?q?jE9goZJB/m2T9AbdhJ1bgvReBpEOVZRDp8i9M+2h2PyaD0eq0+QrLAf52nVxRZ?=
 =?us-ascii?q?2lr/3P7L9ft2MWNUQhkOwuG3L5SL6DwscOdjZziCKmlqoh+nSjWb4VZgUGbmQ6?=
 =?us-ascii?q?PFnmhuQy3YVBRlQUkG0ycRVIGbWt8l3chNPvHN09O5spAr7E5/nUgP+u3Ce+Bg?=
 =?us-ascii?q?RR7Jt/yQBwFnl4sLpD8yxXwDolgJ8VeE=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQA0mfqsJw3/BPsBZBsDJHl5d7skD+tV00zEX?=
 =?us-ascii?q?/kB9WHVpm6uj5rWTdZUgpG3JYVkqKRUdcLq7Sc69qE3nhOpICOUqU4tLsmHdyR?=
 =?us-ascii?q?WVxK8L1/qT/9TLIVyDygZlvZ0QApSX4rXLfCtHZL/BkXaF+rUboOVvjprY4Ns2?=
 =?us-ascii?q?lE0dMD2CApsIh2wSZ2r1LqBvfnghOXMXLuvq2iMtnUvZRZ14VKWG7rhsZZm5m/?=
 =?us-ascii?q?T70L/rah4PAHccmWqzpALtxbLwExCemi4XWTFGz7tKyxmmr+R3jp/Tyc2T21vQ?=
 =?us-ascii?q?22TS55MTkML50d1dCMHksLltFgnR?=
X-IronPort-AV: E=Sophos;i="5.87,179,1631570400"; 
   d="scan'208";a="217757"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 07:17:49 +0200
Date:   Mon, 25 Oct 2021 07:17:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Doug Smythies <dsmythies@telus.net>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem in changing from active to passive mode
In-Reply-To: <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110250712070.2938@hadrien>
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien> <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Sun, 24 Oct 2021, Doug Smythies wrote:

> On Sun, Oct 24, 2021 at 6:03 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > Hello,
>
> Hi,
>
> >
> > I have an Intel 6130 and an Intel 5218.  These machines have HWP.  They
> > are configured to boot with active mode and performance as the power
> > governor.  Since the following commit:
> >
> > commit a365ab6b9dfbaf8fb4fb4cd5d8a4c55dc4fb8b1c (HEAD, refs/bisect/bad)
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Mon Dec 14 21:09:26 2020 +0100
> >
> >     cpufreq: intel_pstate: Implement the ->adjust_perf() callback
> >
> > If I change te mode from active to passive, I have the impression that the
> > machine is no longer able to raise the core frequencies above the minimum.
> > Changing the mode back to active has no effect.  This persists if I reboot
> > to another kernel.
> >
> > Here are some runs that illustrate the problem.  I have tested the
> > benchmark many times, and apart from this issue its performance is stable.
>
> Could you also list the CPU frequency scaling governor being used in your
> tests. I know you mentioned the performance governor above, but it
> changes between active/passive/active transitions.

Performance.  I only booted and then changed to passive and then changed
back.

I originally saw the problem when changeing from active-performance to
passive-schedutil.  But seeing the problem doesn't require changing the
governor to schedutil.

>
> Example from my test computer:
>
> Note 1: It is only for brevity of this e-mail that I only list for one CPU.
> Obviously, I looked at all CPUs when doing this.
>
> Note 2: The test example and conditions have been cherry picked
> for dramatic effect.
>
> $ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_driver
> intel_pstate
> $ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
> performance
> $ cat /sys/devices/system/cpu/intel_pstate/status
> active
> $ ./ping-pong-many 100000 500 10
> 1418.0660 usecs/loop. (less is better)
>
> $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
> passive

So converting to passive send you directly to schedutil?  I didn't check
on that - I have always changed to passive and then explicitly change to
schedutil.

> $ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_driver
> intel_cpufreq
> $ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
> schedutil
> $ cat /sys/devices/system/cpu/intel_pstate/status
> passive
> $ ./ping-pong-many 100000 500 10
> 5053.6355 usecs/loop.
>
> $ echo active | sudo tee /sys/devices/system/cpu/intel_pstate/status
> active
> $ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_driver
> intel_pstate
> $ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
> powersave
> $ cat /sys/devices/system/cpu/intel_pstate/status
> active
> $ ./ping-pong-many 100000 500 10
> 2253.5833 usecs/loop.

So now you are twice as slow, but don't know how much this benchmark
varies.  I suspect that on my machine I would get the 5000 number. I also
traced the frequencies and they were at the lowest point (1GHz) almost all
of the time.

I'll redo my tests and collect all of this information.

thanks,
julia

> ... Doug
>
> >
> > Intel 6130:
> >
> > root@yeti-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
> > ===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
> > ===== DaCapo 9.12-MR1 avrora completed warmup 1 in 3420 msec =====
> > ===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
> > ===== DaCapo 9.12-MR1 avrora completed warmup 2 in 2536 msec =====
> > ===== DaCapo 9.12-MR1 avrora starting =====
> > ===== DaCapo 9.12-MR1 avrora PASSED in 2502 msec =====
> > root@yeti-2:/tmp# echo passive | tee /sys/devices/system/cpu/intel_pstate/status
> > passive
> > root@yeti-2:/tmp#
> > root@yeti-2:/tmp# echo active | tee /sys/devices/system/cpu/intel_pstate/status
> > active
> > root@yeti-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
> > ===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
> > ===== DaCapo 9.12-MR1 avrora completed warmup 1 in 7561 msec =====
> > ===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
> > ===== DaCapo 9.12-MR1 avrora completed warmup 2 in 6528 msec =====
> > ===== DaCapo 9.12-MR1 avrora starting =====
> > ===== DaCapo 9.12-MR1 avrora PASSED in 7796 msec =====
> >
> > -------------------------------------------------------------------------
> >
> > Intel 5218:
> >
> > root@troll-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
> > ===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
> > ===== DaCapo 9.12-MR1 avrora completed warmup 1 in 2265 msec =====
> > ===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
> > ===== DaCapo 9.12-MR1 avrora completed warmup 2 in 2033 msec =====
> > ===== DaCapo 9.12-MR1 avrora starting =====
> > ===== DaCapo 9.12-MR1 avrora PASSED in 2068 msec =====
> > root@troll-2:/tmp# echo passive | tee /sys/devices/system/cpu/intel_pstate/status
> > passive
> > root@troll-2:/tmp# echo active | tee /sys/devices/system/cpu/intel_pstate/statusactive
> > root@troll-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
> > ===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
> > ===== DaCapo 9.12-MR1 avrora completed warmup 1 in 4363 msec =====
> > ===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
> > ===== DaCapo 9.12-MR1 avrora completed warmup 2 in 4486 msec =====
> > ===== DaCapo 9.12-MR1 avrora starting =====
> > ===== DaCapo 9.12-MR1 avrora PASSED in 3417 msec =====
> >
> > -------------------------------------------------------------------------
> >
> > thanks,
> > julia
>
