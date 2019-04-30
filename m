Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430B9FF59
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfD3SFq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 14:05:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60870 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfD3SFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 14:05:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id D746728335F
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com
Subject: [RFC 2/4] drm: rockchip: Add DDR devfreq support.
Date:   Tue, 30 Apr 2019 14:05:22 -0400
Message-Id: <20190430180524.22710-3-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430180524.22710-1-gael.portay@collabora.com>
References: <20190430180524.22710-1-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit adds the support for devfreq to control the DDR frequency
dynamically.

Glitches affect the display when the DMC devfreq device changes the DDR
frequency during the scanout. The DRM driver synchronizes the rate
change within the VBLANK.

The VOP locks the DMC devfreq device that causes it to notified when a
rate change is wanted. Then, the VOP enables the VBLANK interrupt,
releases the lock when the interrupt arises and locks the devfreq device
again after the vblank pulse ends using a timer.

The DRM driver disables the devfreq device if more than one CRTC becomes
active.

Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  51 +++++-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   6 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 177 +++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.h  |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  82 +++++++++
 5 files changed, 315 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index d7fa17f12769..ef843568a7f8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -19,6 +19,8 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq-event.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-iommu.h>
 #include <linux/pm_runtime.h>
@@ -78,6 +80,46 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 	iommu_detach_device(domain, dev);
 }
 
+#if IS_ENABLED(CONFIG_ARM_RK3399_DMC_DEVFREQ)
+static int rockchip_drm_init_devfreq(struct device *dev,
+				     struct rockchip_drm_private *priv)
+{
+	struct devfreq *devfreq;
+	struct devfreq_event_dev *edev;
+	int ret;
+
+	devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
+	if (IS_ERR(devfreq)) {
+		ret = PTR_ERR(devfreq);
+		if (ret == -ENODEV) {
+			DRM_DEV_INFO(dev, "devfreq missing, skip\n");
+			return 0;
+		}
+		return ret;
+	}
+
+	edev = devfreq_event_get_edev_by_phandle(devfreq->dev.parent, 0);
+	if (IS_ERR(edev)) {
+		ret = PTR_ERR(edev);
+		if (ret == -ENODEV) {
+			DRM_DEV_INFO(dev, "devfreq edev missing, skip\n");
+			return 0;
+		}
+		return ret;
+	}
+
+	priv->devfreq = devfreq;
+	priv->devfreq_event_dev = edev;
+	return 0;
+}
+#else
+static int rockchip_drm_init_devfreq(struct device *dev,
+				     struct rockchip_drm_private *priv)
+{
+	return 0;
+}
+#endif
+
 static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
 {
 	struct rockchip_drm_private *private = drm_dev->dev_private;
@@ -137,13 +179,19 @@ static int rockchip_drm_bind(struct device *dev)
 	INIT_LIST_HEAD(&private->psr_list);
 	mutex_init(&private->psr_list_lock);
 
+	ret = rockchip_drm_init_devfreq(dev, private);
+	if (ret)
+		goto err_free;
+
 	ret = rockchip_drm_init_iommu(drm_dev);
 	if (ret)
 		goto err_free;
 
 	drm_mode_config_init(drm_dev);
 
-	rockchip_drm_mode_config_init(drm_dev);
+	ret = rockchip_drm_mode_config_init(drm_dev);
+	if (ret)
+		goto err_free;
 
 	/* Try to bind all sub drivers. */
 	ret = component_bind_all(dev, drm_dev);
@@ -201,6 +249,7 @@ static void rockchip_drm_unbind(struct device *dev)
 	drm_atomic_helper_shutdown(drm_dev);
 	component_unbind_all(dev, drm_dev);
 	drm_mode_config_cleanup(drm_dev);
+	rockchip_drm_mode_config_fini(drm_dev);
 	rockchip_iommu_cleanup(drm_dev);
 
 	drm_dev->dev_private = NULL;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index ce48568ec8a0..0ac7e31b5605 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -18,6 +18,7 @@
 #define _ROCKCHIP_DRM_DRV_H
 
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem.h>
 
@@ -57,6 +58,10 @@ struct rockchip_drm_private {
 	struct drm_mm mm;
 	struct list_head psr_list;
 	struct mutex psr_list_lock;
+
+	struct devfreq *devfreq;
+	struct devfreq_event_dev *devfreq_event_dev;
+	struct drm_private_obj ddrfreq_lock_manager;
 };
 
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
@@ -66,6 +71,7 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 
 int rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
+uint32_t rockchip_drm_get_vblank_ns(struct drm_display_mode *mode);
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
 extern struct platform_driver dw_mipi_dsi_rockchip_driver;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 97438bbbe389..613a99c20ed3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/devfreq.h>
 #include <drm/drm.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
@@ -25,6 +26,56 @@
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_psr.h"
 
+struct rockchip_ddrfreq_lock_state {
+	struct drm_private_state base;
+	int lock_counter;
+};
+
+#define to_ddrfreq_lock_state(x) container_of(x, \
+				       struct rockchip_ddrfreq_lock_state, base)
+
+struct drm_private_state *rockchip_atomic_duplicate_ddrfreq_lock_state(
+						    struct drm_private_obj *obj)
+{
+	struct rockchip_ddrfreq_lock_state *ddrfreq_lock_state;
+
+	ddrfreq_lock_state = kmemdup(obj->state, sizeof(*ddrfreq_lock_state),
+				     GFP_KERNEL);
+	if (!ddrfreq_lock_state)
+		return NULL;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj,
+						     &ddrfreq_lock_state->base);
+
+	return &ddrfreq_lock_state->base;
+}
+
+void rockchip_atomic_destroy_ddrfreq_lock_state(struct drm_private_obj *obj,
+						struct drm_private_state *state)
+{
+	struct rockchip_ddrfreq_lock_state *ddrfreq_lock_state =
+						   to_ddrfreq_lock_state(state);
+
+	kfree(ddrfreq_lock_state);
+}
+
+struct drm_private_state_funcs rockchip_ddrfreq_lock_state_funcs = {
+	.atomic_duplicate_state = rockchip_atomic_duplicate_ddrfreq_lock_state,
+	.atomic_destroy_state = rockchip_atomic_destroy_ddrfreq_lock_state,
+};
+
+static struct rockchip_ddrfreq_lock_state *rockchip_get_ddrfreq_lock_state(
+		    struct drm_atomic_state *state, struct drm_private_obj *obj)
+{
+	struct drm_private_state *priv_state;
+
+	priv_state = drm_atomic_get_private_obj_state(state, obj);
+	if (IS_ERR(priv_state))
+		return ERR_CAST(priv_state);
+
+	return to_ddrfreq_lock_state(priv_state);
+}
+
 static int rockchip_drm_fb_dirty(struct drm_framebuffer *fb,
 				 struct drm_file *file,
 				 unsigned int flags, unsigned int color,
@@ -127,10 +178,80 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	return ERR_PTR(ret);
 }
 
