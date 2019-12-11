Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5334F11B3AD
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfLKPoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39944 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388755AbfLKPn4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:43:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id s22so24590312ljs.7
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HmkM4qIacfaV48Xt+NOUMP5KlBEshpTFQ8XvQ2DERIc=;
        b=dJqCCecW0FQNgGZ4Qzo0jBiKEio116X9p+adO21H+FiLr5EANwNr3DDcrl9BQaz0jr
         c2rMZqWlMxpsC+nh38hMz+9zqr3zCSJYEG/Kvf9mmmqOnD8zu0H32ufX5nYFKgQWu7Lj
         3i3MDOYMKod7hHTCTgHJWWYF3TgBatF+2rZs6VwFTaAgvUFNW2c4S4YwA7Ka3e7KaAU+
         cQkz8SO/z02kjO0nxMDVLOwAb47E6Hufr4hcy30ALwMwTwzvBv8rvIHMFDnj/FE11Olo
         Qp8disoOGF6hIsChO4W0qZ1sPfxjU161Q7YoBjgT3QsSO5dWLZViQVr+vnfPtAB9fW3z
         Lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HmkM4qIacfaV48Xt+NOUMP5KlBEshpTFQ8XvQ2DERIc=;
        b=dNM9Xo1/DwxyFu8HbUctbA1EtdYHSaF7/X/pEwpQHbp7HAGYy5mTAnhzh6O2e/i/I4
         wwrvqJGiO9/RyaB4ihmIzyXQ7BSZrwVgxzUNYcl5XOVSxP8RARVmuBOObSg9RcCxfuhz
         HJpyngLtwkb4CcVBoRBJ8je9bp2bzLiaOHHM9EZitx52HIt/AoOXSf7eYsRtCfprx7AF
         h6gJowGd3quamOrW4XBehfI/vVYWPBTXeXlQ1CabIJssa8AsBt4ZiPUb/37OO29IKOM4
         SYvDi1TEvaUxPLsncXyvmeymnHJhtb8PryyV07C0tYefXF1Lo+DQkPu9G8GSc9YqdUiv
         lv8A==
X-Gm-Message-State: APjAAAX7AU5HUGZyl9kZzVx+dLMWzbrHwfBYu+Bb+fMwJzYVG9qzkhu/
        +XOY0fqc1n0oKCMziKhSyNuJxw==
X-Google-Smtp-Source: APXvYqyntQZDl1P1F2PabGBwvZXox+UB8aEO9XTO7zGZ08kzupQ/W6UYRYYzINIUX35ngDKG5nGlsw==
X-Received: by 2002:a2e:a163:: with SMTP id u3mr2327694ljl.13.1576079034051;
        Wed, 11 Dec 2019 07:43:54 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:43:53 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 02/14] dt: psci: Update DT bindings to support hierarchical PSCI states
Date:   Wed, 11 Dec 2019 16:43:31 +0100
Message-Id: <20191211154343.29765-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update PSCI DT bindings to allow to represent idle states for CPUs and the
CPU topology, by using a hierarchical layout. Primarily this is done by
re-using the existing DT bindings for PM domains [1] and for PM domain idle
states [2].

Let's also add an example into the document for the PSCI DT bindings, to
clearly show the new hierarchical based layout. The currently supported
flattened layout, is already described in the ARM idle states bindings [3],
so let's leave that as is.

[1] Documentation/devicetree/bindings/power/power_domain.txt
[2] Documentation/devicetree/bindings/power/domain-idle-state.txt
[3] Documentation/devicetree/bindings/arm/idle-states.txt

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- None.

---
 .../devicetree/bindings/arm/cpus.yaml         |  15 +++
 .../devicetree/bindings/arm/psci.yaml         | 104 ++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index c23c24ff7575..7a9c3ce2dbef 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -242,6 +242,21 @@ properties:
 
       where voltage is in V, frequency is in MHz.
 
