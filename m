Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6E35663A3
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiGEHA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 03:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiGEHAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 03:00:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148C6101C6
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 00:00:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p9so103123plr.11
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KsUvRKQT2AVjAK3kpk9fo+2UaVrAIK8kVr0Wn3bLJKA=;
        b=MSmkFr2MbDp5neqjTTRVl9ePxtJmXZpJnGWXYkKRc5mtP/iOAQ5tO0q7/Synoc45Dm
         OGa+ZL77JdySobbPneyI7oAkKi4SblebELgliQFm+fa7ZXrvKWhhJ1BwQdw9tKgT793E
         RAhU16nhWeKY/11XlaCIWG35iV+ApkgmZYooSQPaQHGmyHj7z9kq2D4UjgBhCNW4FeAx
         BRVSz02voZHE7yjzkzURmFxjZFq/nJyyLLFbH8+7Lna1AljiPOraWt7Z4QRqN4kCzI5F
         INKOBi/OWJ2R26aI0viah49+w0fZWc02BADwVFPX+kvRoILNe6L0DIpdpVPaIaveZXSd
         FV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KsUvRKQT2AVjAK3kpk9fo+2UaVrAIK8kVr0Wn3bLJKA=;
        b=UWN2tQFzpfLEfYUrXdWOU//GyHTY8MyJpIWgJCDyenL7XNMscwfReTiJab9uLGRedF
         /sIWlUriaPaNo1TsW/yAh7Ps7OaJICQYO7BRCeV7UMStmSPZ8iXOOFU7FmoGwGxGA60w
         BYO2B4gaeEpVehZCNxssHv+BLVV+CrCR2jtXRC4u1Sl0Lmpgp7fRRPnwcxMYejGer3WD
         jl5dLARDFWlOgbBP96tT3am+WjNHc55al21d5MqrRdTeSNAt2rbahqyiAUhey+YcfFTx
         7aRCoPy/c5TGZuE/ZIao2IXakb8B5121uVzipSevj/URclXNAVsi+FmGAeXeZ14y+VHU
         h0pQ==
X-Gm-Message-State: AJIora/vMC9CCAAINyqptTvqpZqs2Sla7fA7OmIE2EeVNhCMXqqSyRda
        MEW5a+5ibH9duQ9GZh9UKOSt+A==
X-Google-Smtp-Source: AGRyM1sXUV1O5TyqgLSs2RioUpR9z6ZqQqQKW3igRtmNrUZJR6/fvyFJNMnCQGtfs/Dy65SZCRm0Kg==
X-Received: by 2002:a17:90b:3802:b0:1ed:2434:eb44 with SMTP id mq2-20020a17090b380200b001ed2434eb44mr42223751pjb.85.1657004445571;
        Tue, 05 Jul 2022 00:00:45 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902988100b0016a4a57a25asm22412596plp.152.2022.07.05.00.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/13] dt-bindings: opp: accept array of frequencies
Date:   Tue,  5 Jul 2022 12:30:08 +0530
Message-Id: <1110ceeb20c2e50573b0e208f52238d280f10845.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Devices might need to control several clocks when scaling the frequency
and voltage.  Allow passing array of clock frequencies, similarly to the
voltages.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 76c8acd981b3..66d0ec763f0b 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -50,6 +50,16 @@ select: false
           property to uniquely identify the OPP nodes exists. Devices like power
           domains must have another (implementation dependent) property.
 
+          Entries for multiple clocks shall be provided in the same field, as
+          array of frequencies.  The OPP binding doesn't provide any provisions
+          to relate the values to their clocks or the order in which the clocks
+          need to be configured and that is left for the implementation
+          specific binding.
+        minItems: 1
+        maxItems: 16
+        items:
+          maxItems: 1
+
       opp-microvolt:
         description: |
           Voltage for the OPP
-- 
2.31.1.272.g89b43f80a514

