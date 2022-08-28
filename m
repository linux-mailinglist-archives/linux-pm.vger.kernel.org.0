Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53F45A3C99
	for <lists+linux-pm@lfdr.de>; Sun, 28 Aug 2022 10:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiH1IKc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Aug 2022 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiH1IKa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Aug 2022 04:10:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB65EE21
        for <linux-pm@vger.kernel.org>; Sun, 28 Aug 2022 01:10:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h8so3722487lfm.8
        for <linux-pm@vger.kernel.org>; Sun, 28 Aug 2022 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=StsNWXDB6+UB39PO4hQRxNgr6opwpDLTnHLXIf47Pq0=;
        b=mS59RvQKzSCZNt0P6hYq+zueCAqRD+IZBkzLwuVZOd1KSqNdmzJCexnJTnVdEGGzV1
         tfP9vDlh2D5HBDSleuhT/9gwit6wppt0OgaqQ56imi8PQcrZA7dn4ijzJVfaO78Z4ftq
         tsEmHn+jYbUvYcb1Spc47BPfXG7ZfzxXEQdU1kpI4f4/HMy/2MLUsHLSfhgzLuR+9S9m
         +SnwTIwXKQmb1EcrNCVemIhtTb6bFQwzSpLglpP/yt0BSeKI8YcwplIuKcwKOJgj8Y5w
         leffeqUvWbpoinrJI80aQMOcBJP9ul8Qe9YqyUaeEkmdH2cvDnVqN0S+NPe4SNY3Vja4
         kJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=StsNWXDB6+UB39PO4hQRxNgr6opwpDLTnHLXIf47Pq0=;
        b=20J4CHP957w/nn4vYJuyZV+sYM3pfsD3AmIzRqtoazGS3erkueqZeN+ZxzwuBVzho3
         q0g/XZ0RWeqCbfZ+Ym21cYRDBBs9GObah3i9lB+qJIQa8NNwtH5WQG9ywzzLG+btngDv
         TDpMJlsGYJYvhGIFI7HneOEGeO81fGzEX2aFvv96gV6QdgRM0wz4zSTTpDHhQ1lMA4wc
         jpW+cHhtqjW3H/udOV3XUP7wHSjdV9W9c0quYqUTllQXt0DIB3SHvpOCbyTk0NM2THnh
         BPUKO/tUHCemQpH+smxmG6pVgyOjLtn0VxBs839IcC7qI1gKJaY8P7qjs6oRBJvIsAmM
         rD2w==
X-Gm-Message-State: ACgBeo2nPe3pH8dRw0LPiOdQwSfwIDZDbQkcgEHatoQnEmuabhwAr8bC
        XU0GNMj7IyUiUySVhqk7hMERwg==
X-Google-Smtp-Source: AA6agR6uwI5PLX5/RfIg/F9RIaggAwBPfo1cB3rThmAcQRHtE+Kls8rCRwuSYGUYhCa+z+VuLRBSJQ==
X-Received: by 2002:a05:6512:6cc:b0:48d:acaa:8a66 with SMTP id u12-20020a05651206cc00b0048dacaa8a66mr5223778lff.272.1661674226994;
        Sun, 28 Aug 2022 01:10:26 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004946748ad4dsm199232lfv.159.2022.08.28.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:10:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: thermal: qcom-spmi-adc-tm5: add qcom,adc-tm7
Date:   Sun, 28 Aug 2022 11:10:22 +0300
Message-Id: <20220828081022.96813-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The qcom,adc-tm7 compatible is already used in PMK8350 so add it to the
Qualcomm PMIC Thermal Monitoring ADC.  Based on downstream sources, the
new compatible for TM7 differs from older TM5 by allowing configuring
per sensor decimation, time measurement and number of sample averaging -
unlike one configuration per entire device.  This was not reflected in
the bindings, therefore comment the new compatible as incomplete as it
might change and its ABI is no stable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index feb390d50696..88f5fd1e2f28 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -13,6 +13,7 @@ properties:
     enum:
       - qcom,spmi-adc-tm5
       - qcom,spmi-adc-tm5-gen2
+      - qcom,adc-tm7 # Incomplete / subject to change
 
   reg:
     maxItems: 1
-- 
2.34.1

