Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9036ABF93
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 13:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCFMeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 07:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCFMeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 07:34:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA4E1B2C8
        for <linux-pm@vger.kernel.org>; Mon,  6 Mar 2023 04:34:21 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="398123465"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="398123465"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 04:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="706422133"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="706422133"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga008.jf.intel.com with ESMTP; 06 Mar 2023 04:34:19 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 0/3] Sapphire Rapids C0.x idle states support
Date:   Mon,  6 Mar 2023 14:34:15 +0200
Message-Id: <20230306123418.720679-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch-set enables C0.2 idle state support on Sapphire Rapids Xeon (later -
SPR). The new idle state is added between POLL and C1 states.

This patch-set is based on linux-pm/linux-next.

Motivation
----------

According to my measurements, SPR C0.2 idle state is 5-20% more
energy-efficient than Linux POLL state, and its latency is close to POLL
latency.

When a CPU rests in C0.2, saved power increases power budget of a busy CPU.
This way, C0.2 may improve turbo boost of a busy CPU and improve performance.

Latency and power impact
------------------------

I compared POLL to C0.2 using 'wult' tool (https://github.com/intel/wult).
Wult measures C-state exit latency and several other metrics, of which socket
level AC power and RAPL CPU package power are most interesting in this case.

I collected 1000000 datapoints with wult, and measured 4 configurations:
1. POLL + LFM
2. POLL + HFM
3. C0.2 + LFM
4. C0.2 + HFM

* In "POLL" experiments, all C-states except for POLL were disabled.
* In "C0.2" experiments, all C-states except for C0.2 were disabled.
* In "LFM" experiments, frequency of all CPUs was locked to 800MHz (low frequency
  mode on my SPR system).
* In "HFM" experiments, frequency of all CPUs was locked to 2GHz (high
  frequency mode on my SPR system).

Here are the measurement results. The numbers are percent change from POLL to
C0.2. The formula was:

% change of a value = [(POLL value - C0.2 value) / POLL value] * 100%

----|-----------|-----------|----------|-----------
    | Median IR | 99th % IR | AC Power | RAPL power
----|-----------|-----------|----------|-----------
HFM | 22%       | 11%       | -13%     | -19%
LFM | 23%       | 6%        | -5%      | -18%
----------------------------|----------|-----------

* IR stands for interrupt latency. The table provides the median and 99th
  percentile. Wult measures IR as TSC value in interrupt handler minus TSC value
  of the moment when the interrupt fired.
* AC Power is the socket level AC power, measured with Yokogawa WT310 power
  meter.
* RAPL power is the CPU package power, measured using the 'turbostat' tool.

Conclusion: C0.2 has higher latency comparing to POLL, but it comes with
substantial energy savings.

Cyclictest measurements
-----------------------

I used 'cyclictest' to measure average timer latency for timers armed 100us and
1.5ms ahead.

The executed commands:
# Arming timers 100us ahead.
cyclictest --default-system --nsecs -a 1 --loops 10000000 --distance 100
# Arming timers 1.5ms ahead.
cyclictest --default-system --nsecs -a 1 --loops 10000000 --distance 15000

The numbers below are percent change for the average timer latency.

----|-----------|-------
    | 100us     | 1.5ms
----|-----------|-------
HFM | 0.1%      | -0.1%
LFM | -0.2%     | -0.2%

Conclusion: C0.2 has very small latency impact, as per 'cyclictest'.

On wult vs cyclictest latency data.
- Latency measured with 'wult' is in range of [0.2,1] microseconds, depending
  on configuration (CPU frequency, etc). The number includes HW latency and
  some amount of SW overhead.
- Latency measured with 'cyclictest' is in tens of microseconds, and it is
  dominated by the software overhead component: time run the HW interrupt, exit
  idle, switch the context, reach the user-space handler, and so on.

This explains the significant difference in latency percent change between
'wult' and 'cyclictest'.

Hackbench measurements
----------------------

I ran the 'hackbench' benchmark using the following commands:

# 4 groups, 200 threads
hackbench -s 128 -l 100000000 -g4 -f 25 -P
# 8 groups, 400 threads.
hackbench -s 128 -l 100000000 -g8 -f 25 -P

My system has 224 CPUs, so the first command did not use all CPUs, the second
command used all of them. However, in both cases CPU power reached TDP.

I did not lock CPU frequency, so all frequencies were allowed on all CPUs. I
tested these 2 configurations for both 8 and 4 group runs (so total 4
experiments):
- POLL: only POLL state was enabled, all other C-states were disabled.
- POLL+C0.2: only POLL and C0.2 were enabled, all other C-states were disabled.

I ran hackbench 3 times and compared hackbench "score" (which is basically the
execution time) between POL' and POLL+C0.2 runs.

The below table contains hackbench score % change for hackbench 4 groups. C0.2
residency in these runs was about 20%.

------|--------------
Run # | Time decrease
------|--------------
1     |  -6.5%
2     |  -12.3%
3     |  -7.1%

The below table contains hackbench score % change for hackbench 8 groups. C0.2
residency in these runs was about 10%.

------|---------------
Run # | Time decrease
------|---------------
1     |  -1.6%
2     |  -0.6%
3     |  -0.9%

Conclusion: even with small C0.2 residency (~10%), hackbench shows some
performance improvement. With larger C0.2 residency the improvement is more
pronounced.

Q&A
---

1. Can C0.2 be disabled?

C0.2 can be disabled via sysfs and with the following kernel boot option:

  intel_idle.states_off=2

2. Why C0.2, not C0.1?

I measured both C0.1 and C0.2, but did not notice a clear C0.1 advantage in
terms of latency, but did notice that C0.2 saves more power.

But if users want to try using C0.1 instead of C0.2, they can do this:

echo 0 > /sys/devices/system/cpu/umwait_control/enable_c02

This will make sure that C0.2 requests from 'intel_idle' are automatically
converted to C0.1 requests.

3. How did you verify that system enters C0.2?

I used 'perf' to read the corresponding PMU counters:

perf stat -e CPU_CLK_UNHALTED.C01,CPU_CLK_UNHALTED.C02,cycles -a sleep 1

Artem Bityutskiy (3):
  x86/mwait: Add support for idle via umwait
  x86/umwait: Increase tpause and umwait quanta
  intel_idle: add C0.2 state for Sapphire Rapids Xeon

 arch/x86/include/asm/mwait.h | 63 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/umwait.c |  4 +--
 drivers/idle/intel_idle.c    | 59 ++++++++++++++++++++++++++++++++-
 3 files changed, 123 insertions(+), 3 deletions(-)


base-commit: 0a3f9a6b0265b64c02226fcabb5e9a958307913b

-- 
2.38.1
