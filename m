Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3A32D7908
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437769AbgLKPTF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 10:19:05 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:18094 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406590AbgLKPSs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 10:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607699746;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=dUqD5VcONOumwAMpM+Nqvxi0d/Ll3217bqW7huqrxRc=;
        b=raBoJHFR1BhDqkovLQ1sDXJuaH8mF6wwXHuL9kMREXtl/YjgfcaSiGezKAUigTzdJ1
        jlIOyVbS+GkQrLBKatgWiD2m+9lgEq0o6IGnSzU2xexkKyo9HfFVhlt+95Obu8rX4SeT
        E6ZKnR7VTfkmICrJPxHsgz6Up4cLjSpJZatuJzFNT1im5RHHe6L2zuTPqNMJ3PTe4JwN
        VkSPrlHnrEsowRurIeDS1hnlBwgG8xNzDNo138AW+A5GtKPuD5ZKrTLjKYsL8Mc2wmnd
        vdEcy9yGjevGZMRuiCJ/McFAb/ed0vUyhcpTSqn90yZa8Q1fimV89yZCp8lrcrknGiph
        jaOw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.7.1 AUTH)
        with ESMTPSA id L0a6acwBBFFg1A3
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 11 Dec 2020 16:15:42 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1knk8J-0005S1-5w; Fri, 11 Dec 2020 16:14:59 +0100
Received: (nullmailer pid 116034 invoked by uid 502);
        Fri, 11 Dec 2020 15:14:59 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/3] Documentation: DT: binding documentation for regulator-poweroff
Date:   Fri, 11 Dec 2020 16:14:44 +0100
Message-Id: <20201211151445.115943-3-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211151445.115943-1-michael@fossekall.de>
References: <20201211151445.115943-1-michael@fossekall.de>
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
index 000000000000..03bd1fa5a623
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
+  cpu-supply:
+    description:
+      regulator to disable on power-down
+
+required:
+  - compatible
+  - cpu-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    regulator-poweroff {
+        compatible = "regulator-poweroff";
+        cpu-supply = <&reg_vcc1v2>;
+    };
+...
-- 
2.29.2

