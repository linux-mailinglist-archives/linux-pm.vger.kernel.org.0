Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF304379AB6
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 01:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhEJX2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 19:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhEJX2i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 19:28:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1397C06175F;
        Mon, 10 May 2021 16:27:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m11so9442489lfg.3;
        Mon, 10 May 2021 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UI7+z11dkmf/P78QPJBSlMKu+uK/EhvZSD9Sc8LKS2E=;
        b=djcFs5P+dbdFwdVDvjR6LrI7MN9wEtCtXBPFGwM/K8g26azgqVsd/6hlmIitwlHxjk
         x8amf4z+WEVkv70cyFqL+bcMwB3OvkhDAe2C02CCXOc++TDqMnjq+fca3vaf//otct4d
         hZo/I9KpHnOfT6pp+031lDHXSxnlxJWxtKNgCr0teqFRfqHKk8yxi9iu3XYCSbV+mtt7
         35hvxXM0aAEIIdgjejs3JDT7eCwBw+sUWLQOgQ11MjXHBXs+kvzNt9X2TIJFc0tZYNmw
         KKlp9RzSnqj3YJDcIzR0sb9fOww8zEWoT5pMJjeWtZYGnzQ8bz38WhokuiXv7K4MNbyN
         qrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UI7+z11dkmf/P78QPJBSlMKu+uK/EhvZSD9Sc8LKS2E=;
        b=RwAqWxlXOEm86IGPnWFXHxTL2MX20OzJPOBq/2V8YOUyCjhyM9Wn06ZBjlkL8/jsOs
         EzCXy58DGDlNwO1wSzTVqRJzILen7tk4LAcfP67QAbxkWDT9A/uGSWZ0oMe9KsH68xC2
         moQOb1z/2qc5ex44wGBbu04etvoP74qdcMMS4cdoF79y6OD+SuslCFlzVvuJCGWgKwtf
         f1zG68eBY7dlC1TOgwlgxhPOHwucRHUhpbTCBoUelanAZgDG9YgaSYHmfgM0YvkTSRDY
         iJFhVzk80zcSV1R4bMdJE7LoIslFXjg7tgekzTLXVGa0R2bgTCS9YLfF5VFG0AIhqWGV
         3voA==
X-Gm-Message-State: AOAM5316c3gAyJgqZB3m2JYAT10Lyh9X1lNA7vYqY+HLqxhAt6EafXYJ
        /NFCu5pQ0GDFav3IkxQXDl8=
X-Google-Smtp-Source: ABdhPJy9Lu0IDalVz0lnliC1MaqcUFsXgYnYQxkBMjubg/uCD9EVeLjhdOmcfz0GQJZcckvZ8JAmjA==
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr12704444lfn.632.1620689251308;
        Mon, 10 May 2021 16:27:31 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id f29sm3354203ljo.69.2021.05.10.16.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 16:27:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v17 1/2] drm/tegra: dc: Support memory bandwidth management
Date:   Tue, 11 May 2021 02:27:08 +0300
Message-Id: <20210510232709.1349-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510232709.1349-1-digetx@gmail.com>
References: <20210510232709.1349-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Display controller (DC) performs isochronous memory transfers, and thus,
has a requirement for a minimum memory bandwidth that shall be fulfilled,
otherwise framebuffer data can't be fetched fast enough and this results
in a DC's data-FIFO underflow that follows by a visual corruption.

The Memory Controller drivers provide facility for memory bandwidth
management via interconnect API. Let's wire up the interconnect API
support to the DC driver in order to fix the distorted display output
on T30 Ouya, T124 TK1 and other Tegra devices.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/Kconfig |   1 +
 drivers/gpu/drm/tegra/dc.c    | 352 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.h    |  14 ++
 drivers/gpu/drm/tegra/drm.c   |  14 ++
 drivers/gpu/drm/tegra/hub.c   |   3 +
 drivers/gpu/drm/tegra/plane.c | 116 +++++++++++
 drivers/gpu/drm/tegra/plane.h |  15 ++
 7 files changed, 515 insertions(+)

diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 5043dcaf1cf9..1650a448eabd 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -9,6 +9,7 @@ config DRM_TEGRA
 	select DRM_MIPI_DSI
 	select DRM_PANEL
 	select TEGRA_HOST1X
+	select INTERCONNECT
 	select IOMMU_IOVA
 	select CEC_CORE if CEC_NOTIFIER
 	help
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index f9120dc24682..9997e4942bf8 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -8,6 +8,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/iommu.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
@@ -618,6 +619,9 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	struct tegra_dc *dc = to_tegra_dc(new_plane_state->crtc);
 	int err;
 
+	plane_state->peak_memory_bandwidth = 0;
+	plane_state->avg_memory_bandwidth = 0;
+
 	/* no need for further checks if the plane is being disabled */
 	if (!new_plane_state->crtc)
 		return 0;
@@ -808,6 +812,12 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	formats = dc->soc->primary_formats;
 	modifiers = dc->soc->modifiers;
 
+	err = tegra_plane_interconnect_init(plane);
+	if (err) {
+		kfree(plane);
+		return ERR_PTR(err);
+	}
+
 	err = drm_universal_plane_init(drm, &plane->base, possible_crtcs,
 				       &tegra_plane_funcs, formats,
 				       num_formats, modifiers, type, NULL);
@@ -845,9 +855,13 @@ static int tegra_cursor_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
+	struct tegra_plane_state *plane_state = to_tegra_plane_state(new_plane_state);
 	struct tegra_plane *tegra = to_tegra_plane(plane);
 	int err;
 
+	plane_state->peak_memory_bandwidth = 0;
+	plane_state->avg_memory_bandwidth = 0;
+
 	/* no need for further checks if the plane is being disabled */
 	if (!new_plane_state->crtc)
 		return 0;
@@ -1030,6 +1044,12 @@ static struct drm_plane *tegra_dc_cursor_plane_create(struct drm_device *drm,
 		formats = tegra_cursor_plane_formats;
 	}
 
+	err = tegra_plane_interconnect_init(plane);
+	if (err) {
+		kfree(plane);
+		return ERR_PTR(err);
+	}
+
 	err = drm_universal_plane_init(drm, &plane->base, possible_crtcs,
 				       &tegra_plane_funcs, formats,
 				       num_formats, NULL,
@@ -1144,6 +1164,12 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 	num_formats = dc->soc->num_overlay_formats;
 	formats = dc->soc->overlay_formats;
 
+	err = tegra_plane_interconnect_init(plane);
+	if (err) {
+		kfree(plane);
+		return ERR_PTR(err);
+	}
+
 	if (!cursor)
 		type = DRM_PLANE_TYPE_OVERLAY;
 	else
@@ -1261,6 +1287,7 @@ tegra_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 {
 	struct tegra_dc_state *state = to_dc_state(crtc->state);
 	struct tegra_dc_state *copy;
+	unsigned int i;
 
 	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
 	if (!copy)
@@ -1272,6 +1299,9 @@ tegra_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 	copy->div = state->div;
 	copy->planes = state->planes;
 
+	for (i = 0; i < ARRAY_SIZE(state->plane_peak_bw); i++)
+		copy->plane_peak_bw[i] = state->plane_peak_bw[i];
+
 	return &copy->base;
 }
 
@@ -1798,6 +1828,106 @@ static int tegra_dc_wait_idle(struct tegra_dc *dc, unsigned long timeout)
 	return -ETIMEDOUT;
 }
 
