Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4324FB69C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 10:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbiDKJCE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 05:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbiDKJCD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 05:02:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430773ED1F
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 01:59:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so29454199ejd.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4aOxrZyUSPJXRv4OrmH9C7n/WOuIj+q5IA27jz4qMc=;
        b=y8TqxM3f25U9WL/RQfPQXPdQZtjurmAtiRYTHI0jNekxMYcB1dPgyJh2grbqn4HX6D
         nm1ZCKqbwuqd2j9pKtggxCVl9STb5RsVLA9luCWpcjN4sR8Cu80QI/yYkjRLx7qPPkIZ
         7dyelUFm6LM1y7XdXkHQA83aOTCLxgGMm7g94earVh4/ZSb5euKM+/TNXKyWvGalGo3Y
         zlgsRY5JxBOr1lWoTf2fmfnAbPlBdpxXRuOwoFvdCSZhU3ithNR3hLY9ryONU8gdlYfq
         NdY5z+a5tlqjWVZaQluG81/GsxFzn4EJmi/dDngG2xSLj4ZUVyKIv2WM5RrpEVFK/tAA
         AaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4aOxrZyUSPJXRv4OrmH9C7n/WOuIj+q5IA27jz4qMc=;
        b=8B9K+bePLq0FNth4Gmb3D5oCGPG0IXgqi2hAxWswls3qGYVW03EbzeWDb1ElfVzeKE
         PPxYX4WqJBz5qg0GayKBXhfqP6TNkUK/zn6CRVgzAu25dpWgLX8Ijf0RWlN3JR8iLbZF
         +elUW1ytj5qOTkFpAB+B24byI7e9EhdGp0xP/BQbWYeedZKFjmgrCiCtUBlhizw4ZQk/
         BqahLgGY97cqCyccyRsOwzEaur4mNOB295Xm4HTXgMEw8dEQWD1Mz0a8cWycv9tRcaPk
         aC2l1w64VD2LB6mByAAzbOldgzmV3b1cstgQm7pSild6SjHJzjkWZvIVOM/7G6iHDKby
         wyhw==
X-Gm-Message-State: AOAM532yz6IGnlDuwu8lDWSt1cYMKhrQVKppEqoIc4NA8qvMN7irMSU7
        YKYro/811ZhZizE+g6RBiVBlZA==
X-Google-Smtp-Source: ABdhPJx7l8GOGdvDLLVUIut2eoOtDkRMbuCc+EV2GPy3lS6x37mSNG6YvFhoSdK5eYNxKQHqfigF1w==
X-Received: by 2002:a17:906:7314:b0:6df:839f:af7 with SMTP id di20-20020a170906731400b006df839f0af7mr28935240ejc.65.1649667587804;
        Mon, 11 Apr 2022 01:59:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906297100b006e49a9535f3sm11705416ejd.114.2022.04.11.01.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:59:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vamsi krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ARM: dts: qcom: sdx55: do not use underscore in BCM node name
Date:   Mon, 11 Apr 2022 10:59:32 +0200
Message-Id: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Align BCM voter node with DT schema by using hyphen instead of
underscore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index d455795da44c..4d45be049613 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -770,7 +770,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
-- 
2.32.0

