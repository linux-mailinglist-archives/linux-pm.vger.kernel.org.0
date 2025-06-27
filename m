Return-Path: <linux-pm+bounces-29642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1290AEB0C1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 09:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5517D1894D39
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB822C339;
	Fri, 27 Jun 2025 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYDWq6UH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F89226D1D;
	Fri, 27 Jun 2025 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011141; cv=none; b=i9hdNMxyR47XLTsekn8OjZ2LIRpndAhXTWWYPB/eBbB12i/fmTHrpFABmgepjPBgB7nPOlVDeoAOC0I5Ed5YtkYzUlydGCfXbYWUlesKjS8kUa+dwGfrh6+zGv3VRUnjSrua+DwU4lS+313NdM//e8XL1cuQa9OJOCbWjYxDZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011141; c=relaxed/simple;
	bh=bNv9x2a1Aunm5ZSWXJBFJN6QRl0vJZ4f6hRPK0EsSuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KEA3YGNrtqKMaU7HrwDw73UX5FZpD9Kxb6YjQqA5cq6N/CgdC6L4LdssK5fXaxqtkSxJCYdCEkC0SlWwy5h7JALVRKSXOA4Kjs4jwHi8VJRe2w+9cRCYCe5KME0y7XFyW8xQ0pBlA1Ppfw5psab+BbUdUt3bfpEVODAoL5/tH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYDWq6UH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2985BC4CEE3;
	Fri, 27 Jun 2025 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751011141;
	bh=bNv9x2a1Aunm5ZSWXJBFJN6QRl0vJZ4f6hRPK0EsSuw=;
	h=From:To:Cc:Subject:Date:From;
	b=UYDWq6UH8RKYlO7dz6BlumOPIvypvezTUD0EgdvCirg0XAK8icxMlWBFmUlFjulKB
	 A0g7ViIf9D+F0oVGrj51VejHw92lJTDZ6TEsHxlou5tYBaAnMXIod49o0UaffJBO+l
	 fbGFqWLq44KRYyMh20JCBWs7aW2QFvziULxilKr96cyrrT32d92Dp1thDNd/nzkEeK
	 rdJ3AUdz7vWUqAy+udLRLouuRA1shF0UTe/ik00KMtdT0P1optid51sCE8xCQC1uO7
	 GD9wAHphiyOtSSIRKrr+aMMy2PM9nxRp3tRqLnVDEs15N0HLlyN+cO/u8UgzRqxqUy
	 k0rQ4u9rURr4Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uV3zA-0000000070q-2Es8;
	Fri, 27 Jun 2025 09:59:01 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Gabor Juhos <j4g8y7@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v4] interconnect: avoid memory allocation when 'icc_bw_lock' is held
Date: Fri, 27 Jun 2025 09:58:54 +0200
Message-ID: <20250627075854.26943-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabor Juhos <j4g8y7@gmail.com>

The 'icc_bw_lock' mutex is introduced in commit af42269c3523
("interconnect: Fix locking for runpm vs reclaim") in order to decouple
serialization of bw aggregation from codepaths that require memory
allocation.

