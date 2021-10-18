Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3774317BB
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhJRLsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhJRLsL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:11 -0400
Date:   Mon, 18 Oct 2021 11:45:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOkpi7mtnc3FWmvclGCGWXawCznzRTf450IbXvyEF2s=;
        b=xdMRkh/CZYqvlwkK+ct3DD9N0SvUUgauj0vMRCvLQok6nXT8OBVLu4RuohC0IeLuoHHmxN
        7xRpf0MN0Oqqa5zMZ+8GyraRrsIqSBaK8xsrlLhpft85R94s4lBTdDrzF5ZsQB7tzaGsC/
        GG+gkVdIix6pi7DJ+NiZQNUYk+btEhwZBwrHCLaLPqNeFbJwf3XYkKOt4qjD6tO6c0FL00
        8Uopf+sd0A1D0D9HslaODMZFUK+f2dEqxChsVq825G6gtpCsLeBQ621Kz3TXKzjEC8EZ6e
        aMAuyKq+wZRrRshYGzM9GlpUVDkdoC3+fcp9iiGud90aVC5cIzXVtHxP4HGkTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOkpi7mtnc3FWmvclGCGWXawCznzRTf450IbXvyEF2s=;
        b=eLSiZxNuplUWjMWvs5XNnSIdMjaKGXMi8NOjQNQtIU5UOQB2QQ0HIFkWHtcgwUvANM7Sqr
        A8Br787vawqB6kDA==
From:   "thermal-bot for Ziyang Xuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: fix a UAF bug in
 __thermal_cooling_device_register()
Cc:     Ziyang Xuan <william.xuanziyang@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211015024504.947520-1-william.xuanziyang@huawei.com>
References: <20211015024504.947520-1-william.xuanziyang@huawei.com>
MIME-Version: 1.0
Message-ID: <163455755730.25758.6550468156631534146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     0a5c26712f963f0500161a23e0ffff8d29f742ab
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0a5c26712f963f0500161a23e0ffff8d29f742ab
Author:        Ziyang Xuan <william.xuanziyang@huawei.com>
AuthorDate:    Fri, 15 Oct 2021 10:45:04 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 15 Oct 2021 15:38:48 +02:00

thermal/core: fix a UAF bug in __thermal_cooling_device_register()

When device_register() return failed, program will goto out_kfree_type
to release 'cdev->device' by put_device(). That will call thermal_release()
to free 'cdev'. But the follow-up processes access 'cdev' continually.
That trggers the UAF bug.

====================================================================
BUG: KASAN: use-after-free in __thermal_cooling_device_register+0x75b/0xa90
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 dump_stack_lvl+0xe2/0x152
 print_address_description.constprop.0+0x21/0x140
 ? __thermal_cooling_device_register+0x75b/0xa90
 kasan_report.cold+0x7f/0x11b
 ? __thermal_cooling_device_register+0x75b/0xa90
 __thermal_cooling_device_register+0x75b/0xa90
 ? memset+0x20/0x40
 ? __sanitizer_cov_trace_pc+0x1d/0x50
 ? __devres_alloc_node+0x130/0x180
 devm_thermal_of_cooling_device_register+0x67/0xf0
 max6650_probe.cold+0x557/0x6aa
......

Freed by task 258:
 kasan_save_stack+0x1b/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0x109/0x140
 kfree+0x117/0x4c0
 thermal_release+0xa0/0x110
 device_release+0xa7/0x240
 kobject_put+0x1ce/0x540
 put_device+0x20/0x30
 __thermal_cooling_device_register+0x731/0xa90
 devm_thermal_of_cooling_device_register+0x67/0xf0
 max6650_probe.cold+0x557/0x6aa [max6650]

Do not use 'cdev' again after put_device() to fix the problem like doing
in thermal_zone_device_register().

[dlezcano]: as requested by Rafael, change the affectation into two statements.

Fixes: 584837618100 ("thermal/drivers/core: Use a char pointer for the cooling device name")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20211015024504.947520-1-william.xuanziyang@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6904b97..648829a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -889,7 +889,7 @@ __thermal_cooling_device_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
-	int ret;
+	int id, ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 	    !ops->set_cur_state)
@@ -903,6 +903,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (ret < 0)
 		goto out_kfree_cdev;
 	cdev->id = ret;
+	id = ret;
 
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	if (ret)
@@ -946,8 +947,9 @@ __thermal_cooling_device_register(struct device_node *np,
 out_kfree_type:
 	kfree(cdev->type);
 	put_device(&cdev->device);
+	cdev = NULL;
 out_ida_remove:
-	ida_simple_remove(&thermal_cdev_ida, cdev->id);
+	ida_simple_remove(&thermal_cdev_ida, id);
 out_kfree_cdev:
 	kfree(cdev);
 	return ERR_PTR(ret);
