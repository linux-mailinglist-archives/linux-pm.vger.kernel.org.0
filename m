Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D0039FB7D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 18:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhFHQCF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhFHQB4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 12:01:56 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Jun 2021 09:00:03 PDT
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4EEC061574;
        Tue,  8 Jun 2021 09:00:03 -0700 (PDT)
Received: from mxout4.routing.net (unknown [192.168.10.112])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 37DED2C52D;
        Tue,  8 Jun 2021 15:45:55 +0000 (UTC)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout4.routing.net (Postfix) with ESMTP id 619DA10081F;
        Tue,  8 Jun 2021 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1623167148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=98Qit1hMtPHZc/TS5dL5TLvDSnXeL0iSq1KTlz2Fj4Y=;
        b=Iuhw/LqB8uiWEGDmraAJxW1QmzpUpi9yQ86fUmAiLQUYrSGgN4y3cP6HCt6VbhsVuZriB4
        JmcWW72XI53HVnl+QAB2sqy9KFdUuPMx5Whv0Mu+fyuAq3mVQQPjx+oKgHgcYmnQF6r7Dd
        fuq4cYG7k3Z18G1o0qLI1U7pTEGpmEo=
Received: from localhost.localdomain (fttx-pool-217.61.145.142.bambit.de [217.61.145.142])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id AA073804E7;
        Tue,  8 Jun 2021 15:45:47 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] thermal: mediatek: add sensors-support
Date:   Tue,  8 Jun 2021 17:45:30 +0200
Message-Id: <20210608154530.70074-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 8400b1d9-070e-406d-af5d-86a2ada1c8ff
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

add HWMON-support to mediateks thermal driver to allow lm-sensors
userspace tools read soc temperature

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4: change message to dev_warn as suggested by matthias
v3: drop no_hwmon
v2: drop ifdef and used devm_thermal_add_hwmon_sysfs
---
 drivers/thermal/mtk_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 97e8678ccf0e..ede94eadddda 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -23,6 +23,8 @@
 #include <linux/reset.h>
 #include <linux/types.h>
 
+#include "thermal_hwmon.h"
+
 /* AUXADC Registers */
 #define AUXADC_CON1_SET_V	0x008
 #define AUXADC_CON1_CLR_V	0x00c
@@ -1087,6 +1089,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_peri_therm;
 	}
 
+	ret = devm_thermal_add_hwmon_sysfs(tzdev);
+	if (ret)
+		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
+
 	return 0;
 
 err_disable_clk_peri_therm:
-- 
2.25.1

