Return-Path: <linux-pm+bounces-14448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A08D97C6C1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FA0285A55
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A119925A;
	Thu, 19 Sep 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SKOUz0r9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAB199240;
	Thu, 19 Sep 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737520; cv=none; b=P4gZl9insRQwqQ/VcJOu5NQo75jDOVDyj5et99D9HDwLZrBTws/+rphuJ3YmTgAWcvQvONTXVeH+NUb4t3n5BG8Y6C0ngBwdQPt9Bx/fkLxB/jYWHEk1dUItQ/19AmVUjzwTdRiLKDHmGFo5boKWRRKmbLUv2NXSeN/20mcnhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737520; c=relaxed/simple;
	bh=Vx9E0NW09bVtjBV5lKfEh6WBcSKCDD7TcmzItk//06E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJfPeRYh3OM29EOBZqZRx5+uRlrVXoxxa4v2/wsfdlG4RoCCtbQFIgqQ3qIG2H9DELnR1AMSSb2XtupISFiN5eHfa8M2saGHeqmW9XqzeO4xXgX99OAAXT1ZpWKaLMEKcly119a0IhuqLu3fSLiBNG7UVsSJy6VKTFkuckUjtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SKOUz0r9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726737516;
	bh=Vx9E0NW09bVtjBV5lKfEh6WBcSKCDD7TcmzItk//06E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKOUz0r9RYvKKUufZKS1qPQyag/Ytz82TxUpll710o+RkjFxibx0os50ztCNhxc/B
	 JlyW7HhfTFaJgP1JLSRhHGexhWuSy8jTOP0S2YdMIeSRlfjfyKqDIXpaxx0Ma0qskC
	 46IKaUNUcOG93o45ZFaoEeUU52kAzLEsE/y587YgiQTymr2B1bNdpG2e6/yMKF8ven
	 1C05cdY1O+/m5cnBMHrs8n57ojNOLmYBiHT9VofpGhYMV24c1PC/J4BTwuvBLhJl+U
	 jb+ILnSJ+NMCd8sTh2PURFv3c1fxF97s/hl05dgT2GvOMne8HTysvY8AVXwsv2mQTN
	 XevkQSNoH1gNA==
Received: from jupiter.universe (dyndsl-091-248-208-160.ewe-ip-backbone.de [91.248.208.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8E6B217E10AE;
	Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 582B5480075; Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
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
Subject: [PATCH v2 1/6] pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
Date: Thu, 19 Sep 2024 11:12:42 +0200
Message-ID: <20240919091834.83572-2-sebastian.reichel@collabora.com>
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

Use the cleanup infrastructure to handle the mutex, which
slightly improve code readability for this function.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 9b76b62869d0..4f7021f47261 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -529,13 +529,12 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 	struct rockchip_pmu *pmu = pd->pmu;
 	int ret;
 
-	mutex_lock(&pmu->mutex);
+	guard(mutex)(&pmu->mutex);
 
 	if (rockchip_pmu_domain_is_on(pd) != power_on) {
 		ret = clk_bulk_enable(pd->num_clks, pd->clks);
 		if (ret < 0) {
 			dev_err(pmu->dev, "failed to enable clocks\n");
-			mutex_unlock(&pmu->mutex);
 			return ret;
 		}
 
@@ -558,7 +557,6 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		clk_bulk_disable(pd->num_clks, pd->clks);
 	}
 
-	mutex_unlock(&pmu->mutex);
 	return 0;
 }
 
-- 
2.45.2


