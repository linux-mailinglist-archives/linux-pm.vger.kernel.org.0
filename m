Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99011C9F36
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 01:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEGXjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 19:39:04 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39442 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgEGXjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 19:39:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 13ED980307C7;
        Thu,  7 May 2020 23:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XjurNOfxXpwU; Fri,  8 May 2020 02:38:57 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: power: reset: Unrequire regmap property in syscon-reboot node
Date:   Fri, 8 May 2020 02:38:45 +0300
Message-ID: <20200507233846.11548-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
 <20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since normally syscon-reboot block is supposed to be a part of a system
controller, lets mark the regmap property as deprecated and recommend the
syscon-reboot node to be a sub-node of SYSCON.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org

---

Changelog v2:
- This is a new patch created as a result of the discussion:
  https://lore.kernel.org/linux-pm/20200306130402.1F4F0803079F@mail.baikalelectronics.ru/
---
 .../bindings/power/reset/syscon-reboot.yaml       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index b80772cb9f06..da2509724812 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -12,9 +12,12 @@ maintainers:
 description: |+
   This is a generic reset driver using syscon to map the reset register.
   The reset is generally performed with a write to the reset register
-  defined by the register map pointed by syscon reference plus the offset
-  with the value and mask defined in the reboot node.
-  Default will be little endian mode, 32 bit access only.
+  defined by the SYSCON register map base plus the offset with the value and
+  mask defined in the reboot node. Default will be little endian mode, 32 bit
+  access only. The SYSCON registers map is normally retrieved from the
+  parental dt-node. So the SYSCON reboot node should be represented as a
+  sub-node of a "syscon", "simple-mfd" node. Though the regmap property
+  pointing to the system controller node is also supported.
 
 properties:
   compatible:
@@ -30,7 +33,10 @@ properties:
 
   regmap:
     $ref: /schemas/types.yaml#/definitions/phandle
-    description: Phandle to the register map node.
+    deprecated: true
+    description: |
+      Phandle to the register map node. This property is deprecated in favor of
+      the syscon-reboot node been a child of a system controller node.
 
   value:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -38,7 +44,6 @@ properties:
 
 required:
   - compatible
-  - regmap
   - offset
 
 additionalProperties: false
-- 
2.25.1

