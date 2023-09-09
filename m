Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1ED7995BE
	for <lists+linux-pm@lfdr.de>; Sat,  9 Sep 2023 03:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbjIIBhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Sep 2023 21:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbjIIBhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2023 21:37:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8115E1FE5;
        Fri,  8 Sep 2023 18:37:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59965C433BD;
        Sat,  9 Sep 2023 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220014;
        bh=mR+drSSKE0Y38m8f78bf3Ed0bn2vLce6QEIF311fB2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWNPgcKJ2p1bBGxGXUj05UQSY8z3pq97j5RcegnW3hFWz517nDdQc105swv3aPLnC
         Re+daCH6PCOm1tV4ATyH4AiBuTb7IL+53EkRvOoDGV6Td9ISC3kKnhvQp2QySONKcM
         KSDq4YWjbeTOkXKjZ9oIaYr5L5P0iw8m3Lhuz4zm24pG2tEmM4I0ipJGOHxsCcPHG1
         RqDFQKQ3eSU2S71egKkjLKXFzjOV6sWGhbXv2+1HSsq/dxYkhHz+jFlQhacMsPn4z/
         sKrxvpx3KR/UWBddwTAM+IohUJ24+Lf7Ptbt76TfxzVrt8lRgB5O8y4C9AtD6qioBo
         vPPjGwa30N2tQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/16] interconnect: Fix locking for runpm vs reclaim
Date:   Fri,  8 Sep 2023 20:39:41 -0400
Message-Id: <20230909003941.3580631-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003941.3580631-1-sashal@kernel.org>
References: <20230909003941.3580631-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit af42269c3523492d71ebbe11fefae2653e9cdc78 ]

For cases where icc_bw_set() can be called in callbaths that could
deadlock against shrinker/reclaim, such as runpm resume, we need to
decouple the icc locking.  Introduce a new icc_bw_lock for cases where
we need to serialize bw aggregation and update to decouple that from
paths that require memory allocation such as node/link creation/
destruction.

