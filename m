Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A001476651
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfGZMvu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 08:51:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGZMvp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 08:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZErB5JkXJ+AJC3gF/rewuZPhETPxcPKIdi59ty3DG7Q=; b=TLbZp7lyqvuk/YliNuyjpIq9gQ
        RG7H6WCIGkZud9gSX9MHipsBWbDy3Mfh6QVQTFpEYprQeD8ui+hxt1p+fcR5NwGzaSVNbTJysyyVI
        MoUL7u2xy6d4s9jf/EoX8d34CwsjZ6mok5vaoCpYxg7VrrNTXo7AcVsucywvwRFG4BJJr6bo9p/xJ
        IemVKi1io5b2fu5GmRqbYUZlHu408tDYJqVgIlCB/CwkbOo6eFW03k/+9C7WvMEN3MehoTaJOlxGx
        GD39JxXhbDFVOJ7CuKSv6b3vmC2kWVRFGR3chCDh3XdwuQKMgXVsE0ACVWTt6KyrwmtjHosqhD2fF
        Q1Zo3A2A==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqzhE-0006Ap-LR; Fri, 26 Jul 2019 12:51:41 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hqzhB-0005aC-UX; Fri, 26 Jul 2019 09:51:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 02/26] docs: thermal: add it to the driver API
