Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56BA27A1BF
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgI0QFe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgI0QFd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 12:05:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4234BC0613CE;
        Sun, 27 Sep 2020 09:05:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so9046864wrl.12;
        Sun, 27 Sep 2020 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xE6zcLWmkr9jxOFN4cq8fghmPVso+Cf/losTmFk8zDo=;
        b=Tc7i9fWZdbrwkVmKJwF/qxON99JjAQSksHY7kSAibWN49QEZYJtUWegn646tWc5vMu
         sMP4EMc6rJRrSihpITjdBki4qXKkNneS7/VbcURSMylEwBC8LsxRuXABPuGLnQVe0qKz
         kc0ti50IczlNCsdqC+UTGNN3R3UQqMuO6DU2HsthZO9CXc/AATDLfTKUV9Z0X3bqFYPN
         QHWt7AsN4iVoQdXbnDBMz30ZwYM/dJ7dmeoX5pMJ5UG1gHH7T/CKOel6bVCW2fLlo+/m
         JoMHzshqduXCPpYOLq1DzNKID+EOdVa1gzyTMRByNrm7HrIEBKpO2aOy7HVVZ0EZJQDK
         wcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xE6zcLWmkr9jxOFN4cq8fghmPVso+Cf/losTmFk8zDo=;
        b=bE1MR2oYZL2TzO2BhRZ0aH1HSnfbqodzUyRSXIPfLlwxrMiYtha5b1eTOp8Btuf8YD
         n5NhHyqd88cHAN1pze+eiOeNYZd1J6KepwZj7iegKc98zkUj2/y1hRqyOMUkmBc0omAP
         SO4r7vY8GEcY63jGj0J4hJ9G7GKnLMnKoySx0Akv7pzS+ik+YHlIs5QZghB/8lwn1a4j
         aj0e0R+FLHzm45J16UqbnEnIvQBfTlrw8N0kPh+dxmuXgFHspl/izXaNgpBmB6d6J1bX
         pAnKzb/OH+rQWLG3Sp+zZyEDRpw1U0tPVYMdYOnPXRXKU6jRkr9s/ZAYpTEEEVrxAkHB
         RyjQ==
X-Gm-Message-State: AOAM531/oLn7Q8hxUhdycRaoAvi1AGb3v8cRA+G9jofORnIMXHrmAhpP
        ed2dwMm9QMfte4C0MKzfeu866mpnzOk=
X-Google-Smtp-Source: ABdhPJygxDgRt74PCdJJij5RogUKPLcuIw0z/StVtyRqJWceiJNu6dkjOhX6wGwn/NjDGESpRq1hNQ==
X-Received: by 2002:adf:de11:: with SMTP id b17mr14425467wrm.82.1601222731885;
        Sun, 27 Sep 2020 09:05:31 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id n4sm5677659wmc.48.2020.09.27.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 09:05:31 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: devfreq: Document L2 Krait CPU Cache devfreq driver
Date:   Sun, 27 Sep 2020 18:05:13 +0200
Message-Id: <20200927160515.6480-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200927160515.6480-1-ansuelsmth@gmail.com>
References: <20200927160515.6480-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document dedicated L2 Krait CPU Cache devfreq scaling driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/devfreq/krait-cache-devfreq.yaml | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml

diff --git a/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml b/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml
new file mode 100644
index 000000000000..099ed978e022
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/krait-cache-devfreq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DEVFREQ driver for Krait L2 Cpu Cache Frequency Scaling
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  This Scale the Krait CPU L2 Cache Frequency and optionally voltage
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
+    description: Same voltage tolerance of the Krait CPU
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
+
+examples:
+  - |
+    qcom-krait-cache {
+      compatible = "qcom,krait-cache";
+      clocks = <&kraitcc 4>;
+      clock-names = "l2";
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

