Return-Path: <linux-pm+bounces-42706-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GItQB80wk2mI2QEAu9opvQ
	(envelope-from <linux-pm+bounces-42706-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:59:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0058144E7B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CD30303DAF1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C01313E10;
	Mon, 16 Feb 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ1MWcoW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376331353B;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253888; cv=none; b=V2E8RKSIvvmwqWs9Fx4tgbxYgZ6ghwJEsNFnN22709XWN2RamEGrcctpkgZ13a9U3QkDVHwi3Xay1Fbwi2bI4aW5JdI17Nq/85qjxAnCn/KrlXE/nfrN2TP5JEfKT1Za2jYqqRgiptCtXEWYBBVOVUHANpWcP72KsgY1dd6lVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253888; c=relaxed/simple;
	bh=WYW37/BfhOOjNfUbgzmr0b/6G+uzVVZ+LippTRuq7l8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnQYWrBS+mphY6aEuIuzsZ71Fz+/HbXRvtxzi6AbXEgpTb9EBFgDYrNzKAGdcXdKWesdvblV3OdgxjWB1enIB+I0pH1j17TimzByMZg6xhHfZz5anknEqhuIFv9PjH9iL5/J86L/zGguehVX9q0h4pRYZVcrxROegFy/Y58ZIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ1MWcoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3A96C116C6;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771253887;
	bh=WYW37/BfhOOjNfUbgzmr0b/6G+uzVVZ+LippTRuq7l8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LZ1MWcoWLWOo8VNMgjp1CUNUSjNO4mLPJIUXIY8WVZaRAj37yWd0ELYIErKcDYEGk
	 IAH/orXK8IXxhlwbISW5/F32Eu0hHlaPuSqT/UvEmVsd9CE8IbrIukvAtPvNYaBSJT
	 yFlvY2UG9iEqFlyfgSDHnNFeqo3++trMu5VLTeLSmTsurpfXTQ1SBPf8ka7E2obJwh
	 vCL+VBaDdNCQBZJlR62n3Q60pILX9xDKk+ZZibBuN5GRNbWS2WGwQXvh4y+QwbfofO
	 Dn0yMujM3OXGbRxR4jJAn//kSgQoBunG3uCASyEjzYlBc97WMEl9FSzrmowsQxi9fB
	 8vQSsgsLWnXuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F2E81A32;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Mon, 16 Feb 2026 22:58:04 +0800
Subject: [PATCH v4 3/3] mm, swap: merge common convention and simplify
 allocation helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-hibernate-perf-v4-3-1ba9f0bf1ec9@tencent.com>
References: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Carsten Grohmann <mail@carstengrohmann.de>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
 Carsten Grohmann <carstengrohmann@gmx.de>, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771253885; l=4406;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=XE85Cs7eMoW2MzbPsMRN8glTTJ2qQfea8kHvJhs9XRM=;
 b=XjOjKB6C9RKF289BaDOi2fed12TaT5b+w77m1kwzOZ5PBWUKf9cA9Lwh5/Vmc8idUkOkv49cW
 CGGS8aMFVcQCG2luwdfgnGmOyIk+xyV50eFl6DypcOEVr3JsMK69xGJ
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42706-lists,linux-pm=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de,tencent.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:mid,tencent.com:email,tencent.com:replyto]
X-Rspamd-Queue-Id: B0058144E7B
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Almost all callers of the cluster scan helper require the: lock -> check
usefulness/emptiness check -> allocate -> unlock routine. So merge them
into the same helper to simplify the code.

While at it, add some kerneldoc too.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 54 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ea63885f344a..a6276c5ead8e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -910,7 +910,21 @@ static bool cluster_alloc_range(struct swap_info_struct *si,
 	return true;
 }
 
-/* Try use a new cluster for current CPU and allocate from it. */
+/*
+ * alloc_swap_scan_cluster - Scan and allocate swap entries from one cluster.
+ * @si: the swap device of the cluster.
+ * @ci: the cluster, must be locked.
+ * @folio: the folio to allocate for, could be NULL.
+ * @offset: scan start offset, must be a swap device offset pointing inside @ci.
+ *
+ * Scan the swap slots inside @ci, starting from @offset, and allocate
+ * contiguous entries that point to these slots. If @folio is not NULL, folio
+ * size number of entries are allocated, and the starting entry is stored to
+ * folio->swap. If @folio is NULL, one entry will be allocated and passed to
+ * the caller as the return value. In both cases, the offset is returned.
+ *
+ * This helper also updates the percpu cached cluster.
+ */
 static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 					    struct swap_cluster_info *ci,
 					    struct folio *folio, unsigned long offset)
@@ -923,11 +937,14 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	bool need_reclaim, ret, usable;
 
 	lockdep_assert_held(&ci->lock);
-	VM_WARN_ON(!cluster_is_usable(ci, order));
 
-	if (end < nr_pages || ci->count + nr_pages > SWAPFILE_CLUSTER)
+	if (!cluster_is_usable(ci, order) || end < nr_pages ||
+	    ci->count + nr_pages > SWAPFILE_CLUSTER)
 		goto out;
 
+	if (cluster_is_empty(ci))
+		offset = cluster_offset(si, ci);
+
 	for (end -= nr_pages; offset <= end; offset += nr_pages) {
 		need_reclaim = false;
 		if (!cluster_scan_range(si, ci, offset, nr_pages, &need_reclaim))
@@ -951,6 +968,14 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 		break;
 	}
 out:
+	/*
+	 * Whether the allocation succeeded or failed, relocate the cluster
+	 * and update percpu offset cache. On success this is necessary to
+	 * mark the cluster as cached fast path. On failure, this invalidates
+	 * the percpu cache to indicate an allocation failure and next scan
+	 * should use a new cluster, and move the failed cluster to where it
+	 * should be.
+	 */
 	relocate_cluster(si, ci);
 	swap_cluster_unlock(ci);
 	if (si->flags & SWP_SOLIDSTATE) {
@@ -1060,14 +1085,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 			goto new_cluster;
 
 		ci = swap_cluster_lock(si, offset);
-		/* Cluster could have been used by another order */
-		if (cluster_is_usable(ci, order)) {
-			if (cluster_is_empty(ci))
-				offset = cluster_offset(si, ci);
-			found = alloc_swap_scan_cluster(si, ci, folio, offset);
-		} else {
-			swap_cluster_unlock(ci);
-		}
+		found = alloc_swap_scan_cluster(si, ci, folio, offset);
 		if (found)
 			goto done;
 	}
@@ -1332,14 +1350,7 @@ static bool swap_alloc_fast(struct folio *folio)
 		return false;
 
 	ci = swap_cluster_lock(si, offset);
-	if (cluster_is_usable(ci, order)) {
-		if (cluster_is_empty(ci))
-			offset = cluster_offset(si, ci);
-		alloc_swap_scan_cluster(si, ci, folio, offset);
-	} else {
-		swap_cluster_unlock(ci);
-	}
-
+	alloc_swap_scan_cluster(si, ci, folio, offset);
 	put_swap_device(si);
 	return folio_test_swapcache(folio);
 }
@@ -1943,10 +1954,7 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
 	if (pcp_si == si && pcp_offset) {
 		ci = swap_cluster_lock(si, pcp_offset);
-		if (cluster_is_usable(ci, 0))
-			offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
-		else
-			swap_cluster_unlock(ci);
+		offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
 	}
 	if (offset == SWAP_ENTRY_INVALID)
 		offset = cluster_alloc_swap_entry(si, NULL);

-- 
2.52.0



