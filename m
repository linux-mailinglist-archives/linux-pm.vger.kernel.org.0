Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FDF539E1B
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 09:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350266AbiFAHTg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350287AbiFAHTb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 03:19:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144594EA3E
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 00:19:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gi33so1874325ejc.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 00:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poif9YuK+d5jqJ3ySyG93lIB8NIzwhm4FYQAt1koed4=;
        b=b9qq5o5nRW3OI88iNMKLGFljdgUrPOk0NwMpkcgWBw+qoLBbebiwFuMB+m6vL/LrE3
         qrlC+G53prvOydFQS1zFeTosWss3OQFs/jgbJd9sHmdC/OZKDpg98QIcj9DNEQdFXg61
         I0NI+50atr3oSifyETRENXASf5+W3hFhAsAxsMpYEEJrXGV32iprRh5kfFioutoOI5xb
         RUcXID/Tu7MV7V7QPNHXBdjhRN9baTOu3Iwc0F936ixlIOdlAJIsvf0U4w7cTRDh72pk
         HDX7lnWYWHOEQq385UhGz1Zg8+dOK2p9ZTYJaqPZnmQdtDfbYsmzmFvw5guktjS/8wyl
         ESAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poif9YuK+d5jqJ3ySyG93lIB8NIzwhm4FYQAt1koed4=;
        b=NraR8npWAtZrAk5hJiCRXI+87gcLJhPa0wGngjqwCKZPLvyEuwuCmbZpxwzGlGPacj
         epy75vW3ilUfmCUcZMFP6FxOkegmNGuq4lpCoMo5wtmX1wdwxo4fnfg7eeEg4gRLA2MO
         10uVbSGf19/w1C5l89PusYsVpoPQ2Xr1HPSvdXQY3PdfRNIXrdRQWG/urYSfQ6QOykm8
         JyUZXZOpHx4x6qQ2fv3ilfe6GNx7lnovlwBrteZgAEWAufn5Ybq+Fv1ukI0cjrdvTtU6
         xgtxRh12ofYJtzNKuLYR9xFEjkizrR38hrn0Uwjcdm/MtGCWouJuPA7SJUOTXsIIglti
         bwOQ==
X-Gm-Message-State: AOAM533RADWPYBTEc0xytpHO6NZQoxeYbBj9C+5iBHwUogbpLF4FutgI
        lcmbDCejQk3ph+q43We/gAls2Q==
X-Google-Smtp-Source: ABdhPJx0T8VoGYVKS/HHv7vq4UdMBY+MFcX5GKqOMw93Ky6jxsKb8l4liEmXrEcAa6QuaF7NfBNv3Q==
X-Received: by 2002:a17:907:3d01:b0:6e0:c63b:1992 with SMTP id gm1-20020a1709073d0100b006e0c63b1992mr58394228ejc.422.1654067966664;
        Wed, 01 Jun 2022 00:19:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f27-20020a17090624db00b006f3ef214dcdsm358486ejb.51.2022.06.01.00.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:19:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] dt-bindings: power: supply: qcom,pm8941: document usb-charge-current-limit
Date:   Wed,  1 Jun 2022 09:19:10 +0200
Message-Id: <20220601071911.6435-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
References: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
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

Document already used (in DTS and by driver) 'usb-charge-current-limit'
property:

  arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb:
    charger@1000: 'usb-charge-current-limit' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/supply/qcom,pm8941-charger.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
index cd6364d65751..cbac55d3cb92 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
@@ -117,6 +117,13 @@ properties:
       be done externally to fully comply with the JEITA safety guidelines if this flag
       is set.
 
+  usb-charge-current-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 100000
+    maximum: 2500000
+    description: |
+      Default USB charge current limit in uA.
+
   usb-otg-in-supply:
     description: Reference to the regulator supplying power to the USB_OTG_IN pin.
 
-- 
2.34.1