+static void
+rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	u32 encoder_mask = 0;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		encoder_mask |= crtc_state->encoder_mask;
+		encoder_mask |= crtc->state->encoder_mask;
+	}
+
+	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
+		rockchip_drm_psr_inhibit_get(encoder);
+}
+
+uint32_t rockchip_drm_get_vblank_ns(struct drm_display_mode *mode)
+{
+	uint64_t vblank_time = mode->vtotal - mode->vdisplay;
+
+	vblank_time *= (uint64_t)NSEC_PER_SEC * mode->htotal;
+	do_div(vblank_time, mode->clock * 1000);
+
+	return vblank_time;
+}
+
+static void
+rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	u32 encoder_mask = 0;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		encoder_mask |= crtc_state->encoder_mask;
+		encoder_mask |= crtc->state->encoder_mask;
+	}
+
+	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
+		rockchip_drm_psr_inhibit_put(encoder);
+}
+
 static void
 rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	struct rockchip_drm_private *priv = dev->dev_private;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct rockchip_ddrfreq_lock_state *ddrfreq_lock_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state,
+				      new_crtc_state, i) {
+		if (old_crtc_state->enable == new_crtc_state->enable)
+			continue;
+
+		ddrfreq_lock_state = rockchip_get_ddrfreq_lock_state(old_state,
+						   &priv->ddrfreq_lock_manager);
+		if (IS_ERR(ddrfreq_lock_state))
+			break;
+
+		/* TODO This logic based on the previous state looks weird :/ */
+		if (old_crtc_state->enable &&
+		    ddrfreq_lock_state->lock_counter == 2)
+			devfreq_resume_device(priv->devfreq);
+		else if (!old_crtc_state->enable &&
+			 ddrfreq_lock_state->lock_counter == 1)
+			devfreq_suspend_device(priv->devfreq);
+	}
 
 	rockchip_drm_psr_inhibit_get_state(old_state);
 
@@ -154,10 +275,41 @@ static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers =
 	.atomic_commit_tail = rockchip_atomic_helper_commit_tail_rpm,
 };
 
