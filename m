Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5D2603FD
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIGR6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 13:58:40 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:55890 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729355AbgIGR6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 13:58:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C87BB100E7B44;
        Mon,  7 Sep 2020 17:58:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3866:3867:4321:4385:4605:5007:6261:6642:10004:10848:11026:11473:11658:11914:12048:12296:12297:12555:12895:13069:13311:13357:13894:14181:14384:14394:14721:21080:21611:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: point00_13148c4270ce
X-Filterd-Recvd-Size: 2473
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 17:58:19 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/4] drivers core: Reindent a couple uses around sysfs_emit
Date:   Mon,  7 Sep 2020 10:58:07 -0700
Message-Id: <88db4a1fc2aaaa827f74542b99325928be4113a2.1599501047.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1599501047.git.joe@perches.com>
References: <cover.1599501047.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just a couple of whitespace realignment to open parenthesis for
multi-line statements.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/node.c        | 4 ++--
 drivers/base/power/sysfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 60abdb27137b..f10e8236aba8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -386,9 +386,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(i.freeram),
 		       nid, K(i.totalram - i.freeram),
 		       nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
-				node_page_state(pgdat, NR_ACTIVE_FILE)),
+			      node_page_state(pgdat, NR_ACTIVE_FILE)),
 		       nid, K(node_page_state(pgdat, NR_INACTIVE_ANON) +
-				node_page_state(pgdat, NR_INACTIVE_FILE)),
+			      node_page_state(pgdat, NR_INACTIVE_FILE)),
 		       nid, K(node_page_state(pgdat, NR_ACTIVE_ANON)),
 		       nid, K(node_page_state(pgdat, NR_INACTIVE_ANON)),
 		       nid, K(node_page_state(pgdat, NR_ACTIVE_FILE)),
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index c3d303c4c9c2..eace289938e0 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -102,7 +102,7 @@ static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	return sysfs_emit(buf, "%s\n",
-				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
+			  dev->power.runtime_auto ? ctrl_auto : ctrl_on);
 }
 
 static ssize_t control_store(struct device * dev, struct device_attribute *attr,
-- 
2.26.0

