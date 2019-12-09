Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407D3116E2A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 14:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfLINsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 08:48:38 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:42542 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfLINsh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 08:48:37 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id bpoa2100U5USYZQ01poakF; Mon, 09 Dec 2019 14:48:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ieJOs-0006Sj-CA; Mon, 09 Dec 2019 14:48:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ieJOs-0003Tk-9p; Mon, 09 Dec 2019 14:48:34 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mtd: maps: physmap: Add minimal Runtime PM support
Date:   Mon,  9 Dec 2019 14:48:23 +0100
Message-Id: <20191209134823.13330-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add minimal runtime PM support (enable on probe, disable on remove), to
ensure proper operation with a parent device that uses runtime PM.

This is needed on systems where the FLASH is connected to a bus
controller that is contained in a PM domain and/or has a gateable
functional clock.  In such cases, before accessing any device connected
to the external bus, the PM domain must be powered up, and/or the
functional clock must be enabled, which is typically handled through
runtime PM by the bus controller driver.

An example of this is the Renesas APE6-EVM development board, which has
an Ethernet controller and a CFI FLASH connected to the Bus State
Controller (BSC) of an R-Mobile APE6 SoC.
As long as the Ethernet driver, which had Runtime PM support since
commit 3a611e26e958b037 ("net/smsc911x: Add minimal runtime PM
support"), keeps the BSC powered, accessing the FLASH works.
When the ethernet node in r8a73a4-ape6evm.dts is disabled, the BSC is
never powered up, and the kernel crashes when trying to access the
FLASH:

    Unhandled fault: imprecise external abort (0x1406) at 0x00000000
    pgd = (ptrval)
    [00000000] *pgd=7fef2835
    Internal error: : 1406 [#1] SMP ARM
    CPU: 0 PID: 122 Comm: hd Tainted: G        W         5.5.0-rc1-ape6evm-00814-g38ca966db25b9dbd-dirty #136
    Hardware name: Generic R8A73A4 (Flattened Device Tree)
    PC is at chip_ready+0x12c/0x380
    LR is at chip_ready+0x10c/0x380

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Probably the device should be powered down after probing, and powered
up/down on-demand in the various {get,put}_chip() functions.  However,
that is an optimization which touches more intimidate details of the
internal MTD API, and can be done later.
---
 drivers/mtd/maps/physmap-core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index a9f7964e2edb6668..8f7f966fa9a7ee8a 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -38,6 +38,7 @@
 #include <linux/mtd/cfi_endian.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/gpio/consumer.h>
 
 #include "physmap-gemini.h"
@@ -64,16 +65,16 @@ static int physmap_flash_remove(struct platform_device *dev)
 {
 	struct physmap_flash_info *info;
 	struct physmap_flash_data *physmap_data;
-	int i, err;
+	int i, err = 0;
 
 	info = platform_get_drvdata(dev);
 	if (!info)
-		return 0;
+		goto out;
 
 	if (info->cmtd) {
 		err = mtd_device_unregister(info->cmtd);
 		if (err)
-			return err;
+			goto out;
 
 		if (info->cmtd != info->mtds[0])
 			mtd_concat_destroy(info->cmtd);
@@ -88,7 +89,10 @@ static int physmap_flash_remove(struct platform_device *dev)
 	if (physmap_data && physmap_data->exit)
 		physmap_data->exit(dev);
 
-	return 0;
+out:
+	pm_runtime_put(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+	return err;
 }
 
 static void physmap_set_vpp(struct map_info *map, int state)
@@ -484,13 +488,19 @@ static int physmap_flash_probe(struct platform_device *dev)
 		return -EINVAL;
 	}
 
+	pm_runtime_enable(&dev->dev);
+	pm_runtime_get_sync(&dev->dev);
+
 	if (dev->dev.of_node)
 		err = physmap_flash_of_init(dev);
 	else
 		err = physmap_flash_pdata_init(dev);
 
-	if (err)
+	if (err) {
+		pm_runtime_put(&dev->dev);
+		pm_runtime_disable(&dev->dev);
 		return err;
+	}
 
 	for (i = 0; i < info->nmaps; i++) {
 		struct resource *res;
-- 
2.17.1

