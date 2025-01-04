Return-Path: <linux-pm+bounces-19958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1BEA01639
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 19:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CAC18814BB
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3441D5146;
	Sat,  4 Jan 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NezRFzr5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1C45016;
	Sat,  4 Jan 2025 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736014420; cv=none; b=li53R6oHc6lNPxK5kOEOhS/9T2yxco0pPN9XkxwxIIvNmdn4Sz6GKM8RjxBexcPakuWunO+5pqbQ1pqzVat9Sxd8yUMGfJtpmMfKYxJaEZAxbg7kS/YvvFRs+PIpaM+I0DKv88TGYk+A+bCkoENf9kxbxFXEG1TyktBkxO8ANPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736014420; c=relaxed/simple;
	bh=oMYbdEiZMWkxRbV6nTzaK70f1aiutmitMOAjfsUBO0s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mT5F96qlOcCuw6k7M1FXJIxD6+Wf2NuGmbaMEr6EsAfYJVSwAZUrQwUmoYSxjy1CkUyrniqJzwINIMIhqymPYJe+/HQBHQ7/N0PCqpLJogVXLMa4YCMPKbLANrIVZGiWruT/ZXRdQpQRMapQk/K/YjDgXvi4nH+qHqMVt9lUKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NezRFzr5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso10064231f8f.0;
        Sat, 04 Jan 2025 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736014417; x=1736619217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xV+8RO/Ef30DT4vDUqGvKPdTER63OAV9teSiIpFh5bo=;
        b=NezRFzr5ht2GKHUWk+oFh21+ZsZuzDPTcWx9+seg7Qc/HcGVybtZcZNuzQf0qxyC4X
         odbIEGOE+hsqtrUYfiK8nTCL5hTcf71KpE0K0onN7syvyyeYi5yi/NCph9cncr5pUzOM
         3Op6J78hsOgKAQZtiP6q74Q+e5FTtmmAJQL/97J8YhQqsk2v8f342YPTRtDdZVMlr+Lc
         71sHPNcgqfHu0KZs2H1HLdVdtH86WCKu7Pxdw8OM/wYMSsNE1Tt5gdjJmEa/Puoho+Un
         2zRzhKKT9dMuc+zqPO7y2d/Ny5Fy6SGgBinrfTvYTnJqud/hGpwUQ8dYBqsKe3nLMGhp
         Mgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736014417; x=1736619217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV+8RO/Ef30DT4vDUqGvKPdTER63OAV9teSiIpFh5bo=;
        b=KdGAxY88WN0UZLkMw6KptgErFwp3wONGZpEc4DYqoaukD3b+I3IXfyG1JhZhysrK1Z
         FU9VzwBEEfYuwkvl6KsgPEEHdTiPMV4dmhZTQGIhqog2z6RWxOYI9bGt2Xn6xm9AvvJT
         IHExRfB0EdhwbGT2PPAZY9wB/nxI7ddTGAC+VIPJBI/56p7bhh6PwTgHUIu7X5cuJWFj
         a44ikOpGgu831H6PoLuBUfAarshVspheW1cvBcw0F3/4Sagtbfv2k/xo1EiilF0Nrnmm
         bZvfF3g6iXHjfTXyp/AsnFo5U8C0ny8DJS1BwE9vChpQ3Xo1Gz7LrvudFOL+Bm6EdjhF
         xEBw==
X-Forwarded-Encrypted: i=1; AJvYcCV8eUMZ1rxmv24eszmpZeMHdlW4xxVRVkRw6rbqmE/IZ6j45UAejuy6BEhd8qCRlZ/7umIvB1FMa1w=@vger.kernel.org, AJvYcCXC9+dGevdZLAXLuE1n48yujCL6VJ3LZHxIaLNL90cENRNMqVucCKMt2bQmWqOWSaNxeW/eBfhkHrQCo7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHm0inbddnO7OMZ92maG0tChFUnPV7vz2mMnTsLK1icv4pvGp/
	6QxoQIixF9umpdAXLtLMtQfa3VhdBTuCJage78oY+wlsIeS9P6jo
