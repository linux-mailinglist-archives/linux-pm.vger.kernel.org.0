Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5627D3A2
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgI2Q3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 12:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgI2Q3m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 12:29:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A72C061755;
        Tue, 29 Sep 2020 09:29:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so5255094wme.0;
        Tue, 29 Sep 2020 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gh/tlPqiq/FZnDdP8E5tcF0cibUYZB3Ry3faufJFMVM=;
        b=HPuWWNkfK+jQKOl24Ehxv9m+1PfR1hoQk+vVHZ2SwmiYMwALgUUcQoA4YfvqzGI+wG
         jJ7c0oypKikE7lO+SFmfUhIZxzGTLZf7z0NIIv0kJN4q3NCQcmQtubdOIsGmYDJEfxYE
         wCA8DwUPp4i1Os+5QT5Hp4hOI4ATde9k/+ULaaXA5Y0lQq1cb5vG2eZgyypdO0mDxoG7
         r/blkSaELSbp+2f/1SIvJQsKwbvTMbQ8CfSH5M3icUKZJz9h1zBnHnPktVc8SW1s5ll9
         +yoIQGmxebm3Sq/n2xWxUhWtSs/XkOctoDO65WYX8r/a/GWl6tgFP9dtZyWVa6YO0cUM
         6vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gh/tlPqiq/FZnDdP8E5tcF0cibUYZB3Ry3faufJFMVM=;
        b=KzAN4av5Q5dUd+9OEvJiw8N+cnipMc5Ta7aW+Ct8p+d2AsV5+KgsUuhfmT7LrjhcA/
         EXzrgR1ltI/StDwe1DxY/PJXeY0eAIBu3IyvAZxOZY4wzXuAZK3g5fZzvKWReC+S7rDw
         OkT2IZqzPp/7hWpGkOs9AYTtfCRBS+NEl/wIl3lsYzAcJenvmT0Z+pQU5rl0tvWEjSub
         7e4gTipEW4snqPtsdskFz1zT5tcBrp82HRZ3vAYa9acb50hdYdsk0JgGW0WVqubww+DL
         vA0nY1bZY2qWdfxxu2+7UL5gOUA3GXIRUKw4fFJ/hZKdLkhp/TmWLPfivk5d5gCtk1rz
         fk/Q==
X-Gm-Message-State: AOAM532ioGfwZp9IvTA20PDmhG39wLzp4eRJU7rXt5Xjrf7QHCr0vQod
        0GxFdWXjkA4w9pjWQojfVhs=
X-Google-Smtp-Source: ABdhPJzIGUcKUzqwlkAiT7IvPHP6YHI/kEzUbtF2AV4uOlifcLP5+lC3xoRvk8uxHrNdZk/o72Pncg==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr5529323wmb.32.1601396979503;
        Tue, 29 Sep 2020 09:29:39 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id y14sm363781wma.48.2020.09.29.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 09:29:38 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: arm: Document L2 Krait CPU Cache scaling driver
Date:   Tue, 29 Sep 2020 18:29:25 +0200
Message-Id: <20200929162926.139-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200929162926.139-1-ansuelsmth@gmail.com>
References: <20200929162926.139-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document dedicated L2 Krait CPU Cache devfreq scaling driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
v2:
* Fix problems reported by Rob
* Update example to use opp v2
* Drop unused voltage-tollerance
* Better describe scaling thresholds
* Add bindings to describe Krait L2-Cache

 .../bindings/arm/qcom,krait-cache.yaml        | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,krait-cache.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,krait-cache.yaml b/Documentation/devicetree/bindings/arm/qcom,krait-cache.yaml
new file mode 100644
index 000000000000..4143a758dc28
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,krait-cache.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,krait-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait L2 CPU Cache
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  This describe all the needed bindings required by the Krait L2 CPU Cache.
+
+  Describe what level is available for the shared cache connected to the
+  Krait Cpus, the qcom saw used for qcom spm and how the cache should be
+  scaled using operating-points and cpufreq thresholds.
+  The Krait L2 CPU Cache Scaling Driver scale the frequency and optionally
+  voltage when the Cpu Frequency is changed (using the cpufreq notifier).
+
+  Cache is scaled with the max frequency across all CPU core and the Cache
+  frequency will scale based on the configured CpuFreq threshold in the dts.
+  (example: CPU 600000 kHz, L2 Cache will be scaled to 1000000000 Hz.
+            CPU 1100000 kHz, L2 Cache will be scaled to 1000000000 Hz.
+            CPU 1200000 KHz, L2 Cache will be scaled to 1200000000 Hz.)
+
+  The CpuFreq thresholds can be set from a minimum of 3 bin (idle, nominal
+  and high) and upper but the Krait Cache supports only 3 operating points.
+
+properties:
+  compatible:
+    const: qcom,krait-cache
+
+  cache-level:
+    const: 2
+
+  qcom,saw:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: |
+      Specifies the SAW* node associated with this L2 Cache.
+
+      Required for systems that have an "enable-method" property
+      value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2" defined in
+      CPUs node.
+
+      * arm/msm/qcom,saw2.txt
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: l2
+
+  qcom,l2-cpufreq:
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
+  operating-points-v2: true
+
+required:
+  - compatible
+  - cache-level
+  - qcom,saw
+  - clocks
+  - clock-names
+  - qcom,l2-cpufreq
+
+examples:
+  - |
+    L2: l2-cache {
+      compatible = "qcom,krait-cache";
+      cache-level = <2>;
+      qcom,saw = <&saw_l2>;
+
+      clocks = <&kraitcc 4>;
+      clock-names = "l2";
+      l2-supply = <&smb208_s1a>;
+      qcom,l2-cpufreq = <384000 600000 1200000>;
+      operating-points-v2 = <&opp_table_l2>;
+    };
+
+    opp_table_l2: opp_table_l2 {
+      compatible = "operating-points-v2";
+
+      opp-384000000 {
+        opp-hz = /bits/ 64 <384000000>;
+        opp-microvolt = <1100000>;
+        clock-latency-ns = <100000>;
+      };
+
+      opp-1000000000 {
+        opp-hz = /bits/ 64 <1000000000>;
+        opp-microvolt = <1100000>;
+        clock-latency-ns = <100000>;
+      };
+
+      opp-1200000000 {
+        opp-hz = /bits/ 64 <1200000000>;
+        opp-microvolt = <1150000>;
+        clock-latency-ns = <100000>;
+      };
+    };
-- 
2.27.0

