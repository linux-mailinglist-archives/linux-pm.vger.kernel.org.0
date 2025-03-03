Return-Path: <linux-pm+bounces-23318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11003A4C406
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA361188E88B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E72144C7;
	Mon,  3 Mar 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GJ2Ei2mg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39F213E61
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013965; cv=none; b=d/xyETRxuvoo7YErDqJYiFp2OJRxhnSr/BQRStAOKXG2+wtKI+A3pb1NhZZkJUbE7ZYFfgFJPC03gyEEduNshs5Wb6v+IR4uXAN7FRCahfcUdX9YS0Y50sboDjTP0OxH9rCTXXLPtEzDkX5WlWEdHhOq/LQDVrVjgacJjNegV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013965; c=relaxed/simple;
	bh=uCfVFb/txRCfmFxJ4+6SlRUWu2HOr0nXb+a0S6WwnRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=FiLd+OL7MyPd4hos+3NNQbRJpAtFzzDS34CTBxR42/DwPCMTLLWcY+9p8DV4PQKecY6fNVAtxoVL/8bA819jTMwZHh8M2SbctHSqJjBNJu8YjcyNk3ofW9uuR6MlnPy1VnBz8YuvmQpY5ODaZuBKyaqgaKEi8LYJ4hU4bfbNi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GJ2Ei2mg; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250303145920euoutp01bc3729fe804f6ccf1a47f64f2dde3284~pUvkMYZ_80490504905euoutp01E
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 14:59:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250303145920euoutp01bc3729fe804f6ccf1a47f64f2dde3284~pUvkMYZ_80490504905euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741013960;
	bh=ycx89frYJE0l6BOMe49Vmtw2QSwzJUtNGydH2vz5J0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJ2Ei2mgAdV5uUjtTqJxbqEATFn1izyRFe0jCCLteaRr76D5YddjYecXJh2YWpVmq
	 tIl1O+gX05Bb75d648wz7UdlAlhETBEw8LOdXctoaxPItKTYqI3ryiTeB/YlkkNTLm
	 9XSDiU14JXEJYFAsDc4BqB9yZOl1t3FJzyzHTnuI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303145919eucas1p2c395444b01f97fb1f2908e3f23f9b7fc~pUvjluP2B3212832128eucas1p2b;
	Mon,  3 Mar 2025 14:59:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id EC.D3.20397.7C3C5C76; Mon,  3
	Mar 2025 14:59:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250303145919eucas1p123e4b3ab94c67b7538a088be350372b4~pUvjJL0n_2501125011eucas1p1O;
	Mon,  3 Mar 2025 14:59:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303145919eusmtrp1828ee6d918558e3e65c768cc0d68bd3e~pUvjIWUFS2312323123eusmtrp1b;
	Mon,  3 Mar 2025 14:59:19 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-c6-67c5c3c7654f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 62.2D.19654.7C3C5C76; Mon,  3
	Mar 2025 14:59:19 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303145918eusmtip2fd020107a70bec49772d66fa7923dfba~pUviWhsAD0239102391eusmtip2H;
	Mon,  3 Mar 2025 14:59:18 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 2/5] firmware: thead: Add AON firmware protocol driver
