Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729B310F17D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 21:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfLBU2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 15:28:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52059 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBU2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 15:28:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so736498wme.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ov3qfLDesJCRBNnguqXtY2vyu5jCndpMMvqcZHjaUgY=;
        b=lqyHGeUtxxdEEaCZVDqaXCr/pN6fZMpBRfNUzEhXj+5xICpr9jadEu9V232RlhlB1e
         UjFB0HMG9tr+1MdpnoJ2BcQB3+kImfPnZ8rLfsHhxH1PKRq1T5Tva0cYy5ec+3QerPKG
         aTvXFiab7LC/ZZt8tGMIVmyAsp8t5FeA1hFTMTD71DjII7MZ3YXlIh7i7ZuU4Cq6xbaJ
         IiByzw1YteII1wNhyYuzhorxJkoAW5/OxUXp6SB9xs8qxddQAmXLULhLBJNmutDdHk9v
         t0Xh3RSe7r3T9bC4jTlfme2jsY3Vlm3Hdvi4ahj9n2pyGF7BFOlbSnIQ/wbiooCIbP9z
         gZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ov3qfLDesJCRBNnguqXtY2vyu5jCndpMMvqcZHjaUgY=;
        b=bCoq6r0ha+PhGN1okvrmZd3jwXHrNhIxtkGptc8qGUI2xTNTsAe1R9qliYba6zaiuC
         rTHcxuM+4G+WEMkoEuwzOSmmH/LIDFPXH73G1SvUqExH3OovqpqKTvOsQC7aoUZGgjsK
         wRzoxPlMYRPy9OCY7C/8YmxgSpb8TA9kq/q7adgaJaxn2g+Y7rk4SrpLqup9aEs/BElA
         E0B22oUAX7lrpqDewcuy1csVsFUWPOc+vWqTB48ZU9/PuXxKg8/sBdrVrMG7ehAsfpRs
         BIriOMGxFVc7cdGme6qTuVMhUr8WUgKyv5559jIvt3fxAxzb/IeXGR6yPPu9GFWM+Ona
         OKzQ==
X-Gm-Message-State: APjAAAXgxkqEiNUsqaNilpDfZ+Q8EQNpLJzJRjri097SYV4uFz5Tb41L
        nEgYZ+6aUXLX5F3/0PTsgxAVWj18qwE=
X-Google-Smtp-Source: APXvYqwOs3WtzzgE1rYK2/VlJRQ9YJ+T4mXwoVhmT2WmZBx0iLEZp49UnPjOpRylLepNIWx3kecQag==
X-Received: by 2002:a1c:4b03:: with SMTP id y3mr19930816wma.91.1575318501716;
        Mon, 02 Dec 2019 12:28:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8196:cbcc:fb2c:4975])
        by smtp.gmail.com with ESMTPSA id k20sm556456wmj.10.2019.12.02.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:28:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
Date:   Mon,  2 Dec 2019 21:28:12 +0100
Message-Id: <20191202202815.22731-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The next changes will add a new way to cool down a CPU by injecting
idle cycles. With the current configuration, a CPU cooling device is
the cpufreq cooling device. As we want to add a new CPU cooling
device, let's convert the CPU cooling to a choice giving a list of CPU
cooling devices. At this point, there is obviously only one CPU
cooling device.

There is no functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
  V2:
    - Default CPU_FREQ_COOLING when CPU_THERMAL is set (Viresh Kumar)
---
 drivers/thermal/Kconfig     | 14 ++++++++++++--
 drivers/thermal/Makefile    |  2 +-
 include/linux/cpu_cooling.h |  6 +++---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 001a21abcc28..4e3ee036938b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -150,8 +150,18 @@ config THERMAL_GOV_POWER_ALLOCATOR
 
 config CPU_THERMAL
 	bool "Generic cpu cooling support"
-	depends on CPU_FREQ
 	depends on THERMAL_OF
+	help
+	  Enable the CPU cooling features. If the system has no active
+	  cooling device available, this option allows to use the CPU
+	  as a cooling device.
+
+if CPU_THERMAL
+
+config CPU_FREQ_THERMAL
+	bool "CPU frequency cooling device"
+	depends on CPU_FREQ
+	default y
 	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
@@ -159,7 +169,7 @@ config CPU_THERMAL
 	  This will be useful for platforms using the generic thermal interface
 	  and not the ACPI interface.
 
-	  If you want this support, you should say Y here.
+endif
 
 config CLOCK_THERMAL
 	bool "Generic clock cooling support"
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 74a37c7f847a..d3b01cc96981 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -19,7 +19,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
 thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
 
 # cpufreq cooling
-thermal_sys-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
+thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
 
 # clock cooling
 thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index b74732535e4b..3cdd85f987d7 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -19,7 +19,7 @@
 
 struct cpufreq_policy;
 
-#ifdef CONFIG_CPU_THERMAL
+#ifdef CONFIG_CPU_FREQ_THERMAL
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
  * @policy: cpufreq policy.
@@ -40,7 +40,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy);
 
-#else /* !CONFIG_CPU_THERMAL */
+#else /* !CONFIG_CPU_FREQ_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
@@ -58,6 +58,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
-#endif /* CONFIG_CPU_THERMAL */
+#endif /* CONFIG_CPU_FREQ_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1

