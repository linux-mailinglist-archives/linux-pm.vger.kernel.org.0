Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE63A1A482C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgDJQBP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 12:01:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42545 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgDJQAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 12:00:49 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 3a80db90d5ade516; Fri, 10 Apr 2020 18:00:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH 5/7] PM: sleep: core: Rename DPM_FLAG_NEVER_SKIP
Date:   Fri, 10 Apr 2020 17:56:13 +0200
Message-ID: <5092680.jloV5Ae5OO@kreacher>
In-Reply-To: <1888197.j9z7NJ8yPn@kreacher>
References: <1888197.j9z7NJ8yPn@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Rename DPM_FLAG_NEVER_SKIP to DPM_FLAG_NO_DIRECT_COMPLETE which
matches its purpose more closely.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst    |  6 +++---
 Documentation/power/pci.rst                | 10 +++++-----
 drivers/base/power/main.c                  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c    |  2 +-
 drivers/gpu/drm/radeon/radeon_kms.c        |  2 +-
 drivers/misc/mei/pci-me.c                  |  2 +-
 drivers/misc/mei/pci-txe.c                 |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c  |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c  |  2 +-
 drivers/pci/pcie/portdrv_pci.c             |  2 +-
 include/linux/pm.h                         |  6 +++---
 13 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index f66c7b9126ea..4ace0eba4506 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -361,9 +361,9 @@ the phases are: ``prepare``, ``suspend``, ``suspend_late``, ``suspend_noirq``.
 	runtime PM disabled.
 
 	This feature also can be controlled by device drivers by using the
-	``DPM_FLAG_NEVER_SKIP`` and ``DPM_FLAG_SMART_PREPARE`` driver power
-	management flags.  [Typically, they are set at the time the driver is
-	probed against the device in question by passing them to the
+	``DPM_FLAG_NO_DIRECT_COMPLETE`` and ``DPM_FLAG_SMART_PREPARE`` driver
+	power management flags.  [Typically, they are set at the time the driver
+	is probed against the device in question by passing them to the
 	:c:func:`dev_pm_set_driver_flags` helper function.]  If the first of
 	these flags is set, the PM core will not apply the direct-complete
 	procedure described above to the given device and, consequenty, to any
diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index aa1c7fce6cd0..9e1408121bea 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -1004,11 +1004,11 @@ including the PCI bus type.  The flags should be set once at the driver probe
 time with the help of the dev_pm_set_driver_flags() function and they should not
 be updated directly afterwards.
 
-The DPM_FLAG_NEVER_SKIP flag prevents the PM core from using the direct-complete
-mechanism allowing device suspend/resume callbacks to be skipped if the device
-is in runtime suspend when the system suspend starts.  That also affects all of
-the ancestors of the device, so this flag should only be used if absolutely
-necessary.
+The DPM_FLAG_NO_DIRECT_COMPLETE flag prevents the PM core from using the
+direct-complete mechanism allowing device suspend/resume callbacks to be skipped
+if the device is in runtime suspend when the system suspend starts.  That also
+affects all of the ancestors of the device, so this flag should only be used if
+absolutely necessary.
 
 The DPM_FLAG_SMART_PREPARE flag instructs the PCI bus type to only return a
 positive value from pci_pm_prepare() if the ->prepare callback provided by the
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 21187ee37b22..aa9c8df9fc4b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1850,7 +1850,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	spin_lock_irq(&dev->power.lock);
 	dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
 		(ret > 0 || dev->power.no_pm_callbacks) &&
-		!dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);
+		!dev_pm_test_driver_flags(dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 	spin_unlock_irq(&dev->power.lock);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fd1dc3236eca..a9086ea1ab60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -191,7 +191,7 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	}
 
 	if (adev->runpm) {
-		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
+		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_set_active(dev->dev);
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index ad719c9602af..9cb2d7548daa 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -549,7 +549,7 @@ void intel_runtime_pm_enable(struct intel_runtime_pm *rpm)
 	 * becaue the HDA driver may require us to enable the audio power
 	 * domain during system suspend.
 	 */
-	dev_pm_set_driver_flags(kdev, DPM_FLAG_NEVER_SKIP);
+	dev_pm_set_driver_flags(kdev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
 	pm_runtime_set_autosuspend_delay(kdev, 10000); /* 10s */
 	pm_runtime_mark_last_busy(kdev);
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 58176db85952..372962358a18 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -158,7 +158,7 @@ int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	}
 
 	if (radeon_is_px(dev)) {
-		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
+		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_set_active(dev->dev);
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 3d21c38e2dbb..53f16f3bd091 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -240,7 +240,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * MEI requires to resume from runtime suspend mode
 	 * in order to perform link reset flow upon system suspend.
 	 */
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
 	/*
 	 * ME maps runtime suspend/resume to D0i states,
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index beacf2a2f2b5..4bf26ce61044 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -128,7 +128,7 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * MEI requires to resume from runtime suspend mode
 	 * in order to perform link reset flow upon system suspend.
 	 */
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
 	/*
 	 * TXE maps runtime suspend/resume to own power gating states,
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 177c6da80c57..2730b1c7dddb 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7549,7 +7549,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
 	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
 		pm_runtime_put_noidle(&pdev->dev);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b46bff8fe056..8bb3db2cbd41 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3445,7 +3445,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 69fa1ce1f927..59fc0097438f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4825,7 +4825,7 @@ static int igc_probe(struct pci_dev *pdev,
 	pcie_print_link_status(pdev);
 	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
 	pm_runtime_put_noidle(&pdev->dev);
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 160d67c59310..3acf151ae015 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -115,7 +115,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 	pci_save_state(dev);
 
-	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NEVER_SKIP |
+	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 					   DPM_FLAG_SMART_SUSPEND);
 
 	if (pci_bridge_d3_possible(dev)) {
diff --git a/include/linux/pm.h b/include/linux/pm.h
index d89b7099f241..28fd444fb5c9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -544,7 +544,7 @@ struct pm_subsys_data {
  * These flags can be set by device drivers at the probe time.  They need not be
  * cleared by the drivers as the driver core will take care of that.
  *
- * NEVER_SKIP: Do not skip all system suspend/resume callbacks for the device.
+ * NO_DIRECT_COMPLETE: Do not apply direct-complete optimization to the device.
  * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
  * SMART_SUSPEND: No need to resume the device from runtime suspend.
  * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
@@ -554,7 +554,7 @@ struct pm_subsys_data {
  * their ->prepare callbacks if the driver's ->prepare callback returns 0 (in
  * other words, the system suspend/resume callbacks can only be skipped for the
  * device if its driver doesn't object against that).  This flag has no effect
- * if NEVER_SKIP is set.
+ * if NO_DIRECT_COMPLETE is set.
  *
  * Setting SMART_SUSPEND instructs bus types and PM domains which may want to
  * runtime resume the device upfront during system suspend that doing so is not
@@ -565,7 +565,7 @@ struct pm_subsys_data {
  * Setting LEAVE_SUSPENDED informs the PM core and middle-layer code that the
  * driver prefers the device to be left in suspend after system resume.
  */
-#define DPM_FLAG_NEVER_SKIP		BIT(0)
+#define DPM_FLAG_NO_DIRECT_COMPLETE	BIT(0)
 #define DPM_FLAG_SMART_PREPARE		BIT(1)
 #define DPM_FLAG_SMART_SUSPEND		BIT(2)
 #define DPM_FLAG_LEAVE_SUSPENDED	BIT(3)
-- 
2.16.4




