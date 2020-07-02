Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08BD2129CB
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGBQiO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 12:38:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55114 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgGBQiE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 12:38:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200702163802euoutp01f4966cb570af76f196c5656a3c256e86~d-N-7pcGF1595115951euoutp01z
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 16:38:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200702163802euoutp01f4966cb570af76f196c5656a3c256e86~d-N-7pcGF1595115951euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593707882;
        bh=Feeuv3ADxxV5/AS/i7SVntFIv2q04hag2N4d6shCwSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMPCHfAMk1qSGZoDJ0a17W12erRg3ys7UvWYElSWhV+8s0MJWd9WJpYmcxK8Qw22S
         cbEYjHUufVm8dvUksc/qQn6UpGS7txkM/z7YDo5RpvAe9n8lFGyzY3W/5yHD6I3zNx
         ari7CMI/VwEeBbQf1zh1+jxrn+4gWsSiVceZViJk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200702163801eucas1p263c969961c1793d3101da93cca535994~d-N-azbaY2216322163eucas1p21;
        Thu,  2 Jul 2020 16:38:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 20.99.05997.96D0EFE5; Thu,  2
        Jul 2020 17:38:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702163801eucas1p12db276c7ac9e244e93e4b2f3d33ba729~d-N-HuFjj0769307693eucas1p17;
        Thu,  2 Jul 2020 16:38:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702163801eusmtrp12baf4f452fcd944228d15fe0fa459688~d-N-HBNMV1333013330eusmtrp1K;
        Thu,  2 Jul 2020 16:38:01 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-c2-5efe0d695ba2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.0A.06017.96D0EFE5; Thu,  2
        Jul 2020 17:38:01 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163800eusmtip2d6bcf626c5987c5f2f1903612b6fe6e5~d-N_ZE9_S2767227672eusmtip2Z;
        Thu,  2 Jul 2020 16:38:00 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH RFC v6 6/6] drm: exynos: mixer: Add interconnect support
Date:   Thu,  2 Jul 2020 18:37:24 +0200
Message-Id: <20200702163724.2218-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702163724.2218-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SazCUYRTH59n3sku9ei2TJxplp4tqcklTTy1dzdgvzZRPaaJW3kFYZte1
        UoxsrMusNSIVkplYY7BpxyXK2mwyGMOIbGO0yijGFPuBsmW9Kt9+5zn/c/7nnHl4GH+IcOZF
        SuIZqUQcLSBtcW330sDBSMoS4mVcckUTZZkANZbUE+j94jSByvX9BBo2z5OouF1DItWEEkcD
        Aw1cpDGNEGio9RGJFvL0AJUMdHBQnf4jF42nV5Mos13PRV2z9whUUjhDnrIXadTZpMg48pIU
        TeQYOKLnVXdE+U1qIFrQuJ4nL9n6hjHRkYmM1PPEVdsI+aiajEsLSG7RqLA00HdMAWx4kD4M
        89T9uJX5dDWAveZEBbBd5UUALcYSnA0WAFRXKjAF4K1VVFVcZN+fAfjOWEf+q+j7VMC1tiJp
        b5j3Jh9Y2ZH2h/LPZWudMDoLg9pmFWZNONAiaDLNcayM07thVW0jYWWKPg6nnjQAdr4dsLbh
        9ZqzDS2EXQsUK7GHPQ+m1sbGViUZLx5i1v6QNnPhB1UPztb6Q5W+c50d4FdDE5fl7bC3MBdn
        CzIAzG0b57KBEsAJQ8W6sxAa+5dJqzNG74P1rZ7s82k49uMxyZ7CDo7O2bND2EGVtnj9QhTM
        kvNZ9S74U13MYdkZ5kz9xlmJCH6fFCqBW+mGbUo3bFP637YCYGrgxCTIYsIZ2SEJk+QhE8fI
        EiThHtdiYzRg9av1WgyLzaD1V6gO0Dwg2EwpDSshfEKcKEuJ0QHIwwSO1Jm+3hA+FSZOucFI
        Y69IE6IZmQ648HCBE+VTORPMp8PF8UwUw8Qx0r9ZDs/GOQ0cnf9WKvDKNqcPC5sKNmUuT98f
        s7hriWrFF2XQub17UvPanEZMSpeip4F3J30OhFkCfXvCsNTL7u6DJ7MkrXMd8u4VarZx66BH
        0M7bRR1yc9OW6yl9ocIjDimhLbfUgUTwYJLRLcrLr+ZtS/KFbQHlIzU6Z5Pfzc6GhKCCs7mv
        ggW4LELsvR+TysR/ADJHsF5mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7qZvP/iDD5MYbe4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl5G241VbAUN7hU7N01ibmA8a9nFyMEhIWAisWRBRBcjF4eQwFJGie2357FCxKUk5rcodTFy
        ApnCEn+udbFB1HxilPh5bCM7SIJNwFCi92gfI4gtIuAhcap1LSuIzSwwg1ni9CxTEFsYKP74
        8VsmEJtFQFViyeqNYDW8AlYSTxZuYIRYIC+xesMBZpC9nALWEoc/84KEhYBKjvUvYIcoF5Q4
        OfMJC0gJs4C6xPp5QhCb5CWat85mnsAoOAtJ1SyEqllIqhYwMq9iFEktLc5Nzy020itOzC0u
        zUvXS87P3cQIjNNtx35u2cHY9S74EKMAB6MSD++E43/jhFgTy4orcw8xSnAwK4nwOp09HSfE
        m5JYWZValB9fVJqTWnyI0RTos4nMUqLJ+cAUklcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgTFAW/TG8QulvWdjzR4Le3wOkfi3rPCV4OKrPzQW1HHcmBwz75La
        4inFQhOrzsSweWcaf8q/cXPPxJm9z/8UsPWXT+Fbk9qT5DSbT4ZLcMJK9uWzjk2oFbF7u3Si
        8aarDMZcq6Umqx4uzJ9lLH6E9cn37beUReecfe0mrXJRdScXR8iUg009Bf5KLMUZiYZazEXF
        iQCw9jSz6QIAAA==
