Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D3423F555
	for <lists+linux-pm@lfdr.de>; Sat,  8 Aug 2020 01:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHGXtf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 19:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHGXte (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 19:49:34 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A240C061756;
        Fri,  7 Aug 2020 16:49:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l4so3697203ejd.13;
        Fri, 07 Aug 2020 16:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHQBU7t7T20Mh1z63rmZ4I7YSFYzsVFZZE+YkusJ0rc=;
        b=sM38sMaDokJqT/vk8/35OVNaZAePDPVhSzz83SpBrV4shGmijp9eCcA8Uy0uC++VIA
         a9pZlZKUvEMuB5SPJd1NBw/3vi38RfsUr2pK03VSzF5WrR1G0WpBxhZihU9rDMcxYl/y
         zD/GSVvXauB+nbxOiKbql+y47yGOmKjJCGKpF6wjE07pNKY/6EURXpM0oYIm6K4CJf2S
         oVfMScQ209biRBR2SOvsWh/bwjbJ/552UWUbaPteMoM4jgL+dR5PCmK7Yflq2AnP0u/k
         gpOQt67yyjkTJ5lUY0UA6iSd3ArsfqwMZP7Fcsm5o1ePW7bTWT1f30d3qsbwV1U+hzuU
         v76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHQBU7t7T20Mh1z63rmZ4I7YSFYzsVFZZE+YkusJ0rc=;
        b=ZSM8ramGuNztETud/Ghk4k2eiR2h86jdSgUNHXwbk749pyny63J+LiVUuEe6l0bdhT
         BbiD64WetC49hamk/v4a2V9af52MX7111tY8hDT3gtyYxAadBRWQxaoG8tzddN3sIOFM
         UNAgxeX9C8CPRUkkQiFFQ8VsN8ySXQ/Y+kTSvvsmiKl/RYmj38uENIrZ4gJ/IaWH+2gb
         jtaCWMbQr1f2RsnaH8DLay/kO3vq52Ig/QHpdTSRKDUvI6Vl3O2uN+6+YHDUXF/DSkZ4
         7FD79jP5OOIfKLsdvYxG3pHx33kDG50Q0y+RjCpII9Ck3ARZWQqCskl5vERbUPv89++u
         HB+A==
X-Gm-Message-State: AOAM532M4jgtpJ12T4oglfLh9q4sGC9NT7IzGS4fLYF/tcRpvBlyFJg0
        4NQpo4D+ZrMRCeN68P/EmY4=
X-Google-Smtp-Source: ABdhPJw/cjforkPb3dWMq6damt7+jFKHTFLKXmaPTyWK5qxmEwrx+QbHedOGzkf6CoLMWybIwC2WNg==
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr11502645ejb.91.1596844172842;
        Fri, 07 Aug 2020 16:49:32 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([87.13.195.83])
        by smtp.googlemail.com with ESMTPSA id k17sm6977826eji.28.2020.08.07.16.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 16:49:32 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document Krait CPU Cache scaling
Date:   Sat,  8 Aug 2020 01:49:12 +0200
Message-Id: <20200807234914.7341-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200807234914.7341-1-ansuelsmth@gmail.com>
References: <20200807234914.7341-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document dedicated Krait CPU Cache Scaling driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/cpufreq/krait-cache-scale.yaml   | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml b/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
new file mode 100644
index 000000000000..f10b1f386a99
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/krait-cache-scale.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Cpu Cache Frequency Scaling dedicated driver
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  This Scale the Krait CPU Cache Frequency and optionally voltage
+  when the Cpu Frequency is changed (using the cpufreq notifier).
+
+  Cache is scaled with the max frequency across all core and the cache
+  frequency will scale based on the configured threshold in the dts.
+
+  The cache is hardcoded to 3 frequency bin, idle, nominal and high.
+
+properties:
+  compatible:
+    const: qcom,krait-cache
+
+  clocks:
+    description: Phandle to the L2 CPU clock
+
+  clock-names:
+    const: "l2"
+
+  voltage-tolerance:
+    description: Same voltage tollerance of the Krait CPU
+
+  l2-rates:
+    description: |
+      Frequency the L2 cache will be scaled at.
+      Value is in Hz.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: idle
+      - description: nominal
+      - description: high
+
+  l2-cpufreq:
+    description: |
+      Threshold used by the driver to scale the L2 cache.
+      If the max CPU Frequency is more than the set frequency,
+      the driver will transition to the next frequency bin.
+      Value is in kHz
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: idle
+      - description: nominal
+      - description: high
+
+  l2-volt:
+    description: |
+      Threshold used by the driver to scale the L2 cache.
+      If the max CPU Frequency is more than the set frequency,
+      the driver will transition to the next frequency bin.
+      Value is in microvolt.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: idle
+      - description: nominal
+      - description: high
+
+  l2-supply:
+    description: Phandle to the L2 regulator supply.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - voltage-tolerance
+  - l2-rates
+  - l2-cpufreq
+  - l2-supply
+  - l2-volt
+
+examples:
+  - |
+    qcom-krait-cache {
+      compatible = "qcom,krait-cache";
+      clocks = <&kraitcc 4>;
+      clock-names = "l2";
+      voltage-tolerance = <5>;
+      l2-rates = <384000000 1000000000 1200000000>;
+      l2-cpufreq = <384000 600000 1200000>;
+      l2-volt = <1100000 1100000 1150000>;
+      l2-supply = <&smb208_s1a>;
+    };
-- 
2.27.0

