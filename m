Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048715033FC
	for <lists+linux-pm@lfdr.de>; Sat, 16 Apr 2022 07:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiDPCGs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 22:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiDPCF6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 22:05:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007E694BE
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 18:58:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t15so2102381oie.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 18:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqKd1Orxl/LGzBg+7rmnNDHUMWN7s9B1LCDOy65IlQA=;
        b=N364O5BnRkqe8gLCY6+6Riw2dvoQSe+pV8jWLMWkyKwDJRiXRodeWCF6dOX1MO0Y4x
         l5vzEFdxw764IXFw5pt2I5BaJ+tiXzVWOV0DHxMes3hgEwxVqH25T3a+HXfXVKNmujhX
         hMQBDzRqJbeKLwx5z5Dohu9PQwC4xp2QffevxBiof/Ljud8I/BkLx1YhGNh15rnHV943
         d3fweG1MjzrT+eHTNW/Vt4UAwMp0KpdTnPm+n/SjiieMqWl+NZC15j/By41/vK3ysxGi
         Fmv3PXICjX+HefHAu07XpbCXz3A+PWe8enneamXLGhzN05xmtj+7sxMQyENtpcQY3+mV
         3ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqKd1Orxl/LGzBg+7rmnNDHUMWN7s9B1LCDOy65IlQA=;
        b=vvx+9RCfpucUkt/SZay1qRTMrWC+7ORSoK+GsmXcF+VrgQA3Az5pZ70dybm3fpHIz8
         BrF+NxVVSzOsKln3oXyrKWZDHeBvQkfviDm4XKcO/pC/gXnIvKAuelAyW/tSDVn7/kM6
         uzLkWo+elU73qxSMDcd24uNwgQBAZKkYbODHCV9CFpnaf9Yth9S0pb2Ej0nIwJUF0w/S
         MTznoYtTTgm6txBQTrIOTbNB/dmEParzHm9pFg7OnUTMqMtiixDpB8YlD9anSiz5bWpt
         gaH04my7IDSGyT9Vn3dpONVoIg19KMjG0UAImCYjtbq7X9nwhug4aqvr9xRg49rYn1pN
         JYdw==
X-Gm-Message-State: AOAM532wChXrSA8kGQkkRLhmEVcNtH64/tLD76poYzVniC45dJZUT3VB
        ZwTsNzVLlquTjLjAl31cDPNTbjo2qrxzKzI806aNCw==
X-Google-Smtp-Source: ABdhPJzO4dFfJiTJAfRiEarg+WpfXqOs2uIeFBF1W0TiWPqIMzBObZpTJ1JBTD1oZF/evYqedyW8yQ==
X-Received: by 2002:a17:90b:4d01:b0:1d0:f39f:6073 with SMTP id mw1-20020a17090b4d0100b001d0f39f6073mr1618465pjb.175.1650072405373;
        Fri, 15 Apr 2022 18:26:45 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0050a3bbd36d6sm3313260pfn.204.2022.04.15.18.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:26:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] interconnect: qcom: msm8939: Use icc_sync_state
Date:   Sat, 16 Apr 2022 09:26:34 +0800
Message-Id: <20220416012634.479617-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's fashion to use the icc_sync_state callback to notify the framework
when all consumers are probed, so that the bandwidth request doesn't
need to stay on maximum value.

Do the same thing for msm8939 driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/interconnect/qcom/msm8939.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index f9c2d7d3100d..ca5f611d33b0 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1423,6 +1423,7 @@ static struct platform_driver msm8939_noc_driver = {
 	.driver = {
 		.name = "qnoc-msm8939",
 		.of_match_table = msm8939_noc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(msm8939_noc_driver);
-- 
2.25.1

