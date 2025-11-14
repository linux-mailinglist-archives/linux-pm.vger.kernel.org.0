Return-Path: <linux-pm+bounces-38061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F291C5E63A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB63A4F843B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B047A336EE1;
	Fri, 14 Nov 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="j0vw+Zv2"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6A233557D;
	Fri, 14 Nov 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139278; cv=pass; b=KDzrDIMRkWnsN2AOb8Z2tBuXYJs/O+FuvYwSpWr8Gc65iziRGdyCnVita+YgAmb1re+bxk3TS3ck5OWUFilIwhLarQ0NytqWqSARZLqH95UzUHcPAal9jOFjmSVsbhvgAHCOOoC+A8nj28oHLyY2Od/usxO9ql7w+QOCwX/Hnj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139278; c=relaxed/simple;
	bh=O/WVoQJ5FCa5XbHCzmonV0Ho97jAj8lY7RZxFZsutVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Inn3i2wfU4dL3xTdF2GdKsVsoJq47MRfW+gPeXhucj+Jsar4UIHA2J3IyfOHLfOzZQv2KNQvyujSm0+6Axsl8/JyE7PLM+gtYs5NT8olxLzzjPHZeaRsfSwdV79bFTUZgb7RUGFhlteddvu+iT/Fy3+IndKd5qnxH4dar3nwKwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=j0vw+Zv2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139264; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J9acPu6Yc0AiiEH6RBy6hePHR6U6YgttOl09/3t67sWtBeua1hM0wqdrzjtNYni+zx8PTOFaK2N+ScTXEO/88Cnjlx7ILsaiV8Oat0cira5Ck5URzEDJE5kciAfouilk0/TXKr8HxY5lbPsXoE3L2dWUod1OLscVtPDgP6rzr14=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139264; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iXXXJ/YfENpaJKJhO5wDI3ypfbMEWnHe8CUA+ghmiKE=; 
	b=nZKixmL+GKYQ7Q6b/UYYFDcJRfwHSpiVbn8XjFSJGX6I5R/AWj70s7Wpntsqh46nmXJ0UnjNXvkegqX+LwtH/8KTzyRu+td+gnOU8uEnE/s8wbrQGUz2ruo7TErHnJYgnzaICV8IYnj+P7NFcXSxQ+4xJ2l/FwLohVqRGpAZZLI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139264;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=iXXXJ/YfENpaJKJhO5wDI3ypfbMEWnHe8CUA+ghmiKE=;
	b=j0vw+Zv2sMPg1BhQnSftLJpiXn87XjAMCy2kX9j6kAY3c9RQUc97vegdKbW6wkNx
	AG/Po5pyjS0+hmQKbXVykDrGDm3nwzvVJQz5nSwMAFCd7P+AQ7dxaxy09WoxUS/oXa5
	BmRe9ZAH3ooACx+tMSzK6EUWz8DLXBFIgC/QbKQg=
Received: by mx.zohomail.com with SMTPS id 1763139263537949.2222555499463;
	Fri, 14 Nov 2025 08:54:23 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Nov 2025 17:53:59 +0100
Subject: [PATCH 05/13] soc: mediatek: mtk-dvfsrc: Add and propagate DVFSRC
 bandwidth type
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt8196-dvfsrc-v1-5-b956d4631468@collabora.com>
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
mtk_dvfsrc_bw_type enumeration, and propagate it from specific bw
setting callbacks to __dvfsrc_set_dram_bw_v1(), which will use it
to choose calculation multipliers and dividers in v4 callbacks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.51.2


