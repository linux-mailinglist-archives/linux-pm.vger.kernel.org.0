Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D88127E77
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfLTOrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 09:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbfLTOrR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Dec 2019 09:47:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E692465E;
        Fri, 20 Dec 2019 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576853236;
        bh=kveh1ERXR/jrjPRqVOjjXnLUQXVGtLc6TMm1Lqis+cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTRyC9SUc+VzlS/rlLNgedOFRUXzbMRauAyRiGPIA2+PKf2ewuh0JS024QXTE80IX
         h+iUM67JMyNs1lhQEJSYPZ//kXzbJ+UXlJrY/wfhbUYrsI0hWHq0hnhdcrjOkTVnDy
         AXGsjqT4A7gsMxQ95hPDITeSwOG5XT6rEH41Fby0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 14/14] PM / hibernate: memory_bm_find_bit(): Tighten node optimisation
Date:   Fri, 20 Dec 2019 09:46:58 -0500
Message-Id: <20191220144658.10414-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220144658.10414-1-sashal@kernel.org>
References: <20191220144658.10414-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Andy Whitcroft <apw@canonical.com>

[ Upstream commit da6043fe85eb5ec621e34a92540735dcebbea134 ]

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
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/snapshot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 4f0f0604f1c4f..5dfac92521faa 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -732,8 +732,15 @@ static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
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

