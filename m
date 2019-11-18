Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5585C100C92
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKRUGC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44391 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfKRUGB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:06:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so20410755ljl.11;
        Mon, 18 Nov 2019 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuz1BcEYsck8xXvuAx6no465QzG7OGwvJ3sC9jHo7/Y=;
        b=uh1visuScvodNh0T8pHBqf2GB2+HNTFTQhIPhDeLDok+7qBEvrWAAtnI/A1CAaLpl9
         5FFdbEfyBubZFVgpmhJmFAtN5ZLyl1/jLAplsfXd3TxVyvwtrkbZ7aOl5iOKk70S1qZH
         L6t8faaBy+8iBwgHyQ+JXhs0q5PH+1qU9sA3dk4IP1yhF2pPxv7UMkdqprSh2TH+eFED
         EAwMXoziIq6fPfpJfJBvoDA5Xa3JQFdS6/ZfBjYf3mAwz73qHRIs5DtxNfo1Ippb5ZEZ
         qKOD1urA2W0hEjrH6kgemlQLkm1z50WScTg4p49NVoNUfZ7Lx1UbdOLTCy1/N3lgzPvM
         770A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuz1BcEYsck8xXvuAx6no465QzG7OGwvJ3sC9jHo7/Y=;
        b=NBP/KPFjcOwEQdlNntcZ0ClqtVUl0StxNnSZDi8sVFgKAmURKzpAhG3f6tf0BF3kl0
         zOEVjf4ltyhWFdl6X1GeY8vyvbKr2eGanGwzO29vNhQhgsQD3zOJX8HgkCIb58GHrU1I
         9tga6iWxNCrvn0PnV78kNcDee7wJ2QUxZbVP+az2vFQOmYvWsJZMY2VgyZynLp9P6kiJ
         cBMgi7zRaskKQNQ2XkML9slhKxZTYw5W/58S6yk/ZD2bxPLFV1TDPS9X9+BV+mZYXTga
         ZDfbTWbX4YM3pnbhcqQgh+h0kgqYpsepIcYvyey1mfgTHJmTNeo4Oh70WFWm3LAHcKZJ
         aPVg==
X-Gm-Message-State: APjAAAU77xxtZPignZsYKMvH5zhO0nw2T9iAlKYpqtnGGa0JLkLTTphk
        eNZstnPAnI3GGYUD2CM7k8M=
X-Google-Smtp-Source: APXvYqyhYhJ7ztyMovZ1MiQtwkAscCbe0gkfGOrZ6XqzJMvebaMVZfQSkKVE5yVPpf0nfopJV71yWw==
X-Received: by 2002:a2e:9256:: with SMTP id v22mr898223ljg.124.1574107556687;
        Mon, 18 Nov 2019 12:05:56 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 26/29] drm/tegra: dc: Support memory bandwidth management
Date:   Mon, 18 Nov 2019 23:02:44 +0300
Message-Id: <20191118200247.3567-27-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Display controller (DC) performs isochronous memory transfers and thus
has a requirement for a minimum memory bandwidth that shall be fulfilled,
otherwise framebuffer data can't be fetched fast enough and this results
in a DC's data-FIFO underflow that follows by a visual corruption.

The External Memory Controller drivers provide facility for memory
bandwidth management via interconnect API. This patch wires up the
interconnect API support to the DC driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    | 240 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h    |   8 ++
 drivers/gpu/drm/tegra/drm.c   |  18 +++
 drivers/gpu/drm/tegra/plane.c |   1 +
 drivers/gpu/drm/tegra/plane.h |   4 +-
 5 files changed, 269 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index c2c61156cdcf..c60a0c00d95f 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -519,6 +519,122 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 		tegra_plane_setup_blending(plane, window);
 }
 