Date:   Fri, 26 Jul 2019 09:51:12 -0300
Message-Id: <968a776693ded3027f25144d997eb4187c625906.1564145354.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564145354.git.mchehab+samsung@kernel.org>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The file contents mostly describes driver internals.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst                   |  1 +
 .../{ => driver-api}/thermal/cpu-cooling-api.rst     |  0
 .../{ => driver-api}/thermal/exynos_thermal.rst      |  0
 .../thermal/exynos_thermal_emulation.rst             |  0
 Documentation/{ => driver-api}/thermal/index.rst     |  2 +-
 .../{ => driver-api}/thermal/intel_powerclamp.rst    |  0
 .../{ => driver-api}/thermal/nouveau_thermal.rst     |  0
 .../{ => driver-api}/thermal/power_allocator.rst     |  0
 Documentation/{ => driver-api}/thermal/sysfs-api.rst | 12 ++++++------
 .../thermal/x86_pkg_temperature_thermal.rst          |  2 +-
 MAINTAINERS                                          |  2 +-
 include/linux/thermal.h                              |  4 ++--
 12 files changed, 12 insertions(+), 11 deletions(-)
 rename Documentation/{ => driver-api}/thermal/cpu-cooling-api.rst (100%)
 rename Documentation/{ => driver-api}/thermal/exynos_thermal.rst (100%)
 rename Documentation/{ => driver-api}/thermal/exynos_thermal_emulation.rst (100%)
 rename Documentation/{ => driver-api}/thermal/index.rst (86%)
 rename Documentation/{ => driver-api}/thermal/intel_powerclamp.rst (100%)
 rename Documentation/{ => driver-api}/thermal/nouveau_thermal.rst (100%)
 rename Documentation/{ => driver-api}/thermal/power_allocator.rst (100%)
 rename Documentation/{ => driver-api}/thermal/sysfs-api.rst (98%)
 rename Documentation/{ => driver-api}/thermal/x86_pkg_temperature_thermal.rst (94%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index d12a80f386a6..37ac052ded85 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -65,6 +65,7 @@ available subsections can be seen below.
    dmaengine/index
    slimbus
    soundwire/index
+   thermal/index
    fpga/index
    acpi/index
    backlight/lp855x-driver.rst
diff --git a/Documentation/thermal/cpu-cooling-api.rst b/Documentation/driver-api/thermal/cpu-cooling-api.rst
similarity index 100%
rename from Documentation/thermal/cpu-cooling-api.rst
rename to Documentation/driver-api/thermal/cpu-cooling-api.rst
diff --git a/Documentation/thermal/exynos_thermal.rst b/Documentation/driver-api/thermal/exynos_thermal.rst
similarity index 100%
rename from Documentation/thermal/exynos_thermal.rst
rename to Documentation/driver-api/thermal/exynos_thermal.rst
diff --git a/Documentation/thermal/exynos_thermal_emulation.rst b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
similarity index 100%
rename from Documentation/thermal/exynos_thermal_emulation.rst
rename to Documentation/driver-api/thermal/exynos_thermal_emulation.rst
diff --git a/Documentation/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
similarity index 86%
rename from Documentation/thermal/index.rst
rename to Documentation/driver-api/thermal/index.rst
index 8c1c00146cad..5ba61d19c6ae 100644
--- a/Documentation/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 =======
 Thermal
diff --git a/Documentation/thermal/intel_powerclamp.rst b/Documentation/driver-api/thermal/intel_powerclamp.rst
similarity index 100%
rename from Documentation/thermal/intel_powerclamp.rst
rename to Documentation/driver-api/thermal/intel_powerclamp.rst
diff --git a/Documentation/thermal/nouveau_thermal.rst b/Documentation/driver-api/thermal/nouveau_thermal.rst
similarity index 100%
rename from Documentation/thermal/nouveau_thermal.rst
rename to Documentation/driver-api/thermal/nouveau_thermal.rst
diff --git a/Documentation/thermal/power_allocator.rst b/Documentation/driver-api/thermal/power_allocator.rst
similarity index 100%
rename from Documentation/thermal/power_allocator.rst
rename to Documentation/driver-api/thermal/power_allocator.rst
diff --git a/Documentation/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
similarity index 98%
rename from Documentation/thermal/sysfs-api.rst
rename to Documentation/driver-api/thermal/sysfs-api.rst
index e4930761d3e5..fab2c9b36d08 100644
--- a/Documentation/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -552,7 +552,7 @@ emul_temp
 sustainable_power
 	An estimate of the sustained power that can be dissipated by
 	the thermal zone. Used by the power allocator governor. For
-	more information see Documentation/thermal/power_allocator.rst
+	more information see Documentation/driver-api/thermal/power_allocator.rst
 
 	Unit: milliwatts
 
@@ -563,7 +563,7 @@ k_po
 	controller during temperature overshoot. Temperature overshoot
 	is when the current temperature is above the "desired
 	temperature" trip point. For more information see
-	Documentation/thermal/power_allocator.rst
+	Documentation/driver-api/thermal/power_allocator.rst
 
 	RW, Optional
 
@@ -572,7 +572,7 @@ k_pu
 	controller during temperature undershoot. Temperature undershoot
 	is when the current temperature is below the "desired
 	temperature" trip point. For more information see
-	Documentation/thermal/power_allocator.rst
+	Documentation/driver-api/thermal/power_allocator.rst
 
 	RW, Optional
 
@@ -580,14 +580,14 @@ k_i
 	The integral term of the power allocator governor's PID
 	controller. This term allows the PID controller to compensate
 	for long term drift. For more information see
-	Documentation/thermal/power_allocator.rst
+	Documentation/driver-api/thermal/power_allocator.rst
 
 	RW, Optional
 
 k_d
 	The derivative term of the power allocator governor's PID
 	controller. For more information see
-	Documentation/thermal/power_allocator.rst
+	Documentation/driver-api/thermal/power_allocator.rst
 
 	RW, Optional
 
@@ -598,7 +598,7 @@ integral_cutoff
 	example, if integral_cutoff is 0, then the integral term only
 	accumulates error when temperature is above the desired
 	temperature trip point. For more information see
-	Documentation/thermal/power_allocator.rst
+	Documentation/driver-api/thermal/power_allocator.rst
 
 	Unit: millidegree Celsius
 
diff --git a/Documentation/thermal/x86_pkg_temperature_thermal.rst b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
similarity index 94%
rename from Documentation/thermal/x86_pkg_temperature_thermal.rst
rename to Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
index f134dbd3f5a9..2ac42ccd236f 100644
--- a/Documentation/thermal/x86_pkg_temperature_thermal.rst
+++ b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
@@ -40,7 +40,7 @@ This contains two trip points:
 - trip_point_1_temp
 
 User can set any temperature between 0 to TJ-Max temperature. Temperature units
-are in milli-degree Celsius. Refer to "Documentation/thermal/sysfs-api.rst" for
+are in milli-degree Celsius. Refer to "Documentation/driver-api/thermal/sysfs-api.rst" for
 thermal sys-fs details.
 
 Any value other than 0 in these trip points, can trigger thermal notifications.
diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2a525e22c0..3d6cd6efb264 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15907,7 +15907,7 @@ M:	Viresh Kumar <viresh.kumar@linaro.org>
 M:	Javi Merino <javi.merino@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
-F:	Documentation/thermal/cpu-cooling-api.rst
+F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	drivers/thermal/cpu_cooling.c
 F:	include/linux/cpu_cooling.h
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 681047f8cc05..e45659c75920 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -251,7 +251,7 @@ struct thermal_bind_params {
 	 * platform characterization. This value is relative to the
 	 * rest of the weights so a cooling device whose weight is
 	 * double that of another cooling device is twice as
-	 * effective. See Documentation/thermal/sysfs-api.rst for more
+	 * effective. See Documentation/driver-api/thermal/sysfs-api.rst for more
 	 * information.
 	 */
 	int weight;
@@ -259,7 +259,7 @@ struct thermal_bind_params {
 	/*
 	 * This is a bit mask that gives the binding relation between this
 	 * thermal zone and cdev, for a particular trip point.
-	 * See Documentation/thermal/sysfs-api.rst for more information.
+	 * See Documentation/driver-api/thermal/sysfs-api.rst for more information.
 	 */
 	int trip_mask;
 
-- 
2.21.0

