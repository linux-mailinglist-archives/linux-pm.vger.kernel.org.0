Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920B52A240B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 06:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgKBFVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 00:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKBFVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 00:21:51 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A85C0617A6
        for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2020 21:21:51 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id z3so3696322pfz.6
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 21:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SN8bYxSdkigCEEdTUoVtcPHjy2/GSlL+rkbq+IMRWrA=;
        b=SLJrR4/Zm0U+gkJ7TFiR91FqKxoLXv21ITOr2Uahf20EOjrOKJEhCcoskUmnvy+PCK
         R07y1lyS71ZJ189nLdieoQK+bRcOvpCAuXQnh+HTZTWOjF8eO1rQwQRFNjSEy2NYteqC
         NXkGUeTIycRLAHYuUiH0pC41frvt0sHa5mJgrJQxiy1m3Jj7RvUqvwhq8gDkmG7Dj7fq
         RP1KPe5O/qiihOaiUVwLOaYrDwF/z94V50qMg7X7DR2Te3QTeSiZ1CAUJJkdMq94dDaQ
         ktEZAbyBKwy0jTkT99+A7xI9k2qBWWvTxfce9h0pe7WN+VBjS2zcrlM5qQghx6EoePfK
         PhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SN8bYxSdkigCEEdTUoVtcPHjy2/GSlL+rkbq+IMRWrA=;
        b=SOsBk36vRYIxISAMMf4F8iThrwL3nggioIYHg3WFIhROya4gSMLpNbygMg2Z0wuDGB
         C7L7H/ULcngNKnMtnvXhcBZpwC8kOUqXjDs2cneQyod1hV4pHuUsq5V+yifTrUbZP0Tq
         cfZ9lcNpTgBXfDHTPR9+tYpp04ZAb/YL9VO8SeZSJ8I74xkQ2iXPXL/8UmwPTi5OvT9f
         MnPqFIrOmHgE4bPZAa4D/UCNtPrOlVwncrvxrppOuSdDNyTNaDz1cziBLdYN4RfHpy+B
         Pt7FTT0MYKRzSr3+RRv5eYse9OTNx8pgJAbNVqVMBs0ThuZlkBgZwteadBTVCBw0tUWv
         C0cA==
X-Gm-Message-State: AOAM532T6yKDEVvmxNsXdeEI5Y8vvz36bAkssd7cdxQoMKe2wNwxii+9
        wrxyBVW4pnxxAQTJoE+8zrJZoA3JqhSgZg==
X-Google-Smtp-Source: ABdhPJxAVCo9XhvmPBJkK4DhDuzzi6kYuhqs7hDqk/WPNf+tg2BkGSyV6q0foKeCkCSp75ecI/cVhA==
X-Received: by 2002:a17:90a:5b02:: with SMTP id o2mr15112647pji.221.1604294511312;
        Sun, 01 Nov 2020 21:21:51 -0800 (PST)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 21sm3396343pfw.105.2020.11.01.21.21.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 21:21:50 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, robdclark@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] opp: Allocate the OPP table outside of opp_table_lock
