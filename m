Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBEA4E3FF1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Mar 2022 15:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiCVOBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiCVOBg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 10:01:36 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F85A22BFA
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 07:00:08 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so12558539oti.5
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhV/UvJLA9aEbgbUmNXWEs6slMcShtpmST367S/Aknc=;
        b=A4oRipkn4qkoQLqZNivoplGznH3jkQeq/o0FwSAYbIABJE8Zik56YujioOK1uYcYYN
         8/JG8/xyWBIl1DQulgypbWZWN7rBgLN1OzZJpBh1CN8ngAsIPJyIMeJyuzq169yiBKwE
         6Ljxdj9ujsTrDalA92SLhoilGRQzEt/M23tGEMhTdWziMxNSFjqy4O2KjKtLC2IN70IJ
         oEk1gUwHs6XNpGI2+DkutS4By3lfxIX8uXC68lXtSOdF1DDbtE78NsAKhYCdeV5SR3at
         w7DsQrOFgSBeVRUkMJyyL/3+cE6774YNoCN1GIA8CKVq+AnuDMm/tkEepFA3nMyiQby2
         PRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhV/UvJLA9aEbgbUmNXWEs6slMcShtpmST367S/Aknc=;
        b=rEsT58fjfJpUb8V4NbuQ0pPR3GJMx1YZIoY4shxhMxDw1HgX9H952QiwC09dtfw0oC
         Kbhmi+DXozznQsnfE3vuCaLZCa/SriRpQ7x4G0iIhuktuGuv6obRqNFqYF63+s46HM2R
         2G+g0QU70hPwQBOgBrWObFqPbc+fGs4f0mqkbSXskPlP0BWpktpfSWmbIDBudwqEp0ms
         WU9SSzO/34mDycOShWIcInfQMSGv2qob+NJtp9FeNg/0NOMhMSKPXd9QpEs9MKn1YOeM
         K8ia+5Zdghb39XIHZZmgTYGbCJQvsULAEORNZi8FXfXwlzzE+hlOHMK09Qs4xW38v1sS
         QPeQ==
X-Gm-Message-State: AOAM530Co2qNAUgcO3JrfAJg7QZ4KqRRXXiicx1UKt82RlKE4dB+DhKr
        35XjWJ6K17hpvf4naXhM7ba3Wn8brHU=
X-Google-Smtp-Source: ABdhPJz4sEJ0Sstswg3OgfIfKKpLw9PTBBvWiSMJmQ/yR/aOBvUgnb0+rfbsDvzhfuijkaAxfT3noQ==
X-Received: by 2002:a05:6830:2425:b0:5c9:6ea3:1c08 with SMTP id k5-20020a056830242500b005c96ea31c08mr9856439ots.300.1647957607257;
        Tue, 22 Mar 2022 07:00:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:4b69:325a:b5cb:befa:b0e4])
        by smtp.gmail.com with ESMTPSA id v24-20020a9d5a18000000b005ad458facbdsm8973468oth.27.2022.03.22.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:00:06 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] thermal: imx: Disambiguate the error message
Date:   Tue, 22 Mar 2022 10:59:37 -0300
Message-Id: <20220322135937.304801-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

When the "failed to read sensor data" error message is shown, the
user does not know if it comes after reading the OCOTP_ANA1 or
the OCOTP_MEM0 register.

Disambiguate the error message by adding the register name to it.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/thermal/imx_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..dbc4bca1b68c 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -527,7 +527,7 @@ static int imx_init_from_tempmon_data(struct platform_device *pdev)
 
 	ret = regmap_read(map, OCOTP_ANA1, &val);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
+		dev_err(&pdev->dev, "failed to read OCOTP_ANA1: %d\n", ret);
 		return ret;
 	}
 	ret = imx_init_calib(pdev, val);
@@ -536,7 +536,7 @@ static int imx_init_from_tempmon_data(struct platform_device *pdev)
 
 	ret = regmap_read(map, OCOTP_MEM0, &val);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
+		dev_err(&pdev->dev, "failed to read OCOTP_MEM0: %d\n", ret);
 		return ret;
 	}
 	imx_init_temp_grade(pdev, val);
-- 
2.25.1

