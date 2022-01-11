Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8EC48B480
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jan 2022 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbiAKRvG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 12:51:06 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33070
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344755AbiAKRvE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 12:51:04 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CE8393F17B
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923463;
        bh=0lTX/pRjq8fGrSEdb45cqNSVN0bzGZ2/ArUtBalm9jo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZQG7YKfk6j3R4TQzqSMb026CP26feajCHRODFrKB0rzUfchk67MRY7tsbpvTzwXUz
         YJvRHDsNa4zpoDsI+H53VEedvQFfI7xtysSR1+5eShDtYBJzDm7R68/us1ugBMYLps
         wHsGSnb8+gDClTveYKsoGb6qOV6finclsPHCRfwo7BOyllHUofbgljRTgTtvpIx95P
         TQ2y1qIBiaYWQM8spAJ3UBy1XOupnvg8RvTtiLSAfL/ycS6cLX/PNGB7EI3aCTVriq
         NOkpY2DlJHdVfKHUlrEXJxAELwgOpZwbRSAjNuDPWj0pI5VwrjyT0DwCRRh4srHn2G
         gp+DHOiE43mrg==
Received: by mail-ed1-f69.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso13974088edd.22
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 09:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lTX/pRjq8fGrSEdb45cqNSVN0bzGZ2/ArUtBalm9jo=;
        b=5Quq8gX1UHm3y7N1yXQhEPs1jBNbioFOSuqm/P9s7jUw2vfR92MPhqpf9YLK4PY5Ft
         8n4WpIatNhRu3lA51S8NufbnhE7UzAhh/pwdQf8iewtKTNmoGgrIFaigzM7q1hHDUlRq
         nkQNhShH8Wij9L/dYxk/IZLOALRn8n1t50pe+DZ4dkFwso7QmjfkFtRwjWrVq+sdxqn1
         XdsrVt8M8YCjdJAGob/nmkiOu1I3XQYID0QVYEIWhxhs6e/wiQu0AtlplAn+PJpbjT63
         2yHO23mg+tA4rW672AGJz7Noapgv46Qjkren66D5EjUMxBRGsKQEd2RoI8W5jZsp1fBm
         AqPA==
X-Gm-Message-State: AOAM533nbVloiIVcM4GuC20SNw9b+8E7iR3jAp906ykBp+boGJuFwxEk
        lFciWTRmHOTb4UuZwVpTJ9zEDLK15paN+0CAfYmtRcUMi6Px9goY0vZJtLzUIzO1VlDjzX9sVfG
        F4JZrlV9FNvHAA5g/zhxtYB7M8RoVSQ/h3i6O
X-Received: by 2002:a17:906:7199:: with SMTP id h25mr4637462ejk.734.1641923461941;
        Tue, 11 Jan 2022 09:51:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1N007d3shEa8Ib3SDImdT17QSvZTGxNtwZXkqztluxz5huESUnu16sC4O6EqMG0YJnFlSOQ==
X-Received: by 2002:a17:906:7199:: with SMTP id h25mr4637445ejk.734.1641923461774;
        Tue, 11 Jan 2022 09:51:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p25sm5265160edw.75.2022.01.11.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:51:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] regulator: dt-bindings: maxim,max77693: convert to dtschema
Date:   Tue, 11 Jan 2022 18:50:16 +0100
Message-Id: <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the regulator bindings of Maxim MAX77693 MUIC to DT schema format.
The existing bindings were defined in ../bindings/mfd/max77693.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/maxim,max77693.yaml    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
new file mode 100644
index 000000000000..20d8559bdc2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max77693.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77693 MicroUSB and Companion Power Management IC regulators
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Integrated
+  Circuit (MUIC).
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
+  additional information and example.
+
+properties:
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
+      regulator-min-microamp:
+        minimum: 60000
+      regulator-max-microamp:
+        maximum: 2580000
+
+    required:
+      - regulator-name
+
+patternProperties:
+  "^ESAFEOUT[12]$":
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      Safeout LDO regulator.
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      regulator-min-microvolt:
+        minimum: 3300000
+      regulator-max-microvolt:
+        maximum: 4950000
+
+    required:
+      - regulator-name
+
+additionalProperties: false
-- 
2.32.0

