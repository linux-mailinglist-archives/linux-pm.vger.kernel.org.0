Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05B91E2360
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 15:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgEZNvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 09:51:13 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57774 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbgEZNvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 09:51:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 065F78030869;
        Tue, 26 May 2020 13:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UtXTcM7PrmFW; Tue, 26 May 2020 16:51:08 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sre@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] power: reset: syscon-reboot: Add parental syscon support
Date:   Tue, 26 May 2020 16:51:01 +0300
Message-ID: <20200526135102.21236-3-Sergey.Semin@baikalelectronics.ru>
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
controller, lets look for the syscon regmap in a parental DT node if
regmap property isn't specified. DT binding from now considers the regmap
property as deprecated.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v2:
- This is a new patch created as a result of the discussion:
  https://lore.kernel.org/linux-pm/20200306130402.1F4F0803079F@mail.baikalelectronics.ru/

Changelog v3:
- Resend
---
 drivers/power/reset/syscon-reboot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index 62fbba0df971..510e363381ca 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -51,8 +51,11 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
-	if (IS_ERR(ctx->map))
-		return PTR_ERR(ctx->map);
+	if (IS_ERR(ctx->map)) {
+		ctx->map = syscon_node_to_regmap(dev->parent->of_node);
+		if (IS_ERR(ctx->map))
+			return PTR_ERR(ctx->map);
+	}
 
 	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
 		return -EINVAL;
-- 
2.26.2