X-Gm-Gg: ASbGncu0EeATJTdjjmfs0PJ3LZArQDoPAznxV0NYL2mI7uZsVEbB3nLI8RGbKPkitJN
	2IWqd1W8br9OAiyDnjf+7QJwjrSC8IQ52HmaMJqH5wiglKSfM4ZMosoHL4KWQ+CRTHu4z/ZrLw0
	PdoUw3cdLjD0aTouAKE/P7mCfdqjdi1usGzl10KQQSgUCM7sdjE0ej8hug3ackydDrW4C2oELie
	B5e/7H/K/nhoQdVAP83UgTkyjSxT5Z4HjIOc+0NnaEaqXYP36DTOmTI7e4mF/ZT1+oYM+VjfbRi
	EZ6vUM/m1pCiX/snJ7TYA3KFpXjqQ2C3sG5/nSRw7g==
X-Google-Smtp-Source: AGHT+IHZ9RHFwy4NU/YhiX1jRd9CAQ4xsTogB3A40Eq9ggchtQQG0Ko4CuvvRbK9Fw1CF7r+Ai9xqA==
X-Received: by 2002:a05:6000:70a:b0:382:4ab4:b3e5 with SMTP id ffacd0b85a97d-38a2213e228mr47250390f8f.0.1736014416944;
        Sat, 04 Jan 2025 10:13:36 -0800 (PST)
Received: from localhost.localdomain (host-95-246-253-26.retail.telecomitalia.it. [95.246.253.26])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4366128a3c9sm520167595e9.40.2025.01.04.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 10:13:36 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v8 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Date: Sat,  4 Jan 2025 19:12:38 +0100
Message-ID: <20250104181305.28185-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250104181305.28185-1-ansuelsmth@gmail.com>
References: <20250104181305.28185-1-ansuelsmth@gmail.com>
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
CPU frequency is controlled by the attached PM domain.

Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
driver is needed with OPP v2 nodes declared in DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v8:
- Split in dedicated PM domain driver
Changes v7:
- No changes
Changes v6:
- Improve Kconfig depends logic
- Select PM (PM_GENERIC_DOMAINS depends on it)
- Drop (int) cast for 
Changes v5:
- Rename cpu_pd to perf for power domain name
- Use remove instead of remove_new
Changes v4:
- Rework to clk-only + PM set_performance_state implementation
Changes v3:
- Adapt to new cpufreq-dt APIs
- Register cpufreq-dt instead of custom freq driver
Changes v2:
- Fix kernel bot error with missing slab.h and bitfield.h header
- Limit COMPILE_TEST to ARM64 due to smcc 1.2

 drivers/cpufreq/Kconfig.arm          |  10 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/airoha-cpufreq.c     | 166 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 179 insertions(+)
 create mode 100644 drivers/cpufreq/airoha-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5f7e13e60c80..8494faac58ae 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -15,6 +15,16 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun50i-cpufreq-nvmem.
 
+config ARM_AIROHA_SOC_CPUFREQ
+	tristate "Airoha EN7581 SoC CPUFreq support"
+	depends on ARM64 && (ARCH_AIROHA || COMPILE_TEST)
+	select PM
+	select PM_OPP
+	select PM_GENERIC_DOMAINS
+	default ARCH_AIROHA
+	help
+	  This adds the CPUFreq driver for Airoha EN7581 SoCs.
+
 config ARM_APPLE_SOC_CPUFREQ
 	tristate "Apple Silicon SoC CPUFreq support"
 	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index d35a28dd9463..890fff99f37d 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_AIROHA_SOC_CPUFREQ)	+= airoha-cpufreq.o
 obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
