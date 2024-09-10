Return-Path: <linux-pm+bounces-13963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D19741A7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7B4B266A6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1991A7AD9;
	Tue, 10 Sep 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M8XpCSe1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF701A705D;
	Tue, 10 Sep 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991539; cv=none; b=cIMX+8174ZxxYqw6qVlYi0vbZH8XrFXW44VXMR1cOitjtgRIDl2cPZeJjo2AYMjjYEPbvy1AfeU86PKxqhJu9pEWXSYPgfWmqDJoWefRwFDPYDDyD/D1jf774M0ybuscGEvLnqXOcIrTmvOOIqAHJbvRl24QNbmChJNOCls7078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991539; c=relaxed/simple;
	bh=TfEQ0e/TZzz/N5j2kw3vCDQnPXPvuDJwAkPceMp2rKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+cWE+S3EGEciQlXw4FzkAjTySbtirvOQwtBEhcSAaHAlH0MQyTeNaJuEyHT2O/hfZbKiZZEBrp69Y2zPUJ7LwAmdgpgfXlQ850F5oHhGH9xrpn+v5Y6d6gAN8ULoGoYfzaEZ8B23tvLfjYPV8VhIox6yeXHDRDWssmKMdxxP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M8XpCSe1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725991532;
	bh=TfEQ0e/TZzz/N5j2kw3vCDQnPXPvuDJwAkPceMp2rKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8XpCSe1QYXBmMA+yRiI0tCENnO5kMj9oO+2oSh70RevifXgsqdu/L57bUZt44VNe
	 /eDJ4Vvf8Qoel4QfS5jStA6STSTu98WRjOatvaLp9Su50yrKFlsJLgZrT4EoYrIWK4
	 y96/xgB/lXz4fzhE9XAVfwQ95EPEq8mQ3UPB+rDcctN2QiTS5e0B0V0HQEroroCNoc
	 6OlyBb+7dOqH/2EPbM7uzLebC3FbdmF283KnxFnEefFbftPR/M7R/CQ2AsPEOjbk4x
	 Pup7Sc4WprQ8DvyMcp55a7Nw+Oto4cPW2cYpiKgC5IkJmG3g+aMogxD5RBZpSoH3L6
	 ydeoSozA5TvNA==
Received: from jupiter.universe (dyndsl-091-248-215-127.ewe-ip-backbone.de [91.248.215.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 15A1317E3600;
	Tue, 10 Sep 2024 20:05:32 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 939474800FF; Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 5/6] pmdomain: rockchip: add regulator support
Date: Tue, 10 Sep 2024 19:57:14 +0200
Message-ID: <20240910180530.47194-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910180530.47194-1-sebastian.reichel@collabora.com>
References: <20240910180530.47194-1-sebastian.reichel@collabora.com>
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

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 57 +++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 663d390faaeb..ae6990897928 100644
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
@@ -571,18 +574,67 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 	return 0;
 }
 
+static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
+{
+	return pd->supply ? regulator_disable(pd->supply) : 0;
+}
+
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
@@ -663,6 +715,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 
 	pd->info = pd_info;
 	pd->pmu = pmu;
+	pd->node = node;
 
 	pd->num_clks = of_clk_get_parent_count(node);
 	if (pd->num_clks > 0) {
-- 
2.45.2


