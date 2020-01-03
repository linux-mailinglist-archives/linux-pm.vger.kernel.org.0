Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007AF12FA09
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 16:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgACPzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 10:55:16 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59624 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727539AbgACPzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jan 2020 10:55:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TmkFDOs_1578066907;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmkFDOs_1578066907)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jan 2020 23:55:13 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     rjw@rjwysocki.net, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/power/snapshot.c: improve arithmetic divisions
Date:   Fri,  3 Jan 2020 23:54:58 +0800
Message-Id: <20200103155458.21707-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

do_div() does a 64-by-32 division. Use div64_u64() instead of
do_div() if the divisor is u64, to avoid truncation to 32-bit.
This change also cleans up code a tad.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/power/snapshot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 26b9168..8a6eaf7 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1566,9 +1566,7 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
  */
 static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
 {
-	x *= multiplier;
-	do_div(x, base);
-	return (unsigned long)x;
+	return div64_u64(x * multiplier, base);
 }
 
 static unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
-- 
1.8.3.1

