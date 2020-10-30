Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01AA2A05F2
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJ3Mxj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:53:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60858 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgJ3Mx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:53:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201030125314euoutp025f2ac059181e3e7dd14abe3c9f0be06f~Cxj-LUwdL0305903059euoutp02V
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 12:53:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201030125314euoutp025f2ac059181e3e7dd14abe3c9f0be06f~Cxj-LUwdL0305903059euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604062394;
        bh=HZT3oQChGjK7jV/NiiSLDLwYfRFhbsQd3S14l3n1wX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEXmCbI20DGIAgAiKmcNRGun9aq+5zh/wlJknUe1qqTppIBksr/pLV4tj2OYAIxSM
         IxTU+j3hU3wbwJnDNst4ttKNSI/NniFOq1+eN53su2KoHCqyPKNvTiVOUkz5MTl96J
         f9u5XUFsVEGLqbbt5cajwOJFOWTSl5uoANnSIRfU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201030125309eucas1p29918a0a6aa914f01d6a6e297cb9c9fa1~Cxj6N7qfC1111211112eucas1p2c;
        Fri, 30 Oct 2020 12:53:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.12.06318.5BC0C9F5; Fri, 30
        Oct 2020 12:53:09 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e~Cxj5psvDc1804418044eucas1p1R;
        Fri, 30 Oct 2020 12:53:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201030125308eusmtrp143ef45c038f682b561b0ea7070d9569c~Cxj5o_enC0319303193eusmtrp1G;
        Fri, 30 Oct 2020 12:53:08 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-ea-5f9c0cb587b6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 87.57.06017.4BC0C9F5; Fri, 30
        Oct 2020 12:53:08 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125307eusmtip2765b832a309bff135edf3b1d0790c9c2~Cxj49WQwv1609116091eusmtip2K;
        Fri, 30 Oct 2020 12:53:07 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        s.nawrocki@samsung.com
