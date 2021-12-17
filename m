Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8064794D8
	for <lists+linux-pm@lfdr.de>; Fri, 17 Dec 2021 20:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbhLQTc1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Dec 2021 14:32:27 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:24994 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240679AbhLQTc1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Dec 2021 14:32:27 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A4YA34qmc9CTWcID/vaS1RZ7o5gyRJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2AOzGBNXGrSOPuCZmqheYggaojioBkOuJLUm4JnTQc/+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x/RGQ6YnSHuClUbS?=
 =?us-ascii?q?dZXgrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTckQGWL/fO2BiiFIGBu780l4b/HV0i/lgXBYfQR4/ZzGhnc11ydwLsZWvQ?=
 =?us-ascii?q?AMtFqzKguUUFRdCe817FfQfpuKZeSDg2SCU5wicG5f2+N10BU8/MIkw+ettB2x?=
 =?us-ascii?q?Ks/sCJ1glahmcjuay6KC6T+N2j4IiKtPqNcURoBlI1ivYC/c4SIuFW6zM6cVFw?=
 =?us-ascii?q?j48j+hKHPDDd4wYbyZiaFLLZBgnElMaDpgWn+qygHT7NTpCpzq9u6st7nPTig9?=
 =?us-ascii?q?s1bH3GN7UfNWQQoNShEnwjmbH+XnpRwkfHMKQxCDD8X+2gOLL2yThV+o6ELy+6?=
 =?us-ascii?q?+4vg1CJwGEXIAMZWEH9ovSjjEO6HdVFJCQ8/ysooq8a7kGnTtDhGRa/pRasphM?=
 =?us-ascii?q?AVsBCO+w85huExqfd70CeHGdsZjxcct1gsMIyQT0CzFKFn9r1QzdotdW9V3Ob/?=
 =?us-ascii?q?bqSsXW9JCkJMWgeTSsFSwIf5J/kuo5bs/5lZr6PC4bs0YazQGuphW7a6nhjwa8?=
 =?us-ascii?q?ek4gQ2b/9+13b6w9Ab6PhFmYdjjg7lEr8hu+hWLOYWg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AWvtbaaAkcpajEizlHemx55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBKiC9Hfbo8vxG8M506faWslYssQ8b6LK90cC7KBu2n6Kdh7NxAV7IZmXbUQ?=
 =?us-ascii?q?WTQb2KlbGM/wHd?=
X-IronPort-AV: E=Sophos;i="5.88,214,1635199200"; 
   d="scan'208";a="11656007"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 20:32:25 +0100
Date:   Fri, 17 Dec 2021 20:32:24 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112172022100.2968@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Fri, 17 Dec 2021, Rafael J. Wysocki wrote:

> On Mon, Dec 13, 2021 at 11:52 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > With HWP, intel_cpufreq_adjust_perf takes the utilization, scales it
> > between 0 and the capacity, and then maps everything below min_pstate to
> > the lowest frequency.
>
> Well, it is not just intel_pstate with HWP.  This is how schedutil
> works in general; see get_next_freq() in there.
>
> > On my Intel Xeon Gold 6130 and Intel Xeon Gold
> > 5218, this means that more than the bottom quarter of utilizations are all
> > mapped to the lowest frequency.  Running slowly doesn't necessarily save
> > energy, because it takes more time.
>
> This is true, but the layout of the available range of performance
> values is a property of the processor, not a driver issue.
>
> Moreover, the role of the driver is not to decide how to respond to
> the given utilization value, that is the role of the governor.  The
> driver is expected to do what it is asked for by the governor.

OK, but what exactly is the goal of schedutil?

I would have expected that it was to give good performance while saving
energy, but it's not doing either in many of these cases.

Is it the intent of schedutil that the bottom quarter of utilizations
should be mapped to the lowest frequency?

julia


