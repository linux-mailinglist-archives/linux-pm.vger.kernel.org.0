Return-Path: <linux-pm+bounces-23595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A99A55EE0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32963A55B3
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2475319DF4F;
	Fri,  7 Mar 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KzcF3IxF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F180192B9D;
	Fri,  7 Mar 2025 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319111; cv=none; b=Eal1ch5LZ3E+0xVYAZnxKmfaKcQydcF2V3oIxEZjV2diMelRLbGtqSflaE2q7Rf/uqXH7+txzntEXeXsYH97dD44A0xF2esWiT0jO1ujpc6569gKEQuwKkLZAIYpRPdFdOPhvp+AfVfT5UibNu5Be7uJ9WKWIVjZbm8IyurI3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319111; c=relaxed/simple;
	bh=uyUnzNwyoyuwQMLIpySyWHV1azyU+AGtt2HReF4ZHrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCAzgxFJHnUisdYqDdLmf/I5r2n/KBSFZXlNnhnB20che5v3heMcNeQvfsyG2gtPfdFtKffH/tEzt/g0ky8kqL+wPDW85XoS9VUXGNIJf/mmfd0wl2GVw4/OTwsAJe3Npt3zj22IfTP2dKOLWKMtMXrPzdn5tONFNVmzcEmXvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KzcF3IxF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8ce657b0fb0611ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C1mt1FTWNvuTJE22JvOTJH8Fz7g8J9sC5uN148Guczc=;
	b=KzcF3IxFucHgTBe79nf6AY2Z62qrG/8hj+mMvMVgFLukBI4hjF2rcmXfxcgzGJfZLn6b/6WmZ/4dM4guTKgTi11gYztod8EyXq9FK93fG8JtFsTYPQ70TAU5VDRxBwxgU1zxuSER5peYuGG30mSNAIiEStMglBZZydkEnx/WznQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:de93737a-cf7c-4b8d-b559-d37e82cd3f53,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:8a51cc49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8ce657b0fb0611ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2126118998; Fri, 07 Mar 2025 11:45:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:01 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:45:00 +0800
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
Subject: [PATCH 05/13] pmdomain: mediatek: Support voting for power domain
Date: Fri, 7 Mar 2025 11:44:29 +0800
Message-ID: <20250307034454.12243-6-guangjie.song@mediatek.com>
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

Power domain supports voting mechanism. If any xPU votes power domain
on, the power domain keep on.
Add power domain vote support.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 207 ++++++++++++++++++++++++-
 1 file changed, 205 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 2f75c606f7ba..df9cd012006c 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/soc/mediatek/infracfg.h>
 
@@ -22,7 +23,12 @@
 
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    USEC_PER_SEC
+#define MTK_POLL_TIMEOUT_300MS		(300 * USEC_PER_MSEC)
+#define MTK_POLL_IRQ_TIMEOUT		USEC_PER_SEC
+#define MTK_POLL_VOTE_PREPARE_CNT	2500
+#define MTK_POLL_VOTE_PREPARE_US	2
 #define MTK_ACK_DELAY_US		50
+#define MTK_STABLE_DELAY_US		100
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
@@ -30,6 +36,7 @@
 #define MTK_SCPD_SRAM_SLP		BIT(3)
 #define MTK_SCPD_BYPASS_INIT_ON		BIT(4)
 #define MTK_SCPD_IS_PWR_CON_ON		BIT(5)
