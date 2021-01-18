Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674162F9D14
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbhARKq6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 18 Jan 2021 05:46:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:22346 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389281AbhARJrT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Jan 2021 04:47:19 -0500
IronPort-SDR: lSL1rtmeyPPM+bjnLgLjmzj+hogY6UeF5DimhfzbJPp4rpaVLLj92ppVefisJ064QoWqknXqZ3
 7EM0D63Cb02w==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="158555512"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="158555512"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 01:46:34 -0800
IronPort-SDR: 5LkACl7sIG+dz4oXlTUEJ/B2/RqS5kvT4RiZhfL70B+aIfP8Sa6sAixN4z3YtKYCV/L/t4RE1O
 1NWQOONXXLgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="500598342"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2021 01:46:33 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 01:46:32 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 17:46:31 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.1713.004;
 Mon, 18 Jan 2021 17:46:30 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Doug Smythies <dsmythies@telus.net>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] thermal/intel: introduce tcc cooling driver
Thread-Topic: [PATCH] thermal/intel: introduce tcc cooling driver
Thread-Index: AQHW6yHiKpPnm28pL0qlE9q5Zsm1daop+AgAgAMrOtA=
Date:   Mon, 18 Jan 2021 09:46:30 +0000
Message-ID: <e04c36aae6eb4cbb9b99799290016d58@intel.com>
References: <20210115094744.21156-1-rui.zhang@intel.com>
 <002601d6ec2a$36663da0$a332b8e0$@net>
In-Reply-To: <002601d6ec2a$36663da0$a332b8e0$@net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Doug,

Thanks for testing this patch.

> -----Original Message-----
> From: Doug Smythies <dsmythies@telus.net>
> Sent: Sunday, January 17, 2021 1:08 AM
> To: Zhang, Rui <rui.zhang@intel.com>
> Cc: daniel.lezcano@linaro.org; srinivas.pandruvada@linux.intel.com; linux-
> pm@vger.kernel.org
> Subject: RE: [PATCH] thermal/intel: introduce tcc cooling driver
> Importance: High
> 
> On 2021.01.15 Zhang Rui wrote:
> >
> > On Intel processors, the core frequency can be reduced below OS
> > request, when the current temperature reaches the TCC (Thermal Control
> > Circuit) activation temperature.
> >
> > The default TCC activation temperature is specified by
> > MSR_IA32_TEMPERATURE_TARGET. However, it can be adjusted by
> specifying
> > an offset in degrees C, using the TCC Offset bits in the same MSR register.
> >
> > This patch introduces a cooling devices driver that utilizes the TCC
> > Offset feature. The bigger the current cooling state is, the lower the
> > effective TCC activation temperature is, so that the processors can be
> > throttled earlier before system critical overheats.
> 
> Thank you for this useful patch.
> My systems don't need thermald or any other thermal control, but it is nice
> to have this extra margin to add to the critical stuff, as a backup.
> I also like to use the offset to test stuff.
> 
> I use the internal power limit servo for power limiting, and that servo works
> very well indeed. Using this temperature offset as a way to servo the
> thermal operating limit does work, but tends to overshoot, oscillate, hold low
> excessively long (minutes). 

Do you have a script to test and show the drawbacks of this feature?
It seems that it behaves differently on different platforms.
Maybe we can evaluate this on more platforms.

> It also seems to limit CPU clock frequency
> reduction to the non-turbo limit, regardless of the desired maximum
> temperature.
> 
> I am not familiar with the thermal stuff at all, and didn't know where to find
> the trip point knob. Anyway, found "cooling_devices11".
> 
> I do not understand this:
> 
> ~$ cat /sys/devices/virtual/thermal/cooling_device11/stats/trans_table
> cat: /sys/devices/virtual/thermal/cooling_device11/stats/trans_table: File
> too large

This is a known issue that stats table can not handle devices with too many cooling states, say, 127 cooling states for TCC Offset cooling device.
We can ignore this for now.

> 
> Rather than enter the actual TCC offset, I would rather enter the desired trip
> point, and have the driver do the math to convert it to the offset.

Hmmm, a writable trip point? I need to think about this.

