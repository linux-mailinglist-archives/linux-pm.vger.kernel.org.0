Return-Path: <linux-pm+bounces-40726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5D1D1850F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBE343036C76
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338443904F3;
	Tue, 13 Jan 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eB/F/bvf"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6738E136;
	Tue, 13 Jan 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302022; cv=none; b=XtV6xU9elX3DTxAEtxFMVSlqs55GhMt+GMeXoQbnMS/RYQ/puKiOQa4JCncSpkXKgflsvh9vl6YrC6Cf/8LqEsp4Jh/8L2r5Ox0xq9pimGe953pBCizdCC0fiYepjPMKfJ/Bkgm63DmDmV7JgiW/XSQhg5AeEIcMNHk/5Sksmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302022; c=relaxed/simple;
	bh=P8yUfp90P4V0tRkcOJdc6UzTaZTjo0W3uSd4T2juM4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYcQ0HvDrPx4vSEiZl9/PyApVIZkLB/T1eDBuKpYsOo5dhMfF78WXZ+irCaIaURn6u6zJ7LfCjb1ph8umbxh+xzUiENEJFBdpXkBN/bR+nx2pT7b+EzsSvgF93S256XFInrggBADWwRPD20vkqM0rkVCN1JI5GTqHCIbO2nrg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eB/F/bvf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302018;
	bh=P8yUfp90P4V0tRkcOJdc6UzTaZTjo0W3uSd4T2juM4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eB/F/bvfbe1aMzl7d7zwOd4lyiJAJlsoUvtgQ5gnhy51W+hNBjgIVbpwJxWRf29S/
	 L5N5U54/Kec3NjwuqJmifhEe9fKSWLR1mw+s1KSfJbrLMR+eDqnpT1lg/1XLiY7Xib
	 An0NrxP4yOTtYiuvtJpRjaEexNwOdzE5t/dHOM9oK+UaKYAeotBiOUh6cceNCPG77H
	 wGSF9J15ZnmuMgiPfHgiMC80IeQIu0yzjjhzJkxypbwev4vToFRzPEN/Nl28nfsOQF
	 eN7YCwgr897MSdaUgNAdXXjfIci5+3z7P7f6tyzM7e0OQsfhWHFDuU8l3yHr6KLFU9
	 id6Sfw5thccoA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D504817E150D;
	Tue, 13 Jan 2026 12:00:17 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 5/5] arm64: dts: mediatek: mt7622: Add missing power domain to afe
Date: Tue, 13 Jan 2026 12:00:12 +0100
Message-ID: <20260113110012.36984-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing MT7622_POWER_DOMAIN_AUDIO to the audio controller
node to fix a dtbs_check warning and to make sure that the AFE is
indeed powered on when needed.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 133a6dcc8ef7..bfd96a0ec3dd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -621,6 +621,7 @@ afe: audio-controller {
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>,
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-names = "afe", "asys";
+			power-domains = <&scpsys MT7622_POWER_DOMAIN_AUDIO>;
 
 			clocks = <&infracfg CLK_INFRA_AUDIO_PD>,
 				 <&topckgen CLK_TOP_AUD1_SEL>,
-- 
2.52.0


