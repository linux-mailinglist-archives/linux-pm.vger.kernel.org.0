Return-Path: <linux-pm+bounces-10278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2091DFB0
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E17A1C22660
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B5158DBC;
	Mon,  1 Jul 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOdNf6Je"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EA1865;
	Mon,  1 Jul 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837866; cv=none; b=N4yj7Mp5GgZp6w3F+cIbjmLLZJ3Znh+iKFoG+niQ7hYUdtQj+2gylN3ixZwqNV/i7P0f3M1t6QkT+XvI1oO7/zCpxjZbmw3g6AcJ5FUS/bwxEYuq+7CdDuKdqSF+5Or7pPCoJvDUnQzrDrIp+cSczZLKWmWLKBTFZ4EI4qL/b4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837866; c=relaxed/simple;
	bh=O8BXXu90uaFR1Jb/1zZyV9jZStuqATmFhCnlzHlMlVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TLqBa0dssM4+hq8gmezyXEnPXJvs6Fbb9Kt3w6+r3CR2lkmPxnEHTiogdo44RnGxZLDTccgSKDMre82FtfGKQJiIJ+XxdUJchDsayPmd5VHeOROy5WP37JT+J4Fpg50Mg4UYaHMo1UCo+z3+1Aohf2SeHPuEOeQx4sIkR5yWvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOdNf6Je; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-424acf3226fso23224825e9.1;
        Mon, 01 Jul 2024 05:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719837863; x=1720442663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9oUdv7urUmTInH8QMPbAXnIwXW+SLweFqKTOXeU2hk=;
        b=YOdNf6JeQ6TMWlOEfp6hONbEsyyrUz5X1JOfsw7gEUohbpyGlKD6SKsl8fmDYPLT1/
         iJosjALKCnYP4VF+TARc6IeSVupU76SCazgGeTbTyaDIDTXrl76levlut+zXgloxMciS
         s4IX/D2pnk9ie1hB4PMJxN/T4HBEgR0ytBSYflt6rNZri4Tbbu/ZTUxz0zh6WGbyX3AD
         7du5ytHsL2jw4zLgdPo/4QOM0Wi6hTVxY8wjMFUYynaRI0rYr87qJ7BuVz9lNEtW26uv
         hIwFKCqSUTIi6KEAV6bdWNeBFNWNrR5pk5pS38UTNFaPl1qgezCxIvAzjLv1QWKJcD7o
         nmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719837863; x=1720442663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9oUdv7urUmTInH8QMPbAXnIwXW+SLweFqKTOXeU2hk=;
        b=udSmaxXg/IC7UipoNMWizyIihUJrqr39AzGWO/QwKLHDKIP11pq9NwmlMtEerALcY1
         FVsZhnX9hvO+G3i6tMcHcE5N2LoazHPAkixmv01KsEPQy3zSdtQxO4sp68sC3mSIs4/K
         4bCuWHhwjgI2zK+Uaf1PbohGqxMkKmA8J0DTUMh14NOl6EmcLNxeRLJuhaELw0DEDfeT
         tOJRAkaIkY4xg9/SX8U6Nsk3LvbmnpAXtiKuqX+nbW7704Le7Hpo47ea1AYcmbnQP6Kw
         vYdUm08WmsD6j+PQPQOd7ywnEUjkQA2NJzZ55knweO+P3KhiKWpjRVCRribFdf4HJGMH
         9Zpw==
X-Forwarded-Encrypted: i=1; AJvYcCU7acRP2LOSS2/ryI54suebwoS//v6B9yKSCzngC6zlqRACou2coZaUsJm4klAyLoBCD+CqHUtJytXR3BA0UtvUlfTnbgDTKgTIFNLW14jJCl9jo4XNdK8xrW86+Lq1dwYyLSbYIADWTPpvkBDUOni1wsQ0q3xPjGOmkJ0Qnl6584g/3ArqLsyyC1vnnNGF8A28ltkUk84OU8WM
X-Gm-Message-State: AOJu0Yy55c3BcJHjc6dB3CbLcMDAFxFyrkfALGseTj2MqLU5GKj8GDvR
	omd7rwrSd03G9K/jU54ynuAOL1oeRgjEzVmbYpmutRpJdKWB/rWo/s0YsVrZ
X-Google-Smtp-Source: AGHT+IG/m5dh7OIdKUq1Jt30kdZeI3XnThzntipad3x9UGAxTUw1PaxNZ2+WOT85Dz5soydlYmB7ow==
X-Received: by 2002:a05:600c:4c14:b0:424:f2b9:81f5 with SMTP id 5b1f17b1804b1-4257a028321mr36950435e9.9.1719837862346;
        Mon, 01 Jul 2024 05:44:22 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:f55c:ea59:1259:5240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e16b3sm9921005f8f.61.2024.07.01.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:44:21 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	ivitro@gmail.com,
	stable@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v1] arm64: dts: imx8mp: Fix VPU PGC power-domain parents
Date: Mon,  1 Jul 2024 13:43:02 +0100
Message-Id: <20240701124302.16520-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

On iMX8M Plus QuadLite (VPU-less SoC), the dependency between VPU power
domains lead to a deferred probe error during boot:
[   17.140195] imx-pgc imx-pgc-domain.8: failed to command PGC
[   17.147183] platform imx-pgc-domain.11: deferred probe pending: (reason unknown)
[   17.147200] platform imx-pgc-domain.12: deferred probe pending: (reason unknown)
[   17.147207] platform imx-pgc-domain.13: deferred probe pending: (reason unknown)

This is incorrect and should be the VPU blk-ctrl controlling these power
domains, which is already doing it.

After removing the `power-domain` property from the VPU PGC nodes, both
iMX8M Plus w/ and w/out VPU boot correctly. However, it breaks the
suspend/resume functionality. A fix for this is pending, see Links.

Cc: <stable@vger.kernel.org>
Fixes: df680992dd62 ("arm64: dts: imx8mp: add vpu pgc nodes")
Link: https://lore.kernel.org/all/fcd6acc268b8642371cf289149b2b1c3e90c7f45.camel@pengutronix.de/
Link: https://lore.kernel.org/all/20240418155151.355133-1-ivitro@gmail.com/
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index b92abb5a5c53..12548336b736 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -882,21 +882,18 @@ pgc_vpumix: power-domain@19 {
 
 					pgc_vpu_g1: power-domain@20 {
 						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
 						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
 						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
 					};
 
 					pgc_vpu_g2: power-domain@21 {
 						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
 						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
 						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
 					};
 
 					pgc_vpu_vc8000e: power-domain@22 {
 						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
 						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
 						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
 					};
-- 
2.34.1


