Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D56A2168BC
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGGJCH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgGGJCG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 05:02:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF6BC08C5DB
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 02:02:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so44323201wrm.4
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kRUj27P8zkGmRIKsXZ+nQk6qp/gprxkKDYwZvWToTEw=;
        b=pH2EQs+98Q+b/hALQfjLX+d/kUVqXcCMJojjSCHyCDhhWUqwLbxL1Dmc/I4kLt4+rc
         gzTPDZuuPVC+Tqj7E9x/p47pPP0Pg995WHDCujTB5jfF3eULQol88fmyftUQmvSIHHBK
         bcN8qq/70I4t2S6PyMoS4L/X5UAvHtMFMsl5n1uR6EIFwgIYLX/1/91rk1AMip5Etk7X
         8ywDSgwegbQCwBx9o5kK4oNOR4kSpGhUEW55z8Glp+upLI8C31bdWU2gnU7ObrY0NSKc
         iGo1MHOBCoxhAd3vRwdB9nM/JMn2VnDliLKGtsrsOxUb+pgOmVA2Q05bmcECkvJkc88h
         hIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kRUj27P8zkGmRIKsXZ+nQk6qp/gprxkKDYwZvWToTEw=;
        b=OSgCD2jEqboYFY7RqWOnsZ5L1zZrG1BDtFAgGkesiXbekxvrtsg7xwnZtAVSZPZfiI
         +Tk8D2PKt4V581LYBifNZZWGhqf+F20pxIfHZRz3Ap5OprMkPBe6uXpd6OEIr9aVToqZ
         nk1xVr7EiPpm8I7vH+KW5jKvxaMVI7Ao2heLLETemFh0VTEFv2Zz1k/3vBYpctClwIz9
         St+51EY2orwHZ5N9mfdZeaY0fnuaHvbvE+1Pr2CD1/aMR+A/SVqv/YTYgOFcFLe61voz
         /3+J4CSjA+G8wJIFG/XADC7TXpsXkZFCG2bLFpq46Gp/TW38fjs761uEqx9J7SyngV6T
         bs5Q==
X-Gm-Message-State: AOAM531a4xFMigcK582ID+38OtKD3/HoP5cEB9L1pvzHrtz4KSmlVPk5
        YdyBT4F6Ago727OyfnHWcJXyzg==
X-Google-Smtp-Source: ABdhPJw0LLwgq5sF+UNMHDhajm6tbuK6sIv9ZaOSuqr0BBO+kT16aXZYIymLrhUsFYfKPCbgX3Y/Lw==
X-Received: by 2002:adf:f707:: with SMTP id r7mr52056237wrp.70.1594112524900;
        Tue, 07 Jul 2020 02:02:04 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id d201sm142998wmd.34.2020.07.07.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 02:02:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rdunlap@infradead.org
Subject: [PATCH] thermal: netlink: Fix compilation error when CONFIG_NET=n
Date:   Tue,  7 Jul 2020 11:01:57 +0200
Message-Id: <20200707090159.1018-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the network is not configured, the netlink are disabled on all
the system. The thermal framework assumed the netlink are always
opt-in.

Fix this by adding a Kconfig option for the netlink notification,
defaulting to yes and depending on CONFIG_NET.

As the change implies multiple stubs and in order to not pollute the
internal thermal header, the thermal_nelink.h has been added and
included in the thermal_core.h, so this one regain some kind of
clarity.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig           | 10 ++++
 drivers/thermal/Makefile          |  5 +-
 drivers/thermal/thermal_core.h    | 20 +------
 drivers/thermal/thermal_netlink.h | 98 +++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 19 deletions(-)
 create mode 100644 drivers/thermal/thermal_netlink.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3eb2348e5242..07983bef8d6a 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -17,6 +17,16 @@ menuconfig THERMAL
 
 if THERMAL
 
