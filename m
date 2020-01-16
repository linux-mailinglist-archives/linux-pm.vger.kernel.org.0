Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2163513D89C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 12:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgAPLKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 06:10:07 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:49699 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgAPLKH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 06:10:07 -0500
Received: by mail-wr1-f74.google.com with SMTP id w6so9085960wrm.16
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 03:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HIpX/NKrVtPBrXPgroxOjZO6k8lDeUStnrVsEbDUXS8=;
        b=gwmEaoq0EZjgW5CYICTJYvOMm/utGT+LwkQ/VZxhrSYR3aaizI7YLZIh2EPieAen2t
         gUq1ULl/HqepmauK2az0viRC54svdMxnH4ZbHtczGX9uTPmzZ+biJLv2kqSDPP6VgZne
         3+x2+PEFKVczypIyW9xs3tyh4RiPKCaM5D25QsVWS/2Mb5nH4Cymw0nP/le5z4kOdSvP
         jvy5ik9cmtFviDTjsX54Jjj3q4LPmfLp7kUMFLP6GDvH6J+P+ngrYmf1HW/kNAXzSr2M
         aMySCH33O51PDGp3NkNEXfFVfoGWZWZc+UiVnsLRmenDsi9jDUc9tBdknaDBdBrJdh5h
         thnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HIpX/NKrVtPBrXPgroxOjZO6k8lDeUStnrVsEbDUXS8=;
        b=q4dmqJdjlU7LnPE/RFAd8ZW1MYHO1wKsbSDIGBWlKWIMVKmWRkrx+O5d6CQLf3+T3z
         i5o161VQXtr6d4gGYfnuUUxm0vUgzZZu+CXgNgHdOMwX4UCaDGWHuRAHgsqZD5GVVogq
         Nrc/Vy3gAp6IA/J8zqiDS87zn3ArJcru2fxBzQx7v1R/L2uF+6bU7eVxOK22Leg8OWJ2
         IQ70QGwiEk1nBeKaQIIBXFIlcVBUsWsSNMh+mzSw8Pp/m3UUfeA1SBidVX6d8YA9BeIe
         7pgZtpPWR0HhfnGfb/uM1IcWAl3o5PzIbNcJ2PvZFhAqcn6+rUlG6BptgxOLMPb5BKKh
         o+MQ==
X-Gm-Message-State: APjAAAVU3QfQ/T4GxpB1IF5Ic8GlWxd2DQC38AOYaCxYhftz4jye9bbi
        cRDJavY99wA6nbrtQe2/mIUmRUmtVZ0=
X-Google-Smtp-Source: APXvYqzT0png/XDvtOanH9+zMDalTNdHWDleqg/A3FBgHOvms/CXTp6yluI9lSsmTdJnYoU9k9KHoLkyjJg=
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr2598095wrw.391.1579173004748;
 Thu, 16 Jan 2020 03:10:04 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:09:34 +0100
Message-Id: <20200116110934.90531-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] PM: hibernate: fix crashes with init_on_free=1
From:   glider@google.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, js@sig21.net
Cc:     linux-pm@vger.kernel.org, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Upon resuming from hibernation, free pages may contain stale data from
the kernel that initiated the resume. This breaks the invariant
inflicted by init_on_free=1 that freed pages must be zeroed.

To deal with this problem, make clear_free_pages() also clear the free
pages when init_on_free is enabled.

Reported-by: Johannes Stezenbach <js@sig21.net>
Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
---
 kernel/power/snapshot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 26b9168321e7..d65f2d5ab694 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1147,24 +1147,24 @@ void free_basic_memory_bitmaps(void)
 
 void clear_free_pages(void)
 {
-#ifdef CONFIG_PAGE_POISONING_ZERO
 	struct memory_bitmap *bm = free_pages_map;
 	unsigned long pfn;
 
 	if (WARN_ON(!(free_pages_map)))
 		return;
 
-	memory_bm_position_reset(bm);
-	pfn = memory_bm_next_pfn(bm);
-	while (pfn != BM_END_OF_MAP) {
-		if (pfn_valid(pfn))
-			clear_highpage(pfn_to_page(pfn));
-
+	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
+		memory_bm_position_reset(bm);
 		pfn = memory_bm_next_pfn(bm);
+		while (pfn != BM_END_OF_MAP) {
+			if (pfn_valid(pfn))
+				clear_highpage(pfn_to_page(pfn));
+
+			pfn = memory_bm_next_pfn(bm);
+		}
+		memory_bm_position_reset(bm);
+		pr_info("free pages cleared after restore\n");
 	}
-	memory_bm_position_reset(bm);
-	pr_info("free pages cleared after restore\n");
-#endif /* PAGE_POISONING_ZERO */
 }
 
 /**
-- 
2.25.0.rc1.283.g88dfdc4193-goog

