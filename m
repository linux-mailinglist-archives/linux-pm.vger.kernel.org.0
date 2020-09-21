Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D992723B7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIUMUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 08:20:44 -0400
Received: from foss.arm.com ([217.140.110.172]:42278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgIUMUn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Sep 2020 08:20:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77737D6E;
        Mon, 21 Sep 2020 05:20:42 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3840F3F73B;
        Mon, 21 Sep 2020 05:20:34 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com, orjan.eide@arm.com,
        robh@kernel.org, alyssa.rosenzweig@collabora.com,
        steven.price@arm.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH 1/5] thermal: devfreq_cooling: change tracing function and arguments
Date:   Mon, 21 Sep 2020 13:20:03 +0100
Message-Id: <20200921122007.29610-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921122007.29610-1-lukasz.luba@arm.com>
References: <20200921122007.29610-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Prepare for deleting the static and dynamic power calculation and clean
the trace function. These two fields are going to be removed in the next
changes.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for tracing code
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c |  3 +--
 include/trace/events/thermal.h    | 19 +++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index a12d29096229..7063ccb7b86d 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -278,8 +278,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		*power = dyn_power + static_power;
 	}
 
-	trace_thermal_power_devfreq_get_power(cdev, status, freq, dyn_power,
-					      static_power, *power);
+	trace_thermal_power_devfreq_get_power(cdev, status, freq, *power);
 
 	return 0;
 fail:
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 135e5421f003..8a5f04888abd 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -153,31 +153,30 @@ TRACE_EVENT(thermal_power_cpu_limit,
 TRACE_EVENT(thermal_power_devfreq_get_power,
 	TP_PROTO(struct thermal_cooling_device *cdev,
 		 struct devfreq_dev_status *status, unsigned long freq,
-		u32 dynamic_power, u32 static_power, u32 power),
+		u32 power),
 
-	TP_ARGS(cdev, status,  freq, dynamic_power, static_power, power),
+	TP_ARGS(cdev, status,  freq, power),
 
 	TP_STRUCT__entry(
 		__string(type,         cdev->type    )
 		__field(unsigned long, freq          )
-		__field(u32,           load          )
-		__field(u32,           dynamic_power )
-		__field(u32,           static_power  )
+		__field(u32,           busy_time)
+		__field(u32,           total_time)
 		__field(u32,           power)
 	),
 
 	TP_fast_assign(
 		__assign_str(type, cdev->type);
 		__entry->freq = freq;
-		__entry->load = (100 * status->busy_time) / status->total_time;
-		__entry->dynamic_power = dynamic_power;
-		__entry->static_power = static_power;
+		__entry->busy_time = status->busy_time;
+		__entry->total_time = status->total_time;
 		__entry->power = power;
 	),
 
-	TP_printk("type=%s freq=%lu load=%u dynamic_power=%u static_power=%u power=%u",
+	TP_printk("type=%s freq=%lu load=%u power=%u",
 		__get_str(type), __entry->freq,
-		__entry->load, __entry->dynamic_power, __entry->static_power,
+		__entry->total_time == 0 ? 0 :
+			(100 * __entry->busy_time) / __entry->total_time,
 		__entry->power)
 );
 
-- 
2.17.1

