Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A56BADDF
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 11:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjCOKkn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 06:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjCOKkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 06:40:41 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14061CAFF;
        Wed, 15 Mar 2023 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description;
        bh=s27hbL7BsgnXDk8Vx8xDwfWUq+9SDl95yRCwongKFwk=; b=nQSZqG+1za8hLKZYzT9QdYp1qM
        gc+GekN3MPZqIy50x4IUdPQ02z1f44ULCVNOskK0QmVypKjDwOT36sCaTwlhnLCCpyD3RRH9ORCeb
        wvMxFkKFTwSMa5Y2uHHJUUrP0wF0Gg/6PNVoDN4BjuQUAP5229IwcxAZviAXaVUQCV/zleFY6x1WA
        O/o84TXdtMUo2H+nSbsyA+2GZiDCU3JTQR8vffDBmU/VaUKsBiJTZw/Qd2Ff1mcBoFMmgf5tnY/++
        cU++WY5BZDOaxl4gPj5hvDE2jankTc7cz4gjGp+ea7oqwuZRdeuOjkP2bRML6/182Hi/8zZbK7Io5
        LxeXnyNw==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pcOYY-00GsYJ-KV; Wed, 15 Mar 2023 11:40:30 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/6] dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
Date:   Wed, 15 Mar 2023 11:39:48 +0100
Message-Id: <20230315103950.2679317-5-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
References: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the SoC compatibles must be followed by the IP version compatible
(e.g. compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";) it is
redundant to list all the SoC compatibles again in the if statement.
It will already match the IP-version compatible.

The list has already become inconsistent since for example
"qcom,msm8939-tsens" is covered by the if statement but is not listed
there explicitly like the other SoCs.

Simplify this by dropping the redundant SoC compatibles. ipq8064 and
msm8960 are still needed because they do not have an IP-version
compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Changes in v3: Add Krzysztof's Reviewed-by
Changes in v2:
  - Drop new redundant qcom,tsens-v2 compatibles as well (see discussion
    in https://lore.kernel.org/linux-arm-msm/Y3ZFDRI6ypg18S27@gerhold.net/)
---
 .../bindings/thermal/qcom-tsens.yaml          | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 926e9c51c93c..49416e1ec295 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -223,12 +223,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8064-tsens
-              - qcom,mdm9607-tsens
-              - qcom,msm8916-tsens
               - qcom,msm8960-tsens
-              - qcom,msm8974-tsens
-              - qcom,msm8976-tsens
-              - qcom,qcs404-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
     then:
@@ -244,22 +239,7 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - qcom,msm8953-tsens
-              - qcom,msm8996-tsens
-              - qcom,msm8998-tsens
-              - qcom,sc7180-tsens
-              - qcom,sc7280-tsens
-              - qcom,sc8180x-tsens
-              - qcom,sc8280xp-tsens
-              - qcom,sdm630-tsens
-              - qcom,sdm845-tsens
-              - qcom,sm6350-tsens
-              - qcom,sm8150-tsens
-              - qcom,sm8250-tsens
-              - qcom,sm8350-tsens
-              - qcom,sm8450-tsens
-              - qcom,tsens-v2
+            const: qcom,tsens-v2
     then:
       properties:
         interrupts:
-- 
2.30.2

