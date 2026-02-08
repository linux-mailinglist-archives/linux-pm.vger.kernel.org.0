Return-Path: <linux-pm+bounces-42284-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGlqE7wHiWnK1QQAu9opvQ
	(envelope-from <linux-pm+bounces-42284-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 23:01:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B53BA10A58C
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 23:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C665D3009813
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 21:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8536EAA2;
	Sun,  8 Feb 2026 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc+40F81"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5295A36E49B
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587956; cv=none; b=Jl/qEwpzcsyr8UzFIWKZc9JvSKW0cnaU7BfZ+hTEcnyldnvC13MRDo39Jo/IJ4NGXC/HUWp1z6HiCv9dXrUAgwogubX/IKzgPsjKp44Zo8Wf0GWFlO7aYGLHtqMuzSAaxDBPmd3HItGpLkVQ/F2RJO9+u6eDPoc8x49dKzF52vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587956; c=relaxed/simple;
	bh=ivEurp8BxVVC73UF2YIA0sGKcn4Rvv3bpTlATH+RAvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQLPf993TaCUR8DmoeO3Fz4xHRVlttsGmPkr/xCxyUVaqAtC9SQMmxJw3ZOvidMT/5SSWrmoyHAfv7xnj9mi5E9s9BWzzSCgUMDla+r0lxKEIr1/Sr+OsKhi3ahDMkk/cuc0YVZEgyLysxDegzcmCUorDeRjBiGK1J3/PgEs6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc+40F81; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45f004e7d71so3268379b6e.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587955; x=1771192755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcq3gcBJps8FZtjddhB+nxOnBeH87BfFsdWVB5x664k=;
        b=dc+40F81wBkKVyu/C1B8+cc6caEzLYJpuLJ5W1W7TCSfYcL1XO+XOyilRv9LlWonXn
         35OOuT+QXQwaq/ALiu5BGgNmHiH4aHE1ssRQ/wuGyDbuYl8OjY7NbztQKhaua5sfltdo
         nmO6h++U9Ff/Bh4Vz4432XeartFzGtpqOWE5AILXz9GTAHyY96PfJHcp/pbPa5W7R3we
         bepL9sYvx5RYKRzzm3zfgHPmkK2NSfPGLr15A/g4gPdNT+0qMSaxtuLX2Bo57nZWLgLg
         0kA67K/WKPLEY6Oys0CBHHMbmT3EwDh3UQXzktcSbFe+ZSwRMVDQlHH5sGZw+JYExWfU
         lpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587955; x=1771192755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jcq3gcBJps8FZtjddhB+nxOnBeH87BfFsdWVB5x664k=;
        b=KNY0zQIkBJyzUWryvpWiWfdPZUdPIzoLrdWYcXx6NjPt5LLhaI9aEkkDc3Ql+9myqu
         AU6Gbo41rmhnMUVi76Lysezlg8Swr7kacrW68KEzyyqi/xdk2njL1v6V5+4UdRU/pKVg
         urGVBoylEb52/OzuJZ4t1AXWboiUHsBWlG0P9QXzj8w9ktySdYyNsdQyT1HgUfXU1RvG
         W2PfhyA/kkTRIrb2KUTWK1vJVBXAZGTZLyo1UW9p3c501sbjqJTs45BbDi3zvEJGl5oZ
         pZGRoaIP/patHLGDW05rgvWyfu4HFUvnAhNuVyszNAXk+aqg/SN2lf8OQI06fDkbqqvB
         hWIA==
X-Forwarded-Encrypted: i=1; AJvYcCW3yOr0J/j8SvL2z41wgiUktGF6F0MrJIk8l+x2EDVtecDtDYVGLx6lvB8g4xj0VZ1RE5ehCB6GJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUPevCr4Sa0JvJ28jUr/MD1jcJKW61uypyt+eI5gWFTPmKEXw
	0GKuzNUgxdxBT52I92IKvSjeVHfnQdOOsgaVEkfLGcAWVFELQGQC7ZEG
X-Gm-Gg: AZuq6aIlRmc7EbC/czU5LMjvU1xzClUbsSOzVhykoHEjq1w+6FOkuQjtqCNLJp9tN2t
	pYPQ/Zol3XQbrtiuWPub1dnVvc0KmIcw5AqIQ2FLncxImDPNMOuuJVSnkw1YAOST9HHpUcpD2lh
	i5xSN7GwMrxyNm5X5vEBnmwNpHPzY1Zs7t49G2ofzBEOHRppecsBApt54QyR6l6rhiA+uX0MrzR
	IbnLm2p8PyNpP8117rPC/Lc2lqRPQKCm2t9IhbLcgtqyZnZ1r5JQsgehwwMvCBIlm/8Pz92b58y
	ibGtmq0KQPhXCnkRbX/UZoAVs3hsH1eJiWZVX17XL5QaQGZ5OI0h3IUPIg/iIMY6dQg/GtOaa32
	CiSs5ynvvF6Ri4pCGMZaS57vvrP/NhoCstwaoJbat7U3YkNMyUp5BJVXfB7VkrQWd0hKOk7yNqn
	7WU1JFLWUEvrJVgqATc/UgHfJG4iQIhV5q
X-Received: by 2002:a05:6808:2220:b0:45f:103c:2483 with SMTP id 5614622812f47-462fcbe429bmr4183659b6e.23.1770587955253;
        Sun, 08 Feb 2026 13:59:15 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462fe9a12f5sm5510710b6e.5.2026.02.08.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:59:14 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 16/20] swap: do not unnecesarily pin readahead swap entries
