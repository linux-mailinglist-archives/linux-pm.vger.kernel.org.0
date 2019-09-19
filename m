Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D8B7C23
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403805AbfISOXf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:23:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46556 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403790AbfISOXe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142332euoutp012ce677954da108fe9cb38d8d6d9d0b49~F3PpVdivb2256022560euoutp01m
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142332euoutp012ce677954da108fe9cb38d8d6d9d0b49~F3PpVdivb2256022560euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903012;
        bh=aqnq76AJ7cEM6iPpck0/T4PBR1c8/aJ2zN+gU2OjO5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHb6t26Bwhlx8ziUSsjIvsiO9CSLGIHg2adTCQXu5puBk5jBGdNYgvxkVJTJZxh/r
         7w29RIN6i14odEBINmhL64gMPHsV6QYEnu2Bv1hTQPCw4r9sLNZVIwDYG/N+ljaY+4
         aCc25or0xD60AfvHnLLBMBweIL+9xBbz+/UT1yow=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190919142332eucas1p1d51a1e7ed38d5ff9cbf66beda86860db~F3Poz8KI31885218852eucas1p1l;
        Thu, 19 Sep 2019 14:23:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.69.04374.46F838D5; Thu, 19
        Sep 2019 15:23:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919142331eucas1p2107a7cb9ce8b3817ed171c21a8ad5b00~F3Pn_C_-93080630806eucas1p2o;
        Thu, 19 Sep 2019 14:23:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142331eusmtrp1821b6ff67c64b3c0456b691cd09cb0a8~F3Pn9GMsH0562505625eusmtrp1Q;
        Thu, 19 Sep 2019 14:23:31 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-14-5d838f64ce27
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 18.1F.04166.36F838D5; Thu, 19
        Sep 2019 15:23:31 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142330eusmtip18daa369ad8728ac48cc1b4e8d0870d63~F3PnI7tvl3039930399eusmtip1h;
        Thu, 19 Sep 2019 14:23:30 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, b.zolnierkie@samsung.com, krzk@kernel.org,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
Subject: [RFC PATCH v2 11/11] drm: exynos: mixer: Add interconnect support
Date:   Thu, 19 Sep 2019 16:22:36 +0200
Message-Id: <20190919142236.4071-12-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju27nsKM2OU/DN0mpkUNBFLPikCwn+OPgjJAm6KLbypCOdsuO1
        kEyz8lLJxNIpJt0UxdSjNbWatYarDFekK0qZZZLZxWwahWK5HUP/Pe9z+d7nhY8hlA7Kn9Fo
        U3mdVp2ooj3Ju91/bBvjLuXFbGkfkGFz9x05dlTnI9xS3kTh15OfKHzV0kvhvqlxGl95INJY
        7yghsc3WLMd1gxMUFoftFH7VWUVj5wULwuU2kww3Wgbl+N3pOhqXl36md3tzYn0BzQ3Y79Oc
        o8gq41pvnOJavrfLuEff78u4i231iHOKgZHMQc8dcXyiJp3Xbd512DPB2f+FTBHXZj77ekae
        g34GFCIPBtitIP6sQYXIk1GydQi6++yENEwisBtb5dLgRPDDVkX/j5Q+yqEloRbBYMvQQqRo
        tBu5XDQbBvqyIXfcl7UgKK0ZJ10DwXbI4EV5I+Fy+bARYH171p0g2SDov10wxzOMgg2F69M6
        ad0qaGh+6LZ7zNGTpqukCytYb3ha8dGNiTlP3p1KdwtgCxhoyP8tk8Lh8OvJ9HxvHxiztskl
        vBJ6SotJCQsw0uGgpHAOAvGWhZCE7fDY+pJyFSLY9dDUuVmiw8B4z0m7aGC94M03b6mDF+jv
        XiEkWgHnzyolqILOCi8pCJDbYJ9/m4MBcwMqQWsMi44xLDrGsLC2BhH1yI9PE5LieSFEy2ds
        EtRJQpo2ftPR5CQRzX27nlnrVDsyzRwxI5ZBqqWK1Rl5MUpKnS5kJZkRMITKV1G1LTdGqYhT
        Z53gdcmxurREXjCjFQyp8lOcXDJ0SMnGq1P54zyfwuv+qzLGwz8HNSc/1wSuCzMWRhf/XVdb
        tF/VG3xtSvyyPPiYIXDP8MxQtj6VeWfvWdaWuld/Lp1bamBM4ptDIzuHozKtoT6xGpv65j6P
        jpEgPLNfm1sX8uPXh7D3nzXVfgeC8+KeGzOqymbHlkdVku2jAZFlIWSX6clERKYxvDg72neW
        vdk1fllFCgnq4A2ETlD/A+fzsd5yAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7rJ/c2xBt+mi1scOraV3eL+vFZG
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x4u5HVotNj6+xWlzeNYfN
        4nPvEUaLGef3MVmsPXKX3eJ24wo2ixmTX7I5CHpsWtXJ5nHn2h42j/vdx5k8Ni+p99j4bgeT
        x8F3e5g8+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL+Pz1dcsBZtUKk69aWFvYPwk28XIySEhYCIx+WADWxcjF4eQwFJGiaW3
        5jBBJCQkPq6/wQphC0v8udbFBmILCXxilPjy3grEZhNwlJg09QE7SLOIwClGia3Lz4FNYhY4
        zCQx+UEn2CRhAS+J47faGEFsFgFViavrOpm7GDk4eAUsJRb/LoJYIC+xesMBZhCbEyj8Zd98
        FohlFhJzH88Fa+UVEJQ4OfMJC0grs4C6xPp5QiBhZqDW5q2zmScwCs5CUjULoWoWkqoFjMyr
        GEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiN427Gfm3cwXtoYfIhRgINRiYdXobw5Vog1say4
        MvcQowQHs5II7xzTplgh3pTEyqrUovz4otKc1OJDjKZAn01klhJNzgcml7ySeENTQ3MLS0Nz
        Y3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYzV5VM5QlPcJz3evelj+e9HdUsnNAR8
        UXJV5dab+9U/apWCooCE85PKa7NXlChUSf2bLOL1ddMzP/FLV00OzTe9/6Bx7kaVCQkcpbe3
        z3VwzIqbOWPt4zzPF/yBqtzHAswjeeMltOytZbbelC+ylP/tsTFN/dKqjxKBy37JW7Nl3BUQ
        X5uS36TEUpyRaKjFXFScCACPvzrD9gIAAA==
