Return-Path: <linux-pm+bounces-18463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162699E1DEF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D153B1663E7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6BF1F708C;
	Tue,  3 Dec 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nb65zFn2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAE1F6662
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233329; cv=none; b=egPqDzP+cT7dGefatjB84un9Hte3iUjkaSBmYMecMvvhFkMlAaMGilTWoh8s2JUoMlTmxq4HoIa4E4hSmk4ysvwTUTa9+b0JWQxn10DwDO6JTlBFFQR42CWi1q5qr7NaHSR4qlscGq9iMyRBgwjD9/B/2W61HMeaw1EssVdKuME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233329; c=relaxed/simple;
	bh=5FTMoHzrWaSVFbnPl/ZGYfd0/qy04CJiUOOnbOLkLA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qu9GBnGcN87SGgua8Nbe/SkmB/jsDm2eD3HPic9qcODCV1CXS++Rkp5cZKsrApTRDDfzuf6Y+jM9Io4rKtmq5Tw7I8hBMdImxriFo4Onr2OC7lUMwgDMup6zYpkGV5/4LdVbggkAjwcVnRHXwlR6+wSrHNgxXqljD/UyO9tYjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Nb65zFn2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134159euoutp0207252c3cd716693fdb97a3df83d0ebdf~NroVLU9Tv0142101421euoutp02M
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:41:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241203134159euoutp0207252c3cd716693fdb97a3df83d0ebdf~NroVLU9Tv0142101421euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233319;
	bh=7vWqCZHhnB/kLRjyQw7yTqQkPU5mCbGCFqBzjoU0MzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nb65zFn2X11EO4+ngZDIwKFne/C5HincZiOH/T7iZD1gwKWqU5jpzaz9WtTyhL1x9
	 5ky7rCn+4/PUmaPvfD8BFlx4uY69vQKEDkUdUl9eJ3lIdnaMjerBkMSN+76xTg4f7m
	 uHV8ZtLsGHJcyCwKTU/ns3RUGRC+CSsLB94v8PLs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241203134158eucas1p173695b11180e65af1b0adbb42951dab5~NroUtbWfG2135221352eucas1p1-;
	Tue,  3 Dec 2024 13:41:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 66.8F.20409.6AA0F476; Tue,  3
	Dec 2024 13:41:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241203134158eucas1p1fae346180c0166570ea7e7723076225c~NroUMMsZz2466124661eucas1p1u;
	Tue,  3 Dec 2024 13:41:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134158eusmtrp12c6e026a48b1b32a921993c6bf37ce78~NroULWYK40888908889eusmtrp1G;
	Tue,  3 Dec 2024 13:41:58 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-8b-674f0aa6ed9a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.F6.19654.5AA0F476; Tue,  3
	Dec 2024 13:41:57 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134156eusmtip28456b9c6ad65c0da49bb5bf6132bdc18~NroS3YUQb3010130101eusmtip2Y;
	Tue,  3 Dec 2024 13:41:56 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC PATCH v1 07/14] soc: thead: power-domain: Add skeleton
 power-domain driver for TH1520
