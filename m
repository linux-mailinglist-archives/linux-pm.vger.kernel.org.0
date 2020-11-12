Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25C12B0756
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 15:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgKLOLV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 09:11:21 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55000 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgKLOLS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 09:11:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201112141104euoutp01b7e9af1cb5c30160e970fb5c8223a83d~GyAqM0HMi1450314503euoutp01E
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 14:11:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201112141104euoutp01b7e9af1cb5c30160e970fb5c8223a83d~GyAqM0HMi1450314503euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605190264;
        bh=z4JUTeobWI7rzPyDZAkdJgoWhMqzwKoLxg3F51G+v3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdZ32xryOVIcEXiPOIOV1pUX3J4lTl4ZfIV7rTUNqPbCWipYfLbHdDXkgjchrzma5
         PlsKifBugrItATisdEdqn8eNZ7ZKjTq0GtmAABRnMMZuWld8L6lie5wLqlxwO5867n
         G6Q3C5B59eWwjCQ7o2FTVzU98FSGOh13buZICB6E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201112141056eucas1p1202ef75341f398d7da3df75b4802441e~GyAiGBz672319123191eucas1p11;
        Thu, 12 Nov 2020 14:10:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 00.C9.44805.F624DAF5; Thu, 12
        Nov 2020 14:10:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201112141055eucas1p10bb68467fbb8c481b1275433f5f5f467~GyAhpP6402134621346eucas1p1x;
        Thu, 12 Nov 2020 14:10:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201112141055eusmtrp1092c57ac19bc5475fd4d52639f4074da~GyAhocMCc1178311783eusmtrp1G;
        Thu, 12 Nov 2020 14:10:55 +0000 (GMT)
X-AuditID: cbfec7f4-b37ff7000000af05-71-5fad426ff678
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3D.0F.16282.F624DAF5; Thu, 12
        Nov 2020 14:10:55 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201112141054eusmtip281ef57b5904537952b6019311d571aac~GyAg4LImV0118501185eusmtip2O;
        Thu, 12 Nov 2020 14:10:54 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        inki.dae@samsung.com
Cc:     krzk@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v9 5/5] drm: exynos: mixer: Add interconnect support
Date:   Thu, 12 Nov 2020 15:09:31 +0100
Message-Id: <20201112140931.31139-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112140931.31139-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87oFTmvjDY4+ZrS4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABbFJdNSmpOZllqkb5dAlfGtOOLmQt2eFYc/fKVrYHxsnUXIyeHhICJxL9XLSxdjFwc
        QgIrGCXmHF/BDuF8YZQ4/O4UK4TzmVHi/MbFjDAth6//gEosZ5T48+glI1zLkalPwKrYBAwl
        eo/2AdkcHCICnhInG/RBapgFmpklGpo3gdUIC7hIfDzwgw3EZhFQlfj9sJkNpJ5XwFqi43kN
        xDJ5idUbDjCD2JwCNhJzn7aClfMKCEqcnPmEBcRmBqpp3jqbGWS+hMB8TomJN+awQDS7SNze
        tRfKFpZ4dXwLO4QtI3F6cg8LREMzo0TP7tvsEM4ERon7xxdA/WktcefcL7CLmAU0Jdbv0ocI
        O0p0Ll7BChKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCqVSR+r5rOBGFLSXQ/+Q91jofE76kb
        mScwKs5C8s4sJO/MQti7gJF5FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmBiO/3v+Jcd
        jMtffdQ7xMjEwXiIUYKDWUmEV9lhTbwQb0piZVVqUX58UWlOavEhRmkOFiVx3qQtQCmB9MSS
        1OzU1ILUIpgsEwenVANT2YYSmwWb9T4knnqU0m4g/MOt9M5Pq1XvI+onNU25s8Vl5ox77y8I
        LtN2lhcr5/US+7S3RvtRof+Jb/kfCz/ln638cHRNweECq5c/G2x3nHrEeGHu2wcnrN5290zL
        K9Oyktwu4vvtWNt5r59PF109L7ZkrununV5Pr1tO04n7PqNwW5tGz4L0x7tNFuwJsFeZPEF5
        nx33kgPRO964Z260PCa+OrJqQVo7u+tD1wSZGQu8mV6KnVx5ZYrqjxUdhtOXXFzvlar+P1yE
        v/kGS6jou2NCxjFfixQyEqzjXttYnQzYpMe8RnEuY/GEY3fF387X3iP7p3tB7poYw1nXxRfG
        X3hwxmXKFf28X2F+qRclQpRYijMSDbWYi4oTAaXRE2XbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7r5TmvjDXatV7S4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7GtOOLmQt2eFYc/fKVrYHxsnUXIyeHhICJxOHrP1i7GLk4hASWMkps/3KZuYuRAyghJTG/
        RQmiRljiz7UuNhBbSOATo8S2Vi8Qm03AUKL3aB8jiC0i4Cux+uQkFpA5zAKTmSUe3W4BaxAW
        cJH4eOAHmM0ioCrx+2EzG8h8XgFriY7nNRDz5SVWbzjADGJzCthIzH3aCrXLWmJ/dxsTiM0r
        IChxcuYTFpBWZgF1ifXzhEDCzECtzVtnM09gFJyFpGoWQtUsJFULGJlXMYqklhbnpucWG+kV
        J+YWl+al6yXn525iBEbqtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8yg5r4oV4UxIrq1KL8uOL
        SnNSiw8xmgI9M5FZSjQ5H5gq8kriDc0MTA1NzCwNTC3NjJXEeU2OADUJpCeWpGanphakFsH0
        MXFwSjUwzd017aNizR0j4eSWA+JP3wpa1ebu3H/+WvAxqT9WLdWPEzcs3B/gfmOL56fb9xNm
        pPovU4l2iY20ftp6JyRC/sXU+eLKulksPXt+STLurA8QnGLeqnODVfBh6v9XXZ+XSlmcsi/Z
        EaZ9vVcwfz8j/5Lg/tvCYb+3M3aIFtY39z+zSr1wPWzbY04t33te9VKMD+p9e/8fYH7/2fWw
        4meWvyZxZhvepb6aMHNCO8PCV4dijEvW86fYzD2joVDXfzu+OOGXRJBRpQyH8Mxzbhqi5Ukq
        ddePmc2dYBH7pu3jjYL0dGuX23cPXSqZtPXbun/vHzJ4a6rlb/+8cWfrqqlzJqjv9IgWW3WA
        WXeiKdcXJZbijERDLeai4kQAmJo2HF0DAAA=
X-CMS-MailID: 20201112141055eucas1p10bb68467fbb8c481b1275433f5f5f467
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201112141055eucas1p10bb68467fbb8c481b1275433f5f5f467
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201112141055eucas1p10bb68467fbb8c481b1275433f5f5f467
References: <20201112140931.31139-1-s.nawrocki@samsung.com>
        <CGME20201112141055eucas1p10bb68467fbb8c481b1275433f5f5f467@eucas1p1.samsung.com>
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
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Co-developed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v9:
 - whitespace cleanup,
 - Co-developed-by/Signed-off-by tags corrections.

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
index af192e5..502ce04 100644
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
+	struct mutex		icc_lock;
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

