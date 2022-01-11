Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3848B440
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jan 2022 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbiAKRoY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 12:44:24 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53514
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241318AbiAKRoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 12:44:22 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5355E40A56
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923061;
        bh=CoNoPr6o16kqFclEK0AzeM1mRIrDJDm6YGhA4HJ8sC8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mSF2xoAgOHloW/A4SamJQA86FE7wp0OG5+JNwGWQaSHZnX4/WCwYi9Hhg6F7qDP+D
         HHluhWoFHSgsfvOiH4RD7p0tFYnsnm14nALzoWeIHpto9+B14JuzPs0bwX3AnmCTsK
         GZmeOOC3Juy7/94oPHd+k5S+TummpbcH2L7pIQTCmErw9tB78OHWblD12QB1tUwENI
         C0doHrSZ2ablRloVGtqIc/fbc15HB/NLrUn5GmUQmrCmu/zQ3iFRaraBh/C/kYV2ck
         DDDMIneFXibdSacknpEc33vDz3PpgdO9wUd0R1om5qZCgNI+HrmDSDD0TtmZ3FU3+o
         25/xw5AFzH25Q==
Received: by mail-ed1-f72.google.com with SMTP id m16-20020a056402431000b003fb60bbe0e2so11127890edc.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 09:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoNoPr6o16kqFclEK0AzeM1mRIrDJDm6YGhA4HJ8sC8=;
        b=rYKRPYXIdnvqLy6IYc6kDWAfLWyTqS3y96AlBS+1MXXiUSe7YfZMKpiTffOo9jolZc
         hlmZa1ACVrodTgGmnKZsnJkjgzKdF5xPzDVtSReG4k57Fih+DSTfpRpNM+EFrnZ4KeTY
         pLe+0xGbyJVwdbpoG6zOnPgOBX1TQtvwEla6P8f96R+Db10nLeynvWbiyPlEERl8e7kY
         PvSpjVV4BdQFm4knMBe+k9Lusf4eWwPUIKNDCepfFG15YjZhMaogUqZW/FRsQvM1i6Si
         0u49tmkpgGpyPznnzaaURYyOCSLm5+2EgUrQQD2kGW85G0keI0C2vPVNOAp+1L9tMj1t
         yxLA==
X-Gm-Message-State: AOAM533b5i8Wa4WuRnOHq6gqiyVMlGNZcMI/vd6KPnANzLeL4EPfSGWU
        76pINgWhwdjfd32v+uLhnj0JdsoaC4OHYAcmAwWXRrmW3ZRxlxAD09272f32u4s1jkL9hTc73JQ
        4DxK9mNvyFmPknvbeRCemeuPUEKaN7v/YjjyO
X-Received: by 2002:a17:906:38f:: with SMTP id b15mr4584742eja.661.1641923060944;
        Tue, 11 Jan 2022 09:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFdC8KhRpjLNc8OqCmDTo1S5yleeLeqi+l50v2tbeeFbnrup7LnrmvEZTc7JBwdVDLrZCe2g==
X-Received: by 2002:a17:906:38f:: with SMTP id b15mr4584723eja.661.1641923060742;
        Tue, 11 Jan 2022 09:44:20 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g9sm3758657ejo.222.2022.01.11.09.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:44:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 3/4] regulator: dt-bindings: maxim,max14577: convert to dtschema
Date:   Tue, 11 Jan 2022 18:43:36 +0100
Message-Id: <20220111174337.223320-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the regulator bindings of Maxim MAX14577/MAX77835 MUIC to DT
schema format.  The existing bindings were defined in
../bindings/mfd/max14577.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/maxim,max14577.yaml    | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max14577.yaml b/Documentation/devicetree/bindings/regulator/maxim,max14577.yaml
new file mode 100644
index 000000000000..4212f10644a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max14577.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max14577.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX14577/MAX77836 MicroUSB and Companion Power Management IC regulators
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX14577/MAX77836 MicroUSB
+  Integrated Circuit (MUIC).
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max14577.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max14577-regulator
+      - maxim,max77836-regulator
+
+  CHARGER:
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      Current regulator.
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      regulator-min-microamp: true
+      regulator-max-microamp: true
+
+    required:
+      - regulator-name
+
+  SAFEOUT:
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      Safeout LDO regulator (fixed voltage).
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      regulator-min-microvolt:
+        const: 4900000
+      regulator-max-microvolt:
+        const: 4900000
+
+    required:
+      - regulator-name
+
+patternProperties:
+  "^LDO[12]$":
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      Current regulator.
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      regulator-min-microvolt:
+        minimum: 800000
+      regulator-max-microvolt:
+        maximum: 3950000
+
+    required:
+      - regulator-name
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max14577-regulator
+    then:
+      properties:
+        LDO1: false
+        LDO2: false
+
+additionalProperties: false
-- 
2.32.0

