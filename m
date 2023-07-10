Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FCD74D18C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjGJJdX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 05:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjGJJdC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 05:33:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECB26B6
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 02:31:33 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="344624678"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344624678"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865281466"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865281466"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 02:31:01 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
Date:   Mon, 10 Jul 2023 12:30:56 +0300
Message-Id: <20230710093100.918337-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Background
----------

Idle states reduce power consumption when a CPU has no work to do. The most
shallow CPU idle state is "POLL". It has lowest wake up latency, but saves
little power. The next idle state on Intel platforms is "C1". It has has higher
latency, but saves more power than "POLL".

Sapphire Rapids Xeons add new C0.1 and C0.2 (later C0.x) idle states which
conceptually sit between "POLL" and "C1". These provide a very attractive
midpoint: near-POLL wake-up latency and power consumption halfway between
"POLL" and "C1".

In other words, the expectation is that most latency-sensitive users will
prefer C0.x over POLL.

Enable C0.2 idle state support on Sapphire Rapids Xeon (later - SPR) by adding
it between POLL and C1.

Base commit
-----------

Based on the "linux-next" branch of "linux-pm" git tree.

base-commit: bd9bb08847da3b1eba2ea8cebf514d9287e7f4fb

Changelog
---------

* v4:
  - Address issues pointed out by Thomas Gleixner.
    . mwait.h: use 'IS_ENABLED()' instead of '#ifdef'.
    . mwait.h: use '__always_inline'.
    . mwait.h: use inline stub instead for macro for "!CONFIG_X86_64" case.
    . mwait.h: use proper commentaries for '#endif' and '#else'.
    . mwait.h: tested with llvm/clang.
    . Use imperative form (removed "this patch").
  - intel_idle: rename 'intel_idle_hlt_irq_on()' for consistency.
* v3
  - Dropped patch 'x86/umwait: Increase tpause and umwait quanta' after, as
    suggested by Andy Lutomirski.
  - Followed Peter Zijlstra's suggestion and removed explicit 'umwait'
    deadline. Rely on the global implicit deadline instead.
  - Rebased on top of Arjan's patches.
  - C0.2 was tested in a VM by Arjan van de Ven.
  - Re-measured on 2S and 4S Sapphire Rapids Xeon.
* v2
  - Do not mix 'raw_local_irq_enable()' and 'local_irq_disable()'. I failed to
    directly verify it, but I believe it'll address the '.noinstr.text' warning.
  - Minor kerneldoc commentary fix.

C0.2 vs POLL latency and power
------------------------------

I compared POLL to C0.2 using 'wult' tool (https://github.com/intel/wult),
which measures idle states latency.

* In "POLL" experiments, all C-states except for POLL were disabled.
* In "C0.2" experiments, all C-states except for POLL and C0.2 were disabled.

Here are the measurement results. The numbers are percent change from POLL to
C0.2.

-----------|-----------|----------|-----------
 Median IR | 99th % IR | AC Power | RAPL power
-----------|-----------|----------|-----------
 24%       | 12%       | -13%     | -18%
-----------------------|----------|-----------

* IR stands for interrupt latency. The table provides the median and 99th
  percentile. Wult measures it as the delay between the moment a timer
  interrupt fires to the moment the CPU reaches the interrupt handler.
* AC Power is the wall socket AC power.
* RAPL power is the CPU package power, measured using the 'turbostat' tool.

Hackbench measurements
----------------------

I ran the 'hackbench' benchmark using the following commands:

# 4 groups, 200 threads
hackbench -s 128 -l 100000000 -g4 -f 25 -P
# 8 groups, 400 threads.
hackbench -s 128 -l 100000000 -g8 -f 25 -P

My SPR system has 224 CPUs, so the first command did not use all CPUs, the
second command used all of them. However, in both cases CPU power reached TDP.

I ran hackbench 5 times for every configuration and compared hackbench "score"
averages.

In case of 4 groups, C0.2 improved the score by about 4%, and in case of 8
groups by about 0.6%.

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

4. Ho to change the global explicit 'umwait' deadline?

Via '/sys/devices/system/cpu/umwait_control/max_time'

Artem Bityutskiy (4):
  x86/umwait: use 'IS_ENABLED()'
  x86/mwait: Add support for idle via umwait
  intel_idle: rename 'intel_idle_hlt_irq_on()'
  intel_idle: add C0.2 state for Sapphire Rapids Xeon

 arch/x86/include/asm/mwait.h | 85 ++++++++++++++++++++++++++++++++----
 drivers/idle/intel_idle.c    | 52 +++++++++++++++++++---
 2 files changed, 123 insertions(+), 14 deletions(-)

-- 
2.40.1

