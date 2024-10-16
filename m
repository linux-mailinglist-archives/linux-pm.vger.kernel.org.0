Return-Path: <linux-pm+bounces-15788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CCE9A0F67
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459BC1C2025F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D920F5D7;
	Wed, 16 Oct 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAhaIuiV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB66208D95;
	Wed, 16 Oct 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095090; cv=none; b=i7mXjaJBH9XWRWbpzfFvIWHWFGRP2scu83OOXjawfVAjkMv5UrkjQj5e/B2wolmjW1ZvqeDOjMPmTndJ7WfbIUZ+jdaVgbCtravftt4/0EchF9/EIUN9avEaROAi0BHv1gXw58nGzV0UmAbiXXM5h0ioXRZNquC3VBFQGwvIX9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095090; c=relaxed/simple;
	bh=GkwoMJPR4Ged0NBe+yNQ6l3TsL4se3UOYjUy0eJJ+is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PU5/Dq1ZW8QIBYJvSVaVrrjAUm7/gCK2R0/XEVfhGaCf6Uv0wJHWmhV4mhjfhMTSOqaSoxCkx9c+SX0OkUwY4dZ8vIoaU2r4M3Y5/+n2bFOTLqDkE2K58OL0EvrLH6ZbFZCk+zSCcDVR6Ri+zABPX4lim3mUw6ZC99U1RfmQK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAhaIuiV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a993a6348e0so499976866b.1;
        Wed, 16 Oct 2024 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729095087; x=1729699887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oTUckH6zOuy9FTfTza0YDv0Ru2Gr+Jvp5+oob2O/eN0=;
        b=OAhaIuiVr4biDzPrOKZKPo77Ac9Z/x2m+4dKAay/gUbur3Xe+uyKxSh5gopESGRe2t
         0eVkhURyMs4JAWFrgD0rqP/SrpQXFfzheLRz2LDIoGwiBy5eZaI0g3dp69lgDOM9J3yz
         iy5MyJMPtum7Gf0s/nW+YItebnu57QvcTaRGJBwk1ILf4NCXj7QnsFrDSU4Uk8aISJAy
         jSx3k3nMro4Xy42SX9a1fEdT4Y4JWp0TEhSD+CNKmo1LAwjIiybHblYUsGxR5/QtHezo
         +FvkOjR2BtgtUpUnmnkunEpBsQh5n1DLhArIinPdZeAjIsqOqiiCv8jk3hwfW7BnP0rA
         4LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729095087; x=1729699887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTUckH6zOuy9FTfTza0YDv0Ru2Gr+Jvp5+oob2O/eN0=;
        b=Px1hNWVEG3e9lWs5A2inh5tR3dMS7K93HA6gXFD3NQc02xfkgkkXviqrwNmU3zwary
         ibe6+/Tu9WEdq3pQK/aNUtYzuI3Q/fut/XzTNFVh9gdfWhOyZBwLMZVK+rM5Aewim/v8
         bU27tiqMJJFh14i1nnX6dYR9ZZKEM4xKDYjOI+Rb79PDXjC5z8H33jtS7nkTfka9G7fa
         CuJlBQU1v0weoqr/y+WWY4APKQL/F653L5Lp8dKdp3CYVrgd8wGo3ccuBRbARbmCjJgF
         nbr0pHtCkENdRAjHwXnU4nkRWuc/+ABdfA2r63Ghpu6/bwQw/7bjv+Lnf91PB9+1j6Ze
         mHXA==
X-Forwarded-Encrypted: i=1; AJvYcCU3j9bzoc3bL3G7uJUDbgUHSC0BDZHfj2Cfa0AoMnblUNFiKIeFDDRutaJYYCYnWWLSKCswLurSw9o=@vger.kernel.org, AJvYcCXSESKHFHltlqR4A/cGQ9OXITIvotyNfUsOx0wJaniz63BbyFFqb36Pt/BT0GnPkGquZgaz7+fNPKYXyBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuo5CWBozzBshb1DFBSHfeS80Yc8OUix2BGDzal2cUetSeHVKg
	2tGwnEgUjQfJt5jbvk6wW0LRSo2PwZvIFKqFWp0KXDaobnqADcOD
X-Google-Smtp-Source: AGHT+IGcWZWpa4Xcog+I37stvatkjqCx3aRmUmCCXT9QP/ovwSe0FBaPVi6YpwpDqjR+m91p0uCtig==
X-Received: by 2002:a05:6402:340a:b0:5c9:288d:d6c3 with SMTP id 4fb4d7f45d1cf-5c95ac63be5mr16722474a12.31.1729095086980;
        Wed, 16 Oct 2024 09:11:26 -0700 (PDT)
Received: from localhost.localdomain ([62.19.118.125])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d6297sm1855691a12.15.2024.10.16.09.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:11:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Date: Wed, 16 Oct 2024 18:10:22 +0200
Message-ID: <20241016161044.28745-1-ansuelsmth@gmail.com>
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
 drivers/cpufreq/Kconfig.arm          |   8 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/airoha-cpufreq.c     | 183 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 194 insertions(+)
 create mode 100644 drivers/cpufreq/airoha-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5f7e13e60c80..704e84d00639 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -15,6 +15,14 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun50i-cpufreq-nvmem.
 
+config ARM_AIROHA_SOC_CPUFREQ
+	tristate "Airoha EN7581 SoC CPUFreq support"
+	depends on ARCH_AIROHA || COMPILE_TEST
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
index 000000000000..34006dffd81b
--- /dev/null
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpufreq.h>
+#include <linux/module.h>
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
+	struct device *cpu_dev;
+
+	priv = airoha_cpufreq_find_data(policy->cpu);
+	if (!priv)
+		return -ENODEV;
+
+	cpu_dev = priv->cpu_dev;
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


