Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6460DBE061
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbfIYOjQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 10:39:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391511AbfIYOjQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 10:39:16 -0400
Received: from 1.general.apw.uk.vpn ([10.172.192.78] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <apw@canonical.com>)
        id 1iD8Rl-00011e-A7; Wed, 25 Sep 2019 14:39:13 +0000
From:   Andy Whitcroft <apw@canonical.com>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Whitcroft <apw@canonical.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PM / hibernate: memory_bm_find_bit -- tighten node optimisation
Date:   Wed, 25 Sep 2019 15:39:12 +0100
Message-Id: <20190925143912.22593-1-apw@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When looking for a bit by number we make use of the cached result from the
preceding lookup to speed up operation.  Firstly we check if the requested
pfn is within the cached zone and if not lookup the new zone.  We then
check if the offset for that pfn falls within the existing cached node.
This happens regardless of whether the node is within the zone we are
now scanning.  With certain memory layouts it is possible for this to
false trigger creating a temporary alias for the pfn to a different bit.
This leads the hibernation code to free memory which it was never allocated
with the expected fallout.

Ensure the zone we are scanning matches the cached zone before considering
the cached node.

Deep thanks go to Andrea for many, many, many hours of hacking and testing
that went into cornering this bug.

Reported-by: Andrea Righi <andrea.righi@canonical.com>
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 kernel/power/snapshot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 83105874f255..26b9168321e7 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -734,8 +734,15 @@ static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
 	 * We have found the zone. Now walk the radix tree to find the leaf node
 	 * for our PFN.
 	 */
+
+	/*
+	 * If the zone we wish to scan is the the current zone and the
+	 * pfn falls into the current node then we do not need to walk
+	 * the tree.
+	 */
 	node = bm->cur.node;
-	if (((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
+	if (zone == bm->cur.zone &&
+	    ((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
 		goto node_found;
 
 	node      = zone->rtree;
-- 
2.20.1