+  power-domains:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description:
+      List of phandles and PM domain specifiers, as defined by bindings of the
+      PM domain provider (see also ../power_domain.txt).
+
+  power-domain-names:
+    $ref: '/schemas/types.yaml#/definitions/string-array'
+    description:
+      A list of power domain name strings sorted in the same order as the
+      power-domains property.
+
+      For PSCI based platforms, the name corresponding to the index of the PSCI
+      PM domain provider, must be "psci".
+
   qcom,saw:
     $ref: '/schemas/types.yaml#/definitions/phandle'
     description: |
diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 7abdf58b335e..8ef85420b2ab 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -102,6 +102,34 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/arm/idle-states.txt
 
+  "#power-domain-cells":
+    description:
+      The number of cells in a PM domain specifier as per binding in [3].
+      Must be 0 as to represent a single PM domain.
+
+      ARM systems can have multiple cores, sometimes in an hierarchical
+      arrangement. This often, but not always, maps directly to the processor
+      power topology of the system. Individual nodes in a topology have their
+      own specific power states and can be better represented hierarchically.
+
+      For these cases, the definitions of the idle states for the CPUs and the
+      CPU topology, must conform to the binding in [3]. The idle states
+      themselves must conform to the binding in [4] and must specify the
+      arm,psci-suspend-param property.
+
+      It should also be noted that, in PSCI firmware v1.0 the OS-Initiated
+      (OSI) CPU suspend mode is introduced. Using a hierarchical representation
+      helps to implement support for OSI mode and OS implementations may choose
+      to mandate it.
+
+      [3] Documentation/devicetree/bindings/power/power_domain.txt
+      [4] Documentation/devicetree/bindings/power/domain-idle-state.txt
+
+  power-domains:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description:
+      List of phandles and PM domain specifiers, as defined by bindings of the
+      PM domain provider.
 
 required:
   - compatible
@@ -160,4 +188,80 @@ examples:
       cpu_on = <0x95c10002>;
       cpu_off = <0x95c10001>;
     };
+
+  - |+
+
+    // Case 4: CPUs and CPU idle states described using the hierarchical model.
+
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <1>;
+
+      CPU0: cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a53", "arm,armv8";
+        reg = <0x0>;
+        enable-method = "psci";
+        power-domains = <&CPU_PD0>;
+        power-domain-names = "psci";
+      };
+
+      CPU1: cpu@1 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57", "arm,armv8";
+        reg = <0x100>;
+        enable-method = "psci";
+        power-domains = <&CPU_PD1>;
+        power-domain-names = "psci";
+      };
+
+      idle-states {
+
+        CPU_PWRDN: cpu-power-down {
+          compatible = "arm,idle-state";
+          arm,psci-suspend-param = <0x0000001>;
+          entry-latency-us = <10>;
+          exit-latency-us = <10>;
+          min-residency-us = <100>;
+        };
+
+        CLUSTER_RET: cluster-retention {
+          compatible = "domain-idle-state";
+          arm,psci-suspend-param = <0x1000011>;
+          entry-latency-us = <500>;
+          exit-latency-us = <500>;
+          min-residency-us = <2000>;
+        };
+
+        CLUSTER_PWRDN: cluster-power-down {
+          compatible = "domain-idle-state";
+          arm,psci-suspend-param = <0x1000031>;
+          entry-latency-us = <2000>;
+          exit-latency-us = <2000>;
+          min-residency-us = <6000>;
+        };
+      };
+    };
+
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      CPU_PD0: cpu-pd0 {
+        #power-domain-cells = <0>;
+        domain-idle-states = <&CPU_PWRDN>;
+        power-domains = <&CLUSTER_PD>;
+      };
+
+      CPU_PD1: cpu-pd1 {
+        #power-domain-cells = <0>;
+        domain-idle-states =  <&CPU_PWRDN>;
+        power-domains = <&CLUSTER_PD>;
+      };
+
+      CLUSTER_PD: cluster-pd {
+        #power-domain-cells = <0>;
+        domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+      };
+    };
 ...
-- 
2.17.1

