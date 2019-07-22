Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3315703E8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfGVPiA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 11:38:00 -0400
Received: from foss.arm.com ([217.140.110.172]:39760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbfGVPh5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 11:37:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0C915A1;
        Mon, 22 Jul 2019 08:37:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF0C3F694;
        Mon, 22 Jul 2019 08:37:55 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/6] drivers: firmware: psci: Decouple checker from generic ARM CPUidle
Date:   Mon, 22 Jul 2019 16:37:42 +0100
Message-Id: <20190722153745.32446-4-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The PSCI checker currently relies on the generic ARM CPUidle
infrastructure to enter an idle state, which in turn creates
a dependency that is not really needed.

The PSCI checker code to test PSCI CPU suspend is built on
top of the CPUidle framework and can easily reuse the
struct cpuidle_state.enter() function (previously initialized
by an idle driver, with a PSCI back-end) to trigger an entry
into an idle state, decoupling the PSCI checker from the
generic ARM CPUidle infrastructure and simplyfing the code
in the process.

Convert the PSCI checker suspend entry function to use
the struct cpuidle_state.enter() function callback.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 drivers/firmware/psci/psci_checker.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index f3659443f8c2..6a445397771c 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -228,8 +228,11 @@ static int hotplug_tests(void)
 
 static void dummy_callback(struct timer_list *unused) {}
 
-static int suspend_cpu(int index, bool broadcast)
+static int suspend_cpu(struct cpuidle_device *dev,
+		       struct cpuidle_driver *drv, int index)
 {
+	struct cpuidle_state *state = &drv->states[index];
+	bool broadcast = state->flags & CPUIDLE_FLAG_TIMER_STOP;
 	int ret;
 
 	arch_cpu_idle_enter();
@@ -254,11 +257,7 @@ static int suspend_cpu(int index, bool broadcast)
 		}
 	}
 
-	/*
-	 * Replicate the common ARM cpuidle enter function
-	 * (arm_enter_idle_state).
-	 */
-	ret = CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, index);
+	ret = state->enter(dev, drv, index);
 
 	if (broadcast)
 		tick_broadcast_exit();
@@ -301,9 +300,8 @@ static int suspend_test_thread(void *arg)
 		 * doesn't use PSCI).
 		 */
 		for (index = 1; index < drv->state_count; ++index) {
-			struct cpuidle_state *state = &drv->states[index];
-			bool broadcast = state->flags & CPUIDLE_FLAG_TIMER_STOP;
 			int ret;
+			struct cpuidle_state *state = &drv->states[index];
 
 			/*
 			 * Set the timer to wake this CPU up in some time (which
@@ -318,7 +316,7 @@ static int suspend_test_thread(void *arg)
 			/* IRQs must be disabled during suspend operations. */
 			local_irq_disable();
 
-			ret = suspend_cpu(index, broadcast);
+			ret = suspend_cpu(dev, drv, index);
 
 			/*
 			 * We have woken up. Re-enable IRQs to handle any
-- 
2.21.0

