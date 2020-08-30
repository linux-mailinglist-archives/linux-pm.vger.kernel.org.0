Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA5256FEC
	for <lists+linux-pm@lfdr.de>; Sun, 30 Aug 2020 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgH3S4C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Aug 2020 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgH3SzF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Aug 2020 14:55:05 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674BC061575;
        Sun, 30 Aug 2020 11:55:05 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c15so2325197lfi.3;
        Sun, 30 Aug 2020 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyFVRrq7oNAkyBDcab1pW5QCuvDZJBB4EknZ7t3FCyQ=;
        b=eqfaNI4/kuXYQV3upPkbU1Poja6coHGtkB3x+Zbdd5q/kvBXoQ3WVV9lVlV7SmiKJ2
         u21imvSfFW/H0FNjchmlvEAXLj4xmsNmVgUbbZrvwGeNwR9G/mRS4eRzGYBM+cyW+gTg
         IZ17Q0jzzEWXu17fMMVPiuT5wqW0NWC57P0Pb8ZN+uf/HwK04jKAr42E5pQtSYOVOchw
         3DbZh8uUm1VtQllkW3Oh6HsMoH+tB0dT2jLFkUdlyPf9BO8wKy9EN1j0BhBtphNMxdgg
         UYiUIxzauGngNYfKiHmjcosKfLOX1vKH1B5D91Ft2SIqdsTRkvsZwLx0nLnm/4RChzTF
         Y6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyFVRrq7oNAkyBDcab1pW5QCuvDZJBB4EknZ7t3FCyQ=;
        b=jvMu5R0E45gw2ptg3+6JANJyTs4ec0hUXNN7cbDT3sIRpAJqO04fFM1wKJkd2eYvjt
         nZfV1yRt1iPeLroCYAsiCp6o+bjz5bheuPsffytGejAsy3OpZQ0a0KML8B5iYlqTPTuZ
         DYKUZ4uQa5Lw+kbmSqXFQ0DhrMKpp8R625fFlr2vMneJWbJOUyYv3bhH2stMoOnegC3g
         S/y3lIcpBYFL1wbwQWoVsTcktQpZ/ccC1dCEyDjysSq7tHIKdnFbgPT2rWM5xDr3kZoO
         sVFqlJ29uEj9Y8ZGFZArvzINagdFXvBB0Rfqzrfj7VFz7+NykoONkHd7r2ZuFuTDGx7c
         iXKg==
X-Gm-Message-State: AOAM532l4G5JV47ZAxThsu1HaAVoqBMyo9cH2yiG8k1ptXnXRIbwuaYh
        XG/3nMHD4o0nqBgS2s4B+Hc=
X-Google-Smtp-Source: ABdhPJxSgb/zvqZMjCfnMXtPsXy8CIvbp061yJoZhxOfVfnVI7ZEnO98gX7KcwhZ8GNi9zDUFR/Yeg==
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr3884946lfk.188.1598813703445;
        Sun, 30 Aug 2020 11:55:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id n21sm21630ljc.89.2020.08.30.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 11:55:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
Date:   Sun, 30 Aug 2020 21:53:51 +0300
Message-Id: <20200830185356.5365-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200830185356.5365-1-digetx@gmail.com>
References: <20200830185356.5365-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add binding document for the ENE KB930 Embedded Controller.

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

