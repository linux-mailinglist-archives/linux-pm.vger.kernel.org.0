Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E02FB288
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 08:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbhASHLs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 02:11:48 -0500
Received: from cmta18.telus.net ([209.171.16.91]:38171 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbhASHK6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Jan 2021 02:10:58 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 1l9SlRy8fjV151l9UlFlbG; Tue, 19 Jan 2021 00:10:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1611040210; bh=Vi8JNwbjWmRpAiqcEa4CHuGFMlkXmSu0FIsjUODYCrk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=HB6dgivezBMhxhYUwgsmy9gk7g/u9gMaRCKrfQ+RP5xygaRGIBww0g1mBK4fHnP7I
         Bd6RzWK90kpbt3jcO94CIC8J5fjzZPl6NZnnOORFFj2ftAzjXIghEvZLM8YkJvQgzq
         mkWXbBpCeq2Vh45Tbym/bqAdbT4DvKSjkElyI7u2QAV/lXSK+Rzumf+BWhcRyW3REi
         cqvgguRGYxH1Djq9f0aCPR7+ld5WAoF4NV/YrJCJXygbkp2/hgLAvjiD8Olm1CzEcQ
         cpQ9e1a3dURGjWb+j4wz82pZh1BoU/VhkckaZYaygCuiTRfrFZP717EwJG8qgTBm3b
         KhiqlwAq+VtTQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=BeQdbph2 c=1 sm=1 tr=0 ts=600685d2
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=kLbMzvnApaZ8Txf6CQcA:9
 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Zhang, Rui'" <rui.zhang@intel.com>
Cc:     <daniel.lezcano@linaro.org>, <srinivas.pandruvada@linux.intel.com>,
        <linux-pm@vger.kernel.org>, "'Brown, Len'" <len.brown@intel.com>
References: <20210115094744.21156-1-rui.zhang@intel.com> <002601d6ec2a$36663da0$a332b8e0$@net> <003f01d6ec4d$96038ba0$c20aa2e0$@net> <3942de4204d447228ecb2b8026aa1a51@intel.com>
In-Reply-To: <3942de4204d447228ecb2b8026aa1a51@intel.com>
Subject: RE: [PATCH] thermal/intel: introduce tcc cooling driver
Date:   Mon, 18 Jan 2021 23:10:05 -0800
Message-ID: <002101d6ee32$1ef449f0$5cdcddd0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AQHW6yHiKpPnm28pL0qlE9q5Zsm1daop+AgAgABGv4CAAt0dgIAAbBKQ
X-CMAE-Envelope: MS4xfAMpKb8YWGV/eHMtMrYfZlXSPXy5IJpqL3QNAAe1/SR+w6Y4kYLCW9RtluCT0hhTA79mqQ5QxpgoW4LqIn7BdXB4tPxmQ8u/PNr4LJ3L989PpPqBwfe6
 AwYwAVuh6EOpi/j0OBXxSurg0EzuY7nBBbrsXDKYBaRrU/X155Lypaq4hwQq1eZAslfXFyFjscFr1aNZvUIhcoGeRBkUviTyriBauNbjt6eAq2Cn9XjVVhiC
 uz37Ck6XgGfaAdj3SP09dD5Hcq3cIxAv+SHcncumKP8WNhLbLS4OYvZulM5+m4hvkFyCv7srxm+X/pNKowcM5YVghNc/RLAo3+UJ+BFzCIw=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021.01.18 01:32 Zhang, Rui wrote:
>  On 2021.01.17 05:22 Doug Smythies wrote:
> > On 2021.01.16 09:08 Doug Smythies wrote:
> > > On 2021.01.15 Zhang Rui wrote:
...
>=20
> What platform this is?

My i5-9600K test server.
Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
6 CPUs and 6 cores.
Kernel: 5.11-rc3 + this patch.
Water cooled, with water pump always running full speed.

> On a KBL platform I'm running right now, with performance governor, =
and tcc offset set to 30
> (Effective TCC  is 70c), and also turbostat fixed,
> I can observe that
> 1. all cpus running at max turbo freq (3.9G) when idle, PkgTmp around =
40C
> 2. with load applied (I use stress tool to get 100% CPU load), the =
PkgTmp reports 70C and the
> frequency drops to  around 3G, IMMEDIATELY.
> 3. when I change TCC Offset to 60, cpu is throttled to around 200MHz, =
and the temperature is at around
> 50C, IMMEDIATELY.
> 4. when I change TCC Offset to  20, cpu freq raises to turbo range, =
and PkgTmp reaches 80C,
> IMMEDIATELY.

O.K. You should be able to measure "IMMEDIATELY" and tell us what it is.

>=20
> So in your test, there is something I don't understand. =F0=9F=98=8A
> a) it take such a long time (7+ seconds) to throttle

