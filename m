Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA27224D6D3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgHUOAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgHUOAp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 10:00:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE5C061574;
        Fri, 21 Aug 2020 07:00:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so1724325ejz.0;
        Fri, 21 Aug 2020 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSZpK9kwGLydB4QOqHGik97SZh68Cr5AJapAdxuuNUg=;
        b=kgeWtd3NVY9p+WPW8IHdDM5phyXLxXa4QsFkPvx1y8lfNncmDzM2Cc0lJuRKfE8f6m
         7b5cmM6BuXT3brvf1suue+T25ztJbL6bUn/r39Bcc1vn1a1hGGbdZLbmOJdGMZ0G1C5W
         P8SQ1Zhuq+/Flkhmwgibg3OzFRxNcmBTxE4NNKpVhlgBPla3HJ1u2vaPOwNU87jNK/gc
         LZBbbDCqkMk6Tr0RjMWkakgWUWJh+YN3wPeeEdlja4CAeH2vv21ycGYqix2+n4A0R8Mt
         8/BQn+dP/RTMyhbs2g8NJ4E0ucgrP1A6VYOex9wTckb7sg4dVXT9+GKj9TOUUI2T34//
         Q2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSZpK9kwGLydB4QOqHGik97SZh68Cr5AJapAdxuuNUg=;
        b=rsO/v/F+T3Kf5H3VWBYcsONr3L84g4dk5yWq02CHWMc5DF/+puqnLyJ/1o1wiCRf57
         Vi1pEYseK4ZAtcGUkOQoQacTaCJfO5ktsBYr2O8ATYqCIk0paWkISbSxczOSekwVtBZc
         ATq5E4uNUHf0jSxNYmwAUsfRX5eZLkNkaTUIWGsG2CSqNWOh7l0Lt0PJXdSasvgk7QdJ
         CWRRC9ytmAmqkHDjfNCrYUuih5/pQyPcHEQG8hZ7JZXOm1VLYh/rosPxkNwzoxRLCpCL
         jivWhM5wwGqyuYmzlq36/N60S3k1gGVCQfeBFuC2JDubeUiYFModEmELaM/60jqsguYl
         BNHQ==
X-Gm-Message-State: AOAM532PXM/ur6u1l/fyoYWxe4myjAQqJYWYO/C4q2/oOWWzrr+Wfuzt
        C22mkkScraIKKW4RtYuzEdo=
X-Google-Smtp-Source: ABdhPJy+rPt9DWKhlUipa4kKD90D+bKkwDOBPSwRPiv+ydWboWDvB6uFb+NlKgbbPD3g4Zfzh/S8tA==
X-Received: by 2002:a17:907:36b:: with SMTP id rs11mr3168147ejb.544.1598018443883;
        Fri, 21 Aug 2020 07:00:43 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-10-16-66.retail.telecomitalia.it. [87.10.16.66])
        by smtp.googlemail.com with ESMTPSA id c7sm1152969edf.1.2020.08.21.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:00:43 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/2] dt-bindings: cpufreq: Document Krait CPU Cache scaling
Date:   Fri, 21 Aug 2020 16:00:21 +0200
Message-Id: <20200821140026.19643-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200821140026.19643-1-ansuelsmth@gmail.com>
References: <20200821140026.19643-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document dedicated Krait CPU Cache Scaling driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/cpufreq/krait-cache-scale.yaml   | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml b/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
new file mode 100644
index 000000000000..f5f1c9b76656
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
@@ -0,0 +1,79 @@
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
+  The cache thresholds can be set to 3+ frequency bin, idle, nominal and
+  high.
+
+properties:
+  compatible:
+    const: qcom,krait-cache
+
+  clocks:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: Phandle to the L2 CPU clock
+
+  clock-names:
+    const: "l2"
+
+  voltage-tolerance:
+    description: Same voltage tollerance of the Krait CPU
+
+  l2-cpufreq:
+    description: |
+      Threshold used by the driver to scale the L2 cache.
+      If the max CPU Frequency is more than the set frequency,
+      the driver will transition to the next frequency bin.
+      Value is in kHz
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    items:
+      - description: idle
+      - description: nominal
+      - description: high
+
+  l2-supply:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: Phandle to the L2 regulator supply.
+
+  opp-table: true
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - voltage-tolerance
+  - l2-cpufreq
+  - l2-supply
+
+examples:
+  - |
+    qcom-krait-cache {
+      compatible = "qcom,krait-cache";
+      clocks = <&kraitcc 4>;
+      clock-names = "l2";
+      voltage-tolerance = <5>;
+      l2-cpufreq = <384000 600000 1200000>;
+      l2-supply = <&smb208_s1a>;
+
+      operating-points = <
+        /* kHz    uV */
+        384000  1100000
+        1000000  1100000
+        1200000  1150000
+      >;
+    };
-- 
2.27.0

