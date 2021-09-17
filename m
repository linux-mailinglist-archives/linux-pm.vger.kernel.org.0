Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE57B40F320
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 09:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhIQHWd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 03:22:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:64140 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241319AbhIQHWR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Sep 2021 03:22:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="219553082"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="219553082"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 00:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="473045036"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by orsmga007.jf.intel.com with ESMTP; 17 Sep 2021 00:20:24 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 1/1] intel_idle: enable interrupts before C1 on Xeons
Date:   Fri, 17 Sep 2021 10:20:22 +0300
Message-Id: <20210917072022.3234272-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917072022.3234272-1-dedekind1@gmail.com>
References: <20210917072022.3234272-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Enable local interrupts before requesting C1 on the last two generations of
Intel Xeon platforms: Sky Lake, Cascade Lake, Cooper Lake, Ice Lake.
This decreases average C1 interrupt latency by about 5-10%, as measured with
the 'wult' tool.

The '->enter()' function of the driver enters C-states with local interrupts
disabled by executing the 'monitor' and 'mwait' pair of instructions. If an
interrupt happens, the CPU exits the C-state and continues executing
instructions after 'mwait'. It does not jump to the interrupt handler, because
local interrupts are disabled. The cpuidle subsystem enables interrupts a bit
later, after doing some housekeeping.

With this patch, we enable local interrupts before requesting C1. In this case,
if the CPU wakes up because of an interrupt, it will jump to the interrupt
handler right away. The cpuidle housekeeping will be done after the pending
interrupt(s) are handled.

Enabling interrupts before entering a C-state has measurable impact for faster
C-states, like C1. Deeper, but slower C-states like C6 do not really benefit
from this sort of change, because their latency is a lot higher comparing to
the delay added by cpuidle housekeeping.

This change was also tested with cyclictest and dbench. In case of Ice Lake,
the average cyclictest latency decreased by 5.1%, and the average 'dbench'
throughput increased by about 0.8%. Both tests were run for 4 hours with only
C1 enabled (all other idle states, including 'POLL', were disabled). CPU
frequency was pinned to HFM, and uncore frequency was pinned to the maximum
value. The other platforms had similar single-digit percentage improvements.

It is worth noting, that this patch affects 'cpuidle' statistics a tiny bit.
Before this patch, C1 residency did not include the interrupt handling time, but
with this patch, it will include it. This is similar to what happens in case of
the 'POLL' state, which also runs with interrupts enabled.

Suggested-by: Len Brown <len.brown@intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e6c543b5ee1d..0b66e25c0e2d 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -88,6 +88,12 @@ static struct cpuidle_state *cpuidle_state_table __initdata;
 
 static unsigned int mwait_substates __initdata;
 
+/*
+ * Enable interrupts before entering the C-state. On some platforms and for
+ * some C-states, this may measurably decrease interrupt latency.
+ */
+#define CPUIDLE_FLAG_IRQ_ENABLE		BIT(14)
+
 /*
  * Enable this state by default even if the ACPI _CST does not list it.
  */
@@ -127,6 +133,9 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
 
+	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
+		local_irq_enable();
+
 	mwait_idle_with_hints(eax, ecx);
 
 	return index;
@@ -698,7 +707,7 @@ static struct cpuidle_state skx_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
-		.flags = MWAIT2flg(0x00),
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
@@ -727,7 +736,7 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
-		.flags = MWAIT2flg(0x00),
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-- 
2.31.1

