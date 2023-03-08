Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0936B09AE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 14:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCHNqB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 08:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCHNpi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 08:45:38 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456EF6C880;
        Wed,  8 Mar 2023 05:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N1DdDhzRnW4J57Fi8coCDzwHqnrpF2bA5N89Jyh5ZyE=; b=PR/2Uin9/zFhyhJvRAj84pd6Yv
        bLTL9pJ/vGTbyBuRJdDLQKxk9zUxhxM/wnGX+TB3G2K1N544WIJyw0eWDwdoT5UiasPmAmHrekPct
        TMw1tb3oUeAXWx9btLbDbM0oYodMZXabELHPhENt4dZ8OPZvnEzRWAFOWnvluQhPW0OJ8Xg//ecPK
        VWUATayqKT8K7J/zQzQQVv9r/gfBSvkzWnDs/7NTvF2OM2Bq8iFKH1yKJYVJhJv7DXef5bppcTcj6
        SPB9fs2UYPrKHbrKf8LjX/RUgRZm2M8OnjTRBeYLFeo78ke3PL7/KgkbSrU8rmjtZcECKH3hTGvwJ
        1MCRMoMA==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pZtZz-00FDCA-JT; Wed, 08 Mar 2023 14:11:39 +0100
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
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH v2 4/6] dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
Date:   Wed,  8 Mar 2023 14:10:39 +0100
Message-Id: <20230308131041.124482-5-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230308131041.124482-1-stephan.gerhold@kernkonzept.com>
References: <20230308131041.124482-1-stephan.gerhold@kernkonzept.com>
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

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
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

