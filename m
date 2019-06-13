Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C44478F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfFMRAf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 13:00:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53356 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbfFMRAR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 13:00:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so10982203wmj.3;
        Thu, 13 Jun 2019 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ke2PcNpMKdQyf5iH4DjOeFjzYLX1u7eL3b0acZ61kc=;
        b=hXq0/pK2h7R3bcBV6Xp/+Xt6pV7CUx/cq/JspzC4TlkWiv62tTxAv+r7Z76IR1NFSX
         aa/swXxCp6sN6ZeK142FCfiW0UcVnpwMSCKiv8VeTVOKUR3frYnKc9QaiGkFN+4450I7
         h62/JzZI5339rjqoeQfn3oLMSs67aGVroxuI9xA5HTKlz3O5VYVi3p3r08tCa2U/lzDi
         NsecWORtpLTMIss4M72J73P7LL9aROJAzweFy2HHhU/T5dtzvJoFadvLS5m3X+xSkyO+
         r4BAqNe4oiHZ08d27gHXcQd+J2Qi7o7lIV/Z36XrsLCoV4LSHiGyBN2k+BTOyCHFVWyV
         FRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ke2PcNpMKdQyf5iH4DjOeFjzYLX1u7eL3b0acZ61kc=;
        b=gvDCVYEVuV72oXgUJD8T5Wy26+QxPRr/KxLH1k17w/fBdD3ddwqPAz0WqDlhH757oP
         SiMhxA3yHPPumRhQrR25b2FjaeI/I+3hxO26FWQnzBqK6iODjjL/fjxKhFn09seod0UR
         otNfxBrWSFIkGDNxdH9X2b2qYeQLO1wII4/YJvx1ZXa/UNnLZDNBg8+4ezNn5nY8A2Dr
         evNvUbq75Ewm4yrHEXkb4HM71im38ve+vRGQTJ4ICS8xn8yFeuDKTqE6sTGwa+MHUNhz
         Ex9//GlhzR1Bk/3CixuRydbfxXPw+YMhohMNN8aM/qqu0hCTAA8hpdGtwDWXIdj/id3b
         BQHw==
X-Gm-Message-State: APjAAAWTQdZlxtEDg6WFVCeabhWBunDI+trfEox9DUbLSgIJ1psmc7xB
        AI46dCjcia7CUs1rttA32/GskmdU
X-Google-Smtp-Source: APXvYqy66jM0+WZcaVOd83NWcqoVLopT1hGCGUmaFIIHKvurJEGUGEJICIcI5ORKjAzHYDz3y2+WVQ==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr4746705wma.114.1560445213643;
        Thu, 13 Jun 2019 10:00:13 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x6sm425324wru.0.2019.06.13.10.00.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 10:00:12 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver: core: Allow subsystems to continue deferring probe
Date:   Thu, 13 Jun 2019 19:00:11 +0200
Message-Id: <20190613170011.9647-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Some subsystems, such as pinctrl, allow continuing to defer probe
indefinitely. This is useful for devices that depend on resources
provided by devices that are only probed after the init stage.

One example of this can be seen on Tegra, where the DPAUX hardware
contains pinmuxing controls for pins that it shares with an I2C
controller. The I2C controller is typically used for communication
with a monitor over HDMI (DDC). However, other instances of the I2C
controller are used to access system critical components, such as a
PMIC. The I2C controller driver will therefore usually be a builtin
driver, whereas the DPAUX driver is part of the display driver that
is loaded from a module to avoid bloating the kernel image with all
of the DRM/KMS subsystem.

In this particular case the pins used by this I2C/DDC controller
become accessible very late in the boot process. However, since the
controller is only used in conjunction with display, that's not an
issue.

Unfortunately the driver core currently outputs a warning message
when a device fails to get the pinctrl before the end of the init
stage. That can be confusing for the user because it may sound like
an unwanted error occurred, whereas it's really an expected and
harmless situation.

