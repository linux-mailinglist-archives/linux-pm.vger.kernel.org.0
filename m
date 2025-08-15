Return-Path: <linux-pm+bounces-32429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD9B27E3D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492E75E6893
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6FB2FDC21;
	Fri, 15 Aug 2025 10:28:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA732DAFCD;
	Fri, 15 Aug 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253681; cv=none; b=MTHSnDEYfNXQoCHV1+KIEka4tB+HXn0hhnRRInuSrfkSpSKWFjGJ32DEH6KV/8gzAXPhmIGxlE+Ge3utcOjtiVQQlAN5TsqbLE5e3R62AYlGf37AlpmvJreY1qtSnWyDpl/vQs7nFlX6+vNutX25I1CuwbhhlwH7dIl4+d9gKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253681; c=relaxed/simple;
	bh=wxIj/QdXOqFxCKkQBXdIC17thzMXussFdYxDWLLMO+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlNeB+NY7vvZ/fHstQ9t/tFOaXRN8iKd+yxWonPWhXjAjmw1J2DXof3tjpW2kCzPo9Xj3xilJs6n9ChN/Kc8lOS1DoByEfeeLEywoS7/ovfgNt2N3LBLUFbXhMvZ4BeLJ7tI6rbuNI4Ruuen4wL/O43Esq34+m8lktCnNFloodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7D91691;
	Fri, 15 Aug 2025 03:27:50 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D7853F738;
	Fri, 15 Aug 2025 03:27:55 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	johan+linaro@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	quic_mdtipton@quicinc.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/2] firmware: arm_scmi: Rework quirks framework header
Date: Fri, 15 Aug 2025 11:27:35 +0100
Message-ID: <20250815102736.81450-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split and relocate the quirks framework header so as to be usable also by
SCMI Drivers and not only by the core.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c  |  2 +-
 drivers/firmware/arm_scmi/driver.c |  1 +
 drivers/firmware/arm_scmi/quirks.h | 33 +++-------------------
 include/linux/scmi_quirks.h        | 44 ++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 30 deletions(-)
 create mode 100644 include/linux/scmi_quirks.h

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index afa7981efe82..5599697de37a 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -7,11 +7,11 @@
 
 #include <linux/module.h>
 #include <linux/limits.h>
+#include <linux/scmi_quirks.h>
 #include <linux/sort.h>
 
 #include "protocols.h"
 #include "notify.h"
-#include "quirks.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
 #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index bd56a877fdfc..6f5934cd3a65 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -34,6 +34,7 @@
 #include <linux/processor.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/scmi_quirks.h>
 #include <linux/xarray.h>
 
 #include "common.h"
diff --git a/drivers/firmware/arm_scmi/quirks.h b/drivers/firmware/arm_scmi/quirks.h
index a71fde85a527..260ae38d617b 100644
--- a/drivers/firmware/arm_scmi/quirks.h
+++ b/drivers/firmware/arm_scmi/quirks.h
@@ -4,49 +4,24 @@
  *
  * Copyright (C) 2025 ARM Ltd.
  */
-#ifndef _SCMI_QUIRKS_H
-#define _SCMI_QUIRKS_H
+#ifndef _SCMI_QUIRKS_INTERNAL_H
+#define _SCMI_QUIRKS_INTERNAL_H
 
-#include <linux/static_key.h>
+#include <linux/device.h>
 #include <linux/types.h>
 
 #ifdef CONFIG_ARM_SCMI_QUIRKS
 
-#define DECLARE_SCMI_QUIRK(_qn)						\
-	DECLARE_STATIC_KEY_FALSE(scmi_quirk_ ## _qn)
-
-/*
- * A helper to associate the actual code snippet to use as a quirk
- * named as _qn.
- */
-#define SCMI_QUIRK(_qn, _blk)						\
-	do {								\
-		if (static_branch_unlikely(&(scmi_quirk_ ## _qn)))	\
-			(_blk);						\
-	} while (0)
-
 void scmi_quirks_initialize(void);
 void scmi_quirks_enable(struct device *dev, const char *vend,
 			const char *subv, const u32 impl);
 
 #else
 
-#define DECLARE_SCMI_QUIRK(_qn)
-/* Force quirks compilation even when SCMI Quirks are disabled */
-#define SCMI_QUIRK(_qn, _blk)						\
-	do {								\
-		if (0)							\
-			(_blk);						\
-	} while (0)
-
 static inline void scmi_quirks_initialize(void) { }
 static inline void scmi_quirks_enable(struct device *dev, const char *vend,
 				      const char *sub_vend, const u32 impl) { }
 
 #endif /* CONFIG_ARM_SCMI_QUIRKS */
 
-/* Quirk delarations */
-DECLARE_SCMI_QUIRK(clock_rates_triplet_out_of_spec);
-DECLARE_SCMI_QUIRK(perf_level_get_fc_force);
-
-#endif /* _SCMI_QUIRKS_H */
+#endif /* _SCMI_QUIRKS_INTERNAL_H */
diff --git a/include/linux/scmi_quirks.h b/include/linux/scmi_quirks.h
new file mode 100644
index 000000000000..11657bd91ffc
--- /dev/null
+++ b/include/linux/scmi_quirks.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * System Control and Management Interface (SCMI) Message Protocol Quirks
+ *
+ * Copyright (C) 2025 ARM Ltd.
+ */
+#ifndef _SCMI_QUIRKS_H
+#define _SCMI_QUIRKS_H
+
+#include <linux/static_key.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_ARM_SCMI_QUIRKS
+
+#define DECLARE_SCMI_QUIRK(_qn)						\
+	DECLARE_STATIC_KEY_FALSE(scmi_quirk_ ## _qn)
+
+/*
+ * A helper to associate the actual code snippet to use as a quirk
+ * named as _qn.
+ */
+#define SCMI_QUIRK(_qn, _blk)						\
+	do {								\
+		if (static_branch_unlikely(&(scmi_quirk_ ## _qn)))	\
+			(_blk);						\
+	} while (0)
+
+#else
+
+#define DECLARE_SCMI_QUIRK(_qn)
+/* Force quirks compilation even when SCMI Quirks are disabled */
+#define SCMI_QUIRK(_qn, _blk)						\
+	do {								\
+		if (0)							\
+			(_blk);						\
+	} while (0)
+
+#endif /* CONFIG_ARM_SCMI_QUIRKS */
+
+/* Quirk delarations */
+DECLARE_SCMI_QUIRK(clock_rates_triplet_out_of_spec);
+DECLARE_SCMI_QUIRK(perf_level_get_fc_force);
+
+#endif /* _SCMI_QUIRKS_H */
-- 
2.50.1


