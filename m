Return-Path: <linux-pm+bounces-23884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10712A5CBFC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E9D7A3BA7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13D2263883;
	Tue, 11 Mar 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="km3dXTLM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B252627FF
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713640; cv=none; b=kfgbgZ5RwJDd8zLqOkv5ucb3k+0W/GNM/og62uI+IbNuwcm3A8i5BQBgW28RGYPPxxF7Jo0RF/iiIq17TST/ROJo+LOft10LONFGK2PCwhxb0t2XzMJK8B5JGsGfiurs8bxP60UNtO560olWqpzR+uAHRpm5GX/Po7/W3oSb3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713640; c=relaxed/simple;
	bh=/UBl8GpqqnHNeEOa36PiebInhElpLRhuRXVE+3m4AkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=LoyR3Thjtr0bD3dq/sThTQby/zIiCeEuqAvGG9Yh7U9oalE2U2QeMKhWGKmhtp1LTM99y1GJorh3QzsF8fGji9zAdqY5Vn/XzV/mRXXB6NhgKtwWpP98+z69TSXKm6ItpYnNEBBUCsLScxokJwHSaRzAuobgA2u1xM9yu+n8QlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=km3dXTLM; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250311172035euoutp0241f843e25bd6cb54794005058fcf5206~rz1LSMiQM2934229342euoutp02g
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250311172035euoutp0241f843e25bd6cb54794005058fcf5206~rz1LSMiQM2934229342euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741713635;
	bh=Xxj2oJyaz+HDgy8PfLNLB5s2+EVa6V27xHbnw0+axq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=km3dXTLMfUzpEJXY4dd/Mg+M4Vnra4tr1rKEHMcMutqiovkKlVy3u7RpYrKCjAwno
	 owX3ha24z3XtuPZx4lLxd3q0nrIg357xygyX+CscfXaad6D/fzcWf3VN8XFX4WqdYd
	 hizXqowAV0hmoPQVdxSZvBJQfh5RLSUr8e8EBeiY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250311172035eucas1p2a92bbbfe5369435f6a78f51146766f9c~rz1K2q-HH2715127151eucas1p2d;
	Tue, 11 Mar 2025 17:20:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 87.A8.20821.2E070D76; Tue, 11
	Mar 2025 17:20:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250311172034eucas1p12744332d95f4120a82ae8fe5e07a8d9f~rz1KUGMAi2684826848eucas1p1i;
	Tue, 11 Mar 2025 17:20:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250311172034eusmtrp22d1184be4f3f75759a790a40ac806d04~rz1KOnsW61824318243eusmtrp2R;
	Tue, 11 Mar 2025 17:20:34 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-48-67d070e23278
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 33.A4.19920.2E070D76; Tue, 11
	Mar 2025 17:20:34 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250311172033eusmtip29ad433091f4193172073b67dfa08b3af~rz1JRv5g41727317273eusmtip2b;
	Tue, 11 Mar 2025 17:20:33 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v8 4/5] pmdomain: thead: Add power-domain driver for TH1520
