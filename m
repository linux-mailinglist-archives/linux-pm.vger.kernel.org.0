Return-Path: <linux-pm+bounces-23594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E977A55EDB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49D73A645C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B8D1993B1;
	Fri,  7 Mar 2025 03:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R7UEm0Wy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0041917D9;
	Fri,  7 Mar 2025 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319109; cv=none; b=rAM9NPeu9JHK/eJP+ufDe5rLb/Fg/hmbxloFGXSAmI+VPgGEU8dLE2ixnBAePoa7ibURAuJX1ACX6nxDuuq4qKeWn5cvu+y9vyfUmh/S8O70xtMN8/BU8VIZqg0X8V6c4XgAfR8yf44YPVtsBJUZ9jzKKspoy+/2WtctfthMNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319109; c=relaxed/simple;
	bh=5BpMLNT0YZ+rvdWgkRaFKR4+ZA5uTGMcGtxH4V3Jpcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNDH1ToBbF/YF4jxCgDUCL01p6YtThp/XFUmdaONWw5Nz7Nv8GUFoAEWK/gMeKG4hU86m0PZnUrJ5KyI3nmn17UMdbs6J9t5UBYaWzQ7HKTzpElcQHci0DAjKqRJcgslZtPBqIhvDbl3MWA93nJ720YsnCZw2GW6mYrFwUHsyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R7UEm0Wy; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8d23f21efb0611efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yjsKYsYt56CRuDyvJwITLsiWGxpc8ysryTjYQc7XD4Y=;
	b=R7UEm0WyQlTXPgEtvyPnho3NdpZqpICeZOF+UP4Fz0GCHn6jEGAnvoGdb/TllAGDDRblmE5BeETrKKXJgcwVT0qLlJ020bZAz+4zHjzdmd+GzH/VzIJxhFV4KiqIkI4mjRjXnh+yQHtJsO4cvnnpuqutcmcr5R8xW1/iF/u18U8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0148b497-234a-4245-a920-ed4d2931b40e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:230d08c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8d23f21efb0611efaae1fd9735fae912-20250307
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1358317850; Fri, 07 Mar 2025 11:45:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:01 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:45:01 +0800
From: Guangjie Song <guangjie.song@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, Guangjie Song <guangjie.song@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 06/13] pmdomain: mediatek: Support trigger subsys save/restore regesters
Date: Fri, 7 Mar 2025 11:44:30 +0800
Message-ID: <20250307034454.12243-7-guangjie.song@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307034454.12243-1-guangjie.song@mediatek.com>
References: <20250307034454.12243-1-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Support trigger subsys save/restore registers during power domain
on/off.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 106 ++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index df9cd012006c..0ae4c617b5a6 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -28,6 +28,7 @@
 #define MTK_POLL_VOTE_PREPARE_CNT	2500
 #define MTK_POLL_VOTE_PREPARE_US	2
 #define MTK_ACK_DELAY_US		50
+#define MTK_RTFF_DELAY_US		10
 #define MTK_STABLE_DELAY_US		100
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
@@ -37,6 +38,10 @@
 #define MTK_SCPD_BYPASS_INIT_ON		BIT(4)
 #define MTK_SCPD_IS_PWR_CON_ON		BIT(5)
 #define MTK_SCPD_VOTE_OPS		BIT(6)
+#define MTK_SCPD_NON_CPU_RTFF		BIT(7)
+#define MTK_SCPD_PEXTP_PHY_RTFF		BIT(8)
+#define MTK_SCPD_UFS_RTFF		BIT(9)
+#define MTK_SCPD_RTFF_DELAY		BIT(10)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -70,6 +75,11 @@
 #define PWR_CLK_DIS_BIT			BIT(4)
 #define PWR_SRAM_CLKISO_BIT		BIT(5)
 #define PWR_SRAM_ISOINT_B_BIT		BIT(6)
+#define PWR_RTFF_SAVE			BIT(24)
+#define PWR_RTFF_NRESTORE		BIT(25)
+#define PWR_RTFF_CLK_DIS		BIT(26)
+#define PWR_RTFF_SAVE_FLAG		BIT(27)
+#define PWR_RTFF_UFS_CLK_DIS		BIT(28)
 #define PWR_ACK				BIT(30)
 #define PWR_ACK_2ND			BIT(31)
 