Date: Tue,  3 Dec 2024 14:41:30 +0100
Message-Id: <20241203134137.2114847-8-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVBUdRSd33tv33u7uPZYGfYXYdYSNFECYU0/0UlzMt72YVIzfVlDWzwX
	R2BtV0QTYw1aAVekwBgWi8URlhgIgWWDBeRzWA3cCBI2gwUVQoRYiI9GCozlYfnfueeec8+9
	M5fGJRdIH3pf3EFOHaeIkZEiwtJ+56eNRaLXlSEu5yPoUt85DFX/baBQaYMdQ/ltdgFydpsx
	9Muci0Tfj3RR6FbDcQL1Fn9DoeT2chKNGZwkmtY7BajHepZEM6faALLMpJCorG2AQuVz+Rgq
	mK4m0PkaK0C6tCIB+vnHnWisR48jneEBdLe+hkJLvRUEyptspJB54ksBspW9jVIas4nt61mX
	4wuKnRgbI9jW1FmKbZg3EmytYYBi9bWdgK0sSSPZ/t56kv32cgQ7eNKGsVXnk9iUsnaMdV28
	SrIZ5hLAdif3UWxVx9Hdnu+JtkZxMfsOcerg5z8URd8xLhEHTu8+nFEo1ILqHelASEPmGVg4
	awbpQERLmGIAU+Ydq8UsgFdzckm+mAHw+s0e8p7FWXFOwDdMAFpLf1u1TACorx8i3CqSCYVD
	pvwVlRczjkPH3K8rs3BmFEDL8NmVWesYDpZ3li07aJpg/OGo9kE3LWa2wZtfTwM+bgNsbL6C
	u7GQ2Q7Hz6QLeI0nvJw7vBKGL2uSq/Nw93zIfCeCC66RVfOLcLbdifN4HbxtM1M89oUdWXqC
	xyo4VP3nqiYR1uptq3gL7LcvkO7dcOYJWG4N5ukXYGu3iXLTkFkLHX948iushV9ZcnCeFsNU
	nYRXB8Az+lP/hdqLLRgvYWFRg0cmeNRw3y2G+24x/B9rBHgJkHLxmlglpwmN4xKCNIpYTXyc
	MuhjVWwlWH7qjiXbbA0w3Z4OagEYDVoApHGZl9hU/opSIo5SHPmUU6si1fExnKYFPEQTMqnY
	P2oDJ2GUioPcfo47wKnvdTFa6KPFPHyPjrw1WVnQt+lh6WCi/ql3w4YV1/Q5j0csNj3miNZm
	Nx0LfNL8UZ12l1fi5xt3VX3WXZmQkeW3NbFLdaJ5R7D3jfBn5a/p7GHyd9AoXRqQRR2qc/iN
	zcWP9l6Kmmzd1PoXaBoYZ+kW7p/OJqnVYG2zaxNuLP+S58KRRWbgkzWJb4aXJCWZ6vac9sl2
	bgm4FfnB1FTX5nk/zzVM/6I8ds/evMjUzIKXMguFsmMoN9y/U/6GV0fg70afcKP5Od+THutV
	WNqrxyXS8SsXhXcPR/zAXbNkFdkl8m3eIaW4JHmwzjaV2t2cs9cnPazSkYeHbJadCPWG1xGn
	qtC9n7//5QsyQhOteDoQV2sU/wI4FoW5QwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xe7pLufzTDf4etrQ4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZfxc8I+loD+gom8pZwPjVqcuRk4OCQETiXsbF7F2MXJxCAksZZT482cmM0RCRuJa
	90sWCFtY4s+1LjaIoleMEg29S9lBEmwCRhIPls8H6xYR6GSReLt5LSOIwyzwllHi+syNYO3C
	AskSh7e/B7I5OFgEVCWeN0iChHkF7CUeT/vICLFBXmL/wbNgmzkFHCReT+1iBbGFgGp2/D3M
	ClEvKHFy5hOwkcxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxN
	jMCksu3Yzy07GFe++qh3iJGJg/EQowQHs5II7/L13ulCvCmJlVWpRfnxRaU5qcWHGE2Bzp7I
	LCWanA9Ma3kl8YZmBqaGJmaWBqaWZsZK4rxsV86nCQmkJ5akZqemFqQWwfQxcXBKNTCpGcSs
	cd374kTRp6KWxQeUZn15oLndv3ny5L5LbmK6PLIbi6V/S2yct1BxYd2+vyFLrtR+aNzolfz7
	wUSBBy/kcgWyzmRyJz+1yqnRvBAmabntY/z99oUHipqbs9/uL18++77GA4WWhldZuz5+PZ3A
	Ja8QwbF5kespxcjivPOes5V/ZNvwicb3z5kk/t0ouCxkYtDODceTAruN35cZunEdl/zGtSwg
	bOaBNWyLd7OsKOayPPxjJWfzZsZnk5eezhI3L95eu2fHUe5Pq8vYdRMvrOPz/N4QEpBS2fF7
	e/h2r0MPN/5ME6l/WM4dFrRJoLol8YL2ir8tezWeOwdLTtU0yBLsP5Zb0frizHaZA7eVWIoz
	Eg21mIuKEwEgVJCeswMAAA==
