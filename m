Return-Path: <linux-pm+bounces-42672-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5+o3C+EXkmmuqwEAu9opvQ
	(envelope-from <linux-pm+bounces-42672-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 20:00:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9B713F776
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 20:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0621B300D316
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792C219A71;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy5R6kes"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546CB139D;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771182046; cv=none; b=bCYNTt/KK30WKylSsBqBqhfoy0i9YaFhu0KlzXrRuJge7MDoL9UUrGT9HT+7EBdj/+XG1K6nzTjBCtLqBktz+3RMQ46zHYobpF4EkRfq7IBGK/6MX5uVa6eu9kFpfsi2gqSpSW/1F2Eu3R5K2gHOzjjAXFOU+L6mrWOVEs75ipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771182046; c=relaxed/simple;
	bh=wTK7vBuck4Wc7Ro9R5Mj7NtxqG8AwnxBtxe5boxsbpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KB2AGm9/SlRc6sXctE1uHiRInheJSh+e0TMDBdq36xfoDnd/eoxxyJtGInXC6ZZSvkNjMsuXw4uPwtsBCu077PLVykUvcYTaauWnVXM8wLAqNnYyxuXpueimSnn4sqEuHUcS41Ed5WBWPrr3vOmyYCuUrbmH1ocUYS+KDIQkI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy5R6kes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC65C2BC9E;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771182046;
	bh=wTK7vBuck4Wc7Ro9R5Mj7NtxqG8AwnxBtxe5boxsbpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Yy5R6kesqXoXrKVqGCGp5zq3jrg/VndrjGUBKAr8JT4PCjKGWdbKMERn2zxgL2idJ
	 yP1B81Yw5ciDuiv+2g/So47K/CKdDRWqf0ZGGFmXUEHXcrf+OzSb2gvAAt4TQeC4NP
	 I/WbY9lXtMfGrnEYlVhcYoqECKhBxBh3IE6SDkk+BXvl2iCXIb4FawMc8kalGsddXD
	 ClY3vsvesSt5C2yOpuhsxXlr8D55ngbl0X95ENihFBBDSHoBD9wJAqPE+W5sU0g3AE
	 5l5LF3zTmR75OezDvm6ghrqACFv6PbduaalVm1nY+oGuOTVjmb2yQiq2AqxoBeUDFv
	 RbnpOGQAryVqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC9E63F0D;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Mon, 16 Feb 2026 03:00:26 +0800
Subject: [PATCH v3 2/3] mm, swap: reduce indention for hibernate allocation
 helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-hibernate-perf-v3-2-74e025091145@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771182044; l=2326;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=Er50BTm1CADsw8Sf6/HAwSuhm/4o2yVx7I3U3KWBPIc=;
 b=6R485nSU2o2bmlUPNO4K/iY50QRPl1rzZbPFloZdqJyaeo0dg917Z8y+N6oHRTJOmKCc6S34d
 Ve2gyLpXehHAoSL7/gdAVeYQ3DnjFmOPgzF2YvNccJWX9JFH6/o6w4w
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
	TAGGED_FROM(0.00)[bounces-42672-lists,linux-pm=lfdr.de,kasong.tencent.com];
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
X-Rspamd-Queue-Id: 7A9B713F776
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

It doesn't have to check the device flag, as the allocator will also
check the device flag and refuse to allocate if the device is not
writable. This might cause a trivial waste of CPU cycles of hibernate
allocation raced with swapoff, but that is very unlikely to happen.
Removing the check on the common path should be more helpful.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 32e0e7545ab8..0d1b17c99221 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1936,27 +1936,25 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 
 	/* This is called for allocating swap entry, not cache */
 	if (get_swap_device_info(si)) {
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
+		if (!offset)
+			offset = cluster_alloc_swap_entry(si, NULL);
+		local_unlock(&percpu_swap_cluster.lock);
+		if (offset)
+			entry = swp_entry(si->type, offset);
 		put_swap_device(si);
 	}
 fail:

-- 
2.52.0