Date:   Mon,  2 Nov 2020 10:51:39 +0530
Message-Id: <836b442002d598437e3e6b56d3e07087e5c08afd.1604294460.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <ef43f01ac06976b2aa2b17266d307bb1a4f7e6f9.1604294460.git.viresh.kumar@linaro.org>
References: <ef43f01ac06976b2aa2b17266d307bb1a4f7e6f9.1604294460.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no critical section which needs protection with locks while
allocating an OPP table, except while adding it to the opp_tables list.
And taking the opp_table_lock for the entire duration causes circular
dependency issues like the one mentioned below.  This patch takes
another approach to reduce the size of the critical section to avoid
such issues, the details of that are present within the patch.

 ======================================================
 WARNING: possible circular locking dependency detected
 5.4.72 #14 Not tainted
 ------------------------------------------------------
 chrome/1865 is trying to acquire lock:
 ffffffdd34921750 (opp_table_lock){+.+.}, at: _find_opp_table+0x34/0x74

 but task is already holding lock:
 ffffff81f0fc71a8 (reservation_ww_class_mutex){+.+.}, at: submit_lock_objects+0x70/0x1ec

 fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-ce"
 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:
 -> #4 (reservation_ww_class_mutex){+.+.}:
        __mutex_lock_common+0xec/0xc0c
        ww_mutex_lock_interruptible+0x5c/0xc4
        msm_gem_fault+0x2c/0x124
        __do_fault+0x40/0x16c
        handle_mm_fault+0x7cc/0xd98
        do_page_fault+0x230/0x3b4
        do_translation_fault+0x5c/0x78
        do_mem_abort+0x4c/0xb4
        el0_da+0x1c/0x20
 -> #3 (&mm->mmap_sem){++++}:
        __might_fault+0x70/0x98
        compat_filldir+0xf8/0x48c
        dcache_readdir+0x70/0x1dc
        iterate_dir+0xd4/0x180
        __arm64_compat_sys_getdents+0xa0/0x19c
        el0_svc_common+0xa8/0x178
        el0_svc_compat_handler+0x2c/0x40
        el0_svc_compat+0x8/0x10
 -> #2 (&sb->s_type->i_mutex_key#3){++++}:
        down_write+0x54/0x16c
        start_creating+0x68/0x128
        debugfs_create_dir+0x28/0x114
        opp_debug_register+0x8c/0xc0
        _add_opp_dev_unlocked+0x5c/0x70
        _add_opp_dev+0x38/0x58
        _opp_get_opp_table+0xdc/0x1ac
        dev_pm_opp_get_opp_table_indexed+0x24/0x30
        dev_pm_opp_of_add_table_indexed+0x48/0x84
        of_genpd_add_provider_onecell+0xc0/0x1b8
        rpmhpd_probe+0x240/0x268
        platform_drv_probe+0x90/0xb0
        really_probe+0x134/0x2ec
        driver_probe_device+0x64/0xfc
        __device_attach_driver+0x8c/0xa4
        bus_for_each_drv+0x90/0xd8
        __device_attach+0xc0/0x148
        device_initial_probe+0x20/0x2c
        bus_probe_device+0x34/0x94
        device_add+0x1fc/0x3b0
        of_device_add+0x3c/0x4c
        of_platform_device_create_pdata+0xb8/0xfc
        of_platform_bus_create+0x1e4/0x368
        of_platform_populate+0x70/0xbc
        devm_of_platform_populate+0x58/0xa0
        rpmh_rsc_probe+0x36c/0x3cc
        platform_drv_probe+0x90/0xb0
        really_probe+0x134/0x2ec
        driver_probe_device+0x64/0xfc
        __device_attach_driver+0x8c/0xa4
        bus_for_each_drv+0x90/0xd8
        __device_attach+0xc0/0x148
        device_initial_probe+0x20/0x2c
        bus_probe_device+0x34/0x94
        device_add+0x1fc/0x3b0
        of_device_add+0x3c/0x4c
        of_platform_device_create_pdata+0xb8/0xfc
        of_platform_bus_create+0x1e4/0x368
        of_platform_bus_create+0x230/0x368
        of_platform_populate+0x70/0xbc
        of_platform_default_populate_init+0xa8/0xc0
        do_one_initcall+0x1c8/0x3fc
        do_initcall_level+0xb4/0x10c
        do_basic_setup+0x30/0x48
        kernel_init_freeable+0x124/0x1a4
        kernel_init+0x14/0x104
        ret_from_fork+0x10/0x18
 -> #1 (&opp_table->lock){+.+.}:
        __mutex_lock_common+0xec/0xc0c
        mutex_lock_nested+0x40/0x50
        _add_opp_dev+0x2c/0x58
        _opp_get_opp_table+0xdc/0x1ac
        dev_pm_opp_get_opp_table_indexed+0x24/0x30
        dev_pm_opp_of_add_table_indexed+0x48/0x84
        of_genpd_add_provider_onecell+0xc0/0x1b8
        rpmhpd_probe+0x240/0x268
        platform_drv_probe+0x90/0xb0
        really_probe+0x134/0x2ec
        driver_probe_device+0x64/0xfc
        __device_attach_driver+0x8c/0xa4
        bus_for_each_drv+0x90/0xd8
        __device_attach+0xc0/0x148
        device_initial_probe+0x20/0x2c
        bus_probe_device+0x34/0x94
        device_add+0x1fc/0x3b0
        of_device_add+0x3c/0x4c
        of_platform_device_create_pdata+0xb8/0xfc
        of_platform_bus_create+0x1e4/0x368
        of_platform_populate+0x70/0xbc
        devm_of_platform_populate+0x58/0xa0
        rpmh_rsc_probe+0x36c/0x3cc
        platform_drv_probe+0x90/0xb0
        really_probe+0x134/0x2ec
        driver_probe_device+0x64/0xfc
        __device_attach_driver+0x8c/0xa4
        bus_for_each_drv+0x90/0xd8
        __device_attach+0xc0/0x148
        device_initial_probe+0x20/0x2c
        bus_probe_device+0x34/0x94
        device_add+0x1fc/0x3b0
        of_device_add+0x3c/0x4c
        of_platform_device_create_pdata+0xb8/0xfc
        of_platform_bus_create+0x1e4/0x368
        of_platform_populate+0x70/0xbc
        devm_of_platform_populate+0x58/0xa0
        rpmh_rsc_probe+0x36c/0x3cc
        platform_drv_probe+0x90/0xb0
        really_probe+0x134/0x2ec
        driver_probe_device+0x64/0xfc
        __device_attach_driver+0x8c/0xa4
        bus_for_each_drv+0x90/0xd8
        __device_attach+0xc0/0x148
        device_initial_probe+0x20/0x2c
        bus_probe_device+0x34/0x94
        device_add+0x1fc/0x3b0
        of_device_add+0x3c/0x4c
        of_platform_device_create_pdata+0xb8/0xfc
        of_platform_bus_create+0x1e4/0x368
        of_platform_bus_create+0x230/0x368
        of_platform_populate+0x70/0xbc
        of_platform_default_populate_init+0xa8/0xc0
        do_one_initcall+0x1c8/0x3fc
        do_initcall_level+0xb4/0x10c
        do_basic_setup+0x30/0x48
        kernel_init_freeable+0x124/0x1a4
        kernel_init+0x14/0x104
        ret_from_fork+0x10/0x18
 -> #0 (opp_table_lock){+.+.}:
        __lock_acquire+0xee4/0x2450
        lock_acquire+0x1cc/0x210
        __mutex_lock_common+0xec/0xc0c
        mutex_lock_nested+0x40/0x50
        _find_opp_table+0x34/0x74
        dev_pm_opp_find_freq_exact+0x2c/0xdc
        a6xx_gmu_resume+0xc8/0xecc
        a6xx_pm_resume+0x148/0x200
        adreno_resume+0x28/0x34
        pm_generic_runtime_resume+0x34/0x48
        __rpm_callback+0x70/0x10c
        rpm_callback+0x34/0x8c
        rpm_resume+0x414/0x550
        __pm_runtime_resume+0x7c/0xa0
        msm_gpu_submit+0x60/0x1c0
        msm_ioctl_gem_submit+0xadc/0xb60
        drm_ioctl_kernel+0x9c/0x118
        drm_ioctl+0x27c/0x408
        drm_compat_ioctl+0xcc/0xdc
        __se_compat_sys_ioctl+0x100/0x206c
        __arm64_compat_sys_ioctl+0x20/0x2c
        el0_svc_common+0xa8/0x178
        el0_svc_compat_handler+0x2c/0x40
        el0_svc_compat+0x8/0x10
 other info that might help us debug this:
 Chain exists of: opp_table_lock --> &mm->mmap_sem --> reservation_ww_class_mutex
  Possible unsafe locking scenario:
        CPU0                    CPU1
        ----                    ----
   lock(reservation_ww_class_mutex);
                                lock(&mm->mmap_sem);
                                lock(reservation_ww_class_mutex);
   lock(opp_table_lock);

 *** DEADLOCK ***

 3 locks held by chrome/1865:
  #0: ffffff81edecc0d8 (&dev->struct_mutex){+.+.}, at: msm_ioctl_gem_submit+0x264/0xb60
  #1: ffffff81d0000870 (reservation_ww_class_acquire){+.+.}, at: msm_ioctl_gem_submit+0x8e8/0xb60
  #2: ffffff81f0fc71a8 (reservation_ww_class_mutex){+.+.}, at: submit_lock_objects+0x70/0x1ec
 stack backtrace:
 CPU: 0 PID: 1865 Comm: chrome Not tainted 5.4.72 #14
 Hardware name: Google Lazor (rev1+) with LTE (DT)
 Call trace:
  dump_backtrace+0x0/0x158
  show_stack+0x20/0x2c
  dump_stack+0xc8/0x160
  print_circular_bug+0x2c4/0x2c8
  check_noncircular+0x1a8/0x1b0
  __lock_acquire+0xee4/0x2450
  lock_acquire+0x1cc/0x210
  __mutex_lock_common+0xec/0xc0c
  mutex_lock_nested+0x40/0x50
  _find_opp_table+0x34/0x74
  dev_pm_opp_find_freq_exact+0x2c/0xdc
  a6xx_gmu_resume+0xc8/0xecc
  a6xx_pm_resume+0x148/0x200
  adreno_resume+0x28/0x34
  pm_generic_runtime_resume+0x34/0x48
  __rpm_callback+0x70/0x10c
  rpm_callback+0x34/0x8c
  rpm_resume+0x414/0x550
  __pm_runtime_resume+0x7c/0xa0
  msm_gpu_submit+0x60/0x1c0
  msm_ioctl_gem_submit+0xadc/0xb60
  drm_ioctl_kernel+0x9c/0x118
  drm_ioctl+0x27c/0x408
  drm_compat_ioctl+0xcc/0xdc
  __se_compat_sys_ioctl+0x100/0x206c
  __arm64_compat_sys_ioctl+0x20/0x2c
  el0_svc_common+0xa8/0x178
  el0_svc_compat_handler+0x2c/0x40
  el0_svc_compat+0x8/0x10

