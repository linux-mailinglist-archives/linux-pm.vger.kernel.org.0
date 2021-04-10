Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3950A35AB03
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 07:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhDJFKl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Apr 2021 01:10:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38758 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229494AbhDJFKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Apr 2021 01:10:39 -0400
X-UUID: d4727ea75ad749389cfe79d9388bf555-20210410
X-UUID: d4727ea75ad749389cfe79d9388bf555-20210410
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1507264481; Sat, 10 Apr 2021 13:10:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Apr 2021 13:10:20 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Apr 2021 13:10:19 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 4/5] usb: xhci-mtk: use clock bulk to get clocks
Date:   Sat, 10 Apr 2021 13:10:05 +0800
Message-ID: <1618031406-15347-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1618031406-15347-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1618031406-15347-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3408E7EF8C2E42DC0C4F27BD6ECB1B867776072322ACE32B3E880F291C4878E82000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use clock bulk helpers to get/enable/disable clocks, meanwhile
make sys_ck optional, then will be easier to handle clocks.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-mtk.c | 109 +++++++-----------------------------
 drivers/usb/host/xhci-mtk.h |  10 ++--
 2 files changed, 24 insertions(+), 95 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 30927f4064d4..d4c455eecb8d 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -7,7 +7,6 @@
  *  Chunfeng Yun <chunfeng.yun@mediatek.com>
  */
 
-#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -220,89 +219,6 @@ static int xhci_mtk_ssusb_config(struct xhci_hcd_mtk *mtk)
 	return xhci_mtk_host_enable(mtk);
 }
 
-static int xhci_mtk_clks_get(struct xhci_hcd_mtk *mtk)
-{
-	struct device *dev = mtk->dev;
-
-	mtk->sys_clk = devm_clk_get(dev, "sys_ck");
-	if (IS_ERR(mtk->sys_clk)) {
-		dev_err(dev, "fail to get sys_ck\n");
-		return PTR_ERR(mtk->sys_clk);
-	}
-
-	mtk->xhci_clk = devm_clk_get_optional(dev, "xhci_ck");
-	if (IS_ERR(mtk->xhci_clk))
-		return PTR_ERR(mtk->xhci_clk);
-
-	mtk->ref_clk = devm_clk_get_optional(dev, "ref_ck");
-	if (IS_ERR(mtk->ref_clk))
-		return PTR_ERR(mtk->ref_clk);
-
-	mtk->mcu_clk = devm_clk_get_optional(dev, "mcu_ck");
-	if (IS_ERR(mtk->mcu_clk))
-		return PTR_ERR(mtk->mcu_clk);
-
-	mtk->dma_clk = devm_clk_get_optional(dev, "dma_ck");
-	return PTR_ERR_OR_ZERO(mtk->dma_clk);
-}
-
-static int xhci_mtk_clks_enable(struct xhci_hcd_mtk *mtk)
-{
-	int ret;
-
-	ret = clk_prepare_enable(mtk->ref_clk);
-	if (ret) {
-		dev_err(mtk->dev, "failed to enable ref_clk\n");
-		goto ref_clk_err;
-	}
-
-	ret = clk_prepare_enable(mtk->sys_clk);
-	if (ret) {
-		dev_err(mtk->dev, "failed to enable sys_clk\n");
-		goto sys_clk_err;
-	}
-
-	ret = clk_prepare_enable(mtk->xhci_clk);
-	if (ret) {
-		dev_err(mtk->dev, "failed to enable xhci_clk\n");
-		goto xhci_clk_err;
-	}
-
-	ret = clk_prepare_enable(mtk->mcu_clk);
-	if (ret) {
-		dev_err(mtk->dev, "failed to enable mcu_clk\n");
-		goto mcu_clk_err;
-	}
-
-	ret = clk_prepare_enable(mtk->dma_clk);
-	if (ret) {
-		dev_err(mtk->dev, "failed to enable dma_clk\n");
-		goto dma_clk_err;
-	}
-
-	return 0;
-
-dma_clk_err:
-	clk_disable_unprepare(mtk->mcu_clk);
-mcu_clk_err:
-	clk_disable_unprepare(mtk->xhci_clk);
-xhci_clk_err:
-	clk_disable_unprepare(mtk->sys_clk);
-sys_clk_err:
-	clk_disable_unprepare(mtk->ref_clk);
-ref_clk_err:
-	return ret;
-}
-
-static void xhci_mtk_clks_disable(struct xhci_hcd_mtk *mtk)
-{
-	clk_disable_unprepare(mtk->dma_clk);
-	clk_disable_unprepare(mtk->mcu_clk);
-	clk_disable_unprepare(mtk->xhci_clk);
-	clk_disable_unprepare(mtk->sys_clk);
-	clk_disable_unprepare(mtk->ref_clk);
-}
-
 /* only clocks can be turn off for ip-sleep wakeup mode */
 static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
 {
@@ -367,6 +283,19 @@ static void usb_wakeup_set(struct xhci_hcd_mtk *mtk, bool enable)
 		usb_wakeup_ip_sleep_set(mtk, enable);
 }
 
