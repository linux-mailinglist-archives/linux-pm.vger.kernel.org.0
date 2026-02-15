Return-Path: <linux-pm+bounces-42668-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CFpDsqqkWkrlQEAu9opvQ
	(envelope-from <linux-pm+bounces-42668-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 12:15:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877D13E91D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 12:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BFAC300D16B
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D23A2ECD3A;
	Sun, 15 Feb 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsCTYJ6u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E81283FCD;
	Sun, 15 Feb 2026 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771154109; cv=none; b=KP+i8g7nvPRe0AIHopkiO48rLDd3j1lGxB/DxasWx2/KdrZ5lBywLPxcn/57iBggThyFV5QyNJ0go2kisOVUIvWxKWasCEznX0BOPQBm0++kll+FqsFaMCIzHTnFWqZpoI1uQhaJtl6AwkYFOvz3b/0CZSoTG0L/U1mRQTF7Jk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771154109; c=relaxed/simple;
	bh=rj046hNjbOH1lmWPWDKklrmTWcUTpwf0i1/a8aP/h7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7zGqrhVTrG0OzBpOaSS+4H0O2zFRl/uZJZcJcFYO6AWEZ8E/RtFTggy5RxZNjMUBgGn9owLbsaRbSou8xm9sxmlykLGNYMEYqYnIL2ihleenFTJP7TtTGH/l1CRcutr4LQq2+O6AfcTDKkxlq8RhpphCkS8HzmY84Q7+J+KSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsCTYJ6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C33BEC19424;
	Sun, 15 Feb 2026 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771154108;
	bh=rj046hNjbOH1lmWPWDKklrmTWcUTpwf0i1/a8aP/h7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UsCTYJ6uiT1fnusVLr6iO9cPe+D5snPjE0r3u+CMbfB3SB5E2hJlFaINxDxR3g1WN
	 EqBM0CBysyUKaKVLx34jRqzLI6X6DwT2fOVDBKOLlHG6MtKEbOPonGUjpZ1Df5g0/x
	 36c5xBVTdpkebF74/qR7PfKM4ccO895jWdO9Zv+c9iTbLC6W35XYAlqcF8W5C6aykk
	 WBHpZdSOL8oYVQ9RT9WdhrI+VUNT+PNDiuKZ23CrUVyaTmB11xr3fnZv2RI3Z//0Ls
	 srnfD3ztBxmDMtRXUqpxChGaHQ9PgHZORZZYX+/tKNY4j4ymh6rP9LLyF/qShpN7h8
	 6HLyxutdqj9Eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4867EF5871;
	Sun, 15 Feb 2026 11:15:08 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sun, 15 Feb 2026 19:15:05 +0800
Subject: [PATCH v2 1/2] mm, swap: speed up hibernation allocation and
 writeout
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260215-hibernate-perf-v2-1-cf28c75b04b7@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771154107; l=3113;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=Lqqj4GocBbtPo/Q6I8AjVH970KtvanM4t/1TnJHKDrM=;
 b=EpCLE5H04BAylOQNWpLPoxj5u9nPLrq+LbMZinNLU/K4CSdq71oYjaopYXop6gF6S5NpGJfgR
 SO8ww0w0vYPCYtlq+EW3xm4tdB3STO2C2Cq9S51M63A+gsKjL5fm8qY
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42668-lists,linux-pm=lfdr.de,kasong.tencent.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9877D13E91D
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
hibernation has been using the swap slot slow allocation path for
simplification, which turns out might cause regression for some
devices because the allocator now rotates clusters too often, leading to
slower allocation and more random distribution of data.

Fast allocation is not complex, so implement hibernation support as
well.

And reduce the indent of the code too, while at it. It doesn't have to
check the device flag, as the allocator will also check the device flag
and refuse to allocate if the device is not writable.

Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
performance is several times better [1]:
6.19:               324 seconds
After this series:  35 seconds

Fixes: 0ff67f990bd4 ("mm, swap: remove swap slot cache")
Reported-by: Carsten Grohmann <carstengrohmann@gmx.de>
Closes: https://lore.kernel.org/linux-mm/20260206121151.dea3633d1f0ded7bbf49c22e@linux-foundation.org/
Link: https://lore.kernel.org/linux-mm/8b4bdcfa-ce3f-4e23-839f-31367df7c18f@gmx.de/ [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c6863ff7152c..bcac10d96fb5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1926,8 +1926,9 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 /* Allocate a slot for hibernation */
 swp_entry_t swap_alloc_hibernation_slot(int type)
 {
-	struct swap_info_struct *si = swap_type_to_info(type);
-	unsigned long offset;
+	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
+	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
+	struct swap_cluster_info *ci;
 	swp_entry_t entry = {0};
 
 	if (!si)
@@ -1935,17 +1936,26 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 
 	/* This is called for allocating swap entry, not cache */
 	if (get_swap_device_info(si)) {
-		if (si->flags & SWP_WRITEOK) {
-			/*
-			 * Grab the local lock to be compliant
-			 * with swap table allocation.
-			 */
-			local_lock(&percpu_swap_cluster.lock);
-			offset = cluster_alloc_swap_entry(si, NULL);
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
+		if (offset)
+			entry = swp_entry(si->type, offset);
+		local_unlock(&percpu_swap_cluster.lock);
+
 		put_swap_device(si);
 	}
 fail:

-- 
2.52.0