Reported-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 47 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 84035ab8bb31..6f4a73a6391f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -29,6 +29,8 @@
 LIST_HEAD(opp_tables);
 /* Lock to allow exclusive modification to the device and opp lists */
 DEFINE_MUTEX(opp_table_lock);
+/* Flag indicating that opp_tables list is being updated at the moment */
+static bool opp_tables_busy;
 
 static struct opp_device *_find_opp_dev(const struct device *dev,
 					struct opp_table *opp_table)
@@ -1111,8 +1113,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
 
-	/* Secure the device table modification */
-	list_add(&opp_table->node, &opp_tables);
 	return opp_table;
 
 err:
@@ -1125,27 +1125,64 @@ void _get_opp_table_kref(struct opp_table *opp_table)
 	kref_get(&opp_table->kref);
 }
 
+/*
+ * We need to make sure that the OPP table for a device doesn't get added twice,
+ * if this routine gets called in parallel with the same device pointer.
+ *
+ * The simplest way to enforce that is to perform everything (find existing
+ * table and if not found, create a new one) under the opp_table_lock, so only
+ * one creator gets access to the same. But that expands the critical section
+ * under the lock and may end up causing circular dependencies with frameworks
+ * like debugfs, interconnect or clock framework as they may be direct or
+ * indirect users of OPP core.
+ *
+ * And for that reason we have to go for a bit tricky implementation here, which
+ * uses the opp_tables_busy flag to indicate if another creator is in the middle
+ * of adding an OPP table and others should wait for it to finish.
+ */
 static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 
