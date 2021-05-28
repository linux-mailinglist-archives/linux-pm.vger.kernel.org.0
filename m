Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD11239422D
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhE1Lw4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 07:52:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41007 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhE1Lwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 07:52:55 -0400
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmb1L-0003yy-0I
        for linux-pm@vger.kernel.org; Fri, 28 May 2021 11:51:19 +0000
Received: by mail-ua1-f70.google.com with SMTP id z43-20020a9f372e0000b029020dcb32d820so1804114uad.2
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 04:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxELusyIBpP+fcpz/UatIhkxqx6ZEHw/DrcqLu/q/aE=;
        b=lguwOczczSbMdYLvrtPcnJLR5M1OYvwYMtAZ+EgRzFPP0CyJgI1CsmOgsGi/9quI5N
         CKit82YYNJcmKmLNK3X4Qf1OE3wjVdxR01LCCRd5I6U9NJb6vThrIN5ZNNMbAChsSStC
         jG4KzqxS9gTm65e8wTCaX81P0r5YdnGFivsVHj3zDGHEDz7MnA1cCH+6gCwpsGBBgZoF
         1hkH8wqlyEQtty6An1MNKz4C2wN2qMQjMI2O9P/hGQ1uzovlFDhHluNyRkLW7bRBBXB4
         z/ArAYG3U9Zuy5k0yt3qHJ03wRlbFvVct5pVtE2lYojebrN98fVb/zw+UDQHOh9pv5r7
         VzTA==
X-Gm-Message-State: AOAM530EC0JBqGND4rnHQcyAjJIo5b9n9N9PGeg1SYZX1mAGDMZlGE4A
        Uku/JukcUDCnSBz6gi2Q1Zh2df6Sj63uaLRpH+rfJ+ZiGc2PpfuqBFv4riDsDYeQEGMvfhr1A38
        Yz0rJjKYhZNcynP/IkwKoc0YlYJLzKxDuN7ef
X-Received: by 2002:a05:6102:31b7:: with SMTP id d23mr6244278vsh.56.1622202678192;
        Fri, 28 May 2021 04:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHV9HC0ax8TsVv9E9U2CrKXRWFKJ3kwO0G5xeZeFJCvWLuvkFRNODMIQwC/X1QAj1earJCHQ==
X-Received: by 2002:a05:6102:31b7:: with SMTP id d23mr6244268vsh.56.1622202677969;
        Fri, 28 May 2021 04:51:17 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id 189sm669831vkz.51.2021.05.28.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:51:17 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [RESEND PATCH 1/2] thermal: imx_sc: add missing of_node_put for loop iteration
Date:   Fri, 28 May 2021 07:50:35 -0400
Message-Id: <20210528115036.18222-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/thermal/imx_sc_thermal.c:93:1-33: WARNING:
    Function "for_each_available_child_of_node" should have of_node_put() before return around line 97.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/thermal/imx_sc_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index b01d28eca7ee..8d76dbfde6a9 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -93,6 +93,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(np, child) {
 		sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
 		if (!sensor) {
+			of_node_put(child);
 			of_node_put(sensor_np);
 			return -ENOMEM;
 		}
@@ -104,6 +105,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to get valid sensor resource id: %d\n",
 				ret);
+			of_node_put(child);
 			break;
 		}
 
@@ -114,6 +116,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(sensor->tzd)) {
 			dev_err(&pdev->dev, "failed to register thermal zone\n");
 			ret = PTR_ERR(sensor->tzd);
+			of_node_put(child);
 			break;
 		}
 
-- 
2.27.0

