Return-Path: <linux-pm+bounces-23592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC268A55ED6
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8289A3A527C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D80194C8B;
	Fri,  7 Mar 2025 03:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XJLLxiEd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2418E750;
	Fri,  7 Mar 2025 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319109; cv=none; b=iQp7M8EypqVSFIVBnoyHAs8C59sLhk015wuMP/s+G/bfgRK1uyhdO446HKhH3wNo3KDOKtvTg0wPXDZUM/59sILbtMeoj2pIInfXvklo7hW1FNQKitMBFSpflr1PQwOH8DXgKjgYFE2/AULM5400tpIooRt3hVNPIndujUM0YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319109; c=relaxed/simple;
	bh=NkZ04/nT8tLXbQ16peMlZmvwUmSmEPuKZr+vWLSfrmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4UhGXjvFMpiqcl2llUj5sw0iXUdAi8UHBZgke+9wHMpuJsxhPpEnlitO0S6WM8QTzo8CH+e+FfIafC4u0eVRfCy5XbbUz5w3HUKEgH6FcXl5ym/7AOaocF7iFWtxAs/zj+7Pet1MqsAw27EDuNhnar/HDPqxJCOO8IndDj5z/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XJLLxiEd; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8b682c10fb0611efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=A2AxzsjD4oNDzRPVdL936OhFvrb5cy0xPDLnLQOD+j8=;
	b=XJLLxiEdLJhjZt0rQJHyS5WfE7eZRt0AbGcKCGDfLU5xgcu4SO26YLtV7+ku45nD8nngHWYfFl53zY6LKKRWLXEJ/mozxm0463g/7+shuggyrPzcHeI8B6jEbojsWCOebHffl1g99YcRX/1gVB+UkxHCmk7EAVJl5y4gkS20T/M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:b1944498-164b-45eb-87f1-cc996944bedd,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:6251cc49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b682c10fb0611efaae1fd9735fae912-20250307
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 807993250; Fri, 07 Mar 2025 11:44:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:44:58 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:44:58 +0800
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
Subject: [PATCH 02/13] pmdomain: mediatek: Support sram low power
Date: Fri, 7 Mar 2025 11:44:26 +0800
Message-ID: <20250307034454.12243-3-guangjie.song@mediatek.com>
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

Support sram enter/exit low power mode.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 36 ++++++++++++++++++++------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index d53bd07a6804..9d03249284d6 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -26,6 +26,7 @@
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
 #define MTK_SCPD_SRAM_ISO		BIT(2)
+#define MTK_SCPD_SRAM_SLP		BIT(3)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -118,6 +119,8 @@ static const char * const clk_names[] = {
  * @ctl_offs: The offset for main power control register.
  * @sram_pdn_bits: The mask for sram power control bits.
  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
+ * @sram_slp_bits: The mask for sram low power control bits.
+ * @sram_slp_ack_bits: The mask for sram low power control acked bits.
  * @bus_prot_mask: The mask for single step bus protection.
  * @clk_id: The basic clocks required by this power domain.
  * @caps: The flag for active wake-up action.
@@ -128,6 +131,8 @@ struct scp_domain_data {
 	int ctl_offs;
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
+	u32 sram_slp_bits;
+	u32 sram_slp_ack_bits;
 	u32 bus_prot_mask;
 	enum clk_id clk_id[MAX_CLKS];
 	u8 caps;
@@ -236,11 +241,19 @@ static int scpsys_clk_enable(struct clk *clk[], int max_num)
 static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
 {
 	u32 val;
-	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
+	u32 ack_mask, ack_sta;
 	int tmp;
 
-	val = readl(ctl_addr);
-	val &= ~scpd->data->sram_pdn_bits;
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_SLP)) {
+		ack_mask = scpd->data->sram_slp_ack_bits;
+		ack_sta = ack_mask;
+		val = readl(ctl_addr) | scpd->data->sram_slp_bits;
+	} else {
+		ack_mask = scpd->data->sram_pdn_ack_bits;
+		ack_sta = 0;
+		val = readl(ctl_addr) & ~scpd->data->sram_pdn_bits;
+	}
+
 	writel(val, ctl_addr);
 
 	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
@@ -254,7 +267,7 @@ static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
 	} else {
 		/* Either wait until SRAM_PDN_ACK all 1 or 0 */
 		int ret = readl_poll_timeout(ctl_addr, tmp,
-				(tmp & pdn_ack) == 0,
+				(tmp & ack_mask) == ack_sta,
 				MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret < 0)
 			return ret;
@@ -274,7 +287,7 @@ static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
 static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
 {
 	u32 val;
-	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
+	u32 ack_mask, ack_sta;
 	int tmp;
 
 	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_ISO)) {
@@ -285,13 +298,20 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
 		udelay(1);
 	}
 
-	val = readl(ctl_addr);
-	val |= scpd->data->sram_pdn_bits;
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_SLP)) {
+		ack_mask = scpd->data->sram_slp_ack_bits;
+		ack_sta = 0;
+		val = readl(ctl_addr) & ~scpd->data->sram_slp_bits;
+	} else {
+		ack_mask = scpd->data->sram_pdn_ack_bits;
+		ack_sta = ack_mask;
+		val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
+	}
 	writel(val, ctl_addr);
 
 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
 	return readl_poll_timeout(ctl_addr, tmp,
-			(tmp & pdn_ack) == pdn_ack,
+			(tmp & ack_mask) == ack_sta,
 			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-- 
2.45.2


