Return-Path: <linux-pm+bounces-23746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD42AA58ED8
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908B0160CA4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B72248B9;
	Mon, 10 Mar 2025 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tQpld/0T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43172248BE
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597351; cv=none; b=pyVVqo+fiBDcAu0JQN7RfQbAueZQFpv3F9aVICMQeeAvrvUbLbOzix5iHL0RsxUdQ4wi+pCBksPgpeBskr9zYDQZamg2ndCoDl8yZkalE5snFSBx4FgexXocssEcTZr86XSzrEpR5GYfZk0zubZTQru0lrmBDxE6X7ca20VW3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597351; c=relaxed/simple;
	bh=2Cj0UHyySSKIMUGOIDLH7HHcNe8kjrDIjfqtYMhIkl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Qa6GNNR3QaUwO0HQRNMoED4l0m0n5ODfY5O0mAk3va+JInDRBlxOJUJpsKvrGNAEE/np9G+5VB0kch2kaFLvfA+w5tHSZygBPBh1OLv58B6nVI7xKMKoEfK2u/ad8dngTYwRNJb99tIeRGWIyPCgcJZsJMjsXIaSRFtQbksY3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tQpld/0T; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250310090221euoutp02b8c7b685a914d066abe476e56d1130f3~rZY3o9F0p2542325423euoutp02t
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250310090221euoutp02b8c7b685a914d066abe476e56d1130f3~rZY3o9F0p2542325423euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741597341;
	bh=w+GsXN3Wp44LCIsztJaP/q7j76AjP06Bmhqu8K3VRk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQpld/0TDRTbq0fFB72fjbor9zYWmUFvdoI5iDlQVU5EWusOpPwtijvkkp0CtUKnJ
	 D4exzNrokFdNCfhngvUGejgvWV0Q5Rb7l65j0CpqTFtdKTZljkgJemXeviRj1EE7Xx
	 uoVtQsj3m2DCmr22+fbWSbOj6RdNHvtDY1RdwVmE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250310090220eucas1p283c2c59606d9717a79d4ec4c48ccb14d~rZY3L4jjv0513205132eucas1p2u;
	Mon, 10 Mar 2025 09:02:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.75.20821.C9AAEC76; Mon, 10
	Mar 2025 09:02:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250310090220eucas1p1d5cf6a56935e21b5854f77fdc22236b1~rZY2vDeIq0805808058eucas1p1y;
	Mon, 10 Mar 2025 09:02:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250310090220eusmtrp2f1a68a22e7602a443f50cfde9711a5fb~rZY2uR4BZ2373823738eusmtrp2f;
	Mon, 10 Mar 2025 09:02:20 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-57-67ceaa9c80f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FC.0F.19654.B9AAEC76; Mon, 10
	Mar 2025 09:02:20 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250310090219eusmtip2c49ff2bcf4a2d19c1202eeeaea152d91~rZY13cuPt2597425974eusmtip2R;
	Mon, 10 Mar 2025 09:02:19 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v7 4/5] pmdomain: thead: Add power-domain driver for TH1520
