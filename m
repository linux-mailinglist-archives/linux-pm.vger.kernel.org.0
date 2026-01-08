Return-Path: <linux-pm+bounces-40435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F04CD01F56
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 10:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88807306D290
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C4D37F8DF;
	Thu,  8 Jan 2026 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mQGHSmEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1937F10A
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862731; cv=none; b=nVjA9r0acXfMqp5WnGEn5gsqFyc/EkxudvNGwdq5gUYn8zvHD+uAfm2PaLUIGE0YjFuropqYt3TVIljRtYu7BSCPiv8xFMwQT/Fa9+M5M0kEeJFuXNR3ChKXQqgOTTnUKUH2X4au04JG5ABObtQI9F8bUv92/lqlJ3iuvYtvqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862731; c=relaxed/simple;
	bh=sIkymDyCEmbvxV9ZGQHY++Ov+nqP2mtyu2/hVCGij0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWjLtu9NF1RFoUkSdmOFLPYNoY1a9EsAiN3L+66ppoJys3NVxSWmgKVgeNvGGDk/7Rj3625vmk849CqZzVU8ab6Y+FlourbfQz10peE+udBZq6SAjhofSmOzxoguoncD6X3k11lOVLTqolZatPFFEhr5AtzgR66t87sv6XQGanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mQGHSmEn; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso1865848eec.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 00:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1767862721; x=1768467521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qYO/gxPTzZ1gsudLMySBCma6iHYfPz33KQqAWsXtts=;
        b=mQGHSmEnic+S0mS7xgLg+o+6wdYRXY+vt1KLwNdWi3ebWIs4RzQU8a7QTxZiGHLuyD
         ZjG0ZbcHq/2TyuIcxp09X8FymPW8d0sznQogZikC0C1/ugNg4aS1X256mgLR9imOr+Ht
         NVvx5LFLoDuLgxMCC5RwXsRJjH1ksxbXPIQegQxFL5/z7esv1jZGTOewvIcUMOaj2Dsr
         x7DNyg6gs1Fm6COvrfCisZWVcCKEFG/x8muLeWOOHOwMfqr7fFbcll98jgjP/36MZn62
         EUyIeVhev/vI6uWH1Zz3i13dn3YOCUWf6vCyhUACXp+VqfP24lvi8LaF/RilD5pDYyXr
         eJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862721; x=1768467521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+qYO/gxPTzZ1gsudLMySBCma6iHYfPz33KQqAWsXtts=;
        b=jw2pKynCZH8Ushcu3dR2ZBTvFQGl6cwwQQlpdJ9cY93ORvKCS1J436UwBB1b8AO/YO
         oCZJch/IRlcljyPtSX3dhVqGW0KX4mCmOVkngPHx+zLFnzuUuVsTcjVOZTyTiCTlU6ok
         tMI0kKbQ0pcr/ZtT5fxFvjDnoGyIDyH0QS8a/YyAWJdnZOu92xkTdiL9Ttcg8aZCKuvK
         MviehqHtfyfGBWABXCr38Adc9UOIexMARAWSdhv26sgCTE36fZn1p3y3vWtbGXUDrSst
         lUHYUN0WTR4yKr+zrUc408LBbJzo+O/M/iLd91N4R49tq6Yn2R659e3+KAunuduClrQn
         fFTw==
X-Forwarded-Encrypted: i=1; AJvYcCUDDBfaBMqxVk8TmYp177zpLBjqFbPvgu/zVo8Prc3agfqpeeEi26JbUkNwUawiLTEQSzQ6HUWDBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8nxaNFRh2IF+dg1LKnI56P+maaqbVG8U5pfZc2ijSI6jjbYN
	58TWGhzaOL6PAxqZmu/0WXv09CZhSMeAdDrH/GznSt10P6qR+eIjUUFD+DqTY/aW57s=
X-Gm-Gg: AY/fxX7wt4uyKmnRvIatdpArIymu7trjFQWlZ36H6Ro5DyiBZOI4CUpzG1TIzvlwgBE
	WcZ7ZjROe8HWALQao6Zi1cOs8LhiOKTGCfuHT5C/1dAufR/ccP4QBZ860PDMrv3QbNubsAuidhG
	YDbbGbwQpzJGqPYNJDdJreRRpBmGGTVoGkxAepzIJJZOKZVCgbszU3m/ASOnoB8DybwiwgHmpru
	AHLONz4Brjww3KOJop5Y6YsHqsQ3xcPjz/rEDez8dltRhs3GMIOwrfiJ/NRyueHr8+EUHXldZBb
	dBAhg476uCZhicMJV9AW1DGYPI+xfBlknRLMCjpwdjgHcfD3BhWnXHle3Egp8IjtSLBeEsL/LtZ
	20JCNJMtg/8pHWoPcKBiYwJ08KUAehzYyr5/ZIeWQMLLvgmQtFs6+h5ejbMsVtkSrL7hQGGfzPc
	oq3ztrtfYEs9m6VluHbuwvL/s=
X-Google-Smtp-Source: AGHT+IE1ZYycZa8LfJgM/0T5ClhaC/Ln6YDrHSVxn+Bb2E0ZQUAhY5IK4YTUt16wFaSjFCweu0L/Dw==
X-Received: by 2002:a05:693c:40db:b0:2ae:55f1:8201 with SMTP id 5a478bee46e88-2b17d23964bmr4070425eec.1.1767862721007;
        Thu, 08 Jan 2026 00:58:41 -0800 (PST)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170675076sm8833634eec.2.2026.01.08.00.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:58:40 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 08 Jan 2026 00:58:26 -0800