X-CMS-MailID: 20241203134158eucas1p1fae346180c0166570ea7e7723076225c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134158eucas1p1fae346180c0166570ea7e7723076225c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134158eucas1p1fae346180c0166570ea7e7723076225c
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134158eucas1p1fae346180c0166570ea7e7723076225c@eucas1p1.samsung.com>

The T-Head TH1520 SoC contains multiple power islands that can be
programmatically turned on and off using the AON (Always-On) protocol
and a hardware mailbox [1]. The relevant mailbox driver has already been
merged into the mainline kernel in commit 5d4d263e1c6b ("mailbox:
Introduce support for T-head TH1520 Mailbox driver"); however, the AON
implementation is still under development.

This commit introduces a skeleton power-domain driver for the TH1520
SoC, designed to be easily extended to work with the AON protocol in the
future.  Currently, it only supports the GPU. Since there is no
mechanism yet to turn the GPU power island on, the driver will only set
the relevant registers to bring the GPU out of the reset state.  This
should be done after the power-up sequence requested through the mailbox
is completed.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                                   |   2 +
 drivers/pmdomain/Kconfig                      |   1 +
 drivers/pmdomain/Makefile                     |   1 +
 drivers/pmdomain/thead/Kconfig                |  12 ++
 drivers/pmdomain/thead/Makefile               |   2 +
 drivers/pmdomain/thead/th1520-pm-domains.c    | 195 ++++++++++++++++++
 .../dt-bindings/power/thead,th1520-power.h    |  19 ++
 7 files changed, 232 insertions(+)
 create mode 100644 drivers/pmdomain/thead/Kconfig
 create mode 100644 drivers/pmdomain/thead/Makefile
 create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
 create mode 100644 include/dt-bindings/power/thead,th1520-power.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f8f529e6a31..16fb58aa74b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20192,7 +20192,9 @@ F:	drivers/clk/thead/
 F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
+F:	drivers/pmdomain/thead/th1520-pm-domains.c
 F:	include/dt-bindings/clock/thead,th1520-clk.h
+F:	include/dt-bindings/power/thead,th1520-power.h
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
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
index 000000000000..8a063b3b96f3
--- /dev/null
+++ b/drivers/pmdomain/thead/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config TH1520_PM_DOMAINS
+	bool "Support TH1520 Power Domains"
+	depends on ARCH_THEAD || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  This driver enables power domain management for the T-HEAD
+	  TH-1520 SoC. On this SoC there are number of power domains,
+	  which can be managed independently. For example GPU, AUDIO,
+	  NPU, DPU reside in their own power domains which can be
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
index 000000000000..60bdd011b017
--- /dev/null
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (c) 2024 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/power/thead,th1520-power.h>
+
+/* register offset in VOSYS_REGMAP */
+#define TH1520_GPU_RST_CFG		0x0
+#define TH1520_GPU_RST_CFG_MASK		GENMASK(2, 0)
+
+/* register values */
+#define TH1520_GPU_SW_GPU_RST		BIT(0)
+#define TH1520_GPU_SW_CLKGEN_RST	BIT(1)
+
+struct th1520_power_domain {
+	struct regmap *reg;
+	struct generic_pm_domain genpd;
+	u32 rsrc;
+};
+
+struct th1520_power_info {
+	char *name;
+	u32 rsrc;
+};
+
+static const struct th1520_power_info th1520_pd_ranges[] = {
+	{ "gpu", TH1520_AON_GPU_PD }
+};
+
+static inline struct th1520_power_domain *
+to_th1520_power_domain(struct generic_pm_domain *genpd)
+{
+	return container_of(genpd, struct th1520_power_domain, genpd);
+}
+
+static void th1520_rst_gpu_enable(struct regmap *reg)
+{
+	int val;
+
+	/* if the GPU is not in a reset state it, put it into one */
+	regmap_read(reg, TH1520_GPU_RST_CFG, &val);
+	if (val) {
+		regmap_update_bits(reg, TH1520_GPU_RST_CFG,
+				   TH1520_GPU_RST_CFG_MASK, 0x0);
+	}
+
+	/* rst gpu clkgen */
+	regmap_set_bits(reg, TH1520_GPU_RST_CFG, TH1520_GPU_SW_CLKGEN_RST);
+	/* rst gpu */
+	regmap_set_bits(reg, TH1520_GPU_RST_CFG, TH1520_GPU_SW_GPU_RST);
+}
+
+static void th1520_rst_gpu_disable(struct regmap *reg)
+{
+	regmap_update_bits(reg, TH1520_GPU_RST_CFG, TH1520_GPU_RST_CFG_MASK, 0x0);
+}
+
+static int th1520_pd_power_on(struct generic_pm_domain *domain)
+{
+	struct th1520_power_domain *pd = to_th1520_power_domain(domain);
+
+	/* The missing component here is the call to E902 core through the
+	 * AON protocol using hardware mailbox.
+	 */
+
+	/* Initially after the power up the GPU and GPU clocks are
+	 * in the reset state. Get them from that state to normal operation.
+	 */
+	th1520_rst_gpu_enable(pd->reg);
+
+	return 0;
+}
+
+static int th1520_pd_power_off(struct generic_pm_domain *domain)
+{
+	struct th1520_power_domain *pd = to_th1520_power_domain(domain);
+
+	/* The missing component here is the call to E902 core through the
+	 * AON protocol using hardware mailbox.
+	 */
+
+	/* Put the GPU into reset state after powering it off */
+	th1520_rst_gpu_disable(pd->reg);
+
+	return 0;
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
+	if (ret) {
+		devm_kfree(dev, pd);
+		return ERR_PTR(ret);
+	}
+
+	return pd;
+}
+
+static int th1520_pd_probe(struct platform_device *pdev)
+{
+	struct generic_pm_domain **domains;
+	struct genpd_onecell_data *pd_data;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct regmap *reg;
+	int i;
+
+	reg = syscon_regmap_lookup_by_phandle(np, "thead,vosys-regmap");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	domains = devm_kcalloc(dev, ARRAY_SIZE(th1520_pd_ranges),
+			       sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	pd_data = devm_kzalloc(dev, sizeof(*pd_data), GFP_KERNEL);
+	if (!pd_data)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(th1520_pd_ranges); i++) {
+		struct th1520_power_domain *pd;
+
+		pd = th1520_add_pm_domain(dev, &th1520_pd_ranges[i]);
+		if (IS_ERR_OR_NULL(pd))
+			continue;
+
+		pd->reg = reg;
+		domains[i] = &pd->genpd;
+		dev_dbg(dev, "added power domain %s\n", pd->genpd.name);
+	}
+
+	pd_data->domains = domains;
+	pd_data->num_domains = ARRAY_SIZE(th1520_pd_ranges);
+	pd_data->xlate = th1520_pd_xlate;
+
+	return of_genpd_add_provider_onecell(dev->of_node, pd_data);
+}
+
+static const struct of_device_id th1520_pd_match[] = {
+	{ .compatible = "thead,th1520-pd",},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver th1520_pd_driver = {
+	.driver = {
+		.name = "th1520-pd",
+		.of_match_table = th1520_pd_match,
+	},
+	.probe = th1520_pd_probe,
+};
+builtin_platform_driver(th1520_pd_driver);
diff --git a/include/dt-bindings/power/thead,th1520-power.h b/include/dt-bindings/power/thead,th1520-power.h
new file mode 100644
index 000000000000..30fb4e9892e7
--- /dev/null
+++ b/include/dt-bindings/power/thead,th1520-power.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Alibaba Group Holding Limited.
+ * Copyright (c) 2024 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ */
+
+#ifndef __DT_BINDINGS_POWER_TH1520_H
+#define __DT_BINDINGS_POWER_TH1520_H
+
+#define TH1520_AON_AUDIO_PD	0
+#define TH1520_AON_VDEC_PD	1
+#define TH1520_AON_NPU_PD	2
+#define TH1520_AON_VENC_PD	3
+#define TH1520_AON_GPU_PD	4
+#define TH1520_AON_DSP0_PD	5
+#define TH1520_AON_DSP1_PD	6
+
+#endif
-- 
2.34.1


