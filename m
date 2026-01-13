Return-Path: <linux-pm+bounces-40718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA0D1852D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47380301BB38
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF338A297;
	Tue, 13 Jan 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GP7Gpq/T"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599E38A9B4;
	Tue, 13 Jan 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302017; cv=none; b=iZVqjxWn5Bbi2qUTbd/TzFA3AKwb0WMB0XC5n6E9gL/perIvwPiPM+0YCELFOy2A47HwxoswAXTGGiaDgiETrphAb5gooWL8xn1KInldcvqF3JjDojfkG6xhtBkngxDcHay4MhJxlJraDqc5BkhDPvD8hNzbAfjYLB6lx+6U6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302017; c=relaxed/simple;
	bh=iLu8EGpNwMkDHk5AQxeZ6JfBZx9ZLm0ms2K34WntBDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaMKQF2xR440Gdwr+4D6pirS38o58Pgt0SL7o2odpBuX/mhxczTVeXOONHjqfEIigbMreN1mCNicupQT/Mw3jqRbIORJm9qsM10F1i32SxvoDBShu2whtjH57w8NwxSC2X9D+Y4CKAV9MGBx9xLG3l74q2MsiDUxQ/eO7BVV+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GP7Gpq/T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302010;
	bh=iLu8EGpNwMkDHk5AQxeZ6JfBZx9ZLm0ms2K34WntBDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GP7Gpq/TXzFCpuqeTMj/2x1hk0ctvVMUF5PMT1wIWdkEc08dF1DEuNCmodjTcGCWW
	 JK+aMMC9Yj4TmoLWjkjmlAD3c8uDGvDGn+vUPUtNH2MVd+gDH1/9zUtUHpifMOUf1S
	 B7r90d5BViySe71qS8MNd07+84BTKIT0XQ3U9ALURrOOyF1K3v/ykjOUW49I/ZaTCM
	 E+TJBJqA7tVidVHcY3DFECAj+20hzyprrHqfyuderRanu8eTN7U6ALMttXjTC5OAUm
	 ktLGN2QL0+N+v8CYEDnYpM5Pv1Au0hJn0CDKuWv3bOLC7U422w7ATOzfdjsPUfEFV4
	 EShM3N31te2Xg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9922C17E1520;
	Tue, 13 Jan 2026 12:00:09 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sen.chu@mediatek.com,
	sean.wang@mediatek.com,
	macpaul.lin@mediatek.com,
	lee@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 6/6] arm64: dts: mediatek: mt6795-xperia-m5: Rename PMIC leds node
Date: Tue, 13 Jan 2026 12:00:00 +0100
Message-ID: <20260113110000.36953-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
References: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT6332 PMIC leds node was named "mt6332-led", however, the
binding rightfully enforces using the generic node name "leds".

Change it to the latter to resolve dtbs_check warnings.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index ecd13d089ceb..0e086dd487d9 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -507,7 +507,7 @@ &pmic {
 	 */
 	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
 
-	mt6332-led {
+	leds {
 		compatible = "mediatek,mt6332-led";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.52.0


