Return-Path: <linux-pm+bounces-463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0307FD5CC
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E731C20CAB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18251CAA3;
	Wed, 29 Nov 2023 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NWrmaJ+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD43084;
	Wed, 29 Nov 2023 03:33:12 -0800 (PST)
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id E0A006601F02;
	Wed, 29 Nov 2023 11:33:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701257591;
	bh=x16Rnq7CZEpFbM9s04wUl+znCtY6zt8f98/hPwnLU3c=;
	h=From:To:Cc:Subject:Date:From;
	b=NWrmaJ+GCcglxq208tXL5bSQmTfPx7i69hCbPXnCUxeWxkjyUeJC0uO/ZZ49Oig5q
	 D1vd0wXcKPpaG8YHmzygzS8viumQuoOrtLZ4HlGhj26Ng4Bjtzt5A4ntoeAsxblAt6
	 Xw/z1zN5Gh98+BaWWdPt6vF+esqBVJSw0vZVx2QXrBg86+oFsdfHtP7iGog8zbtT6x
	 HV63cXFbi8Pu58QlB9wIvpHYHXZZPf8i2S4Uf+fdWCm9zI8nSSx+IzPa7/fsy07Qh3
	 yfJ7ZCHeukygDPOEOD/k0+KOurbGnlyT4I8QGBSCnHUemBpwN0tLRjNt/3IOMyFKnG
	 Mqjzf0Nhp/m2A==
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org
Cc: eballetbo@kernel.org,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] pmdomain: mediatek: fix race condition in power on/power off sequences
Date: Wed, 29 Nov 2023 13:31:20 +0200
Message-Id: <20231129113120.4907-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can happen that during the power off sequence for a power domain
another power on sequence is started, and it can lead to powering on and
off in the same time for the similar power domain.
This can happen if parallel probing occurs: one device starts probing, and
one power domain is probe deferred, this leads to all power domains being
rolled back and powered off, while in the same time another device starts
probing and requests powering on the same power domains or similar.

This was encountered on MT8186, when the sequence is :
Power on SSUSB
Power on SSUSB_P1
Power on DIS
	-> probe deferred
Power off DIS
Power off SSUSB_P1
Power off SSUSB

During the sequence of powering off SSUSB, some new similar sequence starts,
and during the power on of SSUSB, clocks are enabled.
In this case, powering off SSUSB fails from the first sequence, because
power off ACK bit check times out (as clocks are powered back on by the second
sequence). In consequence, powering it on also times out, and it leads to
the whole power domain in a bad state.

To solve this issue, added a mutex that locks the whole power off/power on
sequence such that it would never happen that multiple sequences try to
enable or disable the same power domain in parallel.

Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 24 +++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index d5f0ee05c794..4f136b47e539 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_clk.h>
 #include <linux/platform_device.h>
@@ -56,6 +57,7 @@ struct scpsys {
 	struct device *dev;
 	struct regmap *base;
 	const struct scpsys_soc_data *soc_data;
+	struct mutex mutex;
 	struct genpd_onecell_data pd_data;
 	struct generic_pm_domain *domains[];
 };
@@ -238,9 +240,13 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
+	mutex_lock(&scpsys->mutex);
+
 	ret = scpsys_regulator_enable(pd->supply);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&scpsys->mutex);
 		return ret;
+	}
 
 	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
 	if (ret)
@@ -291,6 +297,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 			goto err_enable_bus_protect;
 	}
 
+	mutex_unlock(&scpsys->mutex);
 	return 0;
 
 err_enable_bus_protect:
@@ -305,6 +312,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 err_reg:
 	scpsys_regulator_disable(pd->supply);
+	mutex_unlock(&scpsys->mutex);
 	return ret;
 }
 
@@ -315,13 +323,15 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
+	mutex_lock(&scpsys->mutex);
+
 	ret = scpsys_bus_protect_enable(pd);
 	if (ret < 0)
-		return ret;
+		goto err_mutex_unlock;
 
 	ret = scpsys_sram_disable(pd);
 	if (ret < 0)
-		return ret;
+		goto err_mutex_unlock;
 
 	if (pd->data->ext_buck_iso_offs && MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))
 		regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_offs,
@@ -340,13 +350,15 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
 				 MTK_POLL_TIMEOUT);
 	if (ret < 0)
-		return ret;
+		goto err_mutex_unlock;
 
 	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 
 	scpsys_regulator_disable(pd->supply);
 
-	return 0;
+err_mutex_unlock:
+	mutex_unlock(&scpsys->mutex);
+	return ret;
 }
 
 static struct
@@ -700,6 +712,8 @@ static int scpsys_probe(struct platform_device *pdev)
 		return PTR_ERR(scpsys->base);
 	}
 
+	mutex_init(&scpsys->mutex);
+
 	ret = -ENODEV;
 	for_each_available_child_of_node(np, node) {
 		struct generic_pm_domain *domain;
-- 
2.34.1


