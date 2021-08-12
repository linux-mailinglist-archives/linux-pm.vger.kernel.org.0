Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097BA3EA147
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhHLJAy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 05:00:54 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37410 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235640AbhHLJAw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 05:00:52 -0400
X-UUID: fbd0b11f1bc74afb8c0d166959dae109-20210812
X-UUID: fbd0b11f1bc74afb8c0d166959dae109-20210812
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1784395742; Thu, 12 Aug 2021 17:00:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 17:00:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 17:00:23 +0800
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Dawei Chien <dawei.chien@mediatek.com>
Subject: [V11,PATCH 14/19] interconnect: mediatek: add initial bandwidth
Date:   Thu, 12 Aug 2021 16:58:41 +0800
Message-ID: <20210812085846.2628-15-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210812085846.2628-1-dawei.chien@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

support get_bw function for suitable initial bandwidth

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 drivers/interconnect/mediatek/mtk-emi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/interconnect/mediatek/mtk-emi.c b/drivers/interconnect/mediatek/mtk-emi.c
index 379dab77ebfd..80e2707698be 100644
--- a/drivers/interconnect/mediatek/mtk-emi.c
+++ b/drivers/interconnect/mediatek/mtk-emi.c
@@ -271,6 +271,14 @@ static int emi_icc_set(struct icc_node *src, struct icc_node *dst)
 	return ret;
 }
 
+static int emi_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
 static int emi_icc_remove(struct platform_device *pdev);
 static int emi_icc_probe(struct platform_device *pdev)
 {
@@ -308,6 +316,7 @@ static int emi_icc_probe(struct platform_device *pdev)
 	provider->set = emi_icc_set;
 	provider->aggregate = emi_icc_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
+	provider->get_bw = emi_icc_get_bw;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
-- 
2.14.1

