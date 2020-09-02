Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62A925A7EF
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBIoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 04:44:39 -0400
Received: from foss.arm.com ([217.140.110.172]:33398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBIoj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 04:44:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9A2731B;
        Wed,  2 Sep 2020 01:44:37 -0700 (PDT)
Received: from ubuntu.arm.com (unknown [10.57.6.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 525FD3F68F;
        Wed,  2 Sep 2020 01:44:36 -0700 (PDT)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        robh@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     morten.rasmussen@arm.com
Subject: [PATCH] dt-bindings: arm: Add devicetree binding for cpu-performance-dependencies
Date:   Wed,  2 Sep 2020 09:45:16 +0100
Message-Id: <20200902084516.26584-1-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, there is an assumption that the performance domains as provided
by the SCMI protocol should be mirroring the exact implementation in
hardware, for example, the clock domains, which are a typical type of
performance domains.

By design, an SCMI performance domain defines the granularity of
performance controls, it does not describe any underlying hardware
dependencies (although they may match in many cases).

As a consequence, in platforms where hardware may have the ability to
control cpu performance at different granularity and choose to describe
fine-grained performance control through SCMI performance domains, there
is currently no way for OSPM to discover the actual cpu hardware
dependencies. Inevitably, software components that rely on this missing
description will cease to work.

Thus, there is a need for a new description of hardware dependencies where
the performance level is coordinated by hardware (or firmware) since these
dependency domains might be larger than the SCMI performance domains.

This new optional binding will provide visibility to OSPM on any hardware
or firmware coordination of performance requests and enable more
accurate assumptions about performance and performance side-effects of
requesting performance level changers. This is essential information for
OSPM thermal and energy management frameworks.

There are two main reasons to support this new addition:

1) Per-cpu control & SCMI performance domains

Same as explained above. Some platforms would like to make aggregation
decisions in firmware and want to describe themselves as having per-cpu
control. In order to continue to make sane decisions in the OSPM layer,
we need to know about the underlying connections.

With this optional binding, we provide performance dependencies
information to OSPM for sets of CPUs while the h/w coordinates the
performance level for each cpu.

2) ACPI

With respect to performance, ACPI describes two main types of coordination
that may take place in system when logical processors are required to
transition to a different power/performance state. These two types are
software coordination (SW) and hardware coordination (HW). In the first
one, OSPM is in charge of handling such transitions while preserving the
integrity of the entire system. In the latter case, the h/w is responsible
for ensuring correct operations.

In the HW coordination, OSPM can control each processor as if they were all
independent each other. However, platforms can use ACPI defined interfaces
to group CPUs to create so called "dependency domain". Such interface is
the _PSD method. Users in kernel that need to know dependencies among
cores, can retrieve such information via _PSD [1].

If the same system needs to work with dt + SCMI, we will have all the
controls, but we are missing the information performance level coordination
in hardware/firmware.
This new dt binding provides the missing bits.

[1]ACPI Specification, version 6.3 - 8.3 Power, Performance, and Throttling
State Dependencies

Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 .../bindings/arm/cpu-perf-dependencies.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml

diff --git a/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml b/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml
new file mode 100644
index 000000000000..3b8cf7e29982
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpu-perf-dependencies.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CPU Performance Dependencies
+
+maintainers:
+  - Nicola Mazzucato <nicola.mazzucato@arm.com>
+
+description: |+
+  This optional node provides information to OSPM of cpu performance
+  dependencies.
+  Each list represents a set of CPUs which have performance level
+  dependencies and can assumed to be roughly at the same performance
+  level coordinated by hardware and/or firmware.
+  Example: Describing CPUs in the same clock domain.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - arm,cpu-perf-dependencies
+
+  cpu-perf-affinity:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Specifies a list of phandles to CPU nodes corresponding to a set of CPUs
+      which have performance affinity.
+
+examples:
+  - |
+    cpu-performance-dependencies {
+        compatible = "arm,cpu-perf-dependencies";
+        cpu-perf-domain0 {
+            cpu-perf-affinity = <&CPU0>, <&CPU1>, <&CPU2>, <&CPU3>;
+        }
+        cpu-perf-domain1 {
+            cpu-perf-affinity = <&CPU4>, <&CPU5>, <&CPU6>;
+        }
+        cpu-perf-domain2 {
+            cpu-perf-affinity = <&CPU7>;
+        }
+    };
-- 
2.27.0

