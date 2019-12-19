Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B51270F2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 23:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfLSWxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 17:53:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51664 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLSWx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 17:53:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so7082516wmd.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBcrCTViVT+buUkazP6ndZ+R56LFcmai8/NG1/x431U=;
        b=Hms1C9NofkMz6T1NTyhmVkYBl4ZPR7sI0C/LuYX9azSAlOO86De1fu3PgyXmOMRvte
         itWwqN+xHdp5diEsP7/PESs26jSYQOclJLteh1XsXEP02pJfChBbLTCtB+PVjphI+7Hz
         mgEqJ5xkwnF9YNciYBf/kcbt+ID0414YTZ4EumCnlW9DjglCbhx0IzKevZi3lV2oHLwW
         25zbP/9sARVfASSZh50LdwUocnkQwtpVuVjO+WdneaBkIGwVueeLx+CUvneZ3mPJFPys
         jlJKsHkEJsegERjNFfX2gS3m4w1HbdvOykn1orsUOLbq5FH3il7mi7tcBDiJDCFYpYk5
         zb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBcrCTViVT+buUkazP6ndZ+R56LFcmai8/NG1/x431U=;
        b=Dh3psoo4M0GIQfB+xg/lCu5JcyZnQntvYF600nmWsmPz749j4UzG8VicStKdTDkzGv
         yRkUSUCk+ITar9R06mY9M+41ilGPo0BwjZVS+ZpIH5+Y9i7s4Uz6faZodAv+qjpswGc3
         5Wtr5UBBOl0MYkTsnIDWXn/Y61GJV8GelFFELxMtylOgONzuhZ8ZerY6i0yCzfjZL4a9
         RQ4Zwu0yD/2369JrImLx7wEG/QQ4jG090fVApwky4oOCG93MDPB6usBwnTVOR3VtWU62
         ocmXGDb8t582QCC1DxiKlbfB3zhRYvHt9EARvNgqEo2RYF2dKiQsW6fCotkhKoy1XG0H
         wl+A==
X-Gm-Message-State: APjAAAVafmLGln3R9RfDmdDeoRQmz5hYArJechx/VqaluFLnVY3S7P4s
        dk3XxJBxZJ6ZP+7o2+oNSpDO8zb+ELM=
X-Google-Smtp-Source: APXvYqyOXrMhZ5yilpBSvw1Ozp9navOLrrJW5WY9vQSVe+UwMwp5zrfg864l7Psh+qZcWwti9PTcLA==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr12575389wmi.137.1576796006039;
        Thu, 19 Dec 2019 14:53:26 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:58d:4e9b:2833:86c3])
        by smtp.gmail.com with ESMTPSA id p15sm7581930wma.40.2019.12.19.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:53:25 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org, martin.kepplinger@puri.sm
Subject: [PATCH V6 3/3] thermal/drivers/cpu_cooling: Rename to cpufreq_cooling
Date:   Thu, 19 Dec 2019 23:53:17 +0100
Message-Id: <20191219225317.17158-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219225317.17158-1-daniel.lezcano@linaro.org>
References: <20191219225317.17158-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As we introduced the idle injection cooling device called
cpuidle_cooling, let's be consistent and rename the cpu_cooling to
cpufreq_cooling as this one mitigates with OPPs changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
  V4:
    - Added Acked-by and Reviewed-by
  V3:
    - Fix missing name conversion (Viresh Kumar)
---
 Documentation/driver-api/thermal/exynos_thermal.rst  | 2 +-
 MAINTAINERS                                          | 2 +-
 drivers/thermal/Makefile                             | 2 +-
 drivers/thermal/clock_cooling.c                      | 2 +-
 drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} | 6 +++---
 include/linux/clock_cooling.h                        | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} (99%)

diff --git a/Documentation/driver-api/thermal/exynos_thermal.rst b/Documentation/driver-api/thermal/exynos_thermal.rst
index 5bd556566c70..d4e4a5b75805 100644
--- a/Documentation/driver-api/thermal/exynos_thermal.rst
+++ b/Documentation/driver-api/thermal/exynos_thermal.rst
@@ -67,7 +67,7 @@ TMU driver description:
 The exynos thermal driver is structured as::
 
 					Kernel Core thermal framework
-				(thermal_core.c, step_wise.c, cpu_cooling.c)
+				(thermal_core.c, step_wise.c, cpufreq_cooling.c)
 								^
 								|
 								|
diff --git a/MAINTAINERS b/MAINTAINERS
index d92e9eb14131..0d658a628296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16337,7 +16337,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	Documentation/driver-api/thermal/cpu-idle-cooling.rst
-F:	drivers/thermal/cpu_cooling.c
+F:	drivers/thermal/cpufreq_cooling.c
 F:	drivers/thermal/cpuidle_cooling.c
 F:	include/linux/cpu_cooling.h
 
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 6929e6fad1ac..d502a597a717 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -19,7 +19,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
 thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
 
 # cpufreq cooling
-thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
+thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
 thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 
 # clock cooling
diff --git a/drivers/thermal/clock_cooling.c b/drivers/thermal/clock_cooling.c
index 3ad3256c48fd..7cb3ae4b44ee 100644
--- a/drivers/thermal/clock_cooling.c
+++ b/drivers/thermal/clock_cooling.c
@@ -7,7 +7,7 @@
  *  Copyright (C) 2013	Texas Instruments Inc.
  *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
  *
- *  Highly based on cpu_cooling.c.
+ *  Highly based on cpufreq_cooling.c.
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
  *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  */
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpufreq_cooling.c
similarity index 99%
rename from drivers/thermal/cpu_cooling.c
rename to drivers/thermal/cpufreq_cooling.c
index 52569b27b426..1dcba6bcaf7b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  linux/drivers/thermal/cpu_cooling.c
+ *  linux/drivers/thermal/cpufreq_cooling.c
  *
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
  *
@@ -620,7 +620,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 	struct thermal_cooling_device *cdev = NULL;
 
 	if (!np) {
-		pr_err("cpu_cooling: OF node not available for cpu%d\n",
+		pr_err("cpufreq_cooling: OF node not available for cpu%d\n",
 		       policy->cpu);
 		return NULL;
 	}
@@ -630,7 +630,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 
 		cdev = __cpufreq_cooling_register(np, policy, em);
 		if (IS_ERR(cdev)) {
-			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
+			pr_err("cpufreq_cooling: cpu%d failed to register as cooling device: %ld\n",
 			       policy->cpu, PTR_ERR(cdev));
 			cdev = NULL;
 		}
diff --git a/include/linux/clock_cooling.h b/include/linux/clock_cooling.h
index b5cebf766e02..4b0a69863656 100644
--- a/include/linux/clock_cooling.h
+++ b/include/linux/clock_cooling.h
@@ -7,7 +7,7 @@
  *  Copyright (C) 2013	Texas Instruments Inc.
  *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
  *
- *  Highly based on cpu_cooling.c.
+ *  Highly based on cpufreq_cooling.c.
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
  *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  */
-- 
2.17.1

