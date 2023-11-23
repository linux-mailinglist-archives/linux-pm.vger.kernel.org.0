Return-Path: <linux-pm+bounces-122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B207F5EC4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 13:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC828281C91
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3FE18C04;
	Thu, 23 Nov 2023 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F5BE91
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 04:08:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C53C21063;
	Thu, 23 Nov 2023 04:09:38 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 939B33F7A6;
	Thu, 23 Nov 2023 04:08:51 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/2] firmware: arm_scpi: Move power-domain driver to the pmdomain dir
Date: Thu, 23 Nov 2023 12:08:47 +0000
Message-ID: <20231123120847.2825444-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123120847.2825444-1-sudeep.holla@arm.com>
References: <20231123120847.2825444-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To simplify with maintenance let's move the Arm SCPI power-domain driver
to the new pmdomain directory. Note this is different from and precedes
the new Arm SCMI protocol.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/Kconfig                            |  9 ---------
 drivers/firmware/Makefile                           |  1 -
 drivers/pmdomain/arm/Kconfig                        | 12 ++++++++++++
 drivers/pmdomain/arm/Makefile                       |  1 +
 drivers/{firmware => pmdomain/arm}/scpi_pm_domain.c |  0
 5 files changed, 13 insertions(+), 10 deletions(-)
 rename drivers/{firmware => pmdomain/arm}/scpi_pm_domain.c (100%)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 4a98a859d44d..afeb050ae1b4 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -28,15 +28,6 @@ config ARM_SCPI_PROTOCOL
 	  This protocol library provides interface for all the client drivers
 	  making use of the features offered by the SCP.

-config ARM_SCPI_POWER_DOMAIN
-	tristate "SCPI power domain driver"
-	depends on ARM_SCPI_PROTOCOL || (COMPILE_TEST && OF)
-	default y
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the SCPI power domains which can be
-	  enabled or disabled via the SCP firmware
-
 config ARM_SDE_INTERFACE
 	bool "ARM Software Delegated Exception Interface (SDEI)"
 	depends on ARM64
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 5f9dab82e1a0..944833702ebd 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -3,7 +3,6 @@
 # Makefile for the linux kernel.
 #
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
-obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
 obj-$(CONFIG_DMI)		+= dmi_scan.o
 obj-$(CONFIG_DMI_SYSFS)		+= dmi-sysfs.o
diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
index acbe4331aaf7..efa139c34e08 100644
--- a/drivers/pmdomain/arm/Kconfig
+++ b/drivers/pmdomain/arm/Kconfig
@@ -23,3 +23,15 @@ config ARM_SCMI_POWER_DOMAIN
 	  This driver can also be built as a module. If so, the module
 	  will be called scmi_pm_domain. Note this may needed early in boot
 	  before rootfs may be available.
+
+config ARM_SCPI_POWER_DOMAIN
+	tristate "SCPI power domain driver"
+	depends on ARM_SCPI_PROTOCOL || (COMPILE_TEST && OF)
+	default y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the SCPI power domains which can be
+	  enabled or disabled via the SCP firmware
+
+	  This driver can also be built as a module. If so, the module will be
+	  called scpi_pm_domain.
diff --git a/drivers/pmdomain/arm/Makefile b/drivers/pmdomain/arm/Makefile
index cfcb1f6cdd90..502fe4d0a83e 100644
--- a/drivers/pmdomain/arm/Makefile
+++ b/drivers/pmdomain/arm/Makefile
@@ -2,3 +2,4 @@

 obj-$(CONFIG_ARM_SCMI_PERF_DOMAIN) += scmi_perf_domain.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
+obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
diff --git a/drivers/firmware/scpi_pm_domain.c b/drivers/pmdomain/arm/scpi_pm_domain.c
similarity index 100%
rename from drivers/firmware/scpi_pm_domain.c
rename to drivers/pmdomain/arm/scpi_pm_domain.c
--
2.42.0


