Return-Path: <linux-pm+bounces-38447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5D8C80195
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 350C24E4678
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634892FE584;
	Mon, 24 Nov 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="GcDKiOKa"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307E2FE04F;
	Mon, 24 Nov 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982460; cv=pass; b=tCOOj77Az+Byms2VZfTu8Dcml7kSyj0ZGVSWYoN/pzN24TIAyZHSPQowaWoN9UoT/wHspYBv+MbNWnDRF9Ro99zVLxHHS8M8SnESdW1ydzZ0qRgYkUVfswsysOWNDD5WScJe1yWCEjU5itLqbbYD1ECEBNIwrTrBMp5lRWFSabw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982460; c=relaxed/simple;
	bh=0EHxgzdLZD3MHMZWz/fQ/MU14waqgu4mt8DIkMOFSl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jWZ1btc6Ji/DNUV8MtLtwhliYISRRDmMfUs1DP52FVUq1SBQd6f7+Oa7BaXVJs4lXFA090Q/a8ig6qpkAx2pRk6h0+kDe8CvvtANqw1dnHltgiVgV1VpJHu9A3T3cXHr5HLDFda1KVl99ircBG2ahHTYW2RTEJmpRv5XruPgSbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=GcDKiOKa; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982443; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XDzG38gLtIld33aEjX3U7UoiNF4tEDtXnvJ5AnkLgHpTlwa+Z15UWgZOrngE4CgSJdCQ02BWgYWzvsKZSdy0GvtRas0GaEAiIZpwYjSWSAPFfB5jjebGlq2MLQkIdxJQuYyuorJo7YykC/IB2bHgAd2mP+rR/Ugq1CD/2xOPRP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982443; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xvMrnz046uHJZXOiU4VZP36iA2AFstMOvjMGKhiRnuw=; 
	b=f1T1bujkNj6qyW9wVZbcwnh7HC3yOsbDkkU6eyq7+ZOrswF6g+S4/ae51aKXdfQgHH6JV2F6JnOth3lru/tXZV0p1x2ATs5J6NfmuXn5MAhtCu1dwLxGTgj78XCx2WmHMt8JLwPWGWu2lRltEgY2Bndz2aYbNv6YRCJMVkoPA8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982443;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=xvMrnz046uHJZXOiU4VZP36iA2AFstMOvjMGKhiRnuw=;
	b=GcDKiOKaTuZBBXVNvzksyE9C81Jfb2uT8G1obHyRPlT3907AZ4qT0/iDVQTB7XHY
	1YHVRFU0IrlBA/xzbA0KLqf2ROgPGB/siKj5P93TKBEExPU8lZfFiA0fOMw0S61aqhh
	d7Nf9xGmQWoRGG9i2s4obY0vlpXqEttcBYypI1F0=
Received: by mx.zohomail.com with SMTPS id 1763982440693719.0304302956694;
	Mon, 24 Nov 2025 03:07:20 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:56 +0100
Subject: [PATCH v2 07/13] soc: mediatek: mtk-dvfsrc: Write bandwidth to EMI
 DDR if present
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-7-d9c1334db9f3@collabora.com>
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
`has_emi_ddr` member to struct dvfsrc_soc_data: if true, write the
DRAM bandwidth both to the BW_AVG and to the newly defined EMI_BW
register, present only on DVFSRC v4.

Currently supported SoCs will not use this, as has_emi_ddr is left
out from their platform data, hence reading false.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
2.52.0


