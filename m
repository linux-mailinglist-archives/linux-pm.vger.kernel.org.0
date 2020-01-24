Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5814862A
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbgAXNa2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 08:30:28 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:37546 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388216AbgAXNaU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 08:30:20 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id uDW42100L5USYZQ06DW4cs; Fri, 24 Jan 2020 14:30:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iuz2C-0007bK-ED; Fri, 24 Jan 2020 14:30:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iuz2C-00047E-CN; Fri, 24 Jan 2020 14:30:04 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] crypto: ccree - fix debugfs register access while suspended
Date:   Fri, 24 Jan 2020 14:29:57 +0100
Message-Id: <20200124132957.15769-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124132957.15769-1-geert+renesas@glider.be>
References: <20200124132957.15769-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reading the debugfs files under /sys/kernel/debug/ccree/ can be done by
the user at any time.  On R-Car SoCs, the CCREE device is power-managed
using a moduile clock, and if this clock is not running, bogus register
values may be read.

Fix this by filling in the debugfs_regset32.dev field, so debugfs will
make sure the device is resumed while its registers are being read.

This fixes the bogus values (0x00000260) in the register dumps on R-Car
H3 ES1.0:

    -e6601000.crypto/regs:HOST_IRR = 0x00000260
    -e6601000.crypto/regs:HOST_POWER_DOWN_EN = 0x00000260
    +e6601000.crypto/regs:HOST_IRR = 0x00000038
    +e6601000.crypto/regs:HOST_POWER_DOWN_EN = 0x00000038
     e6601000.crypto/regs:AXIM_MON_ERR = 0x00000000
     e6601000.crypto/regs:DSCRPTR_QUEUE_CONTENT = 0x000002aa
    -e6601000.crypto/regs:HOST_IMR = 0x00000260
    +e6601000.crypto/regs:HOST_IMR = 0x017ffeff
     e6601000.crypto/regs:AXIM_CFG = 0x001f0007
     e6601000.crypto/regs:AXIM_CACHE_PARAMS = 0x00000000
    -e6601000.crypto/regs:GPR_HOST = 0x00000260
    +e6601000.crypto/regs:GPR_HOST = 0x017ffeff
     e6601000.crypto/regs:AXIM_MON_COMP = 0x00000000
    -e6601000.crypto/version:SIGNATURE = 0x00000260
    -e6601000.crypto/version:VERSION = 0x00000260
    +e6601000.crypto/version:SIGNATURE = 0xdcc63000
    +e6601000.crypto/version:VERSION = 0xaf400001

Note that this behavior is system-dependent, and the issue does not show
up on all R-Car Gen3 SoCs and boards.  Even when the device is
suspended, the module clock may be left enabled, if configured by the
firmware for Secure Mode, or when controlled by the Real-Time Core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/crypto/ccree/cc_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/ccree/cc_debugfs.c b/drivers/crypto/ccree/cc_debugfs.c
index 5669997386988055..35f3a2137502bd96 100644
--- a/drivers/crypto/ccree/cc_debugfs.c
+++ b/drivers/crypto/ccree/cc_debugfs.c
@@ -81,6 +81,7 @@ int cc_debugfs_init(struct cc_drvdata *drvdata)
 	regset->regs = debug_regs;
 	regset->nregs = ARRAY_SIZE(debug_regs);
 	regset->base = drvdata->cc_base;
+	regset->dev = dev;
 
 	ctx->dir = debugfs_create_dir(drvdata->plat_dev->name, cc_debugfs_dir);
 
@@ -102,6 +103,7 @@ int cc_debugfs_init(struct cc_drvdata *drvdata)
 		verset->nregs = ARRAY_SIZE(pid_cid_regs);
 	}
 	verset->base = drvdata->cc_base;
+	verset->dev = dev;
 
 	debugfs_create_regset32("version", 0400, ctx->dir, verset);
 
-- 
2.17.1