X-CMS-MailID: 20190919142331eucas1p2107a7cb9ce8b3817ed171c21a8ad5b00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142331eucas1p2107a7cb9ce8b3817ed171c21a8ad5b00
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142331eucas1p2107a7cb9ce8b3817ed171c21a8ad5b00
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142331eucas1p2107a7cb9ce8b3817ed171c21a8ad5b00@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

This patch adds interconnect support to exynos-mixer. Please note that the
mixer works the same as before when CONFIG_INTERCONNECT is 'n'.

Co-developed-by: Artur Świgoń <a.swigon@partner.samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 71 +++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 7b24338fad3c..a44f3284b071 100644
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
@@ -97,6 +98,7 @@ struct mixer_context {
 	struct exynos_drm_crtc	*crtc;
 	struct exynos_drm_plane	planes[MIXER_WIN_NR];
 	unsigned long		flags;
+	struct icc_path		*soc_path;
 
 	int			irq;
 	void __iomem		*mixer_regs;
@@ -931,6 +933,40 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
 	mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
 }
 
+static void mixer_set_memory_bandwidth(struct exynos_drm_crtc *crtc)
+{
+	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
+	struct mixer_context *ctx = crtc->ctx;
+	unsigned long bw, bandwidth = 0;
+	int i, j, sub;
+
+	if (!ctx->soc_path)
+		return;
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
+	/* add 20% safety margin */
+	bandwidth = bandwidth / 4 * 5;
+
+	dev_dbg(ctx->dev, "exynos-mixer: safe bandwidth %ld Bps\n", bandwidth);
+	icc_set_bw(ctx->soc_path, Bps_to_icc(bandwidth), 0);
+}
+
 static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct mixer_context *ctx = crtc->ctx;
@@ -982,6 +1018,7 @@ static void mixer_atomic_flush(struct exynos_drm_crtc *crtc)
 	if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
 		return;
 
+	mixer_set_memory_bandwidth(crtc);
 	mixer_enable_sync(mixer_ctx);
 	exynos_crtc_handle_event(crtc);
 }
@@ -1029,6 +1066,7 @@ static void mixer_disable(struct exynos_drm_crtc *crtc)
 	for (i = 0; i < MIXER_WIN_NR; i++)
 		mixer_disable_plane(crtc, &ctx->planes[i]);
 
+	mixer_set_memory_bandwidth(crtc);
 	exynos_drm_pipe_clk_enable(crtc, false);
 
 	pm_runtime_put(ctx->dev);
@@ -1220,12 +1258,22 @@ static int mixer_probe(struct platform_device *pdev)
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
@@ -1233,6 +1281,7 @@ static int mixer_probe(struct platform_device *pdev)
 	ctx->pdev = pdev;
 	ctx->dev = dev;
 	ctx->mxr_ver = drv->version;
+	ctx->soc_path = path;
 
 	if (drv->is_vp_enabled)
 		__set_bit(MXR_BIT_VP_ENABLED, &ctx->flags);
@@ -1242,17 +1291,29 @@ static int mixer_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctx);
 
 	ret = component_add(&pdev->dev, &mixer_component_ops);
-	if (!ret)
-		pm_runtime_enable(dev);
+	if (ret < 0)
+		goto err;
+
+	pm_runtime_enable(dev);
+
+	return 0;
+
+err:
+	icc_put(path);
 
 	return ret;
 }
 
 static int mixer_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct mixer_context *ctx = dev_get_drvdata(dev);
 
-	component_del(&pdev->dev, &mixer_component_ops);
+	pm_runtime_disable(dev);
+
+	component_del(dev, &mixer_component_ops);
+
+	icc_put(ctx->soc_path);
 
 	return 0;
 }
-- 
2.17.1

