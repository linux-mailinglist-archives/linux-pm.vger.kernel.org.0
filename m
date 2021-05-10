Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0B93798DB
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhEJVNA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhEJVM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:12:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0941C06175F;
        Mon, 10 May 2021 14:11:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x19so25497488lfa.2;
        Mon, 10 May 2021 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5E7wNWlOWphmuJH6nS2gu83oyovtKHqDz0VVt3zqGMw=;
        b=SeHA9v/YPp0WOO3IrKhuafOBQsS/P2X228FEY/aW0zZOOXLP6q5x6/1GGNOoG41OrO
         asCLdZ03Qx33Ypu6nSQpaILCvrQa5yNuNEqr8Aj8nqgMtgQvglMZLO9aIlMUkdWfom+T
         fcsB/g/ueWo1zHDPa3n33dshSBn33KSa1WZWHqlXYC3wgtiL6IaUeTlHSVmjk/dySHl8
         s0w4j56HN+TUfBOuWwfhMgnfFsu/sWW/36EDIQ9vM+1Fzsc+ttNNw9EK8h3Pe8o/BKC5
         wOiGkueUt1WoPiNXMXaoSCS/AFOi7GlhaSjWen5tiAjNNlyGjvSk8DdhQRb7TzVkgd46
         VTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5E7wNWlOWphmuJH6nS2gu83oyovtKHqDz0VVt3zqGMw=;
        b=Kln2UOt3I5SO7axLAmHl7NSE0K8ydQefDsZna3CDN31G6KL7caI3dX1PDGOjDjsUgp
         tDSLbHtgpAk/MXyH3+X03cSxBZqdgxNADjse4EaJi5HtU9UHuCtR86QvtBJ+CDXmFRrN
         3J+PdzJQi6lA+6wzuQaobePPYmC3sGq1cDvgVpUN/wN61QNBOC2cdecR1oKuS/e4W3hz
         BV1mp3UnS0q7iqvbcun+4rlvegYdcK7VgyjDcuDrM/qiAW30MazmVNV3/fagP+GSnIKv
         8t0F/zQKz9Mixiyjq92HZykWDOTMKdrtFWNbOBX/fj3fsHwexaLfpdQjXCP3aOk2SpcB
         N0LQ==
X-Gm-Message-State: AOAM5335afJuJEiY0FsMTVc1aEFzbs3jkuHZPYJricAc0L/GSD5stJhV
        mFvMqjTUKqgw4s7hRuMAMrY=
X-Google-Smtp-Source: ABdhPJyH26fu+tF4iwnXeUUKuISInvFnlzMHQehDL8eqjLzR0oOjrsO8rJGtH30qfjwUH+Dm7BvT1Q==
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr17715702lfv.574.1620681111199;
        Mon, 10 May 2021 14:11:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id x4sm2365339lfa.173.2021.05.10.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:11:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 3/7] dt-bindings: devfreq: tegra30-actmon: Convert to schema
Date:   Tue, 11 May 2021 00:10:04 +0300
Message-Id: <20210510211008.30300-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510211008.30300-1-digetx@gmail.com>
References: <20210510211008.30300-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert NVIDIA Tegra ACTMON binding to schema.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 ---------
 .../devfreq/nvidia,tegra30-actmon.yaml        | 121 ++++++++++++++++++
 2 files changed, 121 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