+static int rockchip_drm_atomic_check(struct drm_device *dev,
+				     struct drm_atomic_state *state)
+{
+	struct rockchip_drm_private *priv = dev->dev_private;
+	struct rockchip_ddrfreq_lock_state *ddrfreq_lock_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	int ret;
+	int i;
+
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret == 0) {
+		for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+			if (!crtc_state->active_changed)
+				continue;
+
+			ddrfreq_lock_state = rockchip_get_ddrfreq_lock_state(
+					    state, &priv->ddrfreq_lock_manager);
+			if (IS_ERR(ddrfreq_lock_state))
+				return PTR_ERR(ddrfreq_lock_state);
+
+			if (crtc_state->enable)
+				ddrfreq_lock_state->lock_counter++;
+			else
+				ddrfreq_lock_state->lock_counter--;
+		}
+	}
+
+	return ret;
+}
+
 static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
 	.fb_create = rockchip_user_fb_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
-	.atomic_check = drm_atomic_helper_check,
+	.atomic_check = rockchip_drm_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
@@ -175,8 +327,11 @@ rockchip_drm_framebuffer_init(struct drm_device *dev,
 	return fb;
 }
 
-void rockchip_drm_mode_config_init(struct drm_device *dev)
+int rockchip_drm_mode_config_init(struct drm_device *dev)
 {
+	struct rockchip_drm_private *priv = dev->dev_private;
+	struct rockchip_ddrfreq_lock_state *ddrfreq_lock_state;
+
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
 
@@ -190,4 +345,22 @@ void rockchip_drm_mode_config_init(struct drm_device *dev)
 
 	dev->mode_config.funcs = &rockchip_drm_mode_config_funcs;
 	dev->mode_config.helper_private = &rockchip_mode_config_helpers;
+
+	ddrfreq_lock_state = kzalloc(sizeof(*ddrfreq_lock_state),
+				     GFP_KERNEL);
+	if (!ddrfreq_lock_state)
+		return -ENOMEM;
+
+	drm_atomic_private_obj_init(&priv->ddrfreq_lock_manager,
+				    &ddrfreq_lock_state->base,
+				    &rockchip_ddrfreq_lock_state_funcs);
+
+	return 0;
+}
+
+void rockchip_drm_mode_config_fini(struct drm_device *dev)
+{
+	struct rockchip_drm_private *priv = dev->dev_private;
+
+	drm_atomic_private_obj_fini(&priv->ddrfreq_lock_manager);
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.h b/drivers/gpu/drm/rockchip/rockchip_drm_fb.h
index f1265cb1aee8..a81df4ef8b35 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.h
@@ -21,5 +21,6 @@ rockchip_drm_framebuffer_init(struct drm_device *dev,
 			      struct drm_gem_object *obj);
 void rockchip_drm_framebuffer_fini(struct drm_framebuffer *fb);
 
-void rockchip_drm_mode_config_init(struct drm_device *dev);
+int rockchip_drm_mode_config_init(struct drm_device *dev);
+void rockchip_drm_mode_config_fini(struct drm_device *dev);
 #endif /* _ROCKCHIP_DRM_FB_H */
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 0d4ade9d4722..e76a68ae3991 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -36,6 +36,8 @@
 #include <linux/component.h>
 #include <linux/overflow.h>
 
+#include <linux/devfreq.h>
+
 #include <linux/reset.h>
 #include <linux/delay.h>
 
@@ -141,6 +143,12 @@ struct vop {
 
 	struct completion line_flag_completion;
 
+	/* devfreq locking */
+	spinlock_t devfreq_lock;
+	bool want_to_change_rate;
+	struct devfreq_dev_userlock devfreq_userlock;
+	struct hrtimer vblank_timer;
+
 	const struct vop_data *data;
 
 	uint32_t *regsbak;
@@ -632,9 +640,12 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
 	struct vop *vop = to_vop(crtc);
+	struct rockchip_drm_private *priv = vop->crtc.dev->dev_private;
 
 	WARN_ON(vop->event);
 
+	devfreq_unlock_device(priv->devfreq, &vop->devfreq_userlock, 0);
+
 	mutex_lock(&vop->vop_lock);
 	drm_crtc_vblank_off(crtc);
 
@@ -1028,6 +1039,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 	struct vop *vop = to_vop(crtc);
 	const struct vop_data *vop_data = vop->data;
+	struct rockchip_drm_private *priv = vop->crtc.dev->dev_private;
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc->state);
 	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
 	u16 hsync_len = adjusted_mode->hsync_end - adjusted_mode->hsync_start;
@@ -1123,6 +1135,11 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	VOP_REG_SET(vop, common, standby, 0);
 	mutex_unlock(&vop->vop_lock);
+
+	ret = devfreq_lock_device(priv->devfreq, &vop->devfreq_userlock);
+	if (ret)
+		DRM_DEV_ERROR(vop->dev,
+			      "cannot lock devfreq - err %d\n", ret);
 }
 
 static bool vop_fs_irq_is_pending(struct vop *vop)
