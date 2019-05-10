Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF821A498
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 23:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfEJVfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 17:35:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:27057 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbfEJVfH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 May 2019 17:35:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 14:35:06 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2019 14:35:05 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Cc:     Rafael Wysocki <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
Date:   Fri, 10 May 2019 15:29:37 -0600
Message-Id: <20190510212937.11661-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The nvme pci driver prepares its devices for power loss during suspend
by shutting down the controllers, and the power setting is deferred to
pci driver's power management before the platform removes power. The
suspend-to-idle mode, however, does not remove power.

NVMe devices that implement host managed power settings can achieve
lower power and better transition latencies than using generic PCI
power settings. Try to use this feature if the platform is not involved
with the suspend. If successful, restore the previous power state on
resume.

Cc: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
Disclaimer: I've tested only on emulation faking support for the feature.

General question: different devices potentially have divergent values
for power consumption and transition latencies. Would it be useful to
allow a user tunable setting to select the desired target power state
instead of assuming the lowest one?

 drivers/nvme/host/core.c | 27 ++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6644a2c3ef7..eb3640fd8838 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1132,6 +1132,33 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
 	return ret;
 }
 
+int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)
+{
+	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(nvme_set_power);
+
+int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)
+{
+	struct nvme_command c;
+	union nvme_result res;
+	int ret;
+
+	if (!result)
+		return -EINVAL;
+
+	memset(&c, 0, sizeof(c));
+	c.features.opcode = nvme_admin_get_features;
+	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
+
+	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
+			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
+	if (ret >= 0)
+		*result = le32_to_cpu(res.u32);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_get_power);
+
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 {
 	u32 q_count = (*count - 1) | ((*count - 1) << 16);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ee75b5ff83f..eaa571ac06d2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -459,6 +459,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags, bool poll);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
+int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps);
+int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3e4fb891a95a..0d5d91e5b293 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
+#include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -116,6 +117,7 @@ struct nvme_dev {
 	u32 cmbsz;
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
+	u32 last_ps;
 
 	mempool_t *iod_mempool;
 
@@ -2828,11 +2830,59 @@ static void nvme_remove(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int nvme_deep_state(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int ret;
+
+	/*
+	 * Save the current power state in case a user tool set a power policy
+	 * for this device. We'll restore that state on resume.
+	 */
+	dev->last_ps = 0;
+	ret = nvme_get_power(&dev->ctrl, &dev->last_ps);
+
+	/*
+	 * Return the error to halt suspend if the driver either couldn't
+	 * submit a command or didn't see a response.
+	 */
+	if (ret < 0)
+		return ret;
+
+	ret = nvme_set_power(&dev->ctrl, dev->ctrl.npss);
+	if (ret < 0)
+		return ret;
+
+	if (!ret) {
+		/*
+		 * A saved state prevents pci pm from generically controlling
+		 * the device's power. We're using protocol specific settings
+		 * so we don't want pci interfering.
+		 */
+		pci_save_state(pdev);
+	} else {
+		/*
+		 * The drive failed the low power request. Fallback to device
+		 * shutdown and clear npss to force a controller reset on
+		 * resume. The value will be rediscovered during reset.
+		 */
+		dev->ctrl.npss = 0;
+		nvme_dev_disable(dev, true);
+	}
+	return 0;
+}
+
 static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+	/*
+	 * Try to use nvme if the device supports host managed power settings
+	 * and platform firmware is not involved.
+	 */
+	if (!pm_suspend_via_firmware() && ndev->ctrl.npss)
+		return nvme_deep_state(ndev);
 	nvme_dev_disable(ndev, true);
 	return 0;
 }
@@ -2842,6 +2892,9 @@ static int nvme_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+	if (!pm_resume_via_firmware() && ndev->ctrl.npss)
+		if (nvme_set_power(&ndev->ctrl, ndev->last_ps) == 0)
+			return 0;
 	nvme_reset_ctrl(&ndev->ctrl);
 	return 0;
 }
-- 
2.14.4