+static unsigned long
+tegra_plane_memory_bandwidth(struct drm_plane_state *state,
+			     struct tegra_dc_window *window)
+{
+	struct tegra_plane_state *tegra_state;
+	struct drm_crtc_state *crtc_state;
+	const struct drm_format_info *fmt;
+	struct tegra_dc_window win;
+	unsigned int bpp_plane;
+	unsigned int bpp;
+	unsigned int mul;
+	unsigned int i;
+
+	if (!state->fb || !state->visible)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state->state, state->crtc);
+	tegra_state = to_tegra_plane_state(state);
+
+	if (!window)
+		window = &win;
+
+	window->src.w = drm_rect_width(&state->src) >> 16;
+	window->src.h = drm_rect_height(&state->src) >> 16;
+	window->dst.w = drm_rect_width(&state->dst);
+	window->dst.h = drm_rect_height(&state->dst);
+	window->tiling = tegra_state->tiling;
+
+	fmt = state->fb->format;
+
+	/*
+	 * Note that real memory bandwidth vary depending on format and
+	 * memory layout, we are not taking that into account because small
+	 * estimation error isn't important since bandwidth is rounded up
+	 * anyway.
+	 */
+	for (i = 0, bpp = 0; i < fmt->num_planes; i++) {
+		bpp_plane = fmt->cpp[i] * 8;
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
+	/*
+	 * Horizontal downscale takes extra bandwidth which roughly depends
+	 * on the scaled width.
+	 */
+	if (window->src.w > window->dst.w)
+		mul = (window->src.w - window->dst.w) * bpp / 2048 + 1;
+	else
+		mul = 1;
+
+	/*
+	 * Ignore window if its width is small enough such that data-prefetch
+	 * FIFO will easily help to overcome temporal memory pressure. This is
+	 * a typical case for the cursor's plane.
+	 */
+	if (mul == 1 && window->src.w * bpp <= 2048)
+		return 0;
+
+	/* mode.clock in kHz, bandwidth in kbit/s */
+	return kbps_to_icc(crtc_state->mode.clock * bpp * mul);
+}
+
+static unsigned long
+tegra20_plane_memory_bandwidth(struct drm_plane_state *state)
+{
+	/* ~35% efficiency */
+	return tegra_plane_memory_bandwidth(state, NULL) * 29 / 10;
+}
+
+static unsigned long
+tegra30_plane_memory_bandwidth(struct drm_plane_state *state)
+{
+	struct tegra_dc_window window;
+	unsigned long bandwidth;
+
+	bandwidth = tegra_plane_memory_bandwidth(state, &window);
+
+	/* x2: memory overfetch for tiled framebuffer and DDR3 */
+	if (window.tiling.mode == TEGRA_BO_TILING_MODE_TILED)
+		bandwidth *= 2;
+
+	/* ~35% efficiency */
+	return bandwidth * 29 / 10;
+}
+
+static unsigned long
+tegra114_plane_memory_bandwidth(struct drm_plane_state *state)
+{
+	struct tegra_dc_window window;
+	unsigned long bandwidth;
+
+	bandwidth = tegra_plane_memory_bandwidth(state, &window);
+
+	/* x2: memory overfetch for tiled framebuffer and DDR3 */
+	if (window.tiling.mode == TEGRA_BO_TILING_MODE_TILED)
+		bandwidth *= 2;
+
+	return bandwidth;
+}
+
+static unsigned long
+tegra124_plane_memory_bandwidth(struct drm_plane_state *state)
+{
+	/* 64bit memory bus */
+	return tegra_plane_memory_bandwidth(state, NULL);
+}
+
 static const u32 tegra20_primary_formats[] = {
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_ARGB1555,
@@ -608,8 +724,10 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	int err;
 
 	/* no need for further checks if the plane is being disabled */
-	if (!state->crtc)
+	if (!state->crtc) {
+		plane_state->memory_bandwidth = 0;
 		return 0;
+	}
 
 	err = tegra_plane_format(state->fb->format->format,
 				 &plane_state->format,
@@ -662,6 +780,8 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	if (err < 0)
 		return err;
 
+	plane_state->memory_bandwidth = dc->soc->plane_memory_bandwidth(state);
+
 	return 0;
 }
 
@@ -1186,6 +1306,7 @@ tegra_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 	copy->pclk = state->pclk;
 	copy->div = state->div;
 	copy->planes = state->planes;
+	copy->memory_bandwidth = state->memory_bandwidth;
 
 	return &copy->base;
 }
@@ -1774,6 +1895,8 @@ static void tegra_crtc_atomic_disable(struct drm_crtc *crtc,
 	spin_unlock_irq(&crtc->dev->event_lock);
 
 	pm_runtime_put_sync(dc->dev);
+
+	icc_set_bw(dc->icc, 0, 0);
 }
 
 static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
@@ -1784,6 +1907,8 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct tegra_dc *dc = to_tegra_dc(crtc);
 	u32 value;
 
+	icc_set_bw(dc->icc, state->memory_bandwidth, state->memory_bandwidth);
+
 	pm_runtime_get_sync(dc->dev);
 
 	/* initialize display controller */