+static void
+tegra_crtc_update_memory_bandwidth(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state,
+				   bool prepare_bandwidth_transition)
+{
+	const struct tegra_plane_state *old_tegra_state, *new_tegra_state;
+	const struct tegra_dc_state *old_dc_state, *new_dc_state;
+	u32 i, new_avg_bw, old_avg_bw, new_peak_bw, old_peak_bw;
+	const struct drm_plane_state *old_plane_state;
+	const struct drm_crtc_state *old_crtc_state;
+	struct tegra_dc_window window, old_window;
+	struct tegra_dc *dc = to_tegra_dc(crtc);
+	struct tegra_plane *tegra;
+	struct drm_plane *plane;
+
+	if (dc->soc->has_nvdisplay)
+		return;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
+	old_dc_state = to_const_dc_state(old_crtc_state);
+	new_dc_state = to_const_dc_state(crtc->state);
+
+	if (!crtc->state->active) {
+		if (!old_crtc_state->active)
+			return;
+
+		/*
+		 * When CRTC is disabled on DPMS, the state of attached planes
+		 * is kept unchanged. Hence we need to enforce removal of the
+		 * bandwidths from the ICC paths.
+		 */
+		drm_atomic_crtc_for_each_plane(plane, crtc) {
+			tegra = to_tegra_plane(plane);
+
+			icc_set_bw(tegra->icc_mem, 0, 0);
+			icc_set_bw(tegra->icc_mem_vfilter, 0, 0);
+		}
+
+		return;
+	}
+
+	for_each_old_plane_in_state(old_crtc_state->state, plane,
+				    old_plane_state, i) {
+		old_tegra_state = to_const_tegra_plane_state(old_plane_state);
+		new_tegra_state = to_const_tegra_plane_state(plane->state);
+		tegra = to_tegra_plane(plane);
+
+		/*
+		 * We're iterating over the global atomic state and it contains
+		 * planes from another CRTC, hence we need to filter out the
+		 * planes unrelated to this CRTC.
+		 */
+		if (tegra->dc != dc)
+			continue;
+
+		new_avg_bw = new_tegra_state->avg_memory_bandwidth;
+		old_avg_bw = old_tegra_state->avg_memory_bandwidth;
+
+		new_peak_bw = new_dc_state->plane_peak_bw[tegra->index];
+		old_peak_bw = old_dc_state->plane_peak_bw[tegra->index];
+
+		/*
+		 * See the comment related to !crtc->state->active above,
+		 * which explains why bandwidths need to be updated when
+		 * CRTC is turning ON.
+		 */
+		if (new_avg_bw == old_avg_bw && new_peak_bw == old_peak_bw &&
+		    old_crtc_state->active)
+			continue;
+
+		window.src.h = drm_rect_height(&plane->state->src) >> 16;
+		window.dst.h = drm_rect_height(&plane->state->dst);
+
+		old_window.src.h = drm_rect_height(&old_plane_state->src) >> 16;
+		old_window.dst.h = drm_rect_height(&old_plane_state->dst);
+
+		/*
+		 * During the preparation phase (atomic_begin), the memory
+		 * freq should go high before the DC changes are committed
+		 * if bandwidth requirement goes up, otherwise memory freq
+		 * should to stay high if BW requirement goes down.  The
+		 * opposite applies to the completion phase (post_commit).
+		 */
+		if (prepare_bandwidth_transition) {
+			new_avg_bw = max(old_avg_bw, new_avg_bw);
+			new_peak_bw = max(old_peak_bw, new_peak_bw);
+
+			if (tegra_plane_use_vertical_filtering(tegra, &old_window))
+				window = old_window;
+		}
+
+		icc_set_bw(tegra->icc_mem, new_avg_bw, new_peak_bw);
+
+		if (tegra_plane_use_vertical_filtering(tegra, &window))
+			icc_set_bw(tegra->icc_mem_vfilter, new_avg_bw, new_peak_bw);
+		else
+			icc_set_bw(tegra->icc_mem_vfilter, 0, 0);
+	}
+}
+
 static void tegra_crtc_atomic_disable(struct drm_crtc *crtc,
 				      struct drm_atomic_state *state)
 {
@@ -1979,6 +2109,8 @@ static void tegra_crtc_atomic_begin(struct drm_crtc *crtc,
 {
 	unsigned long flags;
 
+	tegra_crtc_update_memory_bandwidth(crtc, state, true);
+
 	if (crtc->state->event) {
 		spin_lock_irqsave(&crtc->dev->event_lock, flags);
 
@@ -2011,7 +2143,215 @@ static void tegra_crtc_atomic_flush(struct drm_crtc *crtc,
 	value = tegra_dc_readl(dc, DC_CMD_STATE_CONTROL);
 }
 
+static bool tegra_plane_is_cursor(const struct drm_plane_state *state)
+{
+	const struct tegra_dc_soc_info *soc = to_tegra_dc(state->crtc)->soc;
+	const struct drm_format_info *fmt = state->fb->format;
+	unsigned int src_w = drm_rect_width(&state->src) >> 16;
+	unsigned int dst_w = drm_rect_width(&state->dst);
+
+	if (state->plane->type != DRM_PLANE_TYPE_CURSOR)
+		return false;
+
+	if (soc->supports_cursor)
+		return true;
+
+	if (src_w != dst_w || fmt->num_planes != 1 || src_w * fmt->cpp[0] > 256)
+		return false;
+
+	return true;
+}
+
+static unsigned long
+tegra_plane_overlap_mask(struct drm_crtc_state *state,
+			 const struct drm_plane_state *plane_state)
+{
+	const struct drm_plane_state *other_state;
+	const struct tegra_plane *tegra;
+	unsigned long overlap_mask = 0;
+	struct drm_plane *plane;
+	struct drm_rect rect;
+
+	if (!plane_state->visible || !plane_state->fb)
+		return 0;
+
+	/*
+	 * Data-prefetch FIFO will easily help to overcome temporal memory
+	 * pressure if other plane overlaps with the cursor plane.
+	 */
+	if (tegra_plane_is_cursor(plane_state))
+		return 0;
+
+	drm_atomic_crtc_state_for_each_plane_state(plane, other_state, state) {
+		rect = plane_state->dst;
+
+		tegra = to_tegra_plane(other_state->plane);
+
+		if (!other_state->visible || !other_state->fb)
+			continue;
+
+		/*
+		 * Ignore cursor plane overlaps because it's not practical to
+		 * assume that it contributes to the bandwidth in overlapping
+		 * area if window width is small.
+		 */
+		if (tegra_plane_is_cursor(other_state))
+			continue;
+
+		if (drm_rect_intersect(&rect, &other_state->dst))
+			overlap_mask |= BIT(tegra->index);
+	}
+
+	return overlap_mask;
+}
+
+static struct drm_plane *
+tegra_crtc_get_plane_by_index(struct drm_crtc *crtc, unsigned int index)
+{
+	struct drm_plane *plane;
+
+	drm_atomic_crtc_for_each_plane(plane, crtc) {
+		if (to_tegra_plane(plane)->index == index)
+			return plane;
+	}
+
+	return NULL;
+}
+
+static int tegra_crtc_calculate_memory_bandwidth(struct drm_crtc *crtc,
+						 struct drm_atomic_state *state)
+{
+	ulong overlap_mask[TEGRA_DC_LEGACY_PLANES_NUM] = {}, mask;
+	u32 plane_peak_bw[TEGRA_DC_LEGACY_PLANES_NUM] = {};
+	bool all_planes_overlap_simultaneously = true;
+	const struct tegra_plane_state *tegra_state;
+	const struct drm_plane_state *plane_state;
+	const struct tegra_dc_state *old_dc_state;
+	struct tegra_dc *dc = to_tegra_dc(crtc);
+	const struct drm_crtc_state *old_state;
+	struct tegra_dc_state *new_dc_state;
+	struct drm_crtc_state *new_state;
+	struct tegra_plane *tegra;
+	struct drm_plane *plane;
+	u32 i, k, overlap_bw;
+
+	/*
+	 * The nv-display uses shared planes.  The algorithm below assumes
+	 * maximum 3 planes per-CRTC, this assumption isn't applicable to
+	 * the nv-display.  Note that T124 support has additional windows,
+	 * but currently they aren't supported by the driver.
+	 */
+	if (dc->soc->has_nvdisplay)
+		return 0;
+
+	new_state = drm_atomic_get_new_crtc_state(state, crtc);
+	new_dc_state = to_dc_state(new_state);
+
+	/*
+	 * For overlapping planes pixel's data is fetched for each plane at
+	 * the same time, hence bandwidths are accumulated in this case.
+	 * This needs to be taken into account for calculating total bandwidth
+	 * consumed by all planes.
+	 *
+	 * Here we get the overlapping state of each plane, which is a
+	 * bitmask of plane indices telling with what planes there is an
+	 * overlap. Note that bitmask[plane] includes BIT(plane) in order
+	 * to make further code nicer and simpler.
+	 */
+	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, new_state) {
+		tegra_state = to_const_tegra_plane_state(plane_state);
+		tegra = to_tegra_plane(plane);
+
+		if (WARN_ON_ONCE(tegra->index >= TEGRA_DC_LEGACY_PLANES_NUM))
+			return -EINVAL;
+
+		plane_peak_bw[tegra->index] = tegra_state->peak_memory_bandwidth;
+		mask = tegra_plane_overlap_mask(new_state, plane_state);
+		overlap_mask[tegra->index] = mask;
+
+		if (hweight_long(mask) != 3)
+			all_planes_overlap_simultaneously = false;
+	}
+
+	old_state = drm_atomic_get_old_crtc_state(state, crtc);
+	old_dc_state = to_const_dc_state(old_state);
+
+	/*
+	 * Then we calculate maximum bandwidth of each plane state.
+	 * The bandwidth includes the plane BW + BW of the "simultaneously"
+	 * overlapping planes, where "simultaneously" means areas where DC
+	 * fetches from the planes simultaneously during of scan-out process.
+	 *
+	 * For example, if plane A overlaps with planes B and C, but B and C
+	 * don't overlap, then the peak bandwidth will be either in area where
+	 * A-and-B or A-and-C planes overlap.
+	 *
+	 * The plane_peak_bw[] contains peak memory bandwidth values of
+	 * each plane, this information is needed by interconnect provider
+	 * in order to set up latency allowness based on the peak BW, see
+	 * tegra_crtc_update_memory_bandwidth().
+	 */
+	for (i = 0; i < ARRAY_SIZE(plane_peak_bw); i++) {
+		overlap_bw = 0;
+
+		for_each_set_bit(k, &overlap_mask[i], 3) {
+			if (k == i)
+				continue;
+
+			if (all_planes_overlap_simultaneously)
+				overlap_bw += plane_peak_bw[k];
+			else
+				overlap_bw = max(overlap_bw, plane_peak_bw[k]);
+		}
+
+		new_dc_state->plane_peak_bw[i] = plane_peak_bw[i] + overlap_bw;
+
+		/*
+		 * If plane's peak bandwidth changed (for example plane isn't
+		 * overlapped anymore) and plane isn't in the atomic state,
+		 * then add plane to the state in order to have the bandwidth
+		 * updated.
+		 */
+		if (old_dc_state->plane_peak_bw[i] !=
+		    new_dc_state->plane_peak_bw[i]) {
+			plane = tegra_crtc_get_plane_by_index(crtc, i);
+			if (!plane)
+				continue;
+
+			plane_state = drm_atomic_get_plane_state(state, plane);
+			if (IS_ERR(plane_state))
+				return PTR_ERR(plane_state);
+		}
+	}
+
+	return 0;
+}
+
+static int tegra_crtc_atomic_check(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state)
+{
+	int err;
+
+	err = tegra_crtc_calculate_memory_bandwidth(crtc, state);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state)
+{
+	/*
+	 * Display bandwidth is allowed to go down only once hardware state
+	 * is known to be armed, i.e. state was committed and VBLANK event
+	 * received.
+	 */
+	tegra_crtc_update_memory_bandwidth(crtc, state, false);
+}
+
 static const struct drm_crtc_helper_funcs tegra_crtc_helper_funcs = {
+	.atomic_check = tegra_crtc_atomic_check,
 	.atomic_begin = tegra_crtc_atomic_begin,
 	.atomic_flush = tegra_crtc_atomic_flush,
 	.atomic_enable = tegra_crtc_atomic_enable,
@@ -2337,7 +2677,9 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.overlay_formats = tegra20_overlay_formats,
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = true,
+	.has_win_b_vfilter_mem_client = true,
 	.has_win_c_without_vert_filter = true,
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -2357,7 +2699,9 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.overlay_formats = tegra20_overlay_formats,
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = false,
+	.has_win_b_vfilter_mem_client = true,
 	.has_win_c_without_vert_filter = false,
+	.plane_tiled_memory_bandwidth_x2 = true,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -2377,7 +2721,9 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.overlay_formats = tegra114_overlay_formats,
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = false,
+	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_tiled_memory_bandwidth_x2 = true,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -2397,7 +2743,9 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.overlay_formats = tegra124_overlay_formats,
 	.modifiers = tegra124_modifiers,
 	.has_win_a_without_filters = false,
+	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
@@ -2417,7 +2765,9 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.overlay_formats = tegra114_overlay_formats,
 	.modifiers = tegra124_modifiers,
 	.has_win_a_without_filters = false,
+	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct tegra_windowgroup_soc tegra186_dc_wgrps[] = {
@@ -2467,6 +2817,7 @@ static const struct tegra_dc_soc_info tegra186_dc_soc_info = {
 	.has_nvdisplay = true,
 	.wgrps = tegra186_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra186_dc_wgrps),
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct tegra_windowgroup_soc tegra194_dc_wgrps[] = {
@@ -2516,6 +2867,7 @@ static const struct tegra_dc_soc_info tegra194_dc_soc_info = {
 	.has_nvdisplay = true,
 	.wgrps = tegra194_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra194_dc_wgrps),
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct of_device_id tegra_dc_of_match[] = {
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 29f19c3c6149..db10af097033 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -15,6 +15,8 @@
 
 struct tegra_output;
 
+#define TEGRA_DC_LEGACY_PLANES_NUM	7
+
 struct tegra_dc_state {
 	struct drm_crtc_state base;
 
@@ -23,6 +25,8 @@ struct tegra_dc_state {
 	unsigned int div;
 
 	u32 planes;
+
+	unsigned long plane_peak_bw[TEGRA_DC_LEGACY_PLANES_NUM];
 };
 
 static inline struct tegra_dc_state *to_dc_state(struct drm_crtc_state *state)
@@ -33,6 +37,12 @@ static inline struct tegra_dc_state *to_dc_state(struct drm_crtc_state *state)
 	return NULL;
 }
 
+static inline const struct tegra_dc_state *
+to_const_dc_state(const struct drm_crtc_state *state)
+{
+	return to_dc_state((struct drm_crtc_state *)state);
+}
+
 struct tegra_dc_stats {
 	unsigned long frames;
 	unsigned long vblank;
@@ -66,7 +76,9 @@ struct tegra_dc_soc_info {
 	unsigned int num_overlay_formats;
 	const u64 *modifiers;
 	bool has_win_a_without_filters;
+	bool has_win_b_vfilter_mem_client;
 	bool has_win_c_without_vert_filter;
+	bool plane_tiled_memory_bandwidth_x2;
 };
 
 struct tegra_dc {
@@ -152,6 +164,8 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
 			       struct drm_crtc_state *crtc_state,
 			       struct clk *clk, unsigned long pclk,
 			       unsigned int div);
+void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state);
 
 /* from rgb.c */
 int tegra_dc_rgb_probe(struct tegra_dc *dc);
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index d76bcb6c5622..a10513d7f2e0 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -24,6 +24,7 @@
 #include <asm/dma-iommu.h>
 #endif
 
+#include "dc.h"
 #include "drm.h"
 #include "gem.h"
 
@@ -63,6 +64,17 @@ static const struct drm_mode_config_funcs tegra_drm_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static void tegra_atomic_post_commit(struct drm_device *drm,
+				     struct drm_atomic_state *old_state)
+{
+	struct drm_crtc_state *old_crtc_state __maybe_unused;
+	struct drm_crtc *crtc;
+	unsigned int i;
+
+	for_each_old_crtc_in_state(old_state, crtc, old_crtc_state, i)
+		tegra_crtc_atomic_post_commit(crtc, old_state);
+}
+
 static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *drm = old_state->dev;
@@ -82,6 +94,8 @@ static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
 	} else {
 		drm_atomic_helper_commit_tail_rpm(old_state);
 	}
+
+	tegra_atomic_post_commit(drm, old_state);
 }
 
 static const struct drm_mode_config_helper_funcs
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index bfae8a02f55b..f1bbc5991854 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -358,6 +358,9 @@ static int tegra_shared_plane_atomic_check(struct drm_plane *plane,
 	struct tegra_dc *dc = to_tegra_dc(new_plane_state->crtc);
 	int err;
 
+	plane_state->peak_memory_bandwidth = 0;
+	plane_state->avg_memory_bandwidth = 0;
+
 	/* no need for further checks if the plane is being disabled */
 	if (!new_plane_state->crtc || !new_plane_state->fb)
 		return 0;
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 2e11b4b1f702..c1dc603cf642 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/iommu.h>
+#include <linux/interconnect.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -64,6 +65,8 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	copy->reflect_x = state->reflect_x;
 	copy->reflect_y = state->reflect_y;
 	copy->opaque = state->opaque;
+	copy->peak_memory_bandwidth = state->peak_memory_bandwidth;
+	copy->avg_memory_bandwidth = state->avg_memory_bandwidth;
 
 	for (i = 0; i < 2; i++)
 		copy->blending[i] = state->blending[i];
@@ -244,6 +247,78 @@ void tegra_plane_cleanup_fb(struct drm_plane *plane,
 		tegra_dc_unpin(dc, to_tegra_plane_state(state));
 }
 
+static int tegra_plane_calculate_memory_bandwidth(struct drm_plane_state *state)
+{
+	struct tegra_plane_state *tegra_state = to_tegra_plane_state(state);
+	unsigned int i, bpp, dst_w, dst_h, src_w, src_h, mul;
+	const struct tegra_dc_soc_info *soc;
+	const struct drm_format_info *fmt;
+	struct drm_crtc_state *crtc_state;
+	u64 avg_bandwidth, peak_bandwidth;
+
+	if (!state->visible)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state->state, state->crtc);
+	if (!crtc_state)
+		return -EINVAL;
+
+	src_w = drm_rect_width(&state->src) >> 16;
+	src_h = drm_rect_height(&state->src) >> 16;
+	dst_w = drm_rect_width(&state->dst);
+	dst_h = drm_rect_height(&state->dst);
+
+	fmt = state->fb->format;
+	soc = to_tegra_dc(state->crtc)->soc;
+
+	/*
+	 * Note that real memory bandwidth vary depending on format and
+	 * memory layout, we are not taking that into account because small
+	 * estimation error isn't important since bandwidth is rounded up
+	 * anyway.
+	 */
+	for (i = 0, bpp = 0; i < fmt->num_planes; i++) {
+		unsigned int bpp_plane = fmt->cpp[i] * 8;
+
+		/*
+		 * Sub-sampling is relevant for chroma planes only and vertical
+		 * readouts are not cached, hence only horizontal sub-sampling
+		 * matters.
+		 */
+		if (i > 0)
+			bpp_plane /= fmt->hsub;
+
+		bpp += bpp_plane;
+	}
+
+	/* average bandwidth in kbytes/sec */
+	avg_bandwidth  = min(src_w, dst_w) * min(src_h, dst_h);
+	avg_bandwidth *= drm_mode_vrefresh(&crtc_state->adjusted_mode);
+	avg_bandwidth  = DIV_ROUND_UP(avg_bandwidth * bpp, 8) + 999;
+	do_div(avg_bandwidth, 1000);
+
+	/* mode.clock in kHz, peak bandwidth in kbytes/sec */
+	peak_bandwidth = DIV_ROUND_UP(crtc_state->adjusted_mode.clock * bpp, 8);
+
+	/*
+	 * Tegra30/114 Memory Controller can't interleave DC memory requests
+	 * for the tiled windows because DC uses 16-bytes atom, while DDR3
+	 * uses 32-bytes atom.  Hence there is x2 memory overfetch for tiled
+	 * framebuffer and DDR3 on these SoCs.
+	 */
+	if (soc->plane_tiled_memory_bandwidth_x2 &&
+	    tegra_state->tiling.mode == TEGRA_BO_TILING_MODE_TILED)
+		mul = 2;
+	else
+		mul = 1;
+
+	/* ICC bandwidth in kbytes/sec */
+	tegra_state->peak_memory_bandwidth = kBps_to_icc(peak_bandwidth) * mul;
+	tegra_state->avg_memory_bandwidth  = kBps_to_icc(avg_bandwidth)  * mul;
+
+	return 0;
+}
+
 int tegra_plane_state_add(struct tegra_plane *plane,
 			  struct drm_plane_state *state)
 {
@@ -262,6 +337,10 @@ int tegra_plane_state_add(struct tegra_plane *plane,
 	if (err < 0)
 		return err;
 
+	err = tegra_plane_calculate_memory_bandwidth(state);
+	if (err < 0)
+		return err;
+
 	tegra = to_dc_state(crtc_state);
 
 	tegra->planes |= WIN_A_ACT_REQ << plane->index;
@@ -627,3 +706,40 @@ int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
 
 	return 0;
 }
+
+static const char * const tegra_plane_icc_names[TEGRA_DC_LEGACY_PLANES_NUM] = {
+	"wina", "winb", "winc", NULL, NULL, NULL, "cursor",
+};
+
+int tegra_plane_interconnect_init(struct tegra_plane *plane)
+{
+	const char *icc_name = tegra_plane_icc_names[plane->index];
+	struct device *dev = plane->dc->dev;
+	struct tegra_dc *dc = plane->dc;
+	int err;
+
+	if (WARN_ON(plane->index >= TEGRA_DC_LEGACY_PLANES_NUM) ||
+	    WARN_ON(!tegra_plane_icc_names[plane->index]))
+		return -EINVAL;
+
+	plane->icc_mem = devm_of_icc_get(dev, icc_name);
+	err = PTR_ERR_OR_ZERO(plane->icc_mem);
+	if (err) {
+		dev_err_probe(dev, err, "failed to get %s interconnect\n",
+			      icc_name);
+		return err;
+	}
+
+	/* plane B on T20/30 has a dedicated memory client for a 6-tap vertical filter */
+	if (plane->index == 1 && dc->soc->has_win_b_vfilter_mem_client) {
+		plane->icc_mem_vfilter = devm_of_icc_get(dev, "winb-vfilter");
+		err = PTR_ERR_OR_ZERO(plane->icc_mem_vfilter);
+		if (err) {
+			dev_err_probe(dev, err, "failed to get %s interconnect\n",
+				      "winb-vfilter");
+			return err;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
index c691dd79b27b..f2731aae7d01 100644
--- a/drivers/gpu/drm/tegra/plane.h
+++ b/drivers/gpu/drm/tegra/plane.h
@@ -8,6 +8,7 @@
 
 #include <drm/drm_plane.h>
 
+struct icc_path;
 struct tegra_bo;
 struct tegra_dc;
 
@@ -16,6 +17,9 @@ struct tegra_plane {
 	struct tegra_dc *dc;
 	unsigned int offset;
 	unsigned int index;
+
+	struct icc_path *icc_mem;
+	struct icc_path *icc_mem_vfilter;
 };
 
 struct tegra_cursor {
@@ -52,6 +56,10 @@ struct tegra_plane_state {
 	/* used for legacy blending support only */
 	struct tegra_plane_legacy_blending_state blending[2];
 	bool opaque;
+
+	/* bandwidths are in ICC units, i.e. kbytes/sec */
+	u32 peak_memory_bandwidth;
+	u32 avg_memory_bandwidth;
 };
 
 static inline struct tegra_plane_state *
@@ -63,6 +71,12 @@ to_tegra_plane_state(struct drm_plane_state *state)
 	return NULL;
 }
 
+static inline const struct tegra_plane_state *
+to_const_tegra_plane_state(const struct drm_plane_state *state)
+{
+	return to_tegra_plane_state((struct drm_plane_state *)state);
+}
+
 extern const struct drm_plane_funcs tegra_plane_funcs;
 
 int tegra_plane_prepare_fb(struct drm_plane *plane,
@@ -77,5 +91,6 @@ int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
 bool tegra_plane_format_is_yuv(unsigned int format, bool *planar);
 int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
 				   struct tegra_plane_state *state);
+int tegra_plane_interconnect_init(struct tegra_plane *plane);
 
 #endif /* TEGRA_PLANE_H */
-- 
2.30.2