new file mode 100644
index 000000000000..cca5183495cc
--- /dev/null
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitfield.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "cpufreq-dt.h"
+
+struct airoha_cpufreq_priv {
+	int opp_token;
+	struct device **virt_devs;
+	struct platform_device *cpufreq_dt;
+};
+
+static struct platform_device *cpufreq_pdev;
+
+/* NOP function to disable OPP from setting clock */
+static int airoha_cpufreq_config_clks_nop(struct device *dev,
+					  struct opp_table *opp_table,
+					  struct dev_pm_opp *old_opp,
+					  struct dev_pm_opp *opp,
+					  void *data, bool scaling_down)
+{
+	return 0;
+}
+
+static const char * const airoha_cpufreq_clk_names[] = { "cpu", NULL };
+static const char * const airoha_cpufreq_genpd_names[] = { "cpu_pd", NULL };
+
+static int airoha_cpufreq_probe(struct platform_device *pdev)
+{
+	struct dev_pm_opp_config config = { };
+	struct platform_device *cpufreq_dt;
+	struct airoha_cpufreq_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct device **virt_devs = NULL;
+	struct device *cpu_dev;
+	int ret;
+
+	/* CPUs refer to the same OPP table */
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	config.clk_names = airoha_cpufreq_clk_names;
+	config.config_clks = airoha_cpufreq_config_clks_nop;
+	config.genpd_names = airoha_cpufreq_genpd_names;
+	config.virt_devs = &virt_devs;
+
+	priv->opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+	if (priv->opp_token < 0)
+		return dev_err_probe(dev, priv->opp_token, "Failed to set OPP config\n");
+
+	/* Set Attached PM for OPP ACTIVE */
+	if (virt_devs) {
+		const char * const *name = airoha_cpufreq_genpd_names;
+		int i, j;
+
+		for (i = 0; *name; i++, name++) {
+			ret = pm_runtime_resume_and_get(virt_devs[i]);
+			if (ret) {
+				dev_err(cpu_dev, "failed to resume %s: %d\n",
+					*name, ret);
+
+				/* Rollback previous PM runtime calls */
+				name = config.genpd_names;
+				for (j = 0; *name && j < i; j++, name++)
+					pm_runtime_put(virt_devs[j]);
+
+				goto err_register_cpufreq;
+			}
+		}
+		priv->virt_devs = virt_devs;
+	}
+
+	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(cpufreq_dt);
+	if (ret) {
+		dev_err(dev, "failed to create cpufreq-dt device: %d\n", ret);
+		goto err_register_cpufreq;
+	}
+
+	priv->cpufreq_dt = cpufreq_dt;
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+err_register_cpufreq:
+	dev_pm_opp_clear_config(priv->opp_token);
+
+	return ret;
+}
+
+static void airoha_cpufreq_remove(struct platform_device *pdev)
+{
+	struct airoha_cpufreq_priv *priv = platform_get_drvdata(pdev);
+	const char * const *name = airoha_cpufreq_genpd_names;
+	int i;
+
+	platform_device_unregister(priv->cpufreq_dt);
+
+	dev_pm_opp_clear_config(priv->opp_token);
+
+	for (i = 0; *name; i++, name++)
+		pm_runtime_put(priv->virt_devs[i]);
+}
+
+static struct platform_driver airoha_cpufreq_driver = {
+	.probe = airoha_cpufreq_probe,
+	.remove_new = airoha_cpufreq_remove,
+	.driver = {
+		.name = "airoha-cpufreq",
+	},
+};
+
+static const struct of_device_id airoha_cpufreq_match_list[] __initconst = {
+	{ .compatible = "airoha,en7581" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, airoha_cpufreq_match_list);
+
+static int __init airoha_cpufreq_init(void)
+{
+	struct device_node *np = of_find_node_by_path("/");
+	const struct of_device_id *match;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	match = of_match_node(airoha_cpufreq_match_list, np);
+	of_node_put(np);
+	if (!match)
+		return -ENODEV;
+
+	ret = platform_driver_register(&airoha_cpufreq_driver);
+	if (unlikely(ret < 0))
+		return ret;
+
+	cpufreq_pdev = platform_device_register_data(NULL, "airoha-cpufreq",
+						     -1, match, sizeof(*match));
+	ret = PTR_ERR_OR_ZERO(cpufreq_pdev);
+	if (ret)
+		platform_driver_unregister(&airoha_cpufreq_driver);
+
+	return ret;
+}
+module_init(airoha_cpufreq_init);
+
+static void __exit airoha_cpufreq_exit(void)
+{
+	platform_device_unregister(cpufreq_pdev);
+	platform_driver_unregister(&airoha_cpufreq_driver);
+}
+module_exit(airoha_cpufreq_exit);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("CPUfreq driver for Airoha SoCs");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 9c198bd4f7e9..2aa00769cf09 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,8 @@ static const struct of_device_id allowlist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blocklist[] __initconst = {
+	{ .compatible = "airoha,en7581", },
+
 	{ .compatible = "allwinner,sun50i-a100" },
 	{ .compatible = "allwinner,sun50i-h6", },
 	{ .compatible = "allwinner,sun50i-h616", },
-- 
2.45.2


