Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572FD7389E0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjFUPkw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jun 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjFUPka (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 11:40:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170942109
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 08:40:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f87592ecaeso4668301e87.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687361956; x=1689953956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxhYDMzYM3sPoTVA7uKX6gjc+krbn/LNyC5c2Sai7r8=;
        b=plc8ysziMuz33MsCFtxRco029h1GOA5qjVqHSnvz3JVBE9MaVQ32onzUtuR5WtDkkm
         DKozkywm7i2mA/wpPkjeO7FhjW6+VVYcAwD7cFv6dE2eXGFbM7auS/MSbhTtkhCyQv6a
         RbG7fiRL5WTOUrkiQiE5/lRe/ose2B5FHsDJTUz5KE4vOaQtDdA3aduIlLcbBFkme86Q
         7so/+mn6QBcUTOPoPDHeavwMTkVuoD2LqDWt/Q7fVfoTeGkY4LtuwF17IZH0qz4o7Ob6
         B0MNEghIre1KuJmWOIZ0/aaEAHi2jB9zgPx8wuN2ws7bW1QcnYdYBehly+WT33lcF+bf
         degw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361957; x=1689953957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxhYDMzYM3sPoTVA7uKX6gjc+krbn/LNyC5c2Sai7r8=;
        b=YHayUMNUHQkz+UGHIVhOXvMzsuf3O23AJ4jYrPhmT6+fhf91qzeJ9GmdaAyZpAcnss
         8wK3wYretJN2/CEXjB+fHOyYVE5RzLaE80SxVKnvSz1XUMRJp+6CnooTnO5W9UaHn/iM
         Lgx9RzBiFPxeu6qQ2yFeGdsKzbR+eQENxtlxPwyxh/MGAnJfdW8115bcefp2IcMe4XqL
         d/bqoxtbABTBqIz2RsUJtXowVdbOYJ4c2OyIH+JoDpgGaDS/uxtaigJoC9YfXs01oBAq
         hQ9lMVip6Dsfw+ajZ0MvNH2BLSZ/ORzlAEWcNMahk6eEYacpoKZ/SonH000G0WhIrCyG
         QS7g==
X-Gm-Message-State: AC+VfDzNAubD9QeF1wU9GLjSjuZ2VzewtwCk6Ooyk+VPBrIUph7/J3et
        UQVehIhUgB50/OmN0MyWTtP3JQ==
X-Google-Smtp-Source: ACHHUZ7AJXCZjbtdBiJklc9jnweQoRwN/Hpp0Shrlr0OIdc3i0l2lI8GSXSBIihfNDfa6dVHjKMS+w==
X-Received: by 2002:a19:4f0a:0:b0:4f4:aea9:2a2f with SMTP id d10-20020a194f0a000000b004f4aea92a2fmr9476076lfb.57.1687361956801;
        Wed, 21 Jun 2023 08:39:16 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id l15-20020a19c20f000000b004f73eac0308sm821078lfc.183.2023.06.21.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:39:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 21 Jun 2023 17:39:11 +0200
Subject: [PATCH 2/3] dt-bindings: power: supply: Document Mitsumi MM8013
 fuel gauge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v1-2-4407c6260053@linaro.org>
References: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687361953; l=1391;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=swzJmejAdfZgsQElhxxdYG2Ii9/w0S0UDH09ZiwSv+o=;
 b=ciCb46lVCab3XUdD/PhBmPJGPR46nh4nvwoQSmQZGnJtrhdJOVezWE3UGwGPjFuSBeJ2F6Ift
 VkavK/7dyNQAn3RdbZk7uDckOtCpJPzTwAtnGzt/Y8bOpncF72Tu4bf
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Mitsumie MM8013 is an I2C fuel gauge for Li-Ion cells. The partial
datasheet is available at [1]. Add bindings for this chip.

[1] https://www.mitsumi.co.jp/latest-M/Catalog/pdf/battery_mm_8013_e.pdf
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
2.41.0