@@ -1893,6 +2018,9 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 static void tegra_crtc_atomic_begin(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_crtc_state)
 {
+	struct tegra_dc_state *dc_old_state = to_dc_state(old_crtc_state);
+	struct tegra_dc_state *dc_state = to_dc_state(crtc->state);
+	struct tegra_dc *dc = to_tegra_dc(crtc);
 	unsigned long flags;
 
 	if (crtc->state->event) {
@@ -1907,6 +2035,25 @@ static void tegra_crtc_atomic_begin(struct drm_crtc *crtc,
 
 		crtc->state->event = NULL;
 	}
+
+	if (old_crtc_state && old_crtc_state->active) {
+		/*
+		 * Raise memory bandwidth before changes take effect if it
+		 * goes from low to high.
+		 */
+		if (dc_old_state->memory_bandwidth < dc_state->memory_bandwidth)
+			icc_set_bw(dc->icc,
+				   dc_state->memory_bandwidth,
+				   dc_state->memory_bandwidth);
+	} else {
+		/*
+		 * Raise memory bandwidth before changes take effect if
+		 * CRTC is turning on.
+		 */
+		icc_set_bw(dc->icc,
+			   dc_state->memory_bandwidth,
+			   dc_state->memory_bandwidth);
+	}
 }
 
 static void tegra_crtc_atomic_flush(struct drm_crtc *crtc,
@@ -1925,7 +2072,79 @@ static void tegra_crtc_atomic_flush(struct drm_crtc *crtc,
 	value = tegra_dc_readl(dc, DC_CMD_STATE_CONTROL);
 }
 
+static bool
+tegra_plane_intersects_with_other_plane(struct drm_crtc_state *state,
+					const struct drm_plane_state *plane_state)
+{
+	const struct drm_plane_state *other_state;
+	struct drm_plane *plane;
+	struct drm_rect rect;
+
+	drm_atomic_crtc_state_for_each_plane_state(plane, other_state, state) {
+		rect = plane_state->dst;
+
+		if (other_state == plane_state)
+			continue;
+
+		if (!other_state->visible || !other_state->fb)
+			continue;
+
+		if (drm_rect_intersect(&rect, &other_state->dst))
+			return true;
+	}
+
+	return false;
+}
+
+static int tegra_crtc_atomic_check(struct drm_crtc *crtc,
+				   struct drm_crtc_state *state)
+{
+	struct tegra_dc_state *dc_state = to_dc_state(state);
+	const struct drm_plane_state *plane_state;
+	const struct tegra_plane_state *tegra;
+	unsigned long long bandwidth = 0;
+	struct drm_plane *plane;
+
+	/*
+	 * For overlapping planes pixel's data is fetched for each plane at
+	 * the same time, hence bandwidth is accumulated in this case.
+	 */
+	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, state) {
+		tegra = to_tegra_plane_state(plane_state);
+
+		if (tegra_plane_intersects_with_other_plane(state, plane_state))
+			bandwidth += tegra->memory_bandwidth;
+		else
+			bandwidth = max(bandwidth, (u64)tegra->memory_bandwidth);
+	}
+
+	dc_state->memory_bandwidth = min(bandwidth, (u64)U32_MAX);
+
+	return 0;
+}
+
+void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
+				   struct drm_crtc_state *old_crtc_state)
+{
+	struct tegra_dc_state *dc_old_state = to_dc_state(old_crtc_state);
+	struct tegra_dc_state *dc_state = to_dc_state(crtc->state);
+	struct tegra_dc *dc = to_tegra_dc(crtc);
+
+	if (!dc_old_state)
+		return;
+
+	/*
+	 * Drop memory bandwidth after changes take effect if it goes from
+	 * high to low.
+	 */
+	if (dc_old_state->memory_bandwidth > dc_state->memory_bandwidth)
+		icc_set_bw(dc->icc,
+			   dc_state->memory_bandwidth,
+			   dc_state->memory_bandwidth);
+}
+
 static const struct drm_crtc_helper_funcs tegra_crtc_helper_funcs = {
+	.atomic_check = tegra_crtc_atomic_check,
 	.atomic_begin = tegra_crtc_atomic_begin,
 	.atomic_flush = tegra_crtc_atomic_flush,
 	.atomic_enable = tegra_crtc_atomic_enable,
@@ -2143,6 +2362,7 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = true,
 	.has_win_c_without_vert_filter = true,
+	.plane_memory_bandwidth = tegra20_plane_memory_bandwidth,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -2162,6 +2382,7 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_memory_bandwidth = tegra30_plane_memory_bandwidth,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -2181,6 +2402,7 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_memory_bandwidth = tegra114_plane_memory_bandwidth,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -2200,6 +2422,7 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.modifiers = tegra124_modifiers,
 	.has_win_a_without_filters = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_memory_bandwidth = tegra124_plane_memory_bandwidth,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
@@ -2219,6 +2442,7 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.modifiers = tegra124_modifiers,
 	.has_win_a_without_filters = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_memory_bandwidth = tegra124_plane_memory_bandwidth,
 };
 
 static const struct tegra_windowgroup_soc tegra186_dc_wgrps[] = {
@@ -2267,6 +2491,7 @@ static const struct tegra_dc_soc_info tegra186_dc_soc_info = {
 	.has_nvdisplay = true,
 	.wgrps = tegra186_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra186_dc_wgrps),
+	.plane_memory_bandwidth = tegra124_plane_memory_bandwidth,
 };
 
 static const struct tegra_windowgroup_soc tegra194_dc_wgrps[] = {
@@ -2315,6 +2540,7 @@ static const struct tegra_dc_soc_info tegra194_dc_soc_info = {
 	.has_nvdisplay = true,
 	.wgrps = tegra194_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra194_dc_wgrps),
+	.plane_memory_bandwidth = tegra124_plane_memory_bandwidth,
 };
 
 static const struct of_device_id tegra_dc_of_match[] = {
@@ -2493,6 +2719,13 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	dc->icc = of_icc_get(dc->dev, "dma-mem");
+	err = PTR_ERR_OR_ZERO(dc->icc);
+	if (err) {
+		dev_err(dc->dev, "failed to get interconnect: %d\n", err);
+		goto remove_rgb;
+	}
+
 	platform_set_drvdata(pdev, dc);
 	pm_runtime_enable(&pdev->dev);
 
@@ -2511,6 +2744,9 @@ static int tegra_dc_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
+	icc_put(dc->icc);
+
+remove_rgb:
 	tegra_dc_rgb_remove(dc);
 
 	return err;
@@ -2528,6 +2764,8 @@ static int tegra_dc_remove(struct platform_device *pdev)
 		return err;
 	}
 
