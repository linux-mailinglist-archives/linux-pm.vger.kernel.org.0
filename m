Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705B1570FD0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 04:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiGLCAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jul 2022 22:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGLCAC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2022 22:00:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245993E76D
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 19:00:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 5so5982755plk.9
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 19:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ti2okOxO+DUVTFPOrDB0DRHWNFsTePHaWE122EF3rHs=;
        b=PJNDe6a0viA6D/AS/ZgglVxwJpp2tGbvA73cfqhpomH1a22X/x8cXmgM7v8kH44h0d
         lP0vc4kvgUKlsaEtbH1tY45TIhsy8VtHvXQIblvyyE60Mdd3uonNwou0VI8RKz+85NL9
         KriFmr0YEkbG7E17CFHyTIqNNVl/umHMo4bVTJ1csZG3i64FW+PD3+WYNE5PZ5sdXTOA
         e9fpafyx0u0wzVrRItJBgfs2g+/6fSxiJVVBGow/3sC6Dux9ZuRXUBXjQGIUKTsSEIdU
         tvONA5vyLp0RtbSNnZdfQQ85UAi0qTsqkqasdE2Q+/+BiuMh3TuR0TB3mbLasoD2Ml2J
         yApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ti2okOxO+DUVTFPOrDB0DRHWNFsTePHaWE122EF3rHs=;
        b=cHcZrmm+EOyfLTnf0Jb1uowqUe1Za6uzhJBO4rc8L5wt6nbTzudIChm6XVXiohucGT
         D4aTwrElOEq9Rq8rbUBPLnUf+zrj3X+seFA6OARjEO6rdeNHkeUa6brSlQYf/kWFcUrG
         aZD77oYToC5fV6/t6aFzW1+ro4hZUpS74i6SND08QC6TC/cfJVAmMidVxurF1RZUyk3N
         wLzO3LnF+0jb3O24Ilmmzqc90+CqyrZJsbXAe9+8E9u1ea+75xLLn6qA/XnETNHINTAB
         yda+8aYJ+Av+6g78BloHaPDGygU9Vpb8rFe/web1HkMR5Jt8HWHP56//7vygyXe+SZGG
         683Q==
X-Gm-Message-State: AJIora8MZdyGcS6LtkNk3dgoBJHrboSVd2CQCLWKp+NsDHSEPyVhYd/x
        CoAH3sm785msIhm0TxwUt2r28g==
X-Google-Smtp-Source: AGRyM1vr/s5icczDTeI/15DhHR34Rs1a7o9x3e2jFdM7FZ8eBlMawnE/xiA1Rm9ZX/EH76J21tNwvg==
X-Received: by 2002:a17:903:1105:b0:16c:32e4:6453 with SMTP id n5-20020a170903110500b0016c32e46453mr15238400plh.131.1657591201508;
        Mon, 11 Jul 2022 19:00:01 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a6b4500b001ef76dbae28sm5425821pjl.36.2022.07.11.18.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:00:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/5] dt-bindings: interconnect: Update property for icc-rpm path tag
Date:   Tue, 12 Jul 2022 09:59:25 +0800
Message-Id: <20220712015929.2789881-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712015929.2789881-1-leo.yan@linaro.org>
References: <20220712015929.2789881-1-leo.yan@linaro.org>
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

