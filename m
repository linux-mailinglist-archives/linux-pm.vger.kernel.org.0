Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4786BBFB32
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 00:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfIZWE4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 18:04:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42030 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfIZWE4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 18:04:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so200398pls.9
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FyI5Ob9ZI7/mzKeLeISYFxnQEPANV+hWHjQ4mCtD6v0=;
        b=EGMA1InpKl0N7i7io7mlYWg64F5h4NsR4AZywCxMiEWXPB2wDUxjwzE5bGdAUVotqJ
         vj4aWqmmPJxfXupZCcWK0zhSnC2JTWtItUJZZZpHux8pyEwBkata5jS/WHH7oEHCsq5K
         hvbQwKJIHPIHEbUrdIA8o56johVCCqA+m9pZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FyI5Ob9ZI7/mzKeLeISYFxnQEPANV+hWHjQ4mCtD6v0=;
        b=Nh/prT3vAzbP0epSSLFwtoK+jr31DXzMF9xir3bUoU/9hVicClHmplMXyY4OUWs0+i
         4QwdtyuV/CNxbBg2OrI1HjcZ/rkvCyslxHvEJ1nGoa1iDa1gmdXVFBI+bOmKUiZtaGWr
         oJIyhTEz8OaOxF5B/5hxB7KPe8Z2qurVQKnUwyReGsV+fjLA3b01ODsNqsQbSRIzTNXM
         jrOkueS+YKwot1SKLo8C53bcaboQvyDKuUWamLLFSel38fOQVww5uhMlSHhIXYAojQa4
         y+QnHQm8dgB9keOTr2AicuZGv8eMYF/3Rnb3/xyIYsjUlRjjdQnE0q+CMZrBJmujzERN
         x+Vw==
X-Gm-Message-State: APjAAAXG0W7kpKyYjM6QFphq5TbxiqKIBiX0KhQkU3/t/ikStxBVhS8t
        6X/L1+i35iaszoPTgI+wPACKUA==
X-Google-Smtp-Source: APXvYqzUAHtK2cPMT4htbHMczPwuIQ44aVHsSlSiREiRUU2arpNMe6WceNA3tLjbmoinVkIv4AHtfA==
X-Received: by 2002:a17:902:5a01:: with SMTP id q1mr852910pli.335.1569535495418;
        Thu, 26 Sep 2019 15:04:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n3sm248418pff.102.2019.09.26.15.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 15:04:54 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] PM / Domains: Add tracepoints
Date:   Thu, 26 Sep 2019 15:04:38 -0700
Message-Id: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Define genpd_power_on/off and genpd_set_performance_state
tracepoints and use them.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/base/power/domain.c  | 27 +++++++++++++++++---
 include/trace/events/power.h | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cc85e87eaf05..aee988c112e5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -21,6 +21,7 @@
 #include <linux/suspend.h>
 #include <linux/export.h>
 #include <linux/cpu.h>
+#include <trace/events/power.h>
 
 #include "power.h"
 
@@ -329,6 +330,9 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 		goto err;
 
 	genpd->performance_state = state;
+
+	trace_genpd_set_performance_state(genpd);
+
 	return 0;
 
 err:
@@ -418,14 +422,21 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_on)
 		return 0;
 
-	if (!timed)
-		return genpd->power_on(genpd);
+	if (!timed) {
+		ret = genpd->power_on(genpd);
+		if (!ret)
+			trace_genpd_power_on(genpd);
+
+		return ret;
+	}
 
 	time_start = ktime_get();
 	ret = genpd->power_on(genpd);
 	if (ret)
 		return ret;
 
+	trace_genpd_power_on(genpd);
+
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
 		return ret;
@@ -448,14 +459,22 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_off)
 		return 0;
 
-	if (!timed)
-		return genpd->power_off(genpd);
+	if (!timed) {
+		ret = genpd->power_off(genpd);
+		if (!ret)
+			trace_genpd_power_off(genpd);
+
+		return ret;
+	}
 
 	time_start = ktime_get();
 	ret = genpd->power_off(genpd);
 	if (ret)
 		return ret;
 
+	if (!ret)
+		trace_genpd_power_off(genpd);
+
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
 		return 0;
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 7457e238e1b7..de56cd1e8d0d 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -7,6 +7,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/ktime.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/tracepoint.h>
 #include <linux/trace_events.h>
@@ -525,6 +526,54 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS
+DECLARE_EVENT_CLASS(genpd_power_on_off,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd),
+
+	TP_STRUCT__entry(
+		__string(name, genpd->name)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, genpd->name);
+	),
+
+	TP_printk("name=%s", __get_str(name))
+);
+
+DEFINE_EVENT(genpd_power_on_off, genpd_power_on,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd)
+);
+
+DEFINE_EVENT(genpd_power_on_off, genpd_power_off,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd)
+);
+
+TRACE_EVENT(genpd_set_performance_state,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd),
+
+	TP_STRUCT__entry(
+		__string(name, genpd->name)
+		__field(unsigned int, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, genpd->name);
+		__entry->state = genpd->performance_state;
+	),
+
+	TP_printk("name=%s state=%u", __get_str(name), __entry->state)
+);
+#endif /* CONFIG_PM_GENERIC_DOMAINS */
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.23.0.444.g18eeb5a265-goog

