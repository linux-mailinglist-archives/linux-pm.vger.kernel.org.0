Return-Path: <linux-pm+bounces-41877-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAmDNdJIgGnB5gIAu9opvQ
	(envelope-from <linux-pm+bounces-41877-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 07:48:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A35C8F17
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 07:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB87230078D1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9BA30B518;
	Mon,  2 Feb 2026 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oawsEb8Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C5155757;
	Mon,  2 Feb 2026 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014912; cv=none; b=NZ7aD8wRGv8fkh5XKRZhjsjH4LFVSe8N3tj+9zTRG7JXOzDq8bnxeF/LkwrKYOxXd08nBPztRKFrornInV03IeutlsCWKzlhU75FTTKuloyPNr5lK2qWMwkLxkKO41OV7CfP7foGZbuQbCIBMt4b2BSHS1qqX2by5oAJZdxtHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014912; c=relaxed/simple;
	bh=h4cU9XlYPaB59wbNjZROXr0o3xj6KLYcK9LCOD9UZ38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTyooQ4br4S3tEOdxxhB9uZrbCnntoAwOPVIAyMaxJeZPi78SQoPma6pnFbu7swPJPEOmVnP+YFwEQODm6qWwwC4D1ULc4eUNgdGnZQLPK65ZSNh4Aq0lXgFfBhHzehlFXMsgfoEawJ7oKKcU11ei1khwn7S83W8kBrLyWFct9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oawsEb8Z; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2b44a86a000311f185319dbc3099e8fb-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Z3hAteUT6RLPGsGMhXx+FAjpX6rpL+Ly37R/wHlshp0=;
	b=oawsEb8ZByPXZ1jx8DCCvgXhO69GGzc5AkAi1Rh/qWKEFr3h2OwWjPSdM/04pwTfBb5wyaDciJ4uMqdgUBmYs6gYz6mvX4K3x9DKJRw91J6BkvwCzDaHhRnYSlBWxPOZU0kQhyKwdQ8D4MV5mT/qGnfQVef5tMSwLkQhgHzLHMo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:f61cf261-ed80-4705-9b60-f92d92f214fb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:f4a934e9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2b44a86a000311f185319dbc3099e8fb-20260202
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1426061697; Mon, 02 Feb 2026 14:48:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 14:48:22 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 2 Feb 2026 14:48:22 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <mbrugger@suse.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Qiqi Wang
	<qiqi.wang@mediatek.com>, <sirius.wang@mediatek.com>,
	<vince-wl.liu@mediatek.com>, <jh.hsu@mediatek.com>,
	<irving-ch.lin@mediatek.com>
Subject: [PATCH 2/3] pmdomain: mediatek: Add bus protect control flow for MT8189
Date: Mon, 2 Feb 2026 14:48:14 +0800
Message-ID: <20260202064820.347550-3-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
References: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41877-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irving-ch.lin@mediatek.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]
X-Rspamd-Queue-Id: 80A35C8F17
X-Rspamd-Action: no action

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

In MT8189 mminfra power domain, the bus protect policy separates
into two parts, one is set before subsys clocks enabled, and another
need to enable after subsys clocks enable.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 31 ++++++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  5 ++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 0f0662676c07..3eeb0dabf7d7 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -250,7 +250,7 @@ static int scpsys_bus_protect_set(struct scpsys_domain *pd,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd, u8 flags)
 {
 	for (int i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
 		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
@@ -259,6 +259,10 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 		if (!bpd->bus_prot_set_clr_mask)
 			break;
 
+		if ((bpd->flags & BUS_PROT_IGNORE_SUBCLK) !=
+		    (flags & BUS_PROT_IGNORE_SUBCLK))
+			continue;
+
 		if (bpd->flags & BUS_PROT_INVERTED)
 			ret = scpsys_bus_protect_clear(pd, bpd);
 		else
@@ -270,7 +274,7 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd, u8 flags)
 {
 	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
 		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
@@ -279,6 +283,10 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 		if (!bpd->bus_prot_set_clr_mask)
 			continue;
 
+		if ((bpd->flags & BUS_PROT_IGNORE_SUBCLK) !=
+		    (flags & BUS_PROT_IGNORE_SUBCLK))
+			continue;
+
 		if (bpd->flags & BUS_PROT_INVERTED)
 			ret = scpsys_bus_protect_set(pd, bpd);
 		else
@@ -632,6 +640,15 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret)
 		goto err_pwr_ack;
 
+	/*
+	 * In MT8189 mminfra power domain, the bus protect policy separates
+	 * into two parts, one is set before subsys clocks enabled, and another
+	 * need to enable after subsys clocks enable.
+	 */
+	ret = scpsys_bus_protect_disable(pd, BUS_PROT_IGNORE_SUBCLK);
+	if (ret < 0)
+		goto err_pwr_ack;
+
 	/*
 	 * In few Mediatek platforms(e.g. MT6779), the bus protect policy is
 	 * stricter, which leads to bus protect release must be prior to bus
@@ -648,7 +665,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_disable_subsys_clks;
 
-	ret = scpsys_bus_protect_disable(pd);
+	ret = scpsys_bus_protect_disable(pd, 0);
 	if (ret < 0)
 		goto err_disable_sram;
 
@@ -662,7 +679,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	return 0;
 
 err_enable_bus_protect:
-	scpsys_bus_protect_enable(pd);
+	scpsys_bus_protect_enable(pd, 0);
 err_disable_sram:
 	scpsys_sram_disable(pd);
 err_disable_subsys_clks:
@@ -683,7 +700,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
-	ret = scpsys_bus_protect_enable(pd);
+	ret = scpsys_bus_protect_enable(pd, 0);
 	if (ret < 0)
 		return ret;
 
@@ -697,6 +714,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 
 	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 
+	ret = scpsys_bus_protect_enable(pd, BUS_PROT_IGNORE_SUBCLK);
+	if (ret < 0)
+		return ret;
+
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
 		scpsys_modem_pwrseq_off(pd);
 	else
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index f608e6ec4744..a5dca24cbc2f 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -56,6 +56,7 @@ enum scpsys_bus_prot_flags {
 	BUS_PROT_REG_UPDATE = BIT(1),
 	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
 	BUS_PROT_INVERTED = BIT(3),
+	BUS_PROT_IGNORE_SUBCLK = BIT(4),
 };
 
 enum scpsys_bus_prot_block {
@@ -95,6 +96,10 @@ enum scpsys_bus_prot_block {
 		_BUS_PROT(_hwip, _mask, _set, _clr, _mask, _sta,	\
 			  BUS_PROT_REG_UPDATE)
 
+#define BUS_PROT_WR_IGN_SUBCLK(_hwip, _mask, _set, _clr, _sta)		\
+		_BUS_PROT(_hwip, _mask, _set, _clr, _mask, _sta,	\
+			  BUS_PROT_IGNORE_CLR_ACK | BUS_PROT_IGNORE_SUBCLK)
+
 #define BUS_PROT_INFRA_UPDATE_TOPAXI(_mask)			\
 		BUS_PROT_UPDATE(INFRA, _mask,			\
 				INFRA_TOPAXI_PROTECTEN,		\
-- 
2.45.2


