Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CD1785AD9
	for <lists+linux-pm@lfdr.de>; Wed, 23 Aug 2023 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjHWOgn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Aug 2023 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbjHWOgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2023 10:36:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB777E7A
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 07:36:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9a2033978so87992191fa.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692801395; x=1693406195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsh5VSO8QTfgSHz/ZgKE+ynOJSB0HlAAlM2Gc7ibTmE=;
        b=Ta0C358G50UChuN4CcU7dOAKaZhhQ0FGjRrVPcB5ZqUPe3GZeq0JwWpuUIR6P/kCvN
         kQv5IiQn/Qi/+abMsrPRz+neFh8mZod1hSiCBN/ApXY0JBxPrqCXaFFTFIAxp1hHG9g2
         LDP+VYu+VQo7VJl9edDqDSGyiI1a7OzLLFQ4KAkOMKW9yZsVR2NKSseOMgDICIf+9BvM
         CfVhPFSws2uypXAQbdIpGW1BhIVyOHdVwczC3qml5E4e/TxZZvUrJHiKc3gHuypJ1DVV
         k18G03OAWsqoXPvbrOG5z9Is0Q3tnbXpa7K2M5wkx0FlD4fKkF2jffa0K4Hpq5smiPQl
         Gl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801395; x=1693406195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsh5VSO8QTfgSHz/ZgKE+ynOJSB0HlAAlM2Gc7ibTmE=;
        b=J05xuuPnlW9pl2EL0WdMujmHP2SlWwWm9ANqGg8EEeLE5etB2kkYICfoegaQuQ15r4
         a4802D9z6fUZ2y2INKJoyPVnfJl2JHfolKeW9ZHe83RHbzJ3KYzFtGHiZEg+JW0eJokK
         8q7/f08fjwDhrDQH/zCFGx12DUuGRxlrjAYagHtwAHJLAX0+hu4TzGLmPfCrJeBeBYbK
         a2I86ehSGpv5CNAuSFNytKdxd34/ht/QaITrkB7GxGAE6MGSKYR20C37aszUgvLBbCFC
         tDr8mJoHfAeuOiVSrJ0b/9sUt45TXyXo+VZJDDhISM/hIqny75e630jcAs/rLrHAtSFG
         oMXQ==
X-Gm-Message-State: AOJu0Yy0T9Z4UcECYLL+9fnw21WurVt5fAQhPd/4euYEOvwQ/yX3Q7zu
        aOJlOnXEfttGMtU2EPP5utK1nw==
X-Google-Smtp-Source: AGHT+IFcCBom0sELmQwMePxpKhnDEZxyHx9SE2Xsj+6aV1B4EePLc54UadLTVC7Xcqbju6oy3ABAKw==
X-Received: by 2002:a05:6512:3b28:b0:4f8:752f:df48 with SMTP id f40-20020a0565123b2800b004f8752fdf48mr11634810lfv.29.1692801395148;
        Wed, 23 Aug 2023 07:36:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj76.neoplus.adsl.tpnet.pl. [83.9.29.76])
        by smtp.gmail.com with ESMTPSA id z6-20020ac24186000000b004fe36bae2d6sm2668882lfh.81.2023.08.23.07.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:36:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 23 Aug 2023 16:36:14 +0200
Subject: [PATCH RESEND v2 2/3] dt-bindings: power: supply: Document Mitsumi
 MM8013 fuel gauge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v2-2-9f1b41f4bc06@linaro.org>
References: <20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692801391; l=1459;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6Er+/jQXhUlOhQhJurvo+JUF2IRA1dZZPivoGZlH2+c=;
 b=1VgEWX1QIZZeKOFemotFw6KlDf8azxsnAuZyuenYckWHsPVTKc7dXnzpNIGGZqNSYnccLokxs
 A3FOiLPrjahDcNbKgTtEj3kZx0o4VGBsPneFH4W2xHgcDvjmYV7qkBW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Mitsumi MM8013 is an I2C fuel gauge for Li-Ion cells. The partial
datasheet is available at [1]. Add bindings for this chip.

[1] https://www.mitsumi.co.jp/latest-M/Catalog/pdf/battery_mm_8013_e.pdf

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/power/supply/mitsumi,mm8013.yaml      | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
new file mode 100644
index 000000000000..080fd44083ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mitsumi,mm8013.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mitsumi MM8013 fuel gauge
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+properties:
+  compatible:
+    const: mitsumi,mm8013
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@55 {
+        compatible = "mitsumi,mm8013";
+        reg = <0x55>;
+      };
+    };

-- 
2.42.0

