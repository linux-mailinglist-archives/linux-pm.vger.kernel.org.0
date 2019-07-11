Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35936658B0
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfGKOVb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 10:21:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35529 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfGKOVb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 10:21:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so3035161pgl.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Awpujz9r/neB3EOz35gTs3qfspG2l2LEyx+qOFwQWtc=;
        b=itMw7Ebpfg3uMHx+Cp6KsA/Jzruj3ROpTQpU9KFExu0AV2HoMbkQ4B5z08DRqTZ4LZ
         kd2MMKFWuwP4QkUSsyb7fRuNAYfFPwlgP9KidEUMzEO8/HNsW+pUHEiZnagno2r1/1uW
         Bjo8poHGBtyy3cYaA0ViTzf9RPiXyGmVyMOfuwdibIqkoHOjOdcL4c1LYOAKWFYuSXjH
         GdkkY22AYUXcV9hRqzXd4wVDoHHdaYxxndjmYX1x1OiSq+BN/rZYViGkXGyLq6XwRR4O
         HsgqkdvgeflDjPyOPM07rlJTP8EkWvCrhlJfx3i8B2kKgtrQK4muI0eWSOdKkCHnawZj
         a5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Awpujz9r/neB3EOz35gTs3qfspG2l2LEyx+qOFwQWtc=;
        b=keCYOTAtmolpZpKji1/tsnc/6+GgFp53L+IxZR0r3/qWpuAU9MrOhVP7+aQwRol4b/
         +2e+JY2O0TpnyI2dHKzI5b27XW2lKYAii24ei4EgMDlkgALAbuowUZNmUKQQhEf/faZC
         /t22VIVkL56cIpuYyCzdJqhohnOM7JbnTX4GJrT2W+PCjIim0olYvUHB0bhxyJwy2xLN
         C8vRHPmQTuxvht5mwSRwPqR7GKg7EJ2O15wuGTTIiGiLyXxGCu+pu7xsk9rUkQzkQPVa
         MSAJ398DB1iPNLXnqpscCQ53EsWN+8qEMPhYMX5Cgg4zAhLuwDUGm9aFUP19DOtb2cZk
         sP+w==
X-Gm-Message-State: APjAAAXXSYK7s+a22j1BeSUy3rnZe9fozyhmlIDXId7xXC1qJUyIoMoz
        Hr+lstJhoZkwCFTrUJzWhcwR2Q==
X-Google-Smtp-Source: APXvYqwXCzJ0oJtitLVGfwHJo2XK58B5/l/357wPbMNsJfi7bE/SM5jnO449QeEKT1JYb29a4ctIEA==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr4769342pgm.413.1562854889992;
        Thu, 11 Jul 2019 07:21:29 -0700 (PDT)
Received: from localhost ([49.248.58.252])
        by smtp.gmail.com with ESMTPSA id q4sm5408674pjq.27.2019.07.11.07.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 07:21:29 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: QoS: Get rid of unused flags
Date:   Thu, 11 Jul 2019 19:51:25 +0530
Message-Id: <e9e7bc3be3b51e68ae1a0f934c3724bd86f5f9af.1562854650.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1562854650.git.amit.kucheria@linaro.org>
References: <cover.1562854650.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The network_latency and network_throughput flags for PM-QoS have not
found much use in drivers or in userspace since they were introduced.

Commit 4a733ef1bea7 ("mac80211: remove PM-QoS listener") removed the
only user PM_QOS_NETWORK_LATENCY in the kernel a while ago and there
don't seem to be any userspace tools using the character device files
either.

PM_QOS_MEMORY_BANDWIDTH was never even added to the trace events.

Remove all the flags except cpu_dma_latency.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Changes from v1:
- Rebased on linux-next to deal with .rst conversion of docs

I've looked around for use of /dev/network_throughput and
/dev/network_bandwidth) and not found any userspace programs that seem to
use this currently. So this shouldn't be breaking our ABI contract with
userspace.


 Documentation/power/pm_qos_interface.rst |  5 +--
 include/linux/pm_qos.h                   |  6 ---
 include/trace/events/power.h             |  8 +---
 kernel/power/qos.c                       | 48 ------------------------
 4 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 945fc6d760c9..a00d607107ec 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -7,8 +7,7 @@ performance expectations by drivers, subsystems and user space applications on
 one of the parameters.
 
 Two different PM QoS frameworks are available:
-1. PM QoS classes for cpu_dma_latency, network_latency, network_throughput,
-memory_bandwidth.
+1. PM QoS classes for cpu_dma_latency
 2. the per-device PM QoS framework provides the API to manage the per-device latency
 constraints and PM QoS flags.
 
@@ -79,7 +78,7 @@ cleanup of a process, the interface requires the process to register its
 parameter requests in the following way:
 
 To register the default pm_qos target for the specific parameter, the process
-must open one of /dev/[cpu_dma_latency, network_latency, network_throughput]
+must open /dev/cpu_dma_latency
 
 As long as the device node is held open that process has a registered
 request on the parameter.
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6ea1ae373d77..2a3c237b1910 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -13,9 +13,6 @@
 enum {
 	PM_QOS_RESERVED = 0,
 	PM_QOS_CPU_DMA_LATENCY,
-	PM_QOS_NETWORK_LATENCY,
-	PM_QOS_NETWORK_THROUGHPUT,
-	PM_QOS_MEMORY_BANDWIDTH,
 
 	/* insert new class ID */
 	PM_QOS_NUM_CLASSES,
@@ -33,9 +30,6 @@ enum pm_qos_flags_status {
 #define PM_QOS_LATENCY_ANY_NS	((s64)PM_QOS_LATENCY_ANY * NSEC_PER_USEC)
 
 #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
-#define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
-#define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
-#define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE	0
 #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	PM_QOS_LATENCY_ANY
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index f7aece721aed..7457e238e1b7 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -379,9 +379,7 @@ DECLARE_EVENT_CLASS(pm_qos_request,
 
 	TP_printk("pm_qos_class=%s value=%d",
 		  __print_symbolic(__entry->pm_qos_class,
-			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" },
-			{ PM_QOS_NETWORK_LATENCY,	"NETWORK_LATENCY" },
-			{ PM_QOS_NETWORK_THROUGHPUT,	"NETWORK_THROUGHPUT" }),
+			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" }),
 		  __entry->value)
 );
 
@@ -426,9 +424,7 @@ TRACE_EVENT(pm_qos_update_request_timeout,
 
 	TP_printk("pm_qos_class=%s value=%d, timeout_us=%ld",
 		  __print_symbolic(__entry->pm_qos_class,
-			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" },
-			{ PM_QOS_NETWORK_LATENCY,	"NETWORK_LATENCY" },
-			{ PM_QOS_NETWORK_THROUGHPUT,	"NETWORK_THROUGHPUT" }),
+			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" }),
 		  __entry->value, __entry->timeout_us)
 );
 
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 33e3febaba53..9568a2fe7c11 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -78,57 +78,9 @@ static struct pm_qos_object cpu_dma_pm_qos = {
 	.name = "cpu_dma_latency",
 };
 
-static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
-static struct pm_qos_constraints network_lat_constraints = {
-	.list = PLIST_HEAD_INIT(network_lat_constraints.list),
-	.target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
-	.default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
-	.no_constraint_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
-	.type = PM_QOS_MIN,
-	.notifiers = &network_lat_notifier,
-};
-static struct pm_qos_object network_lat_pm_qos = {
-	.constraints = &network_lat_constraints,
-	.name = "network_latency",
-};
-
-
-static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
-static struct pm_qos_constraints network_tput_constraints = {
-	.list = PLIST_HEAD_INIT(network_tput_constraints.list),
-	.target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
-	.default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
-	.no_constraint_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
-	.type = PM_QOS_MAX,
-	.notifiers = &network_throughput_notifier,
-};
-static struct pm_qos_object network_throughput_pm_qos = {
-	.constraints = &network_tput_constraints,
-	.name = "network_throughput",
-};
-
-
-static BLOCKING_NOTIFIER_HEAD(memory_bandwidth_notifier);
-static struct pm_qos_constraints memory_bw_constraints = {
-	.list = PLIST_HEAD_INIT(memory_bw_constraints.list),
-	.target_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
-	.default_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
-	.no_constraint_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
-	.type = PM_QOS_SUM,
-	.notifiers = &memory_bandwidth_notifier,
-};
-static struct pm_qos_object memory_bandwidth_pm_qos = {
-	.constraints = &memory_bw_constraints,
-	.name = "memory_bandwidth",
-};
-
-
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
-	&network_lat_pm_qos,
-	&network_throughput_pm_qos,
-	&memory_bandwidth_pm_qos,
 };
 
 static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
-- 
2.17.1

