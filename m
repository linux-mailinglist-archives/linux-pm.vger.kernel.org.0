Return-Path: <linux-pm+bounces-23320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEFA4C40B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B833170C89
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823E21422D;
	Mon,  3 Mar 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BUU2JvH3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF72144C2
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013967; cv=none; b=OpNlzw/BljiMYUY3KzCT8VYNN7GAjd/yI77x87zB3VsSF6cb6ia3+tzHaj00hAgcZkMigBg3wgBJJBBIHpF+wRAI+PWj7JNCFsZosC6bmWkTBl+l8jUaYDcq8fpfeuEoBN0zw5Qjqeqqh4qR2bmAk6mYkih+qB8Y650aRwABWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013967; c=relaxed/simple;
	bh=yE/XfBNd7QLJwppkjnidARlRa53ewoZYsSCTtQtXRbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=N1a+fKq0CLRXH9UMaFrkV8dRao7D6fyZQoYYfF12fes6I7oGLCmIlBu2ofPhw9aFvnE4M+kigm5yf+5CCQ+WPTjZNY+bOf3up0mPmE5POq799YJYR2xbXXQ01h0+J7DQMxhyDUdkL0O4KQeTYjt0vT4ZSiVDAe927DxJFgTGehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BUU2JvH3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250303145922euoutp024c4ed2344e10e8d16961df320d2198e9~pUvl8vLjQ2011320113euoutp02K
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 14:59:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250303145922euoutp024c4ed2344e10e8d16961df320d2198e9~pUvl8vLjQ2011320113euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741013962;
	bh=8JUe+9f2FdzBBZ5T2K3wL+ckB8t5mydCklEUnxSUWbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUU2JvH31OTBmQhX2pwCI6H1nZ2YjdDwxuuVdnF0zmslG9XHqr54o1kVtoCA/SgyI
	 cbRAkmcVioRpOT0hLFn0HSB/E63XLoQovObvRLSxfkZvAUSWlZ5XTXh4Z3BqSC/Twq
	 hfNImgH41apJtGFIg3nQHkXA3bj9Ah1boIbhcWtA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303145921eucas1p224b00481a29c23a46ba19ccd7d0ae214~pUvlSQg_g1706417064eucas1p2e;
	Mon,  3 Mar 2025 14:59:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D3.E3.20397.9C3C5C76; Mon,  3
	Mar 2025 14:59:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250303145921eucas1p122376fdd6195916372cb13e66091b820~pUvk0agX02501125011eucas1p1Q;
	Mon,  3 Mar 2025 14:59:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303145921eusmtrp1138df0aa7d88db2f37eaf6ad5f8d220d~pUvkzsGhE2312323123eusmtrp1f;
	Mon,  3 Mar 2025 14:59:21 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-cc-67c5c3c93cdf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 95.2D.19654.9C3C5C76; Mon,  3
	Mar 2025 14:59:21 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303145920eusmtip20047c6ed356f659ed8d58ba75d62a37f~pUvj4RzFb0239102391eusmtip2I;
	Mon,  3 Mar 2025 14:59:20 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 4/5] pmdomain: thead: Add power-domain driver for TH1520