Fixes this lockdep splat:

   ======================================================
   WARNING: possible circular locking dependency detected
   6.2.0-rc8-debug+ #554 Not tainted
   ------------------------------------------------------
   ring0/132 is trying to acquire lock:
   ffffff80871916d0 (&gmu->lock){+.+.}-{3:3}, at: a6xx_pm_resume+0xf0/0x234

   but task is already holding lock:
   ffffffdb5aee57e8 (dma_fence_map){++++}-{0:0}, at: msm_job_run+0x68/0x150

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #4 (dma_fence_map){++++}-{0:0}:
          __dma_fence_might_wait+0x74/0xc0
          dma_resv_lockdep+0x1f4/0x2f4
          do_one_initcall+0x104/0x2bc
          kernel_init_freeable+0x344/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #3 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
          fs_reclaim_acquire+0x80/0xa8
          slab_pre_alloc_hook.constprop.0+0x40/0x25c
          __kmem_cache_alloc_node+0x60/0x1cc
          __kmalloc+0xd8/0x100
          topology_parse_cpu_capacity+0x8c/0x178
          get_cpu_for_node+0x88/0xc4
          parse_cluster+0x1b0/0x28c
          parse_cluster+0x8c/0x28c
          init_cpu_topology+0x168/0x188
          smp_prepare_cpus+0x24/0xf8
          kernel_init_freeable+0x18c/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #2 (fs_reclaim){+.+.}-{0:0}:
          __fs_reclaim_acquire+0x3c/0x48
          fs_reclaim_acquire+0x54/0xa8
          slab_pre_alloc_hook.constprop.0+0x40/0x25c
          __kmem_cache_alloc_node+0x60/0x1cc
          __kmalloc+0xd8/0x100
          kzalloc.constprop.0+0x14/0x20
          icc_node_create_nolock+0x4c/0xc4
          icc_node_create+0x38/0x58
          qcom_icc_rpmh_probe+0x1b8/0x248
          platform_probe+0x70/0xc4
          really_probe+0x158/0x290
          __driver_probe_device+0xc8/0xe0
          driver_probe_device+0x44/0x100
          __driver_attach+0xf8/0x108
          bus_for_each_dev+0x78/0xc4
          driver_attach+0x2c/0x38
          bus_add_driver+0xd0/0x1d8
          driver_register+0xbc/0xf8
          __platform_driver_register+0x30/0x3c
          qnoc_driver_init+0x24/0x30
          do_one_initcall+0x104/0x2bc
          kernel_init_freeable+0x344/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #1 (icc_lock){+.+.}-{3:3}:
          __mutex_lock+0xcc/0x3c8
          mutex_lock_nested+0x30/0x44
          icc_set_bw+0x88/0x2b4
          _set_opp_bw+0x8c/0xd8
          _set_opp+0x19c/0x300
          dev_pm_opp_set_opp+0x84/0x94
          a6xx_gmu_resume+0x18c/0x804
          a6xx_pm_resume+0xf8/0x234
          adreno_runtime_resume+0x2c/0x38
          pm_generic_runtime_resume+0x30/0x44
          __rpm_callback+0x15c/0x174
          rpm_callback+0x78/0x7c
          rpm_resume+0x318/0x524
          __pm_runtime_resume+0x78/0xbc
          adreno_load_gpu+0xc4/0x17c
          msm_open+0x50/0x120
          drm_file_alloc+0x17c/0x228
          drm_open_helper+0x74/0x118
          drm_open+0xa0/0x144
          drm_stub_open+0xd4/0xe4
          chrdev_open+0x1b8/0x1e4
          do_dentry_open+0x2f8/0x38c
          vfs_open+0x34/0x40
          path_openat+0x64c/0x7b4
          do_filp_open+0x54/0xc4
          do_sys_openat2+0x9c/0x100
          do_sys_open+0x50/0x7c
          __arm64_sys_openat+0x28/0x34
          invoke_syscall+0x8c/0x128
          el0_svc_common.constprop.0+0xa0/0x11c
          do_el0_svc+0xac/0xbc
          el0_svc+0x48/0xa0
          el0t_64_sync_handler+0xac/0x13c
          el0t_64_sync+0x190/0x194

   -> #0 (&gmu->lock){+.+.}-{3:3}:
          __lock_acquire+0xe00/0x1060
          lock_acquire+0x1e0/0x2f8
          __mutex_lock+0xcc/0x3c8
          mutex_lock_nested+0x30/0x44
          a6xx_pm_resume+0xf0/0x234
          adreno_runtime_resume+0x2c/0x38
          pm_generic_runtime_resume+0x30/0x44
          __rpm_callback+0x15c/0x174
          rpm_callback+0x78/0x7c
          rpm_resume+0x318/0x524
          __pm_runtime_resume+0x78/0xbc
          pm_runtime_get_sync.isra.0+0x14/0x20
          msm_gpu_submit+0x58/0x178
          msm_job_run+0x78/0x150
          drm_sched_main+0x290/0x370
          kthread+0xf0/0x100
          ret_from_fork+0x10/0x20

   other info that might help us debug this:

   Chain exists of:
     &gmu->lock --> mmu_notifier_invalidate_range_start --> dma_fence_map

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(dma_fence_map);
                                  lock(mmu_notifier_invalidate_range_start);
                                  lock(dma_fence_map);
     lock(&gmu->lock);

    *** DEADLOCK ***

   2 locks held by ring0/132:
    #0: ffffff8087191170 (&gpu->lock){+.+.}-{3:3}, at: msm_job_run+0x64/0x150
    #1: ffffffdb5aee57e8 (dma_fence_map){++++}-{0:0}, at: msm_job_run+0x68/0x150

   stack backtrace:
   CPU: 7 PID: 132 Comm: ring0 Not tainted 6.2.0-rc8-debug+ #554
   Hardware name: Google Lazor (rev1 - 2) with LTE (DT)
   Call trace:
    dump_backtrace.part.0+0xb4/0xf8
    show_stack+0x20/0x38
    dump_stack_lvl+0x9c/0xd0
    dump_stack+0x18/0x34
    print_circular_bug+0x1b4/0x1f0
    check_noncircular+0x78/0xac
    __lock_acquire+0xe00/0x1060
    lock_acquire+0x1e0/0x2f8
    __mutex_lock+0xcc/0x3c8
    mutex_lock_nested+0x30/0x44
    a6xx_pm_resume+0xf0/0x234
    adreno_runtime_resume+0x2c/0x38
    pm_generic_runtime_resume+0x30/0x44
    __rpm_callback+0x15c/0x174
    rpm_callback+0x78/0x7c
    rpm_resume+0x318/0x524
    __pm_runtime_resume+0x78/0xbc
    pm_runtime_get_sync.isra.0+0x14/0x20
    msm_gpu_submit+0x58/0x178
    msm_job_run+0x78/0x150
    drm_sched_main+0x290/0x370
    kthread+0xf0/0x100
    ret_from_fork+0x10/0x20

Signed-off-by: Rob Clark <robdclark@chromium.org>
Link: https://lore.kernel.org/r/20230807171148.210181-7-robdclark@gmail.com
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 7db6d0fc6ec2e..64d8dcdc41fd8 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -29,6 +29,7 @@ static LIST_HEAD(icc_providers);
 static int providers_count;
 static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
+static DEFINE_MUTEX(icc_bw_lock);
 static struct dentry *icc_debugfs_dir;
 
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
@@ -632,7 +633,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 
-	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 
 	old_avg = path->reqs[0].avg_bw;
 	old_peak = path->reqs[0].peak_bw;
@@ -664,7 +665,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		apply_constraints(path);
 	}
 
-	mutex_unlock(&icc_lock);
+	mutex_unlock(&icc_bw_lock);
 
 	trace_icc_set_bw_end(path, ret);
 
@@ -964,6 +965,7 @@ EXPORT_SYMBOL_GPL(icc_link_destroy);
 void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 {
 	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
@@ -989,6 +991,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1115,6 +1118,7 @@ void icc_sync_state(struct device *dev)
 		return;
 
 	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 	synced_state = true;
 	list_for_each_entry(p, &icc_providers, provider_list) {
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
-- 
2.40.1

