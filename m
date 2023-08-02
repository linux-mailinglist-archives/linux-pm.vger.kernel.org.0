Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA176C1F4
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 03:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjHBBQA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 21:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjHBBP7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 21:15:59 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B52701;
        Tue,  1 Aug 2023 18:15:58 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5860c7fc2fcso34732137b3.2;
        Tue, 01 Aug 2023 18:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690938957; x=1691543757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHHvH1R50hlGEwDWy54Ftr/XiT00eGPxCBa6hf7d2fM=;
        b=SIcWnJf24oD6MrHfeBaGhZ5Tx9q8YYX5WmPvGDKYmdSECpgrvc5/I96wis28eBoaC7
         8NsSiSbdF2JBhIejFF+5Zo5rJmJP8SNpOeAmh7gnm6FQAQ1UWutSBZIXw3nsL1XM9+9/
         mRMo1NmSiJAXgNPfw10sCAtzODgsGZvF8Yq/fpwxVIIR8QipjlkaQC8d71Kn09RdluhW
         50mg3HafYO2YMJSq9mwP2DVZ/ayNnTfNzZUxet7yX9jShrqjLW+Ux9YZrKqLIRGzA4as
         2eH3V2ovzNqUNc1rJcm8HIADynmWknQejhXNslAUNo7zgE9YKoWk4cX2QGMFX6Wd0a6m
         nWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938957; x=1691543757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHHvH1R50hlGEwDWy54Ftr/XiT00eGPxCBa6hf7d2fM=;
        b=SiV3BT4ANDaQtcua3oOwlLPhposnXknk27bPdj71vYGvATZaDvLycs9k6VvZ+bwUJR
         lbJqfr9cmkkLB2pHZCU7qOnN6uqS3LlzXmGRlDhYV0JNbiALef/hVB0rUgBOYGRy102k
         +vbbk6shPDtWNX8BBnjijNBrbkJJ49fVKyGPYGzZrPulYKUdlPeaVTt7tVue3eb1H52r
         mGifRQ26hjlY+bT2PjQ4vxyTmy5upemLlAQFOxvRuKlvBk8udNF/Ky64Se19o3U4fGNG
         7wrQ/X6t3gfeVLPNLvoj0C8ZbJNVsx1d9pa8ZEHvlkv84ztTDBA45oqGjin77cFscVNh
         Q4wg==
X-Gm-Message-State: ABy/qLbuE1sDrJErw0BZYUN9rnN0UcJEMZw7el7RQgw1wu+4MPqwzEsx
        +hRDFgD0YfQFAl1x4j5ZjG8=
X-Google-Smtp-Source: APBJJlFjuizQSKZg1Hxg9u4prcGpuwNtMRBtiJCzlQjIZpNQrXEkvTAeONS08cHiLKmAC+JC5y/qAA==
X-Received: by 2002:a0d:e647:0:b0:576:91e0:b8c5 with SMTP id p68-20020a0de647000000b0057691e0b8c5mr11842132ywe.0.1690938957494;
        Tue, 01 Aug 2023 18:15:57 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::7cda])
        by smtp.gmail.com with ESMTPSA id d79-20020a814f52000000b00583e52232f1sm4165519ywb.112.2023.08.01.18.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:15:57 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: interconnect: add SDM670 OSM L3 compatible
Date:   Tue,  1 Aug 2023 21:15:49 -0400
Message-ID: <20230802011548.387519-7-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802011548.387519-6-mailingradian@gmail.com>
References: <20230802011548.387519-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the compatible for the OSM L3 interconnect used in the Snapdragon
670.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 9d0a98d77ae9..21dae0b92819 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - qcom,sc7180-osm-l3
               - qcom,sc8180x-osm-l3
+              - qcom,sdm670-osm-l3
               - qcom,sdm845-osm-l3
               - qcom,sm6350-osm-l3
               - qcom,sm8150-osm-l3
-- 
2.41.0