@@ -167,7 +177,7 @@ struct scp_domain_data {
 	u32 sram_slp_ack_bits;
 	u32 bus_prot_mask;
 	enum clk_id clk_id[MAX_CLKS];
-	u8 caps;
+	u32 caps;
 };
 
 struct scp;
@@ -179,6 +189,7 @@ struct scp_domain {
 	const struct scp_domain_data *data;
 	struct regulator *supply;
 	struct regmap *vote_regmap;
+	bool rtff_flag;
 };
 
 struct scp_ctrl_reg {
@@ -428,15 +439,72 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_pwr_ack;
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF) && scpd->rtff_flag) {
+		val |= PWR_RTFF_CLK_DIS;
+		writel(val, ctl_addr);
+	}
+
 	val &= ~PWR_CLK_DIS_BIT;
 	writel(val, ctl_addr);
 
 	val &= ~PWR_ISO_BIT;
 	writel(val, ctl_addr);
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_RTFF_DELAY) && scpd->rtff_flag)
+		udelay(MTK_RTFF_DELAY_US);
+
 	val |= PWR_RST_B_BIT;
 	writel(val, ctl_addr);
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_NON_CPU_RTFF)) {
+		val = readl(ctl_addr);
+		if (val & PWR_RTFF_SAVE_FLAG) {
+			val &= ~PWR_RTFF_SAVE_FLAG;
+			writel(val, ctl_addr);
+
+			val |= PWR_RTFF_CLK_DIS;
+			writel(val, ctl_addr);
+
+			val &= ~PWR_RTFF_NRESTORE;
+			writel(val, ctl_addr);
+
+			val |= PWR_RTFF_NRESTORE;
+			writel(val, ctl_addr);
+
+			val &= ~PWR_RTFF_CLK_DIS;
+			writel(val, ctl_addr);
+		}
+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF)) {
+		val = readl(ctl_addr);
+		if (val & PWR_RTFF_SAVE_FLAG) {
+			val &= ~PWR_RTFF_SAVE_FLAG;
+			writel(val, ctl_addr);
+
+			val &= ~PWR_RTFF_NRESTORE;
+			writel(val, ctl_addr);
+
+			val |= PWR_RTFF_NRESTORE;
+			writel(val, ctl_addr);
+
+			val &= ~PWR_RTFF_CLK_DIS;
+			writel(val, ctl_addr);
+		}
+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF) && scpd->rtff_flag) {
+		val |= PWR_RTFF_UFS_CLK_DIS;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_NRESTORE;
+		writel(val, ctl_addr);
+
+		val |= PWR_RTFF_NRESTORE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_UFS_CLK_DIS;
+		writel(val, ctl_addr);
+
+		scpd->rtff_flag = false;
+	}
+
 	ret = scpsys_sram_enable(scpd, ctl_addr);
 	if (ret < 0)
 		goto err_pwr_ack;
@@ -475,9 +543,45 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 
 	/* subsys power off */
 	val = readl(ctl_addr);
+
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_NON_CPU_RTFF) ||
+	    MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF)) {
+		val |= PWR_RTFF_CLK_DIS;
+		writel(val, ctl_addr);
+
+		val |= PWR_RTFF_SAVE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_SAVE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_CLK_DIS;
+		writel(val, ctl_addr);
+
+		val |= PWR_RTFF_SAVE_FLAG;
+		writel(val, ctl_addr);
+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF)) {
+		val |= PWR_RTFF_UFS_CLK_DIS;
+		writel(val, ctl_addr);
+
+		val |= PWR_RTFF_SAVE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_SAVE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_UFS_CLK_DIS;
+		writel(val, ctl_addr);
+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF))
+			scpd->rtff_flag = true;
+	}
+
 	val |= PWR_ISO_BIT;
 	writel(val, ctl_addr);
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_RTFF_DELAY) && scpd->rtff_flag)
+		udelay(1);
+
 	val &= ~PWR_RST_B_BIT;
 	writel(val, ctl_addr);
 
-- 
2.45.2


