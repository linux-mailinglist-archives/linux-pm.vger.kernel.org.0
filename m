Return-Path: <linux-pm+bounces-40863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E306D1F61C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3473B3083514
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC439A810;
	Wed, 14 Jan 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/bft0uR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C610352C2F
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400245; cv=none; b=cGacLKJR+yzK+tG4uuXodw0Sj3omWPHUul4ygWkDMBE5AnXMtGdyRwqUZr99I0Q6LzNAPwEzTB/H0XAPGSRYJLsXsCSRVXzUFF2Eg2m/cqvRH1vejvr7rJKUI1H/tCuLpIt0Kxd4aXaJnC8KlJ25YEbGy+uDHZkRgOxMzXuOkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400245; c=relaxed/simple;
	bh=ycpTTuEHw1ktY5WMh2z4gJLM2jmFjBFEmH6MdKsS1So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtncrnrGuZfaqxZmqw8LEkxKp1LtHOgX2xzr9/Yvl+eM0HIoJmZxuSuwKBaHwMlavUUQjTCnA3Y+tbabaMpImQ5eIqWwFh36dNwu1sRpJsGU3D0W9ldT0lSQtRn84rgI3F32kUAa7+eIcQptS6KuJw0P13eflzK1+4OdnI/2WSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/bft0uR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edffe5540so13896865e9.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 06:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768400237; x=1769005037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdOFUkO2rK+vmXcRhQDnh9qxgTzvG+6iS6r5EIC/eI4=;
        b=s/bft0uREd3dzmHGvtIciCbb4R5rrP3KrA3m0Q4scVT2+0KkUiLe5ZvJbCZLKbmxiu
         byqIjKqsI1Q2RsG7nEsUXSXwJ+Qxa0n4iwJg39X/X5t3165RZVvFmlJpnKTnr/IrneJE
         U5Fst7Ma/hFUhm6vedBA17gMHvhQvuwWzgxSRjFxWuxIJj6fxbbqdUDHSxY+tA0A+RqI
         zxMEiSZtkPCx+TEsiJprabQEqCwyjCnZthMyZPj8fQkLoN60UEjRWPjkIwKoYCf5bLzP
         l6WFtpv5dt19TPNwureKiEdM/qoSav+0y64ny/p50sVwY8lUlKzjb6ZTvwKIv7nfEnHO
         MsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400237; x=1769005037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vdOFUkO2rK+vmXcRhQDnh9qxgTzvG+6iS6r5EIC/eI4=;
        b=DDpKjU1qbseeXMd9oq72kgnUbMUyOr+hflj3zvG+01ks3jKTbMhYncKfKYkugqn7a0
         mpqTrTMOOc/kalVMwLg9tb+vQFA6xqTe99eZ8c3FYom/+g5zAGPGJaByxQJnMqob4AGa
         GldA6Rr6p0Bg7WC4CQSKOESs0t6uN88fKWm6SE3sN0nIz+vCHYZe2WeI7csu5oKs3zCh
         x3GFN7qtrvlljMtUNNCukfwCsc751EAd5WGzcxGF5SlysdEtqoUrUXu+I31xRAVkIoos
         lngfdma7apQuj89fv95QtQ38n2QZHT0bQo8NKjbyHMNjDmQHzrm5GVXMMaZ9RjOmAlpp
         t+BA==
X-Forwarded-Encrypted: i=1; AJvYcCVIAzFbZoL4YY/IReO4M7c487hyosMw+EaiGsMc4E+voEWHxGS7nLnrVAHkJifLLNT9wYUVpN0X8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bEvR5akRgw1mft6MwSDvDlJWtvxV3kKIeEnbFyboGWQxWBk2
	FK1g2yFxAu6YFquclLCO9UgZKB32H3D57svN11mYbqrz80kzygLt1o+zPfbQ6t5gOgE=
