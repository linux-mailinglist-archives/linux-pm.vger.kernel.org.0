Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175872F8F69
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 22:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbhAPVW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 16:22:26 -0500
Received: from cmta18.telus.net ([209.171.16.91]:53437 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbhAPVWY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Jan 2021 16:22:24 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 0t0ulGUd4jV150t0vl9x9F; Sat, 16 Jan 2021 14:21:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1610832103; bh=r0Oj789s3U2gSJXg+4rFLeuMj6V43AQDZT+1u6JT1k4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=W7YrzXISxLexAcXiJiEbZPNKekimndVMLlRwQ/17VvoSsZPh7VMb6NZlTQ2dSHznw
         97P1tHOhfB+bWJF0DXd8KcU/iymK2o7FLjWIVMxnnKcb0qirndaZveXHUDy6MZDTC3
         rXZQaiRXldv6+5luTeTgY7uiAw0CTAW+ipI4Nraz6bC+qLP+sQ8uR+0rta8q7VYqTS
         o+DVgXd2RVk6A5dHyZcTBz+eNZZ599HFy1/7pbBhkP2u5zOeWd+bIhASEFX7BZHwnt
         zh53nkbeRw/64IGoznng2y72mKgHmSeNlxBHmmDr1u1Bi9AEN99T5vE0nLHHbeoyz7
         QWzbrNm2kHJaQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=BeQdbph2 c=1 sm=1 tr=0 ts=600358e7
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=We-k2EUrKKbPqj7VQVgA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Zhang Rui'" <rui.zhang@intel.com>,
        "'Len Brown'" <len.brown@intel.com>
Cc:     <daniel.lezcano@linaro.org>, <srinivas.pandruvada@linux.intel.com>,
        <linux-pm@vger.kernel.org>, "'Doug Smythies'" <dsmythies@telus.net>
References: <20210115094744.21156-1-rui.zhang@intel.com> <002601d6ec2a$36663da0$a332b8e0$@net>
In-Reply-To: <002601d6ec2a$36663da0$a332b8e0$@net>
Subject: RE: [PATCH] thermal/intel: introduce tcc cooling driver
Date:   Sat, 16 Jan 2021 13:21:39 -0800
Message-ID: <003f01d6ec4d$96038ba0$c20aa2e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdbrIkJv3Xd49VUQTf+fLZID/bj4xQAuumUQABi0bdA=
Content-Language: en-ca
X-CMAE-Envelope: MS4xfC4BhKPI9P6w4vKcAfh5T67nKTlCeTFOim5IH0jGhN4nfv5oQxhxNmdTIqe4Wfl4PsP0XpHVRSuP5QW3nn5nisIgUZd/RmHkFRoTni9eIQMLaBjmUC1h
 CxxJ2VV7JLYXdlq9IEGRpaDOEDlZzhmk5Szn+YPx89lkGnzzCLV/lN2t0HD0nAMbHukwazEl3uGObsQ858emKladB2b7t9KBt/jsLl2wu+g+NyqYWndQ3fRy
 SSve4Lskbfl7cALe0RQI+bry/fg176ZEebnkzLthy3pDMJyjagcd/vt1p8ZfVCAYQQICX7dsDfOJfIA9cuvAbWkoPyuVOf0X09AdXjd4OKdN22s30+6MQRtj
 dyEIohdH
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021.01.16 09:08 Doug Smythies wrote: 
> On 2021.01.15 Zhang Rui wrote:

Added Len to the "To" list:

Turostat has another issue with this stuff.
It will be more work than I want to do to submit a fix patch, so I am not,
but see further down for my hack fix.

...

> Example step function overshoot, trip point set to 55 degrees C.
> 
> doug@s18:~$ sudo ~/turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --
> interval 1
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 0.07    800     45      24      1.89    0.00
> 0.04    800     29      23      1.89    0.00
> 61.76   4546    4151    66      103.77  0.00 < step function load applied on 4 of 6 cores
> 67.76   4570    4476    66      120.42  0.00
> 68.03   4567    4488    66      120.73  0.00
> 67.98   4572    4492    67      121.00  0.00 < 19 degrees over trip point
> 68.10   4489    4493    58      109.19  0.00 < this throttling is either the power servo or the temp
> servo.
> 68.08   4262    4476    51      82.82   0.00 < this throttling is the temp servo.
> 68.13   4143    4513    48      75.16   0.00
> 68.03   4086    4488    46      71.87   0.00 < It actually undershoots often, I don't know why.
> 68.12   4000    4505    46      67.02   0.00 < often it doesn't undershoot.

It turns out that tubostat does not list the package
temperature properly if it is started with an active TCC offset.
It erroneously includes the offset in the temperature math.
In the above example turbostat had also not yet been fixed for the
bit mask issue. So the real temp above was 59 degrees C.

> 68.44   4000    4502    45      67.16   0.00
> 68.06   4000    4483    45      66.95   0.00
> 68.02   3973    4490    44      65.20   0.00
> 67.94   3900    4489    43      60.51   0.00
> 67.88   3900    4501    44      60.55   0.00
> 67.85   3900    4472    43      60.52   0.00

And it settled at about 56 degrees, close to what was asked for.

To proceed with my work, I did a hack fix to turbostat:

doug@s18:~/temp-k-git/linux/tools/power/x86/turbostat$ git diff
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d7acdd4d16c4..7f0a22ab3a0d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4831,6 +4831,7 @@ int read_tcc_activation_temp()
                fprintf(outf, "cpu%d: MSR_IA32_TEMPERATURE_TARGET: 0x%08llx (%d C) (%d default - %d offset)\n",
                        base_cpu, msr, tcc, target_c, offset_c);

+       tcc = target_c;
        return tcc;
 }

So this:

cpu4: MSR_IA32_TEMPERATURE_TARGET: 0x2b64100d (57 C) (100 default - 43 offset)
cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x88420000 (-9 C)

becomes this:

cpu1: MSR_IA32_TEMPERATURE_TARGET: 0x2b64100d (57 C) (100 default - 43 offset)
cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x88400000 (36 C)

and this:

Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
0.08    1079    928     -11     1.91    0.00

Becomes this:

Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
0.05    1046    846     32      1.94    0.00

So now back to my overshoot example:

This:

> 67.98   4572    4492    67      121.00  0.00 < 19 degrees over trip point

Was actually:

> 67.98   4572    4492    80      121.00  0.00 <<< 25 degrees over trip point

But let's just do it again:

doug@s18:~$ cat /sys/devices/virtual/thermal/cooling_device11/cur_state
43       <<< so 100 - 43 = 57 degrees trip point.
doug@s18:~$ sudo ~/turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 0.25
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
0.09    800     6       36      2.01    0.00
0.16    800     23      36      2.00    0.00
0.11    800     14      36      2.15    0.00
66.81   4461    1160    70      101.17  0.00 <<< load applied, temp up 34 degrees in less than 0.25 seconds. Normal.
68.06   4581    1126    74      117.36  0.00
67.69   4589    1119    76      119.60  0.00
67.80   4589    1125    77      120.94  0.00
67.83   4587    1132    78      120.75  0.00
67.68   4591    1125    78      121.63  0.00
68.07   4585    1139    77      121.25  0.00
67.80   4588    1121    79      121.41  0.00 <<< now 20 degrees over trip point.
68.57   4579    1139    79      121.71  0.00
...
68.03   4220    1130    63      80.28   0.00 <<< it takes quite awhile (>7 seconds) to really throttle down.

... Doug


