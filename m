Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF46D3096F9
	for <lists+linux-pm@lfdr.de>; Sat, 30 Jan 2021 18:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhA3Q6z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Jan 2021 11:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhA3Q6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jan 2021 11:58:54 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEC2C061573
        for <linux-pm@vger.kernel.org>; Sat, 30 Jan 2021 08:58:14 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y19so12801010iov.2
        for <linux-pm@vger.kernel.org>; Sat, 30 Jan 2021 08:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvLRtp+BeTWEB12kdIOXlxszYuNnLaeNNd6Fv0O7yoo=;
        b=f/7TjOh/+QF/QNIRxLMjZzQlLfMJdlj3OnWESQECJZ679w2IHWa++ngctJ6otYinoX
         2S/oZ0MuPDhCXYDUZPrDC/CFyX2a1WqAb3RdEPcGrsKufzlMGs/85909EWIcx0PY0SnN
         V+/fFsA2A4NYXp6HbiYF7ps0D4oH98lzldSSqCh6aqs6zmcnxfQYa4DZenCDl5c5CULB
         Qiwfk8qgZbHdSEOoZ+3fkC6qjOzNXzINwaq81w5s+nPv12W4DO4Zjay+S7QHlDV32KGe
         vTnF99bfcw9Go1N+slJg/IWmbJjtPkVTDwQoOPG/9lBWXa944lQXAhuBeC8oQOGxO3/f
         3y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvLRtp+BeTWEB12kdIOXlxszYuNnLaeNNd6Fv0O7yoo=;
        b=VTQGw1T1V73r+Hx772l+kOwWxEq73ntyeGWoKTufT9pxMA58opJ6mC7YklzVsE/9ZL
         L41KnaKT+FM8p31xIoDXkZZdbZ3zy42M8qos8W493VxYP0pDUmP7RnKhFk9tAt1o/Uoh
         8HZEvNGgOetpChp2SF7v6eSJwIU6i8On4m9F3SK/CANqs0P8Mn5weFtsqNTEDI+unUOO
         0cw/O6IfSElCD4ZukRMZg+tWxfGfm/ROhKq9AFb2+DzhFmxR9Qwnl2NX5aPmXO6T3CD8
         q83tzAmtIQLJpIdhd/MCabOnGQnDUebYvYSMlmeatukcWu6m496VdC5CACDisYMl9vwD
         gMiw==
X-Gm-Message-State: AOAM532ZShDQocgeueez3AiIh/ML3uhjBTLdlpp50kYBwsPi4Macw+3U
        843va042Ig4kVAT6mlBLEnfYQrtLJ/ntbuwzfOlthK4citgGjRZV
X-Google-Smtp-Source: ABdhPJwQI27StjJcIkNo6A4hREAUndnNhd8SGeSzRiwJWhCh4T1ew06nZ2wzfERbpHP9ISi0muNsGP1t0stNYkY0e60=
X-Received: by 2002:a5e:8903:: with SMTP id k3mr7415934ioj.36.1612025893940;
 Sat, 30 Jan 2021 08:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20210115094744.21156-1-rui.zhang@intel.com> <002601d6ec2a$36663da0$a332b8e0$@net>
 <000901d6f418$1a9b34e0$4fd19ea0$@net> <53074020f2b19a38811eec925457e828581658f3.camel@intel.com>
In-Reply-To: <53074020f2b19a38811eec925457e828581658f3.camel@intel.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sat, 30 Jan 2021 08:58:02 -0800
Message-ID: <CAAYoRsXcPSJ5N-n6FC31kRkewJYEXC9PSk+r7gnMrt40ppUDAQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/intel: introduce tcc cooling driver
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     daniel.lezcano@linaro.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 28, 2021 at 9:30 AM Zhang Rui <rui.zhang@intel.com> wrote:
> On Tue, 2021-01-26 at 11:18 -0800, Doug Smythies wrote:
> > On 2021.01.16 09:08 Doug Smythies wrote:
> > > On 2021.01.15 Zhang Rui wrote:
...
> > They should have been: RATL and RATLL.
> >
> > From the proper page of the book:
> >
> > > Running Average Thermal Limit Status (R0)
> > > When set, frequency is reduced below the operating
> > > system request due to Running Average Thermal Limit
> > > (RATL).
> >
>
> > 2.) Due to the already discussed turbostat issue, that was not
> > the actual temperature and so the RATL bit being set was actually
> > valid at that time.
> >
> On my side, I got the "Thermal status bit" set.

Yes, and if I understand your comment correctly, you are referring
to IA32_THERM_STATUS (0X19C) and/or
IA32_PACKAGE_THERM_STATUS (0X1B1). I am referring to
MSR_CORE_PERF_LIMIT_REASONS (0X64F).

>
> > I have not been able to find the time window knob for this, if there
> > even is one, similar to the time window knobs for the package power
> > limits.

