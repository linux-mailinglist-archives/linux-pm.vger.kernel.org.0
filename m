Return-Path: <linux-pm+bounces-22567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C7A3E489
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813D916AC94
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302F267AF0;
	Thu, 20 Feb 2025 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H3oO+Axc"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9C2641DF;
	Thu, 20 Feb 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077919; cv=none; b=TrG9crX4wZyBvWj/LJ0g5oBkiLpQJBrATMHdjb8mvls/dimyw5VMNd6Lt25fAU+vPYqofTibwRbB7xda+gClrE8j+QeMMamOSxkhweFDsQa8GS6g40+BkEBk+VK4tBlVaSxWyuS/svnJUhyyRNDYlICTuC4aG2nMZaEmBq7s6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077919; c=relaxed/simple;
	bh=GLMHpN3R06jn1QGPa+raIrP/SKC8LazQwv+Nx7GIz9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1Sd24855lAkfpiQhZQXK3BvLsf999ZDcyjqOK+JsZVE3wtS3tvtf7Ds7FF+4IAH0QtfGtxD1kumS0wqkkzPMiOT2bY5VgmS11zxwmfyf3h1CXbuy5lV0OQu83NMQCvfKRUq1oWK4/ph+/xtjCzJYCjjMVhVGl0SvtDCJ6X2snU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H3oO+Axc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740077913;
	bh=GLMHpN3R06jn1QGPa+raIrP/SKC8LazQwv+Nx7GIz9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H3oO+Axc9hvxQvhxEIChQlZ61ETywsprmiC6eBV5e3RHhFYI17kCS2xY9kZlcoin9
	 jjlyHuws5xUkpcxEoFvQa0T9+i7FY7zw4PjEosMic4QM88SCIkN/sUWGTpCYjsQj5f
	 1ZKrpTFgVwW8ZHkDLRTkdqUumgZhmRQXg3mM01ywU/+77u2O7xyI4RjdLso35S1YFZ
	 /JEMRYO4ot1LqBQu26k21KnjcNBGqB4EOeqGf+AnCHSwQo+zRorQZ6RL6QN5Gk+vRc
	 tKVabWbEhJfKCdcaQYA68qCJlu32UPMP/iIaLnYP93pTxqDu+UGemRZMqhH51T5uwb
	 Wf9zAlcEvldKg==
Received: from jupiter.universe (dyndsl-091-248-085-196.ewe-ip-backbone.de [91.248.85.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E8A017E1247;
	Thu, 20 Feb 2025 19:58:33 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0ED0A480039; Thu, 20 Feb 2025 19:58:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 20 Feb 2025 19:58:07 +0100
Subject: [PATCH v6 4/8] pmdomain: rockchip: reduce indentation in
 rockchip_pd_power
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-rk3588-gpu-pwr-domain-regulator-v6-4-a4f9c24e5b81@kernel.org>
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
In-Reply-To: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
To: Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 =?utf-8?q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Peter Geis <pgwipeout@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Vignesh Raman <vignesh.raman@collabora.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2565; i=sre@kernel.org;
 h=from:subject:message-id; bh=GLMHpN3R06jn1QGPa+raIrP/SKC8LazQwv+Nx7GIz9s=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe3e1jX6bntbKZnlXudz868/4HS7CWVnKWDX
 zPOcSFzKUJjfokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnt3tYAAoJENju1/PI
 O/qa+aAP/0w7Dh1H1KG7hiCI2fYqXKZTGa2+QNuFvRplr+fZh1cGbWobeRgTgLb25eJmRsgO8Pb
 5w8Z2pEU9T9DToKksuX0YAlkskVIpG5251hCvnb4tVH+3bFpOtGba/FnE5c3U6LMnUvewz38P6f
 K8jqqIH1l9aFf6JdAX0QY/Jf0Pj3G738V0g0wIoBt81bSIZ7JcWdBomFoKBpXE50+bAGOeU9NFF
 gXLttpi10rv16x+GfabM+bTuA1AAlBTtTw5pS/naqyyVUc0khBM1acTGJKr1Ndm2Q414miMsmZI
 vMssY7YG1SBMuhl7GjJOmdRZP/EjqIePelm/QQf71zdVMwfTFpxyQsueyJ/pwygL6z/5Hul8tBZ
 Wvu2gz1ZOJrR3OHFzBRJHe3qWNPDke/eOyHFRphpDKCRPkeAN1NK324h/+e5EEjMlI1yXShAQAU
 7LfQOTSldxhg7xw//+5hp8RkIARzpshqTzBftpJtNY1pzOHdoZF9b5JwKiazME37tacaUMw6486
 aindSNzLvGwrmv6XhWQolScXkI1CX9pU13122+3YISUjhsqu9pSkX6benUCObFmbgrof9/BZF6A
 qoSnEBfMiaR4MbCEZEZpZfIPpdhqwCW9h2fUGjAYBIKuxIdX7k67yZqSrMog+toLJ/dyVLviGaU
 i77kDzGpOCAtEoqR4e5gsvg==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Rework the logic, so that the function exits early when the
power domain state is already correct to reduce code indentation.

No functional change intended.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 49 +++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 8f440f2883db88e22fde7ed9b235982d3030416e..f4e555dac20a32978d71092dbe66cdd1226b8ac1 100644
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
2.47.2


