Return-Path: <linux-pm+bounces-16237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0409AB267
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDBD284269
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD961AD5D8;
	Tue, 22 Oct 2024 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V0ko+3o+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B819DF52;
	Tue, 22 Oct 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611914; cv=none; b=YMricFRUYoBe2snFDGL9O7xwuAfB4ieTCpY+DuaQZ3veswfdj2oUh3PkwP19qhzZTuolRWJ+Fvs9+BNY932ys91EA84hYLNQcPNinXJqkYhjnBk2OT3uGMsXhT/57jlS0iCXqMVUUKUePwGi4a+0604+GmGNZ/SZb6v91YI60xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611914; c=relaxed/simple;
	bh=WdAfMwo/02oulaifUnF7xk8G7gAfYMpEJETO/isky1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Orn8mJvklu3pCgMjlDsspEg8J6EDsFNYzCUKRuHT+qL42bSydeDsawOXZ6g2Xd1vc4dQwpXAw38JQox8qrrXvZJgLZpVonx4LmvQu47+23zBBBGiDvxAM44G7CQYtCT7yomHM4NcRFbFvcQAZlrEAmYjQ+jBBH11W5BYE+GecyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V0ko+3o+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729611909;
	bh=WdAfMwo/02oulaifUnF7xk8G7gAfYMpEJETO/isky1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0ko+3o+VrZizinMoMFxC+tLwwaGgfWnMO0+MB1SWLm2JgEWq1U2rVcmCWHL+hffR
	 q9lDRJYm6xymckEd1T03tCHoAqdm3EAXle/2h6hB7eA5qLnyoIMTLcr4nTY8IZzJ0S
	 il3jrsB/4GqfFWVjq3PnacouZwMx0TcaPC74f8w2vlyuT04BU0xWbbqs3AqQb4lnj3
	 whv/Ue177H9Y4aCvdU+gW6BckqAhB3UXhjXHdqylhBPDYl6Ar6+3SebyUeforY/K8P
	 8+c71l0+/g49OIfjv2YVQuGn5GQ8VoBEy4xI94vSOcu91l1I1xoaCp+8qmn50OZ8qE
	 qwo0M+phXHZLg==
Received: from jupiter.universe (dyndsl-091-248-085-026.ewe-ip-backbone.de [91.248.85.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7C4717E367D;
	Tue, 22 Oct 2024 17:45:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 6B89F4800F8; Tue, 22 Oct 2024 17:45:09 +0200 (CEST)
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
Subject: [PATCH v3 4/7] pmdomain: rockchip: reduce indentation in rockchip_pd_power
Date: Tue, 22 Oct 2024 17:41:49 +0200
Message-ID: <20241022154508.63563-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022154508.63563-1-sebastian.reichel@collabora.com>
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
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


