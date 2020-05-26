Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4FC1E2359
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgEZNvL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 09:51:11 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57760 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgEZNvL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 09:51:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 468CD803086E;
        Tue, 26 May 2020 13:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 36kKExf0ojJW; Tue, 26 May 2020 16:51:07 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: power: reset: Unrequire regmap property in syscon-reboot node
Date:   Tue, 26 May 2020 16:51:00 +0300
Message-ID: <20200526135102.21236-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200526135102.21236-1-Sergey.Semin@baikalelectronics.ru>
References: <20200526135102.21236-1-Sergey.Semin@baikalelectronics.ru>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
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
2.26.2

