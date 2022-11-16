Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5888362B732
	for <lists+linux-pm@lfdr.de>; Wed, 16 Nov 2022 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiKPKJ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Nov 2022 05:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiKPKJ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2022 05:09:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49182018F
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 02:09:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v1so29039955wrt.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IS4NhixtyW5TeYqdp9/kbVVcuyzIalO1l41VFDtVdNU=;
        b=hAGvJenW4Og2mAreBZMcIFFcI0BIjoFZ4aGOfVRJ5QO/K2ukidMP6ikxXClzBqeciY
         DzNaAxq0ZUy+w4M8sMIw/QH1eHuwUapiftptHXpYLudfJu/s7dnOOUQfJx2h7K2NQlMv
         2QyKJWcTZYgV884sMYySdwt9E007kmh0uq4VviHXRFOSi3qAkOtcB+TQBydG5uQCxdJ2
         xCQYkB7oWGoWG7eN7J2kRx33MRTyrDU+ZdDAfBJPth2ZB96WnLTNHc/wEe+8d9rA5Nvz
         tLVsicWdtM80d8+Ml6UooeTFWWW7/GTMsSAsgkm+jNa6Fs93EMi6HIOuU14i4SnMsJT4
         Vxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS4NhixtyW5TeYqdp9/kbVVcuyzIalO1l41VFDtVdNU=;
        b=jouv9vxG3nG/jXbTAXJNSsUri6xiSVmSu5/kihMCO/b643g+S+ZyZ8O8nVRW1V/7VF
         2u43/E0S7uaaaVsLQu2rHuxjppO2JjsK6ftkn9R9JTYA/N4MIZuhfj5VjLNROQqgETlh
         D0xywP8TVlb1Eykw9mnKD5xVk15pYd5M4eFCFWoiHee6pXgso+rKREq3qMDx2hCByG9q
         L3tjfIzX1ws5yURK9fQ21nCKu8XIJHCNsJwP8vbJx6O2gbUFAmF3FVaDLjtVa45uxxR4
         ySjMSZqHxpalLxn+3KqIpzwZDOfy7/szNRjvrQKL+SFJW0Y6tli6kHDk0GIvMsIVt8sM
         uhHg==
X-Gm-Message-State: ANoB5pmRuT5c8YMYQqkyqFxfawUnVbVjLDvZqVv1XC7FDcjSsk9616Ax
        /EH5YzZOgFHo5Hjx0Ef44liBgQ==
X-Google-Smtp-Source: AA0mqf4ho7H2ywGylNwvkqJy3pkJcC2giMqrzoSpvKj0x9mRAyZorDJ++ZPQPO+Ldxl7gjyzjvBsqA==
X-Received: by 2002:a5d:526d:0:b0:238:3fcb:31ce with SMTP id l13-20020a5d526d000000b002383fcb31cemr13873164wrc.655.1668593394376;
        Wed, 16 Nov 2022 02:09:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c3b08000000b003cf5ec79bf9sm1504500wma.40.2022.11.16.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:09:53 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:09:50 +0100
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: Add compatible for sm8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM8550 platform has three instances of the tsens block,
add a compatible for these instances.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Amit Kucheria <amitk@kernel.org>
To: Thara Gopinath <thara.gopinath@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f0bd4b979e28..09dbd96d380e 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -58,6 +58,7 @@ properties:
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens
               - qcom,sm8450-tsens
+              - qcom,sm8550-tsens
           - const: qcom,tsens-v2
 
       - description: v2 of TSENS with combined interrupt

---
base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
change-id: 20221114-narmstrong-sm8550-upstream-tsens-dfaec218c321

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
