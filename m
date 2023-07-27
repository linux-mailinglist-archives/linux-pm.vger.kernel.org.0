Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F1765292
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jul 2023 13:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjG0Lgj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jul 2023 07:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjG0Lgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2023 07:36:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F6226BB;
        Thu, 27 Jul 2023 04:36:33 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBTGc5RKzz1GDFM;
        Thu, 27 Jul 2023 19:35:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 19:36:30 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <sre@kernel.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] power: supply: Remove redundant dev_err_probe() for platform_get_irq_byname()
Date:   Thu, 27 Jul 2023 19:35:50 +0800
Message-ID: <20230727113550.2599335-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need to call the dev_err_probe() function directly to print
a custom message when handling an error from platform_get_irq_byname()
function as it is going to display an appropriate error message
in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v2:
- clarify the commit title
---
 drivers/power/supply/mt6370-charger.c       | 4 +---
 drivers/power/supply/qcom_pmi8998_charger.c | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index f27dae5043f5..571cf00dde07 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -849,9 +849,7 @@ static int mt6370_chg_init_irq(struct mt6370_priv *priv)
 		ret = platform_get_irq_byname(to_platform_device(priv->dev),
 					      mt6370_chg_irqs[i].name);
 		if (ret < 0)
-			return dev_err_probe(priv->dev, ret,
-					     "Failed to get irq %s\n",
-					     mt6370_chg_irqs[i].name);
+			return ret;
 
 		priv->irq_nums[i] = ret;
 		ret = devm_request_threaded_irq(priv->dev, ret, NULL,
diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index d16c5ee17249..ce7392e7d8b8 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -922,8 +922,7 @@ static int smb2_init_irq(struct smb2_chip *chip, int *irq, const char *name,
 
 	irqnum = platform_get_irq_byname(to_platform_device(chip->dev), name);
 	if (irqnum < 0)
-		return dev_err_probe(chip->dev, irqnum,
-				     "Couldn't get irq %s byname\n", name);
+		return irqnum;
 
 	rc = devm_request_threaded_irq(chip->dev, irqnum, NULL, handler,
 				       IRQF_ONESHOT, name, chip);
-- 
2.34.1

