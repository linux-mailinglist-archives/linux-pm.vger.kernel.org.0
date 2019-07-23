Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAF0717FB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbfGWMUd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:20:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38706 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389747AbfGWMUc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122031euoutp015b6e1a11af050767195cdfcd271ee4a7~0CJq24un72875428754euoutp01Z
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723122031euoutp015b6e1a11af050767195cdfcd271ee4a7~0CJq24un72875428754euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884431;
        bh=chTAxkeOxeztbYhH5EwlVhyZmCCDjcZAKWEH2LV9Maw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDJFh76Xs3O0baQ+0RL20r3do0CbUInP1yE9C2qSPh+QqXtvkarNdywgj+G3b0r3D
         0jeLwfdDPZG3zUdPGvCwdRqcp4vqm2TInMmeG0b/1ACgCa19DCiMWld5J2YqvPVfoa
         A5cReIjq+1g2716hhh2jP0mYM5cENknB6YwwvNqo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723122030eucas1p1526085231fac50d83e0c3f4e901d27ac~0CJqHQ6G11172511725eucas1p1s;
        Tue, 23 Jul 2019 12:20:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.75.04325.E8BF63D5; Tue, 23
        Jul 2019 13:20:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122029eucas1p2915f536d9ef43a7bd043a878a553439f~0CJpcU7GT2749027490eucas1p2e;
        Tue, 23 Jul 2019 12:20:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122029eusmtrp1a31f44e38dd0815908164fafed0ac103~0CJpbZEWS2543625436eusmtrp1M;
        Tue, 23 Jul 2019 12:20:29 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-b1-5d36fb8eb2a1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.51.04146.D8BF63D5; Tue, 23
        Jul 2019 13:20:29 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122028eusmtip253d509d660fc46b60b3b91f389d18d83~0CJozTE0j1733017330eusmtip2k;
        Tue, 23 Jul 2019 12:20:28 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 11/11] drm: exynos: mixer: Add interconnect support
Date:   Tue, 23 Jul 2019 14:20:16 +0200
Message-Id: <20190723122016.30279-12-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRzvd8/LPY7jccR3va5b14tNekG/lVrJ1rX+kH8z6YknWlx2D0r9
        EbmQMLkaIaxaOBMOV3lbXYdarVtLspWpYdFW8hojdeeh/Pf5fl5+n+93+zGEwkqtYs5o4nmt
        hotR0jLS1DHzxjtn1j9su6FEhs0djVJcV1BD4Q8TXylcanlD4a7JERrntxppnNeXS2KrtVaK
        jf3dFH7XVEzj8WwLwgXWNgmutvRK8ceUChoX6IfpAy5qo+Earf7U3UKr+653StT19y+rn/1o
        kahzGgxIPW5cd0x6XBYQycecSeS1PvtPyqINbbVUnG7jhbSB92Qysq7NRA4MsL4wr5uSZiIZ
        o2ArEKS2TknsgoKdQFBQuVIUxhG8uJpKLyXufX+6mChHMDCcjv4lUpqd7Jhmj0DWjceU3eTO
        WhDoy0ZI+0CwBtvwy7SQcGMPw5e8koU+klXBwHQdZcdyNhD+lBeTYt16qKp9Stixg43PbE+n
        RY8rvLw9sOAhbJ7UxiLCXgDsqBTu/PotEcNBUN6vQyJ2g2+dDVIRr4FX+qzFAgEGn/RRYjgZ
        gfGBhRCFvfC8861NYGwNW6GmyUekD0KlTi+108A6Q893V3EHZ8gz5RMiLYeMNIUIvaBsNlQM
        Alyp6l58Ww0/sk1ELtpQuOyYwmXHFP6vLUOEAXnyCUJsFC/s0vDntwlcrJCgidoWcS7WiGzf
        7NV85+Rj1DZ3yoxYBimd5LUtfmEKiksUkmLNCBhC6S4PSfYPU8gjuaSLvPZcuDYhhhfMaDVD
        Kj3ll1Z8DlWwUVw8f5bn43jtkiphHFYlI7cOt6aStLbR6ZtRJxwDEnUzXv6e2wOD5h0te5/I
        VeZ281A6F2GuPx2wp3yznm7mPT14zU+ozrjVM+Y7GK7yaD6aFsx1DQ/t9CnCvTE5ZKlXUuK+
        Ht3W7LG84BNVma8f7lZVqra0z2W3HsLeNcQjV5Ozi59qrDIg4W7IplRdtZIUorkdXoRW4P4C
        Bh55rGIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7q9v81iDX7fU7U4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexqp9
        G1gLWlQq2p5cZWlgPC/bxcjJISFgIrH47QH2LkYuDiGBpYwSN8//YINISEh8XH+DFcIWlvhz
        rYsNougTo8SWE7eZQRJsAp4SPRN3sIIkRAROMUpsXX4OrIpZYBOjxN3jE9lBqoQF3CUeTprH
        BGKzCKhKPPmxEWwsr4CTxP/lc1ggVshLrN5wAGwqJ1C862g72BlCAo4S27a/ZoSoF5Q4OfMJ
        UD0H0AJ1ifXzhEDCzECtzVtnM09gFJyFpGoWQtUsJFULGJlXMYqklhbnpucWG+oVJ+YWl+al
        6yXn525iBMbptmM/N+9gvLQx+BCjAAejEg/vhj2msUKsiWXFlbmHGCU4mJVEeAMbzGKFeFMS
        K6tSi/Lji0pzUosPMZoCvTaRWUo0OR+YQvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5ak
        ZqemFqQWwfQxcXBKNTC6lT5elvdbzu0Th+GCz/3v7ljmGXv11Ul6/uSfl+xZ0HRI737Xy/rC
        iZe/Lv4wX/5IxrvOztrDz7YpdEXN5/CNjjs0ad313b4VLz5eLjlhGmzwOTR9fubniX2BX9Vn
        3NvV32UgEXz0t+rc0tRPzov3xgXtfzsloFRVcT/PxBD3iNfftr+d4OuvxFKckWioxVxUnAgA
        zexhSukCAAA=
