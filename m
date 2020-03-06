Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3436017BD87
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 14:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCFNEE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 08:04:04 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36190 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFNEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 08:04:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1F4F0803079F;
        Fri,  6 Mar 2020 13:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dhEMg_zQDqYP; Fri,  6 Mar 2020 16:03:56 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] dt-bindings: power: reset: Add regmap support to the SYSCON reboot-mode bindings
Date:   Fri, 6 Mar 2020 16:03:40 +0300
In-Reply-To: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Optional regmap property will be used to refer to a syscon-controller
having a reboot tolerant register mapped.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 .../bindings/power/reset/syscon-reboot-mode.yaml         | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
index e09bb07b1abb..f47bf52ad983 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
@@ -13,9 +13,8 @@ description: |
   This driver gets reboot mode magic value from reboot-mode driver
   and stores it in a SYSCON mapped register. Then the bootloader
   can read it and take different action according to the magic
-  value stored. The SYSCON mapped register is retrieved from the
-  parental dt-node plus the offset. So the SYSCON reboot-mode node
-  should be represented as a sub-node of a "syscon", "simple-mfd" node.
+  value stored. The SYSCON mapped register is retrieved either from
+  the parental dt-node or from a regmap phandle plus the offset.
 
 properties:
   compatible:
@@ -29,6 +28,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Offset in the register map for the mode register (in bytes).
 
+  regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the register map node.
+
 patternProperties:
   "^mode-.+":
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.25.1

