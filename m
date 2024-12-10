Return-Path: <linux-pm+bounces-18932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B99EB79F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2140F164115
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BD63DAC04;
	Tue, 10 Dec 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CV5pqR1Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86C237A22;
	Tue, 10 Dec 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850630; cv=none; b=b4t+AehIaMZx213igNqRtmiyYU7MlrYWG1rS/ZW4e1L2ONxx+xmC6kqv6NbD9o0nH/X0hICXi6p2nSAfVh9V9bzovd6sAMod3TzKZvPQJnjgne5N/EbKUGWw/O5IN8If7Qq2qR7cdH9XFCOCl4tSys2TOr2b9uU7wF2i4eZKJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850630; c=relaxed/simple;
	bh=NJ7R6moR13i/qYgT1UcSIwbcfv9v3Unc4ptYYcOTvR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwN3YC/Ow3oEmUNtLDy4i0b83P8tuaK3gUwEuFpgyyNahu/zbsyvr+06yvLkTvFgIi80ZomkYumXDIgxir1uNKQTApoVoRRdRibGawQgFbO5qM6H9JSCB9tVUVGeLbx41P2ntY3Gk1/wIhlB5/yBJWQweRno43exxpAMgckF6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CV5pqR1Z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733850625;
	bh=NJ7R6moR13i/qYgT1UcSIwbcfv9v3Unc4ptYYcOTvR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CV5pqR1ZizLOUCx6gWPAczRIc617fq/Oe9xuc+GK2VVGka9ZWLpUcfqgf1qxRwso+
	 81PH6+Gn08GJWC5SYyvNHhFlPNr8eBBovsvrWHSi+L7Pc9oAJZ0vEmKFXJa+XfioR3
	 jcubQOC4mPuriwMgyqo/rEfFvnSOVU+Og2Fp2LbitonLE9y6y8SmWvYrMBlrL3YPZt
	 rMUPzf2K+dRyUCYWooW0SYp+b+HEIHmCu53SGJjs2bEVdE827AuInp3fvq5Zvyk+yc
	 cbzkICZTPiAlfxgFyY2ampGH220J0KTum5zzKXxIZ2SyOB89ORE03UrSSVnENhyDcS
	 rIkpt5yZMICqA==
Received: from jupiter.universe (dyndsl-091-248-190-127.ewe-ip-backbone.de [91.248.190.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 22E8D17E37C0;
	Tue, 10 Dec 2024 18:10:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A952D48CC8D; Tue, 10 Dec 2024 18:10:24 +0100 (CET)
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
Subject: [PATCH v4 3/7] pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain errors
Date: Tue, 10 Dec 2024 18:06:43 +0100
Message-ID: <20241210171023.141162-4-sebastian.reichel@collabora.com>
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
index a161ee13c633..8f440f2883db 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -533,16 +533,17 @@ static int rockchip_pmu_domain_mem_reset(struct rockchip_pm_domain *pd)
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
@@ -557,16 +558,21 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 
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
@@ -592,7 +598,11 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
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