+static int xhci_mtk_clks_get(struct xhci_hcd_mtk *mtk)
+{
+	struct clk_bulk_data *clks = mtk->clks;
+
+	clks[0].id = "sys_ck";
+	clks[1].id = "xhci_ck";
+	clks[2].id = "ref_ck";
+	clks[3].id = "mcu_ck";
+	clks[4].id = "dma_ck";
+
+	return devm_clk_bulk_get_optional(mtk->dev, BULK_CLKS_NUM, clks);
+}
+
 static int xhci_mtk_ldos_enable(struct xhci_hcd_mtk *mtk)
 {
 	int ret;
@@ -522,7 +451,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_pm;
 
-	ret = xhci_mtk_clks_enable(mtk);
+	ret = clk_bulk_prepare_enable(BULK_CLKS_NUM, mtk->clks);
 	if (ret)
 		goto disable_ldos;
 
@@ -625,7 +554,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 
 disable_clk:
-	xhci_mtk_clks_disable(mtk);
+	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
 
 disable_ldos:
 	xhci_mtk_ldos_disable(mtk);
@@ -655,7 +584,7 @@ static int xhci_mtk_remove(struct platform_device *pdev)
 	usb_put_hcd(shared_hcd);
 	usb_put_hcd(hcd);
 	xhci_mtk_sch_exit(mtk);
-	xhci_mtk_clks_disable(mtk);
+	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
 	xhci_mtk_ldos_disable(mtk);
 
 	pm_runtime_disable(dev);
@@ -682,7 +611,7 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
 	if (ret)
 		goto restart_poll_rh;
 
-	xhci_mtk_clks_disable(mtk);
+	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
 	usb_wakeup_set(mtk, true);
 	return 0;
 
@@ -703,7 +632,7 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 	int ret;
 
 	usb_wakeup_set(mtk, false);
-	ret = xhci_mtk_clks_enable(mtk);
+	ret = clk_bulk_prepare_enable(BULK_CLKS_NUM, mtk->clks);
 	if (ret)
 		goto enable_wakeup;
 
@@ -719,7 +648,7 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 	return 0;
 
 disable_clks:
-	xhci_mtk_clks_disable(mtk);
+	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
 enable_wakeup:
 	usb_wakeup_set(mtk, true);
 	return ret;
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 621ec1a85009..11996edc1967 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -9,8 +9,12 @@
 #ifndef _XHCI_MTK_H_
 #define _XHCI_MTK_H_
 
+#include <linux/clk.h>
+
 #include "xhci.h"
 
+#define BULK_CLKS_NUM	5
+
 /**
  * To simplify scheduler algorithm, set a upper limit for ESIT,
  * if a synchromous ep's ESIT is larger than @XHCI_MTK_MAX_ESIT,
@@ -140,11 +144,7 @@ struct xhci_hcd_mtk {
 	int u3p_dis_msk;
 	struct regulator *vusb33;
 	struct regulator *vbus;
-	struct clk *sys_clk;	/* sys and mac clock */
-	struct clk *xhci_clk;
-	struct clk *ref_clk;
-	struct clk *mcu_clk;
-	struct clk *dma_clk;
+	struct clk_bulk_data clks[BULK_CLKS_NUM];
 	struct regmap *pericfg;
 	struct phy **phys;
 	int num_phys;
-- 
2.18.0