-	/* Hold our table modification lock here */
+again:
 	mutex_lock(&opp_table_lock);
 
 	opp_table = _find_opp_table_unlocked(dev);
 	if (!IS_ERR(opp_table))
 		goto unlock;
 
+	/*
+	 * The opp_tables list or an OPP table's dev_list is getting updated by
+	 * another user, wait for it to finish.
+	 */
+	if (unlikely(opp_tables_busy)) {
+		mutex_unlock(&opp_table_lock);
+		cpu_relax();
+		goto again;
+	}
+
+	opp_tables_busy = true;
 	opp_table = _managed_opp(dev, index);
+
+	/* Drop the lock to reduce the size of critical section */
+	mutex_unlock(&opp_table_lock);
+
 	if (opp_table) {
 		if (!_add_opp_dev(dev, opp_table)) {
 			dev_pm_opp_put_opp_table(opp_table);
 			opp_table = ERR_PTR(-ENOMEM);
 		}
-		goto unlock;
+
+		mutex_lock(&opp_table_lock);
+	} else {
+		opp_table = _allocate_opp_table(dev, index);
+
+		mutex_lock(&opp_table_lock);
+		if (!IS_ERR(opp_table))
+			list_add(&opp_table->node, &opp_tables);
 	}
 
-	opp_table = _allocate_opp_table(dev, index);
+	opp_tables_busy = false;
 
 unlock:
 	mutex_unlock(&opp_table_lock);
-- 
2.25.0.rc1.19.g042ed3e048af

