Return-Path: <linux-pm+bounces-13961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E197419F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B89286B19
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F81A4F2B;
	Tue, 10 Sep 2024 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aQ3LBe25"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95A1A01AE;
	Tue, 10 Sep 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991536; cv=none; b=Bz2RVbwrT3GgJLIAF7Y/WIKr0rhaOKdJh8NT0cNjbFkfoVa2nPCQcsDPFMl9uR7CH/9NZucnoP2LZbKp3/siTJPaoJkNxqQPPKb8ZEv2Ic11h5QDd8LwcFZ52miTCIPg8ONm3lqidEWAHCz+YUeZsX0gKiOApxsq6vTzK6VsxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991536; c=relaxed/simple;
	bh=Je1FHMLQZVb6pynDmX5z0/KiXmKexwWWB6JfVjr/pn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrO6r21lFN/1N5Vky5gT8Em4YF8Mgu/5wMIy+vyHo1TRcSe4tMCBtTmO+GaTgfuwg1oaCgYxAFrUk0V5LWTqRP08yHjBdlXVQlBmahwEihhhjB35NSTanNBbdETTMG6lNoqyCvUfBEWlYcW/4iKwDY8+MCGoooSYI6nCzs2AM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aQ3LBe25; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725991532;
	bh=Je1FHMLQZVb6pynDmX5z0/KiXmKexwWWB6JfVjr/pn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQ3LBe254vT0U9W9y2BvvsOx/vlsWxT1qwH5pDak0czgIj8EHaW+ETvwW3FUCy8iL
	 AuPhed8aEjCYrg6NnSsqc2ecq2u8KZxIgvI6uobpCfVrNLHuGEemfHbckgyL6tL4Sa
	 8u/2hB8H3GQlD6cwEIiDJS+auTz6Ez6Jp7PTkO+5UQpyMUGVx2TWKGHRJExZV2hpdU
	 FZ43YG5BQhnRtHzmuXAgpo1O0W5DmWhVpiQxw8O8hfLGCU47teEyWperRHj9fM8UpS
	 HIU6NSubjhpXppNuvSKNdZewRAeSU+Uk475rgrR8Xs1rpTKApTDTGqlIQikLyBCfJs
	 P8467nPtVK4UQ==
Received: from jupiter.universe (dyndsl-091-248-215-127.ewe-ip-backbone.de [91.248.215.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D465617E35FF;
	Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 900774800F6; Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
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
Subject: [PATCH v1 3/6] pmdomain: rockchip: reduce indention in rockchip_pd_power
Date: Tue, 10 Sep 2024 19:57:12 +0200
Message-ID: <20240910180530.47194-4-sebastian.reichel@collabora.com>
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

Rework the logic, so that the function exits early when the
power domain state is already correct to reduce code indention.

No functional change intended.

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


