Return-Path: <linux-pm+bounces-19964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63769A019BA
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 15:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D317A167C
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4314D456;
	Sun,  5 Jan 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjghNoUU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265242A93;
	Sun,  5 Jan 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736087242; cv=none; b=NSyFdD26Jq9j3uqiq/4Ib5m/mBlOnI/97aj582DS4sZjeHUOmgkhcm688EeZOIoiUcvLNzi3IVf2HZR92Fy2b6aoAr3PFMln1MdbhmALWYUT8MwCcd1lVbrovOCNLJI5UokYFHzShLeWiBmhaPFkd6m4XQGAtHScalumbWKTUCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736087242; c=relaxed/simple;
	bh=cY0IdA4avr/XmHZshF+96+n3p60epuelvtE/f+Gg9Qw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjsWLEJrZWtOfc1gOoj/xZKMq3vCKEMxMSsxvvOnshzbUQ5oHk69JhzborFU5HmPGVVTe3Omm9rd454TsLNJvn02ztguBZAyLDWcEsOO58G0YS31r+YymhqwVmeK7rq1xYlUTJM0GyHzZNiK7u+pJwUnInvrWURYBjWEI2wOnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjghNoUU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385df53e559so10703328f8f.3;
        Sun, 05 Jan 2025 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736087238; x=1736692038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkN0Zbqriw5PzthPVlNgEaF6B8Bg927+i+ccWjtK+W4=;
        b=cjghNoUURzkm8eyEq1/IBkldTX6K3Jcq5G4qc/WlzQ587n+r7CfEi9FDb78Ars8otA
         za+RnyWjSeJmINDQYzfJVPyBHHZ0FvkZ4WTuBollhLV0cGIDmyzxgSZ/pDURAeInJLnU
         4mxDi+QjHMmaSREiuii97RldvBj0hIg4P7Zgd81hDVRKoG1uFnthiGCn+FLkCgTFeRXN
         1pQiUTi0KQc4C3XO+xKWBAYZMYzpjZK2lK/pfXxnrXYV+SC6idbzMGinjEC4sGQOxgaF
         iCVzCS2NW+GbcCioj6nNvBEZrL539ppmF7Q7pmmbKgAJMvb4uK15tPj4vUFJIgz8j0NK
         A9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736087238; x=1736692038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkN0Zbqriw5PzthPVlNgEaF6B8Bg927+i+ccWjtK+W4=;
        b=labNn28ifoQxSqQEOV1KF/NaQMfU/x5hWJpYHqkzG9fSwKGe54B1tNVdbYhC6yoQjw
         I/Povz/RyC2aLNyhh5YRw6vZY1UTSz/5j23Xy/RQ3Nryft45iGiVSVarkfMycGuKttrW
         ee7Y6ggrc+v3vEkpCebZVQ22kZ3mlimL+OjRAUz8WNu7OXFBudMrIfq6JSL8k2Nq9Xzl
         ID3EybhAJL95t/oWSXGDWKXEoq0qZq+m8Lyhlm1J14i+FSV4SCoQ1o38OILBhVVBZ+b/
         e0YQFidFoYKPE47jkHbutFUn6TWPmufZ2Oc+/Igc4NvL95kCwn3cMBjQEjvsp9yXzs4i
         1rGw==
X-Forwarded-Encrypted: i=1; AJvYcCUCqkiCCzmTaO7W5rph6c7MlCbATqXhJoIL8r0fB3nDy+zsv4ZaSwLEnJyYObtlz6APS+g4u3i9qWg=@vger.kernel.org, AJvYcCWj/k8hnqLA21Csw1LI0C7FctpJX9PY7ZCVBsQXGi6u55S8OptlI99A0fK5KZyhzVB6+cFT0YaNe3Zveps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapxuX59FkDbz38NGzPa1x2IsMZ9Kj8fbTIjIBs6RflSiqFbUJ
	GTLI7O+b8z5Es97BYrkk0KHlO0zT4YIEBw3c+xLU83mTrj9sW2Fd
X-Gm-Gg: ASbGncug3wy31UG2d+VvpFyIb6qVWjKcLXI3oKLLwGNlhpV0fqG/pthrANtol6ZcqWw
	vwn/SQllSaP69qLjgILNFN6Zr4xXuyOfyLW/LxUqGzZWIiBtOwa8prQbHd3aCQ/xtXS7lFWtIHV
	F4M0Qxd2sO5uIHEkCPaVuSCB2vXdOhVWDMMrKbsqlE9TsbXdA5knDxE2APlfbynAv0/wU2/NCc0
	/fgMccakNk04n/WAeG5QS9sqFrCb7VpkACE5l+L5Su2lWfVyJXMGVa3EGfN2DSQgrgTLt6BSDJA
	TInntOgQcGC7LNCgPLvbc3pPCJ5kTmLwv6xnsaAUlQ==
