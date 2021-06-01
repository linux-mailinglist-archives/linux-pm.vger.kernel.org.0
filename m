Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED844396C12
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhFAEXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 00:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbhFAEXC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 00:23:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD5EC06174A;
        Mon, 31 May 2021 21:21:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x38so19633730lfa.10;
        Mon, 31 May 2021 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVDN3/XdMNVZM4yku4nQG+3hbexTQxQ+++kad62qpsQ=;
        b=YOFtBH9qlqjt8j5eXDYXwQ08SIabQqSHhEwvCZ3HsX/k4tFN1cbliJmUSlAsQe6yeG
         ZWmCr4hPYcKRaeI1SQJ6+Bprmi3q/YeFjggm0Zl/LlfgY9Z4kGgrSYcLNfN95KLXd6mD
         d8Tvj0IB4UEolntz9FmB6SEduV8fdt1MRYU3vhFJf++/dB7C/C53W9ULHu/Zcr0X75dL
         TECHUDKw7D4raBOWiUk5X16g4d9fMePSCLwJ0CR6XE3e51aqUJ/IpRCsoFofox/X+msR
         dh4cnIuUh39x4kjhQ7z2XcznDGErcP9bWHcqQiL/J/OXxzhwqV+MilaBJYVcWrsJWzgi
         UQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVDN3/XdMNVZM4yku4nQG+3hbexTQxQ+++kad62qpsQ=;
        b=kpEZhpUJUoK9XKlNrjIfpJD7TbZn1D2gCyVzZasSbmHe2yyPNPVihaR/QQP9y6VFob
         oJclY84kn6dMUbI1A1E/Ij1t4s58gzq5AB/7ruxLYCRkZdBlcMurTDfKxQpNm9IivYT5
         QjuKY54/J06kY0H9YA3P6L4WNRfaLLMEfvfyxIicT1kFle7X712n49CXevt7DW7xapPJ
         AsJ9Vmpvv8DlRj/XwjnNU6hc2cM5e3sWE++izo2FejgyAUYwiayy0mM7W3IdcnPe/kaS
         UwSr4BEVSPuVqosbHOqQJVq7ft4fWYlu+SjyZtTLyc6KesGSKHHO78r1Cg0OaaeZ/FWl
         tL8A==
X-Gm-Message-State: AOAM533+fJWMXragQw6+3U4yMkuX+Q1/+H4KuKqEKFBRpzdH7Am9A+C7
        V+/U0s5mYDtJ1i1PSqCZkNM=
X-Google-Smtp-Source: ABdhPJzfrbNaVptezL/a4Rfd5/6nQEQnDBgyBEhQpa7QETsxTUhgEOp12TH79gg9x3RQw8BQRqNahw==
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr17645352lfd.551.1622521278756;
        Mon, 31 May 2021 21:21:18 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id d9sm931627lfv.47.2021.05.31.21.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 21:21:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v18 1/2] drm/tegra: dc: Support memory bandwidth management
Date:   Tue,  1 Jun 2021 07:21:07 +0300
Message-Id: <20210601042108.1942-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601042108.1942-1-digetx@gmail.com>
References: <20210601042108.1942-1-digetx@gmail.com>
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
 drivers/gpu/drm/tegra/dc.c    | 348 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h    |  12 ++
 drivers/gpu/drm/tegra/drm.c   |  14 ++
 drivers/gpu/drm/tegra/plane.c | 117 ++++++++++++
 drivers/gpu/drm/tegra/plane.h |  16 ++
 6 files changed, 506 insertions(+), 2 deletions(-)

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
index 074563ca586c..7dfe3250761f 100644
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
@@ -618,9 +619,14 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	struct tegra_dc *dc = to_tegra_dc(new_plane_state->crtc);
 	int err;
 
+	plane_state->peak_memory_bandwidth = 0;
+	plane_state->avg_memory_bandwidth = 0;
+
 	/* no need for further checks if the plane is being disabled */
