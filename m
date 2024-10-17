Return-Path: <linux-pm+bounces-15903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30299A2D53
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 21:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D0C1F2860E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535D21BAFB;
	Thu, 17 Oct 2024 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyrgnER7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159061E0DC3;
	Thu, 17 Oct 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192125; cv=none; b=EfFOpDegz0WgvQvtQkVtIsasVF2dNbmocUZB+/nBWXKuiLJdBr3MeOIZzfRJWGT9FUMCKIJeYVXgVIeRS8xHOVrRUOKxslraNQ1BMkGI9xHKr2s9uIXjmkAJTutnnF/M/0Gj0fugBY33sNj5U57SArSYuY4DSxjf0yKT/2kw+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192125; c=relaxed/simple;
	bh=OGIEndB9wShg9BStQXMdBRJ7aaSCXzA/2FCTr3qyVEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6ij0FVVyPPFpZLGiuHaROpkJIV1ntzNtzuImF0/tN4hy9rN4dOTHxpBvIag1h2OXfGS5hANwrpB87xU8U/zvzPVw8x5hxPsFZqnPHwEr0ufFq9GoDemOxQSIfYII28ZLJO2TO5Yz2X7zhjGgVZGEJkCAWZowPkytfeXd8z0mlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyrgnER7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315baec69eso9088385e9.2;
        Thu, 17 Oct 2024 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729192122; x=1729796922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Da4xfni/iRqV29H1FugSQneULVwbsYh57qiyb47G3eQ=;
        b=RyrgnER73kklk+3cReUYi7Ctd9hrA68M0yJCFsqUotPp79scFBvdePujcJii5+w31d
         dM4QnNbLByPYtjzp73+HpZ44Cc6+7JFORoOOZciiwVfiaJMrM6E1lm7Mu6NDHNZROT8r
         m4h8a1Nh5UfoEvZaAZ4aXIwnXPRbJA3o7c4FanLChtChgKBPfmoEGJRVVL3yN2KtwtIY
         P0upwFzfL/IPjskZFjodyy+QC4F4HmcPVtcbaq/GdI/0zODT3+O53ESC067YF+t7Q5Nj
         hHC06v8fhxRVQMMRx0VNmTFO8uzy8PiR4Vj1dulyUzeJJLXPXoNgBT/NM2v1HDXWbH1I
         4mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192122; x=1729796922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Da4xfni/iRqV29H1FugSQneULVwbsYh57qiyb47G3eQ=;
        b=YpzC0HqpEvhTZr6d+bi5Sbpq8QaLPqMYhAzRDTofXMfmpOzHU/+1ZJ9cGDXLt2Dv+a
         268jZRj1GnUt5BmowcIJ3MVajR6SImCejwpqOsgPWENG+XPi01NlHH+eqx2DzTTzrQfA
         cp8sCo8FK0AiiyqyVxuVUCvTRvgE2aXg8KhMG27TDBtec7roEJcoVXQXRj/uTO4hli4d
         6BbfBWv7hv0By6EDtNusQFBpeW1EQU9Xd/BBvQThmpDa33u7CmkqLhqPbyLPyHxpKf96
         Nh3q1n9VVc8UO7h5O7eUOievjp7S5injm304bpdF37JVRqeSHEsZyO7nFucH9wY9g6Gy
         FKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6DD3fC674FkmdiDNc4IFEHhwZVIulCzKe9z4OkGXgKHKNDbJxTB7mHHnN2NFHCKxc1tgaThUe2t0=@vger.kernel.org, AJvYcCXgiWbYHvdSFts2tP6nfL6MK5OyxHuBIaJ9VB3rU0an1iHdGCzWCpdiB1j/I95WQ5AK3xZbbM4gXUaZyqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqL2qXT/NUa4ycPE44QoeIPIowW7NTSerj5ntrMrB/V8goWrfG
	s4WC1GYEp30+cZ4l+1urT1F9DffvpdFVR0pjVcR9JHgp1YHPniIK
X-Google-Smtp-Source: AGHT+IGCE6QJnDZjgbHzy+3T/i4OVG/RXpdVfSj/U8JdIeLQ+Tpp+F0D4gJT7lqUBM/+GtdPOaS33w==
X-Received: by 2002:a05:600c:5023:b0:431:542d:2592 with SMTP id 5b1f17b1804b1-431542d2d1fmr42046435e9.27.1729192121917;
        Thu, 17 Oct 2024 12:08:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d7fc27ed9sm8035311f8f.97.2024.10.17.12.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:08:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Date: Thu, 17 Oct 2024 21:07:49 +0200