@@ -1349,10 +1366,44 @@ static void vop_handle_vblank(struct vop *vop)
 		drm_flip_work_commit(&vop->fb_unref_work, system_unbound_wq);
 }
 
+static enum hrtimer_restart vblank_timer_function(struct hrtimer *timer)
+{
+	struct vop *vop = container_of(timer, struct vop, vblank_timer);
+	struct rockchip_drm_private *priv = vop->crtc.dev->dev_private;
+	struct devfreq *devfreq = priv->devfreq;
+
+	drm_crtc_vblank_put(&vop->crtc);
+
+	devfreq_lock_device(devfreq, &vop->devfreq_userlock);
+
+	spin_lock(&vop->devfreq_lock);
+	vop->want_to_change_rate = false;
+	spin_unlock(&vop->devfreq_lock);
+
+	return HRTIMER_NORESTART;
+}
+
+static void want_to_change_rate(struct devfreq_dev_userlock *userlock,
+				struct devfreq *devfreq)
+{
+	struct vop *vop = container_of(userlock, struct vop, devfreq_userlock);
+	int err;
+
+	spin_lock(&vop->devfreq_lock);
+	vop->want_to_change_rate = true;
+	spin_unlock(&vop->devfreq_lock);
+
+	err = drm_crtc_vblank_get(&vop->crtc);
+	if (err)
+		DRM_DEV_ERROR(vop->dev, "couldn't get vblank %d\n", err);
+}
+
 static irqreturn_t vop_isr(int irq, void *data)
 {
 	struct vop *vop = data;
 	struct drm_crtc *crtc = &vop->crtc;
+	struct rockchip_drm_private *priv = crtc->dev->dev_private;
+	ktime_t vblank_timeout;
 	uint32_t active_irqs;
 	int ret = IRQ_NONE;
 
@@ -1398,6 +1449,19 @@ static irqreturn_t vop_isr(int irq, void *data)
 	}
 
 	if (active_irqs & FS_INTR) {
+		spin_lock(&vop->devfreq_lock);
+		if (vop->want_to_change_rate) {
+			vop->want_to_change_rate = false;
+			vblank_timeout = ktime_add_ns(ktime_get(),
+				       rockchip_drm_get_vblank_ns(&crtc->mode));
+			hrtimer_start(&vop->vblank_timer, vblank_timeout,
+				      HRTIMER_MODE_ABS);
+			devfreq_unlock_device(priv->devfreq,
+					      &vop->devfreq_userlock,
+					      vblank_timeout);
+		}
+		spin_unlock(&vop->devfreq_lock);
+
 		drm_crtc_handle_vblank(crtc);
 		vop_handle_vblank(vop);
 		active_irqs &= ~FS_INTR;
@@ -1746,6 +1810,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	const struct vop_data *vop_data;
+	struct rockchip_drm_private *priv;
 	struct drm_device *drm_dev = data;
 	struct vop *vop;
 	struct resource *res;
@@ -1815,6 +1880,20 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 		}
 	}
 
+	hrtimer_init(&vop->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	vop->vblank_timer.function = vblank_timer_function;
+
+	INIT_LIST_HEAD(&vop->devfreq_userlock.node);
+	vop->devfreq_userlock.want_to_change_rate = want_to_change_rate;
+
+	priv = vop->crtc.dev->dev_private;
+	ret = devfreq_register_dev_user_lock(&vop->devfreq_userlock,
+					     priv->devfreq);
+	if (ret)
+		DRM_DEV_ERROR(&pdev->dev,
+			      "cannot register to devfreq user lock - err %d\n",
+			      ret);
+
 	return 0;
 
 err_disable_pm_runtime:
@@ -1826,6 +1905,9 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 static void vop_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct vop *vop = dev_get_drvdata(dev);
+	struct rockchip_drm_private *priv = vop->crtc.dev->dev_private;
+
+	devfreq_unregister_dev_user_lock(&vop->devfreq_userlock, priv->devfreq);
 
 	if (vop->rgb)
 		rockchip_rgb_fini(vop->rgb);
-- 
2.21.0

