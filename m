Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3B65BA23
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 05:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjACE52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 23:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjACE5W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 23:57:22 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8E8B7E6
        for <linux-pm@vger.kernel.org>; Mon,  2 Jan 2023 20:57:20 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id z26so44174261lfu.8
        for <linux-pm@vger.kernel.org>; Mon, 02 Jan 2023 20:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=032AleYKwYBfKPehAkrDGenXwgSPtz3uJUu4le8LKMc=;
        b=lFrCd8Mwwx57UQRYDLwiNFuDZNpzzYyFKc6Bg0c4hz1+VUfURjwMxXq+we23rxXipu
         x5aTH9qXEN9JxeKj7Tk5yfbtGE7iZBTfxMffSUkKWEF6d/7tZpq5ToR0BId4XzPZvmLH
         BcmcgdgRRkve5V6Pru5fazsTeU8LfG+ltHjPpSqdLh2MQwYn/gpm4m2qHNRzDJX9V+vY
         sNlcm1QmqjodEPGgwDiUmUZ8QZ68QtJ+Gt7JsGYGM01fPL9KbYSLq2j050CjIuwWEpAW
         m0RjcmVkXPTZAyME1vZoN+i+KVpTOS9TiGwLSLYOypkWNPZiqPMmBDuzLRjXt+EQ2ZiL
         pXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=032AleYKwYBfKPehAkrDGenXwgSPtz3uJUu4le8LKMc=;
        b=SLO68Az9IO1bOzmIfi2dgAH5aMx18+42knhvsW9PRqdCTh3gqvK8VGFi4YxKhmWiYL
         zaVkT5EJ6UL7b8TYIRBQgVKfsOb9ZRhWxgo4o4e+295cbAzY3Y7EGMkvduTeT/GCkEmg
         FMFcOnOFQzxA5olDBxYnT4DNLJhA7QlhtrBTw7txSxVgWPPyCWi/uYOgEKlIM5a/VQjC
         4o23mD6w9A20Prz5mU3eQcHrrGMgety6pLmSqdZCgYj4aZrkGUnw5ujGtKxtbA8JmIMf
         m1cEapdAXsLam9TxQ9TiQ46hX1zE/1wEgjxjho4uMQlZzhbzQTKjsNX9LeG2GL86S9ZD
         xCUw==
X-Gm-Message-State: AFqh2kqUCGrcG7YLwKvRuxKvbSd7rIdwL0i9jqq6ziUf2MghVKNhpuvQ
        J1wiDjO2DYc27X/cx3rT/0xk8g==
X-Google-Smtp-Source: AMrXdXtlJGFF8EVeegodK0AhKIktQmt6sVGC0J0pRQSxmmPRjZk7zKnSNTtan9Pa0vLwh5tsWJ/TkA==
X-Received: by 2002:a05:6512:168d:b0:4ca:fd5f:ce82 with SMTP id bu13-20020a056512168d00b004cafd5fce82mr9663992lfb.49.1672721838408;
        Mon, 02 Jan 2023 20:57:18 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id y26-20020a0565123f1a00b00494603953b6sm4714819lfa.6.2023.01.02.20.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 20:57:17 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: drop obsolete OSM_L3/EPSS defines
Date:   Tue,  3 Jan 2023 06:57:17 +0200
Message-Id: <20230103045717.1079067-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since Qualcomm platforms have switched to the separate OSM_L3/EPSS
driver, old related defines became unused. Drop them now.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Fixes: 4529992c9474 ("interconnect: qcom: osm-l3: Use platform-independent node ids")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sc7180.h  | 2 --
 drivers/interconnect/qcom/sc7280.h  | 2 --
 drivers/interconnect/qcom/sc8180x.h | 2 --
 drivers/interconnect/qcom/sdm845.h  | 2 --
 drivers/interconnect/qcom/sm8150.h  | 2 --
 drivers/interconnect/qcom/sm8250.h  | 2 --
 6 files changed, 12 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.h b/drivers/interconnect/qcom/sc7180.h
