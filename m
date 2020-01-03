Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079FC12FB8E
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 18:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgACRYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 12:24:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:50553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgACRYt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jan 2020 12:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578072273;
        bh=qghX+QZQz0amY4J6exmjXYni20BbeHit7yiZbXpzCH4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GKrQtN0uzXgE0oKJ3P2lSxrNhQ20i/QswZ0TwsdKaa5wZ+kFUVjn9nppsEc12SIut
         PHmepwD+ZpsPTjhI/WhADT4FYKbn3s+VJgTR7pMK4+5nU+mqoKu2pfiZwvbpylExlI
         z9n81bCyzYnSFupzfQvg8+sIF4Qdm4ijbf74U+tM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MYeR1-1jHHkI1YSh-00Vjmh; Fri, 03 Jan 2020 18:24:33 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 1/4] dt-bindings: Add Broadcom AVS RO thermal
Date:   Fri,  3 Jan 2020 18:23:53 +0100
Message-Id: <1578072236-31820-2-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
References: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:DS97MUMU4JfP2Uj8qPbJqu6pgKli1UXiEGkkZQ6zYhvTxMTqFHl
 7G3s/jafuIr6u+H/o34IJS1rpDSikd4TjamNe2SMEM7IRZLsEOk3zK70RqhdmAqQxUdbUxA
 vYrcHp2KDuRGwLW8uraQpi/mGPTOqcL6BLkCzt/eq2UoXQWTDNOInFeCT8hAGsrFKDaM16o
 0aP5OtLHQ2offJIBlzMKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mJjmYR9lwEM=:IphzPXGuGbTDRm1zeeTUJj
 eatyE7V06qoKafaLN3e1ml9GfzqeQicUGpa1fXlzWYy4YD+c+c2cvbmlRn5aPSTSp9teWUtaQ
 8urjoOYL4PMfxCQopopTAZyNIgWEm2inIy+PRegrrRQRE4BB1mueCkUNhVmKIezmE0UEory22
 Z6UJljlvSvNzQpZtlBwpTZxTCq+sFKF1kEbjWjxIJepxRHGmUnRMqUq32YVOGi9IhM0bsmoj7
 XymwR+vhk67VOujJ16IzU9u9hR4UPirmRcdw1eJkwi1a10m3vv7ufM13C2lUkKt8guh9ox4qd
 Mgi7+d45NjksvW9yuEQ3XilMD8cE+Bh7exor8nUUyugESzJEXn3wXaofh42LWDvQcyZbI94rX
 tpy4uWpN/ZsfH7/LRSYLw7IjXYoz9Lvj9zTSfBzwf1uQTstvpXbENOfzhTivyZCjGSJKVvayT
 OjEdLnAl2jVgqiRtaumaNPHKAnugdEYVGB7xBnEs8hyKxmQCcQDnabcAq50nqDUDUlWntScKV
 qtU1izIf4i8bcu2nH4Hioss3Q/XKmhBOavnVr54El+dGLSHukjueCly+gpXeL63vQGSMD0T8g
 vHiQElQdwQe/Kfz3MTMyYspYX+wtj6pTYKzzzxfA1diWkb01qVZVFL47vrjRpl2i2+mqmL5CA
 O5YjjQFoqJ5jh6iKjJzZFFcXiKq6Nkh0Lvuj9xR4dkRs8bPIRxYErL98BOxZ8gdXkelpJ8gtl
 Jqil4YB/pe6WtVntq7Nq7n4JuMhBbJsDI0T52q2PNzsmAPfp6Eh+C99EJ1xK9Hy2ByjratgEW
 j0MIKIrpj6zv6jRSsrtDE3L/iyNNJM7fzktSGUyZavkkeutx7kd/n4Iuk/VEIax4+9uEs0JXs
 MPcgIznD47m1mLQTSwdlPUEDiGB0pZhj7SD8Xk+7mMRBlOtE6Fnu5sILbzNgPGPiJd59DND/N
 Jc6/VSsZZTe0FMizoG1Yf1QJ6N7C/LUOEt6a0Lo6ppCwirhGe6f9WOdok/xUlahp5zhNCSXrA
 Fe4EB69FuFG3myHPXO0qi3Cn1ZKcrXx6Usu1kt5eySnBrQguKM5pk0VbXR/w99uXpEk/Usqy2
 30/b4RvZuI0YZe4e3NfjakjzNwAqBjEKkaOLeI0qjHGaucjSyD8pC1Kx6dDHSVmf438sLihUn
 t0PhzYxyVP5T9oxvYZBp/Tq285gWcXkg2CFwr9XYo/miQaeC9iTEbmcq2YGUEEGn+2kTeWSzx
 uPn/eBL0DHRVVQ64kDcaK6ZjI6Xk3MBMyCzCUJg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the BCM2711 doesn't have a AVS TMON block, the thermal information
must be retrieved from the AVS ring oscillator block. This block is part
of the AVS monitor which contains a bunch of raw sensors.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 45 +++++++++++++++++=
+++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-=
thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal=
.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
new file mode 100644
index 0000000..7dce05e
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,avs-ro-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom AVS ring oscillator thermal
+
+maintainers:
+  - Stefan Wahren <wahrenst@gmx.net>
+
+description: |+
+  The thermal node should be the child of a syscon node with the
+  required property:
+
+  - compatible: Should be one of the following:
+                "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
+
+  Refer to the the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.txt
+
+properties:
+  compatible:
+    const: brcm,bcm2711-thermal
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+        avs-monitor@7d5d2000 {
+                compatible =3D "brcm,bcm2711-avs-monitor",
+                             "syscon", "simple-mfd";
+                reg =3D <0x7d5d2000 0xf00>;
+
+                thermal: thermal {
+                        compatible =3D "brcm,bcm2711-thermal";
+                        #thermal-sensor-cells =3D <0>;
+                };
+        };
+...
=2D-
2.7.4

