Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C03010FAD6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 10:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCJhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 04:37:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36167 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCJhN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 04:37:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2789849wru.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=v9aPs/wpi2L5/d1FqkD06cZ03HNvyIimtXPANJEaaic=;
        b=UO5bhFxtDW+Yhtt76FWIlSYlZjTVcz3TshtsNuRV/UPdlkYfWUpmJjmE9LchizUrZU
         wCdGmXa/c4WBeOrnh0ueMXSGy11K8bDqCYzH82FJgOzU/+xwDKU6+3aGexyCVbTyPGvm
         MjAOko08FJyTVOXFEnRG2vLiTcNIVYMhy6t1mfJeatE66cVYBhp73AjBOtLbRGBuGhWk
         kUqt51i6SfdlrIDmGX3khX6/Owm/uhw0zA3lMAJ4nr4y5xUeAJNzPLZMHE5xSvuGQdel
         4/9lqadTADcsVtVAzqmM5Usco+DUDuQA5eU+XxItYOot0U3e8pWz3OyimG6G0PthVkmR
         7/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v9aPs/wpi2L5/d1FqkD06cZ03HNvyIimtXPANJEaaic=;
        b=TKhKJfuOfhuYAwDPZ+/tLGuh6tUpltFmu5qius/fQ+4VmBTcRM2Y4HnENKuVV/o9Cj
         gpEKC5NZK+olbm984+w8HaUzBeqdkyholvfvvjUgwTiziEjDYSYOk1d5Zlk80RH63SvE
         ZLdEKSx+Hqv71wBvHhRL9BH0p7jw/T3X3vuXEK4LFLfcGqmtlK6o/e4RaAd2qkdwPSd5
         TE/12HVm7/Y6GnQxO3PCbHruzeAABOqQJ3fXh1Ag1piO9D4x2KPugxW2PCrj9YBjjNUp
         mS1gGtLyj4O/PAFmaBzGekXcTLQFCtsRCETfVk6S8EdzElMK4gpp+599NMB9sUyP/jdX
         GsnQ==
X-Gm-Message-State: APjAAAUS602ThXJzyZMk+orMuZ11anFaieCx4jdjvUs6BYnETUj1yT5x
        H3mUhMni+GiQfjtRBIDioIwIWA==
X-Google-Smtp-Source: APXvYqyciia4aYAIG8fMfAHSsdXZfaxnHQ0iL6ucE1f1unnBidOhAr0gju8Fey54UdXU/ImqbbyLTQ==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr3903327wro.209.1575365831350;
        Tue, 03 Dec 2019 01:37:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8196:cbcc:fb2c:4975])
        by smtp.gmail.com with ESMTPSA id w13sm2935751wru.38.2019.12.03.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:37:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
Date:   Tue,  3 Dec 2019 10:37:01 +0100
Message-Id: <20191203093704.7037-1-daniel.lezcano@linaro.org>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

