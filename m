Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63F382436
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 08:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhEQGYL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 02:24:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:34734 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234906AbhEQGYK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 May 2021 02:24:10 -0400
IronPort-SDR: xF4l3eQKMFd8QFjg/98Pdi8vsA5/RGyFfyZje9fK020PIXvYDXQ9VK/Mak72A5k92rgl8p5GvO
 AA1+fbgo+Hxg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197306274"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="197306274"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 23:22:54 -0700
IronPort-SDR: n9XLUXmqY0w22WDF0n7nbrUZrrR/05JdZwWZaTkLiH55D70lpdJXyAYChSS9Oy5dAG1laTd682
 KhGx2uTwiVdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="393388428"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2021 23:22:53 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] thermal: int340x: processor_thermal: Export mailbox interface
Date:   Sun, 16 May 2021 23:14:40 -0700
Message-Id: <20210517061441.1921901-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517061441.1921901-1-srinivas.pandruvada@linux.intel.com>
References: <20210517061441.1921901-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export the mailbox interface to be used by other modules. Also change
command id and response from u8 to u32 data type.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device.h |  2 ++
 .../intel/int340x_thermal/processor_thermal_mbox.c   | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index b9ed64561aaf..3161607424f5 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -79,4 +79,6 @@ void proc_thermal_rfim_remove(struct pci_dev *pdev);
 int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 void proc_thermal_mbox_remove(struct pci_dev *pdev);
 
+int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp);
+
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index 990f51f22884..59e93b04f0a9 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -23,7 +23,7 @@
 
 static DEFINE_MUTEX(mbox_lock);
 
-static int send_mbox_cmd(struct pci_dev *pdev, u8 cmd_id, u32 cmd_data, u8 *cmd_resp)
+static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp)
 {
 	struct proc_thermal_device *proc_priv;
 	u32 retries, data;
@@ -82,6 +82,12 @@ static int send_mbox_cmd(struct pci_dev *pdev, u8 cmd_id, u32 cmd_data, u8 *cmd_
 	return ret;
 }
 
+int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp)
+{
+	return send_mbox_cmd(pdev, cmd_id, cmd_data, cmd_resp);
+}
+EXPORT_SYMBOL_GPL(processor_thermal_send_mbox_cmd);
+
 /* List of workload types */
 static const char * const workload_types[] = {
 	"none",
@@ -147,7 +153,7 @@ static ssize_t workload_type_show(struct device *dev,
 				   char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	u8 cmd_resp;
+	u32 cmd_resp;
 	int ret;
 
 	ret = send_mbox_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, 0, &cmd_resp);
@@ -181,7 +187,7 @@ static bool workload_req_created;
 
 int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
-	u8 cmd_resp;
+	u32 cmd_resp;
 	int ret;
 
 	/* Check if there is a mailbox support, if fails return success */
-- 
2.27.0

