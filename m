Return-Path: <linux-pm+bounces-42664-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YoTnGzKikWnnkwEAu9opvQ
	(envelope-from <linux-pm+bounces-42664-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:38:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5613E7DD
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF0A3011862
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34692284884;
	Sun, 15 Feb 2026 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikrL8ZZt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC225228D
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771151919; cv=none; b=Ast9yy+z+y0zXPQVCftBtW/ygdkzCNHM2WhmaozZcHknuDY5P8vsP8Iih0y6gbUtMlKKsfQ5TeX1/69zKAaI79ii1scwUIn1P2Ir1MgG6W3/yi6OoM1GnGPSUAtAU1IFdjlQOxJCTPCHf0zPe4eryG/HE6x9m7tf3AMvcBCM6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771151919; c=relaxed/simple;
	bh=p+cec/aodda6p9z15PbtOD06+rlGgjcagQZkqKkBgJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+p1S736o6fJ6JTKCHMlI7hEiRG+kqF5KgI/I0ZEMwdrbqN9Tmdg1L21Sw4ktQx4d+f6NgXOi83A2g8qFiwStUWEsbRNOL9q2l64FpDwRNHR+c/XwENSWmiK8FgfQnfQAWtrpsUV4jvbEiCs5jLJp7m9x46oOsvADbJDwrzQLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikrL8ZZt; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-824b05d2786so1741575b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 02:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771151917; x=1771756717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9xfddMpTBkv4yU1TaSitiYJz3pzQM97yNutklwj4FDs=;
        b=ikrL8ZZt+yX5EOMNgPMqs99pdNwwtv58dNnFBukBHlgvnfmpXNTLDfD71pi0sN4Nn+
         02N/wK7f6E1mDdSvzQTlaD+85RJU2u+lOQXMiK4OOlvgvjX/dmcDIxR53PLPIm/uSZvs
         9KiCfaOY0dannL0wMSp2kfCHpRqon7BS0pzCwPmslox1ffIWd2JN6Eu12PK05BJM/3Cr
         wjnyzCaP0QLAVvGRhrbnvTdVpRJybZA3gVE+tQZFbejv1xXjvJaZhJBNF3fDiegLKEPE
         HNOCUo6lF4mh0vZ+HsEMsbOzJJczdDPHxIP01Kb8Bb9LZEhzzINkttMy7fuNv3oCS3TF
         1grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771151917; x=1771756717;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xfddMpTBkv4yU1TaSitiYJz3pzQM97yNutklwj4FDs=;
        b=CZWV7NrMOiOPaTHVkSdxvChLhar08PkKmxsTbQQEijAk64jzq/g88iMdy7SceIzS9t
         CYGblhRh67soaUn/137kdSjJiPZj4LiGqzXP940Uq3kC59fA31FRIlcyx25vx1rMDLpZ
         Wp7nO6c1CgFCF6sakkJx4Cynd09MHVLDnAjVwZZ4bV8hDYOb7dTYcsU0s1P7XWiHlV9D
         2VTgIbE2a67h4GZ13bidw484sKBCihTNRMkhlJqSxkEcFlzC0UVbWCW8e0NaJyIq90hD
         KV34+jRCl+nzTJ3QSuU2LIfxuaqyvMzcMEzYV8cms9DXVRgFvqlbtHJIL4HRbqzZhvlV
         ETuA==
X-Forwarded-Encrypted: i=1; AJvYcCVBY8QnbzaswyWqn9h/l+ciyZsbMocBixwxJMJbQzIh/FOyBe77tDSYtvr4gWU93bmaiDNW9+1tlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6h7XCd/lKSuZbHS1VGMV1nt3lKoGer1fz6dqohW/TbKZCtoJ
	v+T57Q2ybVv+N/gP1iLEV1JUKGwZbkOY+Jd0ICEtkpk5QXky7Gr8Wsq5
X-Gm-Gg: AZuq6aJ8Mq/2nSJDZDPFVIcvGdKYd9CK5+RbkIomUpcw4kdtw9arUiRR4jv45LKuw49
	Dk8tpLmjczTslwojMkTuTG4NDsFF4INtqFE+N9D3TT8WuROC/oNj69OpegRtT+98WEKjMTvw8NR
	dGz2RirluNE4wcvbGlbCRzUOKOr+qRC+MxLsO1QVqniHQs5yBMCobdwG9qTcOmVUHUYgE1pJ/i7
	JG2CpgyYbvk4Rywfa8VuvP8ImZMN2EW8YEhxS8+1bXTErjovONXFYS80CsW5RrXWsyg++aHeE4V
	Us4jRIrQG3AaHsqHn7Cl31E6QrEyQNUkVZA0rNmHkvZzXNbD1AFWwaLVUWNfAUxj9TpdQy7OsQ+
	oCglGc6SSu+/JEfTjcws0JKUdh8d8owXJC0/2z2SWTRNQoB+h2tYvDoOLW5XPouWng5+rJmj5Za
	RK3RWFkvniJ8bsUAwhGAHtXJdwLAADe64BOWRMU25F5C+ubDt3raq4WKgCim3Xf0KUcPSIQan85
	X8=
X-Received: by 2002:a05:6a00:3699:b0:81f:eb35:69ef with SMTP id d2e1a72fcca58-824c95be066mr7117872b3a.40.1771151917075;
        Sun, 15 Feb 2026 02:38:37 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb5acesm8165660b3a.63.2026.02.15.02.38.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Feb 2026 02:38:36 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Carsten Grohmann <carstengrohmann@gmx.de>,
	linux-kernel@vger.kernel.org,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/2] mm, swap: simplify checking if a folio is swapped
