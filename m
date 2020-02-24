Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1A16A800
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBXONB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 09:13:01 -0500
Received: from foss.arm.com ([217.140.110.172]:37732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgBXONA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Feb 2020 09:13:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD37530E;
        Mon, 24 Feb 2020 06:12:59 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6090F3F534;
        Mon, 24 Feb 2020 06:12:57 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 7/7] clocksource/drivers/arm_arch_timer: validate arch_timer_rate
Date:   Mon, 24 Feb 2020 14:11:42 +0000
Message-Id: <20200224141142.25445-8-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224141142.25445-1-ionela.voinescu@arm.com>
References: <20200224141142.25445-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Using an arch timer with a frequency of less than 1MHz can potentially
result in incorrect functionality in systems that assume a reasonable
rate of the arch timer of 1 to 50MHz, described as typical in the
architecture specification.

Therefore, warn if the arch timer rate is below 1MHz, which is
considered atypical and worth emphasizing.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a5464c625b4..4faa930eabf8 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -885,6 +885,17 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int validate_timer_rate(void)
+{
+	if (!arch_timer_rate)
+		return -EINVAL;
+
+	/* Arch timer frequency < 1MHz can cause trouble */
+	WARN_ON(arch_timer_rate < 1000000);
+
+	return 0;
+}
+
 /*
  * For historical reasons, when probing with DT we use whichever (non-zero)
  * rate was probed first, and don't verify that others match. If the first node
@@ -900,7 +911,7 @@ static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
 		arch_timer_rate = rate;
 
 	/* Check the timer frequency. */
-	if (arch_timer_rate == 0)
+	if (validate_timer_rate())
 		pr_warn("frequency not available\n");
 }
 
@@ -1594,9 +1605,10 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	 * CNTFRQ value. This *must* be correct.
 	 */
 	arch_timer_rate = arch_timer_get_cntfrq();
-	if (!arch_timer_rate) {
+	ret = validate_timer_rate();
+	if (ret) {
 		pr_err(FW_BUG "frequency not available.\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	arch_timer_uses_ppi = arch_timer_select_ppi();
-- 
2.17.1