X-CMS-MailID: 20200702163801eucas1p12db276c7ac9e244e93e4b2f3d33ba729
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163801eucas1p12db276c7ac9e244e93e4b2f3d33ba729
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163801eucas1p12db276c7ac9e244e93e4b2f3d33ba729
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163801eucas1p12db276c7ac9e244e93e4b2f3d33ba729@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
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
 drivers/gpu/drm/exynos/exynos_mixer.c | 150 ++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index c7e2e2e..f7babf8 100644
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
+	/* mutex protecting @icc_bandwidth and serializing access to @icc_path */
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
@@ -934,6 +946,78 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
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
+static void mixer_set_icc_bandwidth(struct mixer_context *ctx)
+{
+	unsigned long bandwidth;
+	u32 avg_bw, peak_bw;
+
+	mutex_lock(&ctx->icc_lock);
+
+	/* add 20% safety margin */
+	bandwidth = ctx->icc_bandwidth / 4 * 5;
+
+	avg_bw = peak_bw = Bps_to_icc(bandwidth);
+	icc_set_bw(ctx->icc_path, avg_bw, peak_bw);
+
+	mutex_unlock(&ctx->icc_lock);
+
+	dev_dbg(ctx->dev, "safe bandwidth %lu Bps\n", bandwidth);
+}
+
+static void mixer_icc_request_fn(struct work_struct *work)
+{
+	struct mixer_context *ctx = container_of(work, struct mixer_context,
+						 work);
+	mixer_set_icc_bandwidth(ctx);
+}
+
 static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct mixer_context *ctx = crtc->ctx;
@@ -980,12 +1064,34 @@ static void mixer_disable_plane(struct exynos_drm_crtc *crtc,
 
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
+		mutex_unlock(&ctx->icc_lock);
+
+		if (bw > prev_bw)
+			mixer_set_icc_bandwidth(ctx);
+		else if (bw < prev_bw)
+			set_bit(MXR_BIT_REQUEST_BW, &ctx->flags);
+	}
+
+	mixer_enable_sync(ctx);
 	exynos_crtc_handle_event(crtc);
 }
 
@@ -1036,6 +1142,10 @@ static void mixer_atomic_disable(struct exynos_drm_crtc *crtc)
 
 	pm_runtime_put(ctx->dev);
 
+	cancel_work_sync(&ctx->work);
+	ctx->icc_bandwidth = 0;
+	mixer_set_icc_bandwidth(ctx);
+
 	clear_bit(MXR_BIT_POWERED, &ctx->flags);
 }
 
@@ -1210,6 +1320,7 @@ static void mixer_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct mixer_context *ctx = dev_get_drvdata(dev);
 
+	cancel_work_sync(&ctx->work);
 	mixer_ctx_remove(ctx);
 }
 
@@ -1223,19 +1334,33 @@ static int mixer_probe(struct platform_device *pdev)
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
@@ -1247,17 +1372,26 @@ static int mixer_probe(struct platform_device *pdev)
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

