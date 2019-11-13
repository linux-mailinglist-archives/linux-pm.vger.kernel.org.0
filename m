Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB5FAC25
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 09:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfKMIk4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 03:40:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42715 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMIkz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 03:40:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so1285257wrf.9
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 00:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=duwBoEZu8ONR3Kpqj7k/vnfSyGY52V9/HA6DrXTVVao=;
        b=LbG0zOdgKPABVSEgK1vjmpfZefrws6Ve9ii3LF79ah6JbAro9X/IalXn8g70oRwIs9
         u9mXgOE+ECeneTh9bHGCfXT98oOe9dGQEmEJ/cndxRDTQe7xTau6KW+Z8l710c6b6VLD
         0vvmR8FhCWelGuVRK49RBxU2k0ksf7iYplmEDqypYQcOkgMqiu7LQNRSD+GX2+8PXeoY
         qw1RMG6kZ68B15y5Ku1EM1UaW6KcYSx2eYSm40RWyBywK7chFGgYa9Ki6GBhGSLNTVo3
         ZhJzyQcmImIJMKhb7IG3QTuEmRp6A1xys5nKsecxxfcKfNLqlWYEQNbQIUtEIDuDDI21
         0f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=duwBoEZu8ONR3Kpqj7k/vnfSyGY52V9/HA6DrXTVVao=;
        b=j0OXT5A/nRJChzq62vAfnQI4bW5/91/5ts3zp98czhtbaESyO4jGEWxiKnTVBKG9Jw
         7igRTFJBkM0suC/3KLYqf1iOijFtbJVmqn+7CxIidOLqFtmChmtAjXk2dfgb09nhpVMV
         I0wYFiQsQNsjjLmByxxJmAdtJ859XHPghdB7PL+8Ng5CPSpliS98Vv6M9/8IInHeAUjJ
         zewvSyyZxOmMAyEiwNwxx1/0YkhPF9lGev05PtMk0lx+QajKooazQVAfAsYy6cPz3uZH
         CSEmXoWg28rCQFo496F7GWyeuR+Q6VHcNtXcPEMaOfhNX5nTY/tk2CVNjv66AhOdCfPC
         VAXw==
X-Gm-Message-State: APjAAAXTeE5XN1PEXXUP91IAwVy6RL9mOdJwm3og72MZFEblJg4hhaMI
        oP1TUBAPaH5fnQcz/2GEfcoPKMiAhwQ=
X-Google-Smtp-Source: APXvYqyhAqxkq744Z/HqS84ByvyvEvolM2hZLSHEnenA1CNXMue2JTN6yHOt6t1/M8gv/9Gnddkq1g==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr1632661wrm.366.1573634453646;
        Wed, 13 Nov 2019 00:40:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8174:caa5:2144:f60])
        by smtp.gmail.com with ESMTPSA id h205sm1667499wmf.35.2019.11.13.00.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 00:40:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net, edubezval@gmail.com, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
Date:   Wed, 13 Nov 2019 09:40:40 +0100
Message-Id: <20191113084042.5707-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/Kconfig     | 13 +++++++++++--
 drivers/thermal/Makefile    |  2 +-
 include/linux/cpu_cooling.h |  6 +++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 001a21abcc28..2b82c4861091 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -150,8 +150,17 @@ config THERMAL_GOV_POWER_ALLOCATOR
 
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
 	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
@@ -159,7 +168,7 @@ config CPU_THERMAL
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