I just assume there is a time window, similar to the RAPL based
power limits. But I haven't found it.

> > I wanted to reduce the time constant, just as a test, in an attempt
> > to reduce the step function load potential temperature overshoot.
...

> >
> Thanks for your test.
> I'd prefer this is platform specific.
> Because it behaves really differently from what I observed.

O.K. These oddities aside, in the end it does do
the expected job.

> 99.06   2036    14195   66      12.27
> 99.07   2007    14240   66      12.07
> 99.12   2888    12147   98      28.23   <<< offset cleared
> 99.03   3413    11503   98      37.21
> 98.96   3317    11698   98      34.64

very close to critical temp.
I never knowingly allow my processor
to go above 80 degrees.
Although, I admit it hit 90 degrees a couple of
times during this work.

> 99.07   3246    11410   98      32.89
> 98.95   3210    12107   98      32.13
> 98.94   3164    11790   98      31.08
> 99.00   3124    12106   98      30.84
> 99.00   3086    11876   98      29.60
> 98.94   3054    12482   98      29.00
> 98.89   3030    12629   98      28.54
> 99.39   2377    10764   82      17.62   <<< Didn't do anything, so it
> is probably thermald or something

or critical temp hit.

>
> I tried both tests, and the results are the same, in both cases, it
> starts throttling immediately (within a second), and no over-throttling
> observed.
>
> Do you have a script to do this?

No, all of my tests were done manually, varing:
. placement of high loads on some cores for more heat over smaller surface area.
. balance between 100% CPU load at max heat verses 100% CPU load at less heat.
. balance between this TCC Offset throttling verses package power limits
. using ambient (coolant temperature) as a heat removal capacity knob.

In summary: I played around until I found something interesting.

> Say, run turbostat in background and
> then change tcc offset at certain timestamp? Maybe we can try exactly
> the same test on different machines.

I had an idea, and wasted way way too much time trying to make it work.
I thought to just get turbostat to also show the offset, so then we know for
certain when it changed. I tried virtually all combinations of:

turbostat --Summary --quiet --add
/sys/devices/virtual/thermal/cooling_device11/cur_state,,,,TCC --show
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 1
turbostat --Summary --quiet --add msr0x1a2,u32,package,raw,TCC --show
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 1

and could never get it to work in "Summary" mode. (note: about 95% of
my use of turbostat is in "Summary" mode.)

Anyway, after too long, I did get this to work:

turbostat --quiet --cpu 0 --add
/sys/devices/virtual/thermal/cooling_device11/cur_state,u32,,raw,TCC
--show CPU,Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 1 | grep "^ 0"

Example 1:

turbostat --quiet --cpu 0 --add
/sys/devices/virtual/thermal/cooling_device11/cur_state,u32,,raw,TCC
--show CPU,Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 1 | grep "^0"
CPU     Busy%   Bzy_MHz IRQ            TCC      PkgTmp  PkgWatt
0       100.26  4500    1002    0x00000001      78      99.88 <<< Offset = 1
0       100.26  4501    1002    0x00000001      77      99.90 <<<
steady state power limit throttle
0       100.26  4501    1004    0x00000001      77      99.92
0       100.26  4500    1002    0x0000001e      78      99.91   <<<
offset changed, trip int 70
0       100.25  4502    1003    0x0000001e      77      100.03
0       100.25  4503    1002    0x0000001e      77      99.85
0       100.25  4502    1002    0x0000001e      78      99.92
0       100.26  4501    1003    0x0000001e      78      99.95
0       100.25  4503    1002    0x0000001e      77      99.88
0       100.25  4502    1002    0x0000001e      78      99.86
0       100.25  4502    1004    0x0000001e      77      99.92
0       100.25  4503    1002    0x0000001e      77      99.98
0       100.25  4502    1002    0x0000001e      77      99.88
0       100.26  4498    1004    0x0000001e      77      100.06
0       100.26  4501    1002    0x0000001e      78      99.77
0       100.26  4500    1002    0x0000001e      78      99.53
0       100.26  4430    1002    0x0000001e      72      91.19  <<<
Thermal throttling. 13 Seconds
0       100.26  4400    1002    0x0000001e      72      87.55
0       100.26  4400    1002    0x0000001e      71      87.52
0       100.26  4400    1005    0x0000001e      71      87.56
0       100.26  4400    1002    0x0000001e      72      87.53

Example 2:

