Return-Path: <linux-pm+bounces-38444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9CEC801DA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 445E3347B8F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF12FD69B;
	Mon, 24 Nov 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="UL/OfK1+"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D12FB0B4;
	Mon, 24 Nov 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982453; cv=pass; b=p02KmhPusUZywatG+TUA68tn9fC2tb2qgWq/or83cXedZZF6P0HxhIlHBbj/HQP9vqqiT2c89EHCDOjzcwLLp4jLXl2IUF0zKqdW7NvT1WwITMYcFsVsZFNyw0NDT4s32P1OQR5T/tjHla91Gw//uAomvYJEouA3Oetk821V3p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982453; c=relaxed/simple;
	bh=YCzXdLNuiZJ8bxvj5S57gtpR9VUoiBQJnwsZH0XY5jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmFFAHXdw/q3ZWL/Omwn0kDYuEbCgo4Rvz+37SPEQUWVCOtDyZfrBX0EuN8gHXEJ4157Ak2kJDGCH7CnM4Db2jWcl7Brj95uWjAb+hlYrZXkHZ6cx77ZWalzzEXA76HvvLOK9Ir3Ub2l1kE8JGJUIuNSO2U0N2Aew8+O3IfCJKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=UL/OfK1+; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982435; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UD0Wb+j5c6m/0ShV/FUC9GVDFrHSx0YYSY7Ziib54ppZ2bsLBPL3Mqf3eVEemtHEIzViarboarRGo6uHGkP2rpG2ZZev5HJ6Bf70LEL1Lj4Prfcpf3SgEZcPfmayA6UA2mjxRsNdLXX1owUt8kAeUDU9rUo22OQpDRJPX4xAU3g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982435; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kkFPhvnssFwdabScSzVUBJl7AWvF4qJiRWBgEepccCU=; 
	b=cLxqs0eQDApWct70qGZj5Nq0AN/rozNzHM9+UHr5gxQSQ2wnWlMEh+gfo1GinpDnZGL5I+xXLN82Xpxqdme1QOKnZPphabPYUJidrKE81xfsq4645UxKBtUP9q8xlqAVDq/caLvaByblv+h4DlLAlMrqA0coUrtFNfHr54XGim8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982435;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=kkFPhvnssFwdabScSzVUBJl7AWvF4qJiRWBgEepccCU=;
	b=UL/OfK1+YmvySUgeXnPsXvTKBW33wn2MXm86Q2idLyojW/SEm/LIzgl6MsCati72
	tkWCdRkyPXSOAiANpou+h36/mrjCJltyBBgxUW4RCHoGY3zmSQWUNykmkHoVvcgQuzP
	gVQTPipILgOBHFHOz8EJ6WPKsUNlpoAlbP4bV+g0=
Received: by mx.zohomail.com with SMTPS id 1763982434008998.6034952190819;
	Mon, 24 Nov 2025 03:07:14 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:54 +0100
Subject: [PATCH v2 05/13] soc: mediatek: mtk-dvfsrc: Add and propagate
 DVFSRC bandwidth type
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-5-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
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
mtk_dvfsrc_bw_type enumeration, and propagate it from specific bw
setting callbacks to __dvfsrc_set_dram_bw_v1(), which will use it
to choose calculation multipliers and dividers in v4 callbacks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index 7708b07ab2d6..a684e405daf7 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -36,6 +36,13 @@
 #define MTK_SIP_DVFSRC_INIT		0x0
 #define MTK_SIP_DVFSRC_START		0x1
 
+enum mtk_dvfsrc_bw_type {
+	DVFSRC_BW_AVG,
+	DVFSRC_BW_PEAK,
+	DVFSRC_BW_HRT,
+	DVFSRC_BW_MAX,
+};
+
 struct dvfsrc_bw_constraints {
 	u16 max_dram_nom_bw;
 	u16 max_dram_peak_bw;
@@ -268,7 +275,7 @@ static void dvfsrc_set_vscp_level_v2(struct mtk_dvfsrc *dvfsrc, u32 level)
 }
 
 static void __dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u32 reg,
-				    u16 max_bw, u16 min_bw, u64 bw)
+				    int type, u16 max_bw, u16 min_bw, u64 bw)
 {
 	u32 new_bw = (u32)div_u64(bw, 100 * 1000);
 
@@ -285,21 +292,21 @@ static void dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
 {
 	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_nom_bw;
 
-	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_BW, max_bw, 0, bw);
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_BW, DVFSRC_BW_AVG, max_bw, 0, bw);
 };
 
 static void dvfsrc_set_dram_peak_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
 {
 	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_peak_bw;
 
-	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_PEAK_BW, max_bw, 0, bw);
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_PEAK_BW, DVFSRC_BW_PEAK, max_bw, 0, bw);
 }
 
 static void dvfsrc_set_dram_hrt_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
 {
 	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_hrt_bw;
 
-	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_HRT_BW, max_bw, 0, bw);
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_HRT_BW, DVFSRC_BW_HRT, max_bw, 0, bw);
 }
 
 static void dvfsrc_set_opp_level_v1(struct mtk_dvfsrc *dvfsrc, u32 level)

-- 
2.52.0


