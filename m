Return-Path: <linux-pm+bounces-38064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45276C5E712
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DC774FEFF0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E6337113;
	Fri, 14 Nov 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gfGecciJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CBA2C08B6;
	Fri, 14 Nov 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139289; cv=pass; b=G6zOzRxSn4bfCclGJ+tDdbrMoWDIMSicHW53+BuegnjQqKqf1T1QTlBPR9lSsvZb/vm7/cnX06m6ueV8i8vLWkr1KrCGos+H71ULgM1AtBnGE65ozSDc84iDCyw5phu5KNWVAItqKgHosCwD5r6DJ885EHmhdJwnoiDVUt3HB9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139289; c=relaxed/simple;
	bh=gBlM7J2+FrMBLHdbWoAArHxLBQdKSdBw0Bhoqs7rBrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pb52LzQeCZocX4YhGXZPL5J4RLWKjY3Vu8frVke83jJ7kVoMpGxNZ6sSIt9lpjPgv2zlmAekHsVEXtrw8ztXBRRUQ3VioJMg2zHwC3jaGcjXWMQyymEra+7ViIFGEn2ivzJdBuH6XmnreyYMxyZdlhaaFjkRLBZ6MJhruyh75Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=gfGecciJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139272; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kIsqBtSo/Zatc1ZGc5M4q+Ujt5PykEskH6fTzFxPZ5U0fxFKNGv7LO7A3EZArpB7Lc1I7BNsMIiRKyWUgw00UfvbiGtcjR0hybeuBxIVK7d+EydLENx007HQOEbsuDQhq4zGvw17+auGK6943Lk64ngt9ahK/QHR6H2JzD2ex48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139272; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lypS4OCGKHljGBDBOhbks812Bl5TYzzffujcK7lKp1M=; 
	b=G4p5LYtTtNg2W9DSUAZA0EPkLQsZItbHulevCVmDgNDYOkxBe2pfrAdLNHbaAuXxyZET5JgY3Pc5a6kCzqevgQ/Z9OoyVCUB3+tUDXqP8FfMZrSpcca9OWsuAMOIC5+KNivof6qtgG86RYNtn+eXIrTlmRzigVNabSvbfcd18vg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139272;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=lypS4OCGKHljGBDBOhbks812Bl5TYzzffujcK7lKp1M=;
	b=gfGecciJzg0sNj1rJEzmpwUVBHoDY+Zz9H/zIw8A3E9qZD2MJHzVpBf3BfZ3hcT9
	szQrYIwODYJatRKSP3Efa2tXVQ74EiJfqIaZdKjUIGWhp/JzllhrNGB6ISjOp2gt3Gl
	f5+sizyoKFcQVsSDxRlTdAzWeUynWs83mXRiW/14=
Received: by mx.zohomail.com with SMTPS id 1763139271219137.1608638744043;
	Fri, 14 Nov 2025 08:54:31 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Nov 2025 17:54:01 +0100
Subject: [PATCH 07/13] soc: mediatek: mtk-dvfsrc: Write bandwidth to EMI
 DDR if present
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt8196-dvfsrc-v1-7-b956d4631468@collabora.com>
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
In-Reply-To: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In preparation for adding support for DVFSRC Version 4, add a new
`has_emi_ddr` member to struct dvfsrc_soc_data: if true, write the
DRAM bandwidth both to the BW_AVG and to the newly defined EMI_BW
register, present only on DVFSRC v4.

Currently supported SoCs will not use this, as has_emi_ddr is left
out from their platform data, hence reading false.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index 3cbccbb7469a..bf0e7b01d255 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -72,6 +72,7 @@ struct mtk_dvfsrc {
 
 struct dvfsrc_soc_data {
 	const int *regs;
+	const bool has_emi_ddr;
 	const struct dvfsrc_opp_desc *opps_desc;
 	u32 (*calc_dram_bw)(struct mtk_dvfsrc *dvfsrc, int type, u64 bw);
 	u32 (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
@@ -107,6 +108,7 @@ enum dvfsrc_regs {
 	DVFSRC_SW_BW,
 	DVFSRC_SW_PEAK_BW,
 	DVFSRC_SW_HRT_BW,
+	DVFSRC_SW_EMI_BW,
 	DVFSRC_VCORE,
 	DVFSRC_REGS_MAX,
 };
@@ -292,6 +294,9 @@ static void __dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u32 reg,
 		new_bw = max(new_bw, min_bw);
 
 	dvfsrc_writel(dvfsrc, reg, new_bw);
+
+	if (type == DVFSRC_BW_AVG && dvfsrc->dvd->has_emi_ddr)
+		dvfsrc_writel(dvfsrc, DVFSRC_SW_EMI_BW, bw);
 }
 
 static void dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)

-- 
2.51.2