Date: Sun, 15 Feb 2026 18:38:14 +0800
Message-ID: <20260215103815.87329-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com>
References: <20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,gmx.de,vger.kernel.org,tencent.com];
	TAGGED_FROM(0.00)[bounces-42664-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:replyto,tencent.com:email]
X-Rspamd-Queue-Id: B7E5613E7DD
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Clean up and simplify how we check if a folio is swapped. The helper
already requires the folio to be in swap cache and locked. That's enough
to pin the swap cluster from being freed, so there is no need to lock
anything else to avoid UAF.

And besides, we have cleaned up and defined the swap operation to be
mostly folio based, and now the only place a folio will have any of its
swap slots' count increased from 0 to 1 is folio_dup_swap, which also
requires the folio lock. So as we are holding the folio lock here, a
folio can't change its swap status from not swapped (all swap slots have
a count of 0) to swapped (any slot has a swap count larger than 0).

So there won't be any false negatives of this helper if we simply depend
on the folio lock to stabilize the cluster.

We are only using this helper to determine if we can and should release
the swap cache. So false positives are completely harmless, and also
already exist before. Depending on the timing, previously, it's also
possible that a racing thread releases the swap count right after
releasing the ci lock and before this helper returns. In any case, the
worst that could happen is we leave a clean swap cache. It will still be
reclaimed when under pressure just fine.

So, in conclusion, we can simplify and make the check much simpler and
lockless. Also, rename it to folio_maybe_swapped to reflect the design.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h     |  5 ++--
 mm/swapfile.c | 82 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 9fc5fecdcfdf..3ee761ee8348 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -195,12 +195,13 @@ extern int swap_retry_table_alloc(swp_entry_t entry, gfp_t gfp);
  *
  * folio_alloc_swap(): the entry point for a folio to be swapped
  * out. It allocates swap slots and pins the slots with swap cache.
- * The slots start with a swap count of zero.
+ * The slots start with a swap count of zero. The slots are pinned
+ * by swap cache reference which doesn't contribute to swap count.
  *
  * folio_dup_swap(): increases the swap count of a folio, usually
  * during it gets unmapped and a swap entry is installed to replace
  * it (e.g., swap entry in page table). A swap slot with swap
- * count == 0 should only be increasd by this helper.
+ * count == 0 can only be increased by this helper.
  *
  * folio_put_swap(): does the opposite thing of folio_dup_swap().
  */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9628015fd8cf..cb18960a6089 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1743,7 +1743,11 @@ int folio_alloc_swap(struct folio *folio)
  * @subpage: if not NULL, only increase the swap count of this subpage.
  *
  * Typically called when the folio is unmapped and have its swap entry to
- * take its palce.
+ * take its place: Swap entries allocated to a folio has count == 0 and pinned
+ * by swap cache. The swap cache pin doesn't increase the swap count. This
+ * helper sets the initial count == 1 and increases the count as the folio is
+ * unmapped and swap entries referencing the slots are generated to replace
+ * the folio.
  *
  * Context: Caller must ensure the folio is locked and in the swap cache.
  * NOTE: The caller also has to ensure there is no raced call to
