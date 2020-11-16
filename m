Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3813A2B5184
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 20:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgKPTsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 14:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKPTsh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 14:48:37 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8788EC0613CF;
        Mon, 16 Nov 2020 11:48:37 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l10so21521166lji.4;
        Mon, 16 Nov 2020 11:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPhbBtY24leD6EYjNk4lZTpgtDU5k3awjWfX3kBti/E=;
        b=sS/d5ozCmT1WlBzzt0I/v5pN/qs2V9wYs5BYxc9uvrZguVwfhBLuRck4/4WliimdIs
         REasW796idVIkAaTlIFGvmWhF1Ej0NU8ytKq9p32yxrxPr4gDWBr6yKzPDYJDFAEahET
         WRP75CeY9HTd6cIzG23tbzXb1205tQUHrRgmhKUrUUH5u/2UizcStuejW0fQLfRsvTNx
         JW26axPjz0YNfXaijwykRn+y5L79XZaxU1VNAF5UFLRXX9YGgEfssF2v7VWgYNzn5EI2
         j9wJ3iHDbvrBaZFoLWICauF0w+cjPVPJ2AWTuahKADGQHx/nILRc2a/irM8ZdfPqDxep
         wzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPhbBtY24leD6EYjNk4lZTpgtDU5k3awjWfX3kBti/E=;
        b=uJGu7NfVHG3CJU63ocyhJGqpdFG5lHPMTZwnbW9TUb6m01dGwIvlGxdHsrJUFem3Yn
         Wuq0bE3kBR3NoY37j7cjD4CaOMngdGrVM8UCxgfVYNnuuiZBWFepVzJbZ4Iq63oJ7BoX
         8O8a6BxmS+/vlhTVLE4CWTyCId32j02NnvV67dwAiRnA7ssfKNYUiuwvEDaJWdvOdtj0
         erTNIho3RxFCc3JDbaPD/r13r/TuZdHXe+F066LEO+x8pyiFhp7BtLfLrNK/0kEYQ8LS
         fWuIy6QspJQw4lGS2pgsmz7hZFWj4NV/3+5WIf07/i9yTMw877knBbEva45V4x1Vrmjp
         crBQ==
X-Gm-Message-State: AOAM530/fNZChpi/uYgFaVYglS9O1SqXsfaF78k+b3fREuHSS58Z6BQX
        sATvPoh+vD5fp0oKn7N++NU=
X-Google-Smtp-Source: ABdhPJw/HQXTrEal7cje7AKUV5k2FWJFmFAwN4f9rUq/dt2O4wrdEwwIRSzKh9X0UGFnQLX4xgNwvg==
X-Received: by 2002:a05:651c:203:: with SMTP id y3mr370608ljn.66.1605556114482;
        Mon, 16 Nov 2020 11:48:34 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id n5sm2864286lfb.306.2020.11.16.11.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:48:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
Date:   Mon, 16 Nov 2020 22:48:24 +0300
Message-Id: <20201116194827.28947-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116194827.28947-1-digetx@gmail.com>
References: <20201116194827.28947-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add binding document for the ENE KB930 Embedded Controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/mfd/ene-kb930.yaml    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ene-kb930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
new file mode 100644
index 000000000000..06ed9ec8f4bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
@@ -0,0 +1,65 @@
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
+          - acer,a500-iconia-ec # Acer A500 Iconia tablet device
+      - const: ene,kb930
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
2.29.2