Subject: [PATCH v7 6/6] drm: exynos: mixer: Add interconnect support
Date:   Fri, 30 Oct 2020 13:51:49 +0100
Message-Id: <20201030125149.8227-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030125149.8227-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa2yLYRT2fvfOKt+q4qhFaeYHwchE3rgsyEgT4hYRJLSlX2ax1tJuZiIy
        qdnWbVL8aM0ylxnTkl3iMqMzU+sobcRdRwWLzCUubYVhtPu2bP+e85zneZ9zTl6OlN2jFVyW
        MVcwGXXZKiaButzxKzD9UmKVZuarqxIcqi5CuNFRT+Onkfc0Pu7x0/hR9AuD7e4mBh8O2Sgc
        CDSw+GFLFYPDFR6EHYFWAl/wvGRxcF8dg4vcHhbf+lRMY8eRHmYhr25yljLqrifXGXWozEuo
        D150InW4acIqemPCfL2QnbVTMKWmaxO2HfrkQjkfl+wKntQUolvYiiQc8LOhufMcY0UJnIyv
        Q+BptdNiEUEQDv4gxCKM4E3kOzVoORl4jsTGWQSFJR1Dlsf1ESKuYvhZUHH7IIpjOZ8BB7qr
        +90k/4YAy3EyjkfH+EflNf08xU+GM7anbBxL+bnQ57mHxDQluBra+vUSfh5YS58RoiYJ7hx9
        N/CmEiyXjpHxIYDvYeGPs4UWzRnQ/dDCiHg0fPBeZEWcDL4j5ZRosCAovxZkxcKGIOQ9MRA9
        D7r8vTE3F4uYAvUtqSK9CG6cbmPjNPCj4NnnJHGIUXD4sp0UaSmUHJCJ6hT47bQTIlZA2bt/
        A1dUw+3Gn7QNTaoctk7lsHUqh3JPINKJxgp5ZkOmYE4zCvkzzDqDOc+YOWPrDkMTiv0xX583
        2oxa/2xpRzyHVInShcpjGhmt22kuMLQj4EiVXLr4vm+zTKrXFewWTDs0prxswdyOxnOUaqw0
        7VTPJhmfqcsVtgtCjmAa7BKcRFGINrjXZ+kdrqMbVioejEi5k5vvvvn16+rUtSO1HmvxnFfL
        a2pfT6XWvF+W8mLdsimJts2OJ30VH3u1Yb9iTO9+/tyD133RBfmBHNfzKr9SXjTxSvOvC9/4
        2nEd6zvr9rZJ2go6Ofn5v8kr7nbO7zrT8NYdSf8+bbrfp0/rXqrFe7ZH01WUeZtu1lTSZNb9
        B8YNN9ZfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7pbeObEG5xuUbG4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbXN41h83ic+8RRosZ5/cxWaw9cpfd
        4nbjCjaL1r1H2C0Ov2lntZgx+SWbg4DHplWdbB53ru1h87jffZzJo2/LKkaPz5vkAlij9GyK
        8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DImvlnNWPDa
        teL2wvgGxsMWXYycHBICJhILz99k7GLk4hASWMoo8e/2bZYuRg6ghJTE/BYliBphiT/XuthA
        bCGBT4wS09emg9hsAoYSvUf7GEFsEQEPiVOta1lB5jALfGCSWPugFywhLOAicaVnMQuIzSKg
        KrFswnV2EJtXwEri35EzjBAL5CVWbzjADGJzClhLdHXeYAK5QQio5u2BKohyQYmTM5+AncYs
        oC6xfp4QSJgZqLN562zmCYyCs5BUzUKomoWkagEj8ypGkdTS4tz03GIjveLE3OLSvHS95Pzc
        TYzAqNx27OeWHYxd74IPMQpwMCrx8DrIz44XYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpR
        fnxRaU5q8SFGU6DPJjJLiSbnAxNGXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC
        1CKYPiYOTqkGRofJ2uuOlyq/9s3e6BtQ6V3cYRL0Y3V8nQhzqM6bJS+KasqulIZvO16gYcLd
        0hFmuDZ3Sor+8YjwFRbrfTK7mDL1v/8Wmbplvel0e8aTvPMNHjFw7t5d1t3TYmgcra1w5NZn
        ngi7T0aqFyZWlcrPTxPaXvVqsdycD4s2r4mb+i+OUfz2e6b7SizFGYmGWsxFxYkA6kFqOOAC
        AAA=
X-CMS-MailID: 20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds interconnect support to exynos-mixer. The mixer works
the same as before when CONFIG_INTERCONNECT is 'n'.

For proper operation of the video mixer block we need to ensure the
interconnect busses like DMC or LEFTBUS provide enough bandwidth so
as to avoid DMA buffer underruns in the mixer block. I.e we need to
prevent those busses from operating in low perfomance OPPs when
the mixer is running.
In this patch the bus bandwidth request is done through the interconnect
API, the bandwidth value is calculated from selected DRM mode, i.e.
video plane width, height, refresh rate and pixel format.

The bandwidth setting is synchronized with VSYNC when we are switching
to lower bandwidth. This is required to ensure enough bandwidth for
the device since new settings are normally being applied in the hardware
synchronously with VSYNC.

Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v7:
 - fixed incorrect setting of the ICC bandwidth when the mixer is
   disabled, now the bandwidth is set explicitly to 0 in such case.

Changes for v6:
 - the icc_set_bw() call is now only done when calculated value for
   a crtc changes, this avoids unnecessary calls per each video frame
 - added synchronization of the interconnect bandwidth setting with
   the mixer VSYNC in order to avoid buffer underflow when we lower
   the interconnect bandwidth when the hardware still operates with
   previous mode settings that require higher bandwidth. This fixed
   IOMMU faults observed e.g. during switching from two planes to
   a single plane operation.