-	if (!new_plane_state->crtc)
+	if (!new_plane_state->crtc) {
+		plane_state->total_peak_memory_bandwidth = 0;
 		return 0;
+	}
 
 	err = tegra_plane_format(new_plane_state->fb->format->format,
 				 &plane_state->format,
@@ -808,6 +814,12 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
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
@@ -845,12 +857,18 @@ static int tegra_cursor_atomic_check(struct drm_plane *plane,
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
-	if (!new_plane_state->crtc)
+	if (!new_plane_state->crtc) {
+		plane_state->total_peak_memory_bandwidth = 0;
 		return 0;
+	}
 
 	/* scaling not supported for cursor */
 	if ((new_plane_state->src_w >> 16 != new_plane_state->crtc_w) ||
@@ -1035,6 +1053,12 @@ static struct drm_plane *tegra_dc_cursor_plane_create(struct drm_device *drm,
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
 				       num_formats, linear_modifiers,
@@ -1149,6 +1173,12 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
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
@@ -1804,6 +1834,106 @@ static int tegra_dc_wait_idle(struct tegra_dc *dc, unsigned long timeout)
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
+		new_peak_bw = new_tegra_state->total_peak_memory_bandwidth;
+		old_peak_bw = old_tegra_state->total_peak_memory_bandwidth;
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
@@ -1985,6 +2115,8 @@ static void tegra_crtc_atomic_begin(struct drm_crtc *crtc,
 {
 	unsigned long flags;
 
+	tegra_crtc_update_memory_bandwidth(crtc, state, true);
+
 	if (crtc->state->event) {
 		spin_lock_irqsave(&crtc->dev->event_lock, flags);
 
@@ -2017,7 +2149,207 @@ static void tegra_crtc_atomic_flush(struct drm_crtc *crtc,
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
+static int tegra_crtc_calculate_memory_bandwidth(struct drm_crtc *crtc,
+						 struct drm_atomic_state *state)
+{
+	ulong overlap_mask[TEGRA_DC_LEGACY_PLANES_NUM] = {}, mask;
+	u32 plane_peak_bw[TEGRA_DC_LEGACY_PLANES_NUM] = {};
+	bool all_planes_overlap_simultaneously = true;
+	const struct tegra_plane_state *tegra_state;
+	const struct drm_plane_state *plane_state;
+	struct tegra_dc *dc = to_tegra_dc(crtc);
+	const struct drm_crtc_state *old_state;
+	struct drm_crtc_state *new_state;
+	struct tegra_plane *tegra;
+	struct drm_plane *plane;
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
+	old_state = drm_atomic_get_old_crtc_state(state, crtc);
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
+	 * in order to set up latency allowance based on the peak BW, see
+	 * tegra_crtc_update_memory_bandwidth().
+	 */
+	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, new_state) {
+		u32 i, old_peak_bw, new_peak_bw, overlap_bw = 0;
+
+		/*
+		 * Note that plane's atomic check doesn't touch the
+		 * total_peak_memory_bandwidth of enabled plane, hence the
+		 * current state contains the old bandwidth state from the
+		 * previous CRTC commit.
+		 */
+		tegra_state = to_const_tegra_plane_state(plane_state);
+		tegra = to_tegra_plane(plane);
+
+		for_each_set_bit(i, &overlap_mask[tegra->index], 3) {
+			if (i == tegra->index)
+				continue;
+
+			if (all_planes_overlap_simultaneously)
+				overlap_bw += plane_peak_bw[i];
+			else
+				overlap_bw = max(overlap_bw, plane_peak_bw[i]);
+		}
+
+		new_peak_bw = plane_peak_bw[tegra->index] + overlap_bw;
+		old_peak_bw = tegra_state->total_peak_memory_bandwidth;
+
+		/*
+		 * If plane's peak bandwidth changed (for example plane isn't
+		 * overlapped anymore) and plane isn't in the atomic state,
+		 * then add plane to the state in order to have the bandwidth
+		 * updated.
+		 */
+		if (old_peak_bw != new_peak_bw) {
+			struct tegra_plane_state *new_tegra_state;
+			struct drm_plane_state *new_plane_state;
+
+			new_plane_state = drm_atomic_get_plane_state(state, plane);
+			if (IS_ERR(new_plane_state))
+				return PTR_ERR(new_plane_state);
+
+			new_tegra_state = to_tegra_plane_state(new_plane_state);
+			new_tegra_state->total_peak_memory_bandwidth = new_peak_bw;
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
@@ -2343,7 +2675,9 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.overlay_formats = tegra20_overlay_formats,
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = true,
+	.has_win_b_vfilter_mem_client = true,
 	.has_win_c_without_vert_filter = true,
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -2363,7 +2697,9 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.overlay_formats = tegra20_overlay_formats,
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = false,
+	.has_win_b_vfilter_mem_client = true,
 	.has_win_c_without_vert_filter = false,
+	.plane_tiled_memory_bandwidth_x2 = true,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -2383,7 +2719,9 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.overlay_formats = tegra114_overlay_formats,
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = false,
+	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_tiled_memory_bandwidth_x2 = true,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -2403,7 +2741,9 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.overlay_formats = tegra124_overlay_formats,
 	.modifiers = tegra124_modifiers,
 	.has_win_a_without_filters = false,
+	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
@@ -2423,7 +2763,9 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.overlay_formats = tegra114_overlay_formats,
 	.modifiers = tegra124_modifiers,
 	.has_win_a_without_filters = false,
+	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct tegra_windowgroup_soc tegra186_dc_wgrps[] = {
@@ -2473,6 +2815,7 @@ static const struct tegra_dc_soc_info tegra186_dc_soc_info = {
 	.has_nvdisplay = true,
 	.wgrps = tegra186_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra186_dc_wgrps),
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct tegra_windowgroup_soc tegra194_dc_wgrps[] = {
@@ -2522,6 +2865,7 @@ static const struct tegra_dc_soc_info tegra194_dc_soc_info = {
 	.has_nvdisplay = true,
 	.wgrps = tegra194_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra194_dc_wgrps),
+	.plane_tiled_memory_bandwidth_x2 = false,
 };
 
 static const struct of_device_id tegra_dc_of_match[] = {
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 29f19c3c6149..581263c7614a 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -15,6 +15,8 @@
 
 struct tegra_output;
 
+#define TEGRA_DC_LEGACY_PLANES_NUM	7
+
 struct tegra_dc_state {
 	struct drm_crtc_state base;
 
@@ -33,6 +35,12 @@ static inline struct tegra_dc_state *to_dc_state(struct drm_crtc_state *state)
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
@@ -66,7 +74,9 @@ struct tegra_dc_soc_info {
 	unsigned int num_overlay_formats;
 	const u64 *modifiers;
 	bool has_win_a_without_filters;
+	bool has_win_b_vfilter_mem_client;
 	bool has_win_c_without_vert_filter;
+	bool plane_tiled_memory_bandwidth_x2;
 };
 
 struct tegra_dc {
@@ -152,6 +162,8 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
 			       struct drm_crtc_state *crtc_state,
 			       struct clk *clk, unsigned long pclk,
 			       unsigned int div);
+void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state);
 
 /* from rgb.c */
 int tegra_dc_rgb_probe(struct tegra_dc *dc);
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index c850991241e8..ca1f66fd8d63 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -25,6 +25,7 @@
 #include <asm/dma-iommu.h>
 #endif
 
+#include "dc.h"
 #include "drm.h"
 #include "gem.h"
 
@@ -64,6 +65,17 @@ static const struct drm_mode_config_funcs tegra_drm_mode_config_funcs = {
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
@@ -83,6 +95,8 @@ static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
 	} else {
 		drm_atomic_helper_commit_tail_rpm(old_state);
 	}
+
+	tegra_atomic_post_commit(drm, old_state);
 }
 
 static const struct drm_mode_config_helper_funcs
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 2e11b4b1f702..ad6f5fbec00c 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/iommu.h>
+#include <linux/interconnect.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -64,6 +65,9 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	copy->reflect_x = state->reflect_x;
 	copy->reflect_y = state->reflect_y;
 	copy->opaque = state->opaque;
+	copy->total_peak_memory_bandwidth = state->total_peak_memory_bandwidth;
+	copy->peak_memory_bandwidth = state->peak_memory_bandwidth;
+	copy->avg_memory_bandwidth = state->avg_memory_bandwidth;
 
 	for (i = 0; i < 2; i++)
 		copy->blending[i] = state->blending[i];
@@ -244,6 +248,78 @@ void tegra_plane_cleanup_fb(struct drm_plane *plane,
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
@@ -262,6 +338,10 @@ int tegra_plane_state_add(struct tegra_plane *plane,
 	if (err < 0)
 		return err;
 
+	err = tegra_plane_calculate_memory_bandwidth(state);
+	if (err < 0)
+		return err;
+
 	tegra = to_dc_state(crtc_state);
 
 	tegra->planes |= WIN_A_ACT_REQ << plane->index;
@@ -627,3 +707,40 @@ int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
 
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
index c691dd79b27b..31ff7721e9a9 100644
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
@@ -52,6 +56,11 @@ struct tegra_plane_state {
 	/* used for legacy blending support only */
 	struct tegra_plane_legacy_blending_state blending[2];
 	bool opaque;
+
+	/* bandwidths are in ICC units, i.e. kbytes/sec */
+	u32 total_peak_memory_bandwidth;
+	u32 peak_memory_bandwidth;
+	u32 avg_memory_bandwidth;
 };
 
 static inline struct tegra_plane_state *
@@ -63,6 +72,12 @@ to_tegra_plane_state(struct drm_plane_state *state)
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
@@ -77,5 +92,6 @@ int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
 bool tegra_plane_format_is_yuv(unsigned int format, bool *planar);
 int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
 				   struct tegra_plane_state *state);
+int tegra_plane_interconnect_init(struct tegra_plane *plane);
 
 #endif /* TEGRA_PLANE_H */
-- 
2.30.2

