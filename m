Return-Path: <linux-pm+bounces-22563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8649A3E468
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DB73A2716
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5760A265CAF;
	Thu, 20 Feb 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qQyPpIox"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD42641DC;
	Thu, 20 Feb 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077917; cv=none; b=R6aRH5tS8ft1poMzwqtLvu6DLu3DjCl4LGwW7bsf2BwwfV/U6bk+4J0Tepl1FT8yZ5D3aOwWt0CxoN38g1a/Sa4zVO3eHoyBxBmtlfjm9A8dAYUlUmnxk7R02XGtKXrxAY1ctIPwaCv/fLMkfolpxhLHrf18jUxBnb5kNdxuPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077917; c=relaxed/simple;
	bh=wvIAJI+i4HZNVWYYxGJdrqYngwnW4qGYFAI663giHWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzAFG2SDnw1MpLuhdM1Usu+KGmSNxqWRiVHsnjHXY5CXWv/30VkpTYEdA9yWTrBnp1w0hlEO7DfI7AgBWh/9zqRjWYnbadd6l+ZyXAsnFBrQyRg5VCgLrqlhQ8LN/dYljsepGacU+sfIUVNHkS0uhOdxaIDeiRAHNLCmzjGTehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qQyPpIox; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740077913;
	bh=wvIAJI+i4HZNVWYYxGJdrqYngwnW4qGYFAI663giHWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qQyPpIoxgzy2FNYqeOlBs64+FG6DDYljtRA8bDwxluJ33EHKo67PFQp+QdV7HQZPm
	 LwSb+4D67G6LVXtmJr+surXdM2N4Kn8CI9Q1fPhiJSJyihr9rPx9lRKGutfFGinmpf
	 PXgMdYSNj5RQzsJqIKTkxw1pN3/ELBwtUqjPR/VXvmvHwOH+jX3gbAxURzeoVK+adZ
	 eBY1rzmjVS/sA1vepWq6LbNuoCzLS6WHIz9BwjYhM+dHFfXKsJ3DGxgidrKvdvD0RO
	 8UXOxB9GYWbYUgxQhzC9leyBrACe5ldNAamElvqIsmT90vYeygziAix1IG76rXsBNO
	 9AG+JPtpG/JUg==
Received: from jupiter.universe (dyndsl-091-248-085-196.ewe-ip-backbone.de [91.248.85.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5FBA217E1571;
	Thu, 20 Feb 2025 19:58:33 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0D8EA480038; Thu, 20 Feb 2025 19:58:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 20 Feb 2025 19:58:06 +0100
Subject: [PATCH v6 3/8] pmdomain: rockchip: forward
 rockchip_do_pmu_set_power_domain errors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-rk3588-gpu-pwr-domain-regulator-v6-3-a4f9c24e5b81@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3000; i=sre@kernel.org;
 h=from:subject:message-id; bh=wvIAJI+i4HZNVWYYxGJdrqYngwnW4qGYFAI663giHWU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe3e1haoFSV/5aQeWUaz8Vpy8SFKqIjcV2DF
 bnSYcqEi4L0+okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnt3tYAAoJENju1/PI
 O/qap1sP/jpd+zTf8V2WvUrk+nDNSci07OBxQ+NkbESdvzuvR/cGGEUYCkpZB2B89Ed/MJLmIk6
 ZzQLw0NQYbGPiRqTy8xM6m8zd+C0kxf6URp0igK69lKcB0nQKtU0GDtc8gpDkPnQuBhRlwfjnaQ
 acWhlUYNULlZvPCh8emd8IsHn0jzbtXH95Zvel0jC1ffQ21gmvZhnodF4/789CdHOdzP1hiedjG
 4GAzzes2bjQdpOp+r1AjhwONWVq5ftb3U3uCuxOnHHjUro9No+GWzYEKnnQ1RJTz2xJ+8yhx01T
 n1Dcy0vbGVa7CbeVw1bxyhjPY9utSos6te2lXvwk/I13UVW0TAuo4C8iBPbCe8CzGSlUHvOZkJ3
 nd3QRTMz2vLK0W9XdwGbEdWNIKiTrj/ux/kPHmGNdm9wmNK0QD0XaFzRhtXeugT9JPjYcWb88b/
 rtA/gl8q+ls960qz5hALSbjoDeg8oWEIrWR2M2Hd9yGX38Unty10GP2UyW5mlrDdKZTKcfhY1c+
 nC0uAse0Mp+f8BBzBtchk3TnSKsch8vYpH7JEkZEvBV/Sx6usmZq4eWTEJmL7RCzZ5SiUOi3esD
 +7ECP8U3+UFKgrBXb4bTuThLcKJlcRozr+vA7R77kzFWQJ9vTWTx9TsW+fdS+iAo0SQwGOghokp
 pk6E6XgrRpXoT/r6kJVo0sw==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Currently rockchip_do_pmu_set_power_domain prints a warning if there
have been errors turning on the power domain, but it does not return
any errors and rockchip_pd_power() tries to continue setting up the
QOS registers. This usually results in accessing unpowered registers,
which triggers an SError and a full system hang.

This improves the error handling by forwarding the error to avoid
kernel panics.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index a161ee13c63362ca8ee0f79090a2a8d4db18a591..8f440f2883db88e22fde7ed9b235982d3030416e 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -533,16 +533,17 @@ static int rockchip_pmu_domain_mem_reset(struct rockchip_pm_domain *pd)
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
@@ -557,16 +558,21 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 
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
@@ -592,7 +598,11 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			rockchip_pmu_set_idle_request(pd, true);
 		}
 
-		rockchip_do_pmu_set_power_domain(pd, power_on);
+		ret = rockchip_do_pmu_set_power_domain(pd, power_on);
+		if (ret < 0) {
+			clk_bulk_disable(pd->num_clks, pd->clks);
+			return ret;
+		}
 
 		if (power_on) {
 			/* if powering up, leave idle mode */

-- 
2.47.2


