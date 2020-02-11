Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63420159D62
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgBKXiw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:52 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62451 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgBKXiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:51 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 5bf8a385c2cf4050; Wed, 12 Feb 2020 00:38:49 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 13/28] PM: QoS: Add CPU latency QoS API wrappers
Date:   Wed, 12 Feb 2020 00:07:42 +0100
Message-ID: <3944283.XRuKlcf6xm@kreacher>
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

Introduce (temporary) wrappers around pm_qos_request(),
pm_qos_request_active() and pm_qos_add/update/remove_request() to
provide replacements for them with function signatures that will be
used in the final CPU latency QoS API, so that the users of it can be
switched over to the new arrangement one by one before the API is
finally set.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 3c4bee29ecda..63d39e66f95d 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -152,6 +152,33 @@ void pm_qos_remove_request(struct pm_qos_request *req);
 s32 pm_qos_request(int pm_qos_class);
 int pm_qos_request_active(struct pm_qos_request *req);
 
+static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
+					       s32 value)
+{
+	pm_qos_add_request(req, PM_QOS_CPU_DMA_LATENCY, value);
+}
+
+static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
+						  s32 new_value)
+{
+	pm_qos_update_request(req, new_value);
+}
+
+static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req)
+{
+	pm_qos_remove_request(req);
+}
+
+static inline bool cpu_latency_qos_request_active(struct pm_qos_request *req)
+{
+	return pm_qos_request_active(req);
+}
+
+static inline s32 cpu_latency_qos_limit(void)
+{
+	return pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+}
+
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
-- 
2.16.4





