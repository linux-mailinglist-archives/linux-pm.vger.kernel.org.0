Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A9396B0A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhFAC0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFAC0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:26:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EAC06174A;
        Mon, 31 May 2021 19:24:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q1so19353495lfo.3;
        Mon, 31 May 2021 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7jwgPjlusYAYMbjtHrJjh1BfFW4WaS2/S+5bph4b30=;
        b=WB3fT78tlfBxMi/icd8ZxyBWr7m3UB3XhMN8EGxpEsKmRmZP9OrMMi+Z9VN2I/CIdg
         X1YE/fVw50WopDQyX6CQQYyoz3JZSISKgANFOJI2Jr4kaPsu9pVfYJkwdheh6DS5oHAW
         cxtp1cmGvRkRY/1B1VIh6PDqObmyoIV8d7IhwDlYeVAwnKY/+S6uxGIiRJTF6HRSqScn
         wy3ho4VCW3Jg3/sTgbCF9/aZu+crzOHP5cZUR8kMHhquvNAYkFOsrW2dVNTvGRhEcwfM
         VsddkiJ26BeV2FPvF1qF7MgAS0u+O0YEjpsI5eTWpLGSpOVcpwieJtOZ0msrYaZSYeCn
         9Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7jwgPjlusYAYMbjtHrJjh1BfFW4WaS2/S+5bph4b30=;
        b=hDM7kfSx9GcUFsCd8N/tENM8MYi/CY4ysvMDFWWmYDYX5IFW0dK+tIzCdQKAZRyV0G
         hl/68WvY3nPK2HMr3DhsscHH4mPmcPJEzmYW1Mec3NfgWQvQJadTNgM9jqCh63AQ1ODy
         ZuNo05FznrRZCnI2r56qZsOEtRLaGnA/HPmHAUTNbhKkIwkTYdeIM+8IT0mozyl2myew
         yy4nu0vEJljhJ/KNCV3zrdV7eCdSdhLlHaAWb4+Q4BK0Fqvw0A7FRVmqynCoH/wsV91v
         q0S3gJ+TP3ypj3IOiZg30/2xyM30+ETNz6vGft9g8ppmeQNAfD0oBHnAxFapYhlqlo4q
         Ogfw==
X-Gm-Message-State: AOAM5310ml5EtRKCXIg9kj7heG6xdzxDdBsO9g++g+ftvwdANGQCbW6M
        Omyib3EzqXtEFf5o5tYXIUY=
X-Google-Smtp-Source: ABdhPJzRDEpnQuIL1pgmFEZRRKb2hCKhhFEPx+xH6zJZjy9+F+//nouaZdu1I70dMEldSrXGWEXTUA==
X-Received: by 2002:a05:6512:3d0f:: with SMTP id d15mr16809278lfv.639.1622514256364;
        Mon, 31 May 2021 19:24:16 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id g34sm1524207lfv.59.2021.05.31.19.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:24:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: devfreq: tegra30-actmon: Convert to schema
Date:   Tue,  1 Jun 2021 05:23:18 +0300
Message-Id: <20210601022319.17938-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601022319.17938-1-digetx@gmail.com>
References: <20210601022319.17938-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert NVIDIA Tegra ACTMON binding to schema.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
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
index 000000000000..ba938eed28ee
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
+      memory clients, see MEMORY CONTROLLER and ACTIVITY MONITOR sections.
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

