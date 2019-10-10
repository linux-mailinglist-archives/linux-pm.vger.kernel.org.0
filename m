Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976CBD281A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfJJLkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43213 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfJJLkK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so4112227lfl.10
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jyY5hfR8/N8coo7i/Rw81G3nXo/cAyXblG5DM904HwE=;
        b=OgHOnIF/JT9aqU5ULYziikH3VIpbyfjLcYtZ62ZAGion5jENQDB43lu6J4WKcJu6KY
         52BLa6tvDhyxmjUbdlEIBfL4xtgznU7Qql5Yu5h35386cUJn2GYFKaqo4kJ64ogBJKiY
         POAOhEUixlR3um6FnqjifcyURYypxa3kqWLGjwyvOmRq8pKZNrIDz/50xhcgjnz8vVl5
         mPj5/Y37vX4kKohxCKn5yzdcQlwykwhiySJ9g1Pl/HNVXTDyRpvJqTWPMhlz13rm95J8
         zOwzOXLKnERt4j5NlWJg089O+KMqcioLvUndOe5GvbFVL/G/OyZ2hlMuG+PeFN64PMOo
         zqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jyY5hfR8/N8coo7i/Rw81G3nXo/cAyXblG5DM904HwE=;
        b=A/lAhOAl4hy25i7g05/8rtUpYnRMxYRN4eU+41H2TyuMz/KzTUrSIWwiywKh4HNu8r
         P7orHCUEaOIWC8J7KBZRqxGs8vcOEPpV6fmk5XQfzGeDS8hloa8Ugk7/pRyL/gDVmVkK
         PQ4vgutOpX0KjX145k+SGUc2wsL/af6IIouNAoiqrV0CKJDSY35GN7/t2UfqbpeMk6p5
         1R76ziVwcfV1hHUe0ecPC+bOGBcvezYvw+DM++mC+aJqlJPjHPt7wsc0jckxerTKmWFF
         oictUdQeBFLQJN0BfHwTZqDQHaWlBXcM7KcO3eB5vT9M9FBi9DQHGA+OsUqUmOqWxuRn
         mLvQ==
X-Gm-Message-State: APjAAAVn1E08MKnjKhmX/knJCi5xgn/vP+uDHNiUgqN7i7Mc1heXeCrB
        30RHH8m1TWcJJaR0eRuCfrZt+Q==
X-Google-Smtp-Source: APXvYqwVz/veomsjupLKt3xVJOp9HD2kp91pfcT6HzEDeMCrvfq1+l+xdbKIzxGRgkRxI/FcE66Vpw==
X-Received: by 2002:a19:ca56:: with SMTP id h22mr5690879lfj.192.1570707608097;
        Thu, 10 Oct 2019 04:40:08 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 02/13] dt: psci: Update DT bindings to support hierarchical PSCI states
Date:   Thu, 10 Oct 2019 13:39:26 +0200
Message-Id: <20191010113937.15962-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update PSCI DT bindings to allow to represent idle states for CPUs and the
CPU topology, by using a hierarchical layout. Primarily this is done by
re-using the existing power domain description [1] and the domain idle
state description [2].

Let's also take the opportunity to update the examples to clarify the
difference between the currently supported flattened layout vs the new
hierarchical layout.

[1] Documentation/devicetree/bindings/power/power_domain.txt
[2] Documentation/devicetree/bindings/power/domain-idle-state.txt

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/arm/psci.yaml         | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 7abdf58b335e..360579bfa591 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -160,4 +160,157 @@ examples:
       cpu_on = <0x95c10002>;
       cpu_off = <0x95c10001>;
     };