> 
> Example step function overshoot, trip point set to 55 degrees C.
> 
> doug@s18:~$ sudo ~/turbostat --Summary --quiet --show
> Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 1
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 0.07    800     45      24      1.89    0.00
> 0.04    800     29      23      1.89    0.00
> 61.76   4546    4151    66      103.77  0.00 < step function load applied on 4 of 6
> cores
> 67.76   4570    4476    66      120.42  0.00
> 68.03   4567    4488    66      120.73  0.00
> 67.98   4572    4492    67      121.00  0.00 < 19 degrees over trip point
> 68.10   4489    4493    58      109.19  0.00 < this throttling is either the power
> servo or the temp servo.
> 68.08   4262    4476    51      82.82   0.00 < this throttling is the temp servo.
> 68.13   4143    4513    48      75.16   0.00
> 68.03   4086    4488    46      71.87   0.00 < It actually undershoots often, I don't
> know why.
> 68.12   4000    4505    46      67.02   0.00 < often it doesn't undershoot.
> 68.44   4000    4502    45      67.16   0.00
> 68.06   4000    4483    45      66.95   0.00
> 68.02   3973    4490    44      65.20   0.00
> 67.94   3900    4489    43      60.51   0.00
> 67.88   3900    4501    44      60.55   0.00
> 67.85   3900    4472    43      60.52   0.00
> 67.96   3900    4481    43      60.59   0.00
> 68.26   3900    4501    44      60.70   0.00
> 67.93   3900    4498    43      60.58   0.00
> 68.03   3900    4476    43      60.68   0.00
> 67.83   3900    4481    44      60.54   0.00
> 35.06   3895    2412    25      32.13   0.00 < load removed.
> 0.04    800     25      24      1.89    0.00
> 0.04    800     22      23      1.89    0.00
> 0.06    800     35      23      1.90    0.00
> 0.03    800     18      23      1.89    0.00
> 0.04    800     26      22      1.90    0.00
> 0.30    1927    44      23      1.97    0.00
> ^C0.10  800     25      23      1.91    0.00
> 
> Example long time to recover:
> (actually, this example never recovers, unusual):
> Note: 3.7 GHz is the limit.
> 
> doug@s18:~$ sudo ~/turbostat --Summary --quiet --show
> Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 30
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 67.58   3700    134812  42      52.15   0.00 <<< the trip point was changed from 37
> to 57 degrees
> 67.90   3700    134964  42      52.08   0.00
> 68.07   3700    134424  42      52.06   0.00
> 68.01   3700    134415  41      50.76   0.00
> 68.14   3700    134521  41      50.78   0.00
> 68.11   3700    134424  42      50.75   0.00
> 68.03   3700    134329  42      50.70   0.00
> 68.11   3700    134321  42      50.76   0.00
> 68.05   3700    134456  42      51.09   0.00
> 68.12   3700    134549  42      52.21   0.00
> 68.12   3700    134482  42      52.19   0.00
> 68.10   3700    134301  42      52.20   0.00
> 68.11   3700    134444  42      52.14   0.00
> 68.08   3700    134422  42      52.17   0.00
> 68.07   3700    134430  42      52.23   0.00
> 68.00   3700    134723  42      52.12   0.00
> 67.96   3711    135207  44      52.53   0.00 <<< It takes 8 minutes until the
> frequency goes above 3.7 GHz
> 68.05   3765    134519  42      54.34   0.00
> 68.11   3771    134461  43      54.60   0.00
> 67.83   3763    134867  43      54.26   0.00
> 67.93   3773    134577  43      54.78   0.00 <<< But it never recovers, Why not?
> ...
> 
> For unknown reason the processor seems to now think it is not heavily
> loaded. From my MSR decoder:
> 
> 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 200020 AUTO AUTOL
> 
> From the book:
> 
> > Autonomous Utilization-Based Frequency Control Status (R0) When set,
> > frequency is reduced below the operating system request because the
> > processor has detected that utilization is low.
> 
> Which is not true.
> 
> Anyway,
> 
> Acked-by: Doug Smythies <dsmythies@telus.net>
> 
thanks,
rui
