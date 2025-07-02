Return-Path: <linux-pm+bounces-29968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472AAAF0F56
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 11:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B541C26CE9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F87823ED56;
	Wed,  2 Jul 2025 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TR3v0U1t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9E23D2B4
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447595; cv=none; b=Pz9V09Vwv6b2qNhVMc3unXZEmwXu4S1EMVvyooOPHr+i5Qn/TEGr+dc1EMJGByAacBAsfwzFzEru9lgGqxag4oq0+MrbqfEiAjPcLejIanZQ0TovlTdtilgAKwjldMVRvUTiM4kzpxx0moqOhsDizJGNnHFevzU7SzVbVbw3Sm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447595; c=relaxed/simple;
	bh=2FPjzMzKyA6adFzJ0yhBTxg69acIxuCchSzT7oFh9NU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rjn5AHjVqArLct0YjJxGur8unUSZCysZZ5D2EXp9hXehP2eRaSHOeFKRGII57bAhIBwORwy1qt9dOLIrPlx+QKH+bfMr9inFaw5TS3jQ6Jv+b18xU0r6q0Tfib3cR35ZbLnCihKwUbksFzQ/lLvT7N8lv1XtDKNYPfSPIJxmolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TR3v0U1t; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fa980d05a8so70112096d6.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Jul 2025 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1751447593; x=1752052393; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vo6FBHptvz4zRCJelPx9LjfFz/JvRA8JCJ880HRAykw=;
        b=TR3v0U1tGZKdwx8e1Hlvu+Y3kjtGLtaGnNUKd9YeC3f4eWz5kqe74YCKIGq8ayt1P+
         8qgHlcLNX1MC0T0++1wo3CGOiVd4kXqZ0rbclxehSvU5LGkckORqtRFMBEGBNeX7Bjmz
         ZNeKzViz0GgkAp/GsZvYSjN+1GB5lDvBVAEVvzlQB1vnVl4HuYaTuSfa7b914mlVa8DU
         +6qCC1la6kgn+xBa8N5PsokdjPB0MN0xOoO+wmA0oWkzoiToeBEglI3uNKYXHEvvdpJD
         XHiA8KCf6MmqsZ/WMp15QNtYPZSOfIVvmuxrfXq2TRF95hGRjI0jdaCsON7QB35d4ZFr
         QLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751447593; x=1752052393;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo6FBHptvz4zRCJelPx9LjfFz/JvRA8JCJ880HRAykw=;
        b=OTUTGXPq+MgMumoq+muBvcTp51CHASHdsRhT7taRm8pBleTd3p6nti1d1l2SIJzeR0
         41xwxoYzzE3ucBnxAF2EBbySqezFLxyMJz0opnEPNntEOfuocHrP0a+tDm2JDMirH+Ns
         126+DXJAgAuCEUws9NniyIzr2VoTSvUq1PE/RJqcJwEKLkuF2efO/UPu3Se4+zZ052ay
         /MD+uoOvOYw0y1cHkVO+iZ3d16y590NppRYDog5weqkCjpkkKdbMNn/ziRMsdCdE8Gbg
         iHnkHP6/ztIzfrz4HH7U7sztkVtVXq1mLpJfZ42y7P6w5gS75PIFhGdj86Qa0GdXaGct
         TETg==
X-Forwarded-Encrypted: i=1; AJvYcCVrW+ci1+iwrRsWDn4Lr95EQUHuNNeVDoqQajE0F74lvWHJ1ph4bbwM4LhbnGGvb+PcAtrm9zAAxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcCg1kRA4ACYCS19h0gfALstzQH7JSEu+8h42U0YPW8RG6pZnZ
	Iot0n51JWfrQgNr9k/+d5VDvFCu78fId5j3+WlfnRb/LZcIM3T8qbpoyOmOt7oRNF+s=
X-Gm-Gg: ASbGncsL6OjEwy+HG+aXJhTzcrcJ0PfmZldBqXA4jlpQDPa1BnJEshNNHCcl0/43d5/
	7SADFONdYU6a9XOA7QgSYGNpKqqVk02gcqltCfIzLwgoOyLhx+j3wc+V0TPgiKMB4ySub4rGq1r
	8YtQt50eaIWkEOJ3k9Nbycc+HgPxDXXCLg9g9Hm68QfZVD8qjpj8UGabWxUol17r2Q9CkHR1Q0N
	5a0Vj5cbgI88mULRCe1yE0bq4e6P2DPYPj0b0xHnx6vtcBbNRR21BuatPQRyS11bCLqWn5mStgU
	AmToovgsitj/rA6YxCQJLbkpE68mWRgPFjHgM5wN0qVmBAq7bwEELL5+vNKz6qDAZHACxe8Gx2B
	sHL7aZJL4
X-Google-Smtp-Source: AGHT+IFzmLCmLoGxxKwpjhHax+Cuhcc0opHmznf13C5TLU2uQvyPNUYZotNsu3vuaVV6k6gxhSCFeA==
X-Received: by 2002:a05:6214:20cf:b0:6fd:7604:d90a with SMTP id 6a1803df08f44-702b1aae28fmr19229146d6.6.1751447593097;
        Wed, 02 Jul 2025 02:13:13 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d4431344f7sm911736285a.2.2025.07.02.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:13:12 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Nick Hu <nick.hu@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 3/3] cpuidle: Add SiFive power provider
