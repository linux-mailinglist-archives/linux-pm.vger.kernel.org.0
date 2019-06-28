Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE97E59B4D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfF1Man (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 08:30:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfF1Man (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 08:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g6PnYgoF+nIsr1DeTSg87cV+0eoxQLgIXXB3B01vM2Y=; b=CNgvgrdN+QqkNXZv02JzcBs2vw
        p7D5qhM9+kkh58oEYDGNv+4Wadz6HAc3D4aLItQpG75ssGYlAxxXN8g2Gi0SMYfavQIhALBRvuayk
        QJlEgOlxXkqoifr0v0+lErJg/kYrfwygZlms8/I/ZPO39kQIb9cuCyQyR56V49mn/PVrzU/9sA9yh
        KtIm00YHbOCPyHtwzhzo3blpjpPXf5MBkwhCjWSZRmjP+F/vdeBidVGfbs0WaTfw5JtQc3MPHzyFA
        u8frsSC3Vd1axRT5LnZBFWhkcmdOneRZWTFI2zWClj1L9gWHIsAmb5ycHxEWeHc3fhXf1p0yhWVU5
        0rAsSzhQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00054r-2s; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1R-0005Qz-Va; Fri, 28 Jun 2019 09:30:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 01/39] docs: thermal: add it to the driver API
Date:   Fri, 28 Jun 2019 09:29:54 -0300
Message-Id: <c9c7d7e0567aed7e36c4eb9c09ddfb6274913e9c.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 Documentation/{ => driver-api}/thermal/index.rst     |  2 --
 .../{ => driver-api}/thermal/intel_powerclamp.rst    |  0
 .../{ => driver-api}/thermal/nouveau_thermal.rst     |  0
 .../{ => driver-api}/thermal/power_allocator.rst     |  0
 Documentation/{ => driver-api}/thermal/sysfs-api.rst | 12 ++++++------
 .../thermal/x86_pkg_temperature_thermal.rst          |  2 +-
 MAINTAINERS                                          |  2 +-
 include/linux/thermal.h                              |  4 ++--
 12 files changed, 11 insertions(+), 12 deletions(-)
 rename Documentation/{ => driver-api}/thermal/cpu-cooling-api.rst (100%)
 rename Documentation/{ => driver-api}/thermal/exynos_thermal.rst (100%)
 rename Documentation/{ => driver-api}/thermal/exynos_thermal_emulation.rst (100%)
 rename Documentation/{ => driver-api}/thermal/index.rst (95%)
 rename Documentation/{ => driver-api}/thermal/intel_powerclamp.rst (100%)
 rename Documentation/{ => driver-api}/thermal/nouveau_thermal.rst (100%)
 rename Documentation/{ => driver-api}/thermal/power_allocator.rst (100%)
 rename Documentation/{ => driver-api}/thermal/sysfs-api.rst (98%)
 rename Documentation/{ => driver-api}/thermal/x86_pkg_temperature_thermal.rst (94%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 0dbaa987aa11..4e503e360860 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -56,6 +56,7 @@ available subsections can be seen below.
    dmaengine/index
    slimbus
    soundwire/index
+   thermal/index
    fpga/index
    acpi/index
    generic-counter
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
similarity index 95%
rename from Documentation/thermal/index.rst
rename to Documentation/driver-api/thermal/index.rst
index 8c1c00146cad..68ceb6886561 100644
--- a/Documentation/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =======
 Thermal
 =======
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
index 7ba6d174f49f..9d3a408f5ce1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15762,7 +15762,7 @@ M:	Viresh Kumar <viresh.kumar@linaro.org>
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