index c6212a10c2f6..c2d8388bb880 100644
--- a/drivers/interconnect/qcom/sc7180.h
+++ b/drivers/interconnect/qcom/sc7180.h
@@ -145,7 +145,5 @@
 #define SC7180_SLAVE_SERVICE_SNOC			134
 #define SC7180_SLAVE_QDSS_STM				135
 #define SC7180_SLAVE_TCU				136
-#define SC7180_MASTER_OSM_L3_APPS			137
-#define SC7180_SLAVE_OSM_L3				138
 
 #endif
diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
index 1fb9839b2c14..175e400305c5 100644
--- a/drivers/interconnect/qcom/sc7280.h
+++ b/drivers/interconnect/qcom/sc7280.h
@@ -150,7 +150,5 @@
 #define SC7280_SLAVE_PCIE_1			139
 #define SC7280_SLAVE_QDSS_STM			140
 #define SC7280_SLAVE_TCU			141
-#define SC7280_MASTER_EPSS_L3_APPS		142
-#define SC7280_SLAVE_EPSS_L3			143
 
 #endif
diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qcom/sc8180x.h
index 2eafd35543c7..ce32295af8f3 100644
--- a/drivers/interconnect/qcom/sc8180x.h
+++ b/drivers/interconnect/qcom/sc8180x.h
@@ -168,8 +168,6 @@
 #define SC8180X_SLAVE_EBI_CH0_DISPLAY		158
 #define SC8180X_SLAVE_MNOC_SF_MEM_NOC_DISPLAY	159
 #define SC8180X_SLAVE_MNOC_HF_MEM_NOC_DISPLAY	160
-#define SC8180X_MASTER_OSM_L3_APPS		161
-#define SC8180X_SLAVE_OSM_L3			162
 
 #define SC8180X_MASTER_QUP_CORE_0		163
 #define SC8180X_MASTER_QUP_CORE_1		164
diff --git a/drivers/interconnect/qcom/sdm845.h b/drivers/interconnect/qcom/sdm845.h
index 776e9c2acb27..bc7e425ce985 100644
--- a/drivers/interconnect/qcom/sdm845.h
+++ b/drivers/interconnect/qcom/sdm845.h
@@ -136,7 +136,5 @@
 #define SDM845_SLAVE_SERVICE_SNOC			128
 #define SDM845_SLAVE_QDSS_STM				129
 #define SDM845_SLAVE_TCU				130
-#define SDM845_MASTER_OSM_L3_APPS			131
-#define SDM845_SLAVE_OSM_L3				132
 
 #endif /* __DRIVERS_INTERCONNECT_QCOM_SDM845_H__ */
diff --git a/drivers/interconnect/qcom/sm8150.h b/drivers/interconnect/qcom/sm8150.h
index 97996f64d799..3e01ac76ae1d 100644
--- a/drivers/interconnect/qcom/sm8150.h
+++ b/drivers/interconnect/qcom/sm8150.h
@@ -148,7 +148,5 @@
 #define SM8150_SLAVE_VSENSE_CTRL_CFG		137
 #define SM8150_SNOC_CNOC_MAS			138
 #define SM8150_SNOC_CNOC_SLV			139
-#define SM8150_MASTER_OSM_L3_APPS		140
-#define SM8150_SLAVE_OSM_L3			141
 
 #endif
diff --git a/drivers/interconnect/qcom/sm8250.h b/drivers/interconnect/qcom/sm8250.h
index b31fb431a20f..7eb6c709c30d 100644
--- a/drivers/interconnect/qcom/sm8250.h
+++ b/drivers/interconnect/qcom/sm8250.h
@@ -158,7 +158,5 @@
 #define SM8250_SLAVE_VSENSE_CTRL_CFG		147
 #define SM8250_SNOC_CNOC_MAS			148
 #define SM8250_SNOC_CNOC_SLV			149
-#define SM8250_MASTER_EPSS_L3_APPS		150
-#define SM8250_SLAVE_EPSS_L3			151
 
 #endif
-- 
2.39.0

