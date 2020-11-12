Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5322B1212
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 23:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKLWti (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 17:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgKLWti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 17:49:38 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05440C0613D1;
        Thu, 12 Nov 2020 14:49:38 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 74so10959902lfo.5;
        Thu, 12 Nov 2020 14:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPhbBtY24leD6EYjNk4lZTpgtDU5k3awjWfX3kBti/E=;
        b=n6dMjr4I786NVBj4lXSxCXhGSqx6jWaAeEJUOT4wguu7hju71yefq+5ZbgRhrvHIxl
         5ajI0mT4A3bXfiPq927cQjvSHaunu+UgRgG9qwpPU7gDL5C2ANUlnHk2WeMWFX7wbprd
         ssJDaCuy4FkH2FwnJ5Fd+qwfTr5a+eXWo+sOX6xvBzstt0WcWGldNwVP9hwNoct4wNHs
         JlOy/cXZPD+30ISA3ICfJ69hGL0pqrSB2/6wZ32kok+xbnxukVPv3tTYA2LcSMZ5FwJH
         K/QZA/HfGNy9rQeZ90k9mswqK2nZdIlGahtAlJzWmoLw5vvPDITvPf3PofDbaNaEbqus
         y42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPhbBtY24leD6EYjNk4lZTpgtDU5k3awjWfX3kBti/E=;
        b=i5RdHzuSZDn60c5kKIUE/ugp0/ze6ERIwwiO0HMRSYiwkt/FWbYLz20P1L4ecT1wQp
         Ap8MYJzeRBb2ukWDRITENMgqV8ENnhufQJSHVbr1XcAm5kk6Htp9khDuwg83HXuSPi2U
         DV2BbTHI2u2LhKRuzVzfCzxybDcr4zu7zv0HiMjy/c6llbjrpLzoqof+YDbDjiOSeH8S
         qILYV+n17oEqiwUVKDYpCHUnsFIkpvKkyzc4ahmzfkKgKcFcDgVqZVi3iuuN+/AuJzzD
         cGTFRpkOpQJntdk7ZMKthBJX6JAdP5Jw5Gn83Bm2IyXpdG56QbU/lQSkAW0UzwoG7EM/
         ChzQ==
X-Gm-Message-State: AOAM532VQ3q94VY0WDTjQUW6Uf9nuQyMC9ydesTYB0bV++GwCfLyvyJ4
        6SlpC/tNt/Ch88qLDtoCpac=
X-Google-Smtp-Source: ABdhPJwEocKTqUtqEdlhi54Azueft+2QnNOkGYJOuhiUBroKwT2nknMHjFgtxunqII1+FN641gEFdg==
X-Received: by 2002:ac2:5619:: with SMTP id v25mr680010lfd.102.1605221376476;
        Thu, 12 Nov 2020 14:49:36 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id z187sm1006536lfc.126.2020.11.12.14.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:49:36 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
Date:   Fri, 13 Nov 2020 01:49:20 +0300
Message-Id: <20201112224923.4028-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112224923.4028-1-digetx@gmail.com>
References: <20201112224923.4028-1-digetx@gmail.com>
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