deleted file mode 100644
index 897eedfa2bc8..000000000000
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-NVIDIA Tegra Activity Monitor
-
-The activity monitor block collects statistics about the behaviour of other
-components in the system. This information can be used to derive the rate at
-which the external memory needs to be clocked in order to serve all requests
-from the monitored clients.
-
-Required properties:
-- compatible: should be "nvidia,tegra<chip>-actmon"
-- reg: offset and length of the register set for the device
-- interrupts: standard interrupt property
-- clocks: Must contain a phandle and clock specifier pair for each entry in
-clock-names. See ../../clock/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - actmon
-  - emc
-- resets: Must contain an entry for each entry in reset-names. See
-../../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - actmon
-- operating-points-v2: See ../bindings/opp/opp.txt for details.
-- interconnects: Should contain entries for memory clients sitting on
-                 MC->EMC memory interconnect path.
-- interconnect-names: Should include name of the interconnect path for each
-                      interconnect entry. Consult TRM documentation for
-                      information about available memory clients, see MEMORY
-                      CONTROLLER section.
-
-For each opp entry in 'operating-points-v2' table:
-- opp-supported-hw: bitfield indicating SoC speedo ID mask
-- opp-peak-kBps: peak bandwidth of the memory channel
-
-Example:
-	dfs_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp@12750000 {
-			opp-hz = /bits/ 64 <12750000>;
-			opp-supported-hw = <0x000F>;
-			opp-peak-kBps = <51000>;
-		};
-		...
-	};
-
-	actmon@6000c800 {
-		compatible = "nvidia,tegra124-actmon";
-		reg = <0x0 0x6000c800 0x0 0x400>;
-		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car TEGRA124_CLK_ACTMON>,
-			 <&tegra_car TEGRA124_CLK_EMC>;
-		clock-names = "actmon", "emc";
-		resets = <&tegra_car 119>;
-		reset-names = "actmon";
-		operating-points-v2 = <&dfs_opp_table>;
-		interconnects = <&mc TEGRA124_MC_MPCORER &emc>;
-		interconnect-names = "cpu";
-	};
diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
new file mode 100644
index 000000000000..2a940d5d7ab4
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/nvidia,tegra30-actmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra30 Activity Monitor
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  The activity monitor block collects statistics about the behaviour of other
+  components in the system. This information can be used to derive the rate at
+  which the external memory needs to be clocked in order to serve all requests
+  from the monitored clients.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra30-actmon
+      - nvidia,tegra114-actmon
+      - nvidia,tegra124-actmon
+      - nvidia,tegra210-actmon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: actmon
+      - const: emc
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: actmon
+
+  interrupts:
+    maxItems: 1
+
+  interconnects:
+    minItems: 1
+    maxItems: 12
+
+  interconnect-names:
+    minItems: 1
+    maxItems: 12
+    description:
+      Should include name of the interconnect path for each interconnect
+      entry. Consult TRM documentation for information about available
+      memory clients, see ACTIVITY MONITOR section.
+
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property, which
+      is a bitfield indicating SoC speedo ID mask.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - interconnects
+  - interconnect-names
+  - operating-points-v2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/memory/tegra30-mc.h>
+
+    mc: memory-controller@7000f000 {
+        compatible = "nvidia,tegra30-mc";
+        reg = <0x7000f000 0x400>;
+        clocks = <&clk 32>;
+        clock-names = "mc";
+
+        interrupts = <0 77 4>;
+
+        #iommu-cells = <1>;
+        #reset-cells = <1>;
+        #interconnect-cells = <1>;
+    };
+
+    emc: external-memory-controller@7000f400 {
+        compatible = "nvidia,tegra30-emc";
+        reg = <0x7000f400 0x400>;
+        interrupts = <0 78 4>;
+        clocks = <&clk 57>;
+
+        nvidia,memory-controller = <&mc>;
+        operating-points-v2 = <&dvfs_opp_table>;
+        power-domains = <&domain>;
+
+        #interconnect-cells = <0>;
+    };
+
+    actmon@6000c800 {
+        compatible = "nvidia,tegra30-actmon";
+        reg = <0x6000c800 0x400>;
+        interrupts = <0 45 4>;
+        clocks = <&clk 119>, <&clk 57>;
+        clock-names = "actmon", "emc";
+        resets = <&rst 119>;
+        reset-names = "actmon";
+        operating-points-v2 = <&dvfs_opp_table>;
+        interconnects = <&mc TEGRA30_MC_MPCORER &emc>;
+        interconnect-names = "cpu-read";
+    };
-- 
2.30.2

