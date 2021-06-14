Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B893A6EDB
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 21:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhFNTYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 15:24:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhFNTYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 15:24:39 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lssAM-0007us-RK
        for linux-pm@vger.kernel.org; Mon, 14 Jun 2021 19:22:34 +0000
Received: by mail-ed1-f72.google.com with SMTP id x8-20020aa7d3880000b029038fe468f5f4so20684812edq.10
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 12:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v40f0IMWX+9KE3fNiPgtmRZ6Kg5WkPKxY6VfG/sZNRE=;
        b=JGSpU27JRe2oA+PEBdMzjTVg4J71PbekxtafctHnTCXbMSchHlz/urvkzU8u87qHux
         KRkcNW8IcPqFlXEoviucFkcGdqDJRddRh7RMrZsV0aLvsuMMQZBgiBpiQuYrqWhiF2aZ
         8+ksTDuf6WG8mnsMNpaObrYxrvrHCyPktKvTr+qpynYU4dmlHdsVdHILguMLT/mQlqiN
         65VBUO1trZg9z5hZSwXKgfee6NBcoYShnN1trIjLe8+EPq10MducN28l3rtClI+HLovM
         vsxebhl3e2YxdwdEpun7MBxox+pxNjyss0mbYzpRxsw1Yzgn3DV8SOcWRsm0vi+0xpu3
         f5Zg==
X-Gm-Message-State: AOAM532B32vzJbuDdmmtll7KcqFdjnEyTL43G2QRfTiO/bvhK1in3wX4
        ESmhjGC6s7y6AlZMqiKS74NIBaOCxushF7vnkfLbLTguMh7AceV4DSmXclM38z0B4J31WZKjoFV
        +6Q9hsoejWbwo8HcHawuKWVbG7Jvxvk+qbMnI
X-Received: by 2002:a05:6402:1111:: with SMTP id u17mr19112858edv.87.1623698554629;
        Mon, 14 Jun 2021 12:22:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGsYd69QUu+wFqDQnnw+BdpeP2+5cS8DUuCzeANpDr3eNbkYiQwXJf7g8EICQsTP83XB2tBQ==
X-Received: by 2002:a05:6402:1111:: with SMTP id u17mr19112845edv.87.1623698554460;
        Mon, 14 Jun 2021 12:22:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n23sm9071365edr.46.2021.06.14.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:22:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 2/2] thermal: sprd: add missing of_node_put for loop iteration
Date:   Mon, 14 Jun 2021 21:22:30 +0200
Message-Id: <20210614192230.19248-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210614192230.19248-1-krzysztof.kozlowski@canonical.com>
References: <20210614192230.19248-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/thermal/sprd_thermal.c:387:1-23: WARNING:
    Function "for_each_child_of_node" should have of_node_put() before goto around lines 391.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

---

Changes since v1:
1. Add of_put label as suggested by Daniel.
---
 drivers/thermal/sprd_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 3682edb2f466..76a2caa9c265 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -388,7 +388,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
 		if (!sen) {
 			ret = -ENOMEM;
-			goto disable_clk;
+			goto of_put;
 		}
 
 		sen->data = thm;
@@ -397,13 +397,13 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(sen_child, "reg", &sen->id);
 		if (ret) {
 			dev_err(&pdev->dev, "get sensor reg failed");
-			goto disable_clk;
+			goto of_put;
 		}
 
 		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
 		if (ret) {
 			dev_err(&pdev->dev, "efuse cal analysis failed");
-			goto disable_clk;
+			goto of_put;
 		}
 
 		sprd_thm_sensor_init(thm, sen);
@@ -416,19 +416,20 @@ static int sprd_thm_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
 			ret = PTR_ERR(sen->tzd);
-			goto disable_clk;
+			goto of_put;
 		}
 
 		thm->sensor[sen->id] = sen;
 	}
+	/* sen_child set to NULL at this point */
 
 	ret = sprd_thm_set_ready(thm);
 	if (ret)
-		goto disable_clk;
+		goto of_put;
 
 	ret = sprd_thm_wait_temp_ready(thm);
 	if (ret)
-		goto disable_clk;
+		goto of_put;
 
 	for (i = 0; i < thm->nr_sensors; i++)
 		sprd_thm_toggle_sensor(thm->sensor[i], true);
@@ -436,6 +437,8 @@ static int sprd_thm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, thm);
 	return 0;
 
+of_put:
+	of_node_put(sen_child);
 disable_clk:
 	clk_disable_unprepare(thm->clk);
 	return ret;
-- 
2.27.0

