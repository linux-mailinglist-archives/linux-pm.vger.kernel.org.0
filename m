Return-Path: <linux-pm+bounces-18931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8029EB79D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134961887021
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561903DABF0;
	Tue, 10 Dec 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NI/1oTgD"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B523A590;
	Tue, 10 Dec 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850630; cv=none; b=mHOwmtQrHqGrH9EGSQWx8vyr2GS2FVfUSKknGK2pj0P/eFE3TIFfhbbL8crzqWs3VpzhPUGP6TMR9pStJAGCq/SpxDmURMG/Et+SxWBYId+R7iucceMmemeXPdFnFLbn/ts7juAM3BSlqMl1ODcP355IMmhZ/6onNLI44kX3rD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850630; c=relaxed/simple;
	bh=fC0pCAo2XvTLTelwyvhpjGUBmtu099+nMxksrhgRHPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2VAcvP7JnognXpPCzk1UcV8Y745KUHyF8F10Y9Rz8dmG+xNDE4XOIoBUHLWv1fvZmhCbJ7KF+Nw4VYdItgR1ottX5Ljro9MetrUJwp9dUH5lmIHWLUrbCVQEZI0KuwYkqW44vmEzolC9so4VXKRFxfwtusfJMt6rIqmz+fRWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NI/1oTgD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733850625;
	bh=fC0pCAo2XvTLTelwyvhpjGUBmtu099+nMxksrhgRHPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NI/1oTgD9eclSLSmBpjWvcQ7SBog1PdkLqMSi/Z2ZL0DMagPl4vucz3CpSXR/YH7+
	 cSpoAGnvjOYu+sLhnBEi9Jh0IYzgQwDV+cT5BdqgOiI4cUVvFbK98nIk1NZhrFe7m4
	 RsAfa8q/JAejqidwh/L/Qk/siLpoECavedvWkeSYaiIX0v9qXlSZlPLET8dh2AzHyI
	 7VnZvQIr6g5xdVC+B613OQwJ4adHnVM68YRErMmz5Pzouk1HI7Vpb4j/kuP6E3awGe
	 Fxosm0HTdNmDRLWEvOzpj+ZX/YuCd7Z/SLu4Z/seJ3yoMmoy3haK0LJ0YEPjrbwJPU
	 gTvB3bIDdjuRg==
Received: from jupiter.universe (dyndsl-091-248-190-127.ewe-ip-backbone.de [91.248.190.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 214AF17E37B2;
	Tue, 10 Dec 2024 18:10:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A738548CC8C; Tue, 10 Dec 2024 18:10:24 +0100 (CET)
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
Subject: [PATCH v4 2/7] pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
Date: Tue, 10 Dec 2024 18:06:42 +0100
Message-ID: <20241210171023.141162-3-sebastian.reichel@collabora.com>
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

Use the cleanup infrastructure to handle the mutex, which
slightly improve code readability for this function.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index cb0f93800138..a161ee13c633 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -574,13 +574,12 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
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
 
@@ -606,7 +605,6 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		clk_bulk_disable(pd->num_clks, pd->clks);
 	}
 
-	mutex_unlock(&pmu->mutex);
 	return 0;
 }
 
-- 
2.45.2