See test results below, it does seem to throttle quickly, but
then the temperature creeps up.

> b) it throttles to a frequency that is not low enough (in order to =
keep the system under effective TCC
> temperature, the frequency can be throttled to below turbo range, LFM, =
and even below LFM in my case)

c) it can take a long time to respond to an increase in allowed =
temperature. Likely
related to some integral term build up from condition "b" above, because =
yours isn't clamped
to 3.7 GHz, the response is more "immediate". I test both conditions, =
repeatedly below.

>=20
> Can you please try performance governor and 100% CPU load to see if =
the symptom is the same?

I did 100% load on 4 of 6 CPUs on purpose: So as not to hit PKG Limit #2 =
from the outset; To
have 2 CPUs idle, as I thought it might be more challenging.

In terms of maximum heat generation, or maximum energy used, I studied =
every method I could
find, including several of my own methods, settling on prime95 / torture =
test / max heat method.

Note: all previous work was done with the intel_pstate driver, HWP =
enabled, powersave governor.

Test 1: intel_cpufreq,  HWP enabled, performance governor.
Test 1.1: startup delay, requires faster sampling:
MSR_IA32_TEMPERATURE_TARGET: 0x2a64100d (58 C) (100 default - 42 offset)
at 58 degrees it shouldn't clamp.

doug@s18:~$ sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 0.25
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
0.02    4600    6       31      1.98    0.00
0.53    4600    41      31      2.54    0.00
33.29   4360    645     52      37.34   0.00 <<< PKG Limit #2 already =
engaged
99.03   4271    1512    59      121.84  0.00 <<< O.K. Seems additional =
throttling is "IMMEDIATE"
98.85   4244    1511    60      119.81  0.00
98.80   4239    1516    61      119.71  0.00
98.82   4230    1510    63      120.02  0.00
98.84   4228    1509    63      119.32  0.00
98.81   4230    1514    63      120.16  0.00
98.78   4224    1511    63      119.00  0.00
98.82   4226    1510    63      119.18  0.00
98.81   4225    1514    64      119.77  0.00
98.84   4225    1509    63      119.23  0.00
98.82   4225    1511    65      119.56  0.00 <<< But, what? Now 7 =
degrees over.
   Note: increase in waste heat for otherwise unchanged operating
   conditions is normal at high limits of operation.
   Note: I do not know the level of hysteresis, if any. This might be =
normal.
98.80   4227    1515    63      119.93  0.00
... delete 14.5 seconds ...
100.25  4217    1514    63      111.25  0.00
100.26  4200    1514    62      109.29  0.00 <<< O.K. finally brings it =
down.
100.26  4200    1509    62      109.15  0.00
... delete 8.75 seconds
100.26  4100    1509    60      101.64  0.00
100.26  4100    1511    60      101.61  0.00  <<< These two are =
important, because they
100.25  4010    1515    58      94.65   0.00  <<< reveal that we did not =
hit PKG Limit #1
                                              <<< 100.0 watts
                                              <<< and we know for =
certain it is the temp
                                              <<< servo.

Test 1.2: clamp and recover delay, requires slower sampling:

MSR_IA32_TEMPERATURE_TARGET: 0x3f64100d (37 C) (100 default - 63 offset)

$ sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 30
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
100.26  3700    180608  59      72.80   0.00
100.26  3700    180407  60      72.70   0.00 <<< steady state
100.26  3700    181663  59      72.65   0.00

100.26  3700    46322   59      72.66   0.00 <<< close to time offset =
set to 37)
100.26  3700    180508  60      72.93   0.00
100.26  3700    180396  59      74.24   0.00
100.26  3700    180330  60      74.74   0.00
100.26  3700    180359  59      74.77   0.00
100.26  3775    180327  64      79.08   0.00 <<< ~~2 minutes 30 seconds =
response time
100.26  3853    180369  62      84.72   0.00
100.26  3865    180571  64      85.83   0.00
100.26  3866    180383  62      85.90   0.00

Now, change to 1 second sample time and change the offset again,
but this time it is not clamped already first.

