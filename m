Return-Path: <linux-pm+bounces-42667-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EgeD8WqkWkrlQEAu9opvQ
	(envelope-from <linux-pm+bounces-42667-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 12:15:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DD13E915
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 12:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB6CB3003BED
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E952EBDCD;
	Sun, 15 Feb 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZFLGBXX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF62D46A2;
	Sun, 15 Feb 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771154109; cv=none; b=UpmrP0cLO6uXgOWw4C563Zj9zMx/t2wCW9DhHB9PFEKixSAnkddjtRpmcAQY0MgCEha9mFE2YE61HK5jnYphf8ohPSu5ohM3WAeXP/UAZrGWsT+uIer2dAklYlkb4NKdjGtawukWqAqHC24ys5KaAooyFH6QZFjZOaX5wp3PTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771154109; c=relaxed/simple;
	bh=fMI3NMBEUVDZUALv7eftcVJYCPV2kGHURWijC9u+i6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LK2fPIYj2L0RKnOs0G9XXy59scZ+yUIyMT0HcFz5s8XFkYiUHEgPUJ7GyqO2h94Z4SzuBafKrqGMqKxnpV4yO3D4b0VuwHb1FhxRAFwCs+GvFuqfL/gfrw3TuKLuVNpcJWTyVy5s0jnM2ylkwmdiv6SQXdRCa8p+dgv85PdTqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZFLGBXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFDECC2BCAF;
	Sun, 15 Feb 2026 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771154108;
	bh=fMI3NMBEUVDZUALv7eftcVJYCPV2kGHURWijC9u+i6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bZFLGBXXVj5aCmzNntR+TglAS+Z2wBCtWgkxyYgpPwAjYIYK2rxoZKQpLtPRq05+J
	 rlMYG7FKZJbPBPyUX+Um7z9sjbwfK2T+ksmiiWZX5Ny6S1bhsUrcKKr8pA/+Uzt3gh
	 SfB11RbCwxhRyPum/39VG7U4lv1uDHJleLSnNmOAlC8XI8Av//QqFZq4PihKsAiHWl
	 6edYgFAdtO/QrsTz7Yj+gljyzxCQ7c0Ccixj+tarwovgx+mA1gRMu9Sd4mspfu6+Vt
	 SVxfe8GYh2TVskwFEuF/LT6NGzUQs+jZpUOW/SSerJDkoUFymi9Mt9aibF7+QgPr1S
	 xZqbfBH2QvLnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F54EF5878;
	Sun, 15 Feb 2026 11:15:08 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sun, 15 Feb 2026 19:15:06 +0800
Subject: [PATCH v2 2/2] mm, swap: merge common convention and simplify
 allocation helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260215-hibernate-perf-v2-2-cf28c75b04b7@tencent.com>
References: <20260215-hibernate-perf-v2-0-cf28c75b04b7@tencent.com>
In-Reply-To: <20260215-hibernate-perf-v2-0-cf28c75b04b7@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Carsten Grohmann <carstengrohmann@gmx.de>, linux-kernel@vger.kernel.org, 
 "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771154107; l=2624;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=xURGM+JYZwNNO3bCJVyq5yzC/yV0T9iWCnyE/4unSbc=;
 b=v0kDF8xUvccP2/HLrDh7NblfN20PPLULlZ/UaTwGJmcAFIkoTwUkR3GCJ4hwIO83OUbYDANJX
 fyqBaABYJMsCxqAW0utUZT9l2/ES8XKqAAT9u0t+5kR8IaQS9UKM/iN
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42667-lists,linux-pm=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,gmx.de,vger.kernel.org,tencent.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C3DD13E915
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Almost all callers of the cluster scan helper require the: lock -> check
usefulness/emptiness check -> allocate -> unlock routine. So merge them
into the same helper to simplify the code.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bcac10d96fb5..03cc0ff4dc8c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -923,11 +923,14 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
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
@@ -1060,14 +1063,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
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
@@ -1332,14 +1328,7 @@ static bool swap_alloc_fast(struct folio *folio)
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
@@ -1945,10 +1934,7 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 		pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
 		if (pcp_si == si && pcp_offset) {
 			ci = swap_cluster_lock(si, pcp_offset);
-			if (cluster_is_usable(ci, 0))
-				offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
-			else
-				swap_cluster_unlock(ci);
+			offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
 		}
 		if (!offset)
 			offset = cluster_alloc_swap_entry(si, NULL);

-- 
2.52.0



