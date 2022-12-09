Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54165648571
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiLIP1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiLIP0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E55E9232C
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ssRRv2V56fwYrj/K5Pt0nlm8fRU0ZnmAXwXVq8Zi2N0=;
        b=lXfubIL4BqMdxV7d1xdgf/rougR8Ki6L+WE2IaAzJfWkitgVvLHSHHTqCkr3caJJqY6xnh
        To5Hi+DoXo3mtvwWz1bDTuPnlybeXo3btE6sc5knDiVO3gj+0CsGJ//v34cRDT3x3eCnUA
        hdHWHHG0B2a3Kbz3bVnVi5PBkWqefc176DIn1IiE8hXKodFQACRaxVbC4I9lDDWAEd1u7G
        IGU17CdO6j0tvnGGct4u4LKvLdZFqZ69ykbcURG3t/h14TiaDbnbkJVryyMRDEMwWfI2jX
        Vb1h1xHhyDs2lRDWOCy6iqCWNXy6/6enY8Y/Nj9wLrOM8ufdxpKJaGvGA8hESA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ssRRv2V56fwYrj/K5Pt0nlm8fRU0ZnmAXwXVq8Zi2N0=;
        b=k96vJ+8h+wygg1aM53FHrIuD2BI0QTVq4jiX+x4B7EeGaYunRNU1lT25vf3/H09ZAHzh69
        7Xv6UWlnAdK0QMBw==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Ensure that thermal device is
 registered in thermal_zone_get_temp
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959851.4906.4474243575819442572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1c6b30060777352e7881383bab726046d8c3c610
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1c6b30060777352e7881383bab726046d8c3c610
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:24:54 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Ensure that thermal device is registered in thermal_zone_get_temp

Calls to thermal_zone_get_temp() are not protected against thermal zone
device removal. As result, it is possible that the thermal zone operations
callbacks are no longer valid when thermal_zone_get_temp() is called.
This may result in crashes such as

BUG: unable to handle page fault for address: ffffffffc04ef420
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
PGD 5d60e067 P4D 5d60e067 PUD 5d610067 PMD 110197067 PTE 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 3209 Comm: cat Tainted: G        W         5.10.136-19389-g615abc6eb807 #1 02df41ac0b12f3a64f4b34245188d8875bb3bce1
Hardware name: Google Coral/Coral, BIOS Google_Coral.10068.92.0 11/27/2018
RIP: 0010:thermal_zone_get_temp+0x26/0x73
Code: 89 c3 eb d3 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 53 48 85 ff 74 50 48 89 fb 48 81 ff 00 f0 ff ff 77 44 48 8b 83 98 03 00 00 <48> 83 78 10 00 74 36 49 89 f6 4c 8d bb d8 03 00 00 4c 89 ff e8 9f
RSP: 0018:ffffb3758138fd38 EFLAGS: 00010287
RAX: ffffffffc04ef410 RBX: ffff98f14d7fb000 RCX: 0000000000000000
RDX: ffff98f17cf90000 RSI: ffffb3758138fd64 RDI: ffff98f14d7fb000
RBP: ffffb3758138fd50 R08: 0000000000001000 R09: ffff98f17cf90000
R10: 0000000000000000 R11: ffffffff8dacad28 R12: 0000000000001000
R13: ffff98f1793a7d80 R14: ffff98f143231708 R15: ffff98f14d7fb018
FS:  00007ec166097800(0000) GS:ffff98f1bbd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc04ef420 CR3: 000000010ee9a000 CR4: 00000000003506e0
Call Trace:
 temp_show+0x31/0x68
 dev_attr_show+0x1d/0x4f
 sysfs_kf_seq_show+0x92/0x107
 seq_read_iter+0xf5/0x3f2
 vfs_read+0x205/0x379
 __x64_sys_read+0x7c/0xe2
 do_syscall_64+0x43/0x55
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

if a thermal device is removed while accesses to its device attributes
are ongoing.

The problem is exposed by code in iwl_op_mode_mvm_start(), which registers
a thermal zone device only to unregister it shortly afterwards if an
unrelated failure is encountered while accessing the hardware.

Check if the thermal zone device is registered after acquiring the
thermal zone device mutex to ensure this does not happen.

The code was tested by triggering the failure in iwl_op_mode_mvm_start()
on purpose. Without this patch, the kernel crashes reliably. The crash
is no longer observed after applying this and the preceding patches.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index c65cdce..fca0b23 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -115,7 +115,12 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	int ret;
 
 	mutex_lock(&tz->lock);
-	ret = __thermal_zone_get_temp(tz, temp);
+
+	if (device_is_registered(&tz->device))
+		ret = __thermal_zone_get_temp(tz, temp);
+	else
+		ret = -ENODEV;
+
 	mutex_unlock(&tz->lock);
 
 	return ret;
