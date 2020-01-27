Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B8A14A706
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 16:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgA0PRv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 10:17:51 -0500
Received: from foss.arm.com ([217.140.110.172]:45996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgA0PRv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jan 2020 10:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11C9831B;
        Mon, 27 Jan 2020 07:17:51 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA2683F67D;
        Mon, 27 Jan 2020 07:17:44 -0800 (PST)
From:   lukasz.luba@arm.com
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, lukasz.luba@arm.com
Subject: [PATCH 1/1] drivers: devfreq: add DELAYED_WORK to monitoring subsystem
Date:   Mon, 27 Jan 2020 15:17:31 +0000
Message-Id: <20200127151731.8640-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127151731.8640-1-lukasz.luba@arm.com>
References: <20200127151731.8640-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

This change aims to add different mechanism used in monitoring subsystem
which rely on DELAYED_WORK instead of DEFERRABLE_WORK. The DEFERRABLE_WORK
used TIMER_DEFERRABLE under the hood, which will not cause a CPU to come
out of idle and service the DEVFREQ monitoring queued work. This is
especially important in SMP systems, when some of the CPUs might be kept
in idle, while the other may have a big load.

The DELAYED_WORK is going to be triggered even on an idle CPU and will
serve the monitoring update request.

The difference could be observed in the trace output, when devfreq trace
option is enabled, i.e.
echo 1 > /sys/kernel/debug/tracing/events/devfreq/enable
sleep 5
echo 0 > /sys/kernel/debug/tracing/events/devfreq/enable
cat /sys/kernel/debug/tracing/trace

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/devfreq/Kconfig   | 19 +++++++++++++++++++
 drivers/devfreq/devfreq.c |  6 +++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 0b1df12e0f21..fba9cd55f434 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -30,6 +30,25 @@ menuconfig PM_DEVFREQ
 
 if PM_DEVFREQ
 
+config DEVFREQ_USE_DELAYED_WORK
+	bool "Use DELAYED_WORK in DEVFREQ monitoring subsystem"
+	help
+	  This changes the default DEVFREQ framework monitoring subsystem
+	  from using DEFERRABLE_WORK to DELAYED_WORK. The former uses
+	  TIMER_DEFERRABLE, which will work normally when the system is busy,
+	  but will not cause a CPU to come out of idle and serve the DEVFREQ
+	  monitoring requests. This is especially important in the SMP systems
+	  with many CPUs, when the load balance tries to keep some CPUs idle.
+	  The next service request could not be triggered when the CPU went
+	  idle in the meantime.
+
+	  The DELAYED_WORK is going to be triggered even on an idle CPU. This
+	  will allow to call the DEVFREQ driver in more reliable fashion and
+	  prevent i.e. from overflowing the device's counters.
+
+	  Enable this when you have SMP system and you do not see the DEVFREQ
+	  monitoring to be triggered in your trace output.
+
 comment "DEVFREQ Governors"
 
 config DEVFREQ_GOV_SIMPLE_ONDEMAND
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cceee8bc3c2f..319c63c4774c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -457,7 +457,11 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 	if (devfreq->governor->interrupt_driven)
 		return;
 
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+	if (IS_ENABLED(CONFIG_DEVFREQ_USE_DELAYED_WORK))
+		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
+	else
+		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
-- 
2.17.1

