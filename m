Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F227CA19
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 14:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgI2MQe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 08:16:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730048AbgI2MQb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 08:16:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C3E814BF;
        Tue, 29 Sep 2020 05:16:30 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.50.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2933E3F73B;
        Tue, 29 Sep 2020 05:16:27 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, qperret@google.com, mka@chromium.org,
        rjw@rjwysocki.net
Subject: [PATCH 2/2] PM / EM: update the comments related to power scale
Date:   Tue, 29 Sep 2020 13:16:10 +0100
Message-Id: <20200929121610.16060-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929121610.16060-1-lukasz.luba@arm.com>
References: <20200929121610.16060-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model supports power values expressed in milli-Watts or in an
'abstract scale'. Update the related comments is the code to reflect that
state.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 11 +++++------
 kernel/power/energy_model.c  |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b67a51c574b9..b19146b31760 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -13,9 +13,8 @@
 /**
  * em_perf_state - Performance state of a performance domain
  * @frequency:	The frequency in KHz, for consistency with CPUFreq
- * @power:	The power consumed at this level, in milli-watts (by 1 CPU or
-		by a registered device). It can be a total power: static and
-		dynamic.
+ * @power:	The power consumed at this level (by 1 CPU or by a registered
+ *		device). It can be a total power: static and dynamic.
  * @cost:	The cost coefficient associated with this level, used during
  *		energy calculation. Equal to: power * max_frequency / frequency
  */
@@ -55,7 +54,7 @@ struct em_data_callback {
 	/**
 	 * active_power() - Provide power at the next performance state of
 	 *		a device
-	 * @power	: Active power at the performance state in mW
+	 * @power	: Active power at the performance state
 	 *		(modified)
 	 * @freq	: Frequency at the performance state in kHz
 	 *		(modified)
@@ -66,8 +65,8 @@ struct em_data_callback {
 	 * and frequency.
 	 *
 	 * In case of CPUs, the power is the one of a single CPU in the domain,
-	 * expressed in milli-watts. It is expected to fit in the
-	 * [0, EM_MAX_POWER] range.
+	 * expressed in milli-Watts or an abstract scale. It is expected to
+	 * fit in the [0, EM_MAX_POWER] range.
 	 *
 	 * Return 0 on success.
 	 */
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index c1ff7fa030ab..2bd2afbb83f5 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -130,7 +130,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 
 		/*
 		 * The power returned by active_state() is expected to be
-		 * positive, in milli-watts and to fit into 16 bits.
+		 * positive and to fit into 16 bits.
 		 */
 		if (!power || power > EM_MAX_POWER) {
 			dev_err(dev, "EM: invalid power: %lu\n",
-- 
2.17.1

