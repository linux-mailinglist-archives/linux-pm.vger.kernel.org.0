Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86792A497E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgKCPYx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:24:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:51622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgKCPWw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:22:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E6A9AE53;
        Tue,  3 Nov 2020 15:22:50 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 3/5] kernel/power: allow hibernation with page_poison sanity checking
Date:   Tue,  3 Nov 2020 16:22:35 +0100
Message-Id: <20201103152237.9853-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201103152237.9853-1-vbabka@suse.cz>
References: <20201103152237.9853-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Page poisoning used to be incompatible with hibernation, as the state of
poisoned pages was lost after resume, thus enabling CONFIG_HIBERNATION forces
CONFIG_PAGE_POISONING_NO_SANITY. For the same reason, the poisoning with zeroes
variant CONFIG_PAGE_POISONING_ZERO used to disable hibernation. The latter
restriction was removed by commit 1ad1410f632d ("PM / Hibernate: allow
hibernation with PAGE_POISONING_ZERO") and similarly for init_on_free by commit
18451f9f9e58 ("PM: hibernate: fix crashes with init_on_free=1") by making sure
free pages are cleared after resume.

We can use the same mechanism to instead poison free pages with PAGE_POISON
after resume. This covers both zero and 0xAA patterns. Thus we can remove the
Kconfig restriction that disables page poison sanity checking when hibernation
is enabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: <linux-pm@vger.kernel.org>
---
 kernel/power/hibernate.c |  2 +-
 kernel/power/power.h     |  2 +-
 kernel/power/snapshot.c  | 14 ++++++++++----
 mm/Kconfig.debug         |  1 -
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2fc7d509a34f..da0b41914177 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -326,7 +326,7 @@ static int create_image(int platform_mode)
 
 	if (!in_suspend) {
 		events_check_enabled = false;
-		clear_free_pages();
+		clear_or_poison_free_pages();
 	}
 
 	platform_leave(platform_mode);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 24f12d534515..778bf431ec02 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -106,7 +106,7 @@ extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
 extern int hibernate_preallocate_memory(void);
 
-extern void clear_free_pages(void);
+extern void clear_or_poison_free_pages(void);
 
 /**
  *	Auxiliary structure used for reading the snapshot image data and
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 46b1804c1ddf..6b1c84afa891 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1144,7 +1144,7 @@ void free_basic_memory_bitmaps(void)
 	pr_debug("Basic memory bitmaps freed\n");
 }
 
-void clear_free_pages(void)
+void clear_or_poison_free_pages(void)
 {
 	struct memory_bitmap *bm = free_pages_map;
 	unsigned long pfn;
@@ -1152,12 +1152,18 @@ void clear_free_pages(void)
 	if (WARN_ON(!(free_pages_map)))
 		return;
 
-	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
+	if (page_poisoning_enabled() || want_init_on_free()) {
 		memory_bm_position_reset(bm);
 		pfn = memory_bm_next_pfn(bm);
 		while (pfn != BM_END_OF_MAP) {
-			if (pfn_valid(pfn))
-				clear_highpage(pfn_to_page(pfn));
+			if (pfn_valid(pfn)) {
+				struct page *page = pfn_to_page(pfn);
+				if (page_poisoning_enabled_static())
+					kernel_poison_pages(page, 1);
+				else if (want_init_on_free())
+					clear_highpage(page);
+
+			}
 
 			pfn = memory_bm_next_pfn(bm);
 		}
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 864f129f1937..c57786ad5be9 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -64,7 +64,6 @@ config PAGE_OWNER
 
 config PAGE_POISONING
 	bool "Poison pages after freeing"
-	select PAGE_POISONING_NO_SANITY if HIBERNATION
 	help
 	  Fill the pages with poison patterns after free_pages() and verify
 	  the patterns before alloc_pages. The filling of the memory helps
-- 
2.29.1

