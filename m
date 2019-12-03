Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A983610FAD9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 10:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLCJhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 04:37:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37918 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfLCJhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 04:37:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so2768406wrh.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 01:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n1V4m5uHfTZUZxbvB/zT+U3+jIt/r2ueCcg5F/IHP4U=;
        b=E65o8GbhaN6dhsWwqzOmls+WOicYbtpQe1WLFww2Jaa7JRztNoOiGZ1KrFWIh7zroa
         PD3m16AUfEZovja7lfC1k64JxzC1hmTdp7WHe7tGzNB9iXuyUR3Sv1Z0dH1S7tCMx30N
         cQDUdtZNMQuQKrytVyqyB9a8sWZ4wGV55Rsvb5vj4evXM/2omPE92xA2TQ6i6L/U8YT0
         z8QnLUuCWiyXCVpdhJS3s4LFc/YsSdeDrdNf4khoh2erPEN/qQJqXyvCEPDWgfAJePgW
         pFHmVbBmDN9BjHHOHVcntF6yAo27fTWTeDVByAWFYHnYaLg9mdx9jz8IfIvJ3YuOdDRu
         qP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n1V4m5uHfTZUZxbvB/zT+U3+jIt/r2ueCcg5F/IHP4U=;
        b=hAoiTxYUGh2ETEuJpv85GM7SoyWPD1lmQaP5IVFH50timNQ6szxrWmzvzr5wsZz73+
         QCK2L/dlvNZB6/7S0mbuj99iUn4tSWTzZ31Uxb3EhTxqHHb1tXgah1JVOTUbVFIeeGDz
         W4JAOma3OKfwfBLiw0SSeDaDu4UqpZZqryn+YB2OWVXsaZ9JTbE93K1C68JHKgTrNc+G
         tObsVLo3XwJWgBHJ0mhUKRrgd2RQIMh547UgZAbW856LSwLK1tgTvlKxjSi7VCnaXx+B
         dZEoteqwuSCbqThWUi9nbzWqiL0FhfT9WI6uwu6eyk3XM5+0pJLwtxzHPw2vhnLtSzd9
         m7Qg==
X-Gm-Message-State: APjAAAXjkGhB5tK4bLvw3vZYJLdjTkUulOovPffREvhj3xReY9mInfo0
        kCJ3I+HrGKASdMtUTfrEX9RXtA==
X-Google-Smtp-Source: APXvYqwZgnSicZdtM/tuYU44eF8nODj6JRqUZHZKZa0aD8MBSp2wduQjWdsjtvzB8xzUdW3uGc7BuQ==
X-Received: by 2002:adf:f411:: with SMTP id g17mr3958312wro.89.1575365834904;
        Tue, 03 Dec 2019 01:37:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8196:cbcc:fb2c:4975])
        by smtp.gmail.com with ESMTPSA id w13sm2935751wru.38.2019.12.03.01.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:37:14 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] thermal/drivers/cpu_cooling: Rename to cpufreq_cooling
Date:   Tue,  3 Dec 2019 10:37:04 +0100
Message-Id: <20191203093704.7037-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203093704.7037-1-daniel.lezcano@linaro.org>
References: <20191203093704.7037-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As we introduced the idle injection cooling device called
cpuidle_cooling, let's be consistent and rename the cpu_cooling to
cpufreq_cooling as this one mitigates with OPPs changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
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
index d2e92a0360f2..26e4be914765 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16194,7 +16194,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	Documentation/driver-api/thermal/cpu-idle-cooling.rst
-F:	drivers/thermal/cpu_cooling.c
+F:	drivers/thermal/cpufreq_cooling.c
 F:	drivers/thermal/cpuidle_cooling.c
 F:	include/linux/cpu_cooling.h
 
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9c8aa2d4bd28..5c98472ffd8b 100644
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
index 6b9865c786ba..3a3f9cf94b6d 100644
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
@@ -694,7 +694,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 	u32 capacitance = 0;
 
 	if (!np) {
-		pr_err("cpu_cooling: OF node not available for cpu%d\n",
+		pr_err("cpufreq_cooling: OF node not available for cpu%d\n",
 		       policy->cpu);
 		return NULL;
 	}
@@ -705,7 +705,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 
 		cdev = __cpufreq_cooling_register(np, policy, capacitance);
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

