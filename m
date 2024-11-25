Return-Path: <linux-pm+bounces-18085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89219D8A3B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB3BB3576B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0E1B21A6;
	Mon, 25 Nov 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBF6mGkS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8C1B0F06;
	Mon, 25 Nov 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546970; cv=none; b=D+LYgygdcDokJDmvzNz4SzkTTLfZwis/zqmMq8fH31X1e2F4BjKLCdPwrB8Y34lURMPzz8W/bQeAhLQiXbrvCav4D2nJRl4g8O+Pfnd3FFjlplCtoRQ/yIN2YDkJYsheIY6CRM8OwNPfnB3GfkykuR1PzWvtGAxXKcE/dTIMsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546970; c=relaxed/simple;
	bh=+LM1rK7vah20uAIPBx8x5WKF8QEsH0r7kgg/8Vz0UYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeftSjdxbYbKP/07E1h084W+ZFuppB3KKbaFy+n5oqagjxCxDHRnteIRgUCqb9suj9ni0IM4BsP47AfYhRbf2sD1Oi40LUhnyufzegplCjR6agrrxXjrz5bWvVaCMhVPNfH/QUE+XePFw1csSpWALPFNb2Xyf1LCufuOfDO6NCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBF6mGkS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314f38d274so57547205e9.1;
        Mon, 25 Nov 2024 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732546966; x=1733151766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YacDjwA3Pzwa/6jHmzMbauERh855QymnQOy/p7bYdAY=;
        b=CBF6mGkS+9JrTTzdvDE2XTwR8PKV9/9dU90jM1KF7TVL/ujyIR7I1FB//vXPjY4D6Q
         AGIXqsdt/NmfYJkmYISgSZkc2nrsM2T7zt349COm7SLStC19cHIzDsbQ9Uzd88/Z+RTs
         6870BkFUIlwBMWIO1U6nUutmxMcaNvLi1lVFxs5XmGQaYIO24plfw5W9RCy8t7C73SWg
         9Q5gX3Ht0n+kH9bAu9jsq+MEqQW2efZqREl7iV7pdEwRBRtx0XY1FlkeB8fETR3y04SH
         y+h3k9+FXsBjztXQMF14sjPNw/es5qwbS8+GQNiX4qhL08XjRWblIlLLE85GCyin35Ee
         cFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546966; x=1733151766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YacDjwA3Pzwa/6jHmzMbauERh855QymnQOy/p7bYdAY=;
        b=e8Itjuakw10kns/EO3BhHr9jrbtZ6Lj9knvyJSd3cnDdEvbW4ZglTvxHvOVqbvkzPr
         gQtnaYsKWHysa0Et/HhrDSURga2jkM2/UeFuyVs5dNkAL8VhUxExj09QSKFY4h0m19Ea
         AWNztkWLgiMgQUGJ76O0rQn5HaxX5vGvVEmKgXDAKl/GY5jUFvm4z/iFyG5Wn9OEZOBd
         TQO3MLMLW+brWsriDR5DxnfmYTHHjJSTmYaave0AjsST9THPDiPDVGQFZolaxa9aYXrB
         nwxDUG7CBuMUwD4hFHZTMd/yxgC5QCqXIX2zw4pMj9TGsg36aNpt+J89T625zlcppDQX
         BMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYU3SVuCCzyp0LzrNhkkBjjKfJ8Iyz2wT6XSqxf49R3N5drRI5qhnOfz0wY8hdNZS/nDyv2XRpvFTOEWQ=@vger.kernel.org, AJvYcCWGR5pLvx8s8VriSmwakZ1VptJBUDt4MW9dCALygxNHTuKTUjdxHZmAO7Hvfo1PUOoxFLGM0/2IDKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywaVYLija7JMZMad7cmG3USVRXoGo/z4bNFgsFzgVgr6tilgLp
	zONbva5+FvU9mEUWFI76DU24QM5jDtJYkfPlOjU+0IrzmpR8UZaU
X-Gm-Gg: ASbGnctFcJpYLeH+uDg1liPMwwpSwAIUXKtJlSMEmiT/xjF7fkYh/+tC3W7k2NripiC
	TnUahY2VG1knRRW9rakhICuaCiw6NUH8GrCYL8+KYHxF/hAtZHK4/itk3RQTNVbkXlXe1TwAdNG
	2Wjys3Y6uBYXSawmL14HYm9/vGx5U2fRqCv+WjC0rcV8hF+mJCpk4eLfzoYda690aCf7GxhPfB7
	QLeRvm3qECn9AmwHvOmhoycBkYM6knv8iySLEA/Y8yS71Z+XXZcF4foWyoOeyb03ePVz5AlIEML
	jWu7VcovzqGiwpal/xE=
X-Google-Smtp-Source: AGHT+IGAW0t2ZrdBcqdUgNKM+2F6avTAZtGexAj6xXX8ALGw523Q2ou+1d0XnbHJldgeYgGhv/UGzQ==
X-Received: by 2002:a05:600c:5250:b0:431:5465:8072 with SMTP id 5b1f17b1804b1-433ce4ae351mr156896005e9.31.1732546951164;
        Mon, 25 Nov 2024 07:02:31 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43494a0ad65sm77776405e9.26.2024.11.25.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:02:30 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 2/2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Date: Mon, 25 Nov 2024 16:01:12 +0100
