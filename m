Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E126CC48
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 22:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgIPUl6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 16:41:58 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:54076 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728415AbgIPUlC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 16:41:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DD8C7182CED34;
        Wed, 16 Sep 2020 20:41:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:69:355:379:541:800:960:968:973:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1605:1730:1747:1777:1792:2194:2198:2199:2200:2393:2559:2562:2741:2902:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:4050:4119:4321:4605:5007:6119:6261:7904:8957:9592:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12438:12555:12683:12895:13894:14110:14394:21080:21433:21627:21939:21966:21990:30029:30045:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: form69_220a5c72711c
X-Filterd-Recvd-Size: 8817
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:40:59 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH V3 3/8] drivers core: Remove strcat uses around sysfs_emit and neaten
Date:   Wed, 16 Sep 2020 13:40:40 -0700
Message-Id: <5d606519698ce4c8f1203a2b35797d8254c6050a.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1600285923.git.joe@perches.com>
References: <cover.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

strcat is no longer necessary for sysfs_emit and sysfs_emit_at uses.

Convert the strcat uses to sysfs_emit calls and neaten other block
uses of direct returns to use an intermediate const char *.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/cacheinfo.c   | 25 +++++++++++++-------
 drivers/base/core.c        | 10 ++++----
 drivers/base/memory.c      | 47 ++++++++++++++++++--------------------
 drivers/base/power/sysfs.c | 23 +++++++++++--------
 4 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 6a8c2b5881be..96f8af414a48 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -404,17 +404,23 @@ static ssize_t type_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