Changes for v5:
 - renamed soc_path variable to icc_path
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 146 ++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index af192e5..61182cf 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -13,6 +13,7 @@
 #include <linux/component.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -73,6 +74,7 @@ enum mixer_flag_bits {
 	MXR_BIT_INTERLACE,
 	MXR_BIT_VP_ENABLED,
 	MXR_BIT_HAS_SCLK,
+	MXR_BIT_REQUEST_BW,
 };
 
 static const uint32_t mixer_formats[] = {
@@ -99,6 +101,13 @@ struct mixer_context {
 	struct exynos_drm_plane	planes[MIXER_WIN_NR];
 	unsigned long		flags;
 
+	struct icc_path		*icc_path;
+	/* memory bandwidth on the interconnect bus in B/s */
+	unsigned long		icc_bandwidth;
+	/* mutex protecting @icc_bandwidth */
+	struct mutex 		icc_lock;
+	struct work_struct	work;
+
 	int			irq;
 	void __iomem		*mixer_regs;
 	void __iomem		*vp_regs;
@@ -754,6 +763,9 @@ static irqreturn_t mixer_irq_handler(int irq, void *arg)
 		val |= MXR_INT_CLEAR_VSYNC;
 		val &= ~MXR_INT_STATUS_VSYNC;
 
+		if (test_and_clear_bit(MXR_BIT_REQUEST_BW, &ctx->flags))
+			schedule_work(&ctx->work);
+
 		/* interlace scan need to check shadow register */
 		if (test_bit(MXR_BIT_INTERLACE, &ctx->flags)
 		    && !mixer_is_synced(ctx))
@@ -934,6 +946,76 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
 	mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
 }
 
+/**
+ * mixer_get_memory_bandwidth - calculate memory bandwidth for current crtc mode
+ * @crtc: a crtc with DRM mode to calculate the bandwidth for
+ *
+ * Return: memory bandwidth in B/s
+ *
+ * This function returns memory bandwidth calculated as a sum of amount of data
+ * per second for each plane. The calculation is based on maximum possible pixel
+ * resolution for a plane so as to avoid different bandwidth request per each
+ * video frame. The formula used for calculation for each plane is:
+ *
+ * bw = width * height * frame_rate / interlace / (hor_subs * vert_subs)
+ *
+ * where:
+ *  - width, height - (DRM mode) video frame width and height in pixels,
+ *  - frame_rate - DRM mode frame refresh rate,
+ *  - interlace: 1 - in case of progressive and 2 in case of interlaced video,
+ *  - hor_subs, vert_subs - accordingly horizontal and vertical pixel
+ *    subsampling for a plane.
+ */
+static unsigned int mixer_get_memory_bandwidth(struct exynos_drm_crtc *crtc)
+{
+	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
+	struct mixer_context *ctx = crtc->ctx;
+	unsigned long bw, bandwidth = 0;
+	int i, j, sub;
+
+	for (i = 0; i < MIXER_WIN_NR; i++) {
+		struct drm_plane *plane = &ctx->planes[i].base;
+		const struct drm_format_info *format;
+
+		if (plane->state && plane->state->crtc && plane->state->fb) {
+			format = plane->state->fb->format;
+			bw = mode->hdisplay * mode->vdisplay *
+							drm_mode_vrefresh(mode);
+			if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+				bw /= 2;
+			for (j = 0; j < format->num_planes; j++) {
+				sub = j ? (format->vsub * format->hsub) : 1;
+				bandwidth += format->cpp[j] * bw / sub;
+			}
+		}
+	}
+
+	return bandwidth;
+}
+
+static void mixer_set_icc_bandwidth(struct mixer_context *ctx,
+				    unsigned long bandwidth)
+{
+	u32 avg_bw, peak_bw;
+
+	/* add 20% safety margin */
+	bandwidth = bandwidth / 4 * 5;
+
+	avg_bw = peak_bw = Bps_to_icc(bandwidth);
+	icc_set_bw(ctx->icc_path, avg_bw, peak_bw);
+
+	dev_dbg(ctx->dev, "safe bandwidth %lu Bps\n", bandwidth);
+}
+
+static void mixer_icc_request_fn(struct work_struct *work)
+{
+	struct mixer_context *ctx = container_of(work, struct mixer_context,
+						 work);
+	mutex_lock(&ctx->icc_lock);
+	mixer_set_icc_bandwidth(ctx, ctx->icc_bandwidth);
+	mutex_unlock(&ctx->icc_lock);
+}
+
 static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct mixer_context *ctx = crtc->ctx;
@@ -980,12 +1062,35 @@ static void mixer_disable_plane(struct exynos_drm_crtc *crtc,
 
 static void mixer_atomic_flush(struct exynos_drm_crtc *crtc)
 {
-	struct mixer_context *mixer_ctx = crtc->ctx;
+	struct mixer_context *ctx = crtc->ctx;
+	int bw, prev_bw;
 
-	if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
+	if (!test_bit(MXR_BIT_POWERED, &ctx->flags))
 		return;
 
-	mixer_enable_sync(mixer_ctx);
+	/*
+	 * Request necessary bandwidth on the interconnects. If new
+	 * bandwidth is greater than current value set the new value
+	 * immediately. Otherwise request lower bandwidth only after
+	 * VSYNC, after the HW has actually switched to new video
+	 * frame settings.
+	 */
+	if (ctx->icc_path) {
+		bw = mixer_get_memory_bandwidth(crtc);
+
+		mutex_lock(&ctx->icc_lock);
+		prev_bw = ctx->icc_bandwidth;
+		ctx->icc_bandwidth = bw;
+
+		if (bw > prev_bw)
+			mixer_set_icc_bandwidth(ctx, bw);
+		else if (bw < prev_bw)
+			set_bit(MXR_BIT_REQUEST_BW, &ctx->flags);
+
+		mutex_unlock(&ctx->icc_lock);
+	}
+
+	mixer_enable_sync(ctx);
 	exynos_crtc_handle_event(crtc);
 }
 
@@ -1036,6 +1141,8 @@ static void mixer_atomic_disable(struct exynos_drm_crtc *crtc)
 
 	pm_runtime_put(ctx->dev);
 
+	mixer_set_icc_bandwidth(ctx, 0);
+
 	clear_bit(MXR_BIT_POWERED, &ctx->flags);
 }
 
@@ -1223,19 +1330,33 @@ static int mixer_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct mixer_drv_data *drv;
 	struct mixer_context *ctx;
+	struct icc_path *path;
 	int ret;
 
+	/*
+	 * Returns NULL if CONFIG_INTERCONNECT is disabled.
+	 * May return ERR_PTR(-EPROBE_DEFER).
+	 */
+	path = of_icc_get(dev, NULL);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
 		DRM_DEV_ERROR(dev, "failed to alloc mixer context.\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 
 	drv = of_device_get_match_data(dev);
 
+	INIT_WORK(&ctx->work, mixer_icc_request_fn);
+	mutex_init(&ctx->icc_lock);
+
 	ctx->pdev = pdev;
 	ctx->dev = dev;
 	ctx->mxr_ver = drv->version;
+	ctx->icc_path = path;
 
 	if (drv->is_vp_enabled)
 		__set_bit(MXR_BIT_VP_ENABLED, &ctx->flags);
@@ -1247,17 +1368,26 @@ static int mixer_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	ret = component_add(&pdev->dev, &mixer_component_ops);
-	if (ret)
+	if (ret) {
 		pm_runtime_disable(dev);
-
+		goto err;
+	}
+	return 0;
+err:
+	icc_put(path);
 	return ret;
 }
 
 static int mixer_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct mixer_context *ctx = dev_get_drvdata(dev);
+
+	pm_runtime_disable(dev);
+
+	component_del(dev, &mixer_component_ops);
 
-	component_del(&pdev->dev, &mixer_component_ops);
+	icc_put(ctx->icc_path);
 
 	return 0;
 }
-- 
2.7.4

