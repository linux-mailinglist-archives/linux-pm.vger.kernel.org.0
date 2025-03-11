Return-Path: <linux-pm+bounces-23882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81E6A5CBF9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D8F189D54A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F9262D24;
	Tue, 11 Mar 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jRsMBX8o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810522627E6
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713640; cv=none; b=pNutI3mTCO1/PFsfUs23l748L+UWWCDuQiULboMWru40muaRdH7e+GFkq5BiBXeCI9lHWIcCbxQ8TMxM3AssElUfhcANWnCCiBEiqLBamyqAgSd6oDR9uspaSPzrJOHgf/m7XgNMeVatxd2jJlfAxIwRrA5P5rJkfwPRneNkXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713640; c=relaxed/simple;
	bh=eeYMWDoZL9LyA0BEmtnhhp46+o950MSovd2jSx8T02k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Pz7GGrNeSUwKWZmbqPgOd3DPLuqhKJE5pcXerQpad4QGXImaZd9mK8KijHxSXiMHWcmcJpCAOc0L/kz9uwQfnB5P31wm5OKxrxpmUIt0C2sX3qHrWgHspw3Q/e4u4Sv7dWZX7/XDd6kRmuOjyrZgtXujHtC7M6ENJm0Z0Xu7bhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jRsMBX8o; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250311172033euoutp02eda947b3603022e12b988f86309e0b4c~rz1JqHz2_0290402904euoutp02G
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250311172033euoutp02eda947b3603022e12b988f86309e0b4c~rz1JqHz2_0290402904euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741713633;
	bh=7piyQdJ6QzftDxjYM8NMwAZ5E8bVQAIL26OpWKtuUHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jRsMBX8oCfRl1BhxAXq0Q7asmquvTdJqXUj6WF1wxTc0LJkzC+H65Hw0rrmk9W3Hs
	 Qs0mIPUbUbYhJUmazFqL0+GvgFc0nqsVcjybt01o4of/DUyggJlagA5J45AdqG67bS
	 h+/WO3kFdZVPytBkDoeV6tDaSufTCGfYC003qpGQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250311172033eucas1p2bab59f03688c0896a931c66a9b792d67~rz1JEeYQk2712227122eucas1p2T;
	Tue, 11 Mar 2025 17:20:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.A9.20397.1E070D76; Tue, 11
	Mar 2025 17:20:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250311172032eucas1p1c29eb54ff83e0b1cb84166506ecf91c9~rz1IirGBh0672906729eucas1p12;
	Tue, 11 Mar 2025 17:20:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250311172032eusmtrp121996b8d5652beae737704c2e3497ee5~rz1Ih3rIs1350113501eusmtrp1a;
	Tue, 11 Mar 2025 17:20:32 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-94-67d070e1a576
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.BD.19654.0E070D76; Tue, 11
	Mar 2025 17:20:32 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250311172031eusmtip2ab6dcdc705d85732c52ea263d719890f~rz1Hp_i7Y1726717267eusmtip2_;
	Tue, 11 Mar 2025 17:20:31 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v8 2/5] firmware: thead: Add AON firmware protocol driver
