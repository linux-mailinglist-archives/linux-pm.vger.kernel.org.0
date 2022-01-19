Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828F84938E7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jan 2022 11:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbiASKsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jan 2022 05:48:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:18890 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346702AbiASKsN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Jan 2022 05:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642589293; x=1674125293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ab7mpM5ZdJr1IQnypXzl4OjTNXTVYJqZZvCjurNkqxI=;
  b=OUdS1xAAUssjXt5GtfP4CbPRW+CAfZa70jBsK9hSV2MIEc5slv1hFXl/
   6tJKN/UaxG9XN+A0QVT7nyoESDFl19DNqaUT+Aakd99Ehh6B2eBbDZVML
   EJuBakohxkrGso18Y/zthTnUcp1dbZK6YtIcCZ8yBDn0kZU1dIV8Zw1iO
   3jyOWcXfNDrr0FbekgG8poEUMZqvj6s9QsZ7PeALGYBapxX5XcsjgK1QY
   LFayUxf4Tumt1di8HGJLgX1m2o/MS68y4lalqfgoPrfA+qnBYSoSkTtV7
   gjsMPVS6Dvpl16bAgoW9KvYiW/S82+C04FTAJMkRqyOWk/uidnUhmuY0g
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="245235260"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="245235260"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 02:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="625845393"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2022 02:48:11 -0800
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH] x86: Remove register_nosave_region_late()
Date:   Wed, 19 Jan 2022 11:47:51 +0100
Message-Id: <20220119104751.1764414-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is an unused wrapper forcing kmalloc allocation for registering
nosave regions. Also, rename __register_nosave_region() to
register_nosave_region() now that there is no need for disambiguation.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/linux/suspend.h | 11 +----------
 kernel/power/snapshot.c | 21 +++++++--------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5785d909c321..3e8ecdebe601 100644
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
@@ -458,7 +450,6 @@ int pfn_is_nosave(unsigned long pfn);
 int hibernate_quiet_exec(int (*func)(void *data), void *data);
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
-static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
 static inline void swsusp_unset_page_free(struct page *p) {}
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index f7a986078213..330d49937692 100644
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
2.25.1