Date: Mon,  3 Mar 2025 15:58:58 +0100
Message-Id: <20250303145901.446791-3-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303145901.446791-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87rHDx9NN5gwydji2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdxWWTkpqTWZZapG+XwJWx64B/
	wfnpjBVzL51ja2A8XdbFyMkhIWAi8ad9PTOILSSwglGi6Ux1FyMXkP2FUeLY3JvsEM5nRomF
	ex8zw3S8OLWSDSKxnFFi8rQ9jBDOG0aJVdd/s4JUsQkYSTxYPp8VJCEi0M8k0XfkP5jDLLCS
	UeL+hbNgs4QFPCXutf0Fs1kEVCW2fbsDZvMK2EncODKHCWKfvMT+gyD1HBycAvYSnxo0IUoE
	JU7OfMICYjMDlTRvnc0MMl9CYDOnRMu+CYwQvS4SF/rns0HYwhKvjm9hh7BlJE5P7mGBsPMl
	Hmz9BPVbjcTOnuNQtrXEnXO/2ED2MgtoSqzfpQ8RdpR482QNWFhCgE/ixltBiBP4JCZtm84M
	EeaV6GgTgqhWk5ja0wu39NyKbVBPeUi8bNrLPIFRcRaSZ2YheWYWwt4FjMyrGMVTS4tz01OL
	jfNSy/WKE3OLS/PS9ZLzczcxAtPh6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK8t9qPpgvxpiRW
	VqUW5ccXleakFh9ilOZgURLnXbS/NV1IID2xJDU7NbUgtQgmy8TBKdXA1HphTVH7B9tPsY+P
	HE20PP1rrvobC4G7P20k0lhuXpSdKyggc+nUKj+364HKHBsafT7pTt/CJ7OQ66f7/x/VS4N/
	xzWUe5jwVpVfDN6l9Cc657+kmaL2WR1jWcvPMSeuPeLdq+v6KSRK66hg50x24ZjbM/4bH2j+
	bKj+Jm7x3IJ5Zw7x9cs85Xyh6bWsuCDqR83yFA5xpaipNY3x2Q1/wqfsexyiVHHngrFbz8nt
	//xtPCy+HTrkOflS1RkOB1PXfWtT5kp+EjgDTJ4JryV4klf8Z/6wMTOYb9PEayb9U//O+NG1
	7MO7vb4hR3a9mvZmTmel65+DLW+C+uew2WmxTRWb0Nb+UIwlzEWyJWSREktxRqKhFnNRcSIA
	u+23sPYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7rHDx9NN1i8TdTi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdpWdTlF9akqqQkV9cYqsUbWhh
	pGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex64B/wfnpjBVzL51ja2A8XdbFyMkh
	IWAi8eLUSrYuRi4OIYGljBIzXvxhhUjISFzrfskCYQtL/LnWBVX0ilGi++YGsCI2ASOJB8vn
	s4IkRAQWMklcnbKBGcRhFljLKHH46iV2kCphAU+Je21/mUFsFgFViW3f7oDZvAJ2EjeOzGGC
	WCEvsf/gWaA4BwengL3EpwZNEFMIqOTVJw6IakGJkzOfgB3EDFTdvHU28wRGgVlIUrOQpBYw
	Mq1iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNxtx35u2cG48tVHvUOMTByMhxglOJiVRHhv
	tR9NF+JNSaysSi3Kjy8qzUktPsRoCnT1RGYp0eR8YOrIK4k3NDMwNTQxszQwtTQzVhLnZbty
	Pk1IID2xJDU7NbUgtQimj4mDU6qBSXS7b6bRpEsn/8RMevv5TFOf0ftv1r4NR66Wl1xPl29s
	rTpi+Vf347WNoVNmTRQ+nJ4ns0syokW013bbjRoWRQ4u4eSUu1IWE813fdluc0GYMaT88rz+
	TRfDPNYGH1ip+nla0MMTRxVb21szrQ5/dHjz11BqxqQoj5qi96LmoZv/vVpnrfKsLzEq9YXP
	ta0HztxTXXh5Fdsmjmez5VoV54bvDtXwPeXfIDLD3Nxifcb1PPsZUwWPv3wRbhV4nidvz+/S
	aWZ2B2/qqchNZt0Twsb3U3VFbniSctQD1ltuFmua2fda9Pua6JQ3T3W+kvX93X+98xeSfzg9
	uvSvK0AroUT8js/uxd8CVE8nH+8wVGIpzkg01GIuKk4EAIUDvpllAwAA
X-CMS-MailID: 20250303145919eucas1p123e4b3ab94c67b7538a088be350372b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303145919eucas1p123e4b3ab94c67b7538a088be350372b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303145919eucas1p123e4b3ab94c67b7538a088be350372b4
References: <20250303145901.446791-1-m.wilczynski@samsung.com>
	<CGME20250303145919eucas1p123e4b3ab94c67b7538a088be350372b4@eucas1p1.samsung.com>

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
 drivers/firmware/thead,th1520-aon.c           | 247 ++++++++++++++++++
 .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
 5 files changed, 459 insertions(+)
 create mode 100644 drivers/firmware/thead,th1520-aon.c
 create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 46745cfe9d1f..c446fed8ff96 100644
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
index 000000000000..48e1bd986768
--- /dev/null
+++ b/drivers/firmware/thead,th1520-aon.c
@@ -0,0 +1,247 @@
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


