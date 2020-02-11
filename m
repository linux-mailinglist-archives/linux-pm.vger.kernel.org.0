Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4214D159D76
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBKXiu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56653 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgBKXiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:50 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 534515a4e8c04bea; Wed, 12 Feb 2020 00:38:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 16/28] drm: i915: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:12:10 +0100
Message-ID: <1759702.XAW9B0MHEz@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/update/remove_request() instead of
pm_qos_add/update/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c |  4 ++--
 drivers/gpu/drm/i915/i915_drv.c         | 12 +++++-------
 drivers/gpu/drm/i915/intel_sideband.c   |  5 +++--
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index c7424e2a04a3..208457005a11 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1360,7 +1360,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
 	 * lowest possible wakeup latency and so prevent the cpu from going into
 	 * deep sleep states.
 	 */
-	pm_qos_update_request(&i915->pm_qos, 0);
+	cpu_latency_qos_update_request(&i915->pm_qos, 0);
 
 	intel_dp_check_edp(intel_dp);
 
@@ -1488,7 +1488,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
 
 	ret = recv_bytes;
 out:
-	pm_qos_update_request(&i915->pm_qos, PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_update_request(&i915->pm_qos, PM_QOS_DEFAULT_VALUE);
 
 	if (vdd)
 		edp_panel_vdd_off(intel_dp, false);
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index f7385abdd74b..74481a189cfc 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -502,8 +502,7 @@ static int i915_driver_early_probe(struct drm_i915_private *dev_priv)
 	mutex_init(&dev_priv->backlight_lock);
 
 	mutex_init(&dev_priv->sb_lock);
-	pm_qos_add_request(&dev_priv->sb_qos,
-			   PM_QOS_CPU_DMA_LATENCY, PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_add_request(&dev_priv->sb_qos, PM_QOS_DEFAULT_VALUE);
 
 	mutex_init(&dev_priv->av_mutex);
 	mutex_init(&dev_priv->wm.wm_mutex);
@@ -568,7 +567,7 @@ static void i915_driver_late_release(struct drm_i915_private *dev_priv)
 	vlv_free_s0ix_state(dev_priv);
 	i915_workqueues_cleanup(dev_priv);
 
-	pm_qos_remove_request(&dev_priv->sb_qos);
+	cpu_latency_qos_remove_request(&dev_priv->sb_qos);
 	mutex_destroy(&dev_priv->sb_lock);
 }
 
@@ -1226,8 +1225,7 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 		}
 	}
 
-	pm_qos_add_request(&dev_priv->pm_qos, PM_QOS_CPU_DMA_LATENCY,
-			   PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_add_request(&dev_priv->pm_qos, PM_QOS_DEFAULT_VALUE);
 
 	intel_gt_init_workarounds(dev_priv);
 
@@ -1273,7 +1271,7 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 err_msi:
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
-	pm_qos_remove_request(&dev_priv->pm_qos);
+	cpu_latency_qos_remove_request(&dev_priv->pm_qos);
 err_mem_regions:
 	intel_memory_regions_driver_release(dev_priv);
 err_ggtt:
@@ -1296,7 +1294,7 @@ static void i915_driver_hw_remove(struct drm_i915_private *dev_priv)
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
 
-	pm_qos_remove_request(&dev_priv->pm_qos);
+	cpu_latency_qos_remove_request(&dev_priv->pm_qos);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/intel_sideband.c b/drivers/gpu/drm/i915/intel_sideband.c
index cbfb7171d62d..0648eda309e4 100644
--- a/drivers/gpu/drm/i915/intel_sideband.c
+++ b/drivers/gpu/drm/i915/intel_sideband.c
@@ -60,7 +60,7 @@ static void __vlv_punit_get(struct drm_i915_private *i915)
 	 * to the Valleyview P-unit and not all sideband communications.
 	 */
 	if (IS_VALLEYVIEW(i915)) {
-		pm_qos_update_request(&i915->sb_qos, 0);
+		cpu_latency_qos_update_request(&i915->sb_qos, 0);
 		on_each_cpu(ping, NULL, 1);
 	}
 }
@@ -68,7 +68,8 @@ static void __vlv_punit_get(struct drm_i915_private *i915)
 static void __vlv_punit_put(struct drm_i915_private *i915)
 {
 	if (IS_VALLEYVIEW(i915))
-		pm_qos_update_request(&i915->sb_qos, PM_QOS_DEFAULT_VALUE);
+		cpu_latency_qos_update_request(&i915->sb_qos,
+					       PM_QOS_DEFAULT_VALUE);
 
 	iosf_mbi_punit_release();
 }
-- 
2.16.4





