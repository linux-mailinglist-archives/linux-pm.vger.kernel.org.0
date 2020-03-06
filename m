Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADFA17BD90
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 14:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCFNEI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 08:04:08 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36200 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgCFNEI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 08:04:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 136888030701;
        Fri,  6 Mar 2020 13:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eiDv7yP_oPEm; Fri,  6 Mar 2020 16:04:01 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sre@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] power: reset: syscon-reboot-mode: Add regmap dts-property support
Date:   Fri, 6 Mar 2020 16:03:41 +0300
In-Reply-To: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130407.136888030701@mail.baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

'Reboot-mode'-type of devices are supposed to work in conjunction with
'reboot'-type devices. In particular Baikal-T1 SoC provides a special
CCU_WDT_RCR register, which is preserved during any type of the CPU
reset (standard and caused by a watchdog one). Since both of them are
responsible for the system-wide operation and related with each other
it would be better to place them at the same place in the dt hierarchy.
In particular the best location would be the dt root node. Currently
'syscon-reboot' device node can be placed anywhere in a dtb as long as
the corresponding device is created at the system boot-up procedure.
While according to the corresponding bindings file 'system-boot-mode'
should be represented as a sub-node of a "syscon", "simple-mfd" node.
This isn't always suitable especially when the reboot-preserved
register is provided by some device, which we don't want to declared
as MFD. In this case it would be good to have the 'syscon-reboot-mode'
node accepting the 'regmap' property with a phandle reference to the
'syscon' dt-node, in the same way the 'syscon-reboot' driver does.
This is what this patch provides - it makes the driver to handle the
optional 'regmap' property. In case if one isn't provided the
previously implemented scheme is expected to be found in dtb.

Moreover seeing current dt-interface implementation of the
'syscon-reboot', 'syscon-poweroff' and 'syscon-reboot-mode' drivers,
they look more or less similar. All of them handle 'offset' and
'mask' dt-properties. While 'value' property is only acceptable
by the 'syscon-reboot' and 'syscon-poweroff' driver, the 'mode-*'
properties of 'syscon-reboot-mode' serve to the similar purpose.
The only strong difference between them is the ability to get the
syscon regmap from the 'regmap' property. By having this patch merged
we'll have that difference eliminated, so the interfaces would look
unified.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/power/reset/syscon-reboot-mode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7..f8f8218ae3ee 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -40,6 +40,7 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct syscon_reboot_mode *syscon_rbm;
+	struct regmap *map;
 
 	syscon_rbm = devm_kzalloc(&pdev->dev, sizeof(*syscon_rbm), GFP_KERNEL);
 	if (!syscon_rbm)
@@ -49,9 +50,13 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 	syscon_rbm->reboot.write = syscon_reboot_mode_write;
 	syscon_rbm->mask = 0xffffffff;
 
-	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
-	if (IS_ERR(syscon_rbm->map))
-		return PTR_ERR(syscon_rbm->map);
+	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
+	if (IS_ERR(map)) {
+		map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+		if (IS_ERR(map))
+			return PTR_ERR(map);
+	}
+	syscon_rbm->map = map;
 
 	if (of_property_read_u32(pdev->dev.of_node, "offset",
 	    &syscon_rbm->offset))
-- 
2.25.1

