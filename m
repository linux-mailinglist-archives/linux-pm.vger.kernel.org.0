Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD6028A426
	for <lists+linux-pm@lfdr.de>; Sun, 11 Oct 2020 01:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJJXNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Oct 2020 19:13:34 -0400
Received: from mail.ispras.ru ([83.149.199.84]:55638 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgJJXND (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Oct 2020 19:13:03 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id A81E440A1DA0;
        Sat, 10 Oct 2020 22:18:13 +0000 (UTC)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Monakov <amonakov@ispras.ru>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] intel_idle: mention assumption that wbinvd is not needed
Date:   Sun, 11 Oct 2020 01:18:06 +0300
Message-Id: <20201010221806.2106-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Intel SDM does not explicitly say that entering a C-state via MWAIT will
implicitly flush CPU caches as appropriate for that C-state. However,
documentation for individual Intel CPU generations does mention this
behavior.

Since intel_idle binds to any Intel CPU with MWAIT, mention this
assumption on MWAIT behavior. In passing, reword opening comment
to make it clear that driver can load on any future Intel CPU with MWAIT.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Hi,

I noticed that one of significant optimizations of intel_idle over
acpi_idle is elision of explicit wbinvd: ACPI requires the OS to flush
caches when entering C3, and Linux issues an explicit wbinvd to do that,
but intel_idle simply issues mwait with the expectation that the CPU
will automatically flush caches if needed.

To me this is a fairly subtle point that became even more subtle
following the update to intel_idle that made it capable to bind to old
and future Intel CPUs with MWAIT (by the way, thanks for that!)

Can you take this patch to spell out the assumption?

 drivers/idle/intel_idle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f4495841bf68..1e5666cf8763 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -8,7 +8,7 @@
  */
 
 /*
- * intel_idle is a cpuidle driver that loads on specific Intel processors
+ * intel_idle is a cpuidle driver that loads on all Intel CPUs with MWAIT
  * in lieu of the legacy ACPI processor_idle driver.  The intent is to
  * make Linux more efficient on these processors, as intel_idle knows
  * more than ACPI, as well as make Linux more immune to ACPI BIOS bugs.
@@ -20,7 +20,11 @@
  * All CPUs have same idle states as boot CPU
  *
  * Chipset BM_STS (bus master status) bit is a NOP
- *	for preventing entry into deep C-stats
+ *	for preventing entry into deep C-states
+ *
+ * CPU will flush caches as needed when entering a C-state via MWAIT
+ *	(in contrast to entering ACPI C3, where acpi_idle driver is
+ *	itself responsible for flushing, via WBINVD)
  */
 
 /*
-- 
2.26.2

