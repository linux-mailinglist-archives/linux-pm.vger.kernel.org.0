Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D227B403D72
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhIHQRo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 12:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhIHQRn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 12:17:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E009160F5E;
        Wed,  8 Sep 2021 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631117795;
        bh=cVjCpS9RWucjZ2Pri7vZ4FvnLiH/GbYavZwf0VFtOYA=;
        h=From:To:Cc:Subject:Date:From;
        b=O9BCRF0bDQGGb30SZ+HYiindSLiaw2+SFpmxvtNYoC+6n8M7RmM5AOY9MOTbMU55V
         XyDtd5TjqDuRkxH+9WPPNl5boINNnQM4jj1y3jur5VpmEb0Et3XKafyBNCQBlYftB7
         VE4LosP+vnYm54vjV7Yv+hE2NSBYtMYj3IqKOp4HnVBMwctF03YwzRFmy+6ivHFqr7
         KaJW3lQ8INqyx7MzJU7jf1gaqk6u4Egs9OY8ZOqm+B9N29yQO3QUJiwED8Iu4VShA4
         yjlz5ktuNBdFj0UaZyizBPYZiusmbblrIXshNBe0f5QFxPBror9k87alfuE6clY+8M
         z4AwTpn1JIAag==
From:   Antoine Tenart <atenart@kernel.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     Antoine Tenart <atenart@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] thermal: int340x: fix tcc offset on resume
Date:   Wed,  8 Sep 2021 18:16:32 +0200
Message-Id: <20210908161632.15520-1-atenart@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After upgrading to Linux 5.13.3 I started noticing my laptop would
shutdown due to overheat (when it should not). It turned out this is due
to commit fe6a6de6692e ("thermal/drivers/int340x/processor_thermal: Fix tcc setting").

What happens is this drivers uses a global variable to keep track of the
tcc offset (tcc_offset_save) and uses it on resume. The issue is this
variable is initialized to 0, but is only set in
tcc_offset_degree_celsius_store, i.e. when the tcc offset is explicitly
set by userspace. If that does not happen, the resume path will set the
offset to 0 (in my case the h/w default being 3, the offset would become
too low after a suspend/resume cycle).

The issue did not arise before commit fe6a6de6692e, as the function
setting the offset would return if the offset was 0. This is no longer
the case (rightfully).

Fix this by keeping track of the offset in a suspend op, so the right
value gets restored after a resume if it was not set by userspace.

The logic to restore the offset after a resume was there long before
commit fe6a6de6692e, but as a value of 0 was considered invalid I'm
referencing the commit that made the issue possible in the Fixes tag
instead.

Fixes: fe6a6de6692e ("thermal/drivers/int340x/processor_thermal: Fix tcc setting")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---

Hi all,

Tbh I'm not familiar with this code and subsystem, I wrote this as it
does fixes the issue and helps to start a discussion. If the fix looks
good to you, great, but there might be better ways of fixing this.

It did work on my laptop, but other tests are welcomed!

One note: I chose not to return an error in suspend, as I'm not sure the
resume would be called if that happens. If that's not the case, I can
propagate the issue. Also setting tcc_offset_save to -1 might not be
needed, if ->suspend is guaranteed to be called before ->resume.

Thanks!
Antoine

 .../intel/int340x_thermal/int3401_thermal.c   |  8 +++-
 .../processor_thermal_device.c                | 39 ++++++++++++++-----
 .../processor_thermal_device.h                |  1 +
 .../processor_thermal_device_pci.c            | 18 ++++++++-
 .../processor_thermal_device_pci_legacy.c     |  8 +++-
 5 files changed, 62 insertions(+), 12 deletions(-)

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
index 0f0038af2ad4..a8d98f1bd6c6 100644
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
 
-static unsigned int tcc_offset_save;
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
@@ -352,7 +371,9 @@ int proc_thermal_resume(struct device *dev)
 	proc_dev = dev_get_drvdata(dev);
 	proc_thermal_read_ppcc(proc_dev);
 
-	tcc_offset_update(tcc_offset_save);
+	/* Do not update if saving failed */
+	if (tcc_offset_save >= 0)
+		tcc_offset_update(tcc_offset_save);
 
 	return 0;
 }
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

