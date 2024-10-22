Return-Path: <linux-pm+bounces-16235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC189AB260
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1DF1C21A00
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852021A3BC0;
	Tue, 22 Oct 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ja9imMJ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674519ABB7;
	Tue, 22 Oct 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611913; cv=none; b=cSZN0XmL7kZFY/0wNR09YG2/8J8S7pJUnzrAmBvGCqe0hgW+zxxY7N3V/iblfGUjVrKNcVYX2V4NKjWem+a4sp5qDzNAhPrrpnrTTnJKOKLc7lzLq5DLs7WoyUMN5nJ1Ijxe+DZzbZ4RndaxyUN13MDNyLtzfWiwam7kP9ufdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611913; c=relaxed/simple;
	bh=fC0pCAo2XvTLTelwyvhpjGUBmtu099+nMxksrhgRHPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmVxi+qF+lRxoqASz5aKbMLCMymcICDZuEwFBUbjwC/xIFFMRqVyHi/A1jcgpf2p7GYc6OLT3NfwFRVVnGMDSSZdJ0bYsrOh3jaDBqYDjHcUM4PurlcgviHbs+oramgQWOTRjaAAyB8H431RWl72wcGEEoVZ3cPgIV3KqoodB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ja9imMJ+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729611909;
	bh=fC0pCAo2XvTLTelwyvhpjGUBmtu099+nMxksrhgRHPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ja9imMJ+elCRsbzxDyBlRoZnwAByzcNQmFMh2KAfgYZ9UGqb8kKDNWEw524a1XtC5
	 oInk7uRf9N1Iqwh3KwWkLtARtX//M5m64qAbkuzNtcZlrvEervIevbR5AYRsDGxEGX
	 fV/M6RYNRXDugoGHGMu2mCH7ZYl2/WZwlyyDko2eD8/RalYq5l9nNuYznE9iFPVSLf
	 AtSmiDSfhJoC3c2uKgb+kpK+Nx8kTqxM9KH61PJ6paom/n7LlMmqWjuqxt/yT+PIiO
	 dOgpZvyHd/fWWs08mfOb0W35WUlY1TkYtaxN3ee4FtWSh68peq1niQXvZbVGUS7TEu
	 HMm1raUMUBXIA==
Received: from jupiter.universe (dyndsl-091-248-085-026.ewe-ip-backbone.de [91.248.85.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B3E6217E3664;
	Tue, 22 Oct 2024 17:45:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 67A4B4800F4; Tue, 22 Oct 2024 17:45:09 +0200 (CEST)
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
Subject: [PATCH v3 2/7] pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
Date: Tue, 22 Oct 2024 17:41:47 +0200
Message-ID: <20241022154508.63563-3-sebastian.reichel@collabora.com>
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