Subject: [PATCH v4 3/3] cpuidle: Add SiFive power provider driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-sifive-pd-drivers-v4-3-2a523d7d51a0@sifive.com>
References: <20260108-sifive-pd-drivers-v4-0-2a523d7d51a0@sifive.com>
In-Reply-To: <20260108-sifive-pd-drivers-v4-0-2a523d7d51a0@sifive.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
 Samuel Holland <samuel.holland@sifive.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Cyan Yang <cyan.yang@sifive.com>, 
 Nick Hu <nick.hu@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3

The SiFive DMC is the power provider of the devices that inside the
SiFive CPU power domains, which include Tile, Cluster and Core Complex
power domains. Before the cpu entering the firmware-based idle state,
each devices that inside the corresponding domain should be suspended
properly. this driver will create the power provider and set the correct
domain idle state.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/cpuidle/Kconfig.riscv               |  12 +++
 drivers/cpuidle/Makefile                    |   1 +
 drivers/cpuidle/cpuidle-sifive-dmc-domain.c | 124 ++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
index b813018ce401..2fe0912f8027 100644
--- a/drivers/cpuidle/Kconfig.riscv
+++ b/drivers/cpuidle/Kconfig.riscv
@@ -22,3 +22,15 @@ config RISCV_SBI_CPUIDLE_DOMAIN
 	  Select this option to enable RISC-V SBI firmware based CPU idle
 	  driver to use PM domains, which is needed to support the hierarchical
 	  DT based layout of the idle state.
+
+config SIFIVE_DMC_CPUIDLE_DOMAIN
+	bool "SiFive DMC CPU idle Domain"
+	depends on ARCH_SIFIVE
+	depends on RISCV_SBI_CPUIDLE
+	depends on PM_GENERIC_DOMAINS_OF
+	select DT_IDLE_GENPD
+	default y
+	help
+	  Select this option to enable RISC-V SBI firmware based CPU idle
+	  driver to use PM domains on SiFive Platforms, which is needed to
+	  support the hierarchical DT based layout of the idle state.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 82595849b75d..eead4c049414 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -43,3 +43,4 @@ obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
 # RISC-V drivers
 obj-$(CONFIG_RISCV_SBI_CPUIDLE)		+= cpuidle-riscv-sbi.o
 obj-$(CONFIG_RISCV_SBI_CPUIDLE_DOMAIN)	+= cpuidle-riscv-sbi-domain.o
+obj-$(CONFIG_SIFIVE_DMC_CPUIDLE_DOMAIN)	+= cpuidle-sifive-dmc-domain.o
diff --git a/drivers/cpuidle/cpuidle-sifive-dmc-domain.c b/drivers/cpuidle/cpuidle-sifive-dmc-domain.c
new file mode 100644
index 000000000000..5174bc525a13
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sifive-dmc-domain.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SiFive CPUIDLE DMC driver
+ */
+
+#define pr_fmt(fmt) "sifive_dmc_cpuidle_domain: " fmt
+
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+#include "cpuidle-riscv-sbi.h"
+#include "dt_idle_genpd.h"
+
+static bool use_osi = true;
+
+static int sifive_cpuidle_dmc_power_off(struct generic_pm_domain *pd)
+{
+	struct genpd_power_state *state = &pd->states[pd->state_idx];
+	u32 *pd_state;
+
+	if (!state->data)
+		return 0;
+
+	/* OSI mode is enabled, set the corresponding domain state. */
+	pd_state = state->data;
+	sbi_set_domain_state(*pd_state);
+
+	return 0;
+}
+
+static int sifive_dmc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct of_phandle_args child, parent;
+	struct device *dev = &pdev->dev;
+	struct generic_pm_domain *pd;
+	int ret = -ENOMEM;
+
+	pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
+	if (!pd)
+		goto out;
+
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+	if (use_osi)
+		pd->power_off = sifive_cpuidle_dmc_power_off;
+	else
+		pd->flags |= GENPD_FLAG_ALWAYS_ON;
+
+	ret = pm_genpd_init(pd, &pm_domain_cpu_gov, false);
+	if (ret)
+		goto free_pd;
+
+	ret = of_genpd_add_provider_simple(np, pd);
+	if (ret)
+		goto remove_pd;
+
+	if (!of_parse_phandle_with_args(np, "power-domains", "#power-domain-cells", 0, &parent)) {
+		child.np = np;
+		child.args_count = 0;
+
+		ret = of_genpd_add_subdomain(&parent, &child);
+		of_node_put(parent.np);
+		if (ret) {
+			pr_err("%pOF failed to add subdomain: %pOF\n", parent.np, child.np);
+			goto remove_pd;
+		}
+	}
+
+	pm_runtime_enable(dev);
+	pr_info("init PM domain %s\n", dev_name(dev));
+	return 0;
+
+remove_pd:
+	pm_genpd_remove(pd);
+free_pd:
+	dt_idle_pd_free(pd);
+out:
+	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
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
+	.driver = {
+		.name = "sifive_dmc",
+		.of_match_table = sifive_dmc_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init sifive_dmc_domain_init(void)
+{
+	int cpu;
+
+	/* Detect OSI support based on CPU DT nodes */
+	for_each_possible_cpu(cpu) {
+		struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
+		if (np &&
+		    of_property_present(np, "power-domains") &&
+		    of_property_present(np, "power-domain-names")) {
+			continue;
+		} else {
+			use_osi = false;
+			break;
+		}
+	}
+
+	sbi_set_osi_mode(use_osi);
+
+	/* Only probe the DMCs when OSI supported */
+	return platform_driver_register(&sifive_dmc_driver);
+}
+core_initcall(sifive_dmc_domain_init);

-- 
2.43.7