Date: Sun,  8 Feb 2026 13:58:29 -0800
Message-ID: <20260208215839.87595-17-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42284-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B53BA10A58C
X-Rspamd-Action: no action

When we perform swap readahead, the target entry is already pinned by
the caller. No need to pin swap entries in the readahead window that
belongs in the same virtual swap cluster as the target swap entry.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap.h       |  1 +
 mm/swap_state.c | 22 +++++++++-------------
 mm/vswap.c      | 10 ++++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index d41e6a0e70753..08a6369a6dfad 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -213,6 +213,7 @@ void swap_cache_lock(swp_entry_t entry);
 void swap_cache_unlock(swp_entry_t entry);
 void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 			   unsigned long vswap, int nr);
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2);
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ad80bf098b63f..e8e0905c7723f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -553,22 +553,18 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		/*
-		 * Readahead entry may come from a device that we are not
-		 * holding a reference to, try to grab a reference, or skip.
-		 *
-		 * XXX: for now, always try to pin the swap entries in the
-		 * readahead window to avoid the annoying conversion to physical
-		 * swap slots. Once we move all swap metadata to virtual swap
-		 * layer, we can simply compare the clusters of the target
-		 * swap entry and the current swap entry, and pin the latter
-		 * swap entry's cluster if it differ from the former's.
+		 * The target entry is already pinned - if the readahead entry
+		 * belongs to the same cluster, it's already protected.
 		 */
-		swapoff_locked = tryget_swap_entry(entry, &si);
-		if (!swapoff_locked)
-			continue;
+		if (!vswap_same_cluster(entry, targ_entry)) {
+			swapoff_locked = tryget_swap_entry(entry, &si);
+			if (!swapoff_locked)
+				continue;
+		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
-		put_swap_entry(entry, si);
+		if (swapoff_locked)
+			put_swap_entry(entry, si);
 		if (!folio)
 			continue;
 		if (page_allocated) {
diff --git a/mm/vswap.c b/mm/vswap.c
index fb6179ce3ace7..7563107eb8eee 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -1503,6 +1503,16 @@ void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si)
 	rcu_read_unlock();
 }
 
+/*
+ * Check if two virtual swap entries belong to the same vswap cluster.
+ * Useful for optimizing readahead when entries in the same cluster
+ * share protection from a pinned target entry.
+ */
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2)
+{
+	return VSWAP_CLUSTER_IDX(entry1) == VSWAP_CLUSTER_IDX(entry2);
+}
+
 static int vswap_cpu_dead(unsigned int cpu)
 {
 	struct percpu_vswap_cluster *percpu_cluster;
-- 
2.47.3


