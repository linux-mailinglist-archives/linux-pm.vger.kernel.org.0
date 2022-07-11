Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D157013E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jul 2022 13:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiGKLxM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jul 2022 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiGKLw5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2022 07:52:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504C2654F
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 04:52:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so8058144pjm.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ti2okOxO+DUVTFPOrDB0DRHWNFsTePHaWE122EF3rHs=;
        b=jhZVzyi7KkZdBBKcBSehp4JJNma6Rnd1dUGsVYwp6Vbj3UKhYcsCFSiQJ77Ux36ERH
         I27bLdrtbu6KJ7Bcjfudr19iHKv48igTAm41K9S8Y1OvaJH5xIiAaE+nJyJomGsRM78V
         ePw0+fkdb0o5KRhlS+XM6SpsgkGvdxhI4cH5gagLoO9s9xxddt3J6yUNms9U30ihsofp
         aD8SIA13gyCR9JfhclVnfGmfq3uLvuQHz74fkeQWvHvJb82qnS4hzTYAEwvEBFFpSUMU
         0Mj4y9SO51TnffG986ygjfsRu9xAQaSPIUL4Vh8m7LGmluNKFmGx3Oii+hI2SQNvBb5G
         ZuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ti2okOxO+DUVTFPOrDB0DRHWNFsTePHaWE122EF3rHs=;
        b=JDs+QP2aM4dLbIizbfaVMe4E02GMdNOjoAubcYGB0n3FgBVhmYXWfe2B2oX6W6aR8/
         dQmdXgfl6R3D8DUrMkYN+Vb0IS8K44HJ14U3QGXmV7cRplbBPfBBgOe6r5Jy3BD78l8n
         DWDcOVveQMX37IN+or91+fmLAanfinpbu//kujikw0pHVLvXtHlTZmVLPHGJMCjSNV7E
         FUYwK9eHtA9RxayaRy0dluKMIasV/eJVEhkqMUWTDYb8fTTweTauDfhWv7PiywMiD+gz
         MkSaerqS4/ztTIzgBh5qJKzjtLm7HLB0vqrEWL4heYu5lTdAyww0Pr8JG9X+INNZ21Lx
         gQEQ==
X-Gm-Message-State: AJIora+rxBdLyFimISic8i1DW4X+a1OgrM46kyjo+8gDjvqsDKp2r6KW
        SSB06XgjcLTk4d5/aINReOixIA==
X-Google-Smtp-Source: AGRyM1tc4ZnKsbp/Z4yfOd/mrOEZRBaeT2l/SKbsWt/6ONuFKzoye6KLxLIwqEOJ1h+VmnAmzvX9RA==
X-Received: by 2002:a17:903:3011:b0:16c:3d34:fde4 with SMTP id o17-20020a170903301100b0016c3d34fde4mr9014748pla.79.1657540375578;
        Mon, 11 Jul 2022 04:52:55 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a648e00b001eaec8cea55sm4586502pjj.57.2022.07.11.04.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:52:55 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/5] dt-bindings: interconnect: Update property for icc-rpm path tag
Date:   Mon, 11 Jul 2022 19:52:36 +0800
Message-Id: <20220711115240.806236-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711115240.806236-1-leo.yan@linaro.org>
References: <20220711115240.806236-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To support path tag in icc-rpm driver, the "#interconnect-cells"
property is updated as enumerate values: 1 or 2.  Setting to 1 means
it is compatible with old DT binding that interconnect path only
contains node id; if set to 2 for "#interconnect-cells" property, then
the second specifier is used as a tag (e.g. vote for which buckets).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/interconnect/qcom,rpm.yaml          | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 8a676fef8c1d..4b37aa88a375 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -45,7 +45,11 @@ properties:
       - qcom,sdm660-snoc
 
   '#interconnect-cells':
-    const: 1
+    description: |
+      Value: <1> is one cell in an interconnect specifier for the
+      interconnect node id, <2> requires the interconnect node id and an
+      extra path tag.
+    enum: [ 1, 2 ]
 
   clocks:
     minItems: 2
-- 
2.25.1

