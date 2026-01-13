Return-Path: <linux-pm+bounces-40723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F059DD18614
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49E4230F7C52
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C002A38FEF3;
	Tue, 13 Jan 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qx4d8zXt"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A038BF87;
	Tue, 13 Jan 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302020; cv=none; b=G1D9BeDZVK2Zts4iCqL5/RB3ESdb0VP6P0BvetU09Q4mGsRH7jkP14rsjmYMREtJb3lqz+xoBm3fek2MyEACf1JY67LbCKlgDiBYsWRhETO4j7b0DvF3pwYdaVLLdrodNyFZOUqY6wgVTrry1BiSu8vcqpG8qfVgPxlYTS96wbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302020; c=relaxed/simple;
	bh=mFVa0fwuvFYnyoWskioZV1v6ax8u0bRsK+JjDpsGtog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiG+cZfyvhEc7UujzDTHlUf2Kf7jOPFWvDLGRLHiG3PJJwOGsywwgkwva1tgiLQGfAByMbNfeYLlY4pKrYPl+V+HFANLIpzn1A7HjsgugnaXXuBb+RroWGIzeZAmEcrB6OPn4NitTKnD+w7NWL0zWhbBECr0jKVQQslpmsl/Scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qx4d8zXt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302016;
	bh=mFVa0fwuvFYnyoWskioZV1v6ax8u0bRsK+JjDpsGtog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qx4d8zXt2CNE/G5w1TuSw0X6NDGNnHsTY7toxj7UvqRrTiIyojaJHCYHxliM2r+m6
	 hoRU/79a9urlPS2dd4OIvPXzjZwbgpkYwNvXC+pHDQDJ1Yy5nreIlT6crgl+/E+Xu0
	 8XWF1LZHzKGfVaTVEVljtsFmObanmhMLJPOJnyXBqbWqAbqDaKvFByMHqRW0bPScIa
	 h4zx8S5N87Wye5IdD9EBxUCLxd3cT0kBjSQ/Nio1f9TI4TbGYev6UqJLi1ew6xrZWC
	 OGYCtpefgFCehLrFUfZDEPbhEIbWIpZVN6cVf/mVAv7St4hwzbOkgNvGqLq1cm2i7O
	 A8663bGa4vzVw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5717517E1525;
	Tue, 13 Jan 2026 12:00:16 +0100 (CET)
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
Subject: [PATCH 3/5] pmdomain: mediatek: scpsys: Add MT7622 Audio power domain to legacy driver
Date: Tue, 13 Jan 2026 12:00:10 +0100
Message-ID: <20260113110012.36984-4-angelogioacchino.delregno@collabora.com>
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

Add the Audio power domain of the MT7622 SoC to the legacy
mtk-scpsys driver (as this legacy SoC is supported only there).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 1a80c1537a43..efc8f276ffce 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -867,6 +867,16 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
 		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
 	},
+	[MT7622_POWER_DOMAIN_AUDIO] = {
+		.name = "audsys",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = SPM_AUDIO_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_NONE},
+		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF1,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
 };
 
 /*
-- 
2.52.0


