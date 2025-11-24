Return-Path: <linux-pm+bounces-38445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8869C801E3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C153AAD09
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1A2FD7BC;
	Mon, 24 Nov 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AbFR2dWG"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103B2FBE0D;
	Mon, 24 Nov 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982457; cv=pass; b=uF5ZWG70SvrbCBd1enf1VDRrEE0nHz8GEt5zA8OvP9zqI92/1h0R1FCSknpjFU3WXhE2XLedGPXUN8UU7+Y1/BDmMHQOmlcH6DJFhpZXgpfuHvThTIP6SlBuxMshxx7E9w+WM5880KYTbPQpTejkvofvoBTrfxfHhxcoQgcuCFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982457; c=relaxed/simple;
	bh=6F2kVSEWewRSGTRLy4D+6o7C5e8oIkIlwz3EdliBxTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQ1bH6Qszq+cbRxdJULpTjI+jFToNEKlcTDHLxRePbKqcVZpEhRYNcB2tOoBwd4KONc2J+5oLNCru7eqCRCsFfDZjv7cwWEUUhul8K6Drmb+svJU3aIdTKwUjhTnU1XXz07jf8dUr4a7qG0mk1jxwDWMcHciV+ns7w4dBEFUEjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=AbFR2dWG; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982439; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CbICZw+MJLYvDM75sIfnRqr2fQ91fmNYtir5j9yJLOmhLrEZDyZeM0mJ7ETOgQi82FE5ryyxrMo8qwNY+a65frh+aCiYJGMyMhtOC+QYdKZYI4HDUG+YLjF6xDCNm0G2j0svY/ir7cklB4tW6jmeSo6N9v222P1wEb7M1x2lsm4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982439; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9c3Qpc7AsTRxWwpMRyYkuInfLdtrj7kwxB62DhZpoe8=; 
	b=i3gBuUhesyaZ61vargUjnt8QzA7kpAtaYe0e5ub4wZ1HtAzRm2az09KbCboHtLBR7zSjSIVCWHZ8cjk0kRm7HeIzv3aMntpZETntLdW7fT2/Wg/XXagLS7jcTLAlnpRlwdF/vOJ2QP66Ypi33D0lzzuHd3hBZNrS6YfbI+DmGKI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982439;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=9c3Qpc7AsTRxWwpMRyYkuInfLdtrj7kwxB62DhZpoe8=;
	b=AbFR2dWGm4T/wE7qV5gHcdokKuzuKOQWD6pN1nurdR3VqNMf1l3314XxXgqbFh3v
	1i618vg7bx8ghfIZCoke0Z0LIAMZqu5njm0Ni2j95LELOdD9+VlahcIO1Mj3zAZKYuU
	HDtZ3s9Dsnlo3N+h5tmE7BkJG2UVXFtgdI2knhKU=
Received: by mx.zohomail.com with SMTPS id 1763982437295434.8072143379791;
	Mon, 24 Nov 2025 03:07:17 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:55 +0100
Subject: [PATCH v2 06/13] soc: mediatek: mtk-dvfsrc: Add a new callback for
 calc_dram_bw
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-6-d9c1334db9f3@collabora.com>
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
callback for calculating the dram bandwidth, assign the current
calculation algo to all of the currently supported SoCs, and use
this in __dvfsrc_set_dram_bw_v1().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index a684e405daf7..3cbccbb7469a 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -73,6 +73,7 @@ struct mtk_dvfsrc {
 struct dvfsrc_soc_data {
 	const int *regs;
 	const struct dvfsrc_opp_desc *opps_desc;
+	u32 (*calc_dram_bw)(struct mtk_dvfsrc *dvfsrc, int type, u64 bw);
 	u32 (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
 	u32 (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
 	u32 (*get_vcore_level)(struct mtk_dvfsrc *dvfsrc);
@@ -274,10 +275,15 @@ static void dvfsrc_set_vscp_level_v2(struct mtk_dvfsrc *dvfsrc, u32 level)
 	dvfsrc_writel(dvfsrc, DVFSRC_VCORE, val);
 }
 
+static u32 dvfsrc_calc_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, int type, u64 bw)
+{
+	return (u32)div_u64(bw, 100 * 1000);
+}
+
 static void __dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u32 reg,
 				    int type, u16 max_bw, u16 min_bw, u64 bw)
 {
-	u32 new_bw = (u32)div_u64(bw, 100 * 1000);
+	u32 new_bw = dvfsrc->dvd->calc_dram_bw(dvfsrc, type, bw);
 
 	/* If bw constraints (in mbps) are defined make sure to respect them */
 	if (max_bw)
@@ -519,6 +525,7 @@ static const struct dvfsrc_opp_desc dvfsrc_opp_mt8183_desc[] = {
 static const struct dvfsrc_soc_data mt8183_data = {
 	.opps_desc = dvfsrc_opp_mt8183_desc,
 	.regs = dvfsrc_mt8183_regs,
+	.calc_dram_bw = dvfsrc_calc_dram_bw_v1,
 	.get_target_level = dvfsrc_get_target_level_v1,
 	.get_current_level = dvfsrc_get_current_level_v1,
 	.get_vcore_level = dvfsrc_get_vcore_level_v1,
@@ -549,6 +556,7 @@ static const struct dvfsrc_opp_desc dvfsrc_opp_mt8195_desc[] = {
 static const struct dvfsrc_soc_data mt8195_data = {
 	.opps_desc = dvfsrc_opp_mt8195_desc,
 	.regs = dvfsrc_mt8195_regs,
+	.calc_dram_bw = dvfsrc_calc_dram_bw_v1,
 	.get_target_level = dvfsrc_get_target_level_v2,
 	.get_current_level = dvfsrc_get_current_level_v2,
 	.get_vcore_level = dvfsrc_get_vcore_level_v2,

-- 
2.52.0


