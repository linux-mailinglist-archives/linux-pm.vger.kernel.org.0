Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F106FBD5A
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 04:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjEICpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 22:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjEICpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 22:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088B4207
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 19:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABD6962754
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 02:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44245C433EF;
        Tue,  9 May 2023 02:45:36 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     chenhuacai@kernel.org, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] power: supply: Fix power_supply_get_battery_info() if parent is NULL
Date:   Tue,  9 May 2023 10:44:48 +0800
Message-Id: <20230509024448.1322898-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HEXHASH_WORD,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After commit 27a2195efa8d26447c ("power: supply: core: auto-exposure
of simple-battery data") we call power_supply_get_battery_info() in
__power_supply_register(), but it causes test_battery crash with NULL
pointer:

[    7.524846] __power_supply_register: Expected proper parent device for 'test_battery'
[    7.524856] CPU 3 Unable to handle kernel paging request at virtual address 0000000000000278, era == 9000000002fb279c, ra == 9000000003173434
[    7.524862] Oops[#1]:
[    7.524866] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.3.0+ #524
[    7.524870] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/2022
[    7.524872] pc 9000000002fb279c ra 9000000003173434 tp 90000001001f0000 sp 90000001001f3c00
[    7.524875] a0 0000000000000000 a1 0000000000000000 a2 0000000000000000 a3 9000000004553e13
[    7.524878] a4 9000000004553e16 a5 ffffffffffffffff a6 9000000003fd0948 a7 0000000000000030
[    7.524881] t0 9000000003173434 t1 90000000035e2c00 t2 0000000000000001 t3 00000000fffff2b0
[    7.524883] t4 0000000000000007 t5 fffffffffffffffe t6 0000000000000000 t7 0000000000000010
[    7.524886] t8 00000000000000b4 u0 00000001c0840c76 s9 0000000000000000 s0 0000000000000000
[    7.524889] s1 900000000370c458 s2 0000000000000001 s3 9000000101f81000 s4 9000000101f81038
[    7.524891] s5 9000000101f813a0 s6 900000000370c398 s7 9000000003eebd18 s8 90000000037c0070
[    7.524894]    ra: 9000000003173434 power_supply_get_battery_info+0xe4/0x710
[    7.591224]   ERA: 9000000002fb279c __dev_fwnode+0x8/0x20
[    7.853583]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[    7.859740]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[    7.864073]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[    7.868839]  ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
[    7.873430] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
[    7.878884]  BADV: 0000000000000278
[    7.882346]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
[    7.888056] Modules linked in:
[    7.891088] Process swapper/0 (pid: 1, threadinfo=0000000091357ee8, task=00000000313d98cb)
[    7.899307] Stack : 00000000000000b4 900000000279aca8 0000000000000001 0000000000000000
[    7.907274]         0000000000000049 0000000000000408 9000000100008c00 90000000035b6370
[    7.915238]         900000000b801080 90000000029a440c 9000000003eb4680 9000000003eb4680
[    7.923202]         9000000101f81038 900000000357cdcc 0000000000000001 900000000370c458
[    7.931166]         9000000101f81000 90000000037c0070 9000000003eebd18 900000000370c398
[    7.939131]         90000000045f4530 9000000101f81038 0000000000000000 0000000000000001
[    7.947095]         900000000370c458 9000000101f81000 0000000000000000 9000000003173e64
[    7.955059]         0000000000000026 9000000003de3880 9000000100562040 900000000357e07c
[    7.963023]         000000000000026f 0000000000000001 90000001001f3d68 fffffffffffffff5
[    7.970987]         90000000036d2ca8 90000000027429d8 90000000037c0030 0000000000000001
[    7.978951]         ...
[    7.981379] Call Trace:
[    7.981382] [<9000000002fb279c>] __dev_fwnode+0x8/0x20
[    7.988916] [<9000000003173434>] power_supply_get_battery_info+0xe4/0x710
[    7.995666] [<9000000003173e64>] __power_supply_register+0x404/0x580
[    8.001984] [<900000000379d368>] test_power_init+0x6c/0x124
[    8.007527] [<90000000026e08f8>] do_one_initcall+0x58/0x1ec
[    8.013066] [<9000000003761614>] kernel_init_freeable+0x290/0x310
[    8.019127] [<90000000035b40e8>] kernel_init+0x24/0x11c
[    8.024324] [<90000000026e2048>] ret_from_kernel_thread+0xc/0xa4
[    8.030295]
[    8.031769] Code: 4c000020  0015002c  03400000 <28c9e08c> 40000d80  02c06184  4c000020  28ca0084  4c000020

Root cause: psy->dev.parent is NULL in power_supply_get_battery_info(),
so change the else branch to be 'else if (psy->dev.parent)' and return
-ENOENT if psy->dev.parent is NULL.

Fixes: 27a2195efa8d26447c ("power: supply: core: auto-exposure of simple-battery data")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/power/supply/power_supply_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ab986dbace16..d1b19027f53b 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -573,7 +573,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	struct power_supply_battery_info *info;
 	struct device_node *battery_np = NULL;
 	struct fwnode_reference_args args;
-	struct fwnode_handle *fwnode;
+	struct fwnode_handle *fwnode = NULL;
 	const char *value;
 	int err, len, index;
 	const __be32 *list;
@@ -585,7 +585,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			return -ENODEV;
 
 		fwnode = fwnode_handle_get(of_fwnode_handle(battery_np));
-	} else {
+	} else if (psy->dev.parent) {
 		err = fwnode_property_get_reference_args(
 					dev_fwnode(psy->dev.parent),
 					"monitored-battery", NULL, 0, 0, &args);
@@ -595,6 +595,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		fwnode = args.fwnode;
 	}
 
+	if (!fwnode)
+		return -ENOENT;
+
 	err = fwnode_property_read_string(fwnode, "compatible", &value);
 	if (err)
 		goto out_put_node;
-- 
2.39.1

