Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D033F2E80
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbhHTPF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 11:05:26 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60618
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240956AbhHTPFZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 11:05:25 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1D4AD40768
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629471887;
        bh=vvpwAgismwRaE/SiEuUUZLnT/brd2eZE+zk8Fwj+Pj4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dlEPyKTKiPhYago59yzfthYlyVg23YIhy5eyJnwABUCywXynT4vykVut78vIu5Z+m
         tcjf6+aWSA8ECoPUCFDizcfhJW2Me7IvzVKNaPMPa2+0LH/hW34h1cxw4mDsg9x1a5
         7ZUICRKogG0tfU1/XBKtw4Re/ob3BtOBJn9WMGo0Twkx2cc8wNPzVhgQkeXWOreI+2
         IdP84xpf87WPn5QQj6TQWjIryuSNWDQGJnhyVQTQOtL4HuZ773K4YVVkGETmAZgevd
         mUFjXcR41UbVmjTQpLQ9f1304GG0IAB48OoaD41p/rgOC50DnlQfZwBX0/queBHM+J
         BbGHkA2dvUOlA==
Received: by mail-ed1-f71.google.com with SMTP id dd25-20020a056402313900b003bed8169691so4721834edb.7
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 08:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvpwAgismwRaE/SiEuUUZLnT/brd2eZE+zk8Fwj+Pj4=;
        b=jUQMcsvvD+BRFPdpcrvJ4Ae9vyMXMjgncv63muARU7Mzwu1nXlgavXmh9jy4KOOqjb
         ASVZzH/bIdCLovnH1mocmD7Y6cuKXaKWikUOC4jwCyjSXPkMxhxXt5WO0IVHTuvYcT/2
         +878Yz/7jcPQTyk7+I/iHTkUh5o3NFGowWlIH1DNxPrk7dDEzQGE9vyWdbLdsj7vadjg
         R68gqTMpUd6uqtnuIlgFiResxx6XQZpzIC0Fa+D3mRpuS/rZWvQ7wFfYASJctsrJrpLp
         cjyi9DTRH3mc+TG6iEc8n62NEDrk4jyK/DuiSAAuPR1RJ7YoOghWN4JAp4PIJhywGu4R
         nR9Q==
X-Gm-Message-State: AOAM530ShlfG1OYvC3b6LjlFQRLFCJvPRIvONZRQFEdQboIrE7ImAijN
        9SnwWULk0nzCAcgaNmOJIpmPf3OuS5S2yuJRB8vuyhJspxSlLEgxKGBvHcgSp8Jt7gbESAtdQ/g
        icM+XeE2m7YvE2bULTDF8qTQiEZoruC8IKD+8
X-Received: by 2002:aa7:ce96:: with SMTP id y22mr22970018edv.115.1629471886755;
        Fri, 20 Aug 2021 08:04:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweMslfD4TCO2vgV63gyjv/wqCq/cRB2bmiA6C/cYas04zIsYysHR4DRQTCT2Jw6e1EcmsCRA==
X-Received: by 2002:aa7:ce96:: with SMTP id y22mr22969989edv.115.1629471886460;
        Fri, 20 Aug 2021 08:04:46 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id ck17sm3690735edb.88.2021.08.20.08.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:04:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: devfreq: event: convert Samsung Exynos PPMU to dtschema
Date:   Fri, 20 Aug 2021 17:03:51 +0200
Message-Id: <20210820150353.161161-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com>
References: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert Samsung Exynos PPMU bindings to DT schema format using
json-schema.  The example is quite different due to the nature of
dtschema examples parsing (no overriding via-label allowed).

New bindings contain copied description from previous bindings document,
therefore the license is set as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. New patch
---
 .../bindings/devfreq/event/exynos-ppmu.txt    | 169 -----------------
 .../devfreq/event/samsung,exynos-ppmu.yaml    | 174 ++++++++++++++++++
 2 files changed, 174 insertions(+), 169 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