However commit d30f83d278a9 ("interconnect: core: Add dynamic id
allocation support") added a devm_kasprintf() call into a path protected
by the 'icc_bw_lock' which causes the following lockdep warning on
machines like the Lenovo ThinkPad X13s:

    ======================================================
    WARNING: possible circular locking dependency detected
    6.16.0-rc3 #15 Not tainted
    ------------------------------------------------------
    (udev-worker)/342 is trying to acquire lock:
    ffffb973f7ec4638 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_node_track_caller_noprof+0xa0/0x3e0

    but task is already holding lock:
    ffffb973f7f7f0e8 (icc_bw_lock){+.+.}-{4:4}, at: icc_node_add+0x44/0x154

    which lock already depends on the new lock.

    the existing dependency chain (in reverse order) is:

    -> #1 (icc_bw_lock){+.+.}-{4:4}:
           icc_init+0x48/0x108
           do_one_initcall+0x64/0x30c
           kernel_init_freeable+0x27c/0x500
           kernel_init+0x20/0x1d8
           ret_from_fork+0x10/0x20

    -> #0 (fs_reclaim){+.+.}-{0:0}:
           __lock_acquire+0x136c/0x2114
           lock_acquire+0x1c8/0x354
           fs_reclaim_acquire+0x74/0xa8
           __kmalloc_node_track_caller_noprof+0xa0/0x3e0
           devm_kmalloc+0x54/0x124
           devm_kvasprintf+0x74/0xd4
           devm_kasprintf+0x58/0x80
           icc_node_add+0xb4/0x154
           qcom_osm_l3_probe+0x20c/0x314 [icc_osm_l3]
           platform_probe+0x68/0xd8
           really_probe+0xc0/0x38c
           __driver_probe_device+0x7c/0x160
           driver_probe_device+0x40/0x110
           __driver_attach+0xfc/0x208
           bus_for_each_dev+0x74/0xd0
           driver_attach+0x24/0x30
           bus_add_driver+0x110/0x234
           driver_register+0x60/0x128
           __platform_driver_register+0x24/0x30
           osm_l3_driver_init+0x20/0x1000 [icc_osm_l3]
           do_one_initcall+0x64/0x30c
           do_init_module+0x58/0x23c
           load_module+0x1df8/0x1f70
           init_module_from_file+0x88/0xc4
           idempotent_init_module+0x188/0x280
           __arm64_sys_finit_module+0x6c/0xd8
           invoke_syscall+0x48/0x110
           el0_svc_common.constprop.0+0xc0/0xe0
           do_el0_svc+0x1c/0x28
           el0_svc+0x4c/0x158
           el0t_64_sync_handler+0xc8/0xcc
           el0t_64_sync+0x198/0x19c

    other info that might help us debug this:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(icc_bw_lock);
                                   lock(fs_reclaim);
                                   lock(icc_bw_lock);
      lock(fs_reclaim);

     *** DEADLOCK ***

The icc_node_add() functions is not designed to fail, and as such it
should not do any memory allocation. In order to avoid this, add a new
helper function for the name generation to be called by drivers which
are using the new dynamic id feature.

Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Link: https://lore.kernel.org/r/20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com
Co-developed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

As Gabor pointed out, the reason he hit this on the IPQ9574 in the first
place is due to a separate bug which is being fixed here:

	https://lore.kernel.org/all/20250625-icc-dyn-id-fix-v1-1-127cb5498449@gmail.com/

Note that this one (along with the IPQ fix) should go into 6.16-final
since this fixes a regression in 6.16-rc1 that prevents lockdep from
being used on a number of Qualcomm platforms (and which risks
introducing further locking issues).

Johan


Changes in v4:
 - make sure to generate a name also for pre-allocated rpmh nodes
 - add icc_node_set_name() helper
 - do not use devres to allocate name
 - use osm-l3 lockdep splat as example in commit message
 - Link to v3: https://lore.kernel.org/r/20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com
 
Changes in v3:
  - move memory allocation out from the icc_node_add() function directly into
    the users of the dynamic id feature
  - adjust commit description according to the changes
  - Link to v2: https://lore.kernel.org/r/20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com

Changes in v2:
  - move memory allocation outside of icc_lock
  - issue a warning and return without modifying the node name in case of
    memory allocation failure, and adjust the commit description
  - remove offered tags from Johan and Bryan
    Note: since I was not sure that that the added WARN_ON() is a substantial
    change or not, I have removed the offered tags intentionally to be on the
    safe side
  - Link to v1: https://lore.kernel.org/r/20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com
  

 drivers/interconnect/core.c           | 29 +++++++++++++++++++++++----
 drivers/interconnect/qcom/icc-rpmh.c  |  7 ++++++-
 drivers/interconnect/qcom/osm-l3.c    |  7 ++++++-
 include/linux/interconnect-provider.h |  6 ++++++
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1a41e59c77f8..fdfc755bbd43 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -906,10 +906,35 @@ void icc_node_destroy(int id)
 		return;
 
 	kfree(node->links);
+	if (node->id >= ICC_DYN_ID_START)
+		kfree(node->name);
 	kfree(node);
 }
 EXPORT_SYMBOL_GPL(icc_node_destroy);
 
+/**
+ * icc_node_set_name() - set node name
+ * @node: node
+ * @provider: node provider
+ * @name: node name
+ *
+ * Return: 0 on success, or -ENOMEM on allocation failure
+ */
+int icc_node_set_name(struct icc_node *node, const struct icc_provider *provider, const char *name)
+{
+	if (node->id >= ICC_DYN_ID_START) {
+		node->name = kasprintf(GFP_KERNEL, "%s@%s", name,
+				       dev_name(provider->dev));
+		if (!node->name)
+			return -ENOMEM;
+	} else {
+		node->name = name;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_node_set_name);
+
 /**
  * icc_link_nodes() - create link between two nodes
  * @src_node: source node
@@ -1038,10 +1063,6 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
 
-	if (node->id >= ICC_DYN_ID_START)
-		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
-					    node->name, dev_name(provider->dev));
-
 	if (node->avg_bw || node->peak_bw) {
 		if (provider->pre_aggregate)
 			provider->pre_aggregate(node);
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 41bfc6e7ee1d..001404e91041 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -293,7 +293,12 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 			goto err_remove_nodes;
 		}
 
-		node->name = qn->name;
+		ret = icc_node_set_name(node, provider, qn->name);
+		if (ret) {
+			icc_node_destroy(node->id);
+			goto err_remove_nodes;
+		}
+
 		node->data = qn;
 		icc_node_add(node, provider);
 
diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index baecbf2533f7..b33f00da1880 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -236,7 +236,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 			goto err;
 		}
 
-		node->name = qnodes[i]->name;
+		ret = icc_node_set_name(node, provider, qnodes[i]->name);
+		if (ret) {
+			icc_node_destroy(node->id);
+			goto err;
+		}
+
 		/* Cast away const and add it back in qcom_osm_l3_set() */
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 55cfebc658e6..37093b6e1af9 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -119,6 +119,7 @@ int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 struct icc_node *icc_node_create_dyn(void);
 struct icc_node *icc_node_create(int id);
 void icc_node_destroy(int id);
+int icc_node_set_name(struct icc_node *node, const struct icc_provider *provider, const char *name);
 int icc_link_nodes(struct icc_node *src_node, struct icc_node **dst_node);
 int icc_link_create(struct icc_node *node, const int dst_id);
 void icc_node_add(struct icc_node *node, struct icc_provider *provider);
@@ -152,6 +153,11 @@ static inline void icc_node_destroy(int id)
 {
 }
 
+static int icc_node_set_name(struct icc_node *node, const struct icc_provider *provider, const char *name)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int icc_link_nodes(struct icc_node *src_node, struct icc_node **dst_node)
 {
 	return -EOPNOTSUPP;
-- 
2.49.0


