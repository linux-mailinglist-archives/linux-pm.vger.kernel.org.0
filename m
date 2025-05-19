Return-Path: <linux-pm+bounces-27372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F96ABC568
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71839189DF30
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F394288C9C;
	Mon, 19 May 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5DgD0P+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0708288C81;
	Mon, 19 May 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674990; cv=none; b=XHYzXsfGv+wze/n9UHQm8aqRb1CfsTwtIAewlHv13IR+TTJ6+9qKsHDFucvPXQdnH+RQmOQTVuC+OadpyaZzQOclrntiIlsawvoTfF/EBtCUZpazRzrGzj0TkK2vqI8jzGDjiOzN2QW8l8aFrqmii4/zKLfH5UFhNQ8dlTsEb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674990; c=relaxed/simple;
	bh=guaS0IJYrKBzUQ7n6cApSVOAkZpGRn7ZgmTQXkQpvxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fiZnoZTdrYHRA5Ko+sGIbNSYCPt+YtSSdpptHX5SMMjJn2vTvZ2PcuYaxTqFPbO5SAvwE++pvkJeNLLxEmZF2f7iObOoFnj53h9IsOlrZiT8MtuLyAh+1kXk6uofSnYy1O+y78JIj4U/79XBP/WqBxZR+NzxbYnlZtfx8k5BhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5DgD0P+; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3da73e9cf17so41546025ab.2;
        Mon, 19 May 2025 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747674988; x=1748279788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1uDXUypTxPVrOjDkyW8a3QEFjfv2DCfH/Ibxzs5fII=;
        b=I5DgD0P+iWGkIl2aCkofPUNEupnbzdcntJM4j/PJ0N+a+2hicPgjSUgeFvo32PtbuI
         +Rehw1beN9B4Vzg2DV5FAL8XxWw2Hjm4UlFbdG7+88hpQKu4lavW7AlIKgxnq6qgYMZS
         CVSJIvTwQp5pSsMee7AuEIB3TBlWlq0UMLlvbpj8ERmIdhJDkJUgTwrGpQqrOOFCDGDo
         NOYrukqvejq7Fs8brofg6oAC+s1TfIZjRnCSmgVg2rxQdJwaNlMVkTE2hV2NuvaKPyX6
         mUa9X4CyLBF3PmE6CH3uPOs2Lfg01eehAASworTRRcdLHwXaTLZWupGVOA/sYeTDb6UV
         GYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674988; x=1748279788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1uDXUypTxPVrOjDkyW8a3QEFjfv2DCfH/Ibxzs5fII=;
        b=Y63hzC6vBjJzJ8ySglkSIYil3RMRCHZhx7e424pe8kHrfQNUUnXFmrHomDcujaKfYc
         z2cBnSDvkiAfLsihJZT/410tFEibJnjBxefTJS6WsBhqaEInWnoWyPJmEnXxy8MN42RY
         zFHsxudMPUjCQrFYmfmf3W7FDo9nwcA/M+6u3PxPhbERtlst5otDnBjBrzsinqXlo2jt
         UlhvUsnmugqWyGcOLNBXDdpaN0AAp9PuIfQWaAlzhlbFFMqa7ENysIa9kPeBLn4vMAhW
         Jy2wPKI9Uy/lDjaewdjSeMtyRLQO+QNGhHNym816ZUC+uMSHo2mHst8u/jqAwfgHl/3v
         yZTw==
X-Forwarded-Encrypted: i=1; AJvYcCUz+amBrkk0AKlNIVN9mcYrTM1zbOkYbAE5/mRynASLm//HxRLtG7ogUQYDgWSOOVguX/HoiN40wd0=@vger.kernel.org, AJvYcCW363kJFCTw5hHC8+dXrE0awqM3FoQVWr5pYIFAk8RP5XxK0PzQUd/WReRlrdhFkj/XfmF1+Y14SE7lf4Y=@vger.kernel.org, AJvYcCXx70CE5ZiNTK7j7e2Dl/oLILw7SMPzuP1juTaweMTQs5QOvn2NFBqRLiMHRWFczaHwsku0fNNSdUny8dFpK4JQ4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YypjTf5BBxG44FtBsAiA9xbefak3L1o6aqByhQN4YcXT9X24AFo
	h0lXuAdrCDNgCkV/P9lHY+CoZfqypqJzCEnB+RHglh1iE1V+ihIdUXsIqpr5aS0tB7s=