Date: Tue, 11 Mar 2025 18:18:57 +0100
Message-Id: <20250311171900.1549916-3-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311171900.1549916-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87oPCy6kG3ydyGLx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO4rJJSc3JLEst0rdL4Mq4+Umz
	4OV0xoove+ayNjA+Kuti5OSQEDCRONHcw9LFyMUhJLCCUWLmx0ZmCOcLo0TTvSvsEM5nRokv
	fTvYYVqubjgFVbWcUWJxUzcjhPOGUWLvtn9sIFVsAkYSD5bPZwVJiAj0M0n0HfkP5jALrGSU
	uH/hLDNIlbCAp0T3ondMXYwcHCwCqhIXV4qAhHkF7CW2rpsJtU5eYv9BiHJOAQeJz9tWMELU
	CEqcnPmEBcRmBqpp3job7CQJgd2cEjeXTWWGaHaROL3hFiuELSzx6vgWqKEyEqcn97BA2PkS
	D7Z+gqqvkdjZcxzKtpa4c+4XG8htzAKaEut36UOEHSXe3W0HO1lCgE/ixltBiBP4JCZtm84M
	EeaV6GgTgqhWk5ja0wu39NyKbVCdHhLfj5tPYFScheSXWUh+mYWwdgEj8ypG8dTS4tz01GLj
	vNRyveLE3OLSvHS95PzcTYzAdHj63/GvOxhXvPqod4iRiYPxEKMEB7OSCO9q2wvpQrwpiZVV
	qUX58UWlOanFhxilOViUxHkX7W9NFxJITyxJzU5NLUgtgskycXBKNTBZal/a+PukW9vxP2nn
	OJ3nJk35dWTbj1//9q8r+CFgqJzDfNd8184vtrsUOGYc/9ok8XqR+krGtvp4Iaa7x3LWSd1Z
	XLvzwrJd/Mce7poZtnHth0uLOJ3Oqxya7e03L+bk3KareT6Sf7bMbuvW/FZa8cT+X6PXzIU1
	va1+MmtfG6TzeYVPfzp3b4Rcl+2ale99TstuVZt+yn9/VvvDg8YHH+24U/TSIv76rJdFQdZW
	lR4OB1tsf/29/Ek7a1/Iwa2qfzd+5jZriljw+6yzk7NPuN//l7/O9ssVH6r1FD7qIu2+MTZu
	5Tf9qv52m/dNxp2qi3dtXRu/YufNsitmBrWtby9FaMb5uSzernJL2Pt2rRJLcUaioRZzUXEi
	AB/4WUD2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7oPCi6kG5zZL2Px7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw
	0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4+Umz4OV0xoove+ayNjA+Kuti5OSQ
	EDCRuLrhFHMXIxeHkMBSRolNx96xQyRkJK51v2SBsIUl/lzrYoMoesUosabjLhNIgk3ASOLB
	8vmsIAkRgYVMElenbAAbxSywllHi8NVLYKOEBTwluhe9A+rg4GARUJW4uFIEJMwrYC+xdd1M
	qG3yEvsPnmUGsTkFHCQ+b1vBCGILAdVsm9zFDFEvKHFy5hOwi5iB6pu3zmaewCgwC0lqFpLU
	AkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGxu+3Yzy07GFe++qh3iJGJg/EQowQHs5II
	72rbC+lCvCmJlVWpRfnxRaU5qcWHGE2Bzp7ILCWanA9MHnkl8YZmBqaGJmaWBqaWZsZK4rxs
	V86nCQmkJ5akZqemFqQWwfQxcXBKNTC5H23ctvbM35VM937bKzk9l9xcKrJh99eW7GMpb5es
	Yjv68G3e7V0OyXx1Fn86fjm5qLMyC6yfs0jt3To+jhmWt7dMP/IjTyRMy3JuZrWlkUylnwF3
	15oDdkxet9ZxHHghvnNptGxmwetkq/9hvQ+CLt529725Zul5ybfx0xlO/VG/4ShyWUulkP3K
	nsALwefZi2cW2cx89YJjh9qEFSdyXrZu/911YrdX3pIrfxb9n332Z9zp97Vyq213bS2YIX02
	P+XktslC/8K5bytaat94tz5px6ba78805qRui2kP+LvEw0bH3UjrlO5lvk3iV5tNHq09tln7
	rR/7RrVj3wIuXlc947RHNn3v13ufDE5W/lFiKc5INNRiLipOBABzTA85ZgMAAA==
X-CMS-MailID: 20250311172032eucas1p1c29eb54ff83e0b1cb84166506ecf91c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250311172032eucas1p1c29eb54ff83e0b1cb84166506ecf91c9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250311172032eucas1p1c29eb54ff83e0b1cb84166506ecf91c9
References: <20250311171900.1549916-1-m.wilczynski@samsung.com>
	<CGME20250311172032eucas1p1c29eb54ff83e0b1cb84166506ecf91c9@eucas1p1.samsung.com>

