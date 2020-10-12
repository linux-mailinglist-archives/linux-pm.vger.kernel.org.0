Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A435928B4FB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgJLMu7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 08:50:59 -0400
Received: from mail.ispras.ru ([83.149.199.84]:40002 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgJLMu7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 08:50:59 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id 60FCC40D4004;
        Mon, 12 Oct 2020 12:50:57 +0000 (UTC)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Monakov <amonakov@ispras.ru>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] intel_idle: mention assumption that wbinvd is not needed
Date:   Mon, 12 Oct 2020 15:50:33 +0300
Message-Id: <20201012125033.2809-1-amonakov@ispras.ru>
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

Since intel_idle binds to any Intel CPU with MWAIT, list this assumption
of MWAIT behavior. In passing, reword opening comment to make it clear
that the driver can load on any old and future Intel CPU with MWAIT.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2: reword remark about WBINVD (Rafael)

 drivers/idle/intel_idle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f4495841bf68..6d87f2129119 100644
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
+ *	(in contrast to entering ACPI C3, in which case the WBINVD
+ *	instruction needs to be executed to flush the caches)
  */
 
 /*
-- 
2.26.2

