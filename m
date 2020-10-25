Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA42984CE
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 00:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420353AbgJYXCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 19:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420347AbgJYXCC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 19:02:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430D8C061755;
        Sun, 25 Oct 2020 16:02:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d24so9479324lfa.8;
        Sun, 25 Oct 2020 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uupHzSrvUEtYcD/DIawVysd4yXQgmE4vD+y7+qxt6Iw=;
        b=AJBcDoQ58mATFLwlTwTItRFWQVcmqQ1tIZ2NQfKF0yDc/9iGdIjrOfEqx1eR4rOQdl
         Oab5qCdqCpN/fMQZK+ULorciKa+yhEXvMIpnwEcVUmkMKHeqnXbq0Hc9hMr1lB7KyF3M
         +3PB1poin9SXAsjJOju2O1XC7UhKDsFr8h/JMUgkPd5gpNAmPw3AMDwtCTlh9sRGb2AU
         HxCwKuAja7Z88O8cRtBVztRrCk82vLapY9TBU5D0UFuJqWhmxadMsVYWXbohV+AlKk2T
         WO7LDJ6n49CCMnrT6Az01xOxPaOpWLkc2Qfzi65NL0S9wBHLy1y8wZtYtg4fcBY2wE9i
         5SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uupHzSrvUEtYcD/DIawVysd4yXQgmE4vD+y7+qxt6Iw=;
        b=E9uDUK4UyQHEbNqdIemZF52iSJuba1H1tr8AswDblk+2NCWs2brYLRUQKR2fjxcHIy
         fyv4oDyKU19mf0DVYFvNvUxsLs8NYb5Es8v70g0oARcco9arEz+dlTLNuCZTo1L99/V8
         /pqvhGiuit10JRFzeh9R7bB5NDzYVeyz4Vu7f803WGYUO3f4+b/DkHzHOvCf+2EuHHcg
         IOd/kduvXoDnHrFTqwVgXe1GrH2pnwLNBMKh9QXGB6bS+dKuIMjwy3DO1tIbrPyBFcU7
         BNGflSsWRmsSmdFlRYMqyCCLQuXWLyF71XOWktD5VgwA/gmTO2+HjZveY+Vvk3aEcO1e
         rUfw==
X-Gm-Message-State: AOAM5302VFfIate0a2+PpMg0nW1AWpfaGMulDdETJzS0O/Imn30VKbeW
        UzKgZrqtSUgy/IZMmaGJ2p4=
X-Google-Smtp-Source: ABdhPJyugY4FZ2dj6El1LLMqB/8omgv03JXh5ZB9dfebD8am/dPh14Egk8eK7tDgkZZdE5/3Dl8wpQ==
X-Received: by 2002:a05:6512:3225:: with SMTP id f5mr3824479lfe.441.1603666920731;
        Sun, 25 Oct 2020 16:02:00 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id j16sm949619ljh.48.2020.10.25.16.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 16:02:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 1/4] dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
Date:   Mon, 26 Oct 2020 02:01:50 +0300
Message-Id: <20201025230153.11729-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025230153.11729-1-digetx@gmail.com>
References: <20201025230153.11729-1-digetx@gmail.com>
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