doug@s18:~$ sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 1
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
100.26  3875    6093    62      87.49   0.00=20
100.26  3800    6017    62      81.03   0.00 <<< by the way, notice the =
oscillations
100.26  3883    6023    64      87.98   0.00
100.26  3900    6020    64      89.52   0.00 <<< Processor package power =
oscillates quite a lot
100.26  3801    6021    62      81.09   0.00 <<< Frequency oscillates =
also.
100.26  3857    6021    64      85.70   0.00 <<< but in this region, 1 =
pstate ~=3D 10 watts
100.26  3900    6018    64      89.34   0.00
...
100.26  3852    6020    62      85.24   0.00
100.26  3800    6019    62      80.82   0.00
100.26  3885    6047    64      87.77   0.00 <<< trip point changed to =
70
100.26  3963    6017    67      94.88   0.00 <<< yes, offset change =
response is fast
100.26  4000    6017    67      98.35   0.00
100.26  4079    6018    69      105.17  0.00
100.26  4100    6017    69      107.02  0.00
... delete 25 seconds ...
100.24  4042    6017    67      102.16  0.00 <<< PKG Limit #1 takes over
100.23  4016    6017    67      99.84   0.00 <<< All throttling is now =
PKG Limit #1
100.23  4017    6024    68      99.84   0.00
100.23  4015    6026    67      99.77   0.00

Test 2: Test 2: intel_pstate,  HWP enabled, powersave governor.
Test 2.1: startup delay, requires faster sampling:
MSR_IA32_TEMPERATURE_TARGET: 0x2a64100d (58 C) (100 default - 42 offset)
at 58 degrees it shouldn't clamp.

$ sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 0.1
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
0.28    800     12      33      1.93
0.25    800     10      33      1.90
0.31    800     13      33      1.90
0.79    800     19      33      1.92
0.34    800     32      34      1.90
0.22    800     5       33      1.91   <<< ~ 77% of next sample is busy =
and 20 degrees already
61.91   4103    469     53      60.20  <<< 260 degrees per second
99.01   4264    610     56      121.94 <<< how much PKG Limit #2 and/or =
TCC loop, I don't know.
98.87   4251    614     61      120.74 <<< unthrottled would be 4.60 GHz
98.87   4235    609     62      119.87
98.85   4226    609     63      119.60
... delete 18.4 seconds
100.26  4100    613     62      102.41
100.26  4100    609     61      102.28
100.25  4040    609     60      97.49  <<< Don't know between PKG Limit =
#1 and/or TCC loop
100.26  4000    609     59      95.02  <<< definitely TCC loop
100.26  4000    615     60      94.01

Test 2.2: clamp and recover delay, requires slower sampling:

MSR_IA32_TEMPERATURE_TARGET: 0x3f64100d (37 C) (100 default - 63 offset)

sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 15
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
100.26  3700    90167   59      73.97
100.26  3700    90234   58      73.96
100.26  3700    90184   58      74.07

100.26  3700    4073    58      74.09 <<< close to time offset set to =
37)
100.26  3700    90222   59      74.12
100.26  3700    90169   59      74.19
100.26  3700    90294   59      73.03
100.26  3700    90164   59      72.63
100.26  3700    90174   59      72.62
100.26  3700    90163   58      72.60
100.26  3700    90208   59      72.58
100.26  3702    90164   60      72.73 <<< 2 minutes until response.
100.26  3831    90169   63      80.67
100.26  3880    90199   63      84.56
100.26  3889    90187   63      85.34
100.26  3900    90170   63      86.24
100.26  3900    90178   62      86.26

Now, change to 0.1 second sample time and change the offset again,
but this time it is not clamped already first.

$ sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 0.1
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
100.26  3900    609     63      89.02
100.26  3900    609     63      89.10

100.26  3900    131     63      89.47  <<< it takes a finite time =
between here and=20
100.26  3900    615     63      89.31  <<< the actual change of offset =
to 30
... delete 2.7 seconds...              <<< but nowhere near this long.
100.26  3900    614     63      90.08
100.24  3915    609     64      90.42  <<< O.K. responding.
100.26  4000    611     65      98.06
... delete 1.2 seconds ...
100.26  4000    609     65      98.27
100.24  4091    616     67      106.93
100.26  4100    610     68      106.74 <<< Next step.
100.26  4100    609     68      106.90
... delete 4.4 seconds ...
100.26  4100    609     68      108.02
100.24  4107    615     69      107.42 <<< Next step.
100.26  4200    609     70      115.93
100.26  4200    609     71      115.99
100.26  4200    610     71      117.14
100.26  4200    615     70      116.00
100.26  4200    609     70      116.17
100.26  4200    609     70      116.09
100.26  4200    612     71      117.23
100.26  4200    617     70      115.96
100.26  4200    611     70      116.10
100.26  4200    609     70      116.10
100.26  4200    609     70      117.38
100.26  4200    615     70      116.09
100.26  4200    610     70      116.12
100.26  4200    609     70      116.03
100.24  4117    609     69      109.74 <<< O.K. go down again.
100.26  4100    617     69      106.86


