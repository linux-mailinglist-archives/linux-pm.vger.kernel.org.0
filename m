Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB4703F0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 17:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfGVPhz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 11:37:55 -0400
Received: from foss.arm.com ([217.140.110.172]:39748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbfGVPhz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 11:37:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E87AC1596;
        Mon, 22 Jul 2019 08:37:54 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798643F694;
        Mon, 22 Jul 2019 08:37:53 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/6] ARM: cpuidle: Remove overzealous error logging
Date:   Mon, 22 Jul 2019 16:37:41 +0100
Message-Id: <20190722153745.32446-3-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUidle back-end operations are not implemented in some platforms
but this should not be considered an error serious enough to be
logged. Check the arm_cpuidle_init() return value to detect whether
the failure must be reported or not in the kernel log and do
not log it if the platform does not support CPUidle operations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/cpuidle/cpuidle-arm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index dc33b3d2954f..9e5156d39627 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -105,11 +105,17 @@ static int __init arm_idle_init_cpu(int cpu)
 	ret = arm_cpuidle_init(cpu);
 
 	/*
-	 * Allow the initialization to continue for other CPUs, if the reported
-	 * failure is a HW misconfiguration/breakage (-ENXIO).
+	 * Allow the initialization to continue for other CPUs, if the
+	 * reported failure is a HW misconfiguration/breakage (-ENXIO).
+	 *
+	 * Some platforms do not support idle operations
+	 * (arm_cpuidle_init() returning -EOPNOTSUPP), we should
+	 * not flag this case as an error, it is a valid
+	 * configuration.
 	 */
 	if (ret) {
-		pr_err("CPU %d failed to init idle CPU ops\n", cpu);
+		if (ret != -EOPNOTSUPP)
+			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
 		ret = ret == -ENXIO ? 0 : ret;
 		goto out_kfree_drv;
 	}
-- 
2.21.0

