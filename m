Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB387824
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406454AbfHILDZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:03:25 -0400
Received: from foss.arm.com ([217.140.110.172]:45556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406441AbfHILDZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 07:03:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E0781684;
        Fri,  9 Aug 2019 04:03:24 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B74B93F575;
        Fri,  9 Aug 2019 04:03:22 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/8] ARM: cpuidle: Remove overzealous error logging
Date:   Fri,  9 Aug 2019 12:03:08 +0100
Message-Id: <bfaea706699cd51341ef1870bc485c8554ebb0be.1565348376.git.lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565348376.git.lorenzo.pieralisi@arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com> <cover.1565348376.git.lorenzo.pieralisi@arm.com>
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
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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

