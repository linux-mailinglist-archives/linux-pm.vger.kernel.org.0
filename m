Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5136F1EA783
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFAQGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 12:06:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55322 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgFAQGs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 12:06:48 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jfmxa-0006sc-Ji
        for linux-pm@vger.kernel.org; Mon, 01 Jun 2020 16:06:46 +0000
Received: by mail-wr1-f70.google.com with SMTP id a4so182797wrp.5
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 09:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeAmA4jTrmNARC3SDWl+jD/pueIRZYDlLrUDy+AkMLI=;
        b=RrFgy7lIkacA+9pPa8nv3A8pVCXD4j9L9SArcO8E0ALQ0h1uDHhCFS4jO/LPm57xCW
         3yFF8s+eEtF5ApiGh3ua1HjRKoTEI6gn+M03LG4/kHLmM/1tzBj/GCWGlav1kWyXsyKv
         /rO7H3qNj48BcK2UhufEIhcheSlE7CeDBG5j0OZaJQ0vnUt9p/glWRzQo28r60wvBKCo
         nD/LXG6deUdzGmjjbgmAXQf0pc113wuMzb8DGINoVGKnAkQFxR6T+u9CrvDldqCN1EJx
         8swMnv6xW4fR1rMqMwMFWVdcdv3KPs3dcyA40TQPnZ924feVqJe6zoIy0PiNwJSl72NZ
         neXQ==
X-Gm-Message-State: AOAM531jA3tO5F9mtlQN4p7kRaflRTtSbLl1oGRgmcWKRoLFBeDa5qtm
        rP42C7fEk8nIOF0ENV8CxoWayoOE5vm2L1CNChtn2crdazwbE0JHbuPgC2yxJX0+B+iVciYSC6K
        nQ3rli7PLonprJA69OGUpVBhNAbYFKtHLWZIq
X-Received: by 2002:a5d:500d:: with SMTP id e13mr24030210wrt.150.1591027606259;
        Mon, 01 Jun 2020 09:06:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+BHxqkANkdUGsMt1WVDpn254B7cTuPi/KBtVflfUw/QH3TY2FO0r0pIcgGqgmYltEFwHOJQ==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr24030186wrt.150.1591027605940;
        Mon, 01 Jun 2020 09:06:45 -0700 (PDT)
Received: from xps-13.homenet.telecomitalia.it (host105-135-dynamic.43-79-r.retail.telecomitalia.it. [79.43.135.105])
        by smtp.gmail.com with ESMTPSA id k16sm19719262wrp.66.2020.06.01.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:06:45 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mm: swap: allow partial swapoff with try_to_unuse()
Date:   Mon,  1 Jun 2020 18:06:35 +0200
Message-Id: <20200601160636.148346-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601160636.148346-1-andrea.righi@canonical.com>
References: <20200601160636.148346-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow to run try_to_unuse() passing an arbitrary amount of pages also
when frontswap is not used.

To preserve the default behavior introduce a new function called
try_to_unuse_wait() and add a new 'wait' parameter: if 'wait' is false
return as soon as "pages_to_unuse" pages are unused, if it is true
simply ignore "pages_to_unuse" and wait until all the pages are unused.

In any case the value of 0 in "pages_to_unuse" means "all pages".

This is required by the PM / hibernation opportunistic memory reclaim
feature.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/swapfile.h |  7 +++++++
 mm/swapfile.c            | 15 +++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index e06febf62978..ac4d0ccd1f7b 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,6 +9,13 @@
 extern spinlock_t swap_lock;
 extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
+extern int try_to_unuse_wait(unsigned int type, bool frontswap, bool wait,
+			     unsigned long pages_to_unuse);
+static inline int
+try_to_unuse(unsigned int type, bool frontswap, unsigned long pages_to_unuse)
+{
+	return try_to_unuse_wait(type, frontswap, true, pages_to_unuse);
+}
 extern int try_to_unuse(unsigned int, bool, unsigned long);
 extern unsigned long generic_max_swapfile_size(void);
 extern unsigned long max_swapfile_size(void);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f8bf926c9c8f..651471ccf133 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2121,10 +2121,13 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 }
 
 /*
- * If the boolean frontswap is true, only unuse pages_to_unuse pages;
- * pages_to_unuse==0 means all pages; ignored if frontswap is false
+ * Unuse pages_to_unuse pages; pages_to_unuse==0 means all pages.
+ *
+ * If "wait" is false stop as soon as "pages_to_unuse" pages are unused, if
+ * wait is true "pages_to_unuse" will be ignored and wait until all the pages
+ * are unused.
  */
-int try_to_unuse(unsigned int type, bool frontswap,
+int try_to_unuse_wait(unsigned int type, bool frontswap, bool wait,
 		 unsigned long pages_to_unuse)
 {
 	struct mm_struct *prev_mm;
@@ -2138,10 +2141,6 @@ int try_to_unuse(unsigned int type, bool frontswap,
 
 	if (!READ_ONCE(si->inuse_pages))
 		return 0;
-
-	if (!frontswap)
-		pages_to_unuse = 0;
-
 retry:
 	retval = shmem_unuse(type, frontswap, &pages_to_unuse);
 	if (retval)
@@ -2223,7 +2222,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	 * been preempted after get_swap_page(), temporarily hiding that swap.
 	 * It's easy and robust (though cpu-intensive) just to keep retrying.
 	 */
-	if (READ_ONCE(si->inuse_pages)) {
+	if (wait && READ_ONCE(si->inuse_pages)) {
 		if (!signal_pending(current))
 			goto retry;
 		retval = -EINTR;
-- 
2.25.1

