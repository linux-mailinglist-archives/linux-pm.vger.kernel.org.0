Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1598D4186E4
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 09:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhIZHTA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 03:19:00 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:45965 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230035AbhIZHTA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Sep 2021 03:19:00 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d82 with ME
        id yXHM2500F4m3Hzu03XHM0b; Sun, 26 Sep 2021 09:17:23 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Sep 2021 09:17:23 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] thermal: intel_powerclamp: Use bitmap_zalloc/bitmap_free when applicable
Date:   Sun, 26 Sep 2021 09:17:20 +0200
Message-Id: <f7513027ae9242643b5ddb6ed48a3aeca1b0f2a8.1632640557.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'cpu_clamping_mask' is a bitmap. So use 'bitmap_zalloc()' and
'bitmap_free()' to simplify code, improve the semantic of the code and
avoid some open-coded arithmetic in allocator arguments.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thermal/intel/intel_powerclamp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index a5b58ea89cc6..9b68489a2356 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -705,10 +705,8 @@ static enum cpuhp_state hp_state;
 static int __init powerclamp_init(void)
 {
 	int retval;
-	int bitmap_size;
 
-	bitmap_size = BITS_TO_LONGS(num_possible_cpus()) * sizeof(long);
-	cpu_clamping_mask = kzalloc(bitmap_size, GFP_KERNEL);
+	cpu_clamping_mask = bitmap_zalloc(num_possible_cpus(), GFP_KERNEL);
 	if (!cpu_clamping_mask)
 		return -ENOMEM;
 
@@ -753,7 +751,7 @@ static int __init powerclamp_init(void)
 exit_unregister:
 	cpuhp_remove_state_nocalls(hp_state);
 exit_free:
-	kfree(cpu_clamping_mask);
+	bitmap_free(cpu_clamping_mask);
 	return retval;
 }
 module_init(powerclamp_init);
@@ -764,7 +762,7 @@ static void __exit powerclamp_exit(void)
 	cpuhp_remove_state_nocalls(hp_state);
 	free_percpu(worker_data);
 	thermal_cooling_device_unregister(cooling_dev);
-	kfree(cpu_clamping_mask);
+	bitmap_free(cpu_clamping_mask);
 
 	cancel_delayed_work_sync(&poll_pkg_cstate_work);
 	debugfs_remove_recursive(debug_dir);
-- 
2.30.2

