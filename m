Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE26D14C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfGRPqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 11:46:17 -0400
Received: from cmta19.telus.net ([209.171.16.92]:49016 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbfGRPqR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jul 2019 11:46:17 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id o8bkhqokTeRl4o8blhOcLP; Thu, 18 Jul 2019 09:46:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1563464775; bh=mVkYOwmlxltPKk5pb2xFBcelvRiAZC0mcU3/BDiQ4B0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=mj31ivkfJkrDgidbA+fnhVI1sdZFfvKBB8GtYskUdT15VZVlZG/tJPh0xdMBb6iYU
         DM29EMz9H4Uen/5oc8j+rVy19mMWtGdQGoCIwRpBTDJVTpK9x9MBUZ+I+GLBmba5Pt
         mSq/E0GNPNXU4YDpK4mwJDiFpBKn4affX/axLK/YIORD+ZqJ+VJ1TAfUPd4SObA0FS
         WG1FjjYNGinZntsb2SH+6lcaZ5GmDAvdS2QrO9NV+zy/6tv62s3juPtAdrKdD21EPo
         4gYFfn70CgyS+RHG5g/K9axpJb8YUfpk84Bn8cjTKkcBsXE0Tbd5WsZkS0GAQsLhl7
         lD7T8805IUeSA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=KqozJleN c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=eFVlzxBfIiMtakjo8QYA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <rjw@rjwysocki.net>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <1563431200-3042-1-git-send-email-dsmythies@telus.net> <20190718102815.utl3hanfc7fpf2i6@vireshk-i7>
In-Reply-To: <20190718102815.utl3hanfc7fpf2i6@vireshk-i7>
Subject: RE: [PATCH] Revert "cpufreq: schedutil: Don't set next_freq to UINT_MAX"
Date:   Thu, 18 Jul 2019 08:46:11 -0700
Message-ID: <000001d53d7f$ee306e70$ca914b50$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdU9U4WU+RUApGW9To2f2s/KpwKxbQAJKeLQ
X-CMAE-Envelope: MS4wfJ2Bg1Rz6wMqwuFFCk4EurQLFYsagfd9rapxiz/3TUvT8h1qG8dx5jYHJXM0ohLVrdEzLnbqZ7mb57LgYfOZXk5eauzje9zbpaiGnpZU1Qfvg6lrXdmb
 Q6rsDcB0/uu5vrxyZew8/xlhT8IDbwkgbyiPJnGRevbLf3WEfYD2jnfWKsnbMVNddYlllUmqpzKfiyfytZ5am2+fTQ2ssjaW71fyRFKRJeCcxx33DOLRCpe2
 PQikT/6c/Z+NgnIRoiupX/MBRlnRwIF64Nk3vBfWk5oGTgsawYyLB7TIif5fFcVxLGdov6WH6e0pkiRoMxg5ZOL9DDzacms3ATUJe1KvUgg=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.07.18 03:28 Viresh Kumar wrote:
> On 17-07-19, 23:26, Doug Smythies wrote:
>> This reverts commit ecd2884291261e3fddbc7651ee11a20d596bb514.
>> 
>> The commit caused a regression whereby reducing the maximum
>> CPU clock frequency is ineffective while busy, and the CPU
>> clock remains unchanged. Once the system has experienced
>> some idle time, the new limit is implemented.
>
> Can you explain why this patch caused that issue ? I am sorry but I couldn't
> understand it from your email. How are we trying to reduce the frequency? Is
> clk_set_rate() getting called with that finally and not working ?

The patch eliminates the "flag", UNIT_MAX, and it's related comment,
that was used to indicate if it was a limit change that causes the
subsequent execution of sugov_update_single.

As for "clk_set_rate()", I don't know. I bisected the kernel
and got here. I also looked at reverting B7EAF1AAB9F8, but
it seemed to have some purpose which I don't know of more
important than this one or not.

I'll reinsert the first test below with more detail:

On 2019.07.17 23:27 Doug wrote:

> Driver: intel_cpufreq ; Governor: Schedutil
> Kernel 5.2:

$ uname -a
Linux s15 5.2.0-stock #608 SMP PREEMPT Mon Jul 8 08:21:56 PDT 2019 x86_64 x86_64 x86_64 GNU/Linux

doug@s15:~$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
doug@s15:~$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
schedutil
schedutil
schedutil
schedutil
schedutil
schedutil
schedutil
schedutil

> Test 1: No thermal throttling involved (I only ever use thermal, if anything):

doug@s15:~$ sudo systemctl status thermald.service
. thermald.service - Thermal Daemon Service
   Loaded: loaded (/lib/systemd/system/thermald.service; disabled; vendor preset: enabled)
   Active: inactive (dead)

> - load the system (some sort of CPU stress test).

Use whatever you want. I use my own, only because I always have and it prints something
every so often which gives an indication of actual clock speed.

doug@s15:~$ ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 &
[1] 3000
[2] 3001
[3] 3002
[4] 3003
[5] 3004
[6] 3005
[7] 3006
[8] 3007
[9] 3008

Watch everything with turobstat:

doug@s15:~$ sudo turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 5
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
0.03    1600    269     25      3.69
0.07    1600    390     25      3.72
0.06    1600    368     25      3.72
0.06    1600    343     25      3.71
0.04    1600    269     26      3.70
74.72   3474    30230   46      43.95  <<< Add load
100.00  3500    40228   50      58.27
100.00  3500    40196   52      58.59
100.00  3500    40215   55      58.91
100.00  3500    40211   56      59.12
100.00  3500    40291   58      59.33  <<< Try to set 60% max
100.00  3500    40278   59      59.55
100.00  3500    40591   61      59.73
100.00  3500    40279   61      60.10
100.00  3500    40292   63      60.35
100.00  3500    40401   64      60.85
99.99   3500    40352   65      61.12
100.00  3500    40230   67      61.32
100.00  3500    40228   67      61.52
100.00  3500    40400   68      61.60  <<< Try to set 42% max
100.00  3500    40279   69      61.74
100.00  3500    40258   68      61.85
100.00  3500    40226   70      62.01
100.00  3500    40220   70      62.10
100.00  3500    40211   71      62.25

> - adjust downwards the maximum clock frequency
>   echo 60 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct

doug@s15:~/temp$ echo 60 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
60
doug@s15:~/temp$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
60
... wait awhile ...
doug@s15:~/temp$ echo 42 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
42
doug@s15:~/temp$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
42

> - observe the Bzy_MHz does not change on the turbostat output.

See annotated turbostat output above.

> - reduce the system load, such that there is some idle time.
> - observe the Bzy_MHz now does change.
> - increase the load again.
> - observe the CPU frequency is now pinned to the new limit.

Go back to 60% first:

doug@s15:~/temp$ echo 60 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
60
killall test1
... wait awhile ...
doug@s15:~$ ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 & ~/c/test1 &
[1] 3040
[2] 3041
[3] 3042
[4] 3043
[5] 3044
[6] 3045
[7] 3046
[8] 3047
[9] 3048

doug@s15:~$ sudo turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 5
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
100.00  3500    40289   80      64.32
100.00  3500    40223   79      64.16
100.00  3500    40212   79      64.14
100.00  3500    40269   79      64.17
100.00  3500    41330   79      64.19  <<< Freq is above the 60% limit
14.10   3489    6260    55      12.63  <<< Load removed, now not "busy"
0.03    1600    263     53      4.13   <<< see sugov_update_single
23.22   2293    9582    65      10.72  <<< Load applied
100.00  2300    40229   66      35.09  <<< 3.8 GHz * 0.6 = 2.3 GHz
100.00  2300    40209   66      35.21
100.00  2300    40211   65      35.20
100.00  2300    40219   65      35.16
100.00  2300    40224   65      35.14

The only procedure changes when using the acpi-cpufreq CPU scaling driver and
the schedutil governor are for setting and monitoring the max freq settings,
as described in the test write-ups.

Hope this helps.

... Doug


