Return-Path: <linux-pm+bounces-14060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50132975FC0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 05:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169D4282555
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 03:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ADD1EB2A;
	Thu, 12 Sep 2024 03:32:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D67581B
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111964; cv=none; b=V7lSdPwNI0e89lXikrjBrempgvYQ0kvFaAtPDxMplmTWA8TxfeHJ/Ntb+q37BCL2DM9hxdWiDeuTSQaORW6g+ZQBA1zoMOvHbFX/LSIxl19LzDay6KQkzg8k3zA4nKF5gWu52Q2rMuFoD+UApLjfjw5qgHjhKIru6HHajKKXMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111964; c=relaxed/simple;
	bh=YXNMX1hZalPdipd47CBIMy3zbxYJGT9dTLn8D2yyMec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkZe7RZhIVMM8ItAUr4IOJLZSmeEXxbN3yhpuXeIWyuny4meB1YeP+Ddxp/EPuP29VHnxX9zQeh3F/BlHuFPjo05KkPDbbO12jA+ZR19XcUctGO22Tf+koklJBoYh9mEzMWvHhBBrFV3BOEnE8599W4GdB9Ojr/MSRtUJ30G1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X42zS0Qkdz1P9LC;
	Thu, 12 Sep 2024 11:31:32 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A70F140453;
	Thu, 12 Sep 2024 11:32:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Sep
 2024 11:32:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <nm@ti.com>, <ssantosh@kernel.org>, <khilman@ti.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] soc: ti: smartreflex: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Thu, 12 Sep 2024 11:41:47 +0800
Message-ID: <20240912034147.3014213-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

If request_irq() fails in sr_late_init(), there is no need to enable
the irq, and if it succeeds, disable_irq() after request_irq() still has
a time gap in which interrupts can come.

request_irq() with IRQF_NO_AUTOEN flag will disable IRQ auto-enable when
request IRQ.

Fixes: 1279ba5916f6 ("OMAP3+: SR: disable interrupt by default")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/soc/ti/smartreflex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index d6219060b616..38add2ab5613 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -202,10 +202,10 @@ static int sr_late_init(struct omap_sr *sr_info)
 
 	if (sr_class->notify && sr_class->notify_flags && sr_info->irq) {
 		ret = devm_request_irq(&sr_info->pdev->dev, sr_info->irq,
-				       sr_interrupt, 0, sr_info->name, sr_info);
+				       sr_interrupt, IRQF_NO_AUTOEN,
+				       sr_info->name, sr_info);
 		if (ret)
 			goto error;
-		disable_irq(sr_info->irq);
 	}
 
 	return ret;
-- 
2.34.1


