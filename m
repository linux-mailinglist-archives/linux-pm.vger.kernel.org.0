Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4A159D6A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgBKXj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:29 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59281 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgBKXjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:02 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 6c68c8faf8632b37; Wed, 12 Feb 2020 00:38:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 05/28] PM: QoS: Clean up pm_qos_read_value() and pm_qos_get/set_value()
Date:   Tue, 11 Feb 2020 23:58:39 +0100
Message-ID: <4773736.iBQsUQvRLO@kreacher>
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

Move the definition of pm_qos_read_value() before the one of
pm_qos_get_value() and add a kerneldoc comment to it (as it is
not static).

Also replace the BUG() in pm_qos_get_value() with WARN() (to
prevent the kernel from crashing if an unknown PM QoS type is
used by mistake) and drop the comment next to it that is not
necessary any more.

Additionally, drop the unnecessary inline modifier from the header
of pm_qos_set_value().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/qos.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 6a36809d6160..f09eca5ffe07 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -98,8 +98,16 @@ static const struct file_operations pm_qos_power_fops = {
 	.llseek = noop_llseek,
 };
 
-/* unlocked internal variant */
-static inline int pm_qos_get_value(struct pm_qos_constraints *c)
+/**
+ * pm_qos_read_value - Return the current effective constraint value.
+ * @c: List of PM QoS constraint requests.
+ */
+s32 pm_qos_read_value(struct pm_qos_constraints *c)
+{
+	return c->target_value;
+}
+
+static int pm_qos_get_value(struct pm_qos_constraints *c)
 {
 	if (plist_head_empty(&c->list))
 		return c->no_constraint_value;
@@ -112,18 +120,12 @@ static inline int pm_qos_get_value(struct pm_qos_constraints *c)
 		return plist_last(&c->list)->prio;
 
 	default:
-		/* runtime check for not using enum */
-		BUG();
+		WARN(1, "Unknown PM QoS type in %s\n", __func__);
 		return PM_QOS_DEFAULT_VALUE;
 	}
 }
 
-s32 pm_qos_read_value(struct pm_qos_constraints *c)
-{
-	return c->target_value;
-}
-
-static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
+static void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 {
 	c->target_value = value;
 }
-- 
2.16.4