deleted file mode 100644
index fb46b491791c..000000000000
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ /dev/null
@@ -1,169 +0,0 @@
-
-* Samsung Exynos PPMU (Platform Performance Monitoring Unit) device
-
-The Samsung Exynos SoC has PPMU (Platform Performance Monitoring Unit) for
-each IP. PPMU provides the primitive values to get performance data. These
-PPMU events provide information of the SoC's behaviors so that you may
-use to analyze system performance, to make behaviors visible and to count
-usages of each IP (DMC, CPU, RIGHTBUS, LEFTBUS, CAM interface, LCD, G3D, MFC).
-The Exynos PPMU driver uses the devfreq-event class to provide event data
-to various devfreq devices. The devfreq devices would use the event data when
-derterming the current state of each IP.
-
-Required properties for PPMU device:
-- compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
-- reg: physical base address of each PPMU and length of memory mapped region.
-
-Optional properties for PPMU device:
-- clock-names : the name of clock used by the PPMU, "ppmu"
-- clocks : phandles for clock specified in "clock-names" property
-
-Required properties for 'events' child node of PPMU device:
-- event-name : the unique event name among PPMU device
-Optional properties for 'events' child node of PPMU device:
-- event-data-type : Define the type of data which shell be counted
-by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
-all possible type, i.e. count read requests, count write data in bytes,
-etc. This field is optional and when it is missing, the driver code
-will use default data type.
-
-Example1 : PPMUv1 nodes in exynos3250.dtsi are listed below.
-
-		ppmu_dmc0: ppmu_dmc0@106a0000 {
-			compatible = "samsung,exynos-ppmu";
-			reg = <0x106a0000 0x2000>;
-			status = "disabled";
-		};
-
-		ppmu_dmc1: ppmu_dmc1@106b0000 {
-			compatible = "samsung,exynos-ppmu";
-			reg = <0x106b0000 0x2000>;
-			status = "disabled";
-		};
-
-		ppmu_cpu: ppmu_cpu@106c0000 {
-			compatible = "samsung,exynos-ppmu";
-			reg = <0x106c0000 0x2000>;
-			status = "disabled";
-		};
-
-		ppmu_rightbus: ppmu_rightbus@112a0000 {
-			compatible = "samsung,exynos-ppmu";
-			reg = <0x112a0000 0x2000>;
-			clocks = <&cmu CLK_PPMURIGHT>;
-			clock-names = "ppmu";
-			status = "disabled";
-		};
-
-		ppmu_leftbus: ppmu_leftbus0@116a0000 {
-			compatible = "samsung,exynos-ppmu";
-			reg = <0x116a0000 0x2000>;
-			clocks = <&cmu CLK_PPMULEFT>;
-			clock-names = "ppmu";
-			status = "disabled";
-		};
-
-Example2 : Events of each PPMU node in exynos3250-rinato.dts are listed below.
-
-	&ppmu_dmc0 {
-		status = "okay";
-
-		events {
-			ppmu_dmc0_3: ppmu-event3-dmc0 {
-				event-name = "ppmu-event3-dmc0";
-			};
-
-			ppmu_dmc0_2: ppmu-event2-dmc0 {
-				event-name = "ppmu-event2-dmc0";
-			};
-
-			ppmu_dmc0_1: ppmu-event1-dmc0 {
-				event-name = "ppmu-event1-dmc0";
-			};
-
-			ppmu_dmc0_0: ppmu-event0-dmc0 {
-				event-name = "ppmu-event0-dmc0";
-			};
-		};
-	};
-
-	&ppmu_dmc1 {
-		status = "okay";
-
-		events {
-			ppmu_dmc1_3: ppmu-event3-dmc1 {
-				event-name = "ppmu-event3-dmc1";
-			};
-		};
-	};
-
-	&ppmu_leftbus {
-		status = "okay";
-
-		events {
-			ppmu_leftbus_3: ppmu-event3-leftbus {
-				event-name = "ppmu-event3-leftbus";
-			};
-		};
-	};
-
-	&ppmu_rightbus {
-		status = "okay";
-
-		events {
-			ppmu_rightbus_3: ppmu-event3-rightbus {
-				event-name = "ppmu-event3-rightbus";
-			};
-		};
-	};
-
-Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
-
-		ppmu_d0_cpu: ppmu_d0_cpu@10480000 {
-			compatible = "samsung,exynos-ppmu-v2";
-			reg = <0x10480000 0x2000>;
-			status = "disabled";
-		};
-
-		ppmu_d0_general: ppmu_d0_general@10490000 {
-			compatible = "samsung,exynos-ppmu-v2";
-			reg = <0x10490000 0x2000>;
-			status = "disabled";
-		};
-
-		ppmu_d0_rt: ppmu_d0_rt@104a0000 {
-			compatible = "samsung,exynos-ppmu-v2";
-			reg = <0x104a0000 0x2000>;
-			status = "disabled";
-		};
-
-		ppmu_d1_cpu: ppmu_d1_cpu@104b0000 {
-			compatible = "samsung,exynos-ppmu-v2";
-			reg = <0x104b0000 0x2000>;
-			status = "disabled";
-		};
-
-		ppmu_d1_general: ppmu_d1_general@104c0000 {
-			compatible = "samsung,exynos-ppmu-v2";
-			reg = <0x104c0000 0x2000>;
-			status = "disabled";
-		};
-
-		ppmu_d1_rt: ppmu_d1_rt@104d0000 {
-			compatible = "samsung,exynos-ppmu-v2";
-			reg = <0x104d0000 0x2000>;
-			status = "disabled";
-		};
-
-Example4 : 'event-data-type' in exynos4412-ppmu-common.dtsi are listed below.
-
-	&ppmu_dmc0 {
-		status = "okay";
-		events {
-			ppmu_dmc0_3: ppmu-event3-dmc0 {
-			event-name = "ppmu-event3-dmc0";
-			event-data-type = <(PPMU_RO_DATA_CNT |
-					PPMU_WO_DATA_CNT)>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml b/Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml
new file mode 100644
index 000000000000..d755f4ff1bea
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml
@@ -0,0 +1,174 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/event/samsung,exynos-ppmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC PPMU (Platform Performance Monitoring Unit)
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  The Samsung Exynos SoC has PPMU (Platform Performance Monitoring Unit) for
+  each IP. PPMU provides the primitive values to get performance data. These
+  PPMU events provide information of the SoC's behaviors so that you may use to
+  analyze system performance, to make behaviors visible and to count usages of
+  each IP (DMC, CPU, RIGHTBUS, LEFTBUS, CAM interface, LCD, G3D, MFC).  The
+  Exynos PPMU driver uses the devfreq-event class to provide event data to
+  various devfreq devices. The devfreq devices would use the event data when
+  derterming the current state of each IP.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos-ppmu
+      - samsung,exynos-ppmu-v2
+
+  clock-names:
+    items:
+      - const: ppmu
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  events:
+    type: object
+
+    patternProperties:
+      '^ppmu-event[0-9]+(-[a-z0-9]+){,2}$':
+        type: object
+        properties:
+          event-name:
+            description: |
+              The unique event name among PPMU device
+            $ref: /schemas/types.yaml#/definitions/string
+
+          event-data-type:
+            description: |
+              Define the type of data which shell be counted by the counter.
+              You can check include/dt-bindings/pmu/exynos_ppmu.h for all
+              possible type, i.e. count read requests, count write data in
+              bytes, etc.  This field is optional and when it is missing, the
+              driver code will use default data type.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+        required:
+          - event-name
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    // PPMUv1 nodes for Exynos3250 (although the board DTS defines events)
+    #include <dt-bindings/clock/exynos3250.h>
+
+    ppmu_dmc0: ppmu@106a0000 {
+        compatible = "samsung,exynos-ppmu";
+        reg = <0x106a0000 0x2000>;
+
+        events {
+            ppmu_dmc0_3: ppmu-event3-dmc0 {
+                event-name = "ppmu-event3-dmc0";
+            };
+
+            ppmu_dmc0_2: ppmu-event2-dmc0 {
+                event-name = "ppmu-event2-dmc0";
+            };
+
+            ppmu_dmc0_1: ppmu-event1-dmc0 {
+                event-name = "ppmu-event1-dmc0";
+            };
+
+            ppmu_dmc0_0: ppmu-event0-dmc0 {
+                event-name = "ppmu-event0-dmc0";
+            };
+        };
+    };
+
+    ppmu_rightbus: ppmu@112a0000 {
+        compatible = "samsung,exynos-ppmu";
+        reg = <0x112a0000 0x2000>;
+        clocks = <&cmu CLK_PPMURIGHT>;
+        clock-names = "ppmu";
+
+        events {
+            ppmu_rightbus_3: ppmu-event3-rightbus {
+                event-name = "ppmu-event3-rightbus";
+            };
+        };
+    };
+
+  - |
+    // PPMUv2 nodes in Exynos5433
+    ppmu_d0_cpu: ppmu@10480000 {
+        compatible = "samsung,exynos-ppmu-v2";
+        reg = <0x10480000 0x2000>;
+        status = "disabled";
+    };
+
+    ppmu_d0_general: ppmu@10490000 {
+        compatible = "samsung,exynos-ppmu-v2";
+        reg = <0x10490000 0x2000>;
+
+        events {
+            ppmu_event0_d0_general: ppmu-event0-d0-general {
+                event-name = "ppmu-event0-d0-general";
+            };
+        };
+    };
+
+    ppmu_d0_rt: ppmu@104a0000 {
+        compatible = "samsung,exynos-ppmu-v2";
+        reg = <0x104a0000 0x2000>;
+        status = "disabled";
+    };
+
+    ppmu_d1_cpu: ppmu@104b0000 {
+        compatible = "samsung,exynos-ppmu-v2";
+        reg = <0x104b0000 0x2000>;
+        status = "disabled";
+    };
+
+    ppmu_d1_general: ppmu@104c0000 {
+        compatible = "samsung,exynos-ppmu-v2";
+        reg = <0x104c0000 0x2000>;
+        status = "disabled";
+    };
+
+    ppmu_d1_rt: ppmu@104d0000 {
+        compatible = "samsung,exynos-ppmu-v2";
+        reg = <0x104d0000 0x2000>;
+        status = "disabled";
+    };
+
+  - |
+    // PPMUv1 nodes with event-data-type for Exynos4412
+    #include <dt-bindings/pmu/exynos_ppmu.h>
+
+    ppmu@106a0000 {
+        compatible = "samsung,exynos-ppmu";
+        reg = <0x106a0000 0x2000>;
+        clocks = <&clock 400>;
+        clock-names = "ppmu";
+
+        events {
+            ppmu-event3-dmc0 {
+                event-name = "ppmu-event3-dmc0";
+                event-data-type = <(PPMU_RO_DATA_CNT |
+                                    PPMU_WO_DATA_CNT)>;
+            };
+        };
+    };
-- 
2.30.2