Message-ID: <20241125150200.714-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125150200.714-1-ansuelsmth@gmail.com>
References: <20241125150200.714-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple CPU Freq driver for Airoha EN7581 SoC that control CPU
frequency scaling with SMC APIs and register a generic "cpufreq-dt"
device.

All CPU share the same frequency and can't be controlled independently.
Current shared CPU frequency is returned by the related SMC command.

Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
driver is needed with OPP v2 nodes declared in DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Adapt to new cpufreq-dt APIs
- Register cpufreq-dt instead of custom freq driver
Changes v2:
- Fix kernel bot error with missing slab.h and bitfield.h header
- Limit COMPILE_TEST to ARM64 due to smcc 1.2

 drivers/cpufreq/Kconfig.arm          |   8 +++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/airoha-cpufreq.c     | 103 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 114 insertions(+)
 create mode 100644 drivers/cpufreq/airoha-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5f7e13e60c80..338fc54276f2 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -15,6 +15,14 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun50i-cpufreq-nvmem.
 
+config ARM_AIROHA_SOC_CPUFREQ
+	tristate "Airoha EN7581 SoC CPUFreq support"
+	depends on ARCH_AIROHA || (COMPILE_TEST && ARM64)
+	select PM_OPP
+	default ARCH_AIROHA
+	help
+	  This adds the CPUFreq driver for Airoha EN7581 SoCs.
+
 config ARM_APPLE_SOC_CPUFREQ
 	tristate "Apple Silicon SoC CPUFreq support"
 	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 0f184031dd12..8e5a37a95d36 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_AIROHA_SOC_CPUFREQ)	+= airoha-cpufreq.o
 obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
new file mode 100644
index 000000000000..52d863a7363a
--- /dev/null
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "cpufreq-dt.h"
+
+#define AIROHA_SIP_AVS_HANDLE			0x82000301
+#define AIROHA_AVS_OP_BASE			0xddddddd0
+#define AIROHA_AVS_OP_MASK			GENMASK(1, 0)
+#define AIROHA_AVS_OP_FREQ_DYN_ADJ		(AIROHA_AVS_OP_BASE | \
+						 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x1))
+#define AIROHA_AVS_OP_GET_FREQ			(AIROHA_AVS_OP_BASE | \
+						 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x2))
+
+struct airoha_cpufreq_state {
+	struct platform_device *cpufreq_dt;
+};
+
+static struct airoha_cpufreq_state *airoha_cpufreq_state;
+
+static unsigned int airoha_cpufreq_get(unsigned int cpu)
+{
+	const struct arm_smccc_1_2_regs args = {
+		.a0 = AIROHA_SIP_AVS_HANDLE,
+		.a1 = AIROHA_AVS_OP_GET_FREQ,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_smc(&args, &res);
+
+	return (int)(res.a0 * 1000);
+}
+
+static int airoha_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	const struct arm_smccc_1_2_regs args = {
+		.a0 = AIROHA_SIP_AVS_HANDLE,
+		.a1 = AIROHA_AVS_OP_FREQ_DYN_ADJ,
+		.a3 = index,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_smc(&args, &res);
+
+	/* SMC signal correct apply by unsetting BIT 0 */
+	return res.a0 & BIT(0) ? -EINVAL : 0;
+}
+
+static int __init airoha_cpufreq_driver_init(void)
+{
+	struct cpufreq_dt_platform_data pdata = { };
+	struct platform_device *cpufreq_dt;
+	struct device *cpu_dev;
+	int ret;
+
+	if (!of_machine_is_compatible("airoha,en7581"))
+		return -ENODEV;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		dev_err(cpu_dev, "Cannot get CPU\n");
+		return -ENODEV;
+	}
+
+	airoha_cpufreq_state = kzalloc(sizeof(*airoha_cpufreq_state), GFP_KERNEL);
+	if (!airoha_cpufreq_state)
+		return -ENOMEM;
+
+	pdata.no_cpu_clk = true;
+	pdata.target_index = airoha_cpufreq_set_target;
+	pdata.get = airoha_cpufreq_get;
+
+	cpufreq_dt = platform_device_register_data(NULL, "cpufreq-dt", -1, &pdata,
+						   sizeof(pdata));
+	ret = PTR_ERR_OR_ZERO(cpufreq_dt);
+	if (ret) {
+		dev_err(cpu_dev,
+			"failed to create cpufreq-dt device: %d\n", ret);
+		kfree(airoha_cpufreq_state);
+		return ret;
+	}
+
+	airoha_cpufreq_state->cpufreq_dt = cpufreq_dt;
+
+	return 0;
+}
+late_initcall(airoha_cpufreq_driver_init);
+
+static void __exit airoha_cpufreq_driver_remove(void)
+{
+	platform_device_unregister(airoha_cpufreq_state->cpufreq_dt);
+	kfree(airoha_cpufreq_state);
+}
+module_exit(airoha_cpufreq_driver_remove);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("CPUfreq driver for Airoha SoCs");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 18942bfe9c95..5ecd8234bfac 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,8 @@ static const struct of_device_id allowlist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blocklist[] __initconst = {
+	{ .compatible = "airoha,en7581", },
+
 	{ .compatible = "allwinner,sun50i-h6", },
 	{ .compatible = "allwinner,sun50i-h616", },
 	{ .compatible = "allwinner,sun50i-h618", },
-- 
2.45.2


