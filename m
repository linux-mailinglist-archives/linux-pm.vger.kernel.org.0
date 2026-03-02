Return-Path: <linux-pm+bounces-43440-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF0nCtjFpWnEFgAAu9opvQ
	(envelope-from <linux-pm+bounces-43440-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 18:16:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D091DDA51
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BF143002905
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7780D33120A;
	Mon,  2 Mar 2026 17:08:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CF421F1F
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471332; cv=none; b=LJVERUmO459yPO9r1UvwD+02ovd9OFjB2gV0bPpMBgh6gBQGDWNKe3Ood5DZ8Thrr+jin2K2n/45175QUhmbFqtrBZjiOfRiAGHlGif6C/xnAW3b8yB9l/GuCG2yVTbHHdPmgopxaLhl7njpE8hTLcTH6dnsyntp6X9ca+fqZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471332; c=relaxed/simple;
	bh=XJBYX5cOG7pKBl31YzkNOk5cZ1vA6736mSyZX7NZbo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OT4Xfpk6Ot6gwucNLIOsHESCFUTAzCr/vtCS+zlCiO+us6eqONKEjJtod0TwHG/soPpLRlXSQT6VdN/6zbpFl7T46wJDpd+Mw9OEDvXAqdqxLY37RFLD/7zc7sRF4kDujxqMh5k3awi0sW4HbUyAz649rfCtM2MVzavCwknINxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 3 Mar 2026 01:53:38 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: linux-pm@vger.kernel.org
Cc: linux-mm@kvack.org,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com
Subject: [RFC PATCH 1/2] mm/swap: release swap reference on each hibernation slot allocation
Date: Tue,  3 Mar 2026 01:53:33 +0900
Message-Id: <20260302165334.1278479-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302165334.1278479-1-youngjun.park@lge.com>
References: <20260302165334.1278479-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5D091DDA51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43440-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,linux-pm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.530];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lge.com:mid,lge.com:email]
X-Rspamd-Action: no action

Currently, only the swap type value is retrieved at lookup time without
holding a reference. If swapoff races after the type is acquired, the
type value becomes invalid and subsequent slot allocations operate on
a stale swap device.

Additionally, grabbing and releasing the reference on every slot
allocation is inefficient. The proper approach is to hold the reference
from the swap device lookup and release it once when it is no longer
needed.

This is a preparatory change. A subsequent commit will lift the
reference acquisition to the lookup site and replace the per-slot
acquire/release with a single reference held across the entire
hibernation swap operation.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/swap.h |  1 +
 mm/swapfile.c        | 55 ++++++++++++++++++++++----------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7a09df6977a5..37bf7cf21594 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -442,6 +442,7 @@ extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
 struct backing_dev_info;
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+extern void put_swap_device_by_type(int type);
 sector_t swap_folio_sector(struct folio *folio);
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 915bc93964db..f505dd1f7571 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1860,6 +1860,10 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
+void put_swap_device_by_type(int type)
+{
+	percpu_ref_put(&swap_info[type]->users);
+}
 /*
  * Free a set of swap slots after their swap count dropped to zero, or will be
  * zero after putting the last ref (saves one __swap_cluster_put_entry call).
@@ -2085,30 +2089,28 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 		goto fail;
 
 	/* This is called for allocating swap entry, not cache */
-	if (get_swap_device_info(si)) {
-		if (si->flags & SWP_WRITEOK) {
-			/*
-			 * Try the local cluster first if it matches the device. If
-			 * not, try grab a new cluster and override local cluster.
-			 */
-			local_lock(&percpu_swap_cluster.lock);
-			pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
-			pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
-			if (pcp_si == si && pcp_offset) {
-				ci = swap_cluster_lock(si, pcp_offset);
-				if (cluster_is_usable(ci, 0))
-					offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
-				else
-					swap_cluster_unlock(ci);
-			}
-			if (!offset)
-				offset = cluster_alloc_swap_entry(si, NULL);
-			local_unlock(&percpu_swap_cluster.lock);
-			if (offset)
-				entry = swp_entry(si->type, offset);
+	if (si->flags & SWP_WRITEOK) {
+		/*
+		 * Try the local cluster first if it matches the device. If
+		 * not, try grab a new cluster and override local cluster.
+		 */
+		local_lock(&percpu_swap_cluster.lock);
+		pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
+		pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
+		if (pcp_si == si && pcp_offset) {
+			ci = swap_cluster_lock(si, pcp_offset);
+			if (cluster_is_usable(ci, 0))
+				offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
+			else
+				swap_cluster_unlock(ci);
 		}
-		put_swap_device(si);
+		if (!offset)
+			offset = cluster_alloc_swap_entry(si, NULL);
+		local_unlock(&percpu_swap_cluster.lock);
+		if (offset)
+			entry = swp_entry(si->type, offset);
 	}
+
 fail:
 	return entry;
 }
@@ -2116,14 +2118,10 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 /* Free a slot allocated by swap_alloc_hibernation_slot */
 void swap_free_hibernation_slot(swp_entry_t entry)
 {
-	struct swap_info_struct *si;
+	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct swap_cluster_info *ci;
 	pgoff_t offset = swp_offset(entry);
 
-	si = get_swap_device(entry);
-	if (WARN_ON(!si))
-		return;
-
 	ci = swap_cluster_lock(si, offset);
 	__swap_cluster_put_entry(ci, offset % SWAPFILE_CLUSTER);
 	__swap_cluster_free_entries(si, ci, offset % SWAPFILE_CLUSTER, 1);
@@ -2131,7 +2129,6 @@ void swap_free_hibernation_slot(swp_entry_t entry)
 
 	/* In theory readahead might add it to the swap cache by accident */
 	__try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
-	put_swap_device(si);
 }
 
 /*
@@ -2160,6 +2157,7 @@ int swap_type_of(dev_t device, sector_t offset)
 			struct swap_extent *se = first_se(sis);
 
 			if (se->start_block == offset) {
+				get_swap_device_info(sis);
 				spin_unlock(&swap_lock);
 				return type;
 			}
@@ -2180,6 +2178,7 @@ int find_first_swap(dev_t *device)
 		if (!(sis->flags & SWP_WRITEOK))
 			continue;
 		*device = sis->bdev->bd_dev;
+		get_swap_device_info(sis);
 		spin_unlock(&swap_lock);
 		return type;
 	}
-- 
2.34.1


