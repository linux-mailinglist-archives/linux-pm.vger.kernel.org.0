Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC252A61EE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgKDKhw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:37:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47698 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbgKDKhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 05:37:48 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201104103735euoutp019972b58ac1521c0fe7081ec77531498e~ER7_rIJuc0672206722euoutp011
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 10:37:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201104103735euoutp019972b58ac1521c0fe7081ec77531498e~ER7_rIJuc0672206722euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604486255;
        bh=L+nUe8U5E5ks5/FEagAgoRj80kpW/jqICao80QN6k0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnOlOz5wvAIh5Kq29XqFesaT/v7WBYqPWnON4PRrnDwUgEsP/y1oiOxx+PWw3dNs8
         jWkiIa+toM4LYYkhJPUx5ibT+4osaHYmPwSujaEBHMeLa8xgCQgyV4h++LjsJzb0T2
         JuIiz1gVfRQvB6uMLY4oBS4EE8Rx0mPcGl5aY/rQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201104103730eucas1p1d04a432aab4d69de891146cde7c5e324~ER75uwSz91564115641eucas1p16;
        Wed,  4 Nov 2020 10:37:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.0A.06318.A6482AF5; Wed,  4
        Nov 2020 10:37:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103730eucas1p2964e5910a1319fc1c931db8f02a447de~ER75aGe1E1144911449eucas1p2v;
        Wed,  4 Nov 2020 10:37:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104103730eusmtrp146cc5014ba082336862476c9514104a2~ER75ZTVyE0613806138eusmtrp1m;
        Wed,  4 Nov 2020 10:37:30 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-a4-5fa2846adf0d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.85.06314.A6482AF5; Wed,  4
        Nov 2020 10:37:30 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103729eusmtip2cae8ed3d402fdf6b98a5eafd8e0f4d28~ER74sPJoW1361713617eusmtip2Z;
        Wed,  4 Nov 2020 10:37:29 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v8 7/7] drm: exynos: mixer: Add interconnect support
Date:   Wed,  4 Nov 2020 11:36:57 +0100
Message-Id: <20201104103657.18007-8-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104103657.18007-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djPc7pZLYviDXYdlba4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABbFJdNSmpOZllqkb5dAlfGtJ6ZTAVN7hWPZrWwNDAetOxi5OCQEDCRmHwquYuRi0NI
        YAWjxJZZB9m6GDmBnC+MEtvXSkIkPjNKtO//yQSSAGl48LedDSKxnFHi3bmjzBAOUMe2x2/Y
        QarYBAwleo/2MYLYIgIuEm1P57GAFDELdDBLbNsxiRkkIQyU6J95HWwfi4CqxMKGC6wgNq+A
        tcSJmY/YIdbJS6zecACsnlPARuLi52Z2iBpBiZMzn7CA2MxANc1bZ4NdISHwk12i8/VfqFtd
        JG61LWWBsIUlXh3fAjVURuL05B4WiIZmRome3bfZIZwJjBL3jy9ghKiylrhz7hcbKJiYBTQl
        1u/Shwg7SlxbtYIFEnp8EjfeCkIcwScxadt0Zogwr0RHmxBEtYrE71XToc6Rkuh+8h+q00Ni
        Zpv0BEbFWUi+mYXkm1kIaxcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITGun/x3/
        uoNx35+kQ4wCHIxKPLwHti2MF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEh
        RmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjK58Yod2qO3vW50c5X5LwHaComtI83nP
        N5wVWxN33PLezGfn/0/lmXKVEOPpZU7lZw2FnB4zujbdjHxYyR7WIG6QE7pbUvmqokLC7YsF
        5TGcq3XL/666Z6m0N/LH/ZTzCRdXTknnlj9w/HXmNhW5/w3zv/AvKHawu5pfk+22ItDCOy3O
        r7FViaU4I9FQi7moOBEAFRVhKGcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7pZLYviDaYeYba4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7GtJ6ZTAVN7hWPZrWwNDAetOxi5OSQEDCRePC3na2LkYtDSGApo8T5978Zuxg5gBJSEvNb
        lCBqhCX+XOtiA7GFBD4xSmzprAKx2QQMJXqP9jGC2CICHhKnWteygtjMAjOYJU7PMgWxhQVc
        JPpnXgfrZRFQlVjYcAGshlfAWuLEzEfsEPPlJVZvOMAMYnMK2Ehc/NzMDrHLWmLx83NMEPWC
        EidnPmEBOY1ZQF1i/TwhiFXyEs1bZzNPYBSchaRqFkLVLCRVCxiZVzGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgRG6rZjPzfvYLy0MfgQowAHoxIP74FtC+OFWBPLiitzDzFKcDArifA6nT0d
        J8SbklhZlVqUH19UmpNafIjRFOi1icxSosn5wCSSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
        ID2xJDU7NbUgtQimj4mDU6qBkV/vcGDugUWCcTJ7xS/EP3mjGe+wft3xI48Lv+w14nsu/fL/
        0+TfD7Z+2vN9wgElHZYVvftSb1+R49BP+qLaKDDjx+TJxT39ah8eRUhuuLw8Qb7355mqh9Pl
        Oebu+v1OqY3XrS5N6u9SoU3MhufX31N4k115dZHV6g0VJq6/db7qnj6Zv7nqVbMSS3FGoqEW
        c1FxIgCxxSkg6gIAAA==
X-CMS-MailID: 20201104103730eucas1p2964e5910a1319fc1c931db8f02a447de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104103730eucas1p2964e5910a1319fc1c931db8f02a447de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104103730eucas1p2964e5910a1319fc1c931db8f02a447de
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
        <CGME20201104103730eucas1p2964e5910a1319fc1c931db8f02a447de@eucas1p2.samsung.com>
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

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v8:
 - updated comment in mixer_probe()

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
index af192e5..8c1509e 100644
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
+	 * Returns NULL if CONFIG_INTERCONNECT is disabled or if "interconnects"
+	 * property does not exist. May return ERR_PTR(-EPROBE_DEFER).
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

