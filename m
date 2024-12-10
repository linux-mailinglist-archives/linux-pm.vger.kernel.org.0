Return-Path: <linux-pm+bounces-18928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2069EB78F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC42282E87
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7923D410;
	Tue, 10 Dec 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BWzephFJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DA23A591;
	Tue, 10 Dec 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850629; cv=none; b=Xndu/CY2iA5XCXf/wDrcwjHIk5svEvYwmXWCK6q5txO828Rz+r4mY+Vq3ZjI6H6915p/obmTZ10ZcF1g1Td9LGjF2v/WX2u4OLfe1gj8etI4rQT3nn7ihU7hQCPkgJoRoBKyRTXw11f/s+fZLLzQlLcYmr8FWMZPZeucFs1FlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850629; c=relaxed/simple;
	bh=WdAfMwo/02oulaifUnF7xk8G7gAfYMpEJETO/isky1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5qRISftShdjojVS4gtzYFmu1489jr45/zOPBqFmV0X08dYtKIGA0SneilikXZhGSWrlR+eqXLAYbdLmmR0Br+9syzyNQGs+4UVR0qGeKEhKuuQEP8AEUOGoLPbGLdddBgl+sE1fSLl7wrsEmBcU6pXi/YgC7MS/lhROY7d5I/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BWzephFJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733850625;
	bh=WdAfMwo/02oulaifUnF7xk8G7gAfYMpEJETO/isky1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWzephFJskl5FdC8gg5CbxrrVMkaWMPTRX0Lw9m8SDeHOvXWi3b7h3bSYlMmgaSw1
	 MAWAlGy9S6dFKT/mwFHa75bhSJKlG5ZpOUX5gGjglUB7zRnG+raGXZwxbp/qqIf4vW
	 Tr0aIa9kEMspodBEJmWJzU3o8S1la/0NHv3UHSG87cM0xFcJJP230xDIGPgEDoz4SV
	 j9CYkU5t1RZtOl8E34DO9F1DSOPGllrUpE6Nd9CXlid6v3+MjPiDSkTo3XPmapLG2G
	 gOFGEpIdgz6UcxQZXdv8eIndcyGY1mR7tNvaLBghODNo58K6p5ZbePNcCxs14r/8FD
	 RvGNQw9XS7Nqg==
Received: from jupiter.universe (dyndsl-091-248-190-127.ewe-ip-backbone.de [91.248.190.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2561117E37C4;
	Tue, 10 Dec 2024 18:10:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id AB75048CC8E; Tue, 10 Dec 2024 18:10:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v4 4/7] pmdomain: rockchip: reduce indentation in rockchip_pd_power
Date: Tue, 10 Dec 2024 18:06:44 +0100
Message-ID: <20241210171023.141162-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210171023.141162-1-sebastian.reichel@collabora.com>
References: <20241210171023.141162-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the logic, so that the function exits early when the
power domain state is already correct to reduce code indentation.

No functional change intended.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 49 +++++++++++++-------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 8f440f2883db..f4e555dac20a 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -582,39 +582,40 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 
 	guard(mutex)(&pmu->mutex);
 
-	if (rockchip_pmu_domain_is_on(pd) != power_on) {
-		ret = clk_bulk_enable(pd->num_clks, pd->clks);
-		if (ret < 0) {
-			dev_err(pmu->dev, "failed to enable clocks\n");
-			return ret;
-		}
+	if (rockchip_pmu_domain_is_on(pd) == power_on)
+		return 0;
 
-		rockchip_pmu_ungate_clk(pd, true);
+	ret = clk_bulk_enable(pd->num_clks, pd->clks);
+	if (ret < 0) {
+		dev_err(pmu->dev, "failed to enable clocks\n");
+		return ret;
+	}
 
-		if (!power_on) {
-			rockchip_pmu_save_qos(pd);
+	rockchip_pmu_ungate_clk(pd, true);
 
-			/* if powering down, idle request to NIU first */
-			rockchip_pmu_set_idle_request(pd, true);
-		}
+	if (!power_on) {
+		rockchip_pmu_save_qos(pd);
 
-		ret = rockchip_do_pmu_set_power_domain(pd, power_on);
-		if (ret < 0) {
-			clk_bulk_disable(pd->num_clks, pd->clks);
-			return ret;
-		}
+		/* if powering down, idle request to NIU first */
+		rockchip_pmu_set_idle_request(pd, true);
+	}
 
-		if (power_on) {
-			/* if powering up, leave idle mode */
-			rockchip_pmu_set_idle_request(pd, false);
+	ret = rockchip_do_pmu_set_power_domain(pd, power_on);
+	if (ret < 0) {
+		clk_bulk_disable(pd->num_clks, pd->clks);
+		return ret;
+	}
 
-			rockchip_pmu_restore_qos(pd);
-		}
+	if (power_on) {
+		/* if powering up, leave idle mode */
+		rockchip_pmu_set_idle_request(pd, false);
 
-		rockchip_pmu_ungate_clk(pd, false);
-		clk_bulk_disable(pd->num_clks, pd->clks);
+		rockchip_pmu_restore_qos(pd);
 	}
 
+	rockchip_pmu_ungate_clk(pd, false);
+	clk_bulk_disable(pd->num_clks, pd->clks);
+
 	return 0;
 }
 
-- 
2.45.2


