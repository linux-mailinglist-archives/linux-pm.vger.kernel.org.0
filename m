Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A424025F048
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIFTvj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 15:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgIFTva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 15:51:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E62C061573;
        Sun,  6 Sep 2020 12:51:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b12so6427473lfp.9;
        Sun, 06 Sep 2020 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyFVRrq7oNAkyBDcab1pW5QCuvDZJBB4EknZ7t3FCyQ=;
        b=FjPv8tOM4FBh/CLhJkVsKZdT31s0rjSmN5qV1MfwaP7Iv5UON4zmgkqEJGqViLNq3W
         yQtG9heHntzY/MHYNJxRvyjmXWoWDEYjMrCa3HoTqylNalhYnOiWxjVl+dq9bQgEBR6d
         f1sOHI9t04+jc0rlXKWieqnK8UJfHkVHtcMVW0q1FX6nxQQdVARgsmbrNSwC1dmmShFz
         U5vquJplAF7zWBVyAM51alG5WS8Dk4iNufN617XsMy2XOloJ6TWo0w9g1ZLryq1MxlH4
         574fb4f6XMDdgcfFeJeY7RKflRmx36gcUS82WNL8J0eLngAD7Ges0sHM39wboaXvVkhO
         YBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyFVRrq7oNAkyBDcab1pW5QCuvDZJBB4EknZ7t3FCyQ=;
        b=gW+1ZaoWZah87VTt83K/C/VWfm0R5T9j5mM0C6r6ZCCLIDHSYQcmdMDkVlw9hsYMlo
         8ycrXmMu7Q7/rYWNmDzEyV2riil+ahKUrm44c2eHYIRn8kNaxa4xReuaNbCMgtoCJ2BZ
         EGk14Y8T/yb5pyGg6JyUHiCpKiEBMWhryHACHg+NMiHHJw+xVK1flBsBWa2Y8Jh/pX9M
         +b0i2P0gBGib0Ebn9mTZMg4Qz+nBO2AUb75rsbOWWB/SpaciRii07rJhGRlUwEdZMtfz
         WfwofVGMSlvJXao4bg2EixB1YBpmoL7Nfiu0PVrq5iBK86wI6p5+MI3W6pDf2VTTRjT+
         Br2g==
X-Gm-Message-State: AOAM533OAY/Q7wEbzyLBxyWT9TaIHrglDYNZ7Qk06a6kS6GaMV2TatuL
        035Kk2/A78XQ3SgaAjQ+KAY=
X-Google-Smtp-Source: ABdhPJyQ4SMKxWY6kGyeKB7uBWsDjTbkL01fuiofXbrjJA1j/cifvBDot70J0IM0cDVq2ry6PzlvQA==
X-Received: by 2002:a19:4ad8:: with SMTP id x207mr8509418lfa.73.1599421883105;
        Sun, 06 Sep 2020 12:51:23 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b7sm4942574lfq.36.2020.09.06.12.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:51:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
Date:   Sun,  6 Sep 2020 22:50:59 +0300
Message-Id: <20200906195103.1347-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200906195103.1347-1-digetx@gmail.com>
References: <20200906195103.1347-1-digetx@gmail.com>
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