Date: Mon,  3 Mar 2025 15:59:00 +0100
Message-Id: <20250303145901.446791-5-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303145901.446791-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7onDx9NNzhxVMPi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdxWWTkpqTWZZapG+XwJVxZMJb
	loIZfhUtZ16xNDB+cuhi5OSQEDCRaPv1ibmLkYtDSGAFo8SSzklsEM4XRomGdbMYIZzPjBLf
	/i9lhWm5+uMRO0RiOaPEkU9XoFreMEqsf/ueCaSKTcBI4sHy+awgCRGBfiaJviP/wRxmgZWM
	EvcvnGUGqRIW8JZ4vP8MkM3BwSKgKrHuQQlImFfATqL12x4WiHXyEvsPngUr4RSwl/jUoAlR
	IihxcuYTsBJmoJLmrbPBnpAQ2Mwp0fD1NTtEr4vEns1XoOYIS7w6vgUqLiNxenIPVDxf4sHW
	T8wQdo3Ezp7jULa1xJ1zv9hA9jILaEqs36UPEXaUWH3sFDtIWEKAT+LGW0GIE/gkJm2bzgwR
	5pXoaBOCqFaTmNrTC7f03IptTBC2h8Sc1f9YJzAqzkLyzCwkz8xC2LuAkXkVo3hqaXFuemqx
	cV5quV5xYm5xaV66XnJ+7iZGYDo8/e/41x2MK1591DvEyMTBeIhRgoNZSYT3VvvRdCHelMTK
	qtSi/Pii0pzU4kOM0hwsSuK8i/a3pgsJpCeWpGanphakFsFkmTg4pRqYStbbvT2p+rtxmrSv
	8Lt3i7nMRNXndS3b4zB1ia/+/z2lLZm1i6q7nt3vUhJc1qy11dYqiVna4fla1aTdzBEd8yN+
	TfswSfP/uxOFYTaxBY9khBfZ+M06f5T/m0hD1PTbWsemZTXd2Bep+vy7yrPfx7b4Weg7f5fe
	2Oh5JGJng+WVR+aPmHOsvD+v2qAoHb2xrVB5+QamCwoph9y1ROvO3Ovhv1SbGLDBI+qAaGlL
	Cs+Da+skxQ+c2tewwm/fw1DdZp/Kq0/TSqOu8muUNihqSD8K1D2afpbJZ2KsUDNrxsoSFRbz
	lBOyza7lj9zuBT+bf13jyYobxYEMPZEVES9dp1cHZy+quRMa1phfoaHEUpyRaKjFXFScCADZ
	jRgp9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xe7onDx9NN5j6gNni2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdpWdTlF9akqqQkV9cYqsUbWhh
	pGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdxZMJbloIZfhUtZ16xNDB+cuhi5OSQ
	EDCRuPrjEXsXIxeHkMBSRolrXYtYIRIyEte6X7JA2MISf651sUEUvWKU2NveyAiSYBMwkniw
	fD4rSEJEYCGTxNUpG5hBHGaBtYwSh69eYgepEhbwlni8/wxQgoODRUBVYt2DEpAwr4CdROu3
	PVAb5CX2HzwLVsIpYC/xqUETxBQCKnn1iQOiWlDi5MwnYNXMQNXNW2czT2AUmIUkNQtJagEj
	0ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAuN127OeWHYwrX33UO8TIxMF4iFGCg1lJhPdW
	+9F0Id6UxMqq1KL8+KLSnNTiQ4ymQEdPZJYSTc4HJo68knhDMwNTQxMzSwNTSzNjJXFetivn
	04QE0hNLUrNTUwtSi2D6mDg4pRqYOlTzU3zy15eFxL5M3Rp1d/KUJZeOHoycopJ9/fLdM5rz
	Yg6GTdM6a+JvMkHupfffNUxL9d9fl7F7KfC7mKkyN0ahwqL470/XxX+vTUx5tZuF+Xpb9f4V
	xqd+/9/4l/Mq9zTZ2T6uzqqHFxpnbH59kP3cDaPOrZ9rty56kC5idlYx8Xhm1bYXui9Y7VLM
	t4lf1X/I8+7tiveSfWGz7HRNlhyrf2HG6bZ3jUqb3s2kL0e7H18s9cra5fqr9MOPPRG2Cfz5
	jecsTG0jvhnsmnr6vaNSW/pzDr8thy6knzF6zG2etPB3quIOrkiJXB/d6mPz35u8k7r5cI78
	3664NOGOyBt/u6Y/+WlS3fHyyuSp75VYijMSDbWYi4oTAQ8OO3JkAwAA
X-CMS-MailID: 20250303145921eucas1p122376fdd6195916372cb13e66091b820
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303145921eucas1p122376fdd6195916372cb13e66091b820
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303145921eucas1p122376fdd6195916372cb13e66091b820
References: <20250303145901.446791-1-m.wilczynski@samsung.com>
	<CGME20250303145921eucas1p122376fdd6195916372cb13e66091b820@eucas1p1.samsung.com>

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
index b2b32e431f35..e240602f0931 100644
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