X-Gm-Gg: AY/fxX4ppjk/nqsSqOhj2N3896RmCiBu9+WQHRb/FlUS4vMA8GbUgYVsINHUeUUvkjm
	4xh2F8Ix+d6JVDuPA36+c83nW85pASRNjXgq4mzxEMGLpONHIIlPYzj3xiHGc+LqVms63iGwn3T
	2WKhUqNk8FX9vl3TepvWzSH3cyY0UoovXPh7yE3o+mkvsH+siHP6u1zfs2XMnzFq26ojcDhg1Iv
	U9gTvpg+++zqXMgYpGZu7hOm1TvQ8NvrdmMcTUI3GLtJ/ILPqdOqy64veFaX/4MJuZrslefF/7H
	KYOKkJNnwOjOsq/GDzXlRqP4/Xn76mutNv3Q6wG6vtVUsAn8cIKCd27kN49ZUWRf7USLNUqfZ4E
	ZKFJGGlabFmAApdAg6k/UsSi2tlJAcvs82Y7ejqSotdpk5otr5dQhJpJOs4hz81p70yHi+uB/zZ
	MJ9T4T7GgT0fAbl3JjIrURX83vkn0EpAGcu3QSIuMRRjiQA0aV58NIw8esDNlR6eX8XNqPoA==
X-Received: by 2002:a05:600c:4e0f:b0:47d:4fbe:e6cc with SMTP id 5b1f17b1804b1-47ee32fc6f7mr35528635e9.13.1768400236418;
        Wed, 14 Jan 2026 06:17:16 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee57a2613sm29595445e9.6.2026.01.14.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:17:15 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 14 Jan 2026 14:16:33 +0000
Subject: [PATCH 5/8] thermal: samsung: Add support for GS101 TMU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-acpm-tmu-v1-5-cfe56d93e90f@linaro.org>
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
In-Reply-To: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768400224; l=19726;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=ycpTTuEHw1ktY5WMh2z4gJLM2jmFjBFEmH6MdKsS1So=;
 b=eED9yiRauzhGXIgeGdYP5CwjdKHFDJEMMA2jDrY3zoMHdeoGBrrHvA2fJnMVrzxv0icVFiP08
 E4szHaZjxIhBFGBoK34KNK6iumTx+q0/C0Bs40VtYBaHp9BEPIjgYf6
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the thermal driver for the Google GS101 SoC.

The GS101 TMU architecture involves a split responsibility between the
kernel and the Alive Core and Power Manager (ACPM) firmware. The kernel
is responsible for mapping the interrupt pending registers via syscon
to identify thermal events, while the firmware handles sensor configuration,
threshold setting, and interrupt acknowledgment via the ACPM protocol.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/Kconfig    |  16 +
 drivers/thermal/samsung/Makefile   |   2 +
 drivers/thermal/samsung/acpm-tmu.c | 638 +++++++++++++++++++++++++++++++++++++
 3 files changed, 656 insertions(+)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index f4eff5a41a84ce02b12abb85d6a0f8818031d0dc..dfe1c19e982f407e6d8acd65958ee39d671c6924 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -9,3 +9,19 @@ config EXYNOS_THERMAL
 	  the TMU, reports temperature and handles cooling action if defined.
 	  This driver uses the Exynos core thermal APIs and TMU configuration
 	  data from the supported SoCs.
+
+config EXYNOS_ACPM_THERMAL
+	tristate "Exynos ACPM thermal management unit driver"
+	depends on THERMAL_OF
+	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)
+	help
+	  Support for the Thermal Management Unit (TMU) on Google GS101 SoC.
+
+	  The TMU on GS101 is managed by the Alive Clock and Power Manager
+	  (ACPM) firmware. This driver handles the kernel-side interaction,
+	  including reading interrupt status registers via syscon and
+	  communicating with the firmware via the ACPM protocol for
+	  configuration and thermal events.
+
+	  Select this if you want to monitor device temperature and enable
+	  thermal mitigation on GS101 based devices.
diff --git a/drivers/thermal/samsung/Makefile b/drivers/thermal/samsung/Makefile
index f139407150d26940fc9ffcf000505cea4866223f..daed80647c349ba4f937ed8fbe6be9df06c34aac 100644
--- a/drivers/thermal/samsung/Makefile
+++ b/drivers/thermal/samsung/Makefile
@@ -4,3 +4,5 @@
 #
 obj-$(CONFIG_EXYNOS_THERMAL)			+= exynos_thermal.o
 exynos_thermal-y				:= exynos_tmu.o