X-Google-Smtp-Source: AGHT+IFShItsvFWM5KB6b81/btYIKb32afHfsWtgb62Yz8u894GM3GnZ84FQgHqBtY7lSMZXb9jyug==
X-Received: by 2002:a05:6000:154f:b0:385:eeb9:a5bb with SMTP id ffacd0b85a97d-38a221f698amr44870461f8f.17.1736087238032;
        Sun, 05 Jan 2025 06:27:18 -0800 (PST)
Received: from localhost.localdomain (host-95-246-253-26.retail.telecomitalia.it. [95.246.253.26])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a1c846ca4sm46438420f8f.43.2025.01.05.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 06:27:17 -0800 (PST)
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
Subject: [PATCH v9 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Date: Sun,  5 Jan 2025 15:26:04 +0100
Message-ID: <20250105142645.20128-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250105142645.20128-1-ansuelsmth@gmail.com>
References: <20250105142645.20128-1-ansuelsmth@gmail.com>
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
Changes v9:
- Fix compile error targetting wrong branch (remove_new change and new PM OPs)
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

 drivers/cpufreq/Kconfig.arm          |   8 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/airoha-cpufreq.c     | 152 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 163 insertions(+)
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
index 000000000000..4fe39eadd163
--- /dev/null
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitfield.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "cpufreq-dt.h"
+
+struct airoha_cpufreq_priv {
+	int opp_token;
+	struct dev_pm_domain_list *pd_list;
+	struct platform_device *cpufreq_dt;
+};
+
+static struct platform_device *cpufreq_pdev;
+
+/* NOP function to disable OPP from setting clock */
+static int airoha_cpufreq_config_clks_nop(struct device *dev,
+					  struct opp_table *opp_table,
+					  struct dev_pm_opp *opp,
+					  void *data, bool scaling_down)
+{
+	return 0;
+}
+
+static const char * const airoha_cpufreq_clk_names[] = { "cpu", NULL };
+static const char * const airoha_cpufreq_pd_names[] = { "perf" };
+
+static int airoha_cpufreq_probe(struct platform_device *pdev)
+{
+	const struct dev_pm_domain_attach_data attach_data = {
+		.pd_names = airoha_cpufreq_pd_names,
+		.num_pd_names = ARRAY_SIZE(airoha_cpufreq_pd_names),
+		.pd_flags = PD_FLAG_DEV_LINK_ON | PD_FLAG_REQUIRED_OPP,
+	};
+	struct dev_pm_opp_config config = {
+		.clk_names = airoha_cpufreq_clk_names,
+		.config_clks = airoha_cpufreq_config_clks_nop,
+	};
+	struct platform_device *cpufreq_dt;
+	struct airoha_cpufreq_priv *priv;
+	struct device *dev = &pdev->dev;
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
+	/* Set OPP table conf with NOP config_clks */
+	priv->opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+	if (priv->opp_token < 0)
+		return dev_err_probe(dev, priv->opp_token, "Failed to set OPP config\n");
+
+	/* Attach PM for OPP */
+	ret = dev_pm_domain_attach_list(cpu_dev, &attach_data,
+					&priv->pd_list);
+	if (ret)
+		goto clear_opp_config;
+
+	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(cpufreq_dt);
+	if (ret) {
+		dev_err(dev, "failed to create cpufreq-dt device: %d\n", ret);
+		goto detach_pm;
+	}
+
+	priv->cpufreq_dt = cpufreq_dt;
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+detach_pm:
+	dev_pm_domain_detach_list(priv->pd_list);
+clear_opp_config:
+	dev_pm_opp_clear_config(priv->opp_token);
+
+	return ret;
+}
+
+static void airoha_cpufreq_remove(struct platform_device *pdev)
+{
+	struct airoha_cpufreq_priv *priv = platform_get_drvdata(pdev);
+
+	platform_device_unregister(priv->cpufreq_dt);
+
+	dev_pm_domain_detach_list(priv->pd_list);
+
+	dev_pm_opp_clear_config(priv->opp_token);
+}
+
+static struct platform_driver airoha_cpufreq_driver = {
+	.probe = airoha_cpufreq_probe,
+	.remove = airoha_cpufreq_remove,
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


