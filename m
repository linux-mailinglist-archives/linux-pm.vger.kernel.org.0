Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64D2159D6D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgBKXji (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:38 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61619 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgBKXjB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:01 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9bf901beddd75d4f; Wed, 12 Feb 2020 00:39:00 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 04/28] PM: QoS: Clean up pm_qos_update_target() and pm_qos_update_flags()
Date:   Tue, 11 Feb 2020 23:58:33 +0100
Message-ID: <1746259.hJgS1hQAGi@kreacher>
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

Clean up the pm_qos_update_target() function:
 * Update its kerneldoc comment.
 * Drop the redundant ret local variable from it.
 * Reorder definitions of local variables in it.
 * Update a comment in it.

Also update the kerneldoc comment of pm_qos_update_flags() (e.g.
notifiers are not called by it any more) and add one emtpy line
to its body (for more visual clarity).

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/qos.c | 56 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index a6be7faa1974..6a36809d6160 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -129,24 +129,30 @@ static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 }
 
 /**
- * pm_qos_update_target - manages the constraints list and calls the notifiers
- *  if needed
- * @c: constraints data struct
- * @node: request to add to the list, to update or to remove
- * @action: action to take on the constraints list
- * @value: value of the request to add or update
+ * pm_qos_update_target - Update a list of PM QoS constraint requests.
+ * @c: List of PM QoS requests.
+ * @node: Target list entry.
+ * @action: Action to carry out (add, update or remove).
+ * @value: New request value for the target list entry.
  *
- * This function returns 1 if the aggregated constraint value has changed, 0
- *  otherwise.
+ * Update the given list of PM QoS constraint requests, @c, by carrying an
+ * @action involving the @node list entry and @value on it.
+ *
+ * The recognized values of @action are PM_QOS_ADD_REQ (store @value in @node
+ * and add it to the list), PM_QOS_UPDATE_REQ (remove @node from the list, store
+ * @value in it and add it to the list again), and PM_QOS_REMOVE_REQ (remove
+ * @node from the list, ignore @value).
+ *
+ * Return: 1 if the aggregate constraint value has changed, 0  otherwise.
  */
 int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 			 enum pm_qos_req_action action, int value)
 {
-	unsigned long flags;
 	int prev_value, curr_value, new_value;
-	int ret;
+	unsigned long flags;
 
 	spin_lock_irqsave(&pm_qos_lock, flags);
+
 	prev_value = pm_qos_get_value(c);
 	if (value == PM_QOS_DEFAULT_VALUE)
 		new_value = c->default_value;
@@ -159,9 +165,8 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 		break;
 	case PM_QOS_UPDATE_REQ:
 		/*
-		 * to change the list, we atomically remove, reinit
-		 * with new value and add, then see if the extremal
-		 * changed
+		 * To change the list, atomically remove, reinit with new value
+		 * and add, then see if the aggregate has changed.
 		 */
 		plist_del(node, &c->list);
 		/* fall through */
@@ -180,16 +185,14 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
 	trace_pm_qos_update_target(action, prev_value, curr_value);
-	if (prev_value != curr_value) {
-		ret = 1;
-		if (c->notifiers)
-			blocking_notifier_call_chain(c->notifiers,
-						     (unsigned long)curr_value,
-						     NULL);
-	} else {
-		ret = 0;
-	}
-	return ret;
+
+	if (prev_value == curr_value)
+		return 0;
+
+	if (c->notifiers)
+		blocking_notifier_call_chain(c->notifiers, curr_value, NULL);
+
+	return 1;
 }
 
 /**
@@ -211,14 +214,12 @@ static void pm_qos_flags_remove_req(struct pm_qos_flags *pqf,
 
 /**
  * pm_qos_update_flags - Update a set of PM QoS flags.
- * @pqf: Set of flags to update.
+ * @pqf: Set of PM QoS flags to update.
  * @req: Request to add to the set, to modify, or to remove from the set.
  * @action: Action to take on the set.
  * @val: Value of the request to add or modify.
  *
- * Update the given set of PM QoS flags and call notifiers if the aggregate
- * value has changed.  Returns 1 if the aggregate constraint value has changed,
- * 0 otherwise.
+ * Return: 1 if the aggregate constraint value has changed, 0 otherwise.
  */
 bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 			 struct pm_qos_flags_request *req,
@@ -254,6 +255,7 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 	spin_unlock_irqrestore(&pm_qos_lock, irqflags);
 
 	trace_pm_qos_update_flags(action, prev_value, curr_value);
+
 	return prev_value != curr_value;
 }
 
-- 
2.16.4