@@ -1944,49 +1948,44 @@ int swp_swapcount(swp_entry_t entry)
 	return count < 0 ? 0 : count;
 }
 
-static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
-					 swp_entry_t entry, int order)
+/*
+ * folio_maybe_swapped - Test if a folio covers any swap slot with count > 0.
+ *
+ * Check if a folio is swapped. Holding the folio lock ensures the folio won't
+ * go from not-swapped to swapped because the initial swap count increment can
+ * only be done by folio_dup_swap, which also locks the folio. But a concurrent
+ * decrease of swap count is possible through swap_put_entries_direct, so this
+ * may return a false positive.
+ *
+ * Context: Caller must ensure the folio is locked and in the swap cache.
+ */
+static bool folio_maybe_swapped(struct folio *folio)
 {
+	swp_entry_t entry = folio->swap;
 	struct swap_cluster_info *ci;
-	unsigned int nr_pages = 1 << order;
-	unsigned long roffset = swp_offset(entry);
-	unsigned long offset = round_down(roffset, nr_pages);
-	unsigned int ci_off;
-	int i;
+	unsigned int ci_off, ci_end;
 	bool ret = false;
 
-	ci = swap_cluster_lock(si, offset);
-	if (nr_pages == 1) {
-		ci_off = roffset % SWAPFILE_CLUSTER;
-		if (swp_tb_get_count(__swap_table_get(ci, ci_off)))
-			ret = true;
-		goto unlock_out;
-	}
-	for (i = 0; i < nr_pages; i++) {
-		ci_off = (offset + i) % SWAPFILE_CLUSTER;
-		if (swp_tb_get_count(__swap_table_get(ci, ci_off))) {
-			ret = true;
-			break;
-		}
-	}
-unlock_out:
-	swap_cluster_unlock(ci);
-	return ret;
-}
-
-static bool folio_swapped(struct folio *folio)
-{
-	swp_entry_t entry = folio->swap;
-	struct swap_info_struct *si;
-
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 
-	si = __swap_entry_to_info(entry);
-	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(folio)))
-		return swap_entry_swapped(si, entry);
+	ci = __swap_entry_to_cluster(entry);
+	ci_off = swp_cluster_offset(entry);
+	ci_end = ci_off + folio_nr_pages(folio);
+	/*
+	 * Extra locking not needed, folio lock ensures its swap entries
+	 * won't be released, the backing data won't be gone either.
+	 */
+	rcu_read_lock();
+	do {
+		if (__swp_tb_get_count(__swap_table_get(ci, ci_off))) {
+			ret = true;
+			break;
+		}
+	} while (++ci_off < ci_end);
+	rcu_read_unlock();
 
-	return swap_page_trans_huge_swapped(si, entry, folio_order(folio));
+	return ret;
 }
 
 static bool folio_swapcache_freeable(struct folio *folio)
@@ -2032,7 +2031,7 @@ bool folio_free_swap(struct folio *folio)
 {
 	if (!folio_swapcache_freeable(folio))
 		return false;
-	if (folio_swapped(folio))
+	if (folio_maybe_swapped(folio))
 		return false;
 
 	swap_cache_del_folio(folio);
@@ -3710,6 +3709,8 @@ void si_swapinfo(struct sysinfo *val)
  *
  * Context: Caller must ensure there is no race condition on the reference
  * owner. e.g., locking the PTL of a PTE containing the entry being increased.
+ * Also the swap entry must have a count >= 1. Otherwise folio_dup_swap should
+ * be used.
  */
 int swap_dup_entry_direct(swp_entry_t entry)
 {
@@ -3721,6 +3722,13 @@ int swap_dup_entry_direct(swp_entry_t entry)
 		return -EINVAL;
 	}
 
+	/*
+	 * The caller must be increasing the swap count from a direct
+	 * reference of the swap slot (e.g. a swap entry in page table).
+	 * So the swap count must be >= 1.
+	 */
+	VM_WARN_ON_ONCE(!swap_entry_swapped(si, entry));
+
 	return swap_dup_entries_cluster(si, swp_offset(entry), 1);
 }
 
-- 
2.52.0