0       100.26  4600    1002    0x00000000      83      113.26 <<< Offset = 0
0       100.26  4600    1002    0x00000000      84      113.43
0       100.25  4599    1002    0x00000000      83      113.42 <<< No
power limit throttle yet.
0       100.26  4600    1004    0x00000000      83      113.40 <<< Not
steady state.
0       100.26  4600    1002    0x00000000      83      113.25
0       100.25  3797    1003    0x00000018      56      54.11  <<<
Overshoot is immediate.
0       100.26  3700    1002    0x00000018      56      47.09
0       100.26  3700    1002    0x00000018      55      47.08
0       100.26  3700    1002    0x00000018      54      46.98
0       100.26  3820    1002    0x00000018      58      51.62  <<<
starts to recover.
0       100.26  4016    1002    0x00000018      62      61.55
0       100.26  4177    1002    0x00000018      64      69.91
0       100.26  4275    1004    0x00000018      68      75.81
0       100.26  4300    1002    0x00000018      68      77.36
0       100.26  4371    1002    0x00000018      71      84.53
0       100.26  4400    1002    0x00000018      72      87.52
0       100.26  4400    1003    0x00000018      72      87.62

Example 3:
This test is specifically an attempt to test the TCC Offset in the exact
way I intend to use it. trip point = 75 degrees, and never changes.
Power limit 2 is 115 watts, timing window short.
Power limit 1 is 100 watts , timing window 8 seconds.
Note: all previous work was with the timing window at 28 seconds.
Note: typically temperature < 75 at 100 watts.

The load is 4 prime95 maximum heat threads, plus 0 weaker memory
hammering threads.

The collant had to be preheated for about an hour before this test
started, otherwise
the  processor would not get hot enough before package power limit 1
took over the
throttling duties.

Now, watching the TCC offset is useless for this test, so let's watch
MSR_CORE_PERF_LIMIT_REASONS instead:

turbostat --add msr0x64f,u32,,raw,TCC --show
CPU,Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ,RAMWatt --interval 1 | grep "^0"

(O.K., I should have changed the added column name. I filter it
anyhow, but manually added back, edited.)

CPU     Busy%   Bzy_MHz IRQ            TCC      PkgTmp  PkgWatt RAMWatt
0       0.07    1081    5       0x08200000      38      2.31    0.45
<<< Note high idle start temp.
0       0.16    824     11      0x08200000      38      2.12    0.45
0       1.74    3430    44      0x00000000      38      2.65    0.45
<<< clear last times log bits
0       0.16    851     6       0x00000000      37      2.27    0.45
0       4.32    3313    269     0x00000000      75      47.15   0.45
<<< load applied
0       4.24    4585    458     0x08000800      78      97.16   0.45
<<< package power limit 2
0       2.80    4588    482     0x08000000      77      97.49   0.45
<<< temperature just high
0       2.87    4593    463     0x08000000      78      97.95   0.45
0       3.39    4600    465     0x08000000      78      97.68   0.45
0       2.66    4600    462     0x08000000      78      97.55   0.45
0       2.28    4584    490     0x08000000      78      97.97   0.45
0       3.29    4583    478     0x08000000      78      97.72   0.45
0       3.24    4595    465     0x08000000      77      97.52   0.45
0       2.47    4600    465     0x08000000      78      97.50   0.45
0       4.18    4570    464     0x08000000      78      97.72   0.45
0       2.51    4600    470     0x08000000      78      97.40   0.45
0       1.77    4601    482     0x08000000      78      97.33   0.45
0       3.13    4584    462     0x08000000      78      97.57   0.45
0       3.06    4600    466     0x08000000      78      97.77   0.45
0       2.86    4592    461     0x08000000      78      97.56   0.45
0       2.85    4569    486     0x08000000      78      97.99   0.45
0       2.96    4600    465     0x08000000      78      97.91   0.45
0       3.00    4585    451     0x08000000      78      97.68   0.45
0       2.06    4600    475     0x08000000      78      97.50   0.45
0       3.05    4594    462     0x08000000      78      97.78   0.45
0       3.11    4592    461     0x08000000      78      97.68   0.45
0       2.31    4546    463     0x08200020      73      93.00   0.45  <<< RATL
0       2.80    4525    454     0x08200000      78      91.29   0.45
<<< Oscillates within
0       3.32    4538    445     0x08200020      73      91.61   0.45
<<< 1 pstate
0       3.27    4557    434     0x08200000      78      93.12   0.45
0       3.26    4523    470     0x08200020      73      89.85   0.45
<<< rough estimate is
0       2.48    4586    466     0x08200020      74      95.67   0.45
<<< oscillation costs 0.4%
0       1.95    4521    468     0x08200000      76      87.93   0.45
<<< performance loss verses
0       3.28    4569    449     0x08200020      73      94.67   0.45
<<< the power limit 2 servo.
0       0.44    4546    495     0x08200000      78      91.77   0.45
<<< (very crude, hard to defend
0       1.91    4518    487     0x08200020      73      91.24   0.45 <<< data.)
0       3.25    4539    460     0x08200000      78      91.63   0.45
0       2.51    4546    469     0x08200020      74      91.12   0.45
0       3.60    4540    453     0x08200000      77      91.43   0.45
0       3.06    4542    463     0x08200020      73      91.56   0.45

... Doug
