Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E2540622C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 02:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhIJAo4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 20:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233876AbhIJAV6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 20:21:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1817D611BF;
        Fri, 10 Sep 2021 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631233248;
        bh=bFudKSCOtqCJSbzerv9YL80dTH1IVwrlA8bgY8TI2qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrieefCADGWs7dKCpmXIkMyg0HVrcB0qyO6uI8PYR7gNc/13eAmK9wHPF51FQHHPD
         ANCYzGpso+DLL+XJSKPyWEELQNbBWJLgxONBgDQbiVw1OMK03I3t3UshyMZ9fqs+9v
         GCTMBbj6Bx333/ln0cHUSdOZXSAnGm2yxYZhI4xt1V3tsltlpwQ38qj+T/jFt23EWx
         Yesd3ZLSJoi5j44H1PVh7dYatg+T/BASO9Ii1f3q5DAJpxH05DFTO5iU5xJLs4H8ft
         ZCN3rgO/0nlT5n1vuEhEAIbHlHffhtgsa1KBKRVa7dSAEPEuSDFMsGQFi7ChGdUzmB
         QJEentlR9qtvw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.10 14/53] cpuidle: pseries: Do not cap the CEDE0 latency in fixup_cede0_latency()
Date:   Thu,  9 Sep 2021 20:19:49 -0400
Message-Id: <20210910002028.175174-14-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910002028.175174-1-sashal@kernel.org>
References: <20210910002028.175174-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

[ Upstream commit 71737a6c2a8f801622d2b71567d1ec1e4c5b40b8 ]

Currently in fixup_cede0_latency() code, we perform the fixup the
CEDE(0) exit latency value only if minimum advertized extended CEDE
latency values are less than 10us. This was done so as to not break
the expected behaviour on POWER8 platforms where the advertised
latency was higher than the default 10us, which would delay the SMT
folding on the core.

However, after the earlier patch "cpuidle/pseries: Fixup CEDE0 latency
only for POWER10 onwards", we can be sure that the fixup of CEDE0
latency is going to happen only from POWER10 onwards. Hence
unconditionally use the minimum exit latency provided by the platform.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1626676399-15975-3-git-send-email-ego@linux.vnet.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle-pseries.c | 59 ++++++++++++++++---------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index a2b5c6f60cf0..18747e5287c8 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -346,11 +346,9 @@ static int pseries_cpuidle_driver_init(void)
 static void __init fixup_cede0_latency(void)
 {
 	struct xcede_latency_payload *payload;
-	u64 min_latency_us;
+	u64 min_xcede_latency_us = UINT_MAX;
 	int i;
 
-	min_latency_us = dedicated_states[1].exit_latency; // CEDE latency
-
 	if (parse_cede_parameters())
 		return;
 
@@ -358,42 +356,45 @@ static void __init fixup_cede0_latency(void)
 		nr_xcede_records);
 
 	payload = &xcede_latency_parameter.payload;
+
+	/*
+	 * The CEDE idle state maps to CEDE(0). While the hypervisor
+	 * does not advertise CEDE(0) exit latency values, it does
+	 * advertise the latency values of the extended CEDE states.
+	 * We use the lowest advertised exit latency value as a proxy
+	 * for the exit latency of CEDE(0).
+	 */
 	for (i = 0; i < nr_xcede_records; i++) {
 		struct xcede_latency_record *record = &payload->records[i];
+		u8 hint = record->hint;
 		u64 latency_tb = be64_to_cpu(record->latency_ticks);
 		u64 latency_us = DIV_ROUND_UP_ULL(tb_to_ns(latency_tb), NSEC_PER_USEC);
 
-		if (latency_us == 0)
-			pr_warn("cpuidle: xcede record %d has an unrealistic latency of 0us.\n", i);
-
-		if (latency_us < min_latency_us)
-			min_latency_us = latency_us;
-	}
-
-	/*
-	 * By default, we assume that CEDE(0) has exit latency 10us,
-	 * since there is no way for us to query from the platform.
-	 *
-	 * However, if the wakeup latency of an Extended CEDE state is
-	 * smaller than 10us, then we can be sure that CEDE(0)
-	 * requires no more than that.
-	 *
-	 * Perform the fix-up.
-	 */
-	if (min_latency_us < dedicated_states[1].exit_latency) {
 		/*
-		 * We set a minimum of 1us wakeup latency for cede0 to
-		 * distinguish it from snooze
+		 * We expect the exit latency of an extended CEDE
+		 * state to be non-zero, it to since it takes at least
+		 * a few nanoseconds to wakeup the idle CPU and
+		 * dispatch the virtual processor into the Linux
+		 * Guest.
+		 *
+		 * So we consider only non-zero value for performing
+		 * the fixup of CEDE(0) latency.
 		 */
-		u64 cede0_latency = 1;
+		if (latency_us == 0) {
+			pr_warn("cpuidle: Skipping xcede record %d [hint=%d]. Exit latency = 0us\n",
+				i, hint);
+			continue;
+		}
 
-		if (min_latency_us > cede0_latency)
-			cede0_latency = min_latency_us - 1;
+		if (latency_us < min_xcede_latency_us)
+			min_xcede_latency_us = latency_us;
+	}
 
-		dedicated_states[1].exit_latency = cede0_latency;
-		dedicated_states[1].target_residency = 10 * (cede0_latency);
+	if (min_xcede_latency_us != UINT_MAX) {
+		dedicated_states[1].exit_latency = min_xcede_latency_us;
+		dedicated_states[1].target_residency = 10 * (min_xcede_latency_us);
 		pr_info("cpuidle: Fixed up CEDE exit latency to %llu us\n",
-			cede0_latency);
+			min_xcede_latency_us);
 	}
 
 }
-- 
2.30.2

