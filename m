Return-Path: <linux-pm+bounces-13958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36419974195
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72F02869DE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F57A1A38FA;
	Tue, 10 Sep 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eYr0ZbDg"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9121990D7;
	Tue, 10 Sep 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991535; cv=none; b=f6NfHpC8Aue2TR4c63fgIsM2wNVnGOnnXdBabagjnR3A3OyfdJ/1k82qcHLg6366GeYvx8Sb3zHIUtv6QUY7whafLr1FaElUTsIPpzjDkuwpXyh2yIAi84qHrfBhDJex9hyc3Z18X8g3+ItR4ldaKJvD1325MlNrvV/6wF126bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991535; c=relaxed/simple;
	bh=ROdzEuOGTsp3a69R5UZV8M059Hc5ky24ugLlzZvsygs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eutk4VYrnVE1oVPupL9DGlgl5dfXfsdDw8OZoyq8/HXRRo0+J0a0CGpusTBE2XQ+Pd2dG+00KYNJGOhbtD0L54n0opE4SoNSspqeDDDOUHwpXC47ygwKTSN91v6p7KRKN82Z6DcYV7uJ9EEl+FFcioKmdebNmGvKjkB82T2sxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eYr0ZbDg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725991532;
	bh=ROdzEuOGTsp3a69R5UZV8M059Hc5ky24ugLlzZvsygs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYr0ZbDgCNWvwNy1Tm6DEd6qU1TrCZFW8Nap52sUy2bwHbQ/xI9M6bPDyJAExVsD2
	 9QzBT4qPGEQ9tNdR8u8Ig5XU5xEmnrYI2V1D0cCQxSFev8xAZoAP9Is9fJySiSU+o9
	 HS4+E5tf1mwdgZazm3tNyQASUHBrgTf3FLtNqlIrbOmPCBK7TYSqppu3H6Uy5Clxoj
	 /sefoFgb1HpVqRlMVfp+5Y9p2zwQYfVIIDF0rDRWo/HbAyE3E7RCV9h3NP/rfpifBl
	 43gPYSSEJ+VCwpyzDIM4797/+k2FZBQhCI39fOJ/cJuca4W1yrurqQ3P5q8UY0WyHY
	 7/HCe95mBDR1g==
Received: from jupiter.universe (dyndsl-091-248-215-127.ewe-ip-backbone.de [91.248.215.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D298317E35FC;
	Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8E1EC4800F4; Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
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
Subject: [PATCH v1 2/6] pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
Date: Tue, 10 Sep 2024 19:57:11 +0200
Message-ID: <20240910180530.47194-3-sebastian.reichel@collabora.com>
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

Use the cleanup infrastructure to handle the mutex, which
slightly improve code readability for this function.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 0f44d698475b..5e5291dedd28 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -535,13 +535,12 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
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
 
@@ -555,7 +554,6 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		ret = rockchip_do_pmu_set_power_domain(pd, power_on);
 		if (ret < 0) {
 			clk_bulk_disable(pd->num_clks, pd->clks);
-			mutex_unlock(&pmu->mutex);
 			return ret;
 		}
 
@@ -569,7 +567,6 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		clk_bulk_disable(pd->num_clks, pd->clks);
 	}
 
-	mutex_unlock(&pmu->mutex);
 	return 0;
 }
 
-- 
2.45.2


