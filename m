Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6153FC596
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbhHaKZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 06:25:32 -0400
Received: from foss.arm.com ([217.140.110.172]:52866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240895AbhHaKZa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 06:25:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447B31063;
        Tue, 31 Aug 2021 03:24:35 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE8BE3F5A1;
        Tue, 31 Aug 2021 03:24:33 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v6 1/7] PM / EM: Fix inefficient states detection
Date:   Tue, 31 Aug 2021 11:24:07 +0100
Message-Id: <1630405453-275784-2-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, a debug message is printed if an inefficient state is detected
in the Energy Model. Unfortunately, it won't detect if the first state is
inefficient or if two successive states are. Fix this behavior.

Fixes: 27871f7a8a34 (PM: Introduce an Energy Model management framework)
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index a332ccd829e2..97e62469a6b3 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -107,8 +107,7 @@ static void em_debug_remove_pd(struct device *dev) {}
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				int nr_states, struct em_data_callback *cb)
 {
-	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
-	unsigned long power, freq, prev_freq = 0;
+	unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
 	struct em_perf_state *table;
 	int i, ret;
 	u64 fmax;
@@ -153,27 +152,21 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 
 		table[i].power = power;
 		table[i].frequency = prev_freq = freq;
-
-		/*
-		 * The hertz/watts efficiency ratio should decrease as the
-		 * frequency grows on sane platforms. But this isn't always
-		 * true in practice so warn the user if a higher OPP is more
-		 * power efficient than a lower one.
-		 */
-		opp_eff = freq / power;
-		if (opp_eff >= prev_opp_eff)
-			dev_dbg(dev, "EM: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
-					i, i - 1);
-		prev_opp_eff = opp_eff;
 	}
 
 	/* Compute the cost of each performance state. */
 	fmax = (u64) table[nr_states - 1].frequency;
-	for (i = 0; i < nr_states; i++) {
+	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res = em_scale_power(table[i].power);
 
 		table[i].cost = div64_u64(fmax * power_res,
 					  table[i].frequency);
+		if (table[i].cost >= prev_cost) {
+			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
+				table[i].frequency);
+		} else {
+			prev_cost = table[i].cost;
+		}
 	}
 
 	pd->table = table;
-- 
2.7.4

