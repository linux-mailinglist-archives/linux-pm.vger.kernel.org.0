Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13224A8E6A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Feb 2022 21:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355030AbiBCUhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Feb 2022 15:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355119AbiBCUe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Feb 2022 15:34:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF86C0613E5;
        Thu,  3 Feb 2022 12:34:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C21F961B1D;
        Thu,  3 Feb 2022 20:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231B0C340E8;
        Thu,  3 Feb 2022 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643920442;
        bh=L2abX2J6L4mBx7bs32Xn/5k1qnjftTG1FoPZV+6UUe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ac3t87QGs+aj12vHoThIB86gjTUSu+pkfERTeYTwnfPqdEJ+jU2nHLpir75zrYHIU
         uUmRIdb6Y9GfhqBWhyliUNQXP8UwmJFdIp/Yu+Ghx4hEBow34yOdt9Xw4ULAx5g0w0
         dgltmfRP37fYGimQxAkEGcjZkzCgBwYrBkhfXMCUF3vRnEi/Q7wSXzVvyQjPjk3Pii
         rso9IPNfqYjzBkTuki2XPeeyxG73YOzEzl21YSqSOl/Y7sZpqAXjItF/IPxG4yUSDJ
         x6E5kpXCHSiV4/RYCPdzVvDD3usWC5BoQtqaQlxx0RyTZ8F+CVeMhXXbTVZ4RLyiuE
         nIO4fWdDhNKSw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 34/41] PM: hibernate: Remove register_nosave_region_late()
Date:   Thu,  3 Feb 2022 15:32:38 -0500
Message-Id: <20220203203245.3007-34-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203203245.3007-1-sashal@kernel.org>
References: <20220203203245.3007-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 33569ef3c754a82010f266b7b938a66a3ccf90a4 ]

It is an unused wrapper forcing kmalloc allocation for registering
nosave regions. Also, rename __register_nosave_region() to
register_nosave_region() now that there is no need for disambiguation.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/suspend.h | 11 +----------
 kernel/power/snapshot.c | 21 +++++++--------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8af13ba60c7e4..c1310c571d805 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -430,15 +430,7 @@ struct platform_hibernation_ops {
 
 #ifdef CONFIG_HIBERNATION
 /* kernel/power/snapshot.c */
-extern void __register_nosave_region(unsigned long b, unsigned long e, int km);
-static inline void __init register_nosave_region(unsigned long b, unsigned long e)
-{
-	__register_nosave_region(b, e, 0);
-}
-static inline void __init register_nosave_region_late(unsigned long b, unsigned long e)
-{
-	__register_nosave_region(b, e, 1);
-}
+extern void register_nosave_region(unsigned long b, unsigned long e);
 extern int swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
@@ -457,7 +449,6 @@ int pfn_is_nosave(unsigned long pfn);
 int hibernate_quiet_exec(int (*func)(void *data), void *data);
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
-static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
 static inline void swsusp_unset_page_free(struct page *p) {}
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index f7a9860782135..330d499376924 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -978,8 +978,7 @@ static void memory_bm_recycle(struct memory_bitmap *bm)
  * Register a range of page frames the contents of which should not be saved
  * during hibernation (to be used in the early initialization code).
  */
-void __init __register_nosave_region(unsigned long start_pfn,
-				     unsigned long end_pfn, int use_kmalloc)
+void __init register_nosave_region(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct nosave_region *region;
 
@@ -995,18 +994,12 @@ void __init __register_nosave_region(unsigned long start_pfn,
 			goto Report;
 		}
 	}
-	if (use_kmalloc) {
-		/* During init, this shouldn't fail */
-		region = kmalloc(sizeof(struct nosave_region), GFP_KERNEL);
-		BUG_ON(!region);
-	} else {
-		/* This allocation cannot fail */
-		region = memblock_alloc(sizeof(struct nosave_region),
-					SMP_CACHE_BYTES);
-		if (!region)
-			panic("%s: Failed to allocate %zu bytes\n", __func__,
-			      sizeof(struct nosave_region));
-	}
+	/* This allocation cannot fail */
+	region = memblock_alloc(sizeof(struct nosave_region),
+				SMP_CACHE_BYTES);
+	if (!region)
+		panic("%s: Failed to allocate %zu bytes\n", __func__,
+		      sizeof(struct nosave_region));
 	region->start_pfn = start_pfn;
 	region->end_pfn = end_pfn;
 	list_add_tail(&region->list, &nosave_regions);
-- 
2.34.1