+#define MTK_SCPD_VOTE_OPS		BIT(6)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -120,8 +127,18 @@ static const char * const clk_names[] = {
 /**
  * struct scp_domain_data - scp domain data for power on/off flow
  * @name: The domain name.
+ * @vote_comp: The vote name.
  * @sta_mask: The mask for power on/off status bit.
  * @ctl_offs: The offset for main power control register.
+ * @vote_done_ofs: The offset for vote done register.
+ * @vote_ofs: The offset for vote register.
+ * @vote_set_ofs: The offset for vote set register.
+ * @vote_clr_ofs: The offset for vote clear register.
+ * @vote_en_ofs: The offset for voted register.
+ * @vote_set_sta_ofs: The offset for vote set status register.
+ * @vote_clr_sta_ofs: The offset for vote clear status register.
+ * @vote_ack_ofs: The offset for power control ack register.
+ * @vote_shift: The bit of vote.
  * @sram_pdn_bits: The mask for sram power control bits.
  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
  * @sram_slp_bits: The mask for sram low power control bits.
@@ -132,8 +149,18 @@ static const char * const clk_names[] = {
  */
 struct scp_domain_data {
 	const char *name;
+	const char *vote_comp;
 	u32 sta_mask;
 	int ctl_offs;
+	u32 vote_done_ofs;
+	u32 vote_ofs;
+	u32 vote_set_ofs;
+	u32 vote_clr_ofs;
+	u32 vote_en_ofs;
+	u32 vote_set_sta_ofs;
+	u32 vote_clr_sta_ofs;
+	u32 vote_ack_ofs;
+	u8 vote_shift;
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
 	u32 sram_slp_bits;
@@ -151,6 +178,7 @@ struct scp_domain {
 	struct clk *clk[MAX_CLKS];
 	const struct scp_domain_data *data;
 	struct regulator *supply;
+	struct regmap *vote_regmap;
 };
 
 struct scp_ctrl_reg {
@@ -493,6 +521,154 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	return ret;
 }
 
+static int mtk_vote_is_done(struct scp_domain *scpd)
+{
+	u32 val = 0, mask = 0;
+
+	regmap_read(scpd->vote_regmap, scpd->data->vote_done_ofs, &val);
+	mask = BIT(scpd->data->vote_shift);
+	if ((val & mask) == mask)
+		return 1;
+
+	return 0;
+}
+
+static int mtk_vote_is_enable_done(struct scp_domain *scpd)
+{
+	u32 done = 0, en = 0, set_sta = 0, mask = 0, ack = 0;
+
+	regmap_read(scpd->vote_regmap, scpd->data->vote_done_ofs, &done);
+	regmap_read(scpd->vote_regmap, scpd->data->vote_en_ofs, &en);
+	regmap_read(scpd->vote_regmap, scpd->data->vote_set_sta_ofs, &set_sta);
+	mask = BIT(scpd->data->vote_shift);
+
+	if ((done & mask) && (en & mask) && !(set_sta & mask)) {
+		if (scpd->data->vote_ack_ofs) {
+			regmap_read(scpd->vote_regmap, scpd->data->vote_ack_ofs, &ack);
+			if (!(ack & mask))
+				return 0;
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int mtk_vote_is_disable_done(struct scp_domain *scpd)
+{
+	u32 val = 0, val2 = 0;
+
+	regmap_read(scpd->vote_regmap, scpd->data->vote_done_ofs, &val);
+	regmap_read(scpd->vote_regmap, scpd->data->vote_clr_sta_ofs, &val2);
+
+	if ((val & BIT(scpd->data->vote_shift)) &&
+	    ((val2 & BIT(scpd->data->vote_shift)) == 0x0))
+		return 1;
+
+	return 0;
+}
+
+static int scpsys_vote_power_on(struct generic_pm_domain *genpd)
+{
+	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
+	struct scp *scp = scpd->scp;
+	u32 val = 0;
+	int ret = 0;
+	int tmp;
+	int i = 0;
+
+	ret = scpsys_regulator_enable(scpd);
+	if (ret < 0)
+		goto out;
+
+	ret = scpsys_clk_enable(scpd->clk, MAX_CLKS);
+	if (ret)
+		goto out;
+
+	ret = readx_poll_timeout_atomic(mtk_vote_is_done, scpd, tmp, tmp > 0,
+					MTK_POLL_DELAY_US, MTK_POLL_IRQ_TIMEOUT);
+	if (ret < 0)
+		goto out;
+
+	val = BIT(scpd->data->vote_shift);
+	regmap_write(scpd->vote_regmap, scpd->data->vote_set_ofs, val);
+	do {
+		regmap_read(scpd->vote_regmap, scpd->data->vote_set_ofs, &val);
+		if ((val & BIT(scpd->data->vote_shift)) != 0)
+			break;
+
+		if (i > MTK_POLL_VOTE_PREPARE_CNT)
+			goto out;
+
+		udelay(MTK_POLL_VOTE_PREPARE_US);
+		i++;
+	} while (1);
+
+	/* add debounce time */
+	udelay(1);
+
+	/* wait until VOTER_ACK = 1 */
+	ret = readx_poll_timeout_atomic(mtk_vote_is_enable_done, scpd, tmp, tmp > 0,
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT_300MS);
+	if (ret < 0)
+		goto out;
+
+	return 0;
+out:
+	dev_err(scp->dev, "Failed to power on domain %s(%d)\n", genpd->name, ret);
+	return ret;
+}
+
+static int scpsys_vote_power_off(struct generic_pm_domain *genpd)
+{
+	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
+	struct scp *scp = scpd->scp;
+	u32 val = 0;
+	int ret = 0;
+	int tmp;
+	int i = 0;
+
+	ret = readx_poll_timeout_atomic(mtk_vote_is_done, scpd, tmp, tmp > 0,
+					MTK_POLL_DELAY_US, MTK_POLL_IRQ_TIMEOUT);
+	if (ret < 0)
+		goto out;
+
+	val = BIT(scpd->data->vote_shift);
+	regmap_write(scpd->vote_regmap, scpd->data->vote_clr_ofs, val);
+	do {
+		regmap_read(scpd->vote_regmap, scpd->data->vote_clr_ofs, &val);
+		if ((val & BIT(scpd->data->vote_shift)) == 0)
+			break;
+
+		if (i > MTK_POLL_VOTE_PREPARE_CNT)
+			goto out;
+
+		i++;
+		udelay(MTK_POLL_VOTE_PREPARE_US);
+	} while (1);
+
+	/* delay 100us for stable status */
+	udelay(MTK_STABLE_DELAY_US);
+
+	/* wait until VOTER_ACK = 0 */
+	ret = readx_poll_timeout_atomic(mtk_vote_is_disable_done, scpd, tmp, tmp > 0,
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT_300MS);
+	if (ret < 0)
+		goto out;
+
+	scpsys_clk_disable(scpd->clk, MAX_CLKS);
+
+	ret = scpsys_regulator_disable(scpd);
+	if (ret < 0)
+		goto out;
+
+	return 0;
+out:
+	dev_err(scp->dev, "Failed to power off domain %s(%d)\n", genpd->name, ret);
+	return ret;
+}
+
 static void init_clks(struct platform_device *pdev, struct clk **clk)
 {
 	int i;
@@ -501,6 +677,21 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
 }
 
+static int mtk_pd_get_regmap(struct platform_device *pdev, struct regmap **regmap,
+			     const char *name)
+{
+	*regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, name);
+	if (PTR_ERR(*regmap) == -ENODEV) {
+		dev_notice(&pdev->dev, "%s regmap is null(%ld)\n", name, PTR_ERR(*regmap));
+		*regmap = NULL;
+	} else if (IS_ERR(*regmap)) {
+		dev_notice(&pdev->dev, "Cannot find %s controller: %ld\n", name, PTR_ERR(*regmap));
+		return PTR_ERR(*regmap);
+	}
+
+	return 0;
+}
+
 static struct scp *init_scp(struct platform_device *pdev,
 			const struct scp_domain_data *scp_domain_data, int num,
 			const struct scp_ctrl_reg *scp_ctrl_reg,
@@ -510,6 +701,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 	int i, j;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
+	int ret;
 
 	scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
 	if (!scp)
@@ -585,9 +777,20 @@ static struct scp *init_scp(struct platform_device *pdev,
 			scpd->clk[j] = c;
 		}
 
+		if (data->vote_comp) {
+			ret = mtk_pd_get_regmap(pdev, &scpd->vote_regmap, data->vote_comp);
+			if (ret)
+				return ERR_PTR(ret);
+		}
+
 		genpd->name = data->name;
-		genpd->power_off = scpsys_power_off;
-		genpd->power_on = scpsys_power_on;
+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_VOTE_OPS)) {
+			genpd->power_on = scpsys_vote_power_on;
+			genpd->power_off = scpsys_vote_power_off;
+		} else {
+			genpd->power_off = scpsys_power_off;
+			genpd->power_on = scpsys_power_on;
+		}
 		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
 			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 	}
-- 
2.45.2


