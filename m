Return-Path: <linux-pm+bounces-42705-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFuAOMkwk2mI2QEAu9opvQ
	(envelope-from <linux-pm+bounces-42705-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:59:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7EE144E6A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20452303CEA1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134EE31355F;
	Mon, 16 Feb 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+Gzv+/s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFC313524;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253888; cv=none; b=qdsUO3YlwuEvY8fTQgfjojZ+Q5tH7Jse5EMgf/lN/ZGxzXKcQIUUSYJ9JKUDgEurBeCLF3+BP8Tz6sc3bB56yGMUSLiFQNWjSgODmGuEJ/zA+He6HtLz9d4sMpa9ceXoo88Rk5mvGzT5yxYc8gBm4joZ+exhYoOdMuR5t0Ink0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253888; c=relaxed/simple;
	bh=myZyOnHzp3lPkDV1e/C2uP7wr+40p+PY2MQZBb28QNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAht66NYJZBQ/JuqFO/aTlRGFpwggXyqxJSZOWIM8VPn5z49v9UwEu+CUaGn5Bcd3Ef/+/D8j6nECqOwU/xaq40Wg7lgaEV1fh4Tc2PhBjjgyQgsvMxFUd+sy/fUv4BiCbyA24r/8g9n8aVUBdxelTvTPaDb2egm4q2ebTH2edE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+Gzv+/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB19EC2BC86;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771253887;
	bh=myZyOnHzp3lPkDV1e/C2uP7wr+40p+PY2MQZBb28QNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l+Gzv+/sQQ4gp2ucvDPntyFzntvJ9KJ0ebymysuwtN+qX7m7zMEXm3MMn/AalPv+E
	 jSEzV2n9MICzI1NIzmO8o78n297/bVF7g40z1thhSU9uTSz8wEluVywhNKGPPO5nLu
	 +KctywZ7ENltWgIDQXhQOB+taPHiBPtSZ+u6TqrY+egBC/xfSohDZIAuQXrJQH1EIW
	 wTCqr2oMh0vRwdhZ2cnoou0aHVW4h4dlvVHBBIZYIHhrn9lyzLmx/N2tcpyEfAS1BZ
	 rC3zOMX3m/ctsyCQfph+WAuANsaHTb3fEWJwS7nJx0llHjelyCJ+1x9AMT8UCIOtRT
	 tschDypbqiasA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A823BE81A28;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Mon, 16 Feb 2026 22:58:03 +0800
Subject: [PATCH v4 2/3] mm, swap: reduce indention for hibernate allocation
 helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-hibernate-perf-v4-2-1ba9f0bf1ec9@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771253885; l=2613;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=NAvqyk1BCM82J8HW6Gnh4CX79o/hdmbrD/B6Y3rHXiw=;
 b=k/nFxKLOf037gv1sMhovQ1z7Lzzq5b7SFtNWk9LCk4plm6mzv2JlgbNEHqsWpL6ecmjVkQy7s
 lmvDhThxszvBx4B7SxU8s36kT/fNDml41igu0SWj6EFXOnsA1XxehU2
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
	TAGGED_FROM(0.00)[bounces-42705-lists,linux-pm=lfdr.de,kasong.tencent.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:mid,tencent.com:email,tencent.com:replyto]
X-Rspamd-Queue-Id: 8E7EE144E6A
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

It doesn't have to check the device flag, as the allocator will also
check the device flag and refuse to allocate if the device is not
writable. This might cause a trivial waste of CPU cycles of hibernate
allocation raced with swapoff, but that is very unlikely to happen.
Removing the check on the common path should be more helpful.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 32e0e7545ab8..ea63885f344a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1931,35 +1931,30 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	struct swap_cluster_info *ci;
 	swp_entry_t entry = {0};
 
-	if (!si)
-		goto fail;
-
-	/* This is called for allocating swap entry, not cache */
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
-		}
-		put_swap_device(si);
+	/* Return empty entry if device is not usable (swapoff or full) */
+	if (!si || !get_swap_device_info(si))
+		return entry;
+	/*
+	 * Try the local cluster first if it matches the device. If
+	 * not, try grab a new cluster and override local cluster.
+	 */
+	local_lock(&percpu_swap_cluster.lock);
+	pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
+	pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
+	if (pcp_si == si && pcp_offset) {
+		ci = swap_cluster_lock(si, pcp_offset);
+		if (cluster_is_usable(ci, 0))
+			offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
+		else
+			swap_cluster_unlock(ci);
 	}
-fail:
+	if (offset == SWAP_ENTRY_INVALID)
+		offset = cluster_alloc_swap_entry(si, NULL);
+	local_unlock(&percpu_swap_cluster.lock);
+	if (offset)
+		entry = swp_entry(si->type, offset);
+	put_swap_device(si);
+
 	return entry;
 }
 

-- 
2.52.0