Message-ID: <20241017190809.16942-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple Cpufreq driver for Airoha EN7581 SoC that control CPU
frequency scaling with SMC APIs.

All CPU share the same frequency and can't be controlled independently.
Current shared CPU frequency is returned by the related SMC command.

Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
driver is needed with OPP v2 nodes declared in DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Fix kernel bot error with missing slab.h and bitfield.h header
- Limit COMPILE_TEST to ARM64 due to smcc 1.2

 drivers/cpufreq/Kconfig.arm          |   8 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/airoha-cpufreq.c     | 183 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 194 insertions(+)
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
index 000000000000..f8bbc142837c
--- /dev/null
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitfield.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/arm-smccc.h>
+
+#define AIROHA_SIP_AVS_HANDLE			0x82000301
+#define AIROHA_AVS_OP_BASE			0xddddddd0
+#define AIROHA_AVS_OP_MASK			GENMASK(1, 0)
+#define AIROHA_AVS_OP_FREQ_DYN_ADJ		(AIROHA_AVS_OP_BASE | \
+						 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x1))
+#define AIROHA_AVS_OP_GET_FREQ			(AIROHA_AVS_OP_BASE | \
+						 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x2))
+
+struct airoha_cpufreq_priv {
+	struct list_head list;
+
+	cpumask_var_t cpus;
+	struct device *cpu_dev;
+	struct cpufreq_frequency_table *freq_table;
+};
+
+static LIST_HEAD(priv_list);
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
+static struct airoha_cpufreq_priv *airoha_cpufreq_find_data(int cpu)
+{
+	struct airoha_cpufreq_priv *priv;
+
+	list_for_each_entry(priv, &priv_list, list) {
+		if (cpumask_test_cpu(cpu, priv->cpus))
+			return priv;
+	}
+
+	return NULL;
+}
+
+static int airoha_cpufreq_init(struct cpufreq_policy *policy)
+{
+	struct airoha_cpufreq_priv *priv;
+
+	priv = airoha_cpufreq_find_data(policy->cpu);
+	if (!priv)
+		return -ENODEV;
+
+	cpumask_copy(policy->cpus, priv->cpus);
+	policy->driver_data = priv;
+	policy->freq_table = priv->freq_table;
+
+	return 0;
+}
+
+static struct cpufreq_driver airoha_cpufreq_driver = {
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+			  CPUFREQ_IS_COOLING_DEV,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= airoha_cpufreq_set_target,
+	.get		= airoha_cpufreq_get,
+	.init		= airoha_cpufreq_init,
+	.attr		= cpufreq_generic_attr,
+	.name		= "airoha-cpufreq",
+};
+
+static int airoha_cpufreq_driver_init_cpu(int cpu)
+{
+	struct airoha_cpufreq_priv *priv;
+	struct device *cpu_dev;
+	int ret;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return -EPROBE_DEFER;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_set_cpu(cpu, priv->cpus);
+	priv->cpu_dev = cpu_dev;
+
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, priv->cpus);
+	if (ret)
+		goto err;
+
+	ret = dev_pm_opp_of_cpumask_add_table(priv->cpus);
+	if (ret)
+		goto err;
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &priv->freq_table);
+	if (ret)
+		goto err;
+
+	list_add(&priv->list, &priv_list);
+
+	return 0;
+
+err:
+	dev_pm_opp_of_cpumask_remove_table(priv->cpus);
+	free_cpumask_var(priv->cpus);
+
+	return ret;
+}
+
+static void airoha_cpufreq_release(void)
+{
+	struct airoha_cpufreq_priv *priv, *tmp;
+
+	list_for_each_entry_safe(priv, tmp, &priv_list, list) {
+		dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
+		dev_pm_opp_of_cpumask_remove_table(priv->cpus);
+		free_cpumask_var(priv->cpus);
+		list_del(&priv->list);
+		kfree(priv);
+	}
+}
+
+static int __init airoha_cpufreq_driver_probe(void)
+{
+	int cpu, ret;
+
+	if (!of_machine_is_compatible("airoha,en7581"))
+		return -ENODEV;
+
+	for_each_possible_cpu(cpu) {
+		ret = airoha_cpufreq_driver_init_cpu(cpu);
+		if (ret)
+			goto err;
+	}
+
+	ret = cpufreq_register_driver(&airoha_cpufreq_driver);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	airoha_cpufreq_release();
+	return ret;
+}
+module_init(airoha_cpufreq_driver_probe);
+
+static void __exit airoha_cpufreq_driver_remove(void)
+{
+	cpufreq_unregister_driver(&airoha_cpufreq_driver);
+	airoha_cpufreq_release();
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


