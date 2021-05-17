Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EA23829F8
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhEQKjf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:39:35 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:25437 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbhEQKje (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:39:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621247894; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ee8dhg/wXej0IPoyr8k/MDDQHf3vDJakrrL1iIUD/LVHzlewggvoo8tQn7cdUELrDS
    bYd2BOwt1f4feYgofySuCH5gPNYtqZymYMjjN/b/wQcuclYOOfAKw+mJxVX1tHED6p/9
    QH3ohfuY9YkxLmFkQxk9E0SUudxbZLwaN1YToz2Ar4/+dVJnzVtO0ry3RdrHTgedDEN/
    Y9cGbL1HEkgVkIaaiLBch1Ee9DgeVUqRVEXgk0wDwbXmnVHYV0HuUiQS7X6nhFvTNwok
    SF1srN89OMJ5d6Zu2/dCGj7afzVB2AKRYrG7vVjBVx35MrJkXwDxFufa2mbwZuqzSVyb
    q5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621247894;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GoBa/ve6tAbPHz+sONXvnYl+mlT4vBV3kKMUhJYWd7E=;
    b=UH57N7A6NEPQ2kiHqbYgteLxYwtCLZbN3vHK5Jxi62wCd7zGgjqHKtJx5IBrLqZ0+l
    fQgZj0h8+/QG2Frcvf/UlsCqKq6bkEcPfSNlySH92o6ooCx0z6rMjSycc2g+PrK5Ej7R
    OBDGt42ZQO6LOoYSh1FJO331EbR1oliOCcte93J4Hk6klmkND9CmATEfk6geJJE5kI6e
    Qvx9moOaLh+to4iZ/wilEYyxUAzcSxIohmY0GI8xA2vEY4s8sVjdO5WBRltp0uqTi7bf
    uihZoWkBMXgWUmi5dCLxTILR6ELKesOF+jXhx2x2rG91TyxeTZIzztEbK4Z8jA7yt1zF
    BiTg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621247894;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GoBa/ve6tAbPHz+sONXvnYl+mlT4vBV3kKMUhJYWd7E=;
    b=jXBeJNNndCLAQKcs4E3rcCapjwS5/e8rMN/eXtN5E+IhDRNB5iO7MPww5O+RjdfHE7
    6J/VQG1sQdsfKhwTjX/p5C1fvoDBXUHfxxaVJ1VK59rv7XH1y/6930EwkloqE2EJQcB0
    hpQLmMCK2EpzQSANNufgRoJY9QbbYbpqALFH2lhjMZE0+bWgcH/FnVlhveFpB4xQ5UB9
    hQmeYjXSQQ/XdFh5AeW9OYUSZONJnEZI1DxRuMjsnl0I8xpc/QSSqlKyGruzwiUIvnQq
    TMTossblw1NmZCvv4hdP8QJ/5olGI8lN4KisJBPZEdz7IAGQAtM/G96/sRKLGYEet/A4
    7TJw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NcMiO"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAcE1PS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:38:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/3] dt-bindings: power: supply: Add DT schema for richtek,rt5033-battery
Date:   Mon, 17 May 2021 12:35:52 +0200
Message-Id: <20210517103554.168159-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517103554.168159-1-stephan@gerhold.net>
References: <20210517103554.168159-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RT5033 PMIC provides a simple fuel gauge via I2C.
Add a DT schema to describe how to set it up in the device tree.

Note that although RT5033 is a MFD with lots of functionality
(also charger, regulator, LEDs, ...) the fuel gauge has a separate
I2C bus and is not part of the MFD.

Cc: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../power/supply/richtek,rt5033-battery.yaml  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
new file mode 100644
index 000000000000..ae647d3355a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/richtek,rt5033-battery.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Richtek RT5033 PMIC Fuel Gauge
+
+maintainers:
+  - Stephan Gerhold <stephan@gerhold.net>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: richtek,rt5033-battery
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@35 {
+        compatible = "richtek,rt5033-battery";
+        reg = <0x35>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@35 {
+        compatible = "richtek,rt5033-battery";
+        reg = <0x35>;
+        interrupt-parent = <&msmgpio>;
+        interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
+      };
+    };
-- 
2.31.1

