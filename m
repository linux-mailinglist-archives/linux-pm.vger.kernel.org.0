Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C386112EAC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 16:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfLDPjx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 10:39:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33912 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfLDPjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 10:39:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id f4so5122437wmj.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1niKCMXXnmGnzZRABJx3hRarOaikbE/OwsjmxwSrkNE=;
        b=c0n/xZi+mCTzNlQRlLCYjL7pSvvKCB2mFzQHqcD21Rl2yMihwatj4fu8MSQQephKYM
         a53jHtNdVOTYqPaU2OTmrxTns5ls+7huxMeLT3DF6hgUepdwGGF+jS0dLiaXZ+apjioK
         O6sCTN1jtZFL4PnYdDcsMiYukIKh36htiy9e2m5GzxW+GzrlyV3Fe+okrXsjG4vwpshO
         He65muV6t5s792gfmkrfXiBfyEtlVjzecqV/9lrd6qTEiP95sdeLmpHFh6tNENFOrVqu
         Fpz5JPkPK+doI9Ejk9P3ITy0Gz19Drwy5yrhavCIeo547Rnlrb9P8xDm0qEkJ/ut8xBm
         NG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1niKCMXXnmGnzZRABJx3hRarOaikbE/OwsjmxwSrkNE=;
        b=uXEGaXwIvsOqnL8MlSz6ntPAbqIU/jTL3+Yb/0If0Z5OjGAWhfsZvUCkxDZebq63xW
         5AK1UZ95p70iD2FQ+HcbOd1/+UC1i5wxyAe5jgVgtP2VRpprTeCjB6Pr9Azt/PsDxHAQ
         KhH9FdVYECNgTQtLBgTNAkkVMXxx914wM5bntXBwxsF/h7AM2NcdIuoKH0Phk/Lonfgr
         VZUzpfWQ5Rb+AiPx4+SzVwglOQjj20NiqhukuQ82YI2too+mXidonfKmlA80bH8SCoQQ
         zpTC0jj7INtkCqqaLLft4LQgKWdPK/5tICqGRtG3ekWFk2zYj5Va0OdxMH1ktlF6QapQ
         2swg==
X-Gm-Message-State: APjAAAVzMkYN8tFlSdMuaYEzNx9JIHNIGc9jdC9BMvm6kTWtfFiB+hwJ
        PLPzXDZ4FoX4j9Hn+iV1Mxqqrg==
X-Google-Smtp-Source: APXvYqzGZovPj+AGgg4lhMwHJDGfAEKbPIbXfCW4qwAbL+vEzcG67Zt+AoImghY4NiEo/jaiI/gqWw==
X-Received: by 2002:a1c:9d4a:: with SMTP id g71mr239894wme.50.1575473990613;
        Wed, 04 Dec 2019 07:39:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:a551:321a:c21f:1f92])
        by smtp.gmail.com with ESMTPSA id f1sm8631311wrp.93.2019.12.04.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:39:50 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/4] thermal/drivers/cpu_cooling: Rename to cpufreq_cooling
Date:   Wed,  4 Dec 2019 16:39:30 +0100
Message-Id: <20191204153930.9128-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204153930.9128-1-daniel.lezcano@linaro.org>
References: <20191204153930.9128-1-daniel.lezcano@linaro.org>
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

