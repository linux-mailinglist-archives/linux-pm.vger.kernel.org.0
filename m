Return-Path: <linux-pm+bounces-22564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8E7A3E47B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DF61883526
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAAB265CD8;
	Thu, 20 Feb 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RMPQ8NxY"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3C2641DE;
	Thu, 20 Feb 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077917; cv=none; b=AcEoL4gvmDR6LqlryAZ1S1uNprLp6UcmqWsrUhz7nm3YM5KkJu51NtSZdQhj8uctpS2jjTtvle5DTifb8Pz2I6Ad3FepHErk4DNVmxPHcqXQpwnzv3lSEl6IgMQYXyzJXt1XmmkaWZjZrir3klkEFJ9vDlQSWkVmrdmxR83O6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077917; c=relaxed/simple;
	bh=b/2SnrTHVsQJ8AcXUtfVUyoN3MTuFOMma2+Z9/HxMzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3cwEaypscvmh8U17WulbSTedcleg9Hu/PcjdUV4G8jdXHrQNAXzilTV6DNN3FeGXjmh5RnCqHnwDtrZCWx6hBILv9/zA1YZ4ot4OIe7jhO3IvsGn6NC3U45xKE52HIT0MhiJqOcwMRhhPMIk4fzf9kMTrpWEb6yI1vgAbjn9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RMPQ8NxY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740077913;
	bh=b/2SnrTHVsQJ8AcXUtfVUyoN3MTuFOMma2+Z9/HxMzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RMPQ8NxYPziX6JPCu9aJTDUQx0ZuFTKwBUJmChkhfgLM5cNI2OycXNvRoSgj9TL1n
	 rtcOuiFvTxdJahWTGQZy+xrvmH7ChG1dAIqNUVUB5lUd9F4p3E6CJGpeCGWS2WlpLO
	 x7C/vB1qzZ1Dkmx8EiQA3xxEyHi+5vYRtCSvpkWztupbYgMwJWlKsUrGlIsGyBPhHD
	 f1+OgK1aBUiI2f9eROKDA/wr7IlE32ToFuAJVAbmkIGpgnY8G6e2xiBL2ztm0HN2hm
	 Om5nDbiTnOJOl+fE6J5ZA2EbGAoG2fc1UxvZPp38IJPFa0+k6h3ZRtk183LgTurkoC
	 Ae9/2lRnfxlGQ==
Received: from jupiter.universe (dyndsl-091-248-085-196.ewe-ip-backbone.de [91.248.85.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 60E9117E1572;
	Thu, 20 Feb 2025 19:58:33 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0C6C4480036; Thu, 20 Feb 2025 19:58:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 20 Feb 2025 19:58:05 +0100
Subject: [PATCH v6 2/8] pmdomain: rockchip: cleanup mutex handling in
 rockchip_pd_power
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-rk3588-gpu-pwr-domain-regulator-v6-2-a4f9c24e5b81@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=sre@kernel.org;
 h=from:subject:message-id; bh=b/2SnrTHVsQJ8AcXUtfVUyoN3MTuFOMma2+Z9/HxMzM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe3e1gCOsfx+eKTwS4JKtRAfv6m5LqpIOJYM
 aLUJwTjS7Ey04kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnt3tYAAoJENju1/PI
 O/qa1JkP/A/mucKd5UTnEFrBQ6IbiAE19wyc4pStxQ+CXOHXUjOOnXPq4kVO7EQ3SuXCR0GkzPu
 qD/WBwYGpNfzWqWWgDtX+8AuVklCX23Cf9IQxdHZtmtnDpUr15Avo3R6EsLsa+oBUJ4XgF0prkV
 V1BByYlG1kSyCIP+9dl+PvrAHUxvaXtklD3LekiZWf0xxAC3sc/9wOv7FKQ/zEfQT6kXfncXXWp
 9J2F0pP/jbZWf24Xzj+jurtkfhnBSj2q/FovzXjYkvN2rQjnbyTRIDTflyIqWoo1JNF7VoveD3P
 sM42Dr9u9B0sz5Qyj+KGMgoMuYn8a+V495lcauOCdEeBfNQl9vPWTCwg3DJMq08U7KHDBFY0FX+
 i0eo0DU5M9UcVZsYHQaGPaIhSR1agP3UwYW3bubAHadhKUtLNldEaZCi0iY0uphxRJ7EiW0EeSf
 00qVs38G79n4pl0VheemG3p2btRmfos+RPz0KMLWpCazlLQAO+QkOZq3EOKumSK//qgoqajd38e
 lqoeSUhvt8GTxrrVe7jt7EVldabX3cNARBTJ8sCKtQl02lSoWQMQoSdF5FI6Zvgfnrk0wHIWWTm
 SD4d5uDqnmz4ylm8p9zR5/RA956Dth8UVaGQYoxgXsiwUE+7PSjSdMF8d3LX9Rkq4YM2hkSqCpa
 TSUt/HJFOA2j9wZ5QmPQ3kw==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

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
index cb0f938001382fad302ccaf6f3959f5ee4dcbb8a..a161ee13c63362ca8ee0f79090a2a8d4db18a591 100644
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
2.47.2


