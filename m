Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5934A159D56
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgBKXjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57039 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgBKXjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:04 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 6e9d651d0f4d8073; Wed, 12 Feb 2020 00:39:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 02/28] PM: QoS: Drop pm_qos_update_request_timeout()
Date:   Tue, 11 Feb 2020 23:58:17 +0100
Message-ID: <1676747.ilkPls4vKt@kreacher>
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

The pm_qos_update_request_timeout() function is not called from
anywhere, so drop it along with the work member in struct
pm_qos_request needed by it.

Also drop the useless pm_qos_update_request_timeout trace event
that is only triggered by that function (so it never triggers at
all) and update the trace events documentation accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/trace/events-power.rst |  2 --
 include/linux/pm_qos.h               |  4 ---
 include/trace/events/power.h         | 24 ------------------
 kernel/power/qos.c                   | 48 ------------------------------------
 4 files changed, 78 deletions(-)

diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
index 2ef318962e29..eec7453a168e 100644
--- a/Documentation/trace/events-power.rst
+++ b/Documentation/trace/events-power.rst
@@ -78,11 +78,9 @@ target/flags update.
   pm_qos_add_request                 "pm_qos_class=%s value=%d"
   pm_qos_update_request              "pm_qos_class=%s value=%d"
   pm_qos_remove_request              "pm_qos_class=%s value=%d"
-  pm_qos_update_request_timeout      "pm_qos_class=%s value=%d, timeout_us=%ld"
 
 The first parameter gives the QoS class name (e.g. "CPU_DMA_LATENCY").
 The second parameter is value to be added/updated/removed.
-The third parameter is timeout value in usec.
 ::
 
   pm_qos_update_target               "action=%s prev_value=%d curr_value=%d"
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 19eafca5680e..4747bdb6bed2 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -8,7 +8,6 @@
 #include <linux/plist.h>
 #include <linux/notifier.h>
 #include <linux/device.h>
-#include <linux/workqueue.h>
 
 enum {
 	PM_QOS_RESERVED = 0,
@@ -43,7 +42,6 @@ enum pm_qos_flags_status {
 struct pm_qos_request {
 	struct plist_node node;
 	int pm_qos_class;
-	struct delayed_work work; /* for pm_qos_update_request_timeout */
 };
 
 struct pm_qos_flags_request {
@@ -149,8 +147,6 @@ void pm_qos_add_request(struct pm_qos_request *req, int pm_qos_class,
 			s32 value);
 void pm_qos_update_request(struct pm_qos_request *req,
 			   s32 new_value);
-void pm_qos_update_request_timeout(struct pm_qos_request *req,
-				   s32 new_value, unsigned long timeout_us);
 void pm_qos_remove_request(struct pm_qos_request *req);
 
 int pm_qos_request(int pm_qos_class);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 7457e238e1b7..ecf39daabf16 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -404,30 +404,6 @@ DEFINE_EVENT(pm_qos_request, pm_qos_remove_request,
 	TP_ARGS(pm_qos_class, value)
 );
 
-TRACE_EVENT(pm_qos_update_request_timeout,
-
-	TP_PROTO(int pm_qos_class, s32 value, unsigned long timeout_us),
-
-	TP_ARGS(pm_qos_class, value, timeout_us),
-
-	TP_STRUCT__entry(
-		__field( int,                    pm_qos_class   )
-		__field( s32,                    value          )
-		__field( unsigned long,          timeout_us     )
-	),
-
-	TP_fast_assign(
-		__entry->pm_qos_class = pm_qos_class;
-		__entry->value = value;
-		__entry->timeout_us = timeout_us;
-	),
-
-	TP_printk("pm_qos_class=%s value=%d, timeout_us=%ld",
-		  __print_symbolic(__entry->pm_qos_class,
-			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" }),
-		  __entry->value, __entry->timeout_us)
-);
-
 DECLARE_EVENT_CLASS(pm_qos_update,
 
 	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_value),
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index d932fa42e8e4..67dab7f330e4 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -295,21 +295,6 @@ static void __pm_qos_update_request(struct pm_qos_request *req,
 			&req->node, PM_QOS_UPDATE_REQ, new_value);
 }
 
-/**
- * pm_qos_work_fn - the timeout handler of pm_qos_update_request_timeout
- * @work: work struct for the delayed work (timeout)
- *
- * This cancels the timeout request by falling back to the default at timeout.
- */
-static void pm_qos_work_fn(struct work_struct *work)
-{
-	struct pm_qos_request *req = container_of(to_delayed_work(work),
-						  struct pm_qos_request,
-						  work);
-
-	__pm_qos_update_request(req, PM_QOS_DEFAULT_VALUE);
-}
-
 /**
  * pm_qos_add_request - inserts new qos request into the list
  * @req: pointer to a preallocated handle
@@ -334,7 +319,6 @@ void pm_qos_add_request(struct pm_qos_request *req,
 		return;
 	}
 	req->pm_qos_class = pm_qos_class;
-	INIT_DELAYED_WORK(&req->work, pm_qos_work_fn);
 	trace_pm_qos_add_request(pm_qos_class, value);
 	pm_qos_update_target(pm_qos_array[pm_qos_class]->constraints,
 			     &req->node, PM_QOS_ADD_REQ, value);
@@ -362,40 +346,10 @@ void pm_qos_update_request(struct pm_qos_request *req,
 		return;
 	}
 
-	cancel_delayed_work_sync(&req->work);
 	__pm_qos_update_request(req, new_value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
-/**
- * pm_qos_update_request_timeout - modifies an existing qos request temporarily.
- * @req : handle to list element holding a pm_qos request to use
- * @new_value: defines the temporal qos request
- * @timeout_us: the effective duration of this qos request in usecs.
- *
- * After timeout_us, this qos request is cancelled automatically.
- */
-void pm_qos_update_request_timeout(struct pm_qos_request *req, s32 new_value,
-				   unsigned long timeout_us)
-{
-	if (!req)
-		return;
-	if (WARN(!pm_qos_request_active(req),
-		 "%s called for unknown object.", __func__))
-		return;
-
-	cancel_delayed_work_sync(&req->work);
-
-	trace_pm_qos_update_request_timeout(req->pm_qos_class,
-					    new_value, timeout_us);
-	if (new_value != req->node.prio)
-		pm_qos_update_target(
-			pm_qos_array[req->pm_qos_class]->constraints,
-			&req->node, PM_QOS_UPDATE_REQ, new_value);
-
-	schedule_delayed_work(&req->work, usecs_to_jiffies(timeout_us));
-}
-
 /**
  * pm_qos_remove_request - modifies an existing qos request
  * @req: handle to request list element
@@ -415,8 +369,6 @@ void pm_qos_remove_request(struct pm_qos_request *req)
 		return;
 	}
 
-	cancel_delayed_work_sync(&req->work);
-
 	trace_pm_qos_remove_request(req->pm_qos_class, PM_QOS_DEFAULT_VALUE);
 	pm_qos_update_target(pm_qos_array[req->pm_qos_class]->constraints,
 			     &req->node, PM_QOS_REMOVE_REQ,
-- 
2.16.4





