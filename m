Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54887159D72
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgBKXj5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:57 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53061 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgBKXiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:51 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 173fdcca87f84597; Wed, 12 Feb 2020 00:38:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 12/28] PM: QoS: Adjust pm_qos_request() signature and reorder pm_qos.h
Date:   Wed, 12 Feb 2020 00:07:01 +0100
Message-ID: <4773738.66pf8vIe9V@kreacher>
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

Change the return type of pm_qos_request() to be the same as the
one of pm_qos_read_value() called by it internally and stop exporting
it to modules (because its only caller, cpuidle, is not modular).

Also move the pm_qos_read_value() header away from the CPU latency
QoS API function headers in pm_qos.h (because it technically does
not belong to that API).

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h | 6 +++---
 kernel/power/qos.c     | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index a3e0bfc6c470..3c4bee29ecda 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -137,20 +137,20 @@ static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
 	return req->dev != NULL;
 }
 
+s32 pm_qos_read_value(struct pm_qos_constraints *c);
 int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 			 enum pm_qos_req_action action, int value);
 bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 			 struct pm_qos_flags_request *req,
 			 enum pm_qos_req_action action, s32 val);
+
 void pm_qos_add_request(struct pm_qos_request *req, int pm_qos_class,
 			s32 value);
 void pm_qos_update_request(struct pm_qos_request *req,
 			   s32 new_value);
 void pm_qos_remove_request(struct pm_qos_request *req);
-
-int pm_qos_request(int pm_qos_class);
+s32 pm_qos_request(int pm_qos_class);
 int pm_qos_request_active(struct pm_qos_request *req);
-s32 pm_qos_read_value(struct pm_qos_constraints *c);
 
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index afac7010e0f2..7bb55aca03bb 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -235,11 +235,10 @@ static struct pm_qos_constraints cpu_latency_constraints = {
  *
  * This function returns the current target value.
  */
-int pm_qos_request(int pm_qos_class)
+s32 pm_qos_request(int pm_qos_class)
 {
 	return pm_qos_read_value(&cpu_latency_constraints);
 }
-EXPORT_SYMBOL_GPL(pm_qos_request);
 
 int pm_qos_request_active(struct pm_qos_request *req)
 {
-- 
2.16.4