+config THERMAL_NETLINK
+	bool "Thermal netlink management"
+	depends on NET
+	default y
+	help
+	  The thermal framework has a netlink interface to do thermal
+	  zones discovery, temperature readings and events such as
+	  trip point crossed, cooling device update or governor
+	  change. It is recommended to enable the feature.
+
 config THERMAL_STATISTICS
 	bool "Thermal state transition statistics"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 1bbf0805fb04..589f6fb0d381 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -5,7 +5,10 @@
 
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o \
-					thermal_helpers.o thermal_netlink.o
+					thermal_helpers.o
+
+# netlink interface to manage the thermal framework
+thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index b44969d50ec0..99d065e6ed08 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -12,6 +12,8 @@
 #include <linux/device.h>
 #include <linux/thermal.h>
 
+#include "thermal_netlink.h"
+
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
@@ -52,24 +54,6 @@ int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
-/* Netlink notification function */
-int thermal_notify_tz_create(int tz_id, const char *name);
-int thermal_notify_tz_delete(int tz_id);
-int thermal_notify_tz_enable(int tz_id);
-int thermal_notify_tz_disable(int tz_id);
-int thermal_notify_tz_trip_down(int tz_id, int id);
-int thermal_notify_tz_trip_up(int tz_id, int id);
-int thermal_notify_tz_trip_delete(int tz_id, int id);
-int thermal_notify_tz_trip_add(int tz_id, int id, int type,
-			       int temp, int hyst);
-int thermal_notify_tz_trip_change(int tz_id, int id, int type,
-				  int temp, int hyst);
-int thermal_notify_cdev_state_update(int cdev_id, int state);
-int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
-int thermal_notify_cdev_delete(int cdev_id);
-int thermal_notify_tz_gov_change(int tz_id, const char *name);
-int thermal_genl_sampling_temp(int id, int temp);
-
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
new file mode 100644
index 000000000000..0ec28d105da5
--- /dev/null
+++ b/drivers/thermal/thermal_netlink.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) Linaro Ltd 2020
+ *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ */
+
+/* Netlink notification function */
+#ifdef CONFIG_THERMAL_NETLINK
+int thermal_notify_tz_create(int tz_id, const char *name);
+int thermal_notify_tz_delete(int tz_id);
+int thermal_notify_tz_enable(int tz_id);
+int thermal_notify_tz_disable(int tz_id);
+int thermal_notify_tz_trip_down(int tz_id, int id);
+int thermal_notify_tz_trip_up(int tz_id, int id);
+int thermal_notify_tz_trip_delete(int tz_id, int id);
+int thermal_notify_tz_trip_add(int tz_id, int id, int type,
+			       int temp, int hyst);
+int thermal_notify_tz_trip_change(int tz_id, int id, int type,
+				  int temp, int hyst);
+int thermal_notify_cdev_state_update(int cdev_id, int state);
+int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
+int thermal_notify_cdev_delete(int cdev_id);
+int thermal_notify_tz_gov_change(int tz_id, const char *name);
+int thermal_genl_sampling_temp(int id, int temp);
+#else
+static inline int thermal_notify_tz_create(int tz_id, const char *name)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_delete(int tz_id)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_enable(int tz_id)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_disable(int tz_id)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_trip_down(int tz_id, int id)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_trip_up(int tz_id, int id)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_trip_delete(int tz_id, int id)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_trip_add(int tz_id, int id, int type,
+					     int temp, int hyst)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_trip_change(int tz_id, int id, int type,
+						int temp, int hyst)
+{
+	return 0;
+}
+
+static inline int thermal_notify_cdev_state_update(int cdev_id, int state)
+{
+	return 0;
+}
+
+static inline int thermal_notify_cdev_add(int cdev_id, const char *name,
+					  int max_state)
+{
+	return 0;
+}
+
+static inline int thermal_notify_cdev_delete(int cdev_id)
+{
+	return 0;
+}
+
+static inline int thermal_notify_tz_gov_change(int tz_id, const char *name)
+{
+	return 0;
+}
+
+static inline int thermal_genl_sampling_temp(int id, int temp)
+{
+	return 0;
+}
+#endif /* CONFIG_THERMAL_NETLINK */
-- 
2.17.1

