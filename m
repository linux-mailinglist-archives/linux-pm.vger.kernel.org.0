Return-Path: <linux-pm+bounces-42273-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEvNNykHiWnK1QQAu9opvQ
	(envelope-from <linux-pm+bounces-42273-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 22:59:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADDD10A4D8
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 22:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4341830039A9
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 21:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7CB360746;
	Sun,  8 Feb 2026 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auk1PhKB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90935EDD0
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587934; cv=none; b=L9KhSHZlEVYbG4YwXdhUVSZw9lyBhITi6wG14rQDmkzcxCWqqOulfDdmtCfTh9GvZ7693I9fSfXNhuGoaYrnlL9xDNAxBHMiYoB/nE4FSQg29cDULSTlUwkyGpA+T1OPVw+Mixw9115w1uekQ1Kku9sDQhfCL19SkxjBAXIcy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587934; c=relaxed/simple;
	bh=0Qlnn/0vz2JKpfqCrEGnXX7iDLpsICWEjt16tSDKWL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mn3s3xZSRJTkYKh/n0k8MnVe859VR5JtFuSeVm2BIAKqVHBr5uZXLhTKw5O5HYqPWfE4jw8E23OHNG7We4zetlHVP+226i5xyNBgLYdmZGGGbsJkkRsf7aArY/Ra+ug/+bwu0iUR3UG6F36fEkgewSGzKldm8zzH8COAd0knfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auk1PhKB; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d45d37c7a0so1532731a34.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587933; x=1771192733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCzAnUs0VtYcvzowlURB7PfVAQtyZ2LBB9m2XBAedLE=;
        b=auk1PhKBsxYRqxltOAaKXLjVDOEyDZzUzj+JtX9LUrCIFQF6bPF3dQtuyKXu9m81lc
         HU+U6FZm+FVJ7ReOUrZAre86MqCAZb/GWCrca75duv26SnzT71VUJnKRguKo1lW3OXQt
         qxO8f76iq2LmBt1xinTij06Pzn15DXRbB5RXImlM+jtUNmH7VfG62r2fwqeqCr2ez6Au
         UW99SgG2RwT3UbOka+bzbjE+lVI8DwwGce1GtXmergMXXhvOyG+bygae8VqilBkx+lTZ
         koeL0xYPYb5/+oH3vf1joCTAIPEM2KhGvxfcMDDlsxPNmZUlpsrS9IpF/nBNswO0DEWb
         eAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587933; x=1771192733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCzAnUs0VtYcvzowlURB7PfVAQtyZ2LBB9m2XBAedLE=;
        b=MtCZy4Gdpmi3QVXTi+DE0KiIB4jlmbakbuM6Quk4bkS8x6XSFTzSug7XWAfayjjsYb
         JAsw79le/bDKfNSmjVDu6Y/64gia/V1b/+xGe1LkrpYQev+2k/dSHr7RwqqULskhQsrd
         ihbu+hWUewFPH+fnXvo+ev/I1czMTHs0vId5nWz26/AX9zZhjpHGoT9NNjfwn80ogvHD
         jemq9s73Vsd+QjdnPoHyJ6qU04N2T2Co9hf38jA3jsOjtHVv4DdIQHQ7ryhQlUI9ZDkk
         TZeRxXJGK8+QOeL5jeDqyUf4TsA63XWs/Jr1N9j3P0iT2bM5FM3zDndnLa31YkDBQje6
         /PkA==
X-Forwarded-Encrypted: i=1; AJvYcCXDWhtM62QlWwZQ6DxAd4qPWgWRiTit3fsf+wQ1zvXVClwxhNb5WvjFlZ3RFyF3g4COcK4sGBhWbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztjsw59dP9PbYPJYVHcXfbw7GbJz48IR0XRO/X7K0twm2cNuLr
	z9l5Hs+W/4sPSO/Q4yAHV+gXw/bCxQgGuYIAQMYQBzLA9q6+ps7NSVv6
X-Gm-Gg: AZuq6aLsL7tnCBFRsUjLzo5fAetjS6ysnWIaneh81WhQnjOrfdKQ6LMLiEjPPoHQwVc
	LTJCz6mddYylUX4uMm/d6Bezdj2iyl/BABL21XM2tifUGU9NAYJIBbwz3TDcOjoiHtthkgaI5XM
	3zCHKDfqizar6GavA3rvbmTlIDOJa2JBPZriQphBjSz56FGYpoG2FGFUY90igjzxvnwZbEP+ETA
	+ZdjkndgJbA+0hJTvMVgeBgTTeu036+lP/n+bD3env7KT+gl9Ynzt0Z8bzf/LE3jf9j7APu27Wd
	4MBSDGimO6B5HvaCq2MhNHPQYmyw5crhn0mwpP+r98K1MTEz5AgFQDYe2msUlXfuCxpLMyKfQlX
	s1l24m604Eoj7gbq0w8zpLeSdroh8nAKP4EEXtuiRmF2V6tOMYCzIMbksJeUa/XpikwefHGee8T
	eRNvmMhB2gJcm6JFodlf4YmzFMdyDnT437mQ==
X-Received: by 2002:a05:6820:1514:b0:662:c369:8af1 with SMTP id 006d021491bc7-66d0d5e38b6mr4727396eaf.78.1770587933119;
        Sun, 08 Feb 2026 13:58:53 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d3adcae3csm5051168eaf.9.2026.02.08.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:58:52 -0800 (PST)
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
Subject: [PATCH v3 05/20] mm/swap: add a new function to check if a swap entry is in swap cached.
Date: Sun,  8 Feb 2026 13:58:18 -0800
Message-ID: <20260208215839.87595-6-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42273-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ADDD10A4D8
X-Rspamd-Action: no action

Userfaultfd checks whether a swap entry is in swapcache. This is
currently done by directly looking at the swapfile's swap map - however,
the swap cached state will soon be managed at the virtual swap layer.
Abstract away this function.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  6 ++++++
 mm/swapfile.c        | 15 +++++++++++++++
 mm/userfaultfd.c     |  3 +--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3da637b218baf..f91a442ac0e82 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -435,6 +435,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int __swap_count(swp_entry_t entry);
 bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 int swp_swapcount(swp_entry_t entry);
+bool is_swap_cached(swp_entry_t entry);
 
 /* Swap cache API (mm/swap_state.c) */
 static inline unsigned long total_swapcache_pages(void)
@@ -554,6 +555,11 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
+static inline bool is_swap_cached(swp_entry_t entry)
+{
+	return false;
+}
+
 static inline int folio_alloc_swap(struct folio *folio)
 {
 	return -EINVAL;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cacfafa9a540d..3c89dedbd5718 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -194,6 +194,21 @@ static bool swap_only_has_cache(struct swap_info_struct *si,
 	return true;
 }
 
+/**
+ * is_swap_cached - check if the swap entry is cached
+ * @entry: swap entry to check
+ *
+ * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
+ *
+ * Returns true if the swap entry is cached, false otherwise.
+ */
+bool is_swap_cached(swp_entry_t entry)
+{
+	struct swap_info_struct *si = __swap_entry_to_info(entry);
+
+	return READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE;
+}
+
 static bool swap_is_last_map(struct swap_info_struct *si,
 		unsigned long offset, int nr_pages, bool *has_cache)
 {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 25f89eba0438c..98be764fb3ecd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1190,7 +1190,6 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 		 * Check if the swap entry is cached after acquiring the src_pte
 		 * lock. Otherwise, we might miss a newly loaded swap cache folio.
 		 *
-		 * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
 		 * We are trying to catch newly added swap cache, the only possible case is
 		 * when a folio is swapped in and out again staying in swap cache, using the
 		 * same entry before the PTE check above. The PTL is acquired and released
@@ -1200,7 +1199,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 		 * cache, or during the tiny synchronization window between swap cache and
 		 * swap_map, but it will be gone very quickly, worst result is retry jitters.
 		 */
-		if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {
+		if (is_swap_cached(entry)) {
 			double_pt_unlock(dst_ptl, src_ptl);
 			return -EAGAIN;
 		}
-- 
2.47.3