>
> > This patch scales the utilization
> > (target_perf) between the min pstate and the cap pstate instead.
> >
> > On the DaCapo (Java) benchmarks and on a few exmples of kernel compilation
> > (based on make defconfig), on two-socket machines with the above CPUs, the
> > performance is always the same or better as Linux v5.15, and the CPU and
> > RAM energy consumption is likewise always the same or better (one
> > exception: zxing-eval on the 5128 uses a little more energy).
> >
> > 6130:
> >
> > Performance (sec):
> >                 v5.15           with this patch (improvement)
> > avrora          77.5773         56.4090 (1.38)
> > batik-eval      113.1173        112.4135 (1.01)
> > biojava-eval    196.6533        196.7943 (1.00)
> > cassandra-eval  62.6638         59.2800 (1.06)
> > eclipse-eval    218.5988        210.0139 (1.04)
> > fop             3.5537          3.4281 (1.04)
> > graphchi-evalN  13.8668         10.3411 (1.34)
> > h2              75.5018         62.2993 (1.21)
> > jme-eval        94.9531         89.5722 (1.06)
> > jython          23.5789         23.0603 (1.02)
> > kafka-eval      60.2784         59.2057 (1.02)
> > luindex         5.3537          5.1190 (1.05)
> > lusearch-fix    3.5956          3.3628 (1.07)
> > lusearch        3.5396          3.5204 (1.01)
> > pmd             13.3505         10.8795 (1.23)
> > sunflow         7.5932          7.4899 (1.01)
> > tomcat-eval     39.6568         31.4844 (1.26)
> > tradebeans      118.9918        99.3932 (1.20)
> > tradesoap-eval  56.9113         54.7567 (1.04)
> > tradesoap       50.7779         44.5169 (1.14)
> > xalan           5.0711          4.8879 (1.04)
> > zxing-eval      10.5532         10.2435 (1.03)
> >
> > make            45.5977         45.3454 (1.01)
> > make sched      3.4318          3.3450 (1.03)
> > make fair.o     2.9611          2.8464 (1.04)
> >
> > CPU energy consumption (J):
> >
> > avrora          4740.4813       3585.5843 (1.32)
> > batik-eval      13361.34        13278.74 (1.01)
> > biojava-eval    21608.70        21652.94 (1.00)
> > cassandra-eval  3037.6907       2891.8117 (1.05)
> > eclipse-eval    23528.15        23198.36 (1.01)
> > fop             455.7363        441.6443 (1.03)
> > graphchi-eval   999.9220        971.5633 (1.03)
> > h2              5451.3093       4929.8383 (1.11)
> > jme-eval        5343.7790       5143.8463 (1.04)
> > jython          2685.3790       2623.1950 (1.02)
> > kafka-eval      2715.6047       2548.7220 (1.07)
> > luindex         597.7587        571.0387 (1.05)
> > lusearch-fix    714.0340        692.4727 (1.03)
> > lusearch        718.4863        704.3650 (1.02)
> > pmd             1627.6377       1497.5437 (1.09)
> > sunflow         1563.5173       1514.6013 (1.03)
> > tomcat-eval     4740.1603       4539.1503 (1.04)
> > tradebeans      8331.2260       7482.3737 (1.11)
> > tradesoap-eval  6610.1040       6426.7077 (1.03)
> > tradesoap       5641.9300       5544.3517 (1.02)
> > xalan           1072.0363       1065.7957 (1.01)
> > zxing-eval      2200.1883       2174.1137 (1.01)
> >
> > make            9788.9290       9777.5823 (1.00)
> > make sched      501.0770        495.0600 (1.01)
> > make fair.o     363.4570        352.8670 (1.03)
> >
> > RAM energy consumption (J):
> >
> > avrora          2508.5553       1844.5977 (1.36)
> > batik-eval      5627.3327       5603.1820 (1.00)
> > biojava-eval    9371.1417       9351.1543 (1.00)
> > cassandra-eval  1398.0567       1289.8317 (1.08)
> > eclipse-eval    10193.28        9952.3543 (1.02)
> > fop             189.1927        184.0620 (1.03)
> > graphchi-eval   539.3947        447.4557 (1.21)
> > h2              2771.0573       2432.2587 (1.14)
> > jme-eval        2702.4030       2504.0783 (1.08)
> > jython          1135.7317       1114.5190 (1.02)
> > kafka-eval      1320.6840       1220.6867 (1.08)
> > luindex         246.6597        237.1593 (1.04)
> > lusearch-fix    294.4317        282.2193 (1.04)
> > lusearch        295.5400        284.3890 (1.04)
> > pmd             721.7020        643.1280 (1.12)
> > sunflow         568.6710        549.3780 (1.04)
> > tomcat-eval     2305.8857       1995.8843 (1.16)
> > tradebeans      4323.5243       3749.7033 (1.15)
> > tradesoap-eval  2862.8047       2783.5733 (1.03)
> > tradesoap       2717.3900       2519.9567 (1.08)
> > xalan           430.6100        418.5797 (1.03)
> > zxing-eval      732.2507        710.9423 (1.03)
> >
> > make            3362.8837       3356.2587 (1.00)
> > make sched      191.7917        188.8863 (1.02)
> > make fair.o     149.6850        145.8273 (1.03)
> >
> > 5128:
> >
> > Performance (sec):
> >
> > avrora          62.0511         43.9240 (1.41)
> > batik-eval      111.6393        110.1999 (1.01)
> > biojava-eval    241.4400        238.7388 (1.01)
> > cassandra-eval  62.0185         58.9052 (1.05)
> > eclipse-eval    240.9488        232.8944 (1.03)
> > fop             3.8318          3.6408 (1.05)
> > graphchi-eval   13.3911         10.4670 (1.28)
> > h2              75.3658         62.8218 (1.20)
> > jme-eval        95.0131         89.5635 (1.06)
> > jython          28.1397         27.6802 (1.02)
> > kafka-eval      60.4817         59.4780 (1.02)
> > luindex         5.1994          4.9587 (1.05)
> > lusearch-fix    3.8448          3.6519 (1.05)
> > lusearch        3.8928          3.7068 (1.05)
> > pmd             13.0990         10.8008 (1.21)
> > sunflow         7.7983          7.8569 (0.99)
> > tomcat-eval     39.2064         31.7629 (1.23)
> > tradebeans      120.8676        100.9113 (1.20)
> > tradesoap-eval  65.5552         63.3493 (1.03)
> > xalan           5.4463          5.3576 (1.02)
> > zxing-eval      9.8611          9.9692 (0.99)
> >
> > make            43.1852         43.1285 (1.00)
> > make sched      3.2181          3.1706 (1.01)
> > make fair.o     2.7584          2.6615 (1.04)
> >
> > CPU energy consumption (J):
> >
> > avrora          3979.5297       3049.3347 (1.31)
> > batik-eval      12339.59        12413.41 (0.99)
> > biojava-eval    23935.18        23931.61 (1.00)
> > cassandra-eval  3552.2753       3380.4860 (1.05)
> > eclipse-eval    24186.38        24076.57 (1.00)
> > fop             441.0607        442.9647 (1.00)
> > graphchi-eval   1021.1323       964.4800 (1.06)
> > h2              5484.9667       4901.9067 (1.12)
> > jme-eval        6167.5287       5909.5767 (1.04)
> > jython          2956.7150       2986.3680 (0.99)
> > kafka-eval      3229.9333       3197.7743 (1.01)
> > luindex         537.0007        533.9980 (1.01)
> > lusearch-fix    720.1830        699.2343 (1.03)
> > lusearch        708.8190        700.7023 (1.01)
> > pmd             1539.7463       1398.1850 (1.10)
> > sunflow         1533.3367       1497.2863 (1.02)
> > tomcat-eval     4551.9333       4289.2553 (1.06)
> > tradebeans      8527.2623       7570.2933 (1.13)
> > tradesoap-eval  6849.3213       6750.9687 (1.01)
> > xalan           1013.2747       1019.1217 (0.99)
> > zxing-eval      1852.9077       1943.1753 (0.95)
> >
> > make            9257.5547       9262.5993 (1.00)
> > make sched      438.7123        435.9133 (1.01)
> > make fair.o     315.6550        312.2280 (1.01)
> >
> > RAM energy consumption (J):
> >
> > avrora          16309.86        11458.08 (1.42)
> > batik-eval      30107.11        29891.58 (1.01)
> > biojava-eval    64290.01        63941.71 (1.01)
> > cassandra-eval  13240.04        12403.19 (1.07)
> > eclipse-eval    64188.41        62008.35 (1.04)
> > fop             1052.2457       996.0907 (1.06)
> > graphchi-eval   3622.5130       2856.1983 (1.27)
> > h2              19965.58        16624.08 (1.20)
> > jme-eval        21777.02        20211.06 (1.08)
> > jython          7515.3843       7396.6437 (1.02)
> > kafka-eval      12868.39        12577.32 (1.02)
> > luindex         1387.7263       1328.8073 (1.04)
> > lusearch-fix    1313.1220       1238.8813 (1.06)
> > lusearch        1303.5597       1245.4130 (1.05)
> > pmd             3650.6697       3049.8567 (1.20)
> > sunflow         2460.8907       2380.3773 (1.03)
> > tomcat-eval     11199.61        9232.8367 (1.21)
> > tradebeans      32385.99        26901.40 (1.20)
> > tradesoap-eval  17691.01        17006.95 (1.04)
> > xalan           1783.7290       1735.1937 (1.03)
> > zxing-eval      2812.9710       2952.2933 (0.95)
> >
> > make            13247.47        13258.64 (1.00)
> > make sched      885.7790        877.1667 (1.01)
> > make fair.o     741.2473        723.6313 (1.02)
>
> So the number look better after the change, because it makes the
> driver ask the hardware for slightly more performance than it is asked
> for by the governor.
>
> >
> > Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
> >
> > ---
> >
> > min_pstate is defined in terms of cpu->pstate.min_pstate and
> > cpu->min_perf_ratio.  Maybe one of these values should be used instead.
> > Likewise, perhaps cap_pstate should be max_pstate?
>
> I'm not sure if I understand this remark.  cap_pstate is the max
> performance level of the CPU and max_pstate is the current limit
> imposed by the framework.  They are different things.
>
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 8c176b7dae41..ba6a48959754 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2789,10 +2789,6 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> >
> >         /* Optimization: Avoid unnecessary divisions. */
> >
> > -       target_pstate = cap_pstate;
> > -       if (target_perf < capacity)
> > -               target_pstate = DIV_ROUND_UP(cap_pstate * target_perf, capacity);
> > -
> >         min_pstate = cap_pstate;
> >         if (min_perf < capacity)
> >                 min_pstate = DIV_ROUND_UP(cap_pstate * min_perf, capacity);
> > @@ -2807,6 +2803,10 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> >         if (max_pstate < min_pstate)
> >                 max_pstate = min_pstate;
> >
> > +       target_pstate = cap_pstate;
> > +       if (target_perf < capacity)
> > +               target_pstate = DIV_ROUND_UP((cap_pstate - min_pstate) * target_perf, capacity) + min_pstate;
>
> So the driver is asked by the governor to deliver the fraction of the
> max performance (cap_pstate) given by the target_perf / capacity ratio
> with the floor given by min_perf / capacity.  It cannot turn around
> and do something else, because it thinks it knows better.
>
> > +
> >         target_pstate = clamp_t(int, target_pstate, min_pstate, max_pstate);
> >
> >         intel_cpufreq_hwp_update(cpu, min_pstate, max_pstate, target_pstate, true);
>
