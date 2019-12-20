Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA849127A87
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 13:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLTMBu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 07:01:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60543 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfLTMBt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 07:01:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191220120147euoutp02e3fa3196a17abc6c063dd7a008d7e0df~iEqJMA1q10140301403euoutp02G
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 12:01:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191220120147euoutp02e3fa3196a17abc6c063dd7a008d7e0df~iEqJMA1q10140301403euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576843307;
        bh=Vp2pX2yxmoezR5VR1GvMMaSos7A2m/IoE56NLCnWKMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9/8X4p4CmFv+Tv4uDeYqkHMn0ZK9x0y3eySn+jSjrgmX0mf88yytJxcamUZyNWPQ
         k80AOcqYGEZJQnKzq97twWZzD2vXy6wV8Nk7jw5qtYwIbCBO/cgF4EpyjEyrCvEF/y
         Uqsfo4YCbrU1LEOIqE+rWBAK0FfB58BxmtpAnK8A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191220120147eucas1p1b2a0121aa707c8134bfaa16d35454ae3~iEqIlHHLV2488424884eucas1p15;
        Fri, 20 Dec 2019 12:01:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 08.3E.60698.B28BCFD5; Fri, 20
        Dec 2019 12:01:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7~iEqIUKKKm2914729147eucas1p23;
        Fri, 20 Dec 2019 12:01:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220120146eusmtrp20e541263f3651a59e5c31138416cf359~iEqITjJN82149221492eusmtrp24;
        Fri, 20 Dec 2019 12:01:46 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-50-5dfcb82bfc1d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A8.87.08375.A28BCFD5; Fri, 20
        Dec 2019 12:01:46 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120146eusmtip28e4c90497745c6fe92f36c1c6485b24a~iEqHhkEs02950829508eusmtip2R;
        Fri, 20 Dec 2019 12:01:45 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, b.zolnierkie@samsung.com, krzk@kernel.org,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
Subject: [RFC PATCH v3 7/7] drm: exynos: mixer: Add interconnect support
Date:   Fri, 20 Dec 2019 12:56:53 +0100
Message-Id: <20191220115653.6487-8-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220115653.6487-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e0+dpUm1xV46KWNhB6UiUU/K0Sp8FIQFQlNGDnrtqRtxm6a
        FZElmpXKVDK1UJNI2RrqKlMribUyKx3UfMC02YvQHlZqMpPM613lf5/z+H7POXAYQumm5jMp
        xqO8yajVq+hAsvGJz7VqZdOkZo3jLoW9FdkIN5TWUbhn9COFK52dFHaPDdP48gM7jYu8ZhK7
        XPVyXNv/ncL2d90UftVylcYj+U6ES12tMmxz9sux50wtjUuLB+lYlrNbztNcX/d9mvNebJNx
        t66f5hq+Nsm4gtsWxI3YF++UJwZuOsDrU9J5U0RMUuAhX+kn6kjh0owXLQPyTORedAEFMMCu
        haq8KvoCCmSUbC0CS9cgIQWjCBwT7f5gBMG17Gfyv5LcjlFKZCVbg8BmVv9TlDwaJ8QCzcZB
        0aUBuViYxzoRFFcNk2JAsHUy+OapmJHPZTl42uWjRSbZcOjpHUAiK1gM3x9Wy6RxoWCtfzjj
        GsBGQ2/XS0LqCYb2svekyMR0T9adK4TUPyaHfFeCxFsg9/5jUuK5MNR223/CQphqrvT7C/Ch
        2UuJywGbicB+w+k32gh9nRPTyzHTA5ZDXUuElI6Dz64GSkwDGwS9X4KlFYKgqPEyIaUVkJuj
        lFAFLWVBkhDgrLXb781Bta1AbkZLymfdUj7rlvL/Y6sQYUEhfJpg0PFClJE/tlrQGoQ0o271
        /lSDHU3/2vPfbWNNqHUy2YFYBqnmKGIP/tIoKW26cNzgQMAQqnkKT65Po1Qc0B4/wZtS95nS
        9LzgQAsYUhWiiKoe1ChZnfYof5jnj/Cmv1UZEzA/E9WGb9uxbKs6rIC0xB+cWv9unVtnTldz
        yT+ZN9GOvZoFm5OjdM1pkcvuxWZeq1+zYbstsiRc6PnU0Tiwxb5e88PafrJ4uFDvzjsZfe41
        kZFAdpFDZdV7YpJ29X+d3H1TnXPibfhQ/sbU0MTxvhq7z2vSWeui48mSxoxTWTwf5rmrIoVD
        2sgVhEnQ/gF6ItAIZwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7paO/7EGmzaZ2Bxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3WHH3I6vFpsfXWC0u75rDZvG59wij
        xYzz+5gs1h65y25xu3EFm8WMyS/ZHAQ8Nq3qZPO4c20Pm8f97uNMHpuX1HtsfLeDyaNvyypG
        j8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQyfs54zVowUaXizK4H7A2MV2S7GDk5JARMJDrOfmHtYuTiEBJYyijx6uZbRoiEhMTH9TdY
        IWxhiT/Xutggij4xSnxeuIwFJMEm4CgxaeoDdpCEiMApRomty8+BVTEL7GaSWDlnP1iVsICH
        xImrP9lAbBYBVYnrNx6AreAVsJD4eGARE8QKeYnVGw4wg9icApYSN65eArOFgGp2fu5jgqgX
        lDg58wnQTA6gBeoS6+cJgYSZgVqbt85mnsAoOAtJ1SyEqllIqhYwMq9iFEktLc5Nzy021CtO
        zC0uzUvXS87P3cQIjNhtx35u3sF4aWPwIUYBDkYlHt6Xyb9jhVgTy4orcw8xSnAwK4nw3u74
        GSvEm5JYWZValB9fVJqTWnyI0RTotYnMUqLJ+cBkklcSb2hqaG5haWhubG5sZqEkztshcDBG
        SCA9sSQ1OzW1ILUIpo+Jg1OqgdG6b5tdm4RQYu0bBk2rPH5u33LfL0c+vt4+/YwHo8WqR4K1
        05U0wyysvhwJf65y+ZlLSVUZx42vL7Zv/rerRErjb5jwz0VTT1U9dGtv9T82uSclgGVKQXjP
        /1LGiVkLehmOsnnNVmHzL7hzdP51Th4DLsV0xwV5Ff9d5S3TzE48uTpBiPP4aiWW4oxEQy3m
        ouJEACpmbZnuAgAA
X-CMS-MailID: 20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

This patch adds interconnect support to exynos-mixer. The mixer works
the same as before when CONFIG_INTERCONNECT is 'n'.

Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 71 +++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 6cfdb95fef2f..a7e7240a055f 100644
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
+
+	pm_runtime_disable(dev);
+
+	component_del(dev, &mixer_component_ops);
 
-	component_del(&pdev->dev, &mixer_component_ops);
+	icc_put(ctx->soc_path);
 
 	return 0;
 }
-- 
2.17.1