Date: Tue, 11 Mar 2025 18:18:59 +0100
Message-Id: <20250311171900.1549916-5-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311171900.1549916-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87qPCi6kG+w5Y2Px7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO4rJJSc3JLEst0rdL4MqYtiC8
	4K1fxbZzc1gbGGc4djFyckgImEicmTONpYuRi0NIYAWjxOMtDWwQzhdGiVMLz7ODVAkJfGaU
	+LorCqZjf9szJoii5YwSW063Q3W8YZT4POc/M0gVm4CRxIPl81lBEiIC/UwSfUf+gznMAisZ
	Je5fOAtWJSzgLXHg3xc2EJtFQFXiz9rNrCA2r4C9xJL535gg9slL7D8IUc8p4CDxedsKRoga
	QYmTM5+wgNjMQDXNW2czgyyQENjOKbH+xDxWiGYXiY/vWqFsYYlXx7ewQ9gyEv93zodakC/x
	YOsnZgi7RmJnz3Eo21rizrlfQMdxAC3QlFi/Sx8i7ChxaTtIOQeQzSdx460gxAl8EpO2TYcK
	80p0tAlBVKtJTO3phVt6bsU2qKUeEtv6frFNYFScheSZWUiemYWwdwEj8ypG8dTS4tz01GLD
	vNRyveLE3OLSvHS95PzcTYzAdHj63/FPOxjnvvqod4iRiYPxEKMEB7OSCO9q2wvpQrwpiZVV
	qUX58UWlOanFhxilOViUxHkX7W9NFxJITyxJzU5NLUgtgskycXBKNTB17pnDWRs32SLixXab
	52Lb1RefcrNpSz734f+9a67yN5qF3wi63L2ufbbTZLd4xKNNSfJZL/9kL7ppGTpfeN+iqU2W
	+oKLymvNAyaujjhRXuDKICxxQnB/7F32lkMyFr33xJyYtT9HCkWUub9eu+EVu12i5QFLnrKr
	sbVT92cXpdalLVafaF9yZjqnhbR7yne3rq1HTD5t9j1w7EwVLyOHSaZhgUvJ9/S8ewqeKjfD
	Mp44PLkde+ruhK8LvNcVvloqPjWt7q6k85dpVuLnhTqZo/w13FVNAsp3h7OsXTTlzvv8nLSE
	XdsCKmK3xYuLhWvMk+G76WqU5XL7Ro3LwYuWy9KfmC9O3XDsQxD3NyWW4oxEQy3mouJEAO9W
	T6H2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7qPCi6kG1w7zm/x7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw
	0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuYtiC84K1fxbZzc1gbGGc4djFyckgI
	mEjsb3vG1MXIxSEksJRRYsL6z0wQCRmJa90vWSBsYYk/17rYQGwhgVeMEu1ro0BsNgEjiQfL
	57OCNIsILGSSuDplAzOIwyywllHi8NVL7CBVwgLeEgf+fQHrZhFQlfizdjMriM0rYC+xZP43
	qG3yEvsPnmUGsTkFHCQ+b1vBCLHNXmLb5C5miHpBiZMzn4BdxAxU37x1NvMERoFZSFKzkKQW
	MDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzcbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4
	V9teSBfiTUmsrEotyo8vKs1JLT7EaAp090RmKdHkfGDqyCuJNzQzMDU0MbM0MLU0M1YS53W7
	fD5NSCA9sSQ1OzW1ILUIpo+Jg1OqgYnfotj69dEm959fqg/bbnn06/fhq+JbKg6xcxgq5114
	PPsLy7vTEjcc91zNeqXr/aB1wfEd2i1FhTYT+lQaE58zrExJYVu9PFaor1fJo6iqRNokYM7n
	viUzH/eGTi6rYV7ycNXitszQ1Sz3BG62LOqYqf/f9KDmp5w+zukMN71t1W8xGnoJtz869vdI
	1FEbYePJ7Jq/GcTEIudeDq5NO/hT04Q9tuOg00+zxBzGteysO8xXt190m3nazjX68e+/NSo1
	Pg/TM79lXRA6KRr2aPWdZNFT2Y93HVQ566x0b9bZTWVb1dheuSy7LOiy7vpWxhMz5lfWHzsm
	b/fxo/M91uVHo+xVD5j2Gm+QXxWk4aTEUpyRaKjFXFScCAD7uQwtZQMAAA==
X-CMS-MailID: 20250311172034eucas1p12744332d95f4120a82ae8fe5e07a8d9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250311172034eucas1p12744332d95f4120a82ae8fe5e07a8d9f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250311172034eucas1p12744332d95f4120a82ae8fe5e07a8d9f
References: <20250311171900.1549916-1-m.wilczynski@samsung.com>
	<CGME20250311172034eucas1p12744332d95f4120a82ae8fe5e07a8d9f@eucas1p1.samsung.com>

