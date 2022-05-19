Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FF52D2D1
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiESMo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiESMoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0C4BA9B0
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:23 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDVMA0HVeRHXPjYFnAdzGMTj3nwi6/Sn2LHJQczoRdY=;
        b=SNwFbliXqoHnCcEU+X1OHbUCcvzl8da4H5TG7Ra8+NfnSx/3a/ye06BGTYZE8sV0+nIeSH
        U0RXAWBX4ZE/bLwbllWnEmN8nQpgEaUsAgv36YZMgQfeWEbDHTSDkr2/4wbXcR1NADGJQ1
        yc5u4/TEOE0OVE0cl/BFFA9zqhW8Ql6ej51b6ueYtkbcD5tDz7Oqhovj50PyFfJ4hIPFnS
        2dCUNrGLmQ04wzLWTkSU4Y/8nuRd2m4s5g8Q0X2DT+VYD3kGYlt8G9yXjC7dmb7ki0oRBe
        /KMMETQCQUA+tpQFX7/rd+juUmRPwC0iqJINn84q6XPppLNUDWM2COiydeIizw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDVMA0HVeRHXPjYFnAdzGMTj3nwi6/Sn2LHJQczoRdY=;
        b=hlCyZ45RoXWJiwiTd6M43Vgsb+hC8eGoN9U8jw7uFt74ertInsBoCXaCbeIwRWyMYw0oTF
        xNXNjZH3Pi68jJCw==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: qcom-tsens.yaml: add
 msm8960 compat string
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220406002648.393486-2-dmitry.baryshkov@linaro.org>
References: <20220406002648.393486-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <165296426088.4207.785150500860431614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a63fa2b601f10fe6a393504a4959ddb04acdc91b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a63fa2b601f10fe6a393504a4959ddb04acdc91b
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Wed, 06 Apr 2022 03:26:45 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:51 +02:00

dt-bindings: thermal: qcom-tsens.yaml: add msm8960 compat string

Add compatibility string for the thermal sensors on MSM8960/APQ8064
platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220406002648.393486-2-dmitry.baryshkov@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b6406bc..43510b8 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -19,10 +19,11 @@ description: |
 properties:
   compatible:
     oneOf:
-      - description: msm9860 TSENS based
+      - description: msm8960 TSENS based
         items:
           - enum:
               - qcom,ipq8064-tsens
+              - qcom,msm8960-tsens
 
       - description: v0.1 of TSENS
         items:
@@ -116,6 +117,7 @@ allOf:
               - qcom,ipq8064-tsens
               - qcom,mdm9607-tsens
               - qcom,msm8916-tsens
+              - qcom,msm8960-tsens
               - qcom,msm8974-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens
