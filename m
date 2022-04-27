Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AA5511B86
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiD0O7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiD0O7e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 10:59:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFCC7247A
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 07:56:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bv19so3938074ejb.6
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kzcmQQ6qe9BuAfgJ/H9FnVAxTClpIB9Ec1O4pt+pto=;
        b=SuM2kKvg9MIOsrbRnXK49sswjYDmhNL5auXZSawiQyqu/3r96paw8FAO/3qj4Q/cJ8
         QYQrKWJdSqC8sHYmnj3Ta4awWKPn4feNlwgOplnY7O9t/jqCVdEUVFAP5imygZIAANnr
         MT+u4rZ8Ba81rIDlGcH2OVlTjOJklsHfmI/CvtwDKGXyxegRBceREqeeVyyVY+NdL1yi
         48cfxCNoL2cXq0oZV0ZSE1VeyCIF54D3kppj5UtOzfj51E71+6ttlj1FBAsklxpRdBWu
         Id+SYXX+XrwwMOYDLDN7Sxv6Zzl7dmcpeukJ4DRd47WwLDuP8LwIWVeT1R8N0zs12UHs
         OdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kzcmQQ6qe9BuAfgJ/H9FnVAxTClpIB9Ec1O4pt+pto=;
        b=PrbKdpVoQiuAsmGY6LJscCb+vu0bcUkBGwUvv5Lxt5SWAw7Ko5Y83L589MTzhXjIX0
         ArdjtoadH0H4NXRj+KKGQdb44Ce7Y97P9ozyXW0V8+E38LM13Jwl79GGd/6L7mMSK1eu
         Tl5NOTu8xFs7HNy+n9DMFd5Y/4HKnFnF71jgTwitH3uCHQOkpios3K9WPII2KRmjrfnu
         Fo15d1Ayh12UT65n6+d1q6RPwKF5fmeuajJK0XIq31pu+CBFKP0qDUyCB36bXQfflHy6
         p8GFeZIFkjxm7/bzC8nEGKoaSYB9As9NoO1Seh4Ny3GcHT0TQvwYe02PNu7MZL9lkTdD
         FhPg==
X-Gm-Message-State: AOAM5322vRhGF2y8NZZpfesqujws48lyVbjv0ThgR93D1HIG4NEH45SZ
        VIlRQEhvrKnyqfaA3lmEFMCXg1iK5lliFg==
X-Google-Smtp-Source: ABdhPJx+Vs5y8HA3NpMU0R2RfFBUtP1VAq77R6zckJbYjK/ihkSS/J5AT+rfpaCiLUn1ZhdDvQMSIw==
X-Received: by 2002:a17:907:3f9c:b0:6f0:28d1:3ad6 with SMTP id hr28-20020a1709073f9c00b006f028d13ad6mr27009349ejc.365.1651071379475;
        Wed, 27 Apr 2022 07:56:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm8475284edt.70.2022.04.27.07.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:56:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] interconnect: qcom: use icc_sync_state
Date:   Wed, 27 Apr 2022 16:56:16 +0200
Message-Id: <20220427145616.523557-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use icc_sync_state for interconnect providers, so that the bandwidth
request doesn't need to stay on maximum value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c | 1 +
 drivers/interconnect/qcom/qcm2290.c | 1 +
 drivers/interconnect/qcom/qcs404.c  | 1 +
 drivers/interconnect/qcom/sdm660.c  | 1 +
 drivers/interconnect/qcom/sm8150.c  | 1 +
 drivers/interconnect/qcom/sm8250.c  | 1 +
 drivers/interconnect/qcom/sm8350.c  | 1 +
 drivers/interconnect/qcom/sm8450.c  | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 2f397a7c3322..811370fcd211 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1347,6 +1347,7 @@ static struct platform_driver msm8916_noc_driver = {
 	.driver = {
 		.name = "qnoc-msm8916",
 		.of_match_table = msm8916_noc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(msm8916_noc_driver);
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 74404e0b2080..6cf75da91428 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1355,6 +1355,7 @@ static struct platform_driver qcm2290_noc_driver = {
 	.driver = {
 		.name = "qnoc-qcm2290",
 		.of_match_table = qcm2290_noc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qcm2290_noc_driver);
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 416c8bff8efa..d82f9add4933 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -1086,6 +1086,7 @@ static struct platform_driver qcs404_noc_driver = {
 	.driver = {
 		.name = "qnoc-qcs404",
 		.of_match_table = qcs404_noc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qcs404_noc_driver);
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 274a7139fe1a..706b49a4bb70 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1716,6 +1716,7 @@ static struct platform_driver sdm660_noc_driver = {
 	.driver = {
 		.name = "qnoc-sdm660",
 		.of_match_table = sdm660_noc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(sdm660_noc_driver);
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 745e3c36a61a..2a85f53802b5 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -535,6 +535,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8150",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index aa707582ea01..8dfb5dea562a 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -551,6 +551,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index c79f93a1ac73..3e26a2175b28 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -531,6 +531,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8350",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 8d99ee6421df..d573018a6324 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1968,6 +1968,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8450",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.32.0

