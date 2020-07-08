Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADBC218B55
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgGHPem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 11:34:42 -0400
Received: from foss.arm.com ([217.140.110.172]:47144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbgGHPel (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 11:34:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36C211045;
        Wed,  8 Jul 2020 08:34:40 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FBCE3F237;
        Wed,  8 Jul 2020 08:34:36 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     lukasz.luba@arm.com, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: [PATCH 0/2] Exynos5422 DMC: adjust to new devfreq monitoring mechanism
Date:   Wed,  8 Jul 2020 16:34:18 +0100
Message-Id: <20200708153420.29484-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

There have been discussions around devfreq, it's related drivers
and governors, reporting some issues [1][2]. There are a patch sets
trying to address these issues [2][3], discussion is still ongoing.

This patch set is a follow up for changes presented in [2]. It moves
from internal interrupts to devfreq monitoring mechanism with fixed
polling interval in the memory controller. The value of polling and
uptreshold have been adjusted in order to get better reaction in the
benchmark workload [4]. The test workload is specific and I still
have to spend some more time to understand impact of different CPUs
or different utilization and governor's decisions. Now, with the patches
it looks better.
For other future adjustments, not specific to a particular
driver's code, I would rather see a different mechanism, which I'll post
shortly as an RFC.

The patch 1/2 needs [2] series, while the patch 2/2 is on top of Krzysztof's
today next/dt branch [5] (I assume patch 2/2 would go through his tree).

Here are test results for the benchmark from [4], showing some more accurate
reaction for the benchmark workload (gentle ask to Willy to confirm this):
simple_ondlemand:
littles: 1.40374 s (was 4.74308 s)
bigs: 1.44519 s (was 4.76556 s)
performance:
littles: 1.13635 s
bigs: 1.17349 s

-------------------------------8<--------------------------------
oller/trans_stat /odroid/benchmark# cat /sys/class/devfreq/10c20000.memory-contro
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
* 165000000:         0        15        24        13        12         2         0        11   1128580
  206000000:        12         0         8         7         3         1         0         0      3760
  275000000:        17         8         0        12        10         2         0         5      6340
  413000000:        19         5         9         0         7         5         0         9     10290
  543000000:        18         0         6        13         0        31         1         8      7510
  633000000:         4         3         3         6        27         0         0         1     11440
  728000000:         1         0         0         0         0         0         0         0       110
  825000000:         7         0         4         3        18         3         0         0     23490
Total transition : 373
root@odroid:/home/odroid/benchmark# bash source/scripts/test_dvfs_mem.sh


mem_gov = simple_ondemand at 413000000

     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
  165000000:         0        15        26        14        12         2         0        11   1134220
  206000000:        12         0         8         7         3         1         0         0      3760
  275000000:        18         8         0        13        10         2         0         5      6670
* 413000000:        20         5         9         0         7         5         0         9     10460
  543000000:        18         0         6        13         0        31         1         8      7510
  633000000:         4         3         3         6        27         0         0         1     11440
  728000000:         1         0         0         0         0         0         0         0       110
  825000000:         7         0         4         3        18         3         0         0     23490
Total transition : 379


 Running on the LITTLE cluster

array_size rounded to fit a CACHE_LINE_SIZE from 33554431 to 33554432
sizeof(size_t) = 4
array_size = 33554432
==> 134217728 b; 131072 Kb; 128 Mb
stride = 0
nr_iter = 9722222
nr_iter_2 = 1
effective_nr_iter = 9722222
cpu_freq = 1400000
==> 1.4 GHz; 1400 MHz; 1400000 KHz
total time = 1403736317 ns; 1.40374 s
time per iter 144.384 ns
estimated cycles per iter 202.138 c


 Running on the big cluster

array_size rounded to fit a CACHE_LINE_SIZE from 33554431 to 33554432
sizeof(size_t) = 4
array_size = 33554432
==> 134217728 b; 131072 Kb; 128 Mb
stride = 0
nr_iter = 9722222
nr_iter_2 = 1
effective_nr_iter = 9722222
cpu_freq = 2000000
==> 2 GHz; 2000 MHz; 2000000 KHz
total time = 1445186489 ns; 1.44519 s
time per iter 148.648 ns
estimated cycles per iter 297.296 c
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
  165000000:         0        15        26        14        12         2         0        11   1134220
  206000000:        12         0         8         7         3         1         0         0      3760
  275000000:        18         8         0        13        15         2         0         5      7220
  413000000:        20         5        10         0         7         5         0         9     10510
  543000000:        18         0        10        13         0        32         1         9      8280
* 633000000:         4         3         3         6        28         0         0         1     14160
  728000000:         1         0         0         0         0         0         0         0       110
  825000000:         7         0         4         3        18         4         0         0     23930
Total transition : 393


mem_gov = performance at 825000000

     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
  165000000:         0        15        26        14        12         2         0        11   1134220
  206000000:        12         0         8         7         3         1         0         0      3760
  275000000:        18         8         0        13        15         2         0         6      7300
  413000000:        20         5        10         0         7         5         0         9     10510
  543000000:        18         0        10        13         0        32         1         9      8280
  633000000:         4         3         4         6        28         0         0         1     14190
  728000000:         1         0         0         0         0         0         0         0       110
* 825000000:         7         0         4         3        18         4         0         0     23980
Total transition : 395


 Running on the LITTLE cluster

array_size rounded to fit a CACHE_LINE_SIZE from 33554431 to 33554432
sizeof(size_t) = 4
array_size = 33554432
==> 134217728 b; 131072 Kb; 128 Mb
stride = 0
nr_iter = 9722222
nr_iter_2 = 1
effective_nr_iter = 9722222
cpu_freq = 1400000
==> 1.4 GHz; 1400 MHz; 1400000 KHz
total time = 1136350257 ns; 1.13635 s
time per iter 116.882 ns
estimated cycles per iter 163.634 c


 Running on the big cluster

array_size rounded to fit a CACHE_LINE_SIZE from 33554431 to 33554432
sizeof(size_t) = 4
array_size = 33554432
==> 134217728 b; 131072 Kb; 128 Mb
stride = 0
nr_iter = 9722222
nr_iter_2 = 1
effective_nr_iter = 9722222
cpu_freq = 2000000
==> 2 GHz; 2000 MHz; 2000000 KHz
total time = 1173486470 ns; 1.17349 s
time per iter 120.701 ns
estimated cycles per iter 241.403 c
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
  165000000:         0        15        26        14        12         2         0        11   1134220
  206000000:        12         0         8         7         3         1         0         0      3760
  275000000:        18         8         0        13        15         2         0         6      7300
  413000000:        20         5        10         0         7         5         0         9     10510
  543000000:        18         0        10        13         0        32         1         9      8280
  633000000:         4         3         4         6        28         0         0         1     14190
  728000000:         1         0         0         0         0         0         0         0       110
* 825000000:         7         0         4         3        18         4         0         0     27760
Total transition : 395
root@odroid:/home/odroid/benchmark#
oller/trans_stat /odroid/benchmark# cat /sys/class/devfreq/10c20000.memory-contro
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
* 165000000:         0        15        26        14        12         2         0        11   1138930
  206000000:        12         0         8         7         3         1         0         0      3760
  275000000:        18         8         0        13        15         2         0         6      7300
  413000000:        20         5        10         0         7         5         0         9     10510
  543000000:        19         0        10        13         0        32         1         9      8390
  633000000:         4         3         4         6        28         0         0         1     14190
  728000000:         1         0         0         0         0         0         0         0       110
  825000000:         7         0         4         3        19         4         0         0     28280
Total transition : 397
root@odroid:/home/odroid/benchmark#
----------------------------------------->8--------------------------------------------

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20200623164733.qbhua7b6cg2umafj@macmini.local/
[2] https://lore.kernel.org/linux-pm/20200703062622.11773-1-cw00.choi@samsung.com/
[3] https://lore.kernel.org/linux-pm/20200703100810.12304-1-cw00.choi@samsung.com/
[4] https://github.com/wwilly/benchmark.git
[5] https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=next/dt




Lukasz Luba (2):
  memory: samsung: exynos5422-dmc: Adjust polling interval and
    uptreshold
  ARM: dts: exynos: Remove interrupts from DMC controller in Exynos5422

 arch/arm/boot/dts/exynos5420.dtsi       | 3 ---
 drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.17.1

