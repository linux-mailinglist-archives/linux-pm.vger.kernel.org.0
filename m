Return-Path: <linux-pm+bounces-22568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A946A3E490
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E3917BB57
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B6267F4E;
	Thu, 20 Feb 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IVp9EtEK"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BA267715;
	Thu, 20 Feb 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077920; cv=none; b=AZPtcx6AD2ImFM8yBjGay3ScnqyZawPmvwBj3XGcV2YP01RyAALZKWmAvQ1Mmp0mxlm16oT6F8JWjMBYITbYKUTHNBeRzDpp+l0FfKVUbJ+vm54B5wXF3MkBV9SP4by0qXE6ZfZgNSC3Gtnx08UyHiCIKEAov1iW0zUnAPUfeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077920; c=relaxed/simple;
	bh=7o+OpRxIZPgyQla3O1ppJeGi5Iy50Gs9yFdJjgvgUAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVOzRgJ9jY7ptREdVzkf0ABYWwRFzo14a04aHkDuU8ga5x0rr66U87P6xf6FVX5+23fanENfcCIccyNfh2H6vml7oi8niR19rWDd9gqVKkcBpB90yYNomISz7z83O8qWwjiQ96SJ1X+ErG3fglKmmb/CMCvfyngxZnOjomSq57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IVp9EtEK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740077914;
	bh=7o+OpRxIZPgyQla3O1ppJeGi5Iy50Gs9yFdJjgvgUAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IVp9EtEK1EDQrXxaycMMOyjcbpc0kzZZ0nRjIu+Ws1l3EEloNNPlCMyptzdC0UIWN
	 NJI/GHuw9E6dJFdTT4hgYBNisc8yTRAYvsbLBci+y8jSlqm/caEA9TX8GbEGY/CzcU
	 OXuRQxpTA8ft7U30tLCDW4XUZhPK/8FNaLkDWmsaiSnnXnMj/BumJJ38Bqcb/69ggB
	 0FFQjGZNvCxN153tPUVbcxwMlvr6SafMmUpIZD1tnZBBQtwKH0YVF9vpjm1zz/YWe1
	 +sIfDh6poI049lGCy8jW4hP9+j7ISuWbq0eBjW231dkAQLKxXHxyM5J+ijgwM09ELy
	 Xh6p3WUKP6tBg==
Received: from jupiter.universe (dyndsl-091-248-085-196.ewe-ip-backbone.de [91.248.85.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0C9417E1575;
	Thu, 20 Feb 2025 19:58:33 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0FFA948003C; Thu, 20 Feb 2025 19:58:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 20 Feb 2025 19:58:08 +0100
Subject: [PATCH v6 5/8] pmdomain: rockchip: fix rockchip_pd_power error
 handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-rk3588-gpu-pwr-domain-regulator-v6-5-a4f9c24e5b81@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291; i=sre@kernel.org;
 h=from:subject:message-id; bh=7NJATNPXUxCHC9s2+sZNOuBbjuSPKWLeZvtfpT8pW1U=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe3e1hL4X+nbgMp1JEPrMdG3lhEIY/+KdiFv
 wG1olm2UyDAvYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnt3tYAAoJENju1/PI
 O/qaPoIP/0vjHTdhyezJwSEonLFUCkVFZgCpLgjI8o90JxV3bW2KdmwrYoKyTQpvvZfynFvor3a
 2ImPkFp0do6BIzTwZAIMmrrJTDRfAHwP5xCeA5Gc50l364C529mm16ejKsHI8S49zvjeLK9WITP
 vtvWeTCNIGG4YOqhYot+WYPXUAAZjBr+viSuFCLYlX7AVoPihACO+CsaBj4MPpdXoAjwlQfoMtz
 nIAczI/0f2HcLG1+/hHG53bjjf2DdAxuZ752q+viB+G6ZCYN2NR5T5ZsqAcNbwHtrz49hu//cjP
 3jsYpIFialmO+5OAgF6ITGmiIcY3+JntAz35ZSKcr5yTVRVLHy+yXOvBc1YPluEicgv52onY3H0
 PIQhEZy/PClqFlx4MOgvfKQ1mam2rzrCz+wKJhMMy0xG/xzjHvqx3uzXhzbYrZZ4w/qNtYBsiZD
 Nqww0GOtlV8AORBzmZCpv9YgGbPMZ+Z2tQAlHiG/8zg93ErLLzcdn+bXHHO3BnfwSpzLjCXkw1W
 dmwCCpUkJ9nXET2sjGZjRWUVM+ENNI9wsI2dVbI4Ixgcj6QdEhz28dCwMDZexZC8quY9ysuiLFa
 Gm0bStUfGK7Gi+x6J9hZyUZLp+LMwwrsWLiUJU+gY4hNwN57hnsKh9MnHPX5zYICecPbMu6Z9ud
 ervUTdkkKIoCeMbERLRQq5g==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Peter Geis <pgwipeout@gmail.com>

The calls rockchip_pd_power makes to rockchip_pmu_set_idle_request lack
any return error handling, causing device drivers to incorrectly believe
the hardware idle requests succeed when they may have failed. This leads
to software possibly accessing hardware that is powered off and the
subsequent SError panic that follows.

Add error checking and return errors to the calling function to prevent
such crashes.

gst-launch-1.0 videotestsrc num-buffers=2000 ! v4l2jpegenc ! fakesink
Setting pipeline to PAUSED ...er-x64
Pipeline is PREROLLING ...
Redistribute latency...
rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack on domain 'hevc', val=0x98260
SError Interrupt on CPU2, code 0x00000000bf000002 -- SError

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Link: https://lore.kernel.org/r/20241214215802.23989-1-pgwipeout@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index f4e555dac20a32978d71092dbe66cdd1226b8ac1..ac3f6e2080d1c3aa3d0b6fa60949c22a7d256bde 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -597,26 +597,29 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		rockchip_pmu_save_qos(pd);
 
 		/* if powering down, idle request to NIU first */
-		rockchip_pmu_set_idle_request(pd, true);
+		ret = rockchip_pmu_set_idle_request(pd, true);
+		if (ret < 0)
+			goto out;
 	}
 
 	ret = rockchip_do_pmu_set_power_domain(pd, power_on);
-	if (ret < 0) {
-		clk_bulk_disable(pd->num_clks, pd->clks);
-		return ret;
-	}
+	if (ret < 0)
+		goto out;
 
 	if (power_on) {
 		/* if powering up, leave idle mode */
-		rockchip_pmu_set_idle_request(pd, false);
+		ret = rockchip_pmu_set_idle_request(pd, false);
+		if (ret < 0)
+			goto out;
 
 		rockchip_pmu_restore_qos(pd);
 	}
 
+out:
 	rockchip_pmu_ungate_clk(pd, false);
 	clk_bulk_disable(pd->num_clks, pd->clks);
 
-	return 0;
+	return ret;
 }
 
 static int rockchip_pd_power_on(struct generic_pm_domain *domain)

-- 
2.47.2


