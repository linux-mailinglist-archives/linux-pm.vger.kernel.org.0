Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE6D72AE1E
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jun 2023 20:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjFJSf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jun 2023 14:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjFJSf2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jun 2023 14:35:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A8E30E8
        for <linux-pm@vger.kernel.org>; Sat, 10 Jun 2023 11:35:27 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="356683686"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="356683686"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 11:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688116106"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="688116106"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2023 11:35:19 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH v3 0/3] Sapphire Rapids C0.x idle states support
Date:   Sat, 10 Jun 2023 21:35:16 +0300
Message-Id: <20230610183518.4061159-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
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

Sapphire Rapids Xeons add new C0.1 and C0.2 idle states which conceptually sit
between "POLL" and "C1". These provide a very attractive midpoint: near-POLL
wake-up latency and power consumption halfway between "POLL" and "C1".

In other words, we expect all but the most latency-sensitive users to prefer
these idle state over POLL.

This patch-set enables C0.2 idle state support on Sapphire Rapids Xeon (later -
SPR). The new idle state is added between POLL and C1.

Patch-set overview
------------------

This patch-set is based on the "linux-next" branch of the "linux-pm" plus
patches from Arjan van de Ven, submitted to linux-pm mailing list
on Jun 5, 2023:
 * Cover letter: [PATCH 0/4 v2] Add support for running in VM guests to intel_idle
 * https://patchwork.kernel.org/project/linux-pm/patch/20230605154716.840930-2-arjan@linux.intel.com/

In other words, the base commit is 'e8195eaff86fd2ddb5f00646b5f76e40cd1164a8',
then Arjan's patches should be applied, and then these patches on top.

Patch #1 does not depend on Arjan's patches, but patch #2 requires the cleanups
from Arjan's patch-set.

Changelog
---------

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

Artem Bityutskiy (2):
  x86/mwait: Add support for idle via umwait
  intel_idle: add C0.2 state for Sapphire Rapids Xeon

 arch/x86/include/asm/mwait.h | 65 ++++++++++++++++++++++++++++++++++++
 drivers/idle/intel_idle.c    | 44 +++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

-- 
2.40.1
