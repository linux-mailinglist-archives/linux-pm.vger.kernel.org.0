Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A80710AA3
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbjEYLOy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 May 2023 07:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbjEYLOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 07:14:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8F1B5
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 04:14:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a0c:5a83:9203:ad00:d93f:618:db35:8dd6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 139116605840;
        Thu, 25 May 2023 12:14:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685013277;
        bh=UiKAWaz+TVBbHcco3PIJzUCzRR4p4Qx9+60xRrdVKYo=;
        h=From:To:Cc:Subject:Date:From;
        b=VSFSPWGOJgn7KTkuUQ73VmY8lj0zR403O84m867RYHL/Vxr9zVFozrNXn3LPvGt7+
         dmG6iLasz6hn2mNTT6Cvus9+2MhrTksJJHM0/mGNXoBU7tjSwuuETY0FqjRLAoGRpo
         Qj40pFp3SVnYBfuSCcA1aZIeWJ57p21xQXbiLAn2wajWiGA7AH0nQv6GbmB+Y/vpTL
         wKZ4EVllIK4L581/gv+4Fg247Wvye1xEjmcblEvrmOIc1VCI+qVucn/hhFhj5AgXTB
         8JgXrmcJL7P+SURMeAnTKKLr37gcEIQCmzte6Uq9bXF1UfYpQvThlw0BuTW6DoUgB+
         XE5U5+oO9mLvg==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     void0red@hust.edu.cn, angelogioacchino.delregno@collabora.com,
        daniel.lezcano@linaro.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"
Date:   Thu, 25 May 2023 13:14:17 +0200
Message-Id: <20230525111417.3350271-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit f05c7b7d9ea9477fcc388476c6f4ade8c66d2d26.

That change was causing a regression in the generic-adc-thermal-probed
bootrr test as reported in the kernelci-results list [1].
A proper rework will take longer, so revert it for now.

[1] https://groups.io/g/kernelci-results/message/42660

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 0b5528804bbd..f59d36de20a0 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1222,12 +1222,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
-	if (IS_ERR(auxadc_base)) {
-		of_node_put(auxadc);
-		return PTR_ERR(auxadc_base);
-	}
-
+	auxadc_base = of_iomap(auxadc, 0);
 	auxadc_phys_base = of_get_phys_base(auxadc);
 
 	of_node_put(auxadc);
@@ -1243,12 +1238,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
-	if (IS_ERR(apmixed_base)) {
-		of_node_put(apmixedsys);
-		return PTR_ERR(apmixed_base);
-	}
-
+	apmixed_base = of_iomap(apmixedsys, 0);
 	apmixed_phys_base = of_get_phys_base(apmixedsys);
 
 	of_node_put(apmixedsys);
-- 
2.25.1