In order to eliminate this warning, this patch allows callers of the
driver_deferred_probe_check_state() helper to specify that they want
to continue deferring probe, regardless of whether we're past the
init stage or not. All of the callers of that function are updated
for the new signature, but only the pinctrl subsystem passes a true
value in the new persist parameter if appropriate.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- pass persist flag via flags parameter to make the function call easier
  to understand

 drivers/base/dd.c            | 19 ++++++++++++++-----
 drivers/base/power/domain.c  |  2 +-
 drivers/iommu/of_iommu.c     |  2 +-
 drivers/pinctrl/devicetree.c |  9 +++++----
 include/linux/device.h       | 18 +++++++++++++++++-
 5 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0df9b4461766..0399a6f6c479 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -238,23 +238,32 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 /**
  * driver_deferred_probe_check_state() - Check deferred probe state
  * @dev: device to check
+ * @flags: Flags used to control the behavior of this function. Drivers can
+ *   set the DRIVER_DEFER_PROBE_PERSIST flag to indicate that they want to
+ *   keep trying to probe after built-in drivers have had a chance to probe.
+ *   This is useful for built-in drivers that rely on resources provided by
+ *   modular drivers.
  *
  * Returns -ENODEV if init is done and all built-in drivers have had a chance
- * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
- * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
+ * to probe (i.e. initcalls are done) and unless the DRIVER_DEFER_PROBE_PERSIST
+ * flag is set, -ETIMEDOUT if deferred probe debug timeout has expired, or
+ * -EPROBE_DEFER if none of those conditions are met.
  *
  * Drivers or subsystems can opt-in to calling this function instead of directly
  * returning -EPROBE_DEFER.
  */
-int driver_deferred_probe_check_state(struct device *dev)
+int driver_deferred_probe_check_state(struct device *dev, unsigned long flags)
 {
 	if (initcalls_done) {
 		if (!deferred_probe_timeout) {
 			dev_WARN(dev, "deferred probe timeout, ignoring dependency");
 			return -ETIMEDOUT;
 		}
-		dev_warn(dev, "ignoring dependency for device, assuming no driver");
-		return -ENODEV;
+
+		if ((flags & DRIVER_DEFER_PROBE_PERSIST) == 0) {
+			dev_warn(dev, "ignoring dependency for device, assuming no driver");
+			return -ENODEV;
+		}
 	}
 	return -EPROBE_DEFER;
 }
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 33c30c1e6a30..6198c6a30fe2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2423,7 +2423,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return driver_deferred_probe_check_state(base_dev);
+		return driver_deferred_probe_check_state(base_dev, 0);
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..b95d4342e414 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -105,7 +105,7 @@ static int of_iommu_xlate(struct device *dev,
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
 	if (!ops)
-		return driver_deferred_probe_check_state(dev);
+		return driver_deferred_probe_check_state(dev, 0);
 
 	return ops->of_xlate(dev, iommu_spec);
 }
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index f7e354f85518..43c0183fa23f 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -111,13 +111,14 @@ static int dt_to_map_one_config(struct pinctrl *p,
 
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
+			unsigned long flags = 0;
+
 			of_node_put(np_pctldev);
-			ret = driver_deferred_probe_check_state(p->dev);
 			/* keep deferring if modules are enabled unless we've timed out */
-			if (IS_ENABLED(CONFIG_MODULES) && !allow_default && ret == -ENODEV)
-				ret = -EPROBE_DEFER;
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
+				flags |= DRIVER_DEFER_PROBE_PERSIST;
 
-			return ret;
+			return driver_deferred_probe_check_state(p->dev, flags);
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
diff --git a/include/linux/device.h b/include/linux/device.h
index e0649f6adf2e..d364656a920c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -340,7 +340,23 @@ struct device *driver_find_device(struct device_driver *drv,
 				  int (*match)(struct device *dev, void *data));
 
 void driver_deferred_probe_add(struct device *dev);
-int driver_deferred_probe_check_state(struct device *dev);
+
+/*
+ * This can be use to continue to defer probe after the init stage and after
+ * all the built-in drivers have had a chance to probe. This is useful if a
+ * built-in driver requires resources provided by a modular driver.
+ *
+ * One such example is the pinctrl subsystem, where for example the DPAUX
+ * hardware on Tegra provides pinmuxing controls for pins shared between DPAUX
+ * and I2C controllers. Only a subset of I2C controllers need the DPAUX
+ * pinmuxing, and some I2C controllers are used during early boot for critical
+ * tasks (such as communicating with the system PMIC). The I2C controllers
+ * that don't share pins with a DPAUX block will want to be driven by a built-
+ * in driver to make sure they are available early on.
+ */
+#define DRIVER_DEFER_PROBE_PERSIST (1 << 0)
+
+int driver_deferred_probe_check_state(struct device *dev, unsigned long flags);
 
 /**
  * struct subsys_interface - interfaces to device functions
-- 
2.21.0

