Return-Path: <linux-pm+bounces-43734-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA4qNwpAqmnGNwEAu9opvQ
	(envelope-from <linux-pm+bounces-43734-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:46:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF1121AB09
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE5323024A24
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 02:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629992472B6;
	Fri,  6 Mar 2026 02:46:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7833688E
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765184; cv=none; b=sJwEESUZ1ZtaBSj0i/N+fRTYGqk/N+US4O+wGmoXm/h8KUCB+L4N4eL8ZHelmhMGmgqu5dwLabs69LHSOCVCchl83eOH6e4QjAaFztXNxhUhUoUBudnaVbvDx2G6kw0RPA58XuCWDB9CZi4yB5F8ZtUwZyC/uCg0bJiRzlYW6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765184; c=relaxed/simple;
	bh=PAGC3AF/XH6CdE/V0mWwqV6XisWbRLN7j93gbUmouPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oktfVgP4DYmrW+eid+IcSvVhfS/EMhaFI03K6rqGWwQ2Qlbl8daFJ+17u94Nic0laeM1L564AYEZvjLybWTMLUCytKeei9bCMKRGYySTec0j2OtAfGOUchQg4JWEZBloon9WpTiRoZ76tnG2wH1iODhQmtgNAtDBDjMs4AIBA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 6 Mar 2026 11:46:11 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: rafael@kernel.org,
	akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	pavel@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	usama.arif@linux.dev,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2] mm/swap, PM: hibernate: hold swap device reference across swap operation
Date: Fri,  6 Mar 2026 11:46:08 +0900
Message-Id: <20260306024608.1720991-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CF1121AB09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43734-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,linux.dev,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,linux-pm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently, in the uswsusp path, only the swap type value is retrieved at
lookup time without holding a reference. If swapoff races after the type
is acquired, subsequent slot allocations operate on a stale swap device.

Additionally, grabbing and releasing the swap device reference on every
slot allocation is inefficient across the entire hibernation swap path.

Address these issues by holding the swap device reference from the point
the swap device is looked up, and releasing it once at each exit path.
This ensures the device remains valid throughout the operation and
removes the overhead of per-slot reference counting.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
Hi,
    
This is a simple RFC quality patch to verify if this approach is suitable.
Per Usama Arif's feedback regarding git bisectability,
I have squashed the previous commits into this single patch.

base-commit: ec96cb7e4c12ff5b474cf9ab66f2e9767953e448 (mm-new)

RFC v1: https://lore.kernel.org/linux-mm/20260305202413.1888499-1-usama.arif@linux.dev/T/#m3693d45180f14f441b6951984f4b4bfd90ec0c9d

 include/linux/swap.h |  1 +
 kernel/power/swap.c  | 12 +++++++---
 kernel/power/user.c  |  9 +++++++-
 mm/swapfile.c        | 55 ++++++++++++++++++++++----------------------
 4 files changed, 45 insertions(+), 32 deletions(-)

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
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 2e64869bb5a0..c230b0fa5a5f 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -350,9 +350,10 @@ static int swsusp_swap_check(void)
 
 	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
 			BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(hib_resume_bdev_file))
+	if (IS_ERR(hib_resume_bdev_file)) {
+		put_swap_device_by_type(root_swap);
 		return PTR_ERR(hib_resume_bdev_file);
-
+	}
 	return 0;
 }
 
@@ -418,6 +419,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
 err_rel:
 	release_swap_writer(handle);
 err_close:
+	put_swap_device_by_type(root_swap);
 	swsusp_close();
 	return ret;
 }
@@ -480,8 +482,11 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 		flush_swap_writer(handle);
 	}
 
-	if (error)
+	if (error) {
 		free_all_swap_pages(root_swap);
+		put_swap_device_by_type(root_swap);
+	}
+
 	release_swap_writer(handle);
 	swsusp_close();
 
@@ -1647,6 +1652,7 @@ int swsusp_unmark(void)
 	 * We just returned from suspend, we don't need the image any more.
 	 */
 	free_all_swap_pages(root_swap);
+	put_swap_device_by_type(root_swap);
 
 	return error;
 }
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 4401cfe26e5c..9cb6c24d49ea 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -90,8 +90,11 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 			data->free_bitmaps = !error;
 		}
 	}
-	if (error)
+	if (error) {
 		hibernate_release();
+		if (data->swap >= 0)
+			put_swap_device_by_type(data->swap);
+	}
 
 	data->frozen = false;
 	data->ready = false;
@@ -115,6 +118,8 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	data = filp->private_data;
 	data->dev = 0;
 	free_all_swap_pages(data->swap);
+	if (data->swap >= 0)
+		put_swap_device_by_type(data->swap);
 	if (data->frozen) {
 		pm_restore_gfp_mask();
 		free_basic_memory_bitmaps();
@@ -235,6 +240,8 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 		offset = swap_area.offset;
 	}
 
+	if (data->swap >= 0)
+		put_swap_device_by_type(data->swap);
 	/*
 	 * User space encodes device types as two-byte values,
 	 * so we need to recode them
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


