Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1D2A6ECC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 21:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbgKDUeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 15:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732126AbgKDUeU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 15:34:20 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072FDC0613D3;
        Wed,  4 Nov 2020 12:34:20 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id m16so24407221ljo.6;
        Wed, 04 Nov 2020 12:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uupHzSrvUEtYcD/DIawVysd4yXQgmE4vD+y7+qxt6Iw=;
        b=U2ezc04ej10ExV+0CyLzp4uqgAZAPzYkXBIJ4y2peICC07SPbkYjroOvm3uO9YeQGv
         +C8zJxQJMHrt1u+SL3sGbag4fiKg/zfdV+NBK2Hmyfx+3P+DAm4EauKJgbgH023QzoUz
         ngO3wg82SW46XUV5EyILcGNeGoIowLFVlx93HKv+ZOF5n2sBgDgX49Qw4NUcNVNf2euj
         wDYK0P88tsu+rGsbPBfCR38tmuWSRzTdhUhiSgXB9z3SnRC3a3kmHBZOH7zrpJxonLX/
         uAN+pIXl+DwD1nvLF26M0pg02Tos8bGac5euFUTP8LB8mlbFnBFxNIGwDsqFNWTykqCB
         qiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uupHzSrvUEtYcD/DIawVysd4yXQgmE4vD+y7+qxt6Iw=;
        b=Omou78XoNpjktU7uoFPGxYrcrMOAT0Y9XuLYrRvSdJ5u0UKTT+2sFg3pkuC3RW89jp
         2kZZYgf3w2api33+OkRYRtj07AsTlmjGvloFo0WkpeZytzNd3rRIR8f3UBFS5DTods5b
         K3jv6gXFyt54YFneDi7iimg2gIN+Wlp9uppuDerqnjwkklY1+66nAHxOH3xeKGISoJml
         jubYpsBZ6NH9s2UA2Shn+yzkzKodnkzTnBS0lo9eSomn2ODdaDZ8GorVenpQ95xMoY/L
         CzfSyLFVc9pN0TCBbupxhVYunhzVqzMNbmMzB7l/r+oUzyKPL3vlhwlXFRbG7d4PXeXl
         GfTg==
X-Gm-Message-State: AOAM530L0ZRcljXpgrYhr7iPG5XFH7OKmmMpmpMLJ0D2fV9d+dTsPWQp
        o6/JcXn+RwJPAKY4iZb6IiE=
X-Google-Smtp-Source: ABdhPJxGq5biOfdM5okW6Eec6fIh7ZyYN13nU6kKvftLBxvRrRbwWYLAfWcEjdQXJubPSyIqi7160g==
X-Received: by 2002:a2e:9148:: with SMTP id q8mr11976153ljg.182.1604522058483;
        Wed, 04 Nov 2020 12:34:18 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id u22sm615084ljk.45.2020.11.04.12.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:17 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
Date:   Wed,  4 Nov 2020 23:34:00 +0300
Message-Id: <20201104203403.24937-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104203403.24937-1-digetx@gmail.com>
References: <20201104203403.24937-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add binding document for the ENE KB930 Embedded Controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ene-kb930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
new file mode 100644
index 000000000000..635c8966ca22
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ene-kb930.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ENE KB930 Embedded Controller bindings
+
+description: |
+  This binding describes the ENE KB930 Embedded Controller attached to an
+  I2C bus.
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - acer,a500-iconia-ec # Acer A500 Iconia tablet device
+      - enum:
+        - ene,kb930
+  reg:
+    maxItems: 1
+
+  monitored-battery: true
+  power-supplies: true
+  system-power-controller: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    battery: battery-cell {
+      compatible = "simple-battery";
+      charge-full-design-microamp-hours = <3260000>;
+      energy-full-design-microwatt-hours = <24000000>;
+      operating-range-celsius = <0 40>;
+    };
+
+    mains: ac-adapter {
+      compatible = "gpio-charger";
+      charger-type = "mains";
+      gpios = <&gpio 125 0>;
+    };
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@58 {
+        compatible = "acer,a500-iconia-ec", "ene,kb930";
+        reg = <0x58>;
+
+        system-power-controller;
+
+        monitored-battery = <&battery>;
+        power-supplies = <&mains>;
+      };
+    };
+
+...
-- 
2.27.0