X-Gm-Gg: ASbGncu4NfWwKHdNeqK8RAgnRM/yYS18Gy8W11MVExl4Uspe988DGhjiR0a0MRSVB4k
	t8WYeUwQgj8GSMwT75rc2I5jHkC1xdqOOxccRM2pMxVBHzYpEh0hR/1mIc7RZr8jtK+TWsfJLCd
	JbFjviGAKtO3rBSfOiv++kdJHZBbkFZlKP1OT4HPutubmckZt9K6nzReQ1J8J6HsIbEIIapPZ5b
	Lc6s/d1DXS1XpANgaEA9oTHnqjN7TUE4k328FS+7QGvo2/vrml7sWnBjMPwGSpwBAstLG5C4pYP
	NVaPI1+qt4hvZd9vgzWXhY1ez1syT3yZXn+CqmBCMIBWKa5BIisHT/EvqqMAWT+/YlnkVAchE6Q
	HG4Yogx+S
X-Google-Smtp-Source: AGHT+IGcPhmxLm05zfOvv98rT+S8AoJqTq1ZTmACNFyaA4DcN6+SVqyHcTRF8Wm1vE2yc2bqeR6yjA==
X-Received: by 2002:a05:6122:310f:b0:528:bd71:8932 with SMTP id 71dfb90a1353d-52dba9513ddmr11512958e0c.11.1747674976187;
        Mon, 19 May 2025 10:16:16 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab4e983sm7003647e0c.31.2025.05.19.10.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:16:15 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>,
	daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 1/3] firmware: imx: introduce imx_sc_pm_get_resource_power_mode()
Date: Mon, 19 May 2025 14:15:12 -0300
Message-Id: <20250519171514.61974-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519171514.61974-1-hiagofranco@gmail.com>
References: <20250519171514.61974-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This SCU API returns the power mode of a given resource.

As example, remoteproc/imx_rproc.c can now use this function to check
the power mode of the remote core to properly set "attached" or
"offline" modes.

Since there is no proper firmware/imx file to place this function, also
introduce firmware/imx/power.c file to keep all the PM functions inside.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Suggested-by: Peng Fan <peng.fan@nxp.com>
---
v3: New patch.
---
 drivers/firmware/imx/Makefile       |  2 +-
 drivers/firmware/imx/power.c        | 52 +++++++++++++++++++++++++++++
 include/linux/firmware/imx/svc/pm.h |  9 +++++
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/power.c

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be8..5f5548e34459 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o power.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
diff --git a/drivers/firmware/imx/power.c b/drivers/firmware/imx/power.c
new file mode 100644
index 000000000000..b982cebba72a
--- /dev/null
+++ b/drivers/firmware/imx/power.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * File containing client-side RPC functions for the PM (Power Management)
+ * service. These function are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/svc/pm.h>
+
+struct imx_sc_msg_req_get_resource_power_mode {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u16 resource;
+		} req;
+		struct {
+			u8 mode;
+		} resp;
+	} data;
+} __packed __aligned(4);
+
+/**
+ * imx_sc_pm_get_resource_power_mode - Get power mode from a given resource.
+ * @ipc: IPC handle.
+ * @resource: Resource to check the power mode.
+ *
+ * Return: Returns < 0 for errors or the following for success:
+ * * %IMX_SC_PM_PW_MODE_OFF	- Power off
+ * * %IMX_SC_PM_PW_MODE_STBY	- Power in standby
+ * * %IMX_SC_PM_PW_MODE_LP	- Power in low-power
+ * * %IMX_SC_PM_PW_MODE_ON	- Power on
+ *
+ */
+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource)
+{
+	struct imx_sc_msg_req_get_resource_power_mode msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
+	hdr->size = 2;
+
+	msg.data.req.resource = resource;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	return msg.data.resp.mode;
+}
+EXPORT_SYMBOL(imx_sc_pm_get_resource_power_mode);
diff --git a/include/linux/firmware/imx/svc/pm.h b/include/linux/firmware/imx/svc/pm.h
index 1f6975dd37b0..56e93a953295 100644
--- a/include/linux/firmware/imx/svc/pm.h
+++ b/include/linux/firmware/imx/svc/pm.h
@@ -82,4 +82,13 @@ enum imx_sc_pm_func {
 #define IMX_SC_PM_PARENT_PLL2	3	/* Parent in PLL2 or PLL0/4 */
 #define IMX_SC_PM_PARENT_BYPS	4	/* Parent is a bypass clock. */
 
+#if IS_ENABLED(CONFIG_IMX_SCU)
+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource);
+#else
+static inline int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc,
+						    u32 resource)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif /* _SC_PM_API_H */
-- 
2.39.5


