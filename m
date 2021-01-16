Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F682F8DC8
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 18:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhAPRJR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 12:09:17 -0500
Received: from cmta19.telus.net ([209.171.16.92]:41724 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbhAPRJN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Jan 2021 12:09:13 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 0p3qlG1kyxoDi0p3slzzsF; Sat, 16 Jan 2021 10:08:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1610816910; bh=JQ1lIQOw/FQhQdyihlNdeL4ktOlij8E6lAkowA8vVPg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=62ip32+bQMWpDwPvK8BsqUoUci/+Z+ZIbQI6vsfuval2J8SWFbPFLlAukgsoeZIUs
         6vM2GgAnRgPInNVoQ19jhjpA6jFVP585xLBGdIxdfKX+ybGLMhNsF1Vq1CCWAc4H18
         Q1SVkrPISfDUL0hJAbwg90kTj5cZzMhKzRxVR56KFns/ExKRSLqfSHjn/AV9R5Mo22
         EcGI6CyezufUof4JfDqOa1xQLFKbjbudbxk6f8ZGqaMqS0Qdz4mLEtX2EMyEs3iOpb
         nHk+d6TOGpT0bCvXOJN5fKUK7Knqf9aAWwOTsY7QlhKAiNnlPEWG6TGbSJi8H2ta0O
         ArsrUMH/Sj2hQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=ctJeL30i c=1 sm=1 tr=0 ts=60031d8e
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=aatUQebYAAAA:8
 a=skdSOlplxTDZW_2ePFQA:9 a=CjuIK1q_8ugA:10 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Zhang Rui'" <rui.zhang@intel.com>
Cc:     <daniel.lezcano@linaro.org>, <srinivas.pandruvada@linux.intel.com>,
        <linux-pm@vger.kernel.org>
References: <20210115094744.21156-1-rui.zhang@intel.com>
In-Reply-To: <20210115094744.21156-1-rui.zhang@intel.com>
Subject: RE: [PATCH] thermal/intel: introduce tcc cooling driver
Date:   Sat, 16 Jan 2021 09:08:26 -0800
Message-ID: <002601d6ec2a$36663da0$a332b8e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdbrIkJv3Xd49VUQTf+fLZID/bj4xQAuumUQ
Content-Language: en-ca
X-CMAE-Envelope: MS4xfEFPzzj+ZSNq7CLh2pOs4LDiCDQlUhrwBfQjg/8yirKr/JaqqmOwKIwUS2xKLV02rEP9uwBpvpvOJW19uoiELEl2k0cGynXFFSehkizV98hlAzmD83+8
 rueChHB0lLFXLjv/oHcokSWdzNBWcz9sS5Fp5kTrHiLFMLQoglArnDQV99z4FnFDQQ5IiCC7D+ID/jqJL0QotpgYLXt21OTUuY2WnMH4aUbtEIvlFzpa9Uej
 ZNrQBp8RXwS4gZSGX+lO270WnxKyMNKJBn1sH5OXVXVQ+oHA2Se18REUTXyJVMqGRxqb1UltgWni4ElSuZSJAA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021.01.15 Zhang Rui wrote:
> 
> On Intel processors, the core frequency can be reduced below OS request,
> when the current temperature reaches the TCC (Thermal Control Circuit)
> activation temperature.
> 
> The default TCC activation temperature is specified by
> MSR_IA32_TEMPERATURE_TARGET. However, it can be adjusted by specifying an
> offset in degrees C, using the TCC Offset bits in the same MSR register.
> 
> This patch introduces a cooling devices driver that utilizes the TCC
> Offset feature. The bigger the current cooling state is, the lower the
> effective TCC activation temperature is, so that the processors can be
> throttled earlier before system critical overheats.

Thank you for this useful patch.
My systems don't need thermald or any other thermal control, but it is nice
to have this extra margin to add to the critical stuff, as a backup.
I also like to use the offset to test stuff.

I use the internal power limit servo for power limiting,
and that servo works very well indeed. Using this temperature
offset as a way to servo the thermal operating limit does work,
but tends to overshoot, oscillate, hold low excessively long
(minutes). It also seems to limit CPU clock frequency reduction
to the non-turbo limit, regardless of the desired maximum
temperature.

I am not familiar with the thermal stuff at all, and didn't know
where to find the trip point knob. Anyway, found "cooling_devices11".

I do not understand this:

~$ cat /sys/devices/virtual/thermal/cooling_device11/stats/trans_table
cat: /sys/devices/virtual/thermal/cooling_device11/stats/trans_table: File too large

Rather than enter the actual TCC offset, I would rather enter the desired trip
point, and have the driver do the math to convert it to the offset.

Example step function overshoot, trip point set to 55 degrees C.

doug@s18:~$ sudo ~/turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 1
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
0.07    800     45      24      1.89    0.00
0.04    800     29      23      1.89    0.00
61.76   4546    4151    66      103.77  0.00 < step function load applied on 4 of 6 cores
67.76   4570    4476    66      120.42  0.00
68.03   4567    4488    66      120.73  0.00
67.98   4572    4492    67      121.00  0.00 < 19 degrees over trip point
68.10   4489    4493    58      109.19  0.00 < this throttling is either the power servo or the temp servo.
68.08   4262    4476    51      82.82   0.00 < this throttling is the temp servo.
68.13   4143    4513    48      75.16   0.00
68.03   4086    4488    46      71.87   0.00 < It actually undershoots often, I don't know why.
68.12   4000    4505    46      67.02   0.00 < often it doesn't undershoot.
68.44   4000    4502    45      67.16   0.00
68.06   4000    4483    45      66.95   0.00
68.02   3973    4490    44      65.20   0.00
67.94   3900    4489    43      60.51   0.00
67.88   3900    4501    44      60.55   0.00
67.85   3900    4472    43      60.52   0.00
67.96   3900    4481    43      60.59   0.00
68.26   3900    4501    44      60.70   0.00
67.93   3900    4498    43      60.58   0.00
68.03   3900    4476    43      60.68   0.00
67.83   3900    4481    44      60.54   0.00
35.06   3895    2412    25      32.13   0.00 < load removed.
0.04    800     25      24      1.89    0.00
0.04    800     22      23      1.89    0.00
0.06    800     35      23      1.90    0.00
0.03    800     18      23      1.89    0.00
0.04    800     26      22      1.90    0.00
0.30    1927    44      23      1.97    0.00
^C0.10  800     25      23      1.91    0.00

Example long time to recover:
(actually, this example never recovers, unusual):
Note: 3.7 GHz is the limit.

doug@s18:~$ sudo ~/turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 30
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
67.58   3700    134812  42      52.15   0.00 <<< the trip point was changed from 37 to 57 degrees
67.90   3700    134964  42      52.08   0.00
68.07   3700    134424  42      52.06   0.00
68.01   3700    134415  41      50.76   0.00
68.14   3700    134521  41      50.78   0.00
68.11   3700    134424  42      50.75   0.00
68.03   3700    134329  42      50.70   0.00
68.11   3700    134321  42      50.76   0.00
68.05   3700    134456  42      51.09   0.00
68.12   3700    134549  42      52.21   0.00
68.12   3700    134482  42      52.19   0.00
68.10   3700    134301  42      52.20   0.00
68.11   3700    134444  42      52.14   0.00
68.08   3700    134422  42      52.17   0.00
68.07   3700    134430  42      52.23   0.00
68.00   3700    134723  42      52.12   0.00
67.96   3711    135207  44      52.53   0.00 <<< It takes 8 minutes until the frequency goes above 3.7 GHz
68.05   3765    134519  42      54.34   0.00
68.11   3771    134461  43      54.60   0.00
67.83   3763    134867  43      54.26   0.00
67.93   3773    134577  43      54.78   0.00 <<< But it never recovers, Why not?
...

For unknown reason the processor seems to now
think it is not heavily loaded. From my MSR decoder:

0x64F: MSR_CORE_PERF_LIMIT_REASONS: 200020 AUTO AUTOL

From the book:

> Autonomous Utilization-Based Frequency Control
> Status (R0)
> When set, frequency is reduced below the operating
> system request because the processor has detected
> that utilization is low.

Which is not true.

Anyway,

Acked-by: Doug Smythies <dsmythies@telus.net>

... Doug


