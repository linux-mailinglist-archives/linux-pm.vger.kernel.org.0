Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD292D9A32
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 15:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407382AbgLNOlO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 09:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408241AbgLNOlH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 09:41:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1AEC0613D6
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 06:40:24 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:40:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKZLfReAZzafQql5jvQhKca2PUuKCJevE1Jw62dSEqU=;
        b=HroVFcthA3aCuCczSAZW4po6Bma15HOHKHioNkpLySGNTktK97/+A6TF9vrDQXmvvDdOJ+
        ZDIRo/sFkIrItl0JntwxF37/7oT+sVOIo2JyhXvvryfCGSORDdSemTs67rO2/3G8QtqJOL
        XhNwm8JBgmkpmiCIRSSSuA5YwzekL70NVGZXcEfpqdYxF8a0v7TtAv7c7HyA7Onijd6tSC
        p3XxhvvAbby/3o3NagC4Qw3inuQviAF/L3YII8qhom2rpFAvwCIQWIyrI+1dGjQtVDi57V
        /HCTcGYKKl4Dl04Q/pjqu6YZ8WZW8poSUR6lT05avJZfpMWy7jLG2+Ps+k9VDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKZLfReAZzafQql5jvQhKca2PUuKCJevE1Jw62dSEqU=;
        b=MsyYrE2yVeGyJ2Kn0pCte3PxY9tifGhFUVIv7I6urGQKMggfv+yTP+uOoRlpL+5N6D2ygX
        uZ3F6i9sD3TnpeCg==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: devfreq_cooling: change tracing
 function and arguments
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201210143014.24685-2-lukasz.luba@arm.com>
References: <20201210143014.24685-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160795682031.3364.16573289695843049882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     b8643a529930802778b04a4fe3f5cd53d9d6057c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b8643a529930802778b04a4fe3f5cd53d9d6057c
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 10 Dec 2020 14:30:10 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Dec 2020 14:10:44 +01:00

thermal: devfreq_cooling: change tracing function and arguments

Prepare for deleting the static and dynamic power calculation and clean
the trace function. These two fields are going to be removed in the next
changes.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for tracing code
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201210143014.24685-2-lukasz.luba@arm.com
---
 drivers/thermal/devfreq_cooling.c |  3 +--
 include/trace/events/thermal.h    | 19 +++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index dfab49a..659c014 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -277,8 +277,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		*power = dyn_power + static_power;
 	}
 
-	trace_thermal_power_devfreq_get_power(cdev, status, freq, dyn_power,
-					      static_power, *power);
+	trace_thermal_power_devfreq_get_power(cdev, status, freq, *power);
 
 	return 0;
 fail:
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 135e542..8a5f048 100644
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
 