Date: Wed,  2 Jul 2025 17:12:36 +0800
Message-Id: <20250702091236.5281-4-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250702091236.5281-1-nick.hu@sifive.com>
References: <20250702091236.5281-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The SiFive DMC is the power provider of the devices that inside the
SiFive CPU power domains, which include Tile, Cluster and Core Complex
power domains. Before the cpu entering the firmware-based idle state,
each devices that inside the corresponding domain should be suspended
properly. So this driver will create the power provider and set the
correct idle state.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/cpuidle/Kconfig.riscv           |  12 +++
 drivers/cpuidle/Makefile                |   1 +
 drivers/cpuidle/cpuidle-sifive-dmc-pd.c | 102 ++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-sifive-dmc-pd.c

diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
index 78518c26af74..f461d09e0bdc 100644
--- a/drivers/cpuidle/Kconfig.riscv
+++ b/drivers/cpuidle/Kconfig.riscv
@@ -13,3 +13,15 @@ config RISCV_SBI_CPUIDLE
 	  Select this option to enable RISC-V SBI firmware based CPU idle
 	  driver for RISC-V systems. This drivers also supports hierarchical
 	  DT based layout of the idle state.
+
+config SIFIVE_DMC_PD_CPUIDLE
+	bool "SiFive DMC SBI PD Provider Driver"
+	depends on ARCH_SIFIVE && RISCV_SBI && PM && OF
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	select RISCV_SBI_CPUIDLE
+	default y
+	help
+	  Select this option to enable SiFive DMC SBI PD Provider driver.
+	  This driver will create the genpd provider and work with the
+	  RISC-V SBI firmware based CPU idle driver.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 1de9e92c5b0f..1f8e01b415e8 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
 ###############################################################################
 # RISC-V drivers
 obj-$(CONFIG_RISCV_SBI_CPUIDLE)		+= cpuidle-riscv-sbi.o
+obj-$(CONFIG_SIFIVE_DMC_PD_CPUIDLE)	+= cpuidle-sifive-dmc-pd.o
diff --git a/drivers/cpuidle/cpuidle-sifive-dmc-pd.c b/drivers/cpuidle/cpuidle-sifive-dmc-pd.c
new file mode 100644
index 000000000000..1c6b2131e573
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sifive-dmc-pd.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SiFive CPUIDLE SBI PD driver
+ */
+
+#define pr_fmt(fmt) "sifive_cpuidle_sbi_pd: " fmt
+
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+#include "cpuidle-riscv-sbi.h"
+#include "dt_idle_genpd.h"
+
+static void sifive_dmc_remove(struct platform_device *pdev)
+{
+	struct generic_pm_domain *pd = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	pm_runtime_disable(dev);
+	of_genpd_del_provider(dev->of_node);
+	pm_genpd_remove(pd);
+	dt_idle_pd_free(pd);
+}
+
+static int sifive_dmc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct generic_pm_domain *pd;
+	struct of_phandle_args child, parent;
+	int ret = -ENOMEM;
+
+	pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
+	if (!pd)
+		goto fail;
+
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+	pd->power_off = sbi_cpuidle_pd_power_off;
+
+	ret = pm_genpd_init(pd, &pm_domain_cpu_gov, false);
+	if (ret)
+		goto free_pd;
+
+	ret = of_genpd_add_provider_simple(np, pd);
+	if (ret)
+		goto remove_pd;
+
+	if (of_parse_phandle_with_args(np, "power-domains",
+				       "#power-domain-cells", 0,
+				       &parent) == 0) {
+		child.np = np;
+		child.args_count = 0;
+
+		if (of_genpd_add_subdomain(&parent, &child))
+			pr_warn("%pOF failed to add subdomain: %pOF\n",
+				parent.np, child.np);
+		else
+			pr_debug("%pOF has a child subdomain: %pOF.\n",
+				 parent.np, child.np);
+	}
+
+	platform_set_drvdata(pdev, pd);
+	pm_runtime_enable(dev);
+	pr_info("%s create success\n", pd->name);
+	return 0;
+
+remove_pd:
+	pm_genpd_remove(pd);
+free_pd:
+	dt_idle_pd_free(pd);
+fail:
+	pr_info("%s create fail\n", pd->name);
+
+	return ret;
+}
+
+static const struct of_device_id sifive_dmc_of_match[] = {
+	{ .compatible = "sifive,tmc1", },
+	{ .compatible = "sifive,tmc0", },
+	{ .compatible = "sifive,smc1", },
+	{ .compatible = "sifive,smc0", },
+	{ .compatible = "sifive,cmc2", },
+	{}
+};
+
+static struct platform_driver sifive_dmc_driver = {
+	.probe = sifive_dmc_probe,
+	.remove = sifive_dmc_remove,
+	.driver = {
+		.name = "sifive_dmc",
+		.of_match_table = sifive_dmc_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init sifive_dmc_init(void)
+{
+	return platform_driver_register(&sifive_dmc_driver);
+}
+arch_initcall(sifive_dmc_init);
-- 
2.17.1


