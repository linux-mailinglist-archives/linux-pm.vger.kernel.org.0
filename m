Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FE22D4C7B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgLIVHI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 16:07:08 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:27763 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732923AbgLIVG7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 16:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607547836;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=e3IJY+YEVfqqtF6U/npVItLV8pI44Dnssy1P4IIS0WY=;
        b=avYFFKS2XpXl05nU/T/vF9eSwqGb5gozXtVic1HK6EpX2JQj1DYl3sHc7nu5wqCP3G
        nliIw8JPQrdnsunEBXro69n00CmI0byPGdVhkp2Kfh0nxIN+yh2vrINKI7JmK285mOY4
        sbA3j9yDlxoSTmqcXyQKze54m4fRQO8enCODGXED/jzeqxm0Biupbm+lVI/zyIH/SkHZ
        hHEMjxff+n0tYX7QXZrHlT+vG8tBhJm1JMmdJidiJZTNpHHhVZNPpDQFL3ZVWWd9+yH9
        UBop1riKfjw2bmISVPTVsk+rebTHe0glyE7cYFZhmLHVLFroFHYmus+BkW4hwaFppHbI
        nREQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.6.2 AUTH)
        with ESMTPSA id e07b38wB9L3qB1r
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 22:03:52 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kn6ck-0008Cl-DP; Wed, 09 Dec 2020 22:03:46 +0100
Received: (nullmailer pid 385358 invoked by uid 502);
        Wed, 09 Dec 2020 21:03:46 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] Documentation: DT: binding documentation for regulator-poweroff
Date:   Wed,  9 Dec 2020 22:02:20 +0100
Message-Id: <20201209210221.385188-3-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209210221.385188-1-michael@fossekall.de>
References: <20201209210221.385188-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree binding documentation for regulator-poweroff driver.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 .../power/reset/regulator-poweroff.yaml       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
new file mode 100644
index 000000000000..c74ac247ab70
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/regulator-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Force-disable power regulator to turn the power off.
+
+maintainers:
+  - Michael Klein <michael@fossekall.de>
+
+description: |
+  When the power-off handler is called, a power regulator is disabled by
+  calling regulator_force_disable(). If the power is still on and the
+  CPU still running after a 3000ms delay, a warning is emitted.
+
+properties:
+  compatible:
+    const: "regulator-poweroff"
+
+  power-supply:
+    description:
+      regulator to disable on power-down
+
+required:
+  - compatible
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    regulator-poweroff {
+        compatible = "regulator-poweroff";
+        power-supply = <&reg_vcc1v2>;
+    };
+...
-- 
2.29.2