Test 3: intel_pstate,  HWP enabled, performance governor.
Test 3.1: startup delay, requires faster sampling:
MSR_IA32_TEMPERATURE_TARGET: 0x2a64100d (58 C) (100 default - 42 offset)
at 58 degrees it shouldn't clamp.

$ sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 0.1
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
0.06    4169    15      32      2.23
0.04    4598    6       33      2.03    <<< ~275 degrees per second
20.09   4599    268     45      15.37   <<< 12 degrees in ~43.7 mSec
99.10   4282    612     55      121.10  <<< how much PKG Limit #2 and/or =
TCC loop, I don't know.
98.94   4263    610     59      122.18
...delete 17.8 seconds. 63-66 degrees Example:
100.26  4300    609     66      118.93.
...
100.25  4154    610     62      106.06  <<< finally comes down again.
100.26  4100    609     62      101.90
... delete 4.5 seconds
100.26  4100    611     61      102.06
100.26  4100    609     61      102.10
100.25  4038    615     59      98.09   <<< finally gets to temp.
100.26  4000    610     59      93.84   <<< will oscillate here
100.26  4000    609     59      93.88   <<< between pstates 40 and 41
... delete 1.3 seconds ...
100.26  4000    615     58      94.81
100.26  4000    611     59      93.83
100.24  4030    609     60      96.27
100.26  4100    609     60      101.99 =20
100.26  4100    615     61      102.91
... delete 0.8 seconds ...
100.26  4100    614     61      103.44
100.25  4091    609     61      101.53
100.26  4000    610     59      94.07
...

Test 3.2: clamp and recover delay, requires slower sampling:

MSR_IA32_TEMPERATURE_TARGET: 0x3f64100d (37 C) (100 default - 63 offset)

sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 15
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
100.26  3700    90181   59      74.72
100.26  3700    90383   59      74.75

100.26  3700    2847    59      74.47 <<< close to time offset set to =
37)
100.26  3700    90240   59      74.83
100.26  3700    90164   59      74.83
100.26  3700    90225   59      74.85
100.26  3700    90219   59      74.90
100.26  3700    90191   59      74.86
100.26  3700    90166   59      74.86
100.26  3700    90164   59      74.80
100.26  3728    90286   60      76.19 <<< 2 minutes, because it was =
clamped.
100.26  3832    90162   64      82.67
100.26  3870    90177   63      85.94

Now, change to 0.1 second sample time and change the offset again,
but this time it is not clamped already first.

$ sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 0.1
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
100.26  3900    609     63      88.73
100.26  3900    615     63      88.83

100.26  3900    303     63      89.85 <<< it takes a finite time between =
here and
100.26  3900    615     63      88.91 <<< the actual change of offset to =
30
100.26  3900    610     64      89.64
... delete 2 seconds ...
100.26  3900    611     64      88.75
100.25  3911    609     64      89.58  <<< 1st response
100.26  4000    615     65      97.82
... delete 1.2 seconds ...
100.26  4000    615     66      98.77
100.24  4086    609     68      104.94 <<< next step
100.26  4100    609     67      106.35
...

Test 4: intel_pstate,  HWP enabled, performance governor.
Method of creating 100% CPU load changed to use much less
Energy per thread.
Test 4.1: startup delay, requires faster sampling:
MSR_IA32_TEMPERATURE_TARGET: 0x2a64100d (45 C) (100 default - 55 offset)

Multiple tests were run with 2 through 6 threads.
It took between 6 and 9 seconds to begin to throttle.

Example, 3 threads:
$ sudo ~/turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 1
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
0.01    4498    25      32      1.95
0.01    4603    17      32      1.93
0.01    4153    31      31      1.96
36.34   4600    2581    51      35.31 <<< load for last ~ 0.727 seconds.
51.13   4600    3562    52      47.88=20
50.77   4600    3620    52      47.98
51.03   4600    3551    52      48.11
51.13   4600    3596    53      48.14
50.87   4600    3627    52      48.20
51.30   4600    3535    52      48.30
51.17   4550    3534    50      46.26 <<< start throttling, ~ 7 seconds
51.27   4452    3567    48      42.05
50.82   4395    3585    47      39.68
51.28   4300    3529    46      36.53 <<< plus another couple to get =
there.
50.98   4300    3522    47      36.28
51.15   4219    3530    45      34.72
51.08   4200    3678    46      34.33
50.74   4200    3697    46      34.17
51.16   4200    3522    46      34.40
50.99   4126    3534    46      32.44
51.22   4100    3590    44      32.41

... Doug


