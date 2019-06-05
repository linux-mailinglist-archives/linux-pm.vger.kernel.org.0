Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3DE35F22
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfFEOXQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 10:23:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfFEOXQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 10:23:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so3857804wrv.2;
        Wed, 05 Jun 2019 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbOPhnIhf4nfTs1vXUxhyXev98Rz11boEidIV7ZETKk=;
        b=EuEneBRAGkY2tXZgyGWpkYs3pssJaYscTtAV6fF+ZUopRxcgPkJfZKX0HopW6Lkm/B
         v0O0oJk05l5BeYYV3/wScnTxlxrKSFKaW0n3OY4+sL26NZqwqXPfTXH6OuXcNMc3to6C
         yB+4q/3CRhEoim7r7L2rNr+uao6W6rGkdQpQ1BG8uZQvPknZ1nwm1MCZV3kjTL/wdY7b
         +/hbkq+i7KuStkxLx6hlLNVMphhNCy6wf+ePNC8XjiPAMdnVjuoOz9yhynbfwZX2E/oe
         yMiTYc6btStoKYLTdudtbAG+geL466JIqTD5ww+WAFb4wskkxUKzpZAbglRkWOd6a+A0
         tXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbOPhnIhf4nfTs1vXUxhyXev98Rz11boEidIV7ZETKk=;
        b=b+jVJkFn5QPzD8CQMVtnbS33CRLb9rSg7yEibBBTLICyxON3iPCaQ/+612vi+yyjNt
         jzGWflzz2wbQ0aRQ2szGD5s++nCXLMHBARCS3TDXvpWiNS2xON+wkQqFo8bU2ZoE/ry4
         Yw1xIG8d+DTHNiG0DA1pPTSrtIZX7JDx3g3g40eUjBe4tw9nxZE2WtVdzRtxk8tPeIFp
         rZc5R3hoixjgCcoPf916dyJvnjZrjIAjF5k2GkbmBUMGw8eW/el4QN0PqxlmkOGEPoW0
         dI3jmkrg1iL+L82o7aEl92BOQUbaOsIOFRKxxXRBiwNgTeUJTUpmRRK6YkBUw1sp2Wle
         uNSA==
X-Gm-Message-State: APjAAAUpoZc7LiBxhHXu1bAu0sV9xIcvXUO/BEzySJ1jaxTkEhAkHGLv
        +/xhRKHITx69ebSuQx4NjlM=
X-Google-Smtp-Source: APXvYqzLt6ho0E63Grp+IikWcNCxLnkedoLM118ioYRsTDO89bPGBtcLhBRXsyeAz6UrVn2JD1cC1w==
X-Received: by 2002:a5d:68d2:: with SMTP id p18mr4785213wrw.56.1559744593985;
        Wed, 05 Jun 2019 07:23:13 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id f10sm34787410wrg.24.2019.06.05.07.23.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 07:23:13 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver: core: Allow subsystems to continue deferring probe
Date:   Wed,  5 Jun 2019 16:23:12 +0200
Message-Id: <20190605142312.6072-1-thierry.reding@gmail.com>
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
 drivers/base/dd.c            | 17 ++++++++++++-----
 drivers/base/power/domain.c  |  2 +-
 drivers/iommu/of_iommu.c     |  2 +-
 drivers/pinctrl/devicetree.c | 10 ++++++----
 include/linux/device.h       |  2 +-
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0df9b4461766..25ffbadf4187 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -238,23 +238,30 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 /**
  * driver_deferred_probe_check_state() - Check deferred probe state
  * @dev: device to check
+ * @persist: Boolean flag indicating whether drivers should keep trying to
+ *   probe after built-in drivers have had a chance to probe. This is useful
+ *   for built-in drivers that rely on resources provided by modular drivers.
  *
  * Returns -ENODEV if init is done and all built-in drivers have had a chance
- * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
- * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
+ * to probe (i.e. initcalls are done) and unless persist is set, -ETIMEDOUT if
+ * deferred probe debug timeout has expired, or -EPROBE_DEFER if none of those
+ * conditions are met.
  *
  * Drivers or subsystems can opt-in to calling this function instead of directly
  * returning -EPROBE_DEFER.
  */
-int driver_deferred_probe_check_state(struct device *dev)
+int driver_deferred_probe_check_state(struct device *dev, bool persist)
 {
 	if (initcalls_done) {
 		if (!deferred_probe_timeout) {
 			dev_WARN(dev, "deferred probe timeout, ignoring dependency");
 			return -ETIMEDOUT;
 		}
-		dev_warn(dev, "ignoring dependency for device, assuming no driver");
-		return -ENODEV;
+
+		if (!persist) {
+			dev_warn(dev, "ignoring dependency for device, assuming no driver");
+			return -ENODEV;
+		}
 	}
 	return -EPROBE_DEFER;
 }
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 33c30c1e6a30..effa5276a773 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2423,7 +2423,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return driver_deferred_probe_check_state(base_dev);
+		return driver_deferred_probe_check_state(base_dev, false);
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index f04a6df65eb8..70f3946b088a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -117,7 +117,7 @@ static int of_iommu_xlate(struct device *dev,
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
 	if (!ops)
-		return driver_deferred_probe_check_state(dev);
+		return driver_deferred_probe_check_state(dev, false);
 
 	return ops->of_xlate(dev, iommu_spec);
 }
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index f7e354f85518..c808bf567d24 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -111,13 +111,15 @@ static int dt_to_map_one_config(struct pinctrl *p,
 
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
+			bool persist = false;
+
 			of_node_put(np_pctldev);
-			ret = driver_deferred_probe_check_state(p->dev);
 			/* keep deferring if modules are enabled unless we've timed out */
-			if (IS_ENABLED(CONFIG_MODULES) && !allow_default && ret == -ENODEV)
-				ret = -EPROBE_DEFER;
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
+				persist = true;
 
-			return ret;
+			return driver_deferred_probe_check_state(p->dev,
+								 persist);
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
diff --git a/include/linux/device.h b/include/linux/device.h
index e0649f6adf2e..ecf59dfcbfb7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -340,7 +340,7 @@ struct device *driver_find_device(struct device_driver *drv,
 				  int (*match)(struct device *dev, void *data));
 
 void driver_deferred_probe_add(struct device *dev);
-int driver_deferred_probe_check_state(struct device *dev);
+int driver_deferred_probe_check_state(struct device *dev, bool persist);
 
 /**
  * struct subsys_interface - interfaces to device functions
-- 
2.21.0

