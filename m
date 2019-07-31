Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708E67C0E8
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfGaMOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 08:14:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34590 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfGaMOQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 08:14:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so69456497wrm.1
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZCxLPCe1ACQErDUW8aWQ5KGtk3yR1/KdxyjnNrl959M=;
        b=hEtFsx3E+vxVxKVnkVJrIPQhq8u5k6R7R82zb8hMdxf9abXPdtLUh28KELgdxJxC7H
         fRk2y7UTqODUNIsjHz/e6c/DCcMZFDmYmRqcQer0vInc6NtYSx+JKe507QqSSmy+27sA
         si1yo3vz6FWgANa91bC16sQzkIS5vyEUgDzCdvaqR4tzTBvn61aSjX6IhW0cw61qZQPE
         NbnbApP+KE2tqktTZaEEwZ6VIEEC7DjdrKqhLyYtc/cUEbL48PcGFI70udjecD5SUYgU
         1DavhttVuzkByIzpTjIXy8Ot5Ginl8C4aNnpTVOXHvtAjoj3meueKbzIOTXOZxjIfDvF
         9LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZCxLPCe1ACQErDUW8aWQ5KGtk3yR1/KdxyjnNrl959M=;
        b=o0YucsRlPKhaMpl0n6HTtvgiwtRxOEGYOAR5vLAr3xTWYs9HidOudT91Q2j7CLIhjK
         HTIZE2UZt+Ray6cv2FIjNhOs+4oafftEFYcvOrnBIlSVnU6OaWShlmWNnC0cQK6rYFyM
         eu/45E2c7FFwCJSK0hyOZwbMgG16d8+Ax7QjgR4HSIJ9qOaA1cqPLf0v40VrS8l9tqrK
         N5u4VEqYcgu+AhVEHVKPWfjbuxlGHEGp8hh01oe0K1UGKVUdut3jP9mN3k4wDgkLTtmQ
         8+LPJFEY4SXwhDWvoPh/MxtnDKiJusJas4lrmsSNQ0yNExTS7zyqj1Ms6DQ4fsYeKctH
         ipxg==
X-Gm-Message-State: APjAAAXS6hTvX2KS1pg6zs8wBbYQ0vwlV8CrvlCRjTjq7NTVU6dpj35e
        4bwxL+vCcCfif8d1JiwpaBck6A==
X-Google-Smtp-Source: APXvYqyR0a3A3NknrNBLDCX+TNBWHtgAMABkJnJgH0JnXRb3PYf4C6vmioWW1jWll9xmx8tLdvDNwg==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr51394689wrm.117.1564575254371;
        Wed, 31 Jul 2019 05:14:14 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:13 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
Date:   Wed, 31 Jul 2019 14:14:04 +0200
Message-Id: <20190731121409.17285-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding the devicetree binding documentation for the Amlogic temperature
sensor found in the Amlogic Meson G12 SoCs.
the G12A  and G12B SoCs are supported.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../bindings/thermal/amlogic,thermal.yaml     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
new file mode 100644
index 000000000000..1e2fe84da13d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Thermal Driver
+
+maintainers:
+  - Guillaume La Roque <glaroque@baylibre.com>
+
+description: Amlogic Thermal driver
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,g12-cpu-thermal
+              - amlogic,g12-ddr-thermal
+          - enum:
+              - amlogic,g12-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  amlogic,ao-secure:
+    description: phandle to the ao-secure syscon
+    allOf:
+     - $ref: /schemas/types.yaml#/definitions/uint32
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - amlogic,ao-secure
+
+examples:
+  - |
+        cpu_temp: temperature-sensor@ff634800 {
+                compatible = "amlogic,g12-cpu-thermal",
+                             "amlogic,g12-thermal";
+                reg = <0x0 0xff634800 0x0 0x50>;
+                interrupts = <0x0 0x24 0x0>;
+                clocks = <&clk 164>;
+                status = "okay";
+                #thermal-sensor-cells = <1>;
+                amlogic,ao-secure = <&sec_AO>;
+        };
+...
\ No newline at end of file
-- 
2.17.1

