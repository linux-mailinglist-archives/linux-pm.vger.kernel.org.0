Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33716159D48
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgBKXim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64962 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgBKXil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:41 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 58cecbe0eccce4dc; Wed, 12 Feb 2020 00:38:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 28/28] PM: QoS: Make CPU latency QoS depend on CONFIG_CPU_IDLE
Date:   Wed, 12 Feb 2020 00:37:11 +0100
Message-ID: <3915146.cHaPKLg5L1@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Because cpuidle is the only user of the effective constraint coming
from the CPU latency QoS, add #ifdef CONFIG_CPU_IDLE around that code
to avoid building it unnecessarily.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h | 13 +++++++++++++
 kernel/power/qos.c     |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index df065db3f57a..4a69d4af3ff8 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -143,11 +143,24 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 			 struct pm_qos_flags_request *req,
 			 enum pm_qos_req_action action, s32 val);
 
+#ifdef CONFIG_CPU_IDLE
 s32 cpu_latency_qos_limit(void);
 bool cpu_latency_qos_request_active(struct pm_qos_request *req);
 void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value);
 void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value);
 void cpu_latency_qos_remove_request(struct pm_qos_request *req);
+#else
+static inline s32 cpu_latency_qos_limit(void) { return INT_MAX; }
+static inline bool cpu_latency_qos_request_active(struct pm_qos_request *req)
+{
+	return false;
+}
+static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
+					       s32 value) {}
+static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
+						  s32 new_value) {}
+static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req) {}
+#endif
 
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index ef73573db43d..32927682bcc4 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -209,6 +209,7 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 	return prev_value != curr_value;
 }
 
+#ifdef CONFIG_CPU_IDLE
 /* Definitions related to the CPU latency QoS. */
 
 static struct pm_qos_constraints cpu_latency_constraints = {
@@ -421,6 +422,7 @@ static int __init cpu_latency_qos_init(void)
 	return ret;
 }
 late_initcall(cpu_latency_qos_init);
+#endif /* CONFIG_CPU_IDLE */
 
 /* Definitions related to the frequency QoS below. */
 
-- 
2.16.4





