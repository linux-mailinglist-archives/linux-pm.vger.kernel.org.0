Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE92D13DA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgLGOhK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 09:37:10 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:21910 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgLGOhK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 09:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607351658;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9SYLzlFgBXzuvKKzJL8JRRj5vw51OfuroQA/clOun08=;
        b=KK79hKHlUYATG2KA8lAb3b14Uk8W/Wc6mmW5PIHDXgU5fTgXvlWLPjHrqIIqDI3z8j
        Gu56Rud7omTG2HFPJ5Ln+eOnL9RDHdZpkvOKs2N7jZNLaFLfSGpVpbQhojVrOGEpoYjE
        fhgJ2k/ZsvT3UqotJgblyvPu2F8GtKc3Ch9fAOC3Jev/cs39RCyhMB1vK2tS90TUSlc0
        WC0UI0cpZDc8DOadx3jTx+JvuG0RncuaQz2HWay9VXJFj5t4MN3QBLN9an/+jdhzn8JL
        sAFnH+Alp9WaeLvbmBq0IvMbZNU2zXCFoOK6bZ+BUENCzEkwxMvBp/i6YGHLOm9FISnm
        dG5w==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wB7ES9OVc
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Dec 2020 15:28:09 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kmHUh-0001TH-CZ; Mon, 07 Dec 2020 15:28:03 +0100
Received: (nullmailer pid 17908 invoked by uid 502);
        Mon, 07 Dec 2020 14:28:03 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/3] Documentation: DT: binding documentation for regulator-poweroff
Date:   Mon,  7 Dec 2020 15:27:55 +0100
Message-Id: <20201207142756.17819-3-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207142756.17819-1-michael@fossekall.de>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree binding documentation for regulator-poweroff driver.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 .../power/reset/regulator-poweroff.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
new file mode 100644
index 000000000000..8c8ce6bb031a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/regulator-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Force-disable power regulators to turn the power off.
+
+maintainers:
+  - Michael Klein <michael@fossekall.de>
+
+description: |
+  When the power-off handler is called, one more regulators are disabled
+  by calling regulator_force_disable(). If the power is still on and the
+  CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.
+
+properties:
+  compatible:
+    const: "regulator-poweroff"
+
+  regulator-names:
+    description:
+      Array of regulator names
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+  REGULATOR-supply:
+    description:
+      For any REGULATOR listed in regulator-names, a phandle
+      to the corresponding regulator node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  timeout-ms:
+    description:
+      Time to wait before asserting a WARN_ON(1). If nothing is
+      specified, 3000 ms is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - regulator-names
+  - REGULATOR-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    regulator-poweroff {
+        compatible = "regulator-poweroff";
+        regulator-names = "vcc1v2", "vcc-dram";
+        vcc1v2-supply = <&reg_vcc1v2>;
+        vcc-dram-supply = <&reg_vcc_dram>;
+    };
+...
-- 
2.29.2

