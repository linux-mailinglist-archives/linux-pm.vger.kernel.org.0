Return-Path: <linux-pm+bounces-23593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F3A55EDC
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E48C1887770
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D100719755B;
	Fri,  7 Mar 2025 03:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CbvezRpM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF5190696;
	Fri,  7 Mar 2025 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319109; cv=none; b=badNZRfUF/6ASbVj0jsgvyDsg+7/ApB8BVXv+IBY9TE4Zf/yZDzk5C37CaZLryLiPRgpLJg1f6IU9YD17LbAIddwJUn/WB+JmaxItRqkEJbDni+Ev+H1/VJq0NmlnvqP6KRaQ6UvJYm6LQUIsL9EHBJAmqn5afvUyaKw1vXqa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319109; c=relaxed/simple;
	bh=mJdPZ8cW8+CXFt0YQNQFQ0nsuc7GJonfa1zkNscDGOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nkp8rcKbQzS9fSwox5fGe9bQ7Z4lz0S5f1bhut81ykeuFG20hHL83BkTVMlPWoZ51TuoXTvnp95X317PkV5N/u2dhhVpRabsBz+F60qNAy8ggGbRMdVBEZcSrYEzwn2gN1eFp6lZtfD+Qkvqe6nGn81YCpy7JY8wnF7Ivjo+5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CbvezRpM; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8c72d894fb0611ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=prxJuUSE8fevIr/DHvhqqrbFA9h0A7CHVLzUycKX/Po=;
	b=CbvezRpMVUsqogrQzAuv4SlM4VmXgn6Zs1G+a3d3cyCujs/boEzkjbwlEHQeQEAfqQoeRE9Lz+Yaln+I3qBmcjpbfUbi8h8IshJiOAIFWsgaq4TU3nozlyMFQJloOUMH57DPWWrb1XUvFv3gcgMAchsyemZ1k0LPY3zE/hLENTc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:c5c9d0cb-deac-474e-a115-116bd80da8de,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:3697108c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8c72d894fb0611ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 3490628; Fri, 07 Mar 2025 11:45:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:00 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:44:59 +0800
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
Subject: [PATCH 04/13] pmdomain: mediatek: Support check power on/off ack
Date: Fri, 7 Mar 2025 11:44:28 +0800
Message-ID: <20250307034454.12243-5-guangjie.song@mediatek.com>
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

Support check ack bits for pmdomain on/off.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 50 +++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 3c8b5d8e7ee9..2f75c606f7ba 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -22,12 +22,14 @@
 
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    USEC_PER_SEC
+#define MTK_ACK_DELAY_US		50
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
 #define MTK_SCPD_SRAM_ISO		BIT(2)
 #define MTK_SCPD_SRAM_SLP		BIT(3)
 #define MTK_SCPD_BYPASS_INIT_ON		BIT(4)
+#define MTK_SCPD_IS_PWR_CON_ON		BIT(5)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -61,6 +63,8 @@
 #define PWR_CLK_DIS_BIT			BIT(4)
 #define PWR_SRAM_CLKISO_BIT		BIT(5)
 #define PWR_SRAM_ISOINT_B_BIT		BIT(6)
+#define PWR_ACK				BIT(30)
+#define PWR_ACK_2ND			BIT(31)
 
 #define PWR_STATUS_CONN			BIT(1)
 #define PWR_STATUS_DISP			BIT(3)
@@ -200,6 +204,20 @@ static int scpsys_domain_is_on(struct scp_domain *scpd)
 	return -EINVAL;
 }
 
+static int scpsys_pwr_ack_is_on(struct scp_domain *scpd)
+{
+	u32 status = readl(scpd->scp->base + scpd->data->ctl_offs) & PWR_ACK;
+
+	return status ? true : false;
+}
+
+static int scpsys_pwr_ack_2nd_is_on(struct scp_domain *scpd)
+{
+	u32 status = readl(scpd->scp->base + scpd->data->ctl_offs) & PWR_ACK_2ND;
+
+	return status ? true : false;
+}
+
 static int scpsys_regulator_enable(struct scp_domain *scpd)
 {
 	if (!scpd->supply)
@@ -360,12 +378,25 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	val = readl(ctl_addr);
 	val |= PWR_ON_BIT;
 	writel(val, ctl_addr);
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON)) {
+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_is_on, scpd, tmp, tmp > 0,
+						MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			goto err_pwr_ack;
+
+		udelay(MTK_ACK_DELAY_US);
+	}
+
 	val |= PWR_ON_2ND_BIT;
 	writel(val, ctl_addr);
 
 	/* wait until PWR_ACK = 1 */
-	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp > 0,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON))
+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_2nd_is_on, scpd, tmp, tmp > 0,
+						MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	else
+		ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp > 0,
+					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 	if (ret < 0)
 		goto err_pwr_ack;
 
@@ -428,12 +459,23 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	val &= ~PWR_ON_BIT;
 	writel(val, ctl_addr);
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON)) {
+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_is_on, scpd, tmp, tmp == 0,
+						MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			goto out;
+	}
+
 	val &= ~PWR_ON_2ND_BIT;
 	writel(val, ctl_addr);
 
 	/* wait until PWR_ACK = 0 */
-	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp == 0,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON))
+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_2nd_is_on, scpd, tmp, tmp == 0,
+						MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	else
+		ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp == 0,
+					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 	if (ret < 0)
 		goto out;
 
-- 
2.45.2


