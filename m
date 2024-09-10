Return-Path: <linux-pm+bounces-13962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE289741A1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD637286C73
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638A1A704A;
	Tue, 10 Sep 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i/8jHUS5"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BF18E021;
	Tue, 10 Sep 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991537; cv=none; b=akBbZ7XlgkpCR6akXUKGu0ObSrBmxelNn4mVEpjWBBZuSx2lqiOqsJ+IXUzSG3YlXb3qHC7Pmxz38tfbs4OEB1RtNk8/zqDOelINOA/9Llz913rkvPl2ifl0rC6zPRVxpna1dn9dIoCL6WwoaktJK90G1wXMlMq+3AkfYl87UmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991537; c=relaxed/simple;
	bh=MeN1i+aab0NQ3JQYuaxoKtvqWnyl4os7c4ARpZBGstw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6UYGltQsJvWDR2aN6NvhEm9VhZrrr6WuDB27ypJtWIDgmwFvXxbVS1sx2TeS9zZaHcI6ngDwGRtxfkQtnMMnFBBPGx7tXLIvv21Ye+nzpwrfpEvkTAqGCkVVZa3VZFN0kYyNW2mwO++M7hGT0t7va2rPq8pHVfYuD3qW/1mvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i/8jHUS5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725991531;
	bh=MeN1i+aab0NQ3JQYuaxoKtvqWnyl4os7c4ARpZBGstw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/8jHUS5okXgNF3JAi1jU6cygrU6Opm/B80l6yR1Sw9wzOW12AHMZe2nUloYKVls0
	 RX0sfj8KWEdmA4oQA3sf8APJZOjKixPYMeOexlE2C/WH6StB71OJLT2wTgAHZohvWN
	 ZpB2jHBTxnrzA3iZyG1ZZizKkKkb0aUCCkqxsWN1iBfMJZ352ImfxYhUd4y2KPKP/C
	 lSCMhExjqPNUpKJdfgLZR9IRDpn6hRUfZhzxRp3mvm4tCP5gSywZdk9eQ3XWoLax8z
	 1GVgSRPoNlTkvI7tonujtNsTkKVux1HbxLanySPDiccaI09rUmVGsc7sBvOhLIWHKf
	 VJMvN6SrZzzsw==
Received: from jupiter.universe (dyndsl-091-248-215-127.ewe-ip-backbone.de [91.248.215.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D192117E35FA;
	Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8C3084800E4; Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
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
Subject: [PATCH v1 1/6] pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain errors
Date: Tue, 10 Sep 2024 19:57:10 +0200
Message-ID: <20240910180530.47194-2-sebastian.reichel@collabora.com>
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

Currently rockchip_do_pmu_set_power_domain prints a warning if there
have been errors turning on the power domain, but it does not return
any errors and rockchip_pd_power() tries to continue setting up the
QOS registers. This usually results in accessing unpowered registers,
which triggers an SError and a full system hang.

This improves the error handling by forwarding the error to avoid
kernel panics.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 35 +++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 9b76b62869d0..0f44d698475b 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -488,16 +488,17 @@ static int rockchip_pmu_domain_mem_reset(struct rockchip_pm_domain *pd)
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
@@ -512,16 +513,21 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 
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
@@ -546,7 +552,12 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			rockchip_pmu_set_idle_request(pd, true);
 		}
 
-		rockchip_do_pmu_set_power_domain(pd, power_on);
+		ret = rockchip_do_pmu_set_power_domain(pd, power_on);
+		if (ret < 0) {
+			clk_bulk_disable(pd->num_clks, pd->clks);
+			mutex_unlock(&pmu->mutex);
+			return ret;
+		}
 
 		if (power_on) {
 			/* if powering up, leave idle mode */
-- 
2.45.2


