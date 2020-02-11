Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B55159D64
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgBKXiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62065 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgBKXiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:54 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 2726e77bf0a98ba8; Wed, 12 Feb 2020 00:38:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 11/28] PM: QoS: Simplify definitions of CPU latency QoS trace events
Date:   Wed, 12 Feb 2020 00:06:17 +0100
Message-ID: <2473634.d0feZ6BIAp@kreacher>
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

Modify the definitions of the CPU latency QoS trace events to take
one argument (since PM_QOS_CPU_DMA_LATENCY is always passed as the
pm_qos_class argument to them) and update the documentation of them
accordingly (while at it, make it explicitly mention CPU latency QoS
and relocate it after the device PM QoS trace events documentation).

The names and output format of the trace events do not change to
preserve user space compatibility.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/trace/events-power.rst | 19 ++++++++++---------
 include/trace/events/power.h         | 35 +++++++++++++++++------------------
 kernel/power/qos.c                   | 16 ++++++++--------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
index eec7453a168e..f45bf11fa88d 100644
--- a/Documentation/trace/events-power.rst
+++ b/Documentation/trace/events-power.rst
@@ -73,14 +73,6 @@ The second parameter is the power domain target state.
 ================
 The PM QoS events are used for QoS add/update/remove request and for
 target/flags update.
-::
-
-  pm_qos_add_request                 "pm_qos_class=%s value=%d"
-  pm_qos_update_request              "pm_qos_class=%s value=%d"
-  pm_qos_remove_request              "pm_qos_class=%s value=%d"
-
-The first parameter gives the QoS class name (e.g. "CPU_DMA_LATENCY").
-The second parameter is value to be added/updated/removed.
 ::
 
   pm_qos_update_target               "action=%s prev_value=%d curr_value=%d"
@@ -90,7 +82,7 @@ The first parameter gives the QoS action name (e.g. "ADD_REQ").
 The second parameter is the previous QoS value.
 The third parameter is the current QoS value to update.
 
-And, there are also events used for device PM QoS add/update/remove request.
+There are also events used for device PM QoS add/update/remove request.
 ::
 
   dev_pm_qos_add_request             "device=%s type=%s new_value=%d"
@@ -101,3 +93,12 @@ The first parameter gives the device name which tries to add/update/remove
 QoS requests.
 The second parameter gives the request type (e.g. "DEV_PM_QOS_RESUME_LATENCY").
 The third parameter is value to be added/updated/removed.
+
+And, there are events used for CPU latency QoS add/update/remove request.
+::
+
+  pm_qos_add_request        "value=%d"
+  pm_qos_update_request     "value=%d"
+  pm_qos_remove_request     "value=%d"
+
+The parameter is the value to be added/updated/removed.
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index ecf39daabf16..af5018aa9517 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -359,51 +359,50 @@ DEFINE_EVENT(power_domain, power_domain_target,
 );
 
 /*
- * The pm qos events are used for pm qos update
+ * CPU latency QoS events used for global CPU latency QoS list updates
  */
-DECLARE_EVENT_CLASS(pm_qos_request,
+DECLARE_EVENT_CLASS(cpu_latency_qos_request,
 
-	TP_PROTO(int pm_qos_class, s32 value),
+	TP_PROTO(s32 value),
 
-	TP_ARGS(pm_qos_class, value),
+	TP_ARGS(value),
 
 	TP_STRUCT__entry(
-		__field( int,                    pm_qos_class   )
 		__field( s32,                    value          )
 	),
 
 	TP_fast_assign(
-		__entry->pm_qos_class = pm_qos_class;
 		__entry->value = value;
 	),
 
-	TP_printk("pm_qos_class=%s value=%d",
-		  __print_symbolic(__entry->pm_qos_class,
-			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" }),
+	TP_printk("CPU_DMA_LATENCY value=%d",
 		  __entry->value)
 );
 
-DEFINE_EVENT(pm_qos_request, pm_qos_add_request,
+DEFINE_EVENT(cpu_latency_qos_request, pm_qos_add_request,
 
-	TP_PROTO(int pm_qos_class, s32 value),
+	TP_PROTO(s32 value),
 
-	TP_ARGS(pm_qos_class, value)
+	TP_ARGS(value)
 );
 
-DEFINE_EVENT(pm_qos_request, pm_qos_update_request,
+DEFINE_EVENT(cpu_latency_qos_request, pm_qos_update_request,
 
-	TP_PROTO(int pm_qos_class, s32 value),
+	TP_PROTO(s32 value),
 
-	TP_ARGS(pm_qos_class, value)
+	TP_ARGS(value)
 );
 
-DEFINE_EVENT(pm_qos_request, pm_qos_remove_request,
+DEFINE_EVENT(cpu_latency_qos_request, pm_qos_remove_request,
 
-	TP_PROTO(int pm_qos_class, s32 value),
+	TP_PROTO(s32 value),
 
-	TP_ARGS(pm_qos_class, value)
+	TP_ARGS(value)
 );
 
+/*
+ * General PM QoS events used for updates of PM QoS request lists
+ */
 DECLARE_EVENT_CLASS(pm_qos_update,
 
 	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_value),
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index a6bf53e9db17..afac7010e0f2 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -247,8 +247,8 @@ int pm_qos_request_active(struct pm_qos_request *req)
 }
 EXPORT_SYMBOL_GPL(pm_qos_request_active);
 
-static void cpu_latency_qos_update(struct pm_qos_request *req,
-				   enum pm_qos_req_action action, s32 value)
+static void cpu_latency_qos_apply(struct pm_qos_request *req,
+				  enum pm_qos_req_action action, s32 value)
 {
 	int ret = pm_qos_update_target(req->qos, &req->node, action, value);
 	if (ret > 0)
@@ -278,10 +278,10 @@ void pm_qos_add_request(struct pm_qos_request *req,
 		return;
 	}
 
-	trace_pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY, value);
+	trace_pm_qos_add_request(value);
 
 	req->qos = &cpu_latency_constraints;
-	cpu_latency_qos_update(req, PM_QOS_ADD_REQ, value);
+	cpu_latency_qos_apply(req, PM_QOS_ADD_REQ, value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_request);
 
@@ -305,12 +305,12 @@ void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
 		return;
 	}
 
-	trace_pm_qos_update_request(PM_QOS_CPU_DMA_LATENCY, new_value);
+	trace_pm_qos_update_request(new_value);
 
 	if (new_value == req->node.prio)
 		return;
 
-	cpu_latency_qos_update(req, PM_QOS_UPDATE_REQ, new_value);
+	cpu_latency_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
@@ -333,9 +333,9 @@ void pm_qos_remove_request(struct pm_qos_request *req)
 		return;
 	}
 
-	trace_pm_qos_remove_request(PM_QOS_CPU_DMA_LATENCY, PM_QOS_DEFAULT_VALUE);
+	trace_pm_qos_remove_request(PM_QOS_DEFAULT_VALUE);
 
-	cpu_latency_qos_update(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 	memset(req, 0, sizeof(*req));
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_request);
-- 
2.16.4