Date: Mon, 10 Mar 2025 10:02:10 +0100
Message-Id: <20250310090211.286549-5-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310090211.286549-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djP87pzVp1LN5jWJm/x7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO4rJJSc3JLEst0rdL4Mro+qdS
	MMOv4sj+K0wNjJ8cuhg5OSQETCQOblrJ2MXIxSEksIJR4u6nJVDOF0aJCZuuMYNUCQl8ZpR4
	+s4TpuPIillsEEXLGSXON5+BKnrDKDFxfjKIzSZgJPFg+XxWkCIRgX4mib4j/8EcZoGVjBL3
	L5wF6xAW8JZ4OH8CG4jNIqAq8ejDHrA4r4CdxLkLxxgh1slL7D8IUc8pYC/xYuMmRogaQYmT
	M5+wgNjMQDXNW2czgyyQENjMKbH9Si87RLOLxInpn5khbGGJV8e3QMVlJP7vnM8EYedLPNj6
	CaqmRmJnz3Eo21rizrlfQMdxAC3QlFi/Sx8i7Aj0/i9mkLCEAJ/EjbeCECfwSUzaNh0qzCvR
	0SYEUa0mMbWnF27puRXboJZ6SDx++J1tAqPiLCTPzELyzCyEvQsYmVcxiqeWFuempxYb5qWW
	6xUn5haX5qXrJefnbmIEJsPT/45/2sE499VHvUOMTByMhxglOJiVRHjVtp9KF+JNSaysSi3K
	jy8qzUktPsQozcGiJM67aH9rupBAemJJanZqakFqEUyWiYNTqoHJPmf/3D3cC6ZxcP05babv
	uubgPW6/9Q6prHvbpN0SXke7hvdNYijsVb7ietxQIdwo5VH9VImw/quFi27svxT4RuTJlPrZ
	pyZt5VDIyPupk+Nze71F8i37hIMMnPtZbFzmvN/TeXTT1EtLF/8RXaS1oEf3MKvmnjNZsSc/
	fpq8dWnSG89M3/flJ6qDFdpOcpeed5Kt4xe+M8XH6Ejin6yjJ5LZ7vdIdBWvtM2LaBVmnvNl
	77KV+5/e2/uy3sBTmmFe1/4jv44zCEVetN3S/IBte0HYrVfv7OI09xeEm4Ta3P3456udzboS
	o5/TyxcfWn+D2dspXKxwrr+GxhfOqjzDr+UT3k37znbkwuk9v5gUlViKMxINtZiLihMBgQcQ
	PPUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7pzVp1LNzg8h9Hi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdpWdTlF9akqqQkV9cYqsUbWhh
	pGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfR9U+lYIZfxZH9V5gaGD85dDFyckgI
	mEgcWTGLrYuRi0NIYCmjRP/NNlaIhIzEte6XLBC2sMSfa11QRa8YJS5sXwWWYBMwkniwfD4r
	SEJEYCGTxNUpG5hBHGaBtYwSh69eYgepEhbwlng4fwIbiM0ioCrx6MMeZhCbV8BO4tyFY4wQ
	K+Ql9h88CxbnFLCXeLFxE1hcCKhmR/c7Voh6QYmTM5+AbWYGqm/eOpt5AqPALCSpWUhSCxiZ
	VjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG7rZjP7fsYFz56qPeIUYmDsZDjBIczEoivGrb
	T6UL8aYkVlalFuXHF5XmpBYfYjQFunsis5Rocj4weeSVxBuaGZgamphZGphamhkrifOyXTmf
	JiSQnliSmp2aWpBaBNPHxMEp1cDU/Zx34v7ni6f773+YrHjqLK+m+2z7+onvFoWsnBsmNUH3
	m61b27UqxxPMYTvz/2wxvnuwu85kgk3Msled7IpaNVcqtnjGcTSf0BFRsJnsOVGezcMl58Um
	7fJbDncO5Op+7PthGD8x0bJaIbZN89Rjx+xD16MYXzxrf3c6NvGzDfcmdfdWiWwz0e77oa/6
	L+5q2hJ+/X5ZqYd6qz6H8dbr2os31JmrL6tULzoWNuPi78mpeVWvv/9q4/u295/EKb8tiVvP
	e/vfDX6c1f7kW3/gxQSjg213Mu94sXjc/HLUTWjTtP3P138v3nTDvE+X8WPJdjefafELWJ6t
	t9F8YLdf5vsVeZmfzAwS2hf1/u1QYinOSDTUYi4qTgQAQQ3mAmYDAAA=
X-CMS-MailID: 20250310090220eucas1p1d5cf6a56935e21b5854f77fdc22236b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250310090220eucas1p1d5cf6a56935e21b5854f77fdc22236b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250310090220eucas1p1d5cf6a56935e21b5854f77fdc22236b1
References: <20250310090211.286549-1-m.wilczynski@samsung.com>
	<CGME20250310090220eucas1p1d5cf6a56935e21b5854f77fdc22236b1@eucas1p1.samsung.com>

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
 drivers/pmdomain/thead/th1520-pm-domains.c | 209 +++++++++++++++++++++
 6 files changed, 226 insertions(+)
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
index 000000000000..7c78cf3955d2
--- /dev/null
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -0,0 +1,209 @@
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
+	int i;
+
+	aon_chan = th1520_aon_init(dev);
+	if (IS_ERR(aon_chan))
+		return dev_err_probe(dev, PTR_ERR(aon_chan),
+				     "Failed to get AON channel\n");
+
+	platform_set_drvdata(pdev, aon_chan);
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
+		if (th1520_pd_ranges[i].disabled)
+			continue;
+
+		pd = th1520_add_pm_domain(dev, &th1520_pd_ranges[i]);
+		if (IS_ERR(pd))
+			return PTR_ERR(pd);
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
+	return of_genpd_add_provider_onecell(dev->of_node, pd_data);
+}
+
+static void th1520_pd_remove(struct platform_device *pdev)
+{
+	struct th1520_aon_chan *aon_chan = platform_get_drvdata(pdev);
+
+	th1520_aon_deinit(aon_chan);
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
+	},
+	.probe = th1520_pd_probe,
+	.remove = th1520_pd_remove,
+};
+module_platform_driver(th1520_pd_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("T-HEAD TH1520 SoC power domain controller");
+MODULE_LICENSE("GPL");
-- 
2.34.1


