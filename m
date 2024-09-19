Return-Path: <linux-pm+bounces-14450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB3F97C6C6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D6AB22C96
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46671199933;
	Thu, 19 Sep 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nX2d0KxK"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5419923A;
	Thu, 19 Sep 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737520; cv=none; b=AfYfJXNdMaoef9QkWXsqjkHhmasyaLbOXARp4sJHebpRmRvtOm8b0tVVOavTgTn3CPgDIaGgX1K2W/94qG5pJb49yIzKQmskLDoIibUV1ykclNQ6LPTldQ/Eiod10c5ueqnK4jn0sZS1zncEX/UdTA7HPIxjo5cn1CGuL4262oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737520; c=relaxed/simple;
	bh=QrWsVp0O3acriip4USpkmSpsqOVLVMd3IZ179rzxzbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBojahNarlnW2+8v+oMc0V0qyXtDU7W5Fy4/QEgmTkic4HW0tn9iUCpZzuz3McNExJo93mKffdBfwu0zje0rYW9MAOab6kpEnIALqurI4mOdRc+A33XuAFCJ6Djivc+tzia2C2ejwmoZQ8m1hRSI4jkcVS7TlRyBBFkhuTq+S8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nX2d0KxK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726737516;
	bh=QrWsVp0O3acriip4USpkmSpsqOVLVMd3IZ179rzxzbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nX2d0KxKVHyJVZbo2V53bBjuzcXznsevjWqf7ehrlfLkvc/G+6qW4IJ7MRivWW67Z
	 K5HUaxwtPXnQd6wGRxtUG/YmuBaAIM4fqEGnH6jijOCDj/ZrUGuhKB0g032Z6vJp6Z
	 J9O4DGLl9+zeBKbrjN/spdWRu6ytbn3VKPqsdlZ1G9cN2xZc+Su97m1PZYVMFO8r4w
	 l4PzdZd1XQKRPeKJ+7nVR3EXgMZD7Rg6UJYEp463+ydVRt0njzgaGL7oDd1lf5Pj+h
	 HdDgmEhMpnO5RvDdtuAeo65581oX/hz86nhHRXC0RVoJxM5oi7OFIdap9PuY7UZ8W0
	 nYEL9MCjFgRvQ==
Received: from jupiter.universe (dyndsl-091-248-208-160.ewe-ip-backbone.de [91.248.208.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8C84917E10AB;
	Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 5A37A480084; Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
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
Subject: [PATCH v2 2/6] pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain errors
Date: Thu, 19 Sep 2024 11:12:43 +0200
Message-ID: <20240919091834.83572-3-sebastian.reichel@collabora.com>
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

Currently rockchip_do_pmu_set_power_domain prints a warning if there
have been errors turning on the power domain, but it does not return
any errors and rockchip_pd_power() tries to continue setting up the
QOS registers. This usually results in accessing unpowered registers,
which triggers an SError and a full system hang.

This improves the error handling by forwarding the error to avoid
kernel panics.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 34 +++++++++++++++++---------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 4f7021f47261..5e5291dedd28 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -488,16 +488,17 @@ static int rockchip_pmu_domain_mem_reset(struct rockchip_pm_domain *pd)
 	return ret;
 }
 
-static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
-					     bool on)
+static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
+					    bool on)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
 	struct generic_pm_domain *genpd = &pd->genpd;
 	u32 pd_pwr_offset = pd->info->pwr_offset;
 	bool is_on, is_mem_on = false;
+	int ret;
 
 	if (pd->info->pwr_mask == 0)
-		return;
+		return 0;
 
 	if (on && pd->info->mem_status_mask)
 		is_mem_on = rockchip_pmu_domain_is_mem_on(pd);
@@ -512,16 +513,21 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 
 	wmb();
 
-	if (is_mem_on && rockchip_pmu_domain_mem_reset(pd))
-		return;
+	if (is_mem_on) {
+		ret = rockchip_pmu_domain_mem_reset(pd);
+		if (ret)
+			return ret;
+	}
 
-	if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_on,
-				      is_on == on, 0, 10000)) {
-		dev_err(pmu->dev,
-			"failed to set domain '%s', val=%d\n",
-			genpd->name, is_on);
-		return;
+	ret = readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_on,
+					is_on == on, 0, 10000);
+	if (ret) {
+		dev_err(pmu->dev, "failed to set domain '%s' %s, val=%d\n",
+			genpd->name, on ? "on" : "off", is_on);
+		return ret;
 	}
+
+	return 0;
 }
 
 static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
@@ -545,7 +551,11 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			rockchip_pmu_set_idle_request(pd, true);
 		}
 
-		rockchip_do_pmu_set_power_domain(pd, power_on);
+		ret = rockchip_do_pmu_set_power_domain(pd, power_on);
+		if (ret < 0) {
+			clk_bulk_disable(pd->num_clks, pd->clks);
+			return ret;
+		}
 
 		if (power_on) {
 			/* if powering up, leave idle mode */
-- 
2.45.2