+
+  - |+
+
+    // Case 4: PSCI v1.0, PSCI v0.2, PSCI v0.1.
+
+    /*
+     * ARM systems can have multiple cores, sometimes in an hierarchical
+     * arrangement. This often, but not always, maps directly to the processor
+     * power topology of the system. Individual nodes in a topology have their
+     * own specific power states and can be better represented hierarchically.
+     *
+     * For these cases, the definitions of the idle states for the CPUs and the
+     * CPU topology, must conform to the power domain description [3]. The idle
+     * states themselves must conform to the domain idle state description [4]
+     * and must specify the arm,psci-suspend-param property.
+     *
+     * This allows two options to represent CPUs and CPU idle states. By using
+     * a flattened model as given in the first example below and by using a
+     * hierarchical model as given in the second example.
+     *
+     * It should also be noted that, in PSCI firmware v1.0 the OS-Initiated
+     * (OSI) CPU suspend mode is introduced. Using the hierarchical
+     * representation helps to implement support for OSI mode and OS
+     * implementations may choose to mandate it.
+     *
+     * [3] Kernel documentation - Power domain description
+     *   Documentation/devicetree/bindings/power/power_domain.txt
+     * [4] Kernel documentation - Domain idle state description
+     *   Documentation/devicetree/bindings/power/domain-idle-state.txt
+     */
+
+     // The flattened model
+     cpus {
+
+       CPU0: cpu@0 {
+         device_type = "cpu";
+         compatible = "arm,cortex-a53", "arm,armv8";
+         reg = <0x0>;
+         enable-method = "psci";
+         cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+       };
+
+       CPU1: cpu@1 {
+         device_type = "cpu";
+         compatible = "arm,cortex-a57", "arm,armv8";
+         reg = <0x100>;
+         enable-method = "psci";
+         cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+       };
+
+       idle-states {
+
+         CPU_PWRDN: cpu-power-down {
+           compatible = "arm,idle-state";
+           arm,psci-suspend-param = <0x0000001>;
+           entry-latency-us = <10>;
+           exit-latency-us = <10>;
+           min-residency-us = <100>;
+         };
+
+         CLUSTER_RET: cluster-retention {
+           compatible = "arm,idle-state";
+           arm,psci-suspend-param = <0x1000011>;
+           entry-latency-us = <500>;
+           exit-latency-us = <500>;
+           min-residency-us = <2000>;
+         };
+
+         CLUSTER_PWRDN: cluster-power-down {
+           compatible = "arm,idle-state";
+           arm,psci-suspend-param = <0x1000031>;
+           entry-latency-us = <2000>;
+           exit-latency-us = <2000>;
+           min-residency-us = <6000>;
+         };
+       };
+     };
+
+     psci {
+       compatible = "arm,psci-1.0";
+       method = "smc";
+     };
+
+     // The hierarchical model
+     cpus {
+
+       CPU0: cpu@0 {
+         device_type = "cpu";
+         compatible = "arm,cortex-a53", "arm,armv8";
+         reg = <0x0>;
+         enable-method = "psci";
+         power-domains = <&CPU_PD0>;
+         power-domain-names = "psci";
+       };
+
+       CPU1: cpu@1 {
+         device_type = "cpu";
+         compatible = "arm,cortex-a57", "arm,armv8";
+         reg = <0x100>;
+         enable-method = "psci";
+         power-domains = <&CPU_PD1>;
+         power-domain-names = "psci";
+       };
+
+       idle-states {
+
+         CPU_PWRDN: cpu-power-down {
+           compatible = "arm,idle-state";
+           arm,psci-suspend-param = <0x0000001>;
+           entry-latency-us = <10>;
+           exit-latency-us = <10>;
+           min-residency-us = <100>;
+         };
+
+         CLUSTER_RET: cluster-retention {
+           compatible = "domain-idle-state";
+           arm,psci-suspend-param = <0x1000011>;
+           entry-latency-us = <500>;
+           exit-latency-us = <500>;
+           min-residency-us = <2000>;
+         };
+
+         CLUSTER_PWRDN: cluster-power-down {
+           compatible = "domain-idle-state";
+           arm,psci-suspend-param = <0x1000031>;
+           entry-latency-us = <2000>;
+           exit-latency-us = <2000>;
+           min-residency-us = <6000>;
+         };
+       };
+     };
+
+     psci {
+       compatible = "arm,psci-1.0";
+       method = "smc";
+
+       CPU_PD0: cpu-pd0 {
+         #power-domain-cells = <0>;
+         domain-idle-states = <&CPU_PWRDN>;
+         power-domains = <&CLUSTER_PD>;
+       };
+
+       CPU_PD1: cpu-pd1 {
+         #power-domain-cells = <0>;
+         domain-idle-states =  <&CPU_PWRDN>;
+         power-domains = <&CLUSTER_PD>;
+       };
+
+       CLUSTER_PD: cluster-pd {
+         #power-domain-cells = <0>;
+         domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+       };
+     };
 ...
-- 
2.17.1

