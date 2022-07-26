Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396095812A3
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiGZMCZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiGZMCY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 08:02:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CABBE0D
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 05:02:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u20so8456573ljk.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 05:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6fD/XhfGA40D6Od+JH33TGQFs+9cn5WlViTeqh25pU=;
        b=x4V2vzirDZAyJQod7xEZ1t66PDwGwBuDhbm6lBVCECjQTeXLl6BAvsfjkVOFnfDL9p
         MX9/CUdKplg78uFv/JtxoFpjBsWbyPN3aBOUk70yqKIZ3UElPj3zkWcY0TUpl69fi4Gb
         VWHPnB8+uBlEfBpMlyz4LBZpYeA2N6CL7v4LYGs9JVGDM6jv7DGUVhEJwKNElAUzgmHq
         ukAAksAQx5P5dToa8/gy+aIz1ZPg0bq3vqbWJ/pjM6nwGmLRrGQN06mIyZVyOpjCBTFa
         uiCIw5u5Cv3lKknXpN8AJM2rUyWN6UjTanpU4QzdyguXm6HTDV3r7hEG2nczOX/SzFr9
         N38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6fD/XhfGA40D6Od+JH33TGQFs+9cn5WlViTeqh25pU=;
        b=uS18WfVmnNR6imtawVcoOdns2z43lAsOI8Xl9RA2Z/V13CWZ9PTSv5ig2X+AalX1wX
         z71h1NONhIbqvBWvwdXS6GcpGc+DL7LcOx5dvGOW25IkJ8/ZdU9Ftg2bjigwjHMzT+aq
         tUOSIZsoOHIz03X29AlM8g7udQUvCU2BM6SQeVCyCDDHrZDRFXuWbSnUpvUzZZtmfD8i
         gLq2rqh/4G6QoyzcBnP0DFDBnixN2lKRtD1FZws1TZMm+H2PyQmqkapWn1YfE2xGn8QU
         sl5twQQoVFvl2BsG4R19ZFbW/6/uaQuAyYhHk96ufJ0nuIyrbw4IzXEyj5awetl/b8NK
         i3bA==
X-Gm-Message-State: AJIora+yxIffKw0PE1+TvgzEyvPXm89Vg1cXJn8K5LRYnl+dbFnIhJdr
        iafIp5zjUkKZSF7Zmu50fcJorA==
X-Google-Smtp-Source: AGRyM1v5yfwhzbU6D/nhsCJ6pc5Tqy15PGmtqSvncoqsvvxI8QgtviYZrpdzwH17YxX+di7JwbQ6aA==
X-Received: by 2002:a2e:bc82:0:b0:25e:f12:5400 with SMTP id h2-20020a2ebc82000000b0025e0f125400mr2218220ljf.33.1658836940244;
        Tue, 26 Jul 2022 05:02:20 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e804f000000b0025ddf9a5b9csm3221865ljg.72.2022.07.26.05.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:02:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: power: reset: qcom,pon: use absolute path to other schema
Date:   Tue, 26 Jul 2022 14:02:14 +0200
Message-Id: <20220726120215.101868-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
References: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Absolute path to other DT schema is preferred over relative one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 353f155df0f4..e8ecb75155db 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -30,11 +30,11 @@ properties:
 
   pwrkey:
     type: object
-    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
+    $ref: /schemas/input/qcom,pm8941-pwrkey.yaml#
 
   resin:
     type: object
-    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
+    $ref: /schemas/input/qcom,pm8941-pwrkey.yaml#
 
 required:
   - compatible
-- 
2.34.1

