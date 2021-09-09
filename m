Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5B40476A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 10:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhIII5i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 04:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232262AbhIII5b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 04:57:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B3CA60FC0;
        Thu,  9 Sep 2021 08:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631177782;
        bh=6UCRjbLatvwjzOCba8xCtVTRxSpA1vATiNLOcgUz0Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsPczK+EOVNvkzS1HLwG5B5jUIOIctxh61qh2GhH4oiK9s73lRgoAy9Te+rDqI47C
         7kYKtINygG0srOJjEy4YbiQOyUmhvOe3BngY0Sy3ojLiiPLYWDzbBVCX0BF2/rBBaz
         NrHAQS1EbNnDpP523zbrtd1yfJKtCd+mDm2A8I3xsv4uPcoCfTkx6PbRm+d7Wi9qHa
         jWetgNuxhaamBmryDNcVblUgAD/ZgsLgMaSEWgAdZvWxBk5l/h660t9SnVvJdV/P28
         oYv2mbpD5y5Uhsx+CR9i3kne1FnqvSkHS5L3F9w29wu5g1Xbr5a88BXRUIK9cthWJi
         NbUy7468y2Uog==
From:   Antoine Tenart <atenart@kernel.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     Antoine Tenart <atenart@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] thermal: int340x: improve the tcc offset saving for suspend/resume
Date:   Thu,  9 Sep 2021 10:56:13 +0200
Message-Id: <20210909085613.5577-3-atenart@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909085613.5577-1-atenart@kernel.org>
References: <20210909085613.5577-1-atenart@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the driver resumes, the tcc offset is set back to its previous
value. But this only works if the value was user defined as otherwise
the offset isn't saved. This asymmetric logic is harder to maintain and
introduced some issues.

Improve the logic by saving the tcc offset in a suspend op, so the right
value is always restored after a resume.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 .../intel/int340x_thermal/int3401_thermal.c   |  8 ++++-
 .../processor_thermal_device.c                | 36 ++++++++++++++-----
 .../processor_thermal_device.h                |  1 +
 .../processor_thermal_device_pci.c            | 18 +++++++++-
 .../processor_thermal_device_pci_legacy.c     |  8 ++++-
 5 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
index acebc8ba94e2..217786fba185 100644
--- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -44,15 +44,21 @@ static int int3401_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int int3401_thermal_suspend(struct device *dev)
+{
+	return proc_thermal_suspend(dev);
+}
 static int int3401_thermal_resume(struct device *dev)
 {
 	return proc_thermal_resume(dev);
 }
 #else
+#define int3401_thermal_suspend NULL
 #define int3401_thermal_resume NULL
 #endif
 
-static SIMPLE_DEV_PM_OPS(int3401_proc_thermal_pm, NULL, int3401_thermal_resume);
+static SIMPLE_DEV_PM_OPS(int3401_proc_thermal_pm, int3401_thermal_suspend,
+			 int3401_thermal_resume);
 
 static struct platform_driver int3401_driver = {
 	.probe = int3401_add,
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index fb64acfd5e07..a8d98f1bd6c6 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -68,8 +68,7 @@ static const struct attribute_group power_limit_attribute_group = {
 	.name = "power_limits"
 };
 
-static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static int tcc_get_offset(void)
 {
 	u64 val;
 	int err;
@@ -78,8 +77,20 @@ static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
 	if (err)
 		return err;
 
-	val = (val >> 24) & 0x3f;
-	return sprintf(buf, "%d\n", (int)val);
+	return (val >> 24) & 0x3f;
+}
+
+static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	int tcc;
+
+	tcc = tcc_get_offset();
+	if (tcc < 0)
+		return tcc;
+
+	return sprintf(buf, "%d\n", tcc);
 }
 
 static int tcc_offset_update(unsigned int tcc)
@@ -107,8 +118,6 @@ static int tcc_offset_update(unsigned int tcc)
 	return 0;
 }
 
-static int tcc_offset_save = -1;
-
 static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -131,8 +140,6 @@ static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
 	if (err)
 		return err;
 
-	tcc_offset_save = tcc;
-
 	return count;
 }
 
@@ -345,6 +352,18 @@ void proc_thermal_remove(struct proc_thermal_device *proc_priv)
 }
 EXPORT_SYMBOL_GPL(proc_thermal_remove);
 
+static int tcc_offset_save = -1;
+
+int proc_thermal_suspend(struct device *dev)
+{
+	tcc_offset_save = tcc_get_offset();
+	if (tcc_offset_save < 0)
+		dev_warn(dev, "failed to save offset (%d)\n", tcc_offset_save);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(proc_thermal_suspend);
+
 int proc_thermal_resume(struct device *dev)
 {
 	struct proc_thermal_device *proc_dev;
@@ -352,6 +371,7 @@ int proc_thermal_resume(struct device *dev)
 	proc_dev = dev_get_drvdata(dev);
 	proc_thermal_read_ppcc(proc_dev);
 
+	/* Do not update if saving failed */
 	if (tcc_offset_save >= 0)
 		tcc_offset_update(tcc_offset_save);
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 5a1cfe4864f1..c1d8de6dc3d1 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -83,6 +83,7 @@ void proc_thermal_mbox_remove(struct pci_dev *pdev);
 int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp);
 int proc_thermal_add(struct device *dev, struct proc_thermal_device *priv);
 void proc_thermal_remove(struct proc_thermal_device *proc_priv);
+int proc_thermal_suspend(struct device *dev);
 int proc_thermal_resume(struct device *dev);
 int proc_thermal_mmio_add(struct pci_dev *pdev,
 			  struct proc_thermal_device *proc_priv,
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 11dd2e825f4f..b4bcd3fe9eb2 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -314,6 +314,20 @@ static void proc_thermal_pci_remove(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int proc_thermal_pci_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct proc_thermal_device *proc_priv;
+	struct proc_thermal_pci *pci_info;
+
+	proc_priv = pci_get_drvdata(pdev);
+	pci_info = proc_priv->priv_data;
+
+	if (!pci_info->no_legacy)
+		return proc_thermal_suspend(dev);
+
+	return 0;
+}
 static int proc_thermal_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -335,10 +349,12 @@ static int proc_thermal_pci_resume(struct device *dev)
 	return 0;
 }
 #else
+#define proc_thermal_pci_suspend NULL
 #define proc_thermal_pci_resume NULL
 #endif
 
-static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, NULL, proc_thermal_pci_resume);
+static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
+			 proc_thermal_pci_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
index f5fc1791b11e..4571a1a53b84 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
@@ -107,15 +107,21 @@ static void proc_thermal_pci_remove(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int proc_thermal_pci_suspend(struct device *dev)
+{
+	return proc_thermal_suspend(dev);
+}
 static int proc_thermal_pci_resume(struct device *dev)
 {
 	return proc_thermal_resume(dev);
 }
 #else
+#define proc_thermal_pci_suspend NULL
 #define proc_thermal_pci_resume NULL
 #endif
 
-static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, NULL, proc_thermal_pci_resume);
+static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
+			 proc_thermal_pci_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
-- 
2.31.1

