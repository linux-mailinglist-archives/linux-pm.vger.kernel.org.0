Return-Path: <linux-pm+bounces-42675-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLhVAegXkmmuqwEAu9opvQ
	(envelope-from <linux-pm+bounces-42675-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 20:00:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A5513F794
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 20:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A461301DAE6
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1D4212F98;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRJX/rgq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5815ECCC;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771182046; cv=none; b=LXS3Kg31/+aTQ7RSVrHGMiASasc8GAFAdjqCSS/lYsSI/t1OiMqWk1z6A7b1IPuFhN/LjATLLh0ehpdFnWp9NYxhZDiQsCT3AJzRX/dRpUQAIb4WqTaL59Kaw1pto0195wICfJK6Vclvpk2fhsoEG6BhwcKYEtdJvYB+8uYV+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771182046; c=relaxed/simple;
	bh=wYTnJaBMBsMKTzzb60ulEhgq9fyH+kQ0QpPvYbf16Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoDjGGczbk2iZb0fdYCOdRnTVS/TOtOp9iRO3fFvB7xMfwRT4/k1KoBDrDbjKh14zZG8XEkHr2GTozdpRsi0yU5cN9X4NlkJl3nmKUz4cCiaENZ3MAdYvFRBe/7RiOw6ISem0AGodFJ9QYNaD9p2eBy4kxXuUatS6itq699I/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRJX/rgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 335EFC2BCB1;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771182046;
	bh=wYTnJaBMBsMKTzzb60ulEhgq9fyH+kQ0QpPvYbf16Uw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JRJX/rgq6MIlxGPmiGkU7l62fhE+zV4C7kMpZKFL+TpQoL+BSrdCUMmDtrFU2S+gK
	 m0p1RMCkGkbqZcV+pfmgh8ALLUG7g7AiyxQwp0oBZpa1UCkN624cNarRqoaEklndrB
	 dAGF7YqjKoi/Ntm66Sx4J7OvxMXZB5anBHCGO4MBBpRU/CxXUDPiShZH1MVcpwbaA8
	 eLLR9DNK4G1JmXs/Bg2K4KtwCftXB5tPZznMJkhiw7kQ8K8j3mjXSnMAOuN4fn0lgo
	 wgL3DH/8xZtrLjXa34GgVP11Agtf1BV8Wi3JSi+3Oo46lz2jixOK6hfcViKtUgZod/
	 pz8dnxaWTlUCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2103CE63F08;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Mon, 16 Feb 2026 03:00:27 +0800
Subject: [PATCH v3 3/3] mm, swap: merge common convention and simplify
 allocation helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-hibernate-perf-v3-3-74e025091145@tencent.com>
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Carsten Grohmann <mail@carstengrohmann.de>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
 Carsten Grohmann <carstengrohmann@gmx.de>, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771182044; l=2624;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=l6JMKyznXv7F/U7uxICNhzFyjw8qBx6KKx0n+2vekQ4=;
 b=sKhh/YKyxlJMwOjmKcgVwcMjFOKElcHZFjBnSNbb504y4+zD57nffhL0T4FZ7GzMEpV5Yxxsh
 yzIfZ8b685RDNlsDQpp54AYE4JVMm8yao6S3CSzFm7RT/IqRLvGfxDN
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42675-lists,linux-pm=lfdr.de,kasong.tencent.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97A5513F794
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
index 0d1b17c99221..68dbbbd0dd24 100644
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



