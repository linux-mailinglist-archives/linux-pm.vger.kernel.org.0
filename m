Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA31E64851D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLIP0l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiLIP0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB20B8F08D
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMrabYRj2/CttKMFYVgdk2uynK9d2UUAJGvXmuHNp1I=;
        b=L4rCHU5FwWGiwf1UNPlrc7bcQO00q5aFeuM6o7OlyvKAqfeSGndqYxwJVQLnHZY1Ao1MXF
        kn6caAKvCJ2u2C4TMeKrsFOKDZMB0qAZ3KY+3Uu+gUgDCBbcASNVPYyBk8/NTbEoVbtq2O
        33KryXSswSMJwXi7k3UX9ko3hx3Mla/QqGPMLNhk3SrP2+xZ17i38oYlp9mWYMGCxbXOy6
        LVXwpBv9g2PoOrR48YS4I1OYs85Cm9xQrzV2ZaJldKWi7VVbXM2mAkqIZi0IDLbwxkmwwx
        ZNTI2T/5meNEfm3Y/YZlmd3Q1PVoENchY5Lb5QQS3dLpcFKepG5S26hspNSW+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMrabYRj2/CttKMFYVgdk2uynK9d2UUAJGvXmuHNp1I=;
        b=xWcUloq3ja+VdljWaXoMYGs2zwDMoCrj/6dH3ZrxWMuXj/dhabPcoQN29CR3zrbBFo2j+L
        cZzjjaLdSsDD73BA==
From:   "thermal-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: qcom-tsens: narrow
 interrupts for SC8280XP, SM6350 and SM8450
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
References: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <167059958785.4906.8220628123764778872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     37ab48c365e6f89d0e228725eeca66828f04a985
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//37ab48c365e6f89d0e228725eeca66828f04a985
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Wed, 16 Nov 2022 12:31:40 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

dt-bindings: thermal: qcom-tsens: narrow interrupts for SC8280XP, SM6350 and SM8450

Narrow number of interrupts per variants: SC8280XP, SM6350 and SM8450.
The compatibles are already used and described.  They only missed the
constraints of number of interrupts.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20221116113140.69587-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f0bd4b9..5bcfddc 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -146,11 +146,14 @@ allOf:
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens
               - qcom,sc8180x-tsens
+              - qcom,sc8280xp-tsens
               - qcom,sdm630-tsens
               - qcom,sdm845-tsens
+              - qcom,sm6350-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens
+              - qcom,sm8450-tsens
               - qcom,tsens-v2
     then:
       properties:
