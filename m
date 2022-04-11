Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942D4FB6A9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbiDKJCK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344019AbiDKJCH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 05:02:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A012B3ED1F
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 01:59:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so10777030ejf.11
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rc69LIllmgRf7vbSQlFUqLbxtA3mmK6fFRVeHFBvEso=;
        b=ZtBIAWZfMwJRLnMjFDnnzsD+a32eYDsJraswdAMsypg/nhGtIBd2E1Vv1EV8aM5/SO
         efltsNS95hR1vy6CKaHvxa+Usw/FYccqNxeQPZQDgMJPNjjTkA1jXKnMt597RrqhTLf7
         sPiD1hqoRxuNUVZ55axnjSI/TCv+5rDByBj+bGSszNln2bNAKNWcte8BHBJJTqqIMqxI
         evweJzDei1CD6n2WI9jDPNnauVwtIJ+P5vYkoAWmdnkY8Q1cc7MFTxcTeeIVHAxOTxHT
         5fl+1FvVEDOJH0mtHqwjsQzhFBDIyXLqDpG/KNOL2tSKOPbTeLyJ+hmdygvPUB0G5HNb
         71Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rc69LIllmgRf7vbSQlFUqLbxtA3mmK6fFRVeHFBvEso=;
        b=SysZzH+UObxiWrlhcGOUJ+RLIqaPmyHccTGhZ0TllYJrdDZ3P6tlnclvjxvc8AUMCi
         keANR0UZMYxLhs7syi3dfINTqoELUunIVQHM/QXNrFAtO6us/Jw0e+YS4yz1NCvyixTG
         IzxvtONC8MTCor0MY9KB0ooSoPCqZUt0pNxXAgkzdSJ7asnuYIvblhNpyJ01sFGKb8gr
         qlELBImc7b3mE8qHqMBO+k8imDquJAywPcj6IQYxPhYN135GcP9R4KVNhR3slrxC4D9X
         IbLLGC5R/ezuCTFnzEl04o3lzeGM7fyLxo40eGfm1iVi6CHcImeF5OCyh9ppPM/tO+j7
         5X6Q==
X-Gm-Message-State: AOAM533STpj9C3F9Pv1dNPzxJ0WBfay3SGlJVFtS1v+Vqgh7vhnLpiAQ
        0zChUZC0nMwwD1nHlRU0jkCdDA==
X-Google-Smtp-Source: ABdhPJzxp5gK+6mo01IKUXO19ZqPNKPmjGNciUm2HErbM1DHA2IhXyk9haPio0X8Kghqchtl/vNL7A==
X-Received: by 2002:a17:906:2b93:b0:6cf:bb48:5a80 with SMTP id m19-20020a1709062b9300b006cfbb485a80mr28490139ejg.681.1649667589943;
        Mon, 11 Apr 2022 01:59:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906297100b006e49a9535f3sm11705416ejd.114.2022.04.11.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:59:49 -0700 (PDT)
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
Subject: [PATCH 3/4] arm64: dts: qcom: do not use underscore in BCM node name
Date:   Mon, 11 Apr 2022 10:59:34 +0200
Message-Id: <20220411085935.130072-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
References: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e1c46b80f14a..86175d257b1e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3522,7 +3522,7 @@ rpmhpd_opp_turbo_l1: opp11 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d7c9edff19f7..443cd9c7f49f 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1217,7 +1217,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 15f3bf2e7ea0..b5c418d326b2 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3744,7 +3744,7 @@ rpmhpd_opp_turbo_l1: opp11 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index af8f22636436..56bf95b7f6ff 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4654,7 +4654,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 20f850b94158..008f6188c8b4 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1881,7 +1881,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
-- 
2.32.0

