Return-Path: <linux-pm+bounces-40719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD52D1853F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A482B30670B2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511338BF61;
	Tue, 13 Jan 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L7scX0yx"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC438A9C2;
	Tue, 13 Jan 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302017; cv=none; b=fBlYOIDrHvMx4Js6WlT/B0HCcMAiJrOqdFgmJoa+/y3Axd16iTUNcsrIDwwYCeuwd8N+37MAsT1710SP6RHA5/6gIUbLtsg0Mw/796Bv/BwXOSG8Bqb5GPfhv3fSUuRer64UP6bF/kmMDo1pAVJJnXxXQ178btSZ4iPo49EGR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302017; c=relaxed/simple;
	bh=u65weYK7NpMKbZ0GoKI16YVgDU67PXN5aOx/v0oaUKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgcH0BvZE6NQFhVzTSIksHYBitKoASxqk16KfDtQFvxQRvI5nHAIsTja3w++7CizpCgej9+9ManhggwhAZrK6sqd8u8ZxHJn7sm8d1sC9gK5OJLisKDoK1pkDGGx76aDEZmmYkw38e7O/w+KBspo6bGeAAME0268Cpwtow5yJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L7scX0yx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302009;
	bh=u65weYK7NpMKbZ0GoKI16YVgDU67PXN5aOx/v0oaUKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7scX0yxN0bR06vP70FHOqwN1Ec6gq8GVw6fQVqQo6cHJkFDmL2Dq1nzzXAP4vIiW
	 J6EaSLLJtIVU38MGQpidFaSnEjJQpmTfKcUNEssmdmi3zsBM1sabNjc3c/CCmCn+td
	 ybWAHDM2+Hjev54IQexvRU1zhhZGktM17oO54Dxy264lp62ZTXWTHb/cDWGp35xWPs
	 xokR095qQhH239bfZX2HOjZGdk/rk4vbK2X0QCqSW1gl16Ia3fJDZmZRjjLttiltyt
	 XfFrZ9ofl/49B7dbIJGRQGXDxReefhG5ZOM8P+gYuMffpZsYcu/AnRwoZYl+I3ydrq
	 i/8aOpumWkxUA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C446617E1513;
	Tue, 13 Jan 2026 12:00:08 +0100 (CET)
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
Subject: [PATCH 5/6] arm64: dts: mediatek: mt6795: Fix issues in SCPSYS node
Date: Tue, 13 Jan 2026 11:59:59 +0100
Message-ID: <20260113110000.36953-6-angelogioacchino.delregno@collabora.com>
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

Add the "mediatek,mt6795-scpsys" compatible to the SCPSYS node
and remove #power-domain-cells (retaining it only in the power
controller subnode) to resolve dtbs_check warnings.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index 58833e5135c8..ae2aaa51c9ad 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -287,9 +287,8 @@ pericfg: syscon@10003000 {
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,mt6795-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
-- 
2.52.0


