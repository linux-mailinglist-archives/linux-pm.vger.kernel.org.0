Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5184C644FC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGJKMh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 06:12:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32958 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJKMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 06:12:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so1001906plo.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2019 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4JmN6a1LQv0TLk4i/L0juA6RvBRvqobL1yyZSf2GWo=;
        b=n9aiL3x380HdNMTe2BIADkUSbXYwzZxn2wN++a9SJ2a+0L4RJMVDO9ohdkaNS/dJpS
         aE3BEbH9R+1e0yD4pxcjT8sPpdQUBdL0U6y93gUB5/Ejuw1Aap45G0forliU6oaI9blO
         qLDSyj/xqLXYGNJA6F81reeKbpWt9nuJ3csljeG33xtg8DuSNpnaL0Ag7wAO9gawLRJw
         lrMh0pRErbpIy7OkOmmLxZyMK3L4MhYbL+DeGvwYwKRdnWQ831HQrl5Cr6oODyGzPeIs
         nOHQnsSOTFGMefzJvzMQclqi+JO2obNiiNGt4NpsfAhM79DYCrSnZgK1HTwwMNpeznCD
         Wokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4JmN6a1LQv0TLk4i/L0juA6RvBRvqobL1yyZSf2GWo=;
        b=nKE//A1P4vLX+KDT7m0hfIHRGc5tsu0pneeEIPFCXLZwwKhGcD8M/d/FRaSWBsU1fT
         bSt/e5Sg8ft0Je4SDw8ShCDhsugEV/pYk5+upypW91Yv0ED0qQKsMCOWX4NSaSp1nSTL
         EiMJPC3UA+a49MFhjn3AyNfBM+uOO+czkdTaOT/t7GdWUpnQ7F2TZBNHjK/4OdTtZH0i
         DFROLGUe6B9VIDpB/uKuBGhB062dTkjydwXMGp9BxuvHBGoZagEgYPPxG8ArOeCCbnnH
         u9WqN63OMXPaBDkY0xO1c6juqyg8uk5pZ3sY6iv10wjeO7kkD3U/lgBsD/7oEcJsW1Hr
         FnVA==
X-Gm-Message-State: APjAAAXdC5+cx/iedzaRbXy/ZvWaaqynVEvfgzMzDTmysEMbV1UYTput
        Ajofek23MxVHfgXjTSrYLr8MBQ==
X-Google-Smtp-Source: APXvYqxl122NYx1PseDRpou4Ih+UShpYE7YyaojpNneVJYoE7B3Kwvk4ebV0XtMTOHeShLrsSHWTQQ==
X-Received: by 2002:a17:902:124:: with SMTP id 33mr38846428plb.145.1562753556068;
        Wed, 10 Jul 2019 03:12:36 -0700 (PDT)
Received: from localhost ([49.248.170.152])
        by smtp.gmail.com with ESMTPSA id a3sm4535626pje.3.2019.07.10.03.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 03:12:35 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org
Subject: [RFC PATCH] PM: QoS: Get rid of unused flags
Date:   Wed, 10 Jul 2019 15:42:31 +0530
Message-Id: <ed318d093fde671dc0bae0aeb8cf07e56a72cf27.1562751312.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1562751312.git.amit.kucheria@linaro.org>
References: <cover.1562751312.git.amit.kucheria@linaro.org>
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
I've looked around for use of /dev/network_throughput and
/dev/network_bandwidth) and not found any userspace programs that seem to
use this currently. So this shouldn't be breaking our ABI contract with
userspace.

 Documentation/power/pm_qos_interface.txt |  5 +--
 include/linux/pm_qos.h                   |  6 ---
 include/trace/events/power.h             |  8 +---
 kernel/power/qos.c                       | 48 ------------------------
 4 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index 19c5f7b1a7bab..ac53ca4ae24e1 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -5,8 +5,7 @@ performance expectations by drivers, subsystems and user space applications on
 one of the parameters.
 
 Two different PM QoS frameworks are available:
-1. PM QoS classes for cpu_dma_latency, network_latency, network_throughput,
-memory_bandwidth.
+1. PM QoS classes for cpu_dma_latency
 2. the per-device PM QoS framework provides the API to manage the per-device latency
 constraints and PM QoS flags.
 
@@ -74,7 +73,7 @@ cleanup of a process, the interface requires the process to register its
 parameter requests in the following way:
 
 To register the default pm_qos target for the specific parameter, the process
-must open one of /dev/[cpu_dma_latency, network_latency, network_throughput]
+must open /dev/cpu_dma_latency
 
 As long as the device node is held open that process has a registered
 request on the parameter.
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6ea1ae373d77c..2a3c237b1910d 100644
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
index f7aece721aed7..7457e238e1b74 100644
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
index 33e3febaba53f..9568a2fe7c116 100644
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