+	icc_put(dc->icc);
+
 	err = tegra_dc_rgb_remove(dc);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to remove RGB output: %d\n", err);
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 3d8ddccd758f..629b379a8207 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -8,6 +8,7 @@
 #define TEGRA_DC_H 1
 
 #include <linux/host1x.h>
+#include <linux/interconnect.h>
 
 #include <drm/drm_crtc.h>
 
@@ -23,6 +24,8 @@ struct tegra_dc_state {
 	unsigned int div;
 
 	u32 planes;
+
+	unsigned long memory_bandwidth;
 };
 
 static inline struct tegra_dc_state *to_dc_state(struct drm_crtc_state *state)
@@ -66,6 +69,7 @@ struct tegra_dc_soc_info {
 	const u64 *modifiers;
 	bool has_win_a_without_filters;
 	bool has_win_c_without_vert_filter;
+	unsigned long (*plane_memory_bandwidth)(struct drm_plane_state *state);
 };
 
 struct tegra_dc {
@@ -90,6 +94,8 @@ struct tegra_dc {
 	struct drm_info_list *debugfs_files;
 
 	const struct tegra_dc_soc_info *soc;
+
+	struct icc_path *icc;
 };
 
 static inline struct tegra_dc *
@@ -150,6 +156,8 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
 			       struct drm_crtc_state *crtc_state,
 			       struct clk *clk, unsigned long pclk,
 			       unsigned int div);
+void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
+				   struct drm_crtc_state *old_crtc_state);
 
 /* from rgb.c */
 int tegra_dc_rgb_probe(struct tegra_dc *dc);
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 56e5e7a5c108..ccce91ea7180 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -20,6 +20,7 @@
 #include <drm/drm_prime.h>
 #include <drm/drm_vblank.h>
 
+#include "dc.h"
 #include "drm.h"
 #include "gem.h"
 
@@ -59,6 +60,21 @@ static const struct drm_mode_config_funcs tegra_drm_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static void tegra_atomic_post_commit(struct drm_device *drm,
+				     struct drm_atomic_state *old_state)
+{
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
+		if (!new_crtc_state->active)
+			continue;
+
+		tegra_crtc_atomic_post_commit(crtc, old_crtc_state);
+	}
+}
+
 static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *drm = old_state->dev;
@@ -75,6 +91,8 @@ static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
 	} else {
 		drm_atomic_helper_commit_tail_rpm(old_state);
 	}
+
+	tegra_atomic_post_commit(drm, old_state);
 }
 
 static const struct drm_mode_config_helper_funcs
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 163b590be224..1f482e594dc9 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -61,6 +61,7 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	copy->swap = state->swap;
 	copy->bottom_up = state->bottom_up;
 	copy->opaque = state->opaque;
+	copy->memory_bandwidth = state->memory_bandwidth;
 
 	for (i = 0; i < 2; i++)
 		copy->blending[i] = state->blending[i];
diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
index a158a915109a..5227c7a9ad8b 100644
--- a/drivers/gpu/drm/tegra/plane.h
+++ b/drivers/gpu/drm/tegra/plane.h
@@ -51,10 +51,12 @@ struct tegra_plane_state {
 	/* used for legacy blending support only */
 	struct tegra_plane_legacy_blending_state blending[2];
 	bool opaque;
+
+	unsigned long memory_bandwidth;
 };
 
 static inline struct tegra_plane_state *
-to_tegra_plane_state(struct drm_plane_state *state)
+to_tegra_plane_state(const struct drm_plane_state *state)
 {
 	if (state)
 		return container_of(state, struct tegra_plane_state, base);
-- 
2.23.0

