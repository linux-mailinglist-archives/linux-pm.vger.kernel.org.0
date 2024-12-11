Return-Path: <linux-pm+bounces-19022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD79ECE9A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 15:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC90166615
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0387C17BEBF;
	Wed, 11 Dec 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ISKQSsTX"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8313C9C4;
	Wed, 11 Dec 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927449; cv=none; b=TOhhPlie6+9jFIFYRXszlEZYGiioCxtQLFgdd+rXbBu7iZC1KnWYRzkPzqXeom0RrYkE3oZ29Cfl92PNT/fF++gt0EhiBBpvEvKxqMBnmM9lt2ZfFFDjJ2siWdLE24fqIMmkTZZUYRU0y0fsiGwzzb705cUOIxoCtneulU/CbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927449; c=relaxed/simple;
	bh=weUMWJ/yGA2zkBAFFHf1vfM+l7pVZFAl+UVEBLx7Q0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql0zDxh0x518FDI518G9zp2qjNC60nQZZP9SBd63N+qDybkkrqeiezIqKoi/XYRTrpbytzyo9fTyWdh88Da0bWcfPPcES2RXTrk41ery4lgdbpOS9MG0lKD0UQQYiBoWY7dO+hTQyOgXwnXWAnDSfxiwYq1IZucHuVsvhxQe3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ISKQSsTX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733927446;
	bh=weUMWJ/yGA2zkBAFFHf1vfM+l7pVZFAl+UVEBLx7Q0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISKQSsTXM0KIZULPgEUYCY8nXS+o9oxQZnhwt+2ykw5kn8VTFvWRyfPXN9H6LJe3s
	 ualoBk5PG/grnkP7GUfH4cJR2HzpXGo3qXQJx6dhE1w9ur4YrWUWn2piQLJkDKkh1D
	 T1Bn8TuUEc2WYvPnQWQuAeTFRPSoD0kAOl7/Yx86fK8o5YKjqUG9DL7SCXykSPqXgc
	 BWvao6sz3+7yr4Qa47/1y4pDTDRjRdXvz1LFT2jmxDjy2buNT8efzFF6MM4CnDexxs
	 lvBk78JbvuiJaxyyJJs6GEr6Ke8ajpxYOFB9HhZpwy1dY4hdN5IplnKvIsoAvM0eTC
	 6G6OIGQNenUKQ==
Received: from jupiter.universe (dyndsl-091-248-215-089.ewe-ip-backbone.de [91.248.215.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 457D517E377D;
	Wed, 11 Dec 2024 15:30:46 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 79DCB48CC8C; Wed, 11 Dec 2024 15:30:45 +0100 (CET)
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
Subject: [PATCH v5 2/7] pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
Date: Wed, 11 Dec 2024 15:26:47 +0100
Message-ID: <20241211143044.9550-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211143044.9550-1-sebastian.reichel@collabora.com>
References: <20241211143044.9550-1-sebastian.reichel@collabora.com>
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
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


