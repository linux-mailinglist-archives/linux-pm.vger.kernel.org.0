Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CEF6B09A5
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 14:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCHNp2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 08:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjCHNpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 08:45:10 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA5BD4C2;
        Wed,  8 Mar 2023 05:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o3kMo4ap9nniq8LrNgqr7HMFOU9Lp9gxz1OZ/gIK5mQ=; b=NUsE+apKLuTs7i+L7h1SLUZ4VB
        ccyFW9sRhhvBeQP6eUBXi5/ICxgwSk5MHQaPcPdU38OlAC8xfRhwEgCUfjt9ExYF+ytbERoxD+K57
        munDjmt8chp1edBI+JUf5SUwlRzl2W12PGnRUjkMY56Lf6fAbT7sbpg/IH86k4dnT/PJu0INpF2Vl
        20g2KiYRVbt6oib/WfAXWERah2UzsEWCif3eWUoVcyr8zXGPp+WC0l3O+XPwaag35QdJlYcssWWJp
        fad5uGZdIltwoNA9EH+UtbYJgEzPVmQOjwu+w2z6yGCadRWbQNlb39WkVS24m08XhCeAkYO65t/c/
        c+Hv03jQ==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pZta2-00FDCA-A4; Wed, 08 Mar 2023 14:11:42 +0100
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
Subject: [PATCH v2 5/6] dt-bindings: thermal: qcom-tsens: Add MSM8909 compatible
Date:   Wed,  8 Mar 2023 14:10:40 +0100
Message-Id: <20230308131041.124482-6-stephan.gerhold@kernkonzept.com>
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

MSM8909 uses the TSENS v0.1 block similar to other SoCs like MDM9607.
Document the "qcom,msm8909-tsens" compatible in the existing schema.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Changes in v2: None
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 49416e1ec295..d6a9bb39c2a7 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -29,6 +29,7 @@ properties:
         items:
           - enum:
               - qcom,mdm9607-tsens
+              - qcom,msm8909-tsens
               - qcom,msm8916-tsens
               - qcom,msm8939-tsens
               - qcom,msm8974-tsens
-- 
2.30.2

