Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA06F9CFD
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 02:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjEHAdT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 May 2023 20:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjEHAdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 May 2023 20:33:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E0A8A63
        for <linux-pm@vger.kernel.org>; Sun,  7 May 2023 17:33:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f24ceae142so900842e87.3
        for <linux-pm@vger.kernel.org>; Sun, 07 May 2023 17:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683505991; x=1686097991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDKMbXnJIvuQzh8ILfzPlhqGHSGT1sdNjiXjnJAa1jI=;
        b=aOemtY/voHimGspIjk8noHBn5hdmmzfEOdTHyeecc1aXVlP+fmw9Fip+qw2awvUiCq
         AQ+46uiFRlP4pdjzKl2vGzV2gd9ySyzZcDyJ19FabROYOCNvxxD7/97uSaWZIbMLSHGV
         KB+GibLShnJfFndq8WzhJCdGs+W6G6HJr4FoQ4IehX3D0KhFMsKN0FKVfmRfVF5/IFQK
         bArQy0hcEGjIVTI2NpJnm9mA1cnUfHB0fYa8REK4Kg8dGo9XOOnUuTXbBWldmArWTChi
         aP3TQPZ7rDAcvdYTa5tw3TezJTK3a1nCvrN3iaI599pEX0b2DJUBFPsLfgQbH2VjIxI8
         hUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683505991; x=1686097991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDKMbXnJIvuQzh8ILfzPlhqGHSGT1sdNjiXjnJAa1jI=;
        b=RrVwjT5HBpmAeG+p/8Oi/DgRPiz2domu5aHlbc+aE05seJdijWU2fQcifBexbItUmD
         vGVSs7s2ct9BUFRIySOD0SbfHOA671i4NCtfVOjDEsJ5UlmFoiQL8Kuu0vuMAm2t+tLk
         hvKbGJXBs2QUog1dxiZTRVUjuRxP0Qol6VmWITkQIrFevEt9dVouSg0lGypA0MBMiu66
         3x6+yOsvWr2RqGmS+JRo5hZLekyGoJTGi0bKRafAs6SRE9YCAGg2vBRRAHcjEgIXnnV1
         uZBlnNnBbJKXZaAzaRfDAUVVAcNri/QxGfx2B1e77joGQPQfRv3cch1xyM28o3P2M4Oa
         Z+gg==
X-Gm-Message-State: AC+VfDzT+lh8DWp2aQ2v4oNXUIPZXzPyR8WxE4Be/W1OgWEfVdf/WEkq
        q66tNzvKL7Xh+XIKDPjwRfidlA==
X-Google-Smtp-Source: ACHHUZ5L5mYXfYEX4glhtdoGY9YXd7EcX8HGqt297P7fo7SQRPt2pynB4Zuto+fc42F00r+NP1ofgw==
X-Received: by 2002:a05:6512:983:b0:4ec:8d50:d124 with SMTP id w3-20020a056512098300b004ec8d50d124mr1811831lft.48.1683505990904;
        Sun, 07 May 2023 17:33:10 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id m22-20020ac24256000000b004eca2b8b6bdsm1114807lfl.4.2023.05.07.17.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 17:33:10 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: power: reset: qcom-pon: define pm8941-pon
Date:   Mon,  8 May 2023 03:33:04 +0300
Message-Id: <20230508003309.2363787-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
References: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
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

On PM8941 pon doesn't store the reset reason. However we still need the
wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index d96170eecbd2..0f4f55dd4eac 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - qcom,pm8916-pon
+      - qcom,pm8941-pon
       - qcom,pms405-pon
       - qcom,pm8998-pon
       - qcom,pmk8350-pon
@@ -63,6 +64,7 @@ allOf:
           contains:
             enum:
               - qcom,pm8916-pon
+              - qcom,pm8941-pon
               - qcom,pms405-pon
               - qcom,pm8998-pon
     then:
-- 
2.39.2