+obj-$(CONFIG_EXYNOS_ACPM_THERMAL)		+= exynos_acpm_thermal.o
+exynos_acpm_thermal-y				:= acpm-tmu.o
diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
new file mode 100644
index 0000000000000000000000000000000000000000..f6ae4c7815421e684d4ea7ac7a486a9968292324
--- /dev/null
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2019 Samsung Electronics Co., Ltd.
+ * Copyright 2025 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#include "../thermal_hwmon.h"
+
+#define EXYNOS_TMU_SENSOR(i)		BIT(i)
+#define EXYNOS_TMU_SENSORS_MAX_COUNT	16
+
+#define GS101_CPUCL2_SENSOR_MASK (EXYNOS_TMU_SENSOR(0) |	\
+				  EXYNOS_TMU_SENSOR(6) |	\
+				  EXYNOS_TMU_SENSOR(7) |	\
+				  EXYNOS_TMU_SENSOR(8) |	\
+				  EXYNOS_TMU_SENSOR(9))
+#define GS101_CPUCL1_SENSOR_MASK (EXYNOS_TMU_SENSOR(4) |	\
+				  EXYNOS_TMU_SENSOR(5))
+#define GS101_CPUCL0_SENSOR_MASK (EXYNOS_TMU_SENSOR(1) |	\
+				  EXYNOS_TMU_SENSOR(2))
+
+#define GS101_REG_INTPEND(i)		((i) * 0x50 + 0xf8)
+
+enum {
+	P0_INTPEND,
+	P1_INTPEND,
+	P2_INTPEND,
+	P3_INTPEND,
+	P4_INTPEND,
+	P5_INTPEND,
+	P6_INTPEND,
+	P7_INTPEND,
+	P8_INTPEND,
+	P9_INTPEND,
+	P10_INTPEND,
+	P11_INTPEND,
+	P12_INTPEND,
+	P13_INTPEND,
+	P14_INTPEND,
+	P15_INTPEND,
+	REG_INTPEND_COUNT,
+};
+
+struct acpm_tmu_sensor_group {
+	u16 mask;
+	u8 id;
+};
+
+struct acpm_tmu_sensor {
+	const struct acpm_tmu_sensor_group *group;
+	struct thermal_zone_device *tzd;
+	struct acpm_tmu_priv *priv;
+	struct mutex lock; /* protects sensor state */
+	bool enabled;
+};
+
+struct acpm_tmu_priv {
+	struct regmap_field *regmap_fields[REG_INTPEND_COUNT];
+	const struct acpm_handle *handle;
+	struct device *dev;
+	struct clk *clk;
+	unsigned int mbox_chan_id;
+	unsigned int num_sensors;
+	int irq;
+	struct acpm_tmu_sensor sensors[] __counted_by(num_sensors);
+};
+
+struct acpm_tmu_driver_data {
+	const struct reg_field *syscon_reg_fields;
+	const struct acpm_tmu_sensor_group *sensor_groups;
+	unsigned int num_sensor_groups;
+	unsigned int mbox_chan_id;
+};
+
+struct acpm_tmu_initialize_tripwalkdata {
+	unsigned char threshold[8];
+	unsigned char hysteresis[8];
+	unsigned char inten;
+	int i;
+};
+
+struct acpm_tmu_trip_temp_tripwalkdata {
+	const struct thermal_trip *trip;
+	unsigned char threshold[8];
+	int temperature;
+	int i;
+};
+
+#define ACPM_TMU_SENSOR_GROUP(_mask, _id)		\
+	{					\
+		.mask	= _mask,		\
+		.id	= _id,			\
+	}
+
+static const struct acpm_tmu_sensor_group gs101_sensor_groups[] = {
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL2_SENSOR_MASK, 0),
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL1_SENSOR_MASK, 1),
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL0_SENSOR_MASK, 2),
+};
+
+static const struct reg_field gs101_syscon_tmu_reg_fields[REG_INTPEND_COUNT] = {
+	[P0_INTPEND] = REG_FIELD(GS101_REG_INTPEND(0), 0, 31),
+	[P1_INTPEND] = REG_FIELD(GS101_REG_INTPEND(1), 0, 31),
+	[P2_INTPEND] = REG_FIELD(GS101_REG_INTPEND(2), 0, 31),
+	[P3_INTPEND] = REG_FIELD(GS101_REG_INTPEND(3), 0, 31),
+	[P4_INTPEND] = REG_FIELD(GS101_REG_INTPEND(4), 0, 31),
+	[P5_INTPEND] = REG_FIELD(GS101_REG_INTPEND(5), 0, 31),
+	[P6_INTPEND] = REG_FIELD(GS101_REG_INTPEND(6), 0, 31),
+	[P7_INTPEND] = REG_FIELD(GS101_REG_INTPEND(7), 0, 31),
+	[P8_INTPEND] = REG_FIELD(GS101_REG_INTPEND(8), 0, 31),
+	[P9_INTPEND] = REG_FIELD(GS101_REG_INTPEND(9), 0, 31),
+	[P10_INTPEND] = REG_FIELD(GS101_REG_INTPEND(10), 0, 31),
+	[P11_INTPEND] = REG_FIELD(GS101_REG_INTPEND(11), 0, 31),
+	[P12_INTPEND] = REG_FIELD(GS101_REG_INTPEND(12), 0, 31),
+	[P13_INTPEND] = REG_FIELD(GS101_REG_INTPEND(13), 0, 31),
+	[P14_INTPEND] = REG_FIELD(GS101_REG_INTPEND(14), 0, 31),
+	[P15_INTPEND] = REG_FIELD(GS101_REG_INTPEND(15), 0, 31),
+};
+
+static const struct acpm_tmu_driver_data acpm_tmu_gs101 = {
+	.syscon_reg_fields = gs101_syscon_tmu_reg_fields,
+	.sensor_groups = gs101_sensor_groups,
+	.num_sensor_groups = ARRAY_SIZE(gs101_sensor_groups),
+	.mbox_chan_id = 9,
+};
+
+static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor *sensor, bool on)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	const struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops.tmu;
+	int ret;
+
+	ret = ops->tz_control(handle, priv->mbox_chan_id, sensor->group->id,
+			      on);
+	if (ret)
+		return ret;
+
+	sensor->enabled = on;
+
+	return 0;
+}
+
+static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on)
+{
+	struct device *dev = priv->dev;
+	int i, ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+
+		/* Skip sensors that weren't found in DT */
+		if (!sensor->tzd)
+			continue;
+
+		scoped_guard(mutex, &sensor->lock) {
+			ret = acpm_tmu_op_tz_control(sensor, on);
+		}
+
+		if (ret)
+			goto out;
+	}
+
+out:
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	struct acpm_tmu_priv *priv = sensor->priv;
+	const struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops.tmu;
+	struct device *dev = priv->dev;
+	int acpm_temp, ret;
+
+	if (!sensor->enabled)
+		return -EAGAIN;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	scoped_guard(mutex, &sensor->lock) {
+		ret = ops->read_temp(handle, priv->mbox_chan_id,
+				     sensor->group->id, &acpm_temp);
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	if (ret)
+		return ret;
+
+	*temp = acpm_temp * MILLIDEGREE_PER_DEGREE;
+
+	return 0;
+}
+
+static int acpm_tmu_trip_temp_walk_cb(struct thermal_trip *trip, void *data)
+{
+	struct acpm_tmu_trip_temp_tripwalkdata * const twd = data;
+	int temperature;
+
+	if (twd->i >= ARRAY_SIZE(twd->threshold))
+		return -ERANGE;
+
+	if (trip->type == THERMAL_TRIP_PASSIVE)
+		goto out;
+
+	temperature = (trip == twd->trip) ? twd->temperature : trip->temperature;
+
+	twd->threshold[twd->i] = temperature / MILLIDEGREE_PER_DEGREE;
+
+out:
+	++twd->i;
+	return 0;
+}
+
+static int acpm_tmu_set_trip_temp(struct thermal_zone_device *tz,
+			const struct thermal_trip *trip, int temperature)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	struct acpm_tmu_priv *priv = sensor->priv;
+	const struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops.tmu;
+	struct device *dev = priv->dev;
+	struct acpm_tmu_trip_temp_tripwalkdata twd = {
+		.trip = trip,
+		.temperature = temperature,
+	};
+	int ret;
+
+	if (trip->type == THERMAL_TRIP_PASSIVE)
+		return 0;
+
+	for_each_thermal_trip(tz, acpm_tmu_trip_temp_walk_cb, &twd);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&sensor->lock);
+
+	if (!sensor->enabled) {
+		ret = ops->set_threshold(handle, priv->mbox_chan_id,
+					 sensor->group->id, twd.threshold,
+					 ARRAY_SIZE(twd.threshold));
+		goto out;
+	}
+
+	ret = acpm_tmu_op_tz_control(sensor, false);
+	if (ret)
+		goto out;
+
+	ret = ops->set_threshold(handle, priv->mbox_chan_id, sensor->group->id,
+				 twd.threshold, ARRAY_SIZE(twd.threshold));
+	if (ret)
+		goto out;
+
+	ret = acpm_tmu_op_tz_control(sensor, true);
+
+out:
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static const struct thermal_zone_device_ops acpm_tmu_sensor_ops = {
+	.get_temp = acpm_tmu_get_temp,
+	.set_trip_temp = acpm_tmu_set_trip_temp,
+};
+
+static int acpm_tmu_has_pending_irq(struct acpm_tmu_sensor *sensor,
+				    bool *pending_irq)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	unsigned long mask = sensor->group->mask;
+	int i, ret;
+	u32 val;
+
+	guard(mutex)(&sensor->lock);
+
+	for_each_set_bit(i, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
+		ret = regmap_field_read(priv->regmap_fields[i], &val);
+		if (ret)
+			return ret;
+
+		if (val) {
+			*pending_irq = true;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t acpm_tmu_thread_fn(int irq, void *id)
+{
+	struct acpm_tmu_priv *priv = id;
+	const struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops.tmu;
+	struct device *dev = priv->dev;
+	int i, ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(dev, "Failed to resume: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+		bool pending_irq = false;
+
+		if (!sensor->tzd)
+			continue;
+
+		ret = acpm_tmu_has_pending_irq(sensor, &pending_irq);
+		if (ret || !pending_irq)
+			continue;
+
+		thermal_zone_device_update(sensor->tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
+
+		scoped_guard(mutex, &sensor->lock) {
+			ret = ops->clear_tz_irq(handle, priv->mbox_chan_id,
+						sensor->group->id);
+			if (ret)
+				dev_err(priv->dev, "Sensor %d: failed to clear IRQ (%d)\n",
+					i, ret);
+		}
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return IRQ_HANDLED;
+}
+
+static int acpm_tmu_init_sensor(struct acpm_tmu_sensor *sensor,
+			const struct acpm_tmu_initialize_tripwalkdata *twd)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	const struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops.tmu;
+	unsigned int mbox_chan_id = priv->mbox_chan_id;
+	u8 acpm_sensor_id = sensor->group->id;
+	int ret;
+
+	guard(mutex)(&sensor->lock);
+
+	ret = ops->set_threshold(handle, mbox_chan_id, acpm_sensor_id,
+				 twd->threshold,
+				 ARRAY_SIZE(twd->threshold));
+	if (ret)
+		return ret;
+
+	ret = ops->set_hysteresis(handle, mbox_chan_id, acpm_sensor_id,
+				  twd->hysteresis,
+				  ARRAY_SIZE(twd->threshold));
+	if (ret)
+		return ret;
+
+	ret = ops->set_interrupt_enable(handle, mbox_chan_id, acpm_sensor_id,
+					twd->inten);
+	return ret;
+}
+
+static int acpm_tmu_initialize_walk_cb(struct thermal_trip *trip, void *data)
+{
+	struct acpm_tmu_initialize_tripwalkdata * const twd = data;
+	int i;
+
+	if (twd->i >= ARRAY_SIZE(twd->threshold))
+		return -ERANGE;
+
+	if (trip->type == THERMAL_TRIP_PASSIVE)
+		goto out;
+
+	i = twd->i;
+
+	twd->threshold[i] = trip->temperature / MILLIDEGREE_PER_DEGREE;
+	twd->hysteresis[i] = trip->hysteresis / MILLIDEGREE_PER_DEGREE;
+
+	twd->inten |= BIT(i);
+
+out:
+	++twd->i;
+	return 0;
+}
+
+static int acpm_tmu_init_sensors(struct acpm_tmu_priv *priv)
+{
+	int i, ret;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+		struct acpm_tmu_initialize_tripwalkdata twd = {};
+
+		/* Skip sensors that weren't found in DT */
+		if (!sensor->tzd)
+			continue;
+
+		thermal_zone_for_each_trip(sensor->tzd,
+					   acpm_tmu_initialize_walk_cb, &twd);
+
+		ret = acpm_tmu_init_sensor(sensor, &twd);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id acpm_tmu_match[] = {
+	{ .compatible = "google,gs101-tmu-top", .data = &acpm_tmu_gs101 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, acpm_tmu_match);
+
+static int acpm_tmu_probe(struct platform_device *pdev)
+{
+	const struct acpm_tmu_driver_data *data;
+	const struct acpm_handle *acpm_handle;
+	struct device *dev = &pdev->dev;
+	struct acpm_tmu_priv *priv;
+	struct regmap *regmap;
+	int i, ret;
+
+	acpm_handle = devm_acpm_get_by_node(dev, dev->parent->of_node);
+	if (IS_ERR(acpm_handle))
+		return dev_err_probe(dev, PTR_ERR(acpm_handle),
+				     "Failed to get ACPM handle\n");
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to get match data\n");
+
+	priv = devm_kzalloc(dev,
+			    struct_size(priv, sensors, data->num_sensor_groups),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->handle = acpm_handle;
+	priv->mbox_chan_id = data->mbox_chan_id;
+	priv->num_sensors = data->num_sensor_groups;
+
+	platform_set_drvdata(pdev, priv);
+
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Unable to map syscon\n");
+
+	ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->regmap_fields,
+					   data->syscon_reg_fields,
+					   REG_INTPEND_COUNT);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to map syscon registers\n");
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Failed to get the clock\n");
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return dev_err_probe(dev, priv->irq, "Failed to get irq\n");
+
+	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
+					acpm_tmu_thread_fn, IRQF_ONESHOT,
+					dev_name(dev), priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 100);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to resume device\n");
+
+	ret = acpm_handle->ops.tmu.init(acpm_handle, priv->mbox_chan_id);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to init TMU\n");
+		goto err_pm_put;
+	}
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+
+		mutex_init(&sensor->lock);
+		sensor->group = &data->sensor_groups[i];
+		sensor->priv = priv;
+
+		sensor->tzd = devm_thermal_of_zone_register(dev, i, sensor,
+							    &acpm_tmu_sensor_ops);
+		if (IS_ERR(sensor->tzd)) {
+			ret = PTR_ERR(sensor->tzd);
+			if (ret == -ENODEV) {
+				sensor->tzd = NULL;
+				dev_dbg(dev, "Sensor %d not used in DT, skipping\n", i);
+				continue;
+			}
+
+			ret = dev_err_probe(dev, ret, "Failed to register sensor %d\n", i);
+			goto err_pm_put;
+		}
+
+		ret = devm_thermal_add_hwmon_sysfs(dev, sensor->tzd);
+		if (ret)
+			dev_warn(dev, "Failed to add hwmon sysfs!\n");
+	}
+
+	ret = acpm_tmu_init_sensors(priv);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to init sensors\n");
+		goto err_pm_put;
+	}
+
+	ret = acpm_tmu_control(priv, true);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to enable TMU\n");
+		goto err_pm_put;
+	}
+
+	pm_runtime_put_autosuspend(&pdev->dev);
+
+	return 0;
+
+err_pm_put:
+	pm_runtime_put_sync(dev);
+	return ret;
+}
+
+static void acpm_tmu_remove(struct platform_device *pdev)
+{
+	struct acpm_tmu_priv *priv = platform_get_drvdata(pdev);
+
+	/* Stop IRQ first to prevent race with thread_fn */
+	disable_irq(priv->irq);
+
+	acpm_tmu_control(priv, false);
+}
+
+static int acpm_tmu_suspend(struct device *dev)
+{
+	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
+	const struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops.tmu;
+	int ret;
+
+	ret = acpm_tmu_control(priv, false);
+	if (ret)
+		return ret;
+
+	/* APB clock not required for this specific msg */
+	return ops->suspend(handle, priv->mbox_chan_id);
+}
+
+static int acpm_tmu_resume(struct device *dev)
+{
+	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
+	const struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops.tmu;
+	int ret;
+
+	/* APB clock not required for this specific msg */
+	ret = ops->resume(handle, priv->mbox_chan_id);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_control(priv, true);
+}
+
+static int acpm_tmu_runtime_suspend(struct device *dev)
+{
+	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int acpm_tmu_runtime_resume(struct device *dev)
+{
+	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(priv->clk);
+}
+
+static const struct dev_pm_ops acpm_tmu_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(acpm_tmu_suspend, acpm_tmu_resume)
+	RUNTIME_PM_OPS(acpm_tmu_runtime_suspend, acpm_tmu_runtime_resume, NULL)
+};
+
+static struct platform_driver acpm_tmu_driver = {
+	.driver = {
+		.name   = "gs-tmu",
+		.pm     = pm_ptr(&acpm_tmu_pm_ops),
+		.of_match_table = acpm_tmu_match,
+	},
+	.probe = acpm_tmu_probe,
+	.remove = acpm_tmu_remove,
+};
+module_platform_driver(acpm_tmu_driver);
+
+MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@linaro.org>");
+MODULE_DESCRIPTION("Samsung Exynos ACPM TMU Driver");
+MODULE_LICENSE("GPL");

-- 
2.52.0.457.g6b5491de43-goog


