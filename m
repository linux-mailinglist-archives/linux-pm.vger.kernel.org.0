Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073722A3FB0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 10:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgKCJGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 04:06:37 -0500
Received: from foss.arm.com ([217.140.110.172]:44752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgKCJGb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 04:06:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0D371424;
        Tue,  3 Nov 2020 01:06:30 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.19.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EC2F3F719;
        Tue,  3 Nov 2020 01:06:26 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, amitk@kernel.org, corbet@lwn.net,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, dianders@chromium.org, mka@chromium.org,
        rnayak@codeaurora.org, rafael@kernel.org, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, sboyd@kernel.org, nm@ti.com
Subject: [PATCH v4 3/4] PM / EM: update the comments related to power scale
Date:   Tue,  3 Nov 2020 09:05:59 +0000
Message-Id: <20201103090600.29053-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103090600.29053-1-lukasz.luba@arm.com>
References: <20201103090600.29053-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model supports power values expressed in milli-Watts or in an
'abstract scale'. Update the related comments is the code to reflect that
state.

Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 11 +++++------
 kernel/power/energy_model.c  |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 685d9e919137..65a0c6ce0616 100644
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
@@ -58,7 +57,7 @@ struct em_data_callback {
 	/**
 	 * active_power() - Provide power at the next performance state of
 	 *		a device
-	 * @power	: Active power at the performance state in mW
+	 * @power	: Active power at the performance state
 	 *		(modified)
 	 * @freq	: Frequency at the performance state in kHz
 	 *		(modified)
@@ -69,8 +68,8 @@ struct em_data_callback {
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
index efe2a595988e..1358fa4abfa8 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -143,7 +143,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 
 		/*
 		 * The power returned by active_state() is expected to be
-		 * positive, in milli-watts and to fit into 16 bits.
+		 * positive and to fit into 16 bits.
 		 */
 		if (!power || power > EM_MAX_POWER) {
 			dev_err(dev, "EM: invalid power: %lu\n",
-- 
2.17.1

