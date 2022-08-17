Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C0596983
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 08:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiHQGZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 02:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiHQGZl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 02:25:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2953D78220
        for <linux-pm@vger.kernel.org>; Tue, 16 Aug 2022 23:25:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u1so17803287lfq.4
        for <linux-pm@vger.kernel.org>; Tue, 16 Aug 2022 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=guVwRYHb/3tPD4YUcYl2zZXQzxPVqgggnejxGyEtXkU=;
        b=KbeOUIoM9yby5Yomhn4o0VC5YzJ40kFhiRc4Wd/GWN0fy0o4Ng6nUV2YaHdeIFPoPV
         dwSaF1KnuXbuxGR5WzE8q+6w83z34s+aLUWazlKA8Yn9+uuAlvKi1wiRYwGrmWlYuob/
         /QTvsrCCU6BW6FMaKvc40eR8m9nW46FgGjIfA3Kk7jJlxzUkFdEjKsCGQyQ5neuhEwaH
         qDj+8vJgmanJw+ZlNciLfwUU0TXyhbYugRh82NidfHNgJ4FlOS31WiAo7oieqwrTl1Fz
         Yo+4VT6Tk9p6j2aVkufZzWhfxKBlRYGqZJJ9+/Q/gj0NBfrGAkRcXdlwkprQUjTPPqLM
         dIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=guVwRYHb/3tPD4YUcYl2zZXQzxPVqgggnejxGyEtXkU=;
        b=Nlos3Tchu7ocYsGO9y+usA5xHUkMPc6At8Ta84GJ4S+htEoHC5mjqrx2y8g/rHUwM0
         uxbTnJCMV8azc86i42gIEYr0O7R0VTDsPCpOziOVsNhLjPiIhpoKbqlVkvYAB5dXmewa
         id6WtexLMf3t6eeOyPkw/TUHxirtSkaEVUxZnwBkCTQ4JN5XcoWG3kORVwNCIBkkcghh
         M36OzmXcu2RFCuNbthZkpN4eVxtxxdSzs/x5KzMr6okxZZyXOPyCgm4elRZZjqpezNwQ
         BLSUwBpsrxelCVsbDslRxopV7aMeDxSL1QeOp74lmk0m1FgXeXNFLvi7naFKAOOUsnoX
         O6xQ==
X-Gm-Message-State: ACgBeo1yV1xjVEVPdgQyS87Y/c1wCskq8KwmrOArLMZDpnBvwBcYJVph
        nkk13vUcTjXqzHvbbCdZ/dUBEQ==
X-Google-Smtp-Source: AA6agR5P5rXqmmHFgywOnH+IYAiRqXSQU7AhevL0GU7rLKmPJkOR6GsdL8LqQ5goaYKSEecI8yEiIA==
X-Received: by 2002:a05:6512:1584:b0:481:31e4:1489 with SMTP id bp4-20020a056512158400b0048131e41489mr7929105lfb.509.1660717537551;
        Tue, 16 Aug 2022 23:25:37 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id j5-20020a056512344500b0048fdb3efa20sm1537655lfr.185.2022.08.16.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:25:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interconnect: restrict opp-table to objects
Date:   Wed, 17 Aug 2022 09:25:33 +0300
Message-Id: <20220817062533.20076-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simple 'opp-table:true' accepts a boolean property as opp-table, so
restrict it to object to properly enfoerce real OPP table nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml        | 3 ++-
 .../devicetree/bindings/interconnect/mediatek,cci.yaml         | 3 ++-
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index 09c8948b5e25..7d8d0896e979 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -47,7 +47,8 @@ properties:
     maxItems: 1
 
   operating-points-v2: true
-  opp-table: true
+  opp-table:
+    type: object
 
   fsl,ddrc:
     $ref: "/schemas/types.yaml#/definitions/phandle"
diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
index 449c7c988229..58611ba2a0f4 100644
--- a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
+++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
@@ -36,7 +36,8 @@ properties:
       - const: intermediate
 
   operating-points-v2: true
-  opp-table: true
+  opp-table:
+    type: object
 
   proc-supply:
     description:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index c2e697f6e6cf..a4743386c4c1 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -35,7 +35,8 @@ properties:
     maxItems: 1
 
   operating-points-v2: true
-  opp-table: true
+  opp-table:
+    type: object
 
   reg:
     # BWMON v4 (currently described) and BWMON v5 use one register address
-- 
2.34.1

