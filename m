Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D46D13BE79
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgAOLam (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 06:30:42 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:38651 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgAOLal (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 06:30:41 -0500
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Wed, 15 Jan 2020
 19:31:03 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: [PATCH v6 2/4] dt-bindings: power: add Amlogic secure power domains bindings
Date:   Wed, 15 Jan 2020 19:30:29 +0800
Message-ID: <1579087831-94965-3-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
References: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the Amlogic Secure power domains, controlling the
secure power domains.

The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
power domain registers are in secure world.

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 40 ++++++++++++++++++++++
 include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
 create mode 100644 include/dt-bindings/power/meson-a1-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
new file mode 100644
index 00000000..af32209
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+# Copyright (c) 2019 Amlogic, Inc
+# Author: Jianxin Pan <jianxin.pan@amlogic.com>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson Secure Power Domains
+
+maintainers:
+  - Jianxin Pan <jianxin.pan@amlogic.com>
+
+description: |+
+  Secure Power Domains used in Meson A1/C1 SoCs, and should be the child node
+  of secure-monitor.
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-a1-pwrc
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#power-domain-cells"
+
+examples:
+  - |
+    secure-monitor {
+        compatible = "amlogic,meson-gxbb-sm";
+
+        pwrc: power-controller {
+            compatible = "amlogic,meson-a1-pwrc";
+            #power-domain-cells = <1>;
+        };
+    }
+
diff --git a/include/dt-bindings/power/meson-a1-power.h b/include/dt-bindings/power/meson-a1-power.h
new file mode 100644
index 00000000..6cf50bf
--- /dev/null
+++ b/include/dt-bindings/power/meson-a1-power.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2019 Amlogic, Inc.
+ * Author: Jianxin Pan <jianxin.pan@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_A1_POWER_H
+#define _DT_BINDINGS_MESON_A1_POWER_H
+
+#define PWRC_DSPA_ID	8
+#define PWRC_DSPB_ID	9
+#define PWRC_UART_ID	10
+#define PWRC_DMC_ID	11
+#define PWRC_I2C_ID	12
+#define PWRC_PSRAM_ID	13
+#define PWRC_ACODEC_ID	14
+#define PWRC_AUDIO_ID	15
+#define PWRC_OTP_ID	16
+#define PWRC_DMA_ID	17
+#define PWRC_SD_EMMC_ID	18
+#define PWRC_RAMA_ID	19
+#define PWRC_RAMB_ID	20
+#define PWRC_IR_ID	21
+#define PWRC_SPICC_ID	22
+#define PWRC_SPIFC_ID	23
+#define PWRC_USB_ID	24
+#define PWRC_NIC_ID	25
+#define PWRC_PDMIN_ID	26
+#define PWRC_RSA_ID	27
+#define PWRC_MAX_ID	28
+
+#endif
-- 
2.7.4

