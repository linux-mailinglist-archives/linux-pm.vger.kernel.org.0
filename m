Return-Path: <linux-pm+bounces-39513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AFDCBC69C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 04:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1EF330102B1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 03:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B81C322B71;
	Mon, 15 Dec 2025 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="exij0irm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233E31AA8C;
	Mon, 15 Dec 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770614; cv=none; b=qwgWgoWaAzKiYY0cjSa2LLbsLdXmmwkHL3ok5njvj4o6qCnEBihz/pdB8YK6rFt1TOgXRj8WqjgcbrbnSoZ7a00Xi9MzL991EOiAxslEj1s8DPNqDhKUE0ZHFFoXQoUT14XDzL4sLi+6fZq92SxAlJzfWsv86He+1eMmRt9aDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770614; c=relaxed/simple;
	bh=DrsYZkiQamWiz0bhf8SHSyd7Rqn5xahi9uYwbgRuYzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nok6/ukxgFPlHkTWxqlsD4RwCctj1B9E7BLNd4QG3eCLuS9wK08UiIWKjrtKip5wjpLlnVpHmnb3x4OD3mY9NwgI6m3DhFD54K+sygv0Fuc7GJaWDLtBbJWGSJOeLRfuVrDyHPdcqcWCt7IkJ5qNMyEUbw1Dt39bLu/gI7kOHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=exij0irm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1cf43336d96911f0b33aeb1e7f16c2b6-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5VqqEAsneNFYY8k+GNal8ibP1/hmLNkCH05sJ3ZMoVw=;
	b=exij0irmpi0KKBZyi50mmAoTRqQWQSI4DfTOkwKU/BKYl2Cg6OnCwgvnNcAHFwV00D9TkhvwkVvrh8i/hSRkbo2M1kfwpJsSc1biDorXJ0874fFlHGtBcGXKZpgMtGojvT9EBQ0dUIvNQgAZPRH+ybqIY3vSGBixvXpy6aVMGX8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d535338d-bf75-4bf6-8577-18ceb2da1ad1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:b9078528-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1cf43336d96911f0b33aeb1e7f16c2b6-20251215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 597555356; Mon, 15 Dec 2025 11:49:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 11:49:51 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 11:49:51 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Richard Cochran <richardcochran@gmail.com>
CC: Qiqi Wang <qiqi.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <irving-ch.lin@mediatek.com>
Subject: [PATCH v4 03/21] clk: mediatek: clk-mux: Make sure bypass clk enabled while setting MFG rate
Date: Mon, 15 Dec 2025 11:49:12 +0800
Message-ID: <20251215034944.2973003-4-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
References: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Enable bypass clock before MFG changing rate, to make sure
MFG reference clock available during transient.

Fixes: b66add7a74e8 ("clk: mediatek: mux: add clk notifier functions")
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/clk-mux.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index c5af6dc078a3..07f1f18b38bc 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -414,16 +414,21 @@ static int mtk_clk_mux_notifier_cb(struct notifier_block *nb,
 	struct clk_notifier_data *data = _data;
 	struct clk_hw *hw = __clk_get_hw(data->clk);
 	struct mtk_mux_nb *mux_nb = to_mtk_mux_nb(nb);
+	struct clk_hw *p_hw = clk_hw_get_parent_by_index(hw, mux_nb->bypass_index);
 	int ret = 0;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		mux_nb->original_index = mux_nb->ops->get_parent(hw);
-		ret = mux_nb->ops->set_parent(hw, mux_nb->bypass_index);
+		ret = clk_prepare_enable(p_hw->clk);
+		if (ret == 0) {
+			mux_nb->original_index = mux_nb->ops->get_parent(hw);
+			ret = mux_nb->ops->set_parent(hw, mux_nb->bypass_index);
+		}
 		break;
 	case POST_RATE_CHANGE:
 	case ABORT_RATE_CHANGE:
 		ret = mux_nb->ops->set_parent(hw, mux_nb->original_index);
+		clk_disable_unprepare(p_hw->clk);
 		break;
 	}
 
-- 
2.45.2


