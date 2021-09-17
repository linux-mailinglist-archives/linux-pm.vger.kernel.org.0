Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6413240F31F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbhIQHW2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 03:22:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:64184 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240178AbhIQHWH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Sep 2021 03:22:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="219553079"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="219553079"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 00:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="473045035"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by orsmga007.jf.intel.com with ESMTP; 17 Sep 2021 00:20:23 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 0/1] intel_idle: improve Xeon C1 interrupt response time
Date:   Fri, 17 Sep 2021 10:20:21 +0300
Message-Id: <20210917072022.3234272-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch improves C1 interrupt latency by about 5-10% on the following
Xeon platforms: Sky Lake, Cascade Lake, Cooper Lake, Ice Lake.
In other words, if CPU is in C1 idle state, and an interrupt happens, in
average the CPU will reach the interrupt handler about 10% earlier if this
patch is applied.

Today, on Intel CPUs, all idle states except for 'POLL' are entered with local
interrupts disabled. If the CPU is woken up by an interrupt, it does not jump
to the interrupt handler, but instead, it continues executing some amount of
housekeeping code in the cpuidle subsystem. Then cpuidle enables the interrupts
and the CPU jumps to the interrupt handler(s).

This patch enables interrupts for C1 before entering the idle state. Therefore,
in a situation like that the CPU will fist run the interrupt handler(s), and
only then the cpuidle housekeeping code. As a result, the interrupt handler
runs a bit earlier, and it potentially may wake up a thread on another CPU a
bit earlier, which, depending on the workload, may end up improving the overall
system responsiveness.

The reason we enable interrupts only before C1 is because it only makes a
measurable difference for fast C-states (C1 has about 1 microsecond latency).
It is mostly data centers being very sensitive to C1 latency, so we only apply
this change to Xeons.

I measured all 4 above mentioned Xeons with 'wult', 'cyclictest', and 'dbench'.
All three showed improvements. Below are Ice Lake test results, but on SKX,
CLX, and CPX the results were similar.

In all 3 tests below I did the following configuration changes.
1. All C-states but C1 disabled ('POLL' also disabled).
2. CPU frequency pinned to HFM (base frequency).
3. Uncore frequency pinned to the maximum value.

#1 was done to test only C1. #2 and #3 were done to exclude frequency-related
test variations.

The results below are my results on my specific system. I did not optimize my
systems to get best possible test scores, and for the most part, just used OS
defaults. The goal was to make an AB comparison, not to get the best possible
scores.

Wult
----

Wult is a tool for measuring C-state wake latency:
https://github.com/intel/wult

I used the 'hrt' wult method for measuring C1 latency with and without this
patch. The median latency improved about 10%. Here is the HTML report:

https://git.infradead.org/~dedekind/wult/patches/intr_on_xeons/v1/

Cyclictest
----------

I ran cyclictest for a single CPU for 4 hours. I made sure that the CPU has a
lot of C1 residency while cyclictest runs. I was looking to compare the
average latency.

cyclictest --mlockall --priority=80 --duration 4h --interval=100 --distance=0 \
           --threads=1 --affinity=0 -N --latency=1000

The '-N' option was used to get the results in nanoseconds. The '--latency'
option was used to prevent cyclictest from blocking C1 via the Linux PM QoS
interface.

Before: average latency: 2417 ns
After:  average latency: 2293 ns

This is a 5.1% improvement.

Dbench
------

I ran dbench for 4 hours for all CPUs. I was using a simple consumer
grade SSD + ext4. I was looking to compare the average throughput.

Before: average throughput: 4527.12 MB/sec
After:  average throughput: 4562.52 MB/sec

This is a 0.8% improvement. It may be a tie, but I ran this test twice for 4
hours on 4 Xeon platforms, and patched kernel version consistently gave a
fraction of percent improvement. I believe this is because this patch slightly
reduces I/O wait time.

Artem.
