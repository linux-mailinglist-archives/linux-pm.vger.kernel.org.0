Return-Path: <linux-pm+bounces-28429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40315AD493C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7992B1897918
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD36227EB2;
	Wed, 11 Jun 2025 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZBMY8787"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01A227E90
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749611452; cv=none; b=ucqUlZTtmReDrYvH3+sdbP1hZXrtC6tQWFeCNWVQT9n5WJ3m4EqAsmYvNxquzhkghmV5t7oP17Bt1xVrtqrlIxTwIZNkWOOuMP6H+8n1LYAmHdc3o9DIzanAgOXBpOKRGv5XDaUhrMUQ8EXprNeIZ9RDKfk9rA/Cia+KkyKr7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749611452; c=relaxed/simple;
	bh=ezs1yVD1qWrbfIWXSnxmuxGlazdXg0gy9Hw4rcIv6x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qvI4GuXWslzBKwGHXHLwG0oof4eo4FVlkFj940yXLzRxFILoEM6BgduF67WfjHrWqg3RJfSETMf5GTFYtX/KlQptz7/LHOZoGBNkTD+VeSjTu7E9zH++lin+vHrnPbslv+3JwXGX8O0H/oPB9ccu2y1O176kYvh2oZmKd2vgKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZBMY8787; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234bfe37cccso75080945ad.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1749611450; x=1750216250; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OKliCGksR6+ULOCTOHx3A9pUuY8LclRcFBEc4eLZfck=;
        b=ZBMY87875OYYsz8xUp9Th+H9YPYEl2tts+Aa5FEEu8w1ta2QUvq4AmodGGF15a2NBw
         jiybxhQTZqX9zciLU8KbNOwqdLsfVZpjL0zb2ORPGQ3TjNZE10FDCO7g812durV5hdun
         oQXcvuq1XCWAlANzmWbH5urj0KPbqpkwmYNEp46DUwOG7gJYFqwgNabdb0zWooHMT8OS
         CwOzH94wGABe4lsw+GP3hxnev6u2s70X8xzjCkyO4X1gm5POAGWJI0lG8+026TfV7Ss2
         rP+Zr4MRQslfLn5S4jlGHw0YuNpIn22w8ROcLZ2rwuz0pvtIocVm67tD0G1P/Lzq4Ivr
         vHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749611450; x=1750216250;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKliCGksR6+ULOCTOHx3A9pUuY8LclRcFBEc4eLZfck=;
        b=N2BxVKLWsSBlbHQv/8SHXqKQYrBbqAASvwovnWHt8oqYdQ5ujmUfJsL0iWTLieC74H
         Bm5lGWFkIXv3TfS46ynj2Bik20l7JV+3L9DFXzd5+1NcC/990xm5+LWy9uqzi/0mbLpJ
         VBgSCHHZs8YJe9jcn5EwNFB6RAUMijlMsqvgQ+zDgi52y6s22hc9zzqtUlU91UBWku2W
         xg6+dkKAYebG7Sa0ZGLk50HWGjwhCmot5pjC99IoVycFe9DAjV2sTM6r6cN8Y1WGN2Zf
         Bm2fStg8cC985ONtTLLA9qIzBgdQRbCWEDDYxQsR7PkQAe5swLvbXah0TmMlpB7AFhi+
         XH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGoSuL1zVeAXb4a3I7dKrBKFXKzkunyKLOJ44yxnRofhZt2PV4vmQ3HoQXBNReTGhbwiBj4NW0CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEYRX9+UPnJbsrk/Ki1mFLIOhp4lQeDGhglNdUKJFsW5hiJIB
	b3zxLXlu+FIS5PnZiUwOefjsq4dXawHgT4YzX40lQdBSPQuX9sYl7jFvv6+wJwBM0TQ=
X-Gm-Gg: ASbGncsWjdrzGFnHvDUoxiqWQk0bOAd1nO8+pmN6N4YhDnIilzzw2FCGiJgYhqZMtZ+
	U37oS6uTEDtzMKH7ilHgm+I7ARKUSJH3arKPDSRG4UsX19AnLc/LsqrOHPP3rInO9+2b9en0vc4
	poBC0Sw+uJxKks6JueDN+A6ZeV1Skgp6ESzjq13xWpJtfMyFWgF/77O8Y6QmE5ohmonEsrVZqmo
	Gteg3wNdx/dyjUsNYNOsS4nDvHEOcqq0i3iV9ZpFC7f7cU8R3rTvKYDdkLFzW5faqKfmBL/QWyM
	bq7elcOMBzV3rkW9/J4n7Lccw++DVON1YdGBRKNu7LlT8XHsLo/DKcphB7HrkdsYgrVWNDYSR5E
	3AN/rvI3a
X-Google-Smtp-Source: AGHT+IFPno+Zu2I5qZ202mkGD/8XfyJVIJyg5/3MgZXAw5pnr/jUfcVT8Ys4xo+b9DSKEUYG3e62jw==
X-Received: by 2002:a17:902:dacf:b0:234:986c:66f9 with SMTP id d9443c01a7336-23642621cf9mr18955565ad.22.1749611450426;
        Tue, 10 Jun 2025 20:10:50 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030789c2sm77669035ad.29.2025.06.10.20.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:10:50 -0700 (PDT)
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
Subject: [PATCH v2 3/3] cpuidle: Add SiFive power provider
Date: Wed, 11 Jun 2025 11:10:22 +0800
Message-Id: <20250611031023.28769-4-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250611031023.28769-1-nick.hu@sifive.com>
References: <20250611031023.28769-1-nick.hu@sifive.com>
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
 drivers/cpuidle/Kconfig.riscv           |  11 +++
 drivers/cpuidle/Makefile                |   1 +
 drivers/cpuidle/cpuidle-sifive-dmc-pd.c | 102 ++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-sifive-dmc-pd.c

diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
index 78518c26af74..af802afefa21 100644
--- a/drivers/cpuidle/Kconfig.riscv
+++ b/drivers/cpuidle/Kconfig.riscv
@@ -13,3 +13,14 @@ config RISCV_SBI_CPUIDLE
 	  Select this option to enable RISC-V SBI firmware based CPU idle
 	  driver for RISC-V systems. This drivers also supports hierarchical
 	  DT based layout of the idle state.
+
+config SIFIVE_DMC_PD_CPUIDLE
+	bool "SiFive DMC SBI PD Provider Driver"
+	depends on ARCH_SIFIVE
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