The T-Head TH1520 SoC contains multiple power islands that can be
programmatically turned on and off using the AON (Always-On) protocol
and a hardware mailbox [1]. The relevant mailbox driver has already been
merged into the mainline kernel in commit 5d4d263e1c6b ("mailbox:
Introduce support for T-head TH1520 Mailbox driver");

Introduce a power-domain driver for the TH1520 SoC, which is using AON
firmware protocol to communicate with E902 core through the hardware
mailbox. This way it can send power on/off commands to the E902 core.

The interaction with AUDIO power island e.g trying to turn it OFF proved
to crash the firmware running on the E902 core. Introduce the workaround
to disable interacting with the power island.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                                |   1 +
 drivers/pmdomain/Kconfig                   |   1 +
 drivers/pmdomain/Makefile                  |   1 +
 drivers/pmdomain/thead/Kconfig             |  12 ++
 drivers/pmdomain/thead/Makefile            |   2 +
 drivers/pmdomain/thead/th1520-pm-domains.c | 218 +++++++++++++++++++++
 6 files changed, 235 insertions(+)
 create mode 100644 drivers/pmdomain/thead/Kconfig
 create mode 100644 drivers/pmdomain/thead/Makefile
 create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c

diff --git a/MAINTAINERS b/MAINTAINERS
index efef657ee528..d3061bf0e295 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20437,6 +20437,7 @@ F:	drivers/firmware/thead,th1520-aon.c
 F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
+F:	drivers/pmdomain/thead/
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
 F:	include/linux/firmware/thead/thead,th1520-aon.h
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 23c64851a5b0..91f04ace35d4 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -16,6 +16,7 @@ source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
 source "drivers/pmdomain/tegra/Kconfig"
+source "drivers/pmdomain/thead/Kconfig"
 source "drivers/pmdomain/ti/Kconfig"
 source "drivers/pmdomain/xilinx/Kconfig"
 
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index a68ece2f4c68..7030f44a49df 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -14,6 +14,7 @@ obj-y					+= st/
 obj-y					+= starfive/
 obj-y					+= sunxi/
 obj-y					+= tegra/
+obj-y					+= thead/
 obj-y					+= ti/
 obj-y					+= xilinx/
 obj-y					+= core.o governor.o
diff --git a/drivers/pmdomain/thead/Kconfig b/drivers/pmdomain/thead/Kconfig
new file mode 100644
index 000000000000..c7a1ac0c61dc
--- /dev/null
+++ b/drivers/pmdomain/thead/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config TH1520_PM_DOMAINS
+	tristate "Support TH1520 Power Domains"
+	depends on TH1520_AON_PROTOCOL || !TH1520_AON_PROTOCOL
+	select REGMAP_MMIO
+	help
+	  This driver enables power domain management for the T-HEAD
+	  TH-1520 SoC. On this SoC there are number of power domains,
+	  which can be managed independently. For example GPU, NPU,
+	  and DPU reside in their own power domains which can be
+	  turned on/off.
diff --git a/drivers/pmdomain/thead/Makefile b/drivers/pmdomain/thead/Makefile
new file mode 100644
index 000000000000..adfdf5479c68
--- /dev/null
+++ b/drivers/pmdomain/thead/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_TH1520_PM_DOMAINS)		+= th1520-pm-domains.o
diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
new file mode 100644
index 000000000000..f702e20306f4
--- /dev/null
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (c) 2024 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ */
+
+#include <linux/firmware/thead/thead,th1520-aon.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+
+#include <dt-bindings/power/thead,th1520-power.h>
+
+struct th1520_power_domain {
+	struct th1520_aon_chan *aon_chan;
+	struct generic_pm_domain genpd;
+	u32 rsrc;
+};
+
+struct th1520_power_info {
+	const char *name;
+	u32 rsrc;
+	bool disabled;
+};
+
+/*
+ * The AUDIO power domain is marked as disabled to prevent the driver from
+ * managing its power state. Direct AON firmware calls to control this power
+ * island trigger a firmware bug causing system instability. Until this
+ * firmware issue is resolved, the AUDIO power domain must remain disabled
+ * to avoid crashes.
+ */
+static const struct th1520_power_info th1520_pd_ranges[] = {
+	[TH1520_AUDIO_PD] = {"audio", TH1520_AON_AUDIO_PD, true },
+	[TH1520_VDEC_PD] = { "vdec", TH1520_AON_VDEC_PD, false },
+	[TH1520_NPU_PD] = { "npu", TH1520_AON_NPU_PD, false },
+	[TH1520_VENC_PD] = { "venc", TH1520_AON_VENC_PD, false },
+	[TH1520_GPU_PD] = { "gpu", TH1520_AON_GPU_PD, false },
+	[TH1520_DSP0_PD] = { "dsp0", TH1520_AON_DSP0_PD, false },
+	[TH1520_DSP1_PD] = { "dsp1", TH1520_AON_DSP1_PD, false }
+};
+
+static inline struct th1520_power_domain *
+to_th1520_power_domain(struct generic_pm_domain *genpd)
+{
+	return container_of(genpd, struct th1520_power_domain, genpd);
+}
+
+static int th1520_pd_power_on(struct generic_pm_domain *domain)
+{
+	struct th1520_power_domain *pd = to_th1520_power_domain(domain);
+
+	return th1520_aon_power_update(pd->aon_chan, pd->rsrc, true);
+}
+
+static int th1520_pd_power_off(struct generic_pm_domain *domain)
+{
+	struct th1520_power_domain *pd = to_th1520_power_domain(domain);
+
+	return th1520_aon_power_update(pd->aon_chan, pd->rsrc, false);
+}
+
+static struct generic_pm_domain *th1520_pd_xlate(const struct of_phandle_args *spec,
+						 void *data)
+{
+	struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
+	struct genpd_onecell_data *pd_data = data;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(th1520_pd_ranges); i++) {
+		struct th1520_power_domain *pd;
+
+		if (th1520_pd_ranges[i].disabled)
+			continue;
+
+		pd = to_th1520_power_domain(pd_data->domains[i]);
+		if (pd->rsrc == spec->args[0]) {
+			domain = &pd->genpd;
+			break;
+		}
+	}
+
+	return domain;
+}
+
+static struct th1520_power_domain *
+th1520_add_pm_domain(struct device *dev, const struct th1520_power_info *pi)
+{
+	struct th1520_power_domain *pd;
+	int ret;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	pd->rsrc = pi->rsrc;
+	pd->genpd.power_on = th1520_pd_power_on;
+	pd->genpd.power_off = th1520_pd_power_off;
+	pd->genpd.name = pi->name;
+
+	ret = pm_genpd_init(&pd->genpd, NULL, true);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pd;
+}
+
+static void th1520_pd_init_all_off(struct generic_pm_domain **domains,
+				   struct device *dev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(th1520_pd_ranges); i++) {
+		struct th1520_power_domain *pd;
+
+		if (th1520_pd_ranges[i].disabled)
+			continue;
+
+		pd = to_th1520_power_domain(domains[i]);
+
+		ret = th1520_aon_power_update(pd->aon_chan, pd->rsrc, false);
+		if (ret)
+			dev_err(dev,
+				"Failed to initially power down power domain %s\n",
+				pd->genpd.name);
+	}
+}
+
+static int th1520_pd_probe(struct platform_device *pdev)
+{
+	struct generic_pm_domain **domains;
+	struct genpd_onecell_data *pd_data;
+	struct th1520_aon_chan *aon_chan;
+	struct device *dev = &pdev->dev;
+	int i, ret;
+
+	aon_chan = th1520_aon_init(dev);
+	if (IS_ERR(aon_chan))
+		return dev_err_probe(dev, PTR_ERR(aon_chan),
+				     "Failed to get AON channel\n");
+
+	domains = devm_kcalloc(dev, ARRAY_SIZE(th1520_pd_ranges),
+			       sizeof(*domains), GFP_KERNEL);
+	if (!domains) {
+		ret = -ENOMEM;
+		goto err_clean_aon;
+	}
+
+	pd_data = devm_kzalloc(dev, sizeof(*pd_data), GFP_KERNEL);
+	if (!pd_data) {
+		ret = -ENOMEM;
+		goto err_clean_aon;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(th1520_pd_ranges); i++) {
+		struct th1520_power_domain *pd;
+
+		if (th1520_pd_ranges[i].disabled)
+			continue;
+
+		pd = th1520_add_pm_domain(dev, &th1520_pd_ranges[i]);
+		if (IS_ERR(pd)) {
+			ret = PTR_ERR(pd);
+			goto err_clean_genpd;
+		}
+
+		pd->aon_chan = aon_chan;
+		domains[i] = &pd->genpd;
+		dev_dbg(dev, "added power domain %s\n", pd->genpd.name);
+	}
+
+	pd_data->domains = domains;
+	pd_data->num_domains = ARRAY_SIZE(th1520_pd_ranges);
+	pd_data->xlate = th1520_pd_xlate;
+
+	/*
+	 * Initialize all power domains to off to ensure they start in a
+	 * low-power state. This allows device drivers to manage power
+	 * domains by turning them on or off as needed.
+	 */
+	th1520_pd_init_all_off(domains, dev);
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, pd_data);
+	if (ret)
+		goto err_clean_genpd;
+
+	return 0;
+
+err_clean_genpd:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(domains[i]);
+err_clean_aon:
+	th1520_aon_deinit(aon_chan);
+
+	return ret;
+}
+
+static const struct of_device_id th1520_pd_match[] = {
+	{ .compatible = "thead,th1520-aon" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, th1520_pd_match);
+
+static struct platform_driver th1520_pd_driver = {
+	.driver = {
+		.name = "th1520-pd",
+		.of_match_table = th1520_pd_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = th1520_pd_probe,
+};
+module_platform_driver(th1520_pd_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("T-HEAD TH1520 SoC power domain controller");
+MODULE_LICENSE("GPL");
-- 
2.34.1


