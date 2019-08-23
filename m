Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4FB9AB05
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfHWJEY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 05:04:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44395 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393379AbfHWJEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 05:04:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so7904986wrf.11
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LvSehJyODRU+BRndfta8X08B5j8xEwZsfCZBCIijqkA=;
        b=E+zizfj6/hflx1ZbXlN5dwuG/nBU4lF/fLOdwiBVlomxgRHm32lbrGRc1FKrVpEDEN
         LvO8Y70tSWIjHy9d4t/3kTOws5W8riekeiM1p65Vd2zAgqFkgEnklJ4HsaZtLCdw3p8t
         JVjJszDE+m/3wlvHFIKWqG07gjSFEtss6siXetJUxE93nhrBizLayCmrVvfoRDN+tTgw
         E/FqG5Tq89P5qKL33BaC50Wkcrllu5X95lQiQet1zQOlHRiZEt0A2//Bk9NfGNAIx0/F
         AwmCeFCHjYAzsB9kMLjBo1TFlKpuTnB250m13X0rIOKizYqZ+HKl4kpItlJ/hXaJQtIR
         9oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvSehJyODRU+BRndfta8X08B5j8xEwZsfCZBCIijqkA=;
        b=c4SgaUGrmnLQj3g68wua4ucYrurV1eJXT73GheRWek3D1ECNWqEKRTScSqmjqPNxA5
         EJMsSU/BDr35jjWyoCjUOYiD/3gnbulBuJ2DRwDbR3Ksj+BwiWfCE4FRKV5u2eAUYwWI
         OS6psXOFS8+vtIhcmPxknDTXHqQRLZW8lDo7ptGG9KwrRozi1kWcx8DN7Sc/+jBJfwCW
         PdzDZ+peW0c85k3EezPMFWqsaxPBiVgTaBgaNmywirVcFHf1v4AuVP2TX+8kbfaaiBYe
         7j0ry8n6sF/nuy+YJX3VLVLxlkqbDlc7543JTZy8gpobIFiIpEboTxTVwkm9zl4Bc54A
         TgHA==
X-Gm-Message-State: APjAAAVlxOCpd0zBA/7kUR4lS+pdKFxshrOelgT3s/s6QPtVKaz6Z5dI
        BEuCsaoVnqWGk+7kVp73h5qQ/w==
X-Google-Smtp-Source: APXvYqwDUPj4N7Dlk+UHgEF98F+a80ceB6IAZDgPKpiKwLjDdXUp2W+wP1PIvNCDjmQKl+tzKhHfoQ==
X-Received: by 2002:a05:6000:1085:: with SMTP id y5mr3787664wrw.285.1566551061365;
        Fri, 23 Aug 2019 02:04:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x26sm1625544wmj.42.2019.08.23.02.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:04:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: power: add Amlogic Everything-Else power domains bindings
Date:   Fri, 23 Aug 2019 11:04:14 +0200
Message-Id: <20190823090418.17148-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823090418.17148-1-narmstrong@baylibre.com>
References: <20190823090418.17148-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the Amlogic Everything-Else power domains,
controlling the Everything-Else peripherals power domains.

The bindings targets the Amlogic G12A and SM1 compatible SoCs,
support for earlier SoCs will be added later.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 93 +++++++++++++++++++
 include/dt-bindings/power/meson-g12a-power.h  | 13 +++
 include/dt-bindings/power/meson-sm1-power.h   | 18 ++++
 3 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
 create mode 100644 include/dt-bindings/power/meson-g12a-power.h
 create mode 100644 include/dt-bindings/power/meson-sm1-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
new file mode 100644
index 000000000000..aab70e8b681e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/amlogic,meson-ee-pwrc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson Everything-Else Power Domains
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |+
+  The Everything-Else Power Domains node should be the child of a syscon
+  node with the required property:
+
+  - compatible: Should be the following:
+                "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
+
+  Refer to the the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.txt
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-g12a-pwrc
+      - amlogic,meson-sm1-pwrc
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: vpu
+      - const: vapb
+
+  resets:
+    minItems: 11
+
+  reset-names:
+    items:
+      - const: viu
+      - const: venc
+      - const: vcbus
+      - const: bt656
+      - const: rdma
+      - const: venci
+      - const: vencp
+      - const: vdac
+      - const: vdi6
+      - const: vencl
+      - const: vid_lock
+
+  "#power-domain-cells":
+    const: 1
+
+  amlogic,ao-sysctrl:
+    description: phandle to the AO sysctrl node
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - "#power-domain-cells"
+  - amlogic,ao-sysctrl
+
+examples:
+  - |
+    pwrc: power-controller {
+          compatible = "amlogic,meson-sm1-pwrc";
+          #power-domain-cells = <1>;
+          amlogic,ao-sysctrl = <&rti>;
+          resets = <&reset_viu>,
+                   <&reset_venc>,
+                   <&reset_vcbus>,
+                   <&reset_bt656>,
+                   <&reset_rdma>,
+                   <&reset_venci>,
+                   <&reset_vencp>,
+                   <&reset_vdac>,
+                   <&reset_vdi6>,
+                   <&reset_vencl>,
+                   <&reset_vid_lock>;
+          reset-names = "viu", "venc", "vcbus", "bt656",
+                        "rdma", "venci", "vencp", "vdac",
+                        "vdi6", "vencl", "vid_lock";
+          clocks = <&clk_vpu>, <&clk_vapb>;
+          clock-names = "vpu", "vapb";
+    };
diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
new file mode 100644
index 000000000000..bb5e67a842de
--- /dev/null
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_G12A_POWER_H
+#define _DT_BINDINGS_MESON_G12A_POWER_H
+
+#define PWRC_G12A_VPU_ID		0
+#define PWRC_G12A_ETH_ID		1
+
+#endif
diff --git a/include/dt-bindings/power/meson-sm1-power.h b/include/dt-bindings/power/meson-sm1-power.h
new file mode 100644
index 000000000000..a020ab00c134
--- /dev/null
+++ b/include/dt-bindings/power/meson-sm1-power.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_SM1_POWER_H
+#define _DT_BINDINGS_MESON_SM1_POWER_H
+
+#define PWRC_SM1_VPU_ID		0
+#define PWRC_SM1_NNA_ID		1
+#define PWRC_SM1_USB_ID		2
+#define PWRC_SM1_PCIE_ID	3
+#define PWRC_SM1_GE2D_ID	4
+#define PWRC_SM1_AUDIO_ID	5
+#define PWRC_SM1_ETH_ID		6
+
+#endif
-- 
2.22.0

