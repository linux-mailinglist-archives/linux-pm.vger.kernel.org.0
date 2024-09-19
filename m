Return-Path: <linux-pm+bounces-14454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE1B97C6D9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23538281D85
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506319CD07;
	Thu, 19 Sep 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XQ0Mwkmk"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3419ABC6;
	Thu, 19 Sep 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737523; cv=none; b=BPz4qhAKhCJ6egOgI+OBbh5xBdw7Ew1+7b4I10f02fdbkDhVXHGY8WDcyi/urig1YVRpVwkSeED+ZQk5uPIbUpPZV1cc7c3UwsItRfhF2QSeZ+jv74EKkidtB+fC6CYPFlU1OqAv5Sxl0b1KTdCMvVrmCjbVyPJObVWrbdo3xZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737523; c=relaxed/simple;
	bh=5X2JcD6nxPTdz5lMfErMebNbQNrki2yIYXCau8/4xYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUO7Up5rYsbh5FIpyrndImBDNwb3k8pYQnpWodbWtm6wKP+jiFvEXuqw/JsIQ9m1hbBTlkMa+3zxFgSUsFLwvobyF7BGCT/UR96ieUuQscB+FxOQI59zlbnTAYQcJyUElFeDuv1JKGQBqYgTWMcPlGFna6HE9oAHHfyGE0Pi9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XQ0Mwkmk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726737516;
	bh=5X2JcD6nxPTdz5lMfErMebNbQNrki2yIYXCau8/4xYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ0Mwkmk5GWH0Rq6ltYmTNoJC6Hwcm7PQjj+VB0c5RIm6hSfZxnIfCzQuSBij7HvB
	 7JS6h047lXbzKvXkwks9j9vfBF97HoBcKHHaMXb9YVxii30KTcZ6iqDEm3CVAISMaU
	 LNz4SViNLTbTjasgJNbVTYqYHVvFPze3l3G9/Qj51FJ/8nKfgfwRSTZbS2c4A864Tz
	 JYek4jlRgaI5yug+H18LC3RClfrx3toHzDBFV11WGEsLuidblth1NWkgWYRi0fhrlq
	 1RxgdfjZITTfFvzxaBAvIAYmy6HryNmSSMoQ22IwjPMISxfbC9ZKeWEDNTVoeHm6n6
	 gkR0/Jm+lWSqg==
Received: from jupiter.universe (dyndsl-091-248-208-160.ewe-ip-backbone.de [91.248.208.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B8DD417E10AF;
	Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 5FA46480088; Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 5/6] pmdomain: rockchip: add regulator support
Date: Thu, 19 Sep 2024 11:12:46 +0200
Message-ID: <20240919091834.83572-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919091834.83572-1-sebastian.reichel@collabora.com>
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some power domains require extra voltages to be applied. For example
trying to enable the GPU domain on RK3588 fails when the SoC does not
have VDD GPU enabled.

The solution to temporarily change the device's device tree node has
been taken over from the Mediatek power domain driver.

The regulator is not acquired at probe time, since that creates circular
dependencies. The power domain driver must be probed early, since SoC
peripherals need it. Regulators on the other hand depend on SoC
peripherals like SPI, I2C or GPIO.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 56 +++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 663d390faaeb..4bc17b588419 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -18,6 +18,7 @@
 #include <linux/of_clk.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <soc/rockchip/pm_domains.h>
 #include <dt-bindings/power/px30-power.h>
@@ -89,6 +90,8 @@ struct rockchip_pm_domain {
 	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
 	int num_clks;
 	struct clk_bulk_data *clks;
+	struct device_node *node;
+	struct regulator *supply;
 };
 
 struct rockchip_pmu {
@@ -571,18 +574,66 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 	return 0;
 }
 
+static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
+{
+	return pd->supply ? regulator_disable(pd->supply) : 0;
+}
+
+static int rockchip_pd_regulator_enable(struct rockchip_pm_domain *pd)
+{
+	struct rockchip_pmu *pmu = pd->pmu;
+	struct device_node *main_node;
+
+	if (!pd->supply) {
+		/*
+		 * Find regulator in current power domain node.
+		 * devm_regulator_get() finds regulator in a node and its child
+		 * node, so set of_node to current power domain node then change
+		 * back to original node after regulator is found for current
+		 * power domain node.
+		 */
+		main_node = pmu->dev->of_node;
+		pmu->dev->of_node = pd->node;
+		pd->supply = devm_regulator_get(pmu->dev, "domain");
+		pmu->dev->of_node = main_node;
+		if (IS_ERR(pd->supply)) {
+			pd->supply = NULL;
+			return 0;
+		}
+	}
+
+	return regulator_enable(pd->supply);
+}
+
 static int rockchip_pd_power_on(struct generic_pm_domain *domain)
 {
 	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
+	int ret;
+
+	ret = rockchip_pd_regulator_enable(pd);
+	if (ret) {
+		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
+		return ret;
+	}
 
-	return rockchip_pd_power(pd, true);
+	ret = rockchip_pd_power(pd, true);
+	if (ret)
+		rockchip_pd_regulator_disable(pd);
+
+	return ret;
 }
 
 static int rockchip_pd_power_off(struct generic_pm_domain *domain)
 {
 	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
+	int ret;
 
-	return rockchip_pd_power(pd, false);
+	ret = rockchip_pd_power(pd, false);
+	if (ret)
+		return ret;
+
+	rockchip_pd_regulator_disable(pd);
+	return ret;
 }
 
 static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
@@ -663,6 +714,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 
 	pd->info = pd_info;
 	pd->pmu = pmu;
+	pd->node = node;
 
 	pd->num_clks = of_clk_get_parent_count(node);
 	if (pd->num_clks > 0) {
-- 
2.45.2