X-CMS-MailID: 20190723122029eucas1p2915f536d9ef43a7bd043a878a553439f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122029eucas1p2915f536d9ef43a7bd043a878a553439f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122029eucas1p2915f536d9ef43a7bd043a878a553439f
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122029eucas1p2915f536d9ef43a7bd043a878a553439f@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

This patch adds interconnect support to exynos-mixer. Please note that the
mixer works the same as before when CONFIG_INTERCONNECT is 'n'.

Co-developed-by: Artur Świgoń <a.swigon@partner.samsung.com>
Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 68 +++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 7b24338fad3c..fb763854b300 100644
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
@@ -931,6 +933,37 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
 	mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
 }
 
+static void mixer_set_memory_bandwidth(struct exynos_drm_crtc *crtc)
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
+	/* add 20% safety margin */
+	bandwidth = 5UL * bandwidth / 4;
+
+	pr_info("exynos-mixer: safe bandwidth %ld Bps\n", bandwidth);
+	icc_set_bw(ctx->soc_path, 0, Bps_to_icc(bandwidth));
+}
+
 static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct mixer_context *ctx = crtc->ctx;
@@ -982,6 +1015,7 @@ static void mixer_atomic_flush(struct exynos_drm_crtc *crtc)
 	if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
 		return;
 
+	mixer_set_memory_bandwidth(crtc);
 	mixer_enable_sync(mixer_ctx);
 	exynos_crtc_handle_event(crtc);
 }
@@ -1029,6 +1063,7 @@ static void mixer_disable(struct exynos_drm_crtc *crtc)
 	for (i = 0; i < MIXER_WIN_NR; i++)
 		mixer_disable_plane(crtc, &ctx->planes[i]);
 
+	mixer_set_memory_bandwidth(crtc);
 	exynos_drm_pipe_clk_enable(crtc, false);
 
 	pm_runtime_put(ctx->dev);
@@ -1220,12 +1255,22 @@ static int mixer_probe(struct platform_device *pdev)
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
@@ -1233,6 +1278,7 @@ static int mixer_probe(struct platform_device *pdev)
 	ctx->pdev = pdev;
 	ctx->dev = dev;
 	ctx->mxr_ver = drv->version;
+	ctx->soc_path = path;
 
 	if (drv->is_vp_enabled)
 		__set_bit(MXR_BIT_VP_ENABLED, &ctx->flags);
@@ -1242,17 +1288,29 @@ static int mixer_probe(struct platform_device *pdev)
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

