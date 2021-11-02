Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DDF442C26
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 12:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhKBLKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 07:10:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:38932 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhKBLKT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 07:10:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="228683484"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="228683484"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 03:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="500490247"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga008.jf.intel.com with ESMTP; 02 Nov 2021 03:52:43 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal/drivers/int340x: processor_thermal: Suppot 64 bit RFIM responses
Date:   Tue,  2 Nov 2021 03:52:36 -0700
Message-Id: <20211102105236.97469-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some of the RFIM mail box command returns 64 bit values. So enhance
mailbox interface to return 64 bit values and use them for RFIM
commands.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 5d6fbc96bd36 ("thermal/drivers/int340x: processor_thermal: Export additional attributes")
---
 .../processor_thermal_device.h                |  2 +-
 .../int340x_thermal/processor_thermal_mbox.c  | 22 +++++++++++--------
 .../int340x_thermal/processor_thermal_rfim.c  | 10 ++++-----
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 5a1cfe4864f1..2aae91e7b13d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -80,7 +80,7 @@ void proc_thermal_rfim_remove(struct pci_dev *pdev);
 int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 void proc_thermal_mbox_remove(struct pci_dev *pdev);
 
-int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp);
+int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u64 *cmd_resp);
 int proc_thermal_add(struct device *dev, struct proc_thermal_device *priv);
 void proc_thermal_remove(struct proc_thermal_device *proc_priv);
 int proc_thermal_resume(struct device *dev);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index 59e93b04f0a9..a86521973dad 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -23,7 +23,7 @@
 
 static DEFINE_MUTEX(mbox_lock);
 
-static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp)
+static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u64 *cmd_resp)
 {
 	struct proc_thermal_device *proc_priv;
 	u32 retries, data;
@@ -68,12 +68,16 @@ static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cm
 			goto unlock_mbox;
 		}
 
-		if (cmd_id == MBOX_CMD_WORKLOAD_TYPE_READ) {
-			data = readl((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
-			*cmd_resp = data & 0xff;
-		}
-
 		ret = 0;
+
+		if (!cmd_resp)
+			break;
+
+		if (cmd_id == MBOX_CMD_WORKLOAD_TYPE_READ)
+			*cmd_resp = readl((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
+		else
+			*cmd_resp = readq((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
+
 		break;
 	} while (--retries);
 
@@ -82,7 +86,7 @@ static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cm
 	return ret;
 }
 
-int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp)
+int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u64 *cmd_resp)
 {
 	return send_mbox_cmd(pdev, cmd_id, cmd_data, cmd_resp);
 }
@@ -153,7 +157,7 @@ static ssize_t workload_type_show(struct device *dev,
 				   char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	u32 cmd_resp;
+	u64 cmd_resp;
 	int ret;
 
 	ret = send_mbox_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, 0, &cmd_resp);
@@ -187,7 +191,7 @@ static bool workload_req_created;
 
 int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
-	u32 cmd_resp;
+	u64 cmd_resp;
 	int ret;
 
 	/* Check if there is a mailbox support, if fails return success */
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 2b8a3235d518..b25b54d4bac1 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -195,7 +195,7 @@ static ssize_t rfi_restriction_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	u16 cmd_id = 0x0008;
-	u32 cmd_resp;
+	u64 cmd_resp;
 	u32 input;
 	int ret;
 
@@ -215,14 +215,14 @@ static ssize_t rfi_restriction_show(struct device *dev,
 				    char *buf)
 {
 	u16 cmd_id = 0x0007;
-	u32 cmd_resp;
+	u64 cmd_resp;
 	int ret;
 
 	ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, 0, &cmd_resp);
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u\n", cmd_resp);
+	return sprintf(buf, "%llu\n", cmd_resp);
 }
 
 static ssize_t ddr_data_rate_show(struct device *dev,
@@ -230,14 +230,14 @@ static ssize_t ddr_data_rate_show(struct device *dev,
 				  char *buf)
 {
 	u16 cmd_id = 0x0107;
-	u32 cmd_resp;
+	u64 cmd_resp;
 	int ret;
 
 	ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, 0, &cmd_resp);
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u\n", cmd_resp);
+	return sprintf(buf, "%llu\n", cmd_resp);
 }
 
 static DEVICE_ATTR_RW(rfi_restriction);
-- 
2.31.1