The T-Head TH1520 SoC uses an E902 co-processor running Always-On (AON)
firmware to manage power, clock, and other system resources [1]. This
patch introduces a driver implementing the AON firmware protocol,
allowing the Linux kernel to communicate with the firmware via mailbox
channels.  Through an RPC-based interface, the kernel can initiate power
state transitions, update resource configurations, and perform other
AON-related tasks.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                                   |   2 +
 drivers/firmware/Kconfig                      |   9 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/thead,th1520-aon.c           | 248 ++++++++++++++++++
 .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
 5 files changed, 460 insertions(+)
 create mode 100644 drivers/firmware/thead,th1520-aon.c
 create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 15f4bc618064..27fdf3d6a5c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20433,10 +20433,12 @@ F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
+F:	drivers/firmware/thead,th1520-aon.c
 F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
+F:	include/linux/firmware/thead/thead,th1520-aon.h
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 9f35f69e0f9e..52c145097770 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -212,6 +212,15 @@ config SYSFB_SIMPLEFB
 
 	  If unsure, say Y.
 
+config TH1520_AON_PROTOCOL
+	tristate "Always-On firmware protocol"
+	depends on ARCH_THEAD || COMPILE_TEST
+	help
+	  Power, clock, and resource management capabilities on the TH1520 SoC are
+	  managed by the E902 core. Firmware running on this core communicates with
+	  the kernel through the Always-On protocol, using hardware mailbox as a medium.
+	  Say yes if you need such capabilities.
+
 config TI_SCI_PROTOCOL
 	tristate "TI System Control Interface (TISCI) Message Protocol"
 	depends on TI_MESSAGE_MANAGER
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 7a8d486e718f..5db9c042430c 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
+obj-$(CONFIG_TH1520_AON_PROTOCOL) += thead,th1520-aon.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
diff --git a/drivers/firmware/thead,th1520-aon.c b/drivers/firmware/thead,th1520-aon.c
new file mode 100644
index 000000000000..4416e9bbf854
--- /dev/null
+++ b/drivers/firmware/thead,th1520-aon.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (c) 2024 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ */
+
+#include <linux/device.h>
+#include <linux/firmware/thead/thead,th1520-aon.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
+#include <linux/slab.h>
+
+#define MAX_RX_TIMEOUT (msecs_to_jiffies(3000))
+#define MAX_TX_TIMEOUT 500
+
+struct th1520_aon_chan {
+	struct mbox_chan *ch;
+	struct th1520_aon_rpc_ack_common ack_msg;
+	struct mbox_client cl;
+	struct completion done;
+
+	/* make sure only one RPC is performed at a time */
+	struct mutex transaction_lock;
+};
+
+struct th1520_aon_msg_req_set_resource_power_mode {
+	struct th1520_aon_rpc_msg_hdr hdr;
+	u16 resource;
+	u16 mode;
+	u16 reserved[10];
+} __packed __aligned(1);
+
+/*
+ * This type is used to indicate error response for most functions.
+ */
+enum th1520_aon_error_codes {
+	LIGHT_AON_ERR_NONE = 0, /* Success */
+	LIGHT_AON_ERR_VERSION = 1, /* Incompatible API version */
+	LIGHT_AON_ERR_CONFIG = 2, /* Configuration error */
+	LIGHT_AON_ERR_PARM = 3, /* Bad parameter */
+	LIGHT_AON_ERR_NOACCESS = 4, /* Permission error (no access) */
+	LIGHT_AON_ERR_LOCKED = 5, /* Permission error (locked) */
+	LIGHT_AON_ERR_UNAVAILABLE = 6, /* Unavailable (out of resources) */
+	LIGHT_AON_ERR_NOTFOUND = 7, /* Not found */
+	LIGHT_AON_ERR_NOPOWER = 8, /* No power */
+	LIGHT_AON_ERR_IPC = 9, /* Generic IPC error */
+	LIGHT_AON_ERR_BUSY = 10, /* Resource is currently busy/active */
+	LIGHT_AON_ERR_FAIL = 11, /* General I/O failure */
+	LIGHT_AON_ERR_LAST
+};
+
+static int th1520_aon_linux_errmap[LIGHT_AON_ERR_LAST] = {
+	0, /* LIGHT_AON_ERR_NONE */
+	-EINVAL, /* LIGHT_AON_ERR_VERSION */
+	-EINVAL, /* LIGHT_AON_ERR_CONFIG */
+	-EINVAL, /* LIGHT_AON_ERR_PARM */
+	-EACCES, /* LIGHT_AON_ERR_NOACCESS */
+	-EACCES, /* LIGHT_AON_ERR_LOCKED */
+	-ERANGE, /* LIGHT_AON_ERR_UNAVAILABLE */
+	-EEXIST, /* LIGHT_AON_ERR_NOTFOUND */
+	-EPERM, /* LIGHT_AON_ERR_NOPOWER */
+	-EPIPE, /* LIGHT_AON_ERR_IPC */
+	-EBUSY, /* LIGHT_AON_ERR_BUSY */
+	-EIO, /* LIGHT_AON_ERR_FAIL */
+};
+
+static inline int th1520_aon_to_linux_errno(int errno)
+{
+	if (errno >= LIGHT_AON_ERR_NONE && errno < LIGHT_AON_ERR_LAST)
+		return th1520_aon_linux_errmap[errno];
+
+	return -EIO;
+}
+
+static void th1520_aon_rx_callback(struct mbox_client *c, void *rx_msg)
+{
+	struct th1520_aon_chan *aon_chan =
+		container_of(c, struct th1520_aon_chan, cl);
+	struct th1520_aon_rpc_msg_hdr *hdr =
+		(struct th1520_aon_rpc_msg_hdr *)rx_msg;
+	u8 recv_size = sizeof(struct th1520_aon_rpc_msg_hdr) + hdr->size;
+
+	if (recv_size != sizeof(struct th1520_aon_rpc_ack_common)) {
+		dev_err(c->dev, "Invalid ack size, not completing\n");
+		return;
+	}
+
+	memcpy(&aon_chan->ack_msg, rx_msg, recv_size);
+	complete(&aon_chan->done);
+}
+
+/**
+ * th1520_aon_call_rpc() - Send an RPC request to the TH1520 AON subsystem
+ * @aon_chan: Pointer to the AON channel structure
+ * @msg: Pointer to the message (RPC payload) that will be sent
+ *
+ * This function sends an RPC message to the TH1520 AON subsystem via mailbox.
+ * It takes the provided @msg buffer, formats it with version and service flags,
+ * then blocks until the RPC completes or times out. The completion is signaled
+ * by the `aon_chan->done` completion, which is waited upon for a duration
+ * defined by `MAX_RX_TIMEOUT`.
+ *
+ * Return:
+ * * 0 on success
+ * * -ETIMEDOUT if the RPC call times out
+ * * A negative error code if the mailbox send fails or if AON responds with
+ *   a non-zero error code (converted via th1520_aon_to_linux_errno()).
+ */
+int th1520_aon_call_rpc(struct th1520_aon_chan *aon_chan, void *msg)
+{
+	struct th1520_aon_rpc_msg_hdr *hdr = msg;
+	int ret;
+
+	mutex_lock(&aon_chan->transaction_lock);
+	reinit_completion(&aon_chan->done);
+
+	RPC_SET_VER(hdr, TH1520_AON_RPC_VERSION);
+	RPC_SET_SVC_ID(hdr, hdr->svc);
+	RPC_SET_SVC_FLAG_MSG_TYPE(hdr, RPC_SVC_MSG_TYPE_DATA);
+	RPC_SET_SVC_FLAG_ACK_TYPE(hdr, RPC_SVC_MSG_NEED_ACK);
+
+	ret = mbox_send_message(aon_chan->ch, msg);
+	if (ret < 0) {
+		dev_err(aon_chan->cl.dev, "RPC send msg failed: %d\n", ret);
+		goto out;
+	}
+
+	if (!wait_for_completion_timeout(&aon_chan->done, MAX_RX_TIMEOUT)) {
+		dev_err(aon_chan->cl.dev, "RPC send msg timeout\n");
+		mutex_unlock(&aon_chan->transaction_lock);
+		return -ETIMEDOUT;
+	}
+
+	ret = aon_chan->ack_msg.err_code;
+
+out:
+	mutex_unlock(&aon_chan->transaction_lock);
+
+	return th1520_aon_to_linux_errno(ret);
+}
+EXPORT_SYMBOL_GPL(th1520_aon_call_rpc);
+
+/**
+ * th1520_aon_power_update() - Change power state of a resource via TH1520 AON
+ * @aon_chan: Pointer to the AON channel structure
+ * @rsrc: Resource ID whose power state needs to be updated
+ * @power_on: Boolean indicating whether the resource should be powered on (true)
+ *            or powered off (false)
+ *
+ * This function requests the TH1520 AON subsystem to set the power mode of the
+ * given resource (@rsrc) to either on or off. It constructs the message in
+ * `struct th1520_aon_msg_req_set_resource_power_mode` and then invokes
+ * th1520_aon_call_rpc() to make the request. If the AON call fails, an error
+ * message is logged along with the specific return code.
+ *
+ * Return:
+ * * 0 on success
+ * * A negative error code in case of failures (propagated from
+ *   th1520_aon_call_rpc()).
+ */
+int th1520_aon_power_update(struct th1520_aon_chan *aon_chan, u16 rsrc,
+			    bool power_on)
+{
+	struct th1520_aon_msg_req_set_resource_power_mode msg = {};
+	struct th1520_aon_rpc_msg_hdr *hdr = &msg.hdr;
+	int ret;
+
+	hdr->svc = TH1520_AON_RPC_SVC_PM;
+	hdr->func = TH1520_AON_PM_FUNC_SET_RESOURCE_POWER_MODE;
+	hdr->size = TH1520_AON_RPC_MSG_NUM;
+
+	RPC_SET_BE16(&msg.resource, 0, rsrc);
+	RPC_SET_BE16(&msg.resource, 2,
+		     (power_on ? TH1520_AON_PM_PW_MODE_ON :
+				 TH1520_AON_PM_PW_MODE_OFF));
+
+	ret = th1520_aon_call_rpc(aon_chan, &msg);
+	if (ret)
+		dev_err(aon_chan->cl.dev, "failed to power %s resource %d ret %d\n",
+			power_on ? "up" : "off", rsrc, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(th1520_aon_power_update);
+
+/**
+ * th1520_aon_init() - Initialize TH1520 AON firmware protocol interface
+ * @dev: Device pointer for the AON subsystem
+ *
+ * This function initializes the TH1520 AON firmware protocol interface by:
+ * - Allocating and initializing the AON channel structure
+ * - Setting up the mailbox client
+ * - Requesting the AON mailbox channel
+ * - Initializing synchronization primitives
+ *
+ * Return:
+ * * Valid pointer to th1520_aon_chan structure on success
+ * * ERR_PTR(-ENOMEM) if memory allocation fails
+ * * ERR_PTR() with other negative error codes from mailbox operations
+ */
+struct th1520_aon_chan *th1520_aon_init(struct device *dev)
+{
+	struct th1520_aon_chan *aon_chan;
+	struct mbox_client *cl;
+
+	aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
+	if (!aon_chan)
+		return ERR_PTR(-ENOMEM);
+
+	cl = &aon_chan->cl;
+	cl->dev = dev;
+	cl->tx_block = true;
+	cl->tx_tout = MAX_TX_TIMEOUT;
+	cl->rx_callback = th1520_aon_rx_callback;
+
+	aon_chan->ch = mbox_request_channel_byname(cl, "aon");
+	if (IS_ERR(aon_chan->ch)) {
+		dev_err(dev, "Failed to request aon mbox chan\n");
+		kfree(aon_chan);
+		return ERR_CAST(aon_chan->ch);
+	}
+
+	mutex_init(&aon_chan->transaction_lock);
+	init_completion(&aon_chan->done);
+
+	return aon_chan;
+}
+EXPORT_SYMBOL_GPL(th1520_aon_init);
+
+/**
+ * th1520_aon_deinit() - Clean up TH1520 AON firmware protocol interface
+ * @aon_chan: Pointer to the AON channel structure to clean up
+ *
+ * This function cleans up resources allocated by th1520_aon_init():
+ * - Frees the mailbox channel
+ * - Frees the AON channel
+ */
+void th1520_aon_deinit(struct th1520_aon_chan *aon_chan)
+{
+	mbox_free_channel(aon_chan->ch);
+	kfree(aon_chan);
+}
+EXPORT_SYMBOL_GPL(th1520_aon_deinit);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("T-HEAD TH1520 Always-On firmware protocol library");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/thead/thead,th1520-aon.h b/include/linux/firmware/thead/thead,th1520-aon.h
new file mode 100644
index 000000000000..dae132b66873
--- /dev/null
+++ b/include/linux/firmware/thead/thead,th1520-aon.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ */
+
+#ifndef _THEAD_AON_H
+#define _THEAD_AON_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#define AON_RPC_MSG_MAGIC (0xef)
+#define TH1520_AON_RPC_VERSION 2
+#define TH1520_AON_RPC_MSG_NUM 7
+
+struct th1520_aon_chan;
+
+enum th1520_aon_rpc_svc {
+	TH1520_AON_RPC_SVC_UNKNOWN = 0,
+	TH1520_AON_RPC_SVC_PM = 1,
+	TH1520_AON_RPC_SVC_MISC = 2,
+	TH1520_AON_RPC_SVC_AVFS = 3,
+	TH1520_AON_RPC_SVC_SYS = 4,
+	TH1520_AON_RPC_SVC_WDG = 5,
+	TH1520_AON_RPC_SVC_LPM = 6,
+	TH1520_AON_RPC_SVC_MAX = 0x3F,
+};
+
+enum th1520_aon_misc_func {
+	TH1520_AON_MISC_FUNC_UNKNOWN = 0,
+	TH1520_AON_MISC_FUNC_SET_CONTROL = 1,
+	TH1520_AON_MISC_FUNC_GET_CONTROL = 2,
+	TH1520_AON_MISC_FUNC_REGDUMP_CFG = 3,
+};
+
+enum th1520_aon_wdg_func {
+	TH1520_AON_WDG_FUNC_UNKNOWN = 0,
+	TH1520_AON_WDG_FUNC_START = 1,
+	TH1520_AON_WDG_FUNC_STOP = 2,
+	TH1520_AON_WDG_FUNC_PING = 3,
+	TH1520_AON_WDG_FUNC_TIMEOUTSET = 4,
+	TH1520_AON_WDG_FUNC_RESTART = 5,
+	TH1520_AON_WDG_FUNC_GET_STATE = 6,
+	TH1520_AON_WDG_FUNC_POWER_OFF = 7,
+	TH1520_AON_WDG_FUNC_AON_WDT_ON = 8,
+	TH1520_AON_WDG_FUNC_AON_WDT_OFF = 9,
+};
+
+enum th1520_aon_sys_func {
+	TH1520_AON_SYS_FUNC_UNKNOWN = 0,
+	TH1520_AON_SYS_FUNC_AON_RESERVE_MEM = 1,
+};
+
+enum th1520_aon_lpm_func {
+	TH1520_AON_LPM_FUNC_UNKNOWN = 0,
+	TH1520_AON_LPM_FUNC_REQUIRE_STR = 1,
+	TH1520_AON_LPM_FUNC_RESUME_STR = 2,
+	TH1520_AON_LPM_FUNC_REQUIRE_STD = 3,
+	TH1520_AON_LPM_FUNC_CPUHP = 4,
+	TH1520_AON_LPM_FUNC_REGDUMP_CFG = 5,
+};
+
+enum th1520_aon_pm_func {
+	TH1520_AON_PM_FUNC_UNKNOWN = 0,
+	TH1520_AON_PM_FUNC_SET_RESOURCE_REGULATOR = 1,
+	TH1520_AON_PM_FUNC_GET_RESOURCE_REGULATOR = 2,
+	TH1520_AON_PM_FUNC_SET_RESOURCE_POWER_MODE = 3,
+	TH1520_AON_PM_FUNC_PWR_SET = 4,
+	TH1520_AON_PM_FUNC_PWR_GET = 5,
+	TH1520_AON_PM_FUNC_CHECK_FAULT = 6,
+	TH1520_AON_PM_FUNC_GET_TEMPERATURE = 7,
+};
+
+struct th1520_aon_rpc_msg_hdr {
+	u8 ver; /* version of msg hdr */
+	u8 size; /*  msg size ,uinit in bytes,the size includes rpc msg header self */
+	u8 svc; /* rpc main service id */
+	u8 func; /* rpc sub func id of specific service, sent by caller */
+} __packed __aligned(1);
+
+struct th1520_aon_rpc_ack_common {
+	struct th1520_aon_rpc_msg_hdr hdr;
+	u8 err_code;
+} __packed __aligned(1);
+
+#define RPC_SVC_MSG_TYPE_DATA 0
+#define RPC_SVC_MSG_TYPE_ACK 1
+#define RPC_SVC_MSG_NEED_ACK 0
+#define RPC_SVC_MSG_NO_NEED_ACK 1
+
+#define RPC_GET_VER(MESG) ((MESG)->ver)
+#define RPC_SET_VER(MESG, VER) ((MESG)->ver = (VER))
+#define RPC_GET_SVC_ID(MESG) ((MESG)->svc & 0x3F)
+#define RPC_SET_SVC_ID(MESG, ID) ((MESG)->svc |= 0x3F & (ID))
+#define RPC_GET_SVC_FLAG_MSG_TYPE(MESG) (((MESG)->svc & 0x80) >> 7)
+#define RPC_SET_SVC_FLAG_MSG_TYPE(MESG, TYPE) ((MESG)->svc |= (TYPE) << 7)
+#define RPC_GET_SVC_FLAG_ACK_TYPE(MESG) (((MESG)->svc & 0x40) >> 6)
+#define RPC_SET_SVC_FLAG_ACK_TYPE(MESG, ACK) ((MESG)->svc |= (ACK) << 6)
+
+#define RPC_SET_BE64(MESG, OFFSET, SET_DATA)                                \
+	do {                                                                \
+		u8 *data = (u8 *)(MESG);                                    \
+		u64 _offset = (OFFSET);                                     \
+		u64 _set_data = (SET_DATA);                                 \
+		data[_offset + 7] = _set_data & 0xFF;                       \
+		data[_offset + 6] = (_set_data & 0xFF00) >> 8;              \
+		data[_offset + 5] = (_set_data & 0xFF0000) >> 16;           \
+		data[_offset + 4] = (_set_data & 0xFF000000) >> 24;         \
+		data[_offset + 3] = (_set_data & 0xFF00000000) >> 32;       \
+		data[_offset + 2] = (_set_data & 0xFF0000000000) >> 40;     \
+		data[_offset + 1] = (_set_data & 0xFF000000000000) >> 48;   \
+		data[_offset + 0] = (_set_data & 0xFF00000000000000) >> 56; \
+	} while (0)
+
+#define RPC_SET_BE32(MESG, OFFSET, SET_DATA)			    \
+	do {							    \
+		u8 *data = (u8 *)(MESG);			    \
+		u64 _offset = (OFFSET);				    \
+		u64 _set_data = (SET_DATA);			    \
+		data[_offset + 3] = (_set_data) & 0xFF;		    \
+		data[_offset + 2] = (_set_data & 0xFF00) >> 8;	    \
+		data[_offset + 1] = (_set_data & 0xFF0000) >> 16;   \
+		data[_offset + 0] = (_set_data & 0xFF000000) >> 24; \
+	} while (0)
+
+#define RPC_SET_BE16(MESG, OFFSET, SET_DATA)		       \
+	do {						       \
+		u8 *data = (u8 *)(MESG);		       \
+		u64 _offset = (OFFSET);			       \
+		u64 _set_data = (SET_DATA);		       \
+		data[_offset + 1] = (_set_data) & 0xFF;	       \
+		data[_offset + 0] = (_set_data & 0xFF00) >> 8; \
+	} while (0)
+
+#define RPC_SET_U8(MESG, OFFSET, SET_DATA)	  \
+	do {					  \
+		u8 *data = (u8 *)(MESG);	  \
+		data[OFFSET] = (SET_DATA) & 0xFF; \
+	} while (0)
+
+#define RPC_GET_BE64(MESG, OFFSET, PTR)                                      \
+	do {                                                                 \
+		u8 *data = (u8 *)(MESG);                                     \
+		u64 _offset = (OFFSET);                                      \
+		*(u32 *)(PTR) =                                              \
+			(data[_offset + 7] | data[_offset + 6] << 8 |        \
+			 data[_offset + 5] << 16 | data[_offset + 4] << 24 | \
+			 data[_offset + 3] << 32 | data[_offset + 2] << 40 | \
+			 data[_offset + 1] << 48 | data[_offset + 0] << 56); \
+	} while (0)
+
+#define RPC_GET_BE32(MESG, OFFSET, PTR)                                      \
+	do {                                                                 \
+		u8 *data = (u8 *)(MESG);                                     \
+		u64 _offset = (OFFSET);                                      \
+		*(u32 *)(PTR) =                                              \
+			(data[_offset + 3] | data[_offset + 2] << 8 |        \
+			 data[_offset + 1] << 16 | data[_offset + 0] << 24); \
+	} while (0)
+
+#define RPC_GET_BE16(MESG, OFFSET, PTR)                                       \
+	do {                                                                  \
+		u8 *data = (u8 *)(MESG);                                      \
+		u64 _offset = (OFFSET);                                       \
+		*(u16 *)(PTR) = (data[_offset + 1] | data[_offset + 0] << 8); \
+	} while (0)
+
+#define RPC_GET_U8(MESG, OFFSET, PTR)          \
+	do {                                   \
+		u8 *data = (u8 *)(MESG);       \
+		*(u8 *)(PTR) = (data[OFFSET]); \
+	} while (0)
+
+/*
+ * Defines for SC PM Power Mode
+ */
+#define TH1520_AON_PM_PW_MODE_OFF 0 /* Power off */
+#define TH1520_AON_PM_PW_MODE_STBY 1 /* Power in standby */
+#define TH1520_AON_PM_PW_MODE_LP 2 /* Power in low-power */
+#define TH1520_AON_PM_PW_MODE_ON 3 /* Power on */
+
+/*
+ * Defines for AON power islands
+ */
+#define TH1520_AON_AUDIO_PD 0
+#define TH1520_AON_VDEC_PD 1
+#define TH1520_AON_NPU_PD 2
+#define TH1520_AON_VENC_PD 3
+#define TH1520_AON_GPU_PD 4
+#define TH1520_AON_DSP0_PD 5
+#define TH1520_AON_DSP1_PD 6
+
+struct th1520_aon_chan *th1520_aon_init(struct device *dev);
+void th1520_aon_deinit(struct th1520_aon_chan *aon_chan);
+
+int th1520_aon_call_rpc(struct th1520_aon_chan *aon_chan, void *msg);
+int th1520_aon_power_update(struct th1520_aon_chan *aon_chan, u16 rsrc,
+			    bool power_on);
+
+#endif /* _THEAD_AON_H */
-- 
2.34.1


