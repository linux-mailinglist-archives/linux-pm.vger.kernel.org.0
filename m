Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D456D9B0A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbjDFOrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjDFOrd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 10:47:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E4CBBAD
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 07:45:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pskns2WsXz4xDt;
        Fri,  7 Apr 2023 00:45:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1680792353;
        bh=K5G4sSTXgNXS7YdhIg4VtzOB7UwPzbyCN9hXlUrIQvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzSZ31ZxAODsLSMGjrCaYgfR9gKyzhjdYKrfNIMn0CDQndzCxdPFO8KHIitb0bX4M
         GJASLOjAAAgJgqy3T7w8jhoi8tkKS6k5i9OYrfsCn6N4alSJvviCIZbr79a5MhzLRq
         GAl/hha49Aj5oMACTF5mFPJ+LjP382+LIJoE/9EYFjf3w8imVlvYO4WNmz4WdOa+R9
         swSg9tVF4Owh6a+dAldDRH3NgwMdWQjNk5teVP/IRKP5LdlKN4B65/hDNMgMOFGr+d
         R/5xFryNVv+HkHxlHJOxRGxqyL6GQPmMJduocioTeJ2al9LUOWgj8K6ay5IeyXTAe+
         PptM3lvbmt23Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <peterz@infradead.org>, <npiggin@gmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/4] cpuidle: pseries: Mark ->enter() functions as __cpuidle
Date:   Fri,  7 Apr 2023 00:45:34 +1000
Message-Id: <20230406144535.3786008-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144535.3786008-1-mpe@ellerman.id.au>
References: <20230406144535.3786008-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Code in the idle path is not allowed to be instrumented because RCU is
disabled, see commit 0e985e9d2286 ("cpuidle: Add comments about
noinstr/__cpuidle usage").

Mark the cpuidle ->enter() callbacks as __cpuidle and use the
raw_local_irq_*() routines to ensure that is the case.

Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/cpuidle/cpuidle-pseries.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 1bad4d2b7be3..a7d33f3ee01e 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -33,16 +33,16 @@ static struct cpuidle_state *cpuidle_state_table __read_mostly;
 static u64 snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
 
-static int snooze_loop(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			int index)
+static __cpuidle
+int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
+		int index)
 {
 	u64 snooze_exit_time;
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	pseries_idle_prolog();
-	local_irq_enable();
+	raw_local_irq_enable();
 	snooze_exit_time = get_tb() + snooze_timeout;
 	dev->poll_time_limit = false;
 
@@ -65,14 +65,14 @@ static int snooze_loop(struct cpuidle_device *dev,
 	HMT_medium();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	pseries_idle_epilog();
 
 	return index;
 }
 
-static void check_and_cede_processor(void)
+static __cpuidle void check_and_cede_processor(void)
 {
 	/*
 	 * Ensure our interrupt state is properly tracked,
@@ -216,9 +216,9 @@ static int __init parse_cede_parameters(void)
 #define NR_DEDICATED_STATES	2 /* snooze, CEDE */
 static u8 cede_latency_hint[NR_DEDICATED_STATES];
 
-static int dedicated_cede_loop(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+static __cpuidle
+int dedicated_cede_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
+			int index)
 {
 	u8 old_latency_hint;
 
@@ -230,7 +230,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	HMT_medium();
 	check_and_cede_processor();
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	get_lppaca()->donate_dedicated_cpu = 0;
 	get_lppaca()->cede_latency_hint = old_latency_hint;
 
@@ -239,9 +239,9 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	return index;
 }
 
-static int shared_cede_loop(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			int index)
+static __cpuidle
+int shared_cede_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
+		     int index)
 {
 
 	pseries_idle_prolog();
@@ -255,7 +255,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 	 */
 	check_and_cede_processor();
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	pseries_idle_epilog();
 
 	return index;
-- 
2.39.2

