Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923B923CCA7
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgHEQ4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 12:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgHEQyb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 12:54:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C1C08E834;
        Wed,  5 Aug 2020 06:12:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so4373567wmd.1;
        Wed, 05 Aug 2020 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9JUGt8Pb9MDGuBsLIt3kVKcTw+cuX4wnQpyN3p61KQ=;
        b=pbk1cNPRF/GvqfGkOr+BRCbGcJN5u/R67NUNZc5JeQP6+Ucu93yX5HNmhmIGcpnbDg
         b/Vb5CNZU1Ai7dd2ZgXfZe5Eg5kzp4G+pIcJFMIjbRDvqndYePvwy8BiVcZGC3tCtAo9
         1ONUxrvdZxxvAzMHnCb/p9eoxfg87gYN5yhFKc8hJSTQBNaQq5Hj19/HA74yll88Arrt
         NjKOdn4OI7CxOZk6HgB0D6UUc5eiGbxAcuj0VhtfZavaaCzB0miFqJiT9b9E7RHQUSRB
         5sFbWUnFxYCQUFI/90+Y6qZ37czHQwsEmr6FzhuPpkC64Q7HbsWa0gq0WF6xe/ubtMgM
         cL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9JUGt8Pb9MDGuBsLIt3kVKcTw+cuX4wnQpyN3p61KQ=;
        b=sxZNa+apP25vppczNLXjRDKJiB1s22yXdKGBh1woBI82+Qg/MohcBMvxgq7jTB01rO
         BU0qWS21oOjjFVAUiu7fbvc/L034wBHFJYkGEuR3hZvhQwBSyjrzXiRMmsw7CwtIogAu
         Lmvdvx2VS6Tlz5ZDxC5seIKc9G0TOivfwdIOm5uap+zxdqRe/Zy1NdYzhWB5bUsQbuDL
         WDH2PaetIsYxUKB01CNDiN7v0iZlE25E0BlIAzzW4q7q1ckdC3FM1KbwY44y5mjPc0SK
         aCeKHY3KDhOuCKb4U7ygOd22iexkjHUUfqvt2i0afBfIPgr9c/COfmTOS393e7TiiTJZ
         60eA==
X-Gm-Message-State: AOAM530arzSf2ncFR1sWcJXYBcSpEd6eQt0kYz3qxnApG5Orkot2vF9c
        FfQhO/j4P1SYhpSwg5zdbhA=
X-Google-Smtp-Source: ABdhPJx7QnQpLkIIv5E0GyPade/7mWzzITIagloPzo8qbKK9XtJXsRfCQT2mdy/5AeRoPFSS4o0yFA==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr3330653wmb.67.1596633137287;
        Wed, 05 Aug 2020 06:12:17 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-251-1-48.retail.telecomitalia.it. [95.251.1.48])
        by smtp.googlemail.com with ESMTPSA id j11sm2669756wrq.69.2020.08.05.06.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:12:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] dt-bindings: cpufreq: Document Krait CPU Cache scaling
Date:   Wed,  5 Aug 2020 15:11:59 +0200
Message-Id: <20200805131200.3234-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805131200.3234-1-ansuelsmth@gmail.com>
References: <20200805131200.3234-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document dedicated Krait CPU Cache Scaling driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/cpufreq/krait-cache-scale.yaml   | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml b/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
new file mode 100644
index 000000000000..190276ba035a
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
@@ -0,0 +1,89 @@
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