+	const char *output;
 
 	switch (this_leaf->type) {
 	case CACHE_TYPE_DATA:
-		return sysfs_emit(buf, "Data\n");
+		output = "Data";
+		break;
 	case CACHE_TYPE_INST:
-		return sysfs_emit(buf, "Instruction\n");
+		output = "Instruction";
+		break;
 	case CACHE_TYPE_UNIFIED:
-		return sysfs_emit(buf, "Unified\n");
+		output = "Unified";
+		break;
 	default:
 		return -EINVAL;
 	}
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static ssize_t allocation_policy_show(struct device *dev,
@@ -422,15 +428,18 @@ static ssize_t allocation_policy_show(struct device *dev,
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
 	unsigned int ci_attr = this_leaf->attributes;
-	int n = 0;
+	const char *output;
 
 	if ((ci_attr & CACHE_READ_ALLOCATE) && (ci_attr & CACHE_WRITE_ALLOCATE))
-		n = sysfs_emit(buf, "ReadWriteAllocate\n");
+		output = "ReadWriteAllocate";
 	else if (ci_attr & CACHE_READ_ALLOCATE)
-		n = sysfs_emit(buf, "ReadAllocate\n");
+		output = "ReadAllocate";
 	else if (ci_attr & CACHE_WRITE_ALLOCATE)
-		n = sysfs_emit(buf, "WriteAllocate\n");
-	return n;
+		output = "WriteAllocate";
+	else
+		return 0;
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static ssize_t write_policy_show(struct device *dev,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e17e8e941462..c5d2cc8bb8b0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -267,16 +267,16 @@ static ssize_t auto_remove_on_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct device_link *link = to_devlink(dev);
-	char *str;
+	const char *output;
 
 	if (link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
-		str = "supplier unbind";
+		output = "supplier unbind";
 	else if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
-		str = "consumer unbind";
+		output = "consumer unbind";
 	else
-		str = "never";
+		output = "never";
 
-	return sysfs_emit(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", output);
 }
 static DEVICE_ATTR_RO(auto_remove_on);
 
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f5c0b64df2e5..7abf9eb8bff0 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -139,7 +139,7 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	ssize_t len = 0;
+	const char *output;
 
 	/*
 	 * We can probably put these states in a nice little array
@@ -147,22 +147,20 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	 */
 	switch (mem->state) {
 	case MEM_ONLINE:
-		len = sysfs_emit(buf, "online\n");
+		output = "online";
 		break;
 	case MEM_OFFLINE:
-		len = sysfs_emit(buf, "offline\n");
+		output = "offline";
 		break;
 	case MEM_GOING_OFFLINE:
-		len = sysfs_emit(buf, "going-offline\n");
+		output = "going-offline";
 		break;
 	default:
-		len = sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n",
-				 mem->state);
 		WARN_ON(1);
-		break;
+		return sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n", mem->state);
 	}
 
-	return len;
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 int memory_notify(unsigned long val, void *v)
@@ -307,17 +305,16 @@ static ssize_t phys_device_show(struct device *dev,
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static void print_allowed_zone(char *buf, int nid, unsigned long start_pfn,
-		unsigned long nr_pages, int online_type,
-		struct zone *default_zone)
+static int print_allowed_zone(char *buf, int len, int nid,
+			      unsigned long start_pfn, unsigned long nr_pages,
+			      int online_type, struct zone *default_zone)
 {
 	struct zone *zone;
 
 	zone = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
-	if (zone != default_zone) {
-		strcat(buf, " ");
-		strcat(buf, zone->name);
-	}
+	if (zone == default_zone)
+		return 0;
+	return sysfs_emit_at(buf, len, " %s", zone->name);
 }
 
 static ssize_t valid_zones_show(struct device *dev,
@@ -327,6 +324,7 @@ static ssize_t valid_zones_show(struct device *dev,
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	struct zone *default_zone;
+	int len = 0;
 	int nid;
 
 	/*
@@ -341,24 +339,23 @@ static ssize_t valid_zones_show(struct device *dev,
 		default_zone = test_pages_in_a_zone(start_pfn,
 						    start_pfn + nr_pages);
 		if (!default_zone)
-			return sysfs_emit(buf, "none\n");
-		strcat(buf, default_zone->name);
+			return sysfs_emit(buf, "%s\n", "none");
+		len += sysfs_emit_at(buf, len, "%s", default_zone->name);
 		goto out;
 	}
 
 	nid = mem->nid;
 	default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, start_pfn,
 					  nr_pages);
-	strcat(buf, default_zone->name);
 
-	print_allowed_zone(buf, nid, start_pfn, nr_pages, MMOP_ONLINE_KERNEL,
-			default_zone);
-	print_allowed_zone(buf, nid, start_pfn, nr_pages, MMOP_ONLINE_MOVABLE,
-			default_zone);
+	len += sysfs_emit_at(buf, len, "%s", default_zone->name);
+	len += print_allowed_zone(buf, len, nid, start_pfn, nr_pages,
+				  MMOP_ONLINE_KERNEL, default_zone);
+	len += print_allowed_zone(buf, len, nid, start_pfn, nr_pages,
+				  MMOP_ONLINE_MOVABLE, default_zone);
 out:
-	strcat(buf, "\n");
-
-	return strlen(buf);
+	len += sysfs_emit_at(buf, len, "%s", "\n");
+	return len;
 }
 static DEVICE_ATTR_RO(valid_zones);
 #endif
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 4276b792d0aa..61e16786f6c5 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -255,9 +255,9 @@ static ssize_t pm_qos_latency_tolerance_us_show(struct device *dev,
 	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
 
 	if (value < 0)
-		return sysfs_emit(buf, "auto\n");
+		return sysfs_emit(buf, "%s\n", "auto");
 	if (value == PM_QOS_LATENCY_ANY)
-		return sysfs_emit(buf, "any\n");
+		return sysfs_emit(buf, "%s\n", "any");
 
 	return sysfs_emit(buf, "%d\n", value);
 }
@@ -538,13 +538,18 @@ static DEVICE_ATTR_RO(runtime_active_kids);
 static ssize_t runtime_enabled_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	if (dev->power.disable_depth && (dev->power.runtime_auto == false))
-		return sysfs_emit(buf, "disabled & forbidden\n");
-	if (dev->power.disable_depth)
-		return sysfs_emit(buf, "disabled\n");
-	if (dev->power.runtime_auto == false)
-		return sysfs_emit(buf, "forbidden\n");
-	return sysfs_emit(buf, "enabled\n");
+	const char *output;
+
+	if (dev->power.disable_depth && !dev->power.runtime_auto)
+		output = "disabled & forbidden";
+	else if (dev->power.disable_depth)
+		output = "disabled";
+	else if (!dev->power.runtime_auto)
+		output = "forbidden";
+	else
+		output = "enabled";
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 static DEVICE_ATTR_RO(runtime_enabled);
 
-- 
2.26.0

