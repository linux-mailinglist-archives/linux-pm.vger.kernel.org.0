Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A656C55C838
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiF0NsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiF0Nri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 09:47:38 -0400
X-Greylist: delayed 1939 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 06:47:36 PDT
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C7860C0;
        Mon, 27 Jun 2022 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PgFS5ZPJcTNQwN2UrbxuXy7Uq3RZFcd+811J1Vhn98s=; b=ZHzArFJDSSkL7IBgej2mWZ/ph7
        rjAOUcUgOWLhJAJYQQwfXEE6I67dpPH5iI3GghuUFFLQhOdkMoIhIETMRBqg3u/dF4rIcFZPW3AqO
        dn8tIu3au5yUUbgnKUV2gqvlVNOj4ehVxYeKjwsREf4Wn0mhm4Jp0ruh4cRaFU3j0miPKuCiZsYgM
        LSS91yCRw+1FcDeppWJoV2CbcbT/HKJlGn6d4VVfiNBuL1dA++aymm7XrjSKWrO7NqnRqzZQBNBoU
        g50KNbGTTtGhngpUTUp17VDkZyqKdNlHJvIMBMVPJGK9E17iqb+nqT5zYCDtIVjWjGdH00I2r4hxW
        cwWtnb2w==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o5oa3-006Cqx-0i; Mon, 27 Jun 2022 15:15:07 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 1/3] dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
Date:   Mon, 27 Jun 2022 15:14:13 +0200
Message-Id: <20220627131415.2868938-2-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
References: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 038d81338fcf..e93e9deec6f6 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -117,12 +117,7 @@ allOf:
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
-- 
2.30.2

