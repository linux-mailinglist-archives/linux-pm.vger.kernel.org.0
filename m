Return-Path: <linux-pm+bounces-480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D386F7FD820
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BDE1F20F9B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B787020327;
	Wed, 29 Nov 2023 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lCt70qak"
X-Original-To: linux-pm@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F236A8;
	Wed, 29 Nov 2023 05:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=JmdW2UbTrTOnM62ANw
	uP4zK8vG4e8luOaqLCxOa+6iE=; b=lCt70qak/pKxGklw11WVuUaz8mDHx0oBkJ
	ITlE86LnkPfuf9V+QHYKWn6+FS7HHy6m9KaWQYPc0BAoOizXwFAy6ecjzfG6MYvD
	+sexrsV0sNZWil+pRJh8+/RefVIBy55LoAnJM6woHtqC1EwGXkeUO9hSjb0FsIZs
	nBV3nd+IA=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wDXnx3FPGdlfoIgBQ--.49480S2;
	Wed, 29 Nov 2023 21:29:43 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: claudiu.beznea@tuxon.dev
Cc: sre@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [power/reset] at91-sama5d2: Add error handling in at91_shdwc_probe
Date: Wed, 29 Nov 2023 05:29:39 -0800
Message-Id: <20231129132939.34047-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXnx3FPGdlfoIgBQ--.49480S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4xCw15uF4UWFW3WFWruFg_yoWkGFc_Xw
	47AFWIya47KF1v9FnavwnIvrZ7CrnrXryDXF18tr93uryDWw4DtrsFvr4DXFs5Xa4UCrs8
	tF4DtF4rZF1xXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMGYLJUUUUU==
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZQs3gl8ZaQ8awgABsi
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

This patch adds error handling to the at91_shdwc_probe function
in drivers/power/reset/at91-sama5d2_shdwc.c. The function
previously did not handle the case where of_match_node could fail,
potentially leading to unexpected behavior if the device tree match
was unsuccessful.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index e76b102b57b1..2ac566c83aec 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -353,6 +353,11 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 		return PTR_ERR(at91_shdwc->shdwc_base);
 
 	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
+	if (!match) {
+		dev_err(&pdev->dev, "No matching device found\n");
+		return -ENODEV;
+	}
+
 	at91_shdwc->rcfg = match->data;
 
 	at91_shdwc->sclk = devm_clk_get(&pdev->dev, NULL);
-- 
2.17.1


