Return-Path: <linux-pm+bounces-14449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081D297C6C4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFFA1C227D9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240ED1993AD;
	Thu, 19 Sep 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p8IxNupL"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DF12E48;
	Thu, 19 Sep 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737520; cv=none; b=XXHr0g9QYh2P1P3GkOQXOkegRpMQBjFL7giwWhHxv/+X+0wdvAtJOZKSyt92fy3OLf2enFbYljb/Cha0fmd/egql0pyWnmlzGtMhRqR0FXVxuYOM60wI++Ywju5TkhVBnQ/fPMssu08RCxbJX/fER5zYyGq2mhdFzKtHO+L4lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737520; c=relaxed/simple;
	bh=Zxm1uLqr1zUwk6C1A4ApcASI47Ep0+VpPk2kApygxO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbiQ8YwnIVQuuXkIasZ8rD4/oPCd6xr+mXih/OarE/sgXlckGPM/eayPBAUyy/xymR6dRfn1m8902Vuy2TaG9lpTkUjDgV7kvP35HlzIdsMca8fcLtzjvAfEGl5OSwFiDF94TXJMeC7M91OUcZVxixl+HWCxBzcm2Yd1LVm1rIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p8IxNupL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726737516;
	bh=Zxm1uLqr1zUwk6C1A4ApcASI47Ep0+VpPk2kApygxO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8IxNupLEi1CO37HBlbjusvnuFIXtFUWOIq1ZrBo8FjbwNC7puM9FfInIJkgLKdc6
	 zFt/0ho4FEjSfoa4Ja6R6syk1kgexB3Z/KzPh8jNChqKcLrNw2wBxOAP1Pw1c1y4I2
	 7YRI4G66Q1bfNahuxFF91JdiKGBJ7lQ4wA3NpAgebeszWU1pX6MF6ocUB+fAnLYVAj
	 V1Vsd7EL9OiOaP2s83dtJBfN3rt1itloAj1FBKBkhAjAyAAdij1Vq52KCAH0DshQ77
	 jqRyRSQwfmbAge5AfR80K9MA07t5cLDEDLd1xgJFa+bkInNg4runv4f2PBjci2Oqhf
	 AqKUuVqYYUaow==
Received: from jupiter.universe (dyndsl-091-248-208-160.ewe-ip-backbone.de [91.248.208.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 808BF17E1082;
	Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 5C1B5480085; Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
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
Subject: [PATCH v2 3/6] pmdomain: rockchip: reduce indentation in rockchip_pd_power
Date: Thu, 19 Sep 2024 11:12:44 +0200
Message-ID: <20240919091834.83572-4-sebastian.reichel@collabora.com>
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

Rework the logic, so that the function exits early when the
power domain state is already correct to reduce code indentation.

No functional change intended.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 45 +++++++++++++-------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 5e5291dedd28..663d390faaeb 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -537,36 +537,37 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 
 	guard(mutex)(&pmu->mutex);
 
-	if (rockchip_pmu_domain_is_on(pd) != power_on) {
-		ret = clk_bulk_enable(pd->num_clks, pd->clks);
-		if (ret < 0) {
-			dev_err(pmu->dev, "failed to enable clocks\n");
-			return ret;
-		}
+	if (rockchip_pmu_domain_is_on(pd) == power_on)
+		return 0;
 
-		if (!power_on) {
-			rockchip_pmu_save_qos(pd);
+	ret = clk_bulk_enable(pd->num_clks, pd->clks);
+	if (ret < 0) {
+		dev_err(pmu->dev, "failed to enable clocks\n");
+		return ret;
+	}
 
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
 
-		clk_bulk_disable(pd->num_clks, pd->clks);
+		rockchip_pmu_restore_qos(pd);
 	}
 
+	clk_bulk_disable(pd->num_clks, pd->clks);
+
 	return 0;
 }
 
-- 
2.45.2


