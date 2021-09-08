Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821E6403506
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349461AbhIHHOr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 03:14:47 -0400
Received: from mx20.baidu.com ([111.202.115.85]:59898 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349763AbhIHHOj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:14:39 -0400
Received: from BC-Mail-Ex24.internal.baidu.com (unknown [172.31.51.18])
        by Forcepoint Email with ESMTPS id 04F4C5EBB9B52C2583AC;
        Wed,  8 Sep 2021 15:13:30 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex24.internal.baidu.com (172.31.51.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:13:29 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:13:29 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 3/3] soc: ti: wkup_m3_ipc: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 15:13:09 +0800
Message-ID: <20210908071310.432-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908071310.432-1-caihuoqing@baidu.com>
References: <20210908071310.432-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 09abd17065ba..388ffbee30a1 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -435,7 +435,6 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	int irq, ret;
 	phandle rproc_phandle;
 	struct rproc *m3_rproc;
-	struct resource *res;
 	struct task_struct *task;
 	struct wkup_m3_ipc *m3_ipc;
 
@@ -443,8 +442,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	if (!m3_ipc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	m3_ipc->ipc_mem_base = devm_ioremap_resource(dev, res);
+	m3_ipc->ipc_mem_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(m3_ipc->ipc_mem_base))
 		return PTR_ERR(m3_ipc->ipc_mem_base);
 
-- 
2.25.1

