Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89B43CD55
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhJ0PTR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 11:19:17 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:3358 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236270AbhJ0PTQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 11:19:16 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Azs6Mn6/vSlwhoeusfHtuk+FGdb1zdoMgy1kn?=
 =?us-ascii?q?xilNoENuH/BwxvrFoB1E73TJYVYqNE3I6urwXJVoIEm8yXcb2/hzAV7PZniehI?=
 =?us-ascii?q?LsFvAb0WKA+UycJ8SdzI5gPM5bGsAQZqyNMbE5t7ed3ODRKadb/DDtytHMuQ6x?=
 =?us-ascii?q?9QYLcegnUdAD0+8vYTzraXGeCTM2TKYRJd653I5qtjCgcXMYYoCSAWQEZfHKo5?=
 =?us-ascii?q?numIj9aRALKhY74E3W5AnYo4LSIly95FMzQjlPybAt/SzslBH43Lyqt7WexgXH?=
 =?us-ascii?q?32HewpxKkJ/Ky8dFBuaLls8JQw+cwjqAVcBEYfmvrTo1qOag5BIDl8TNmQ4pO4?=
 =?us-ascii?q?BJ53bYbgiO0G/Q8jil9Axrx27pyFeej3emi9f+XigGB81Igp8cWgfF6mI71esM?=
 =?us-ascii?q?n55j7ia8jd56HBnAlCPy65zjTBdxjHe5pnIkjKo6k2Ffa40Dc7VcxLZvsH+9KK?=
 =?us-ascii?q?1wXR4S1bpXUNWHVKrnlbVrmBKhHj3kV1BUsZKRti9ZJGbFfqAA0vblpgS+0koJ?=
 =?us-ascii?q?infw//Zv4EvowqhNOaWs1960TZiAq4s+P/P+TZgNc9vpEvHHfFAkf3r3QRKvCG?=
 =?us-ascii?q?WiMp07EFTwjLOyyIkJxYiRCe81Jd0J6d78bG8=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397541166"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 17:16:49 +0200
Date:   Wed, 27 Oct 2021 17:16:48 +0200 (CEST)
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
In-Reply-To: <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110271712100.2966@hadrien>
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien> <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com> <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Wed, 27 Oct 2021, Doug Smythies wrote:

> On Tue, Oct 26, 2021 at 8:13 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > The problem is illustrated by the attached graphs.  These graphs on the
> > odd numbered pages show the frequency of each core measures at every clock
> > tick.  At each measurement there is a small bar representing 4ms of the
> > color associated with the frequency.  The percentages shown are thus not
> > entirely accurate, because the frequency could change within those 4ms and
> > we would not observe that.
> >
> > The first graph, 5.9schedutil_yeti, is the normal behavior of schedutil
> > running.  The application mostly uses the second highest turbo mode, which
> > is the appropriate one given that there are around 5 active cores most of
> > the time.  I traced power:cpu_frequency, which is the event that occurs
> > when the OS requests a change of frequency.  This happens around 5400
> > times.
> >
> > The second graph, 5.15-schedutil_yeti, is the latest version of Linus's
> > tree.  The cores are almost always at the lowest frequency.  There are no
> > occurrences of the power:cpu_frequency event.
> >
> > The third graph, 5.9schedutil_after_yeti, it what happens when I reboot
> > into 5.9 after having changed to passive mode in 5.15.  The number of
> > power:cpu_frequency drops to around 1100.  The proper turbo mode is
> > actually used sometimes, but much less than in the first graph.  More than
> > half of the time, an active core is at the lowest frequency.
> >
> > This application (avrora from the DaCapo benchmarks) is continually
> > stopping and starting, both for very short intervals.  This may discourage
> > the hardware from raising the frequency of its own volition.
>
> Agreed. This type of workflow has long been known to be a challenge
> for various CPU frequency scaling governors. It comes up every so
> often on the linux-pm email list. Basically, the schedutil CPU frequency
> scaling governor becomes somewhat indecisive under these conditions.
> However, if for some reason it gets kicked up to max CPU frequency,
> then often it will stay there (depending on details of the workflow,
> it stays up for my workflows).
>
> Around the time of the commit you referenced in your earlier
> email, it was recognised that proposed changes were adding
> a bit of a downward bias to the hwp-passive-scheutil case for
> some of these difficult workflows [1].
>
> I booted an old 5.9, HWP enabled, passive, schedutil.
> I got the following for my ping-pong test type workflow,
> (which is not the best example):
>
> Run 1: 6234 uSecs/loop
> Run 2: 2813 uSecs/loop
> Run 3: 2721 uSecs/loop
> Run 4: 2813 uSecs/loop
> Run 5: 11303 uSecs/loop
> Run 6: 13803 uSecs/loop
> Run 7: 2809 uSecs/loop
> Run 8: 2796 uSecs/loop
> Run 9: 2760 uSecs/loop
> Run 10: 2691 uSecs/loop
> Run 11: 9288 uSecs/loop
> Run 12: 4275 uSecs/loop
>
> Then the same with kernel 5.15-rc5
> (I am a couple of weeks behind).
>
> Run 1: 13618 uSecs/loop
> Run 2: 13901 uSecs/loop
> Run 3: 8929 uSecs/loop
> Run 4: 12189 uSecs/loop
> Run 5: 10338 uSecs/loop
> Run 6: 12846 uSecs/loop
> Run 7: 5418 uSecs/loop
> Run 8: 7692 uSecs/loop
> Run 9: 11531 uSecs/loop
> Run 10: 9763 uSecs/loop
>
> Now, for your graph 3, are you saying this pseudo
> code of the process is repeatable?:
>
> Power up the system, booting kernel 5.9
> switch to passive/schedutil.
> wait X minutes for system to settle
> do benchmark, result ~13 seconds
> re-boot to kernel 5.15-RC
> switch to passive/schedutil.
> wait X minutes for system to settle
> do benchmark, result ~40 seconds
> re-boot to kernel 5.9
> switch to passive/schedutil.
> wait X minutes for system to settle
> do benchmark, result ~28 seconds

Yes, exactly.

I have been looking into why with 5.15-RC there are no requests from
schedutil.  I'm not yet sure to understand everything.  But I do notice
that the function cpufreq_this_cpu_can_update returns false around 2/3 of
the time.  This comes from the following code returning 0:

cpumask_test_cpu(smp_processor_id(), policy->cpus)

It seems that the mask policy->cpus always contains only one core, which
might or might not be the running one.  I don't know if this is the
intended behavior.

julia
