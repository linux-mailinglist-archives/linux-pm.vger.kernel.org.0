Return-Path: <linux-pm+bounces-24910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E53A7F14E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 01:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D15179390
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC9322DF97;
	Mon,  7 Apr 2025 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdQJu/R7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5A22A1ED;
	Mon,  7 Apr 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069351; cv=none; b=V95dc9YunJ5ToQYn23WanbGUg7+GHDefQpRuOsu6LkRRDeqi5VuAHUMjLluGXH9ik5yjXahNCMY2cSTFampTsih0MKWMMBJ1h7OAq9MiE5BIldTfGBvCw85SNLicLxTarr7bUNzcm/8ywFb4z+d9S5ZDvySSM6Zy07C7N0graQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069351; c=relaxed/simple;
	bh=xy3LsEKYZhRoi7k64bbUBrisG0EpYuzYPbq4cBwnDWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7BM+0ReG9hADF8NqVYQrkcz1zSVDJ6ttnKgAyqQbfchpKcHKBd6082uw2zOu4ahNxzZV0kh4CiPU9PUkSQEHsDCfxLKroNxWMhx8p7UE6q+/p0q+Kea4OashLjhGd0YgSAG3UCiiIMf3EpEowQqlYZDdlyzElJMhIWo+Qkp7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdQJu/R7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ef7c9e9592so47473407b3.1;
        Mon, 07 Apr 2025 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069346; x=1744674146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBlq/QOLg0r1TkYbb42kXekbd2GPTkfXKF/05r7LA1U=;
        b=bdQJu/R7MObGdEgL3OgO1+lVGOrNEXadz56dqOeM35tg90789KRm6Dl+ZQXWbkMmzN
         3APrF+8lZA8+uUTY5aXdIudI1IoIq/gPiiXDoAEhp5TARUI1EAnsn6AKGtQCtzQ76dJ8
         B0SMlCM50luZhhHHRtQ92vQczvqWmWQW7RHpm+x8XJouHqTute/KLdO7ApQpyAgEBmi7
         qB7WBCcZJQeZ3yfqzxW/98Wc91TADCSiktr5IzgnO86eO5IJZxz7asQFZmKeOs8WhP8L
         se9sjwiIm8b4y0H/d45IdycxIbt6qNGM2fssRbRVPd9w2cceg0kBOVe7oC8A6bNqvykJ
         Q5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069346; x=1744674146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBlq/QOLg0r1TkYbb42kXekbd2GPTkfXKF/05r7LA1U=;
        b=Fsvqxb2WZ6PnwU3wT1BJOcB5/2ek8Feg0xdd6E04Wr24KOzs6W5kMzm1fyjWR8u9/l
         BHf5i3ZKbBexuNJey3990Wds539dCoI4Vgnj4sMKenQ9FrlXds4WmJmu36GOxFuYDknV
         KSEq57xEr69T6AhNVaC987n7dusyUZDWKjq49E4YtxI+O390cwr+Ts47DssI7eaLKt82
         odCPPWR4pFIER1I64bgt+2TAdLgbIO36vxfy63C+ge9JNmfWYYbhVLLlCProsiTAK0pm
         r4x9xvRpShM5hFY6SRcNoda2oAbPWScaoYSEStQgsxhVKU6Z/41rVhTHY7+x+UTo24pf
         2jGw==
X-Forwarded-Encrypted: i=1; AJvYcCVsUTNgAOARntOUESNVgSdWD9Sh7IvDgjNkE4U1Z4Bgx3IfnQMy1Wa4HTNDFehHoqELD274QOTw@vger.kernel.org, AJvYcCW/z+crc6nc0TeH06mkoz/HPxeayhhSIWkl9WRViBMD/ZYDWjdAnQtLh6jILji7F9OyrS2cPPV9jcI=@vger.kernel.org, AJvYcCWmEoLU9zJKgt5H5fLCB3Y/1mwq+Z/+CPfpIYuQChX23VTaeuz5Mr+sV/y3Gz3RIBc0kqo4IyF0He7pNO5h@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7/l1hr4i1SlVHWxz69+ea0fgxZjAP7hf0022Laz6Toipexl5
	PLOlNbiQ+cAoE1Tb5uvlXwPK96vnKV+vyRKFoPxzFF1x8cVZ/ynk
X-Gm-Gg: ASbGncs8TYjka3vWwvDfdyu6puv7YujI9n6bliBNmF///c8grIKEdAv0JLQnBSTjKP7
	anlXbcptrqx8zZ9gbDq3Q/nqcAJB1quUiKDnbgig81ID5agxKfD1yWk+b0Qp0uicZMUQQcM1pPQ
	7iSEV6cvi9fElr5Yhu1D+3FL/RGAj6SkmPJTHI9EE1gLoJyNTOOcOI/Iaf9U6SIich8jpLnZEMU
	i3ToMpiANj7yw9XG8rnMfEyiiLPb16d7+CirEt6IeDjZiqGR/t5llY0oxASl+h7RTPlw7Ez4Bgx
	pZbg+3UNlk/9Vc7aO9DRFjhDir8+gbKp83o2
X-Google-Smtp-Source: AGHT+IHh0sZW9KLscMmSC5NY15HZ6AlEhuvPkp2qAIQa6K0Mbuwu6uf+9tY6ONNP9JcoArs/fMVUNQ==
X-Received: by 2002:a05:690c:6702:b0:6fb:1f78:d9ee with SMTP id 00721157ae682-703e15303a8mr274751557b3.15.1744069345957;
        Mon, 07 Apr 2025 16:42:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1fa9ec1sm27772987b3.112.2025.04.07.16.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:25 -0700 (PDT)
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
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 03/14] mm: swap: add a separate type for physical swap slots
Date: Mon,  7 Apr 2025 16:42:04 -0700
Message-ID: <20250407234223.1059191-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for swap virtualization, add a new type to represent the
physical swap slots of swapfile. This allows us to separates:

1. The logical view of the swap entry (i.e what is stored in page table
   entries and used to index into the swap cache), represented by the
   old swp_entry_t type.

from:

2. Its physical backing state (i.e the actual backing slot on the swap
   device), represented by the new swp_slot_t type.

The functions that operate at the physical level (i.e on the swp_slot_t
types) are also renamed where appropriate (prefixed with swp_slot_* for
e.g). We also take this opportunity to re-arrange the header files
(include/linux/swap.h and swapops.h), grouping the swap API into the
following categories:

1. Virtual swap API (i.e functions on swp_entry_t type).

2. Swap cache API (mm/swap_state.c)

3. Swap slot cache API (mm/swap_slots.c)

4. Physical swap slots and device API (mm/swapfile.c).

Note that we have not made any behavioral change - the mapping between
the two types is the identity mapping. In later patches, we shall
dynamically allocate a virtual swap slot (of type swp_entry_t) for each
swapped out page to store in the page table entry, and associate it with
a backing store. A physical swap slot (i.e a slot on a physical swap
device) is one of the backing options.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/mm_types.h   |   7 ++
 include/linux/swap.h       | 124 +++++++++++++------
 include/linux/swap_slots.h |   2 +-
 include/linux/swapops.h    |  25 ++++
 kernel/power/swap.c        |   6 +-
 mm/internal.h              |  10 +-
 mm/memory.c                |   7 +-
 mm/page_io.c               |  33 +++--
 mm/shmem.c                 |  21 +++-
 mm/swap.h                  |  17 +--
 mm/swap_cgroup.c           |  10 +-
 mm/swap_slots.c            |  28 ++---
 mm/swap_state.c            |  26 +++-
 mm/swapfile.c              | 243 ++++++++++++++++++++-----------------
 14 files changed, 351 insertions(+), 208 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0234f14f2aa6..7d93bb2c3dae 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -283,6 +283,13 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+/*
+ * Physical (i.e disk-based) swap slot handle.
+ */
+typedef struct {
+	unsigned long val;
+} swp_slot_t;
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index e479fd31c6d6..674089bc4cd1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -277,7 +277,7 @@ enum swap_cluster_flags {
  * cluster to which it belongs being marked free. Therefore 0 is safe to use as
  * a sentinel to indicate an entry is not valid.
  */
-#define SWAP_ENTRY_INVALID	0
+#define SWAP_SLOT_INVALID	0
 
 #ifdef CONFIG_THP_SWAP
 #define SWAP_NR_ORDERS		(PMD_ORDER + 1)
@@ -452,25 +452,45 @@ extern void __meminit kswapd_run(int nid);
 extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
-
-int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
-		unsigned long nr_pages, sector_t start_block);
-int generic_swapfile_activate(struct swap_info_struct *, struct file *,
-		sector_t *);
-
+/* Virtual swap API */
+swp_entry_t folio_alloc_swap(struct folio *folio);
+bool folio_free_swap(struct folio *folio);
+void put_swap_folio(struct folio *folio, swp_entry_t entry);
+int add_swap_count_continuation(swp_entry_t, gfp_t);
+void swap_shmem_alloc(swp_entry_t, int);
+int swap_duplicate(swp_entry_t);
+int swapcache_prepare(swp_entry_t entry, int nr);
+void swap_free_nr(swp_entry_t entry, int nr_pages);
+void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+int __swap_count(swp_entry_t entry);
+int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
+int swp_swapcount(swp_entry_t entry);
+
+/* Swap cache API (mm/swap_state.c) */
 static inline unsigned long total_swapcache_pages(void)
 {
 	return global_node_page_state(NR_SWAPCACHE);
 }
 
-void free_swap_cache(struct folio *folio);
 void free_page_and_swap_cache(struct page *);
 void free_pages_and_swap_cache(struct encoded_page **, int);
-/* linux/mm/swapfile.c */
+void free_swap_cache(struct folio *folio);
+int init_swap_address_space(unsigned int type, unsigned long nr_pages);
+void exit_swap_address_space(unsigned int type);
+
+/* Swap slot cache API (mm/swap_slot.c) */
+swp_slot_t folio_alloc_swap_slot(struct folio *folio);
+
+/* Physical swap slots and device API (mm/swapfile.c) */
+int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
+		unsigned long nr_pages, sector_t start_block);
+int generic_swapfile_activate(struct swap_info_struct *, struct file *,
+		sector_t *);
+
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
 extern atomic_t nr_rotate_swap;
-extern bool has_usable_swap(void);
+bool has_usable_swap(void);
 
 /* Swap 50% full? Release swapcache more aggressively.. */
 static inline bool vm_swap_full(void)
@@ -483,50 +503,37 @@ static inline long get_nr_swap_pages(void)
 	return atomic_long_read(&nr_swap_pages);
 }
 
-extern void si_swapinfo(struct sysinfo *);
-swp_entry_t folio_alloc_swap(struct folio *folio);
-bool folio_free_swap(struct folio *folio);
-void put_swap_folio(struct folio *folio, swp_entry_t entry);
-extern swp_entry_t get_swap_page_of_type(int);
-extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
-extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t, int);
-extern int swap_duplicate(swp_entry_t);
-extern int swapcache_prepare(swp_entry_t entry, int nr);
-extern void swap_free_nr(swp_entry_t entry, int nr_pages);
-extern void swapcache_free_entries(swp_entry_t *entries, int n);
-extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+void si_swapinfo(struct sysinfo *);
+swp_slot_t swap_slot_alloc_of_type(int);
+int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
+void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
+void swap_slot_cache_free_slots(swp_slot_t *slots, int n);
 int swap_type_of(dev_t device, sector_t offset);
+sector_t swapdev_block(int, pgoff_t);
 int find_first_swap(dev_t *device);
-extern unsigned int count_swap_pages(int, int);
-extern sector_t swapdev_block(int, pgoff_t);
-extern int __swap_count(swp_entry_t entry);
-extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
-extern int swp_swapcount(swp_entry_t entry);
-struct swap_info_struct *swp_swap_info(swp_entry_t entry);
+unsigned int count_swap_pages(int, int);
+struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot);
 struct backing_dev_info;
-extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
-extern void exit_swap_address_space(unsigned int type);
-extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot);
 sector_t swap_folio_sector(struct folio *folio);
 
-static inline void put_swap_device(struct swap_info_struct *si)
+static inline void swap_slot_put_swap_info(struct swap_info_struct *si)
 {
 	percpu_ref_put(&si->users);
 }
 
 #else /* CONFIG_SWAP */
-static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
+static inline struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot)
 {
 	return NULL;
 }
 
-static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
+static inline struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot)
 {
 	return NULL;
 }
 
-static inline void put_swap_device(struct swap_info_struct *si)
+static inline void swap_slot_put_swap_info(struct swap_info_struct *si)
 {
 }
 
@@ -575,7 +582,7 @@ static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 }
 
-static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
+static inline void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
 }
 
@@ -606,12 +613,24 @@ static inline bool folio_free_swap(struct folio *folio)
 	return false;
 }
 
+static inline swp_slot_t folio_alloc_swap_slot(struct folio *folio)
+{
+	swp_slot_t slot;
+
+	slot.val = 0;
+	return slot;
+}
+
 static inline int add_swap_extent(struct swap_info_struct *sis,
 				  unsigned long start_page,
 				  unsigned long nr_pages, sector_t start_block)
 {
 	return -EINVAL;
 }
+
+static inline void swap_slot_free_nr(swp_slot_t slot, int nr_pages)
+{
+}
 #endif /* CONFIG_SWAP */
 
 static inline void free_swap_and_cache(swp_entry_t entry)
@@ -706,16 +725,43 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+/**
+ * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
+ *                         virtual swap slot.
+ * @entry: the virtual swap slot.
+ *
+ * Return: the physical swap slot corresponding to the virtual swap slot.
+ */
+static inline swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
+{
+	return (swp_slot_t) { entry.val };
+}
+
+/**
+ * swp_slot_to_swp_entry - look up the virtual swap slot corresponding to a
+ *                         physical swap slot.
+ * @slot: the physical swap slot.
+ *
+ * Return: the virtual swap slot corresponding to the physical swap slot.
+ */
+static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
+{
+	return (swp_entry_t) { slot.val };
+}
+
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
 {
-	return get_swap_device(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+
+	*si = swap_slot_tryget_swap_info(slot);
+	return *si;
 }
 
 static inline void unlock_swapoff(swp_entry_t entry,
 				struct swap_info_struct *si)
 {
-	put_swap_device(si);
+	swap_slot_put_swap_info(si);
 }
 
 #endif /* __KERNEL__*/
diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index 840aec3523b2..1ac926d46389 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -13,7 +13,7 @@
 struct swap_slots_cache {
 	bool		lock_initialized;
 	struct mutex	alloc_lock; /* protects slots, nr, cur */
-	swp_entry_t	*slots;
+	swp_slot_t	*slots;
 	int		nr;
 	int		cur;
 	int		n_ret;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 96f26e29fefe..2a4101c9bba4 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -618,5 +618,30 @@ static inline int non_swap_entry(swp_entry_t entry)
 	return swp_type(entry) >= MAX_SWAPFILES;
 }
 
+/* Physical swap slots operations */
+
+/*
+ * Store a swap device type + offset into a swp_slot_t handle.
+ */
+static inline swp_slot_t swp_slot(unsigned long type, pgoff_t offset)
+{
+	swp_slot_t ret;
+
+	ret.val = (type << SWP_TYPE_SHIFT) | (offset & SWP_OFFSET_MASK);
+	return ret;
+}
+
+/* Extract the `type' field from a swp_slot_t. */
+static inline unsigned swp_slot_type(swp_slot_t slot)
+{
+	return (slot.val >> SWP_TYPE_SHIFT);
+}
+
+/* Extract the `offset' field from a swp_slot_t. */
+static inline pgoff_t swp_slot_offset(swp_slot_t slot)
+{
+	return slot.val & SWP_OFFSET_MASK;
+}
+
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 82b884b67152..32b236a81dbb 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -178,10 +178,10 @@ sector_t alloc_swapdev_block(int swap)
 {
 	unsigned long offset;
 
-	offset = swp_offset(get_swap_page_of_type(swap));
+	offset = swp_slot_offset(swap_slot_alloc_of_type(swap));
 	if (offset) {
 		if (swsusp_extents_insert(offset))
-			swap_free(swp_entry(swap, offset));
+			swap_slot_free_nr(swp_slot(swap, offset), 1);
 		else
 			return swapdev_block(swap, offset);
 	}
@@ -203,7 +203,7 @@ void free_all_swap_pages(int swap)
 
 		ext = rb_entry(node, struct swsusp_extent, node);
 		rb_erase(node, &swsusp_extents);
-		swap_free_nr(swp_entry(swap, ext->start),
+		swap_slot_free_nr(swp_slot(swap, ext->start),
 			     ext->end - ext->start + 1);
 
 		kfree(ext);
diff --git a/mm/internal.h b/mm/internal.h
index 20b3535935a3..2d63f6537e35 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -275,9 +275,13 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
  */
 static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
-	swp_entry_t entry = pte_to_swp_entry(pte);
-	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
-						   (swp_offset(entry) + delta)));
+	swp_entry_t entry = pte_to_swp_entry(pte), new_entry;
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	pte_t new;
+
+	new_entry = swp_slot_to_swp_entry(swp_slot(swp_slot_type(slot),
+			swp_slot_offset(slot) + delta));
+	new = swp_entry_to_pte(new_entry);
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
diff --git a/mm/memory.c b/mm/memory.c
index e92914df5ca7..c44e845b5320 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4125,8 +4125,9 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 {
-	struct swap_info_struct *si = swp_swap_info(entry);
-	pgoff_t offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *si = swap_slot_swap_info(slot);
+	pgoff_t offset = swp_slot_offset(slot);
 	int i;
 
 	/*
@@ -4308,6 +4309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	bool swapoff_locked = false;
 	bool exclusive = false;
 	swp_entry_t entry;
+	swp_slot_t slot;
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
@@ -4369,6 +4371,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapoff_locked = trylock_swapoff(entry, &si);
 	if (unlikely(!swapoff_locked))
 		goto out;
+	slot = swp_entry_to_swp_slot(entry);
 
 	folio = swap_cache_get_folio(entry, vma, vmf->address);
 	if (folio)
diff --git a/mm/page_io.c b/mm/page_io.c
index 9b983de351f9..182851c47f43 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -204,14 +204,17 @@ static bool is_folio_zero_filled(struct folio *folio)
 static void swap_zeromap_folio_set(struct folio *folio)
 {
 	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis =
+		swap_slot_swap_info(swp_entry_to_swp_slot(folio->swap));
 	int nr_pages = folio_nr_pages(folio);
 	swp_entry_t entry;
+	swp_slot_t slot;
 	unsigned int i;
 
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		entry = page_swap_entry(folio_page(folio, i));
-		set_bit(swp_offset(entry), sis->zeromap);
+		slot = swp_entry_to_swp_slot(entry);
+		set_bit(swp_slot_offset(slot), sis->zeromap);
 	}
 
 	count_vm_events(SWPOUT_ZERO, nr_pages);
@@ -223,13 +226,16 @@ static void swap_zeromap_folio_set(struct folio *folio)
 
 static void swap_zeromap_folio_clear(struct folio *folio)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis =
+		swap_slot_swap_info(swp_entry_to_swp_slot(folio->swap));
 	swp_entry_t entry;
+	swp_slot_t slot;
 	unsigned int i;
 
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		entry = page_swap_entry(folio_page(folio, i));
-		clear_bit(swp_offset(entry), sis->zeromap);
+		slot = swp_entry_to_swp_slot(entry);
+		clear_bit(swp_slot_offset(slot), sis->zeromap);
 	}
 }
 
@@ -358,7 +364,8 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		 * messages.
 		 */
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
-				   ret, swap_dev_pos(page_swap_entry(page)));
+				   ret,
+				   swap_slot_pos(swp_entry_to_swp_slot(page_swap_entry(page))));
 		for (p = 0; p < sio->pages; p++) {
 			page = sio->bvec[p].bv_page;
 			set_page_dirty(page);
@@ -374,10 +381,11 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 
 static void swap_writepage_fs(struct folio *folio, struct writeback_control *wbc)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
 	struct swap_iocb *sio = NULL;
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis = swap_slot_swap_info(slot);
 	struct file *swap_file = sis->swap_file;
-	loff_t pos = swap_dev_pos(folio->swap);
+	loff_t pos = swap_slot_pos(slot);
 
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
@@ -452,7 +460,8 @@ static void swap_writepage_bdev_async(struct folio *folio,
 
 void __swap_writepage(struct folio *folio, struct writeback_control *wbc)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis =
+		swap_slot_swap_info(swp_entry_to_swp_slot(folio->swap));
 
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
 	/*
@@ -543,9 +552,10 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
+	struct swap_info_struct *sis = swap_slot_swap_info(slot);
 	struct swap_iocb *sio = NULL;
-	loff_t pos = swap_dev_pos(folio->swap);
+	loff_t pos = swap_slot_pos(slot);
 
 	if (plug)
 		sio = *plug;
@@ -614,7 +624,8 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 
 void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	struct swap_info_struct *sis =
+		swap_slot_swap_info(swp_entry_to_swp_slot(folio->swap));
 	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
 	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
diff --git a/mm/shmem.c b/mm/shmem.c
index 8ef72dcc592e..f8efa49eb499 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1387,6 +1387,7 @@ static int shmem_find_swap_entries(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct folio *folio;
 	swp_entry_t entry;
+	swp_slot_t slot;
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, ULONG_MAX) {
@@ -1397,11 +1398,13 @@ static int shmem_find_swap_entries(struct address_space *mapping,
 			continue;
 
 		entry = radix_to_swp_entry(folio);
+		slot = swp_entry_to_swp_slot(entry);
+
 		/*
 		 * swapin error entries can be found in the mapping. But they're
 		 * deliberately ignored here as we've done everything we can do.
 		 */
-		if (swp_type(entry) != type)
+		if (swp_slot_type(slot) != type)
 			continue;
 
 		indices[folio_batch_count(fbatch)] = xas.xa_index;
@@ -1619,7 +1622,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (!swap.val) {
 		if (nr_pages > 1)
 			goto try_split;
-
 		goto redirty;
 	}
 
@@ -2164,6 +2166,7 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
 	void *alloced_shadow = NULL;
 	int alloced_order = 0, i;
+	swp_slot_t slot = swp_entry_to_swp_slot(swap);
 
 	/* Convert user data gfp flags to xarray node gfp flags */
 	gfp &= GFP_RECLAIM_MASK;
@@ -2202,11 +2205,14 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 			 */
 			for (i = 0; i < 1 << order; i++) {
 				pgoff_t aligned_index = round_down(index, 1 << order);
-				swp_entry_t tmp;
+				swp_entry_t tmp_entry;
+				swp_slot_t tmp_slot;
 
-				tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
+				tmp_slot =
+					swp_slot(swp_slot_type(slot), swp_slot_offset(slot) + i);
+				tmp_entry = swp_slot_to_swp_entry(tmp_slot);
 				__xa_store(&mapping->i_pages, aligned_index + i,
-					   swp_to_radix_entry(tmp), 0);
+					   swp_to_radix_entry(tmp_entry), 0);
 			}
 		}
 
@@ -2253,10 +2259,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct folio *folio = NULL;
 	bool skip_swapcache = false;
 	swp_entry_t swap;
+	swp_slot_t slot;
 	int error, nr_pages, order, split_order;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
 	swap = radix_to_swp_entry(*foliop);
+	slot = swp_entry_to_swp_slot(swap);
 	*foliop = NULL;
 
 	if (is_poisoned_swp_entry(swap))
@@ -2328,7 +2336,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		if (split_order > 0) {
 			pgoff_t offset = index - round_down(index, 1 << split_order);
 
-			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+			swap = swp_slot_to_swp_entry(swp_slot(
+					swp_slot_type(slot), swp_slot_offset(slot) + offset));
 		}
 
 		/* Here we actually start the io */
diff --git a/mm/swap.h b/mm/swap.h
index ad2f121de970..d5f8effa8015 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -32,12 +32,10 @@ extern struct address_space *swapper_spaces[];
 	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
 		>> SWAP_ADDRESS_SPACE_SHIFT])
 
-/*
- * Return the swap device position of the swap entry.
- */
-static inline loff_t swap_dev_pos(swp_entry_t entry)
+/* Return the swap device position of the swap slot. */
+static inline loff_t swap_slot_pos(swp_slot_t slot)
 {
-	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
+	return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
 }
 
 /*
@@ -78,7 +76,9 @@ struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
-	return swp_swap_info(folio->swap)->flags;
+	swp_slot_t swp_slot = swp_entry_to_swp_slot(folio->swap);
+
+	return swap_slot_swap_info(swp_slot)->flags;
 }
 
 /*
@@ -89,8 +89,9 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 		bool *is_zeromap)
 {
-	struct swap_info_struct *sis = swp_swap_info(entry);
-	unsigned long start = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *sis = swap_slot_swap_info(slot);
+	unsigned long start = swp_slot_offset(slot);
 	unsigned long end = start + max_nr;
 	bool first_bit;
 
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 1007c30f12e2..5e4c91d694a0 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -65,11 +65,12 @@ void swap_cgroup_record(struct folio *folio, unsigned short id,
 			swp_entry_t ent)
 {
 	unsigned int nr_ents = folio_nr_pages(folio);
+	swp_slot_t slot = swp_entry_to_swp_slot(ent);
 	struct swap_cgroup *map;
 	pgoff_t offset, end;
 	unsigned short old;
 
-	offset = swp_offset(ent);
+	offset = swp_slot_offset(slot);
 	end = offset + nr_ents;
 	map = swap_cgroup_ctrl[swp_type(ent)].map;
 
@@ -92,12 +93,12 @@ void swap_cgroup_record(struct folio *folio, unsigned short id,
  */
 unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents)
 {
-	pgoff_t offset = swp_offset(ent);
+	swp_slot_t slot = swp_entry_to_swp_slot(ent);
+	pgoff_t offset = swp_slot_offset(slot);
 	pgoff_t end = offset + nr_ents;
 	struct swap_cgroup *map;
 	unsigned short old, iter = 0;
 
-	offset = swp_offset(ent);
 	end = offset + nr_ents;
 	map = swap_cgroup_ctrl[swp_type(ent)].map;
 
@@ -120,12 +121,13 @@ unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents)
 unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 {
 	struct swap_cgroup_ctrl *ctrl;
+	swp_slot_t slot = swp_entry_to_swp_slot(ent);
 
 	if (mem_cgroup_disabled())
 		return 0;
 
 	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
-	return __swap_cgroup_id_lookup(ctrl->map, swp_offset(ent));
+	return __swap_cgroup_id_lookup(ctrl->map, swp_slot_offset(slot));
 }
 
 int swap_cgroup_swapon(int type, unsigned long max_pages)
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 9c7c171df7ba..4ec2de0c2756 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -111,14 +111,14 @@ static bool check_cache_active(void)
 static int alloc_swap_slot_cache(unsigned int cpu)
 {
 	struct swap_slots_cache *cache;
-	swp_entry_t *slots;
+	swp_slot_t *slots;
 
 	/*
 	 * Do allocation outside swap_slots_cache_mutex
 	 * as kvzalloc could trigger reclaim and folio_alloc_swap,
 	 * which can lock swap_slots_cache_mutex.
 	 */
-	slots = kvcalloc(SWAP_SLOTS_CACHE_SIZE, sizeof(swp_entry_t),
+	slots = kvcalloc(SWAP_SLOTS_CACHE_SIZE, sizeof(swp_slot_t),
 			 GFP_KERNEL);
 	if (!slots)
 		return -ENOMEM;
@@ -160,7 +160,7 @@ static void drain_slots_cache_cpu(unsigned int cpu, bool free_slots)
 	cache = &per_cpu(swp_slots, cpu);
 	if (cache->slots) {
 		mutex_lock(&cache->alloc_lock);
-		swapcache_free_entries(cache->slots + cache->cur, cache->nr);
+		swap_slot_cache_free_slots(cache->slots + cache->cur, cache->nr);
 		cache->cur = 0;
 		cache->nr = 0;
 		if (free_slots && cache->slots) {
@@ -238,22 +238,22 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 
 	cache->cur = 0;
 	if (swap_slot_cache_active)
-		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
+		cache->nr = swap_slot_alloc(SWAP_SLOTS_CACHE_SIZE,
 					   cache->slots, 0);
 
 	return cache->nr;
 }
 
-swp_entry_t folio_alloc_swap(struct folio *folio)
+swp_slot_t folio_alloc_swap_slot(struct folio *folio)
 {
-	swp_entry_t entry;
+	swp_slot_t slot;
 	struct swap_slots_cache *cache;
 
-	entry.val = 0;
+	slot.val = 0;
 
 	if (folio_test_large(folio)) {
 		if (IS_ENABLED(CONFIG_THP_SWAP))
-			get_swap_pages(1, &entry, folio_order(folio));
+			swap_slot_alloc(1, &slot, folio_order(folio));
 		goto out;
 	}
 
@@ -273,7 +273,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 		if (cache->slots) {
 repeat:
 			if (cache->nr) {
-				entry = cache->slots[cache->cur];
+				slot = cache->slots[cache->cur];
 				cache->slots[cache->cur++].val = 0;
 				cache->nr--;
 			} else if (refill_swap_slots_cache(cache)) {
@@ -281,15 +281,11 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 			}
 		}
 		mutex_unlock(&cache->alloc_lock);
-		if (entry.val)
+		if (slot.val)
 			goto out;
 	}
 
-	get_swap_pages(1, &entry, 0);
+	swap_slot_alloc(1, &slot, 0);
 out:
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		put_swap_folio(folio, entry);
-		entry.val = 0;
-	}
-	return entry;
+	return slot;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 81f69b2df550..055e555d3382 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -167,6 +167,19 @@ void __delete_from_swap_cache(struct folio *folio,
 	__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
 }
 
+swp_entry_t folio_alloc_swap(struct folio *folio)
+{
+	swp_slot_t slot = folio_alloc_swap_slot(folio);
+	swp_entry_t entry = swp_slot_to_swp_entry(slot);
+
+	if (entry.val && mem_cgroup_try_charge_swap(folio, entry)) {
+		put_swap_folio(folio, entry);
+		entry.val = 0;
+	}
+
+	return entry;
+}
+
 /**
  * add_to_swap - allocate swap space for a folio
  * @folio: folio we want to move to swap
@@ -548,7 +561,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  * A failure return means that either the page allocation failed or that
  * the swap entry is no longer in use.
  *
- * get/put_swap_device() aren't needed to call this function, because
+ * swap_slot_(get|put)_swap_info() aren't needed to call this function, because
  * __read_swap_cache_async() call them and swap_read_folio() holds the
  * swap cache folio lock.
  */
@@ -654,11 +667,12 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 				    struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct folio *folio;
-	unsigned long entry_offset = swp_offset(entry);
-	unsigned long offset = entry_offset;
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	unsigned long slot_offset = swp_slot_offset(slot);
+	unsigned long offset = slot_offset;
 	unsigned long start_offset, end_offset;
 	unsigned long mask;
-	struct swap_info_struct *si = swp_swap_info(entry);
+	struct swap_info_struct *si = swap_slot_swap_info(slot);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
 	bool page_allocated;
@@ -679,13 +693,13 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
 		folio = __read_swap_cache_async(
-				swp_entry(swp_type(entry), offset),
+				swp_slot_to_swp_entry(swp_slot(swp_slot_type(slot), offset)),
 				gfp_mask, mpol, ilx, &page_allocated, false);
 		if (!folio)
 			continue;
 		if (page_allocated) {
 			swap_read_folio(folio, &splug);
-			if (offset != entry_offset) {
+			if (offset != slot_offset) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
 			}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 27cf985e08ac..a1dd7e998e90 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -53,9 +53,9 @@
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
-static void swap_entry_range_free(struct swap_info_struct *si,
+static void swap_slot_range_free(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci,
-				  swp_entry_t entry, unsigned int nr_pages);
+				  swp_slot_t slot, unsigned int nr_pages);
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
 static bool folio_swapcache_freeable(struct folio *folio);
@@ -203,7 +203,8 @@ static bool swap_is_last_map(struct swap_info_struct *si,
 static int __try_to_reclaim_swap(struct swap_info_struct *si,
 				 unsigned long offset, unsigned long flags)
 {
-	swp_entry_t entry = swp_entry(si->type, offset);
+	swp_entry_t entry = swp_slot_to_swp_entry(swp_slot(si->type, offset));
+	swp_slot_t slot;
 	struct address_space *address_space = swap_address_space(entry);
 	struct swap_cluster_info *ci;
 	struct folio *folio;
@@ -229,7 +230,8 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 
 	/* offset could point to the middle of a large folio */
 	entry = folio->swap;
-	offset = swp_offset(entry);
+	slot = swp_entry_to_swp_slot(entry);
+	offset = swp_slot_offset(slot);
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
@@ -263,7 +265,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	folio_set_dirty(folio);
 
 	ci = lock_cluster(si, offset);
-	swap_entry_range_free(si, ci, entry, nr_pages);
+	swap_slot_range_free(si, ci, slot, nr_pages);
 	unlock_cluster(ci);
 	ret = nr_pages;
 out_unlock:
@@ -344,12 +346,12 @@ offset_to_swap_extent(struct swap_info_struct *sis, unsigned long offset)
 
 sector_t swap_folio_sector(struct folio *folio)
 {
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
+	struct swap_info_struct *sis = swap_slot_swap_info(slot);
 	struct swap_extent *se;
 	sector_t sector;
-	pgoff_t offset;
+	pgoff_t offset = swp_slot_offset(slot);
 
-	offset = swp_offset(folio->swap);
 	se = offset_to_swap_extent(sis, offset);
 	sector = se->start_block + (offset - se->start_page);
 	return sector << (PAGE_SHIFT - 9);
@@ -387,15 +389,15 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 #ifdef CONFIG_THP_SWAP
 #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
 
-#define swap_entry_order(order)	(order)
+#define swap_slot_order(order)	(order)
 #else
 #define SWAPFILE_CLUSTER	256
 
 /*
- * Define swap_entry_order() as constant to let compiler to optimize
+ * Define swap_slot_order() as constant to let compiler to optimize
  * out some code if !CONFIG_THP_SWAP
  */
-#define swap_entry_order(order)	0
+#define swap_slot_order(order)	0
 #endif
 #define LATENCY_LIMIT		256
 
@@ -779,7 +781,7 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 					    unsigned int order,
 					    unsigned char usage)
 {
-	unsigned int next = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
+	unsigned int next = SWAP_SLOT_INVALID, found = SWAP_SLOT_INVALID;
 	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
 	unsigned long end = min(start + SWAPFILE_CLUSTER, si->max);
 	unsigned int nr_pages = 1 << order;
@@ -883,7 +885,7 @@ static void swap_reclaim_work(struct work_struct *work)
  * pool (a cluster). This might involve allocating a new cluster for current CPU
  * too.
  */
-static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
+static unsigned long cluster_alloc_swap_slot(struct swap_info_struct *si, int order,
 					      unsigned char usage)
 {
 	struct swap_cluster_info *ci;
@@ -1135,7 +1137,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	 */
 	for (i = 0; i < nr_entries; i++) {
 		clear_bit(offset + i, si->zeromap);
-		zswap_invalidate(swp_entry(si->type, offset + i));
+		zswap_invalidate(swp_slot_to_swp_entry(swp_slot(si->type, offset + i)));
 	}
 
 	if (si->flags & SWP_BLKDEV)
@@ -1162,16 +1164,16 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 
 static int cluster_alloc_swap(struct swap_info_struct *si,
 			     unsigned char usage, int nr,
-			     swp_entry_t slots[], int order)
+			     swp_slot_t slots[], int order)
 {
 	int n_ret = 0;
 
 	while (n_ret < nr) {
-		unsigned long offset = cluster_alloc_swap_entry(si, order, usage);
+		unsigned long offset = cluster_alloc_swap_slot(si, order, usage);
 
 		if (!offset)
 			break;
-		slots[n_ret++] = swp_entry(si->type, offset);
+		slots[n_ret++] = swp_slot(si->type, offset);
 	}
 
 	return n_ret;
@@ -1179,7 +1181,7 @@ static int cluster_alloc_swap(struct swap_info_struct *si,
 
 static int scan_swap_map_slots(struct swap_info_struct *si,
 			       unsigned char usage, int nr,
-			       swp_entry_t slots[], int order)
+			       swp_slot_t slots[], int order)
 {
 	unsigned int nr_pages = 1 << order;
 
@@ -1231,9 +1233,9 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 	return true;
 }
 
-int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
+int swap_slot_alloc(int n_goal, swp_slot_t swp_slots[], int entry_order)
 {
-	int order = swap_entry_order(entry_order);
+	int order = swap_slot_order(entry_order);
 	unsigned long size = 1 << order;
 	struct swap_info_struct *si, *next;
 	long avail_pgs;
@@ -1260,8 +1262,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
 			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
-					n_goal, swp_entries, order);
-			put_swap_device(si);
+					n_goal, swp_slots, order);
+			swap_slot_put_swap_info(si);
 			if (n_ret || size > 1)
 				goto check_out;
 		}
@@ -1292,36 +1294,36 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 	return n_ret;
 }
 
-static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
+static struct swap_info_struct *_swap_info_get(swp_slot_t slot)
 {
 	struct swap_info_struct *si;
 	unsigned long offset;
 
-	if (!entry.val)
+	if (!slot.val)
 		goto out;
-	si = swp_swap_info(entry);
+	si = swap_slot_swap_info(slot);
 	if (!si)
 		goto bad_nofile;
 	if (data_race(!(si->flags & SWP_USED)))
 		goto bad_device;
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 	if (offset >= si->max)
 		goto bad_offset;
-	if (data_race(!si->swap_map[swp_offset(entry)]))
+	if (data_race(!si->swap_map[swp_slot_offset(slot)]))
 		goto bad_free;
 	return si;
 
 bad_free:
-	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Unused_offset, slot.val);
 	goto out;
 bad_offset:
-	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_offset, slot.val);
 	goto out;
 bad_device:
-	pr_err("%s: %s%08lx\n", __func__, Unused_file, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Unused_file, slot.val);
 	goto out;
 bad_nofile:
-	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_file, slot.val);
 out:
 	return NULL;
 }
@@ -1331,8 +1333,9 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
  * prevent swapoff, such as the folio in swap cache is locked, RCU
  * reader side is locked, etc., the swap entry may become invalid
  * because of swapoff.  Then, we need to enclose all swap related
- * functions with get_swap_device() and put_swap_device(), unless the
- * swap functions call get/put_swap_device() by themselves.
+ * functions with swap_slot_tryget_swap_info() and
+ * swap_slot_put_swap_info(), unless the swap functions call
+ * swap_slot_(tryget|put)_swap_info by themselves.
  *
  * RCU reader side lock (including any spinlock) is sufficient to
  * prevent swapoff, because synchronize_rcu() is called in swapoff()
@@ -1341,11 +1344,11 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
- * put_swap_device() is called.  Otherwise return NULL.
+ * swap_slot_put_swap_info() is called.  Otherwise return NULL.
  *
  * Notice that swapoff or swapoff+swapon can still happen before the
- * percpu_ref_tryget_live() in get_swap_device() or after the
- * percpu_ref_put() in put_swap_device() if there isn't any other way
+ * percpu_ref_tryget_live() in swap_slot_tryget_swap_info() or after the
+ * percpu_ref_put() in swap_slot_put_swap_info() if there isn't any other way
  * to prevent swapoff.  The caller must be prepared for that.  For
  * example, the following situation is possible.
  *
@@ -1365,34 +1368,34 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
  * changed with the page table locked to check whether the swap device
  * has been swapoff or swapoff+swapon.
  */
-struct swap_info_struct *get_swap_device(swp_entry_t entry)
+struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot)
 {
 	struct swap_info_struct *si;
 	unsigned long offset;
 
-	if (!entry.val)
+	if (!slot.val)
 		goto out;
-	si = swp_swap_info(entry);
+	si = swap_slot_swap_info(slot);
 	if (!si)
 		goto bad_nofile;
 	if (!get_swap_device_info(si))
 		goto out;
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 	if (offset >= si->max)
 		goto put_out;
 
 	return si;
 bad_nofile:
-	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_file, slot.val);
 out:
 	return NULL;
 put_out:
-	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_offset, slot.val);
 	percpu_ref_put(&si->users);
 	return NULL;
 }
 
-static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
+static unsigned char __swap_slot_free_locked(struct swap_info_struct *si,
 					      unsigned long offset,
 					      unsigned char usage)
 {
@@ -1432,27 +1435,27 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
 	return usage;
 }
 
-static unsigned char __swap_entry_free(struct swap_info_struct *si,
-				       swp_entry_t entry)
+static unsigned char __swap_slot_free(struct swap_info_struct *si,
+				       swp_slot_t slot)
 {
 	struct swap_cluster_info *ci;
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 	unsigned char usage;
 
 	ci = lock_cluster(si, offset);
-	usage = __swap_entry_free_locked(si, offset, 1);
+	usage = __swap_slot_free_locked(si, offset, 1);
 	if (!usage)
-		swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
+		swap_slot_range_free(si, ci, swp_slot(si->type, offset), 1);
 	unlock_cluster(ci);
 
 	return usage;
 }
 
-static bool __swap_entries_free(struct swap_info_struct *si,
-		swp_entry_t entry, int nr)
+static bool __swap_slots_free(struct swap_info_struct *si,
+		swp_slot_t slot, int nr)
 {
-	unsigned long offset = swp_offset(entry);
-	unsigned int type = swp_type(entry);
+	unsigned long offset = swp_slot_offset(slot);
+	unsigned int type = swp_slot_type(slot);
 	struct swap_cluster_info *ci;
 	bool has_cache = false;
 	unsigned char count;
@@ -1472,7 +1475,7 @@ static bool __swap_entries_free(struct swap_info_struct *si,
 	for (i = 0; i < nr; i++)
 		WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
 	if (!has_cache)
-		swap_entry_range_free(si, ci, entry, nr);
+		swap_slot_range_free(si, ci, slot, nr);
 	unlock_cluster(ci);
 
 	return has_cache;
@@ -1480,7 +1483,7 @@ static bool __swap_entries_free(struct swap_info_struct *si,
 fallback:
 	for (i = 0; i < nr; i++) {
 		if (data_race(si->swap_map[offset + i])) {
-			count = __swap_entry_free(si, swp_entry(type, offset + i));
+			count = __swap_slot_free(si, swp_slot(type, offset + i));
 			if (count == SWAP_HAS_CACHE)
 				has_cache = true;
 		} else {
@@ -1494,13 +1497,14 @@ static bool __swap_entries_free(struct swap_info_struct *si,
  * Drop the last HAS_CACHE flag of swap entries, caller have to
  * ensure all entries belong to the same cgroup.
  */
-static void swap_entry_range_free(struct swap_info_struct *si,
+static void swap_slot_range_free(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci,
-				  swp_entry_t entry, unsigned int nr_pages)
+				  swp_slot_t slot, unsigned int nr_pages)
 {
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
+	swp_entry_t entry = swp_slot_to_swp_entry(slot);
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
@@ -1531,23 +1535,19 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
 
 	ci = lock_cluster(si, offset);
 	do {
-		if (!__swap_entry_free_locked(si, offset, usage))
-			swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
+		if (!__swap_slot_free_locked(si, offset, usage))
+			swap_slot_range_free(si, ci, swp_slot(si->type, offset), 1);
 	} while (++offset < end);
 	unlock_cluster(ci);
 }
 
-/*
- * Caller has made sure that the swap device corresponding to entry
- * is still around or has not been recycled.
- */
-void swap_free_nr(swp_entry_t entry, int nr_pages)
+void swap_slot_free_nr(swp_slot_t slot, int nr_pages)
 {
 	int nr;
 	struct swap_info_struct *sis;
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 
-	sis = _swap_info_get(entry);
+	sis = _swap_info_get(slot);
 	if (!sis)
 		return;
 
@@ -1559,27 +1559,37 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 	}
 }
 
+/*
+ * Caller has made sure that the swap device corresponding to entry
+ * is still around or has not been recycled.
+ */
+void swap_free_nr(swp_entry_t entry, int nr_pages)
+{
+	swap_slot_free_nr(swp_entry_to_swp_slot(entry), nr_pages);
+}
+
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
 void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
-	unsigned long offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	unsigned long offset = swp_slot_offset(slot);
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
-	int size = 1 << swap_entry_order(folio_order(folio));
+	int size = 1 << swap_slot_order(folio_order(folio));
 
-	si = _swap_info_get(entry);
+	si = _swap_info_get(slot);
 	if (!si)
 		return;
 
 	ci = lock_cluster(si, offset);
 	if (swap_is_has_cache(si, offset, size))
-		swap_entry_range_free(si, ci, entry, size);
+		swap_slot_range_free(si, ci, slot, size);
 	else {
-		for (int i = 0; i < size; i++, entry.val++) {
-			if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE))
-				swap_entry_range_free(si, ci, entry, 1);
+		for (int i = 0; i < size; i++, slot.val++) {
+			if (!__swap_slot_free_locked(si, offset + i, SWAP_HAS_CACHE))
+				swap_slot_range_free(si, ci, slot, 1);
 		}
 	}
 	unlock_cluster(ci);
@@ -1587,8 +1597,9 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 
 int __swap_count(swp_entry_t entry)
 {
-	struct swap_info_struct *si = swp_swap_info(entry);
-	pgoff_t offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *si = swap_slot_swap_info(slot);
+	pgoff_t offset = swp_slot_offset(slot);
 
 	return swap_count(si->swap_map[offset]);
 }
@@ -1600,7 +1611,8 @@ int __swap_count(swp_entry_t entry)
  */
 int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 {
-	pgoff_t offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	pgoff_t offset = swp_slot_offset(slot);
 	struct swap_cluster_info *ci;
 	int count;
 
@@ -1616,6 +1628,7 @@ int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
  */
 int swp_swapcount(swp_entry_t entry)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	int count, tmp_count, n;
 	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
@@ -1623,11 +1636,11 @@ int swp_swapcount(swp_entry_t entry)
 	pgoff_t offset;
 	unsigned char *map;
 
-	si = _swap_info_get(entry);
+	si = _swap_info_get(slot);
 	if (!si)
 		return 0;
 
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 
 	ci = lock_cluster(si, offset);
 
@@ -1659,10 +1672,11 @@ int swp_swapcount(swp_entry_t entry)
 static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 					 swp_entry_t entry, int order)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	struct swap_cluster_info *ci;
 	unsigned char *map = si->swap_map;
 	unsigned int nr_pages = 1 << order;
-	unsigned long roffset = swp_offset(entry);
+	unsigned long roffset = swp_slot_offset(slot);
 	unsigned long offset = round_down(roffset, nr_pages);
 	int i;
 	bool ret = false;
@@ -1687,7 +1701,8 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 static bool folio_swapped(struct folio *folio)
 {
 	swp_entry_t entry = folio->swap;
-	struct swap_info_struct *si = _swap_info_get(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *si = _swap_info_get(slot);
 
 	if (!si)
 		return false;
@@ -1710,7 +1725,8 @@ static bool folio_swapped(struct folio *folio)
  */
 void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 {
-	const unsigned long start_offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	const unsigned long start_offset = swp_slot_offset(slot);
 	const unsigned long end_offset = start_offset + nr;
 	struct swap_info_struct *si;
 	bool any_only_cache = false;
@@ -1719,7 +1735,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	if (non_swap_entry(entry))
 		return;
 
-	si = get_swap_device(entry);
+	si = swap_slot_tryget_swap_info(slot);
 	if (!si)
 		return;
 
@@ -1729,7 +1745,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	/*
 	 * First free all entries in the range.
 	 */
-	any_only_cache = __swap_entries_free(si, entry, nr);
+	any_only_cache = __swap_slots_free(si, slot, nr);
 
 	/*
 	 * Short-circuit the below loop if none of the entries had their
@@ -1742,7 +1758,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	 * Now go back over the range trying to reclaim the swap cache. This is
 	 * more efficient for large folios because we will only try to reclaim
 	 * the swap once per folio in the common case. If we do
-	 * __swap_entry_free() and __try_to_reclaim_swap() in the same loop, the
+	 * __swap_slot_free() and __try_to_reclaim_swap() in the same loop, the
 	 * latter will get a reference and lock the folio for every individual
 	 * page but will only succeed once the swap slot for every subpage is
 	 * zero.
@@ -1769,10 +1785,10 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	}
 
 out:
-	put_swap_device(si);
+	swap_slot_put_swap_info(si);
 }
 
-void swapcache_free_entries(swp_entry_t *entries, int n)
+void swap_slot_cache_free_slots(swp_slot_t *slots, int n)
 {
 	int i;
 	struct swap_cluster_info *ci;
@@ -1782,10 +1798,10 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
 		return;
 
 	for (i = 0; i < n; ++i) {
-		si = _swap_info_get(entries[i]);
+		si = _swap_info_get(slots[i]);
 		if (si) {
-			ci = lock_cluster(si, swp_offset(entries[i]));
-			swap_entry_range_free(si, ci, entries[i], 1);
+			ci = lock_cluster(si, swp_slot_offset(slots[i]));
+			swap_slot_range_free(si, ci, slots[i], 1);
 			unlock_cluster(ci);
 		}
 	}
@@ -1844,22 +1860,22 @@ bool folio_free_swap(struct folio *folio)
 
 #ifdef CONFIG_HIBERNATION
 
-swp_entry_t get_swap_page_of_type(int type)
+swp_slot_t swap_slot_alloc_of_type(int type)
 {
 	struct swap_info_struct *si = swap_type_to_swap_info(type);
-	swp_entry_t entry = {0};
+	swp_slot_t slot = {0};
 
 	if (!si)
 		goto fail;
 
 	/* This is called for allocating swap entry, not cache */
 	if (get_swap_device_info(si)) {
-		if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
+		if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &slot, 0))
 			atomic_long_dec(&nr_swap_pages);
-		put_swap_device(si);
+		swap_slot_put_swap_info(si);
 	}
 fail:
-	return entry;
+	return slot;
 }
 
 /*
@@ -2081,6 +2097,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long offset;
 		unsigned char swp_count;
 		swp_entry_t entry;
+		swp_slot_t slot;
 		int ret;
 		pte_t ptent;
 
@@ -2096,10 +2113,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			continue;
 
 		entry = pte_to_swp_entry(ptent);
-		if (swp_type(entry) != type)
+		slot = swp_entry_to_swp_slot(entry);
+
+		if (swp_slot_type(slot) != type)
 			continue;
 
-		offset = swp_offset(entry);
+		offset = swp_slot_offset(slot);
 		pte_unmap(pte);
 		pte = NULL;
 
@@ -2281,6 +2300,7 @@ static int try_to_unuse(unsigned int type)
 	struct swap_info_struct *si = swap_info[type];
 	struct folio *folio;
 	swp_entry_t entry;
+	swp_slot_t slot;
 	unsigned int i;
 
 	if (!swap_usage_in_pages(si))
@@ -2328,7 +2348,8 @@ static int try_to_unuse(unsigned int type)
 	       !signal_pending(current) &&
 	       (i = find_next_to_unuse(si, i)) != 0) {
 
-		entry = swp_entry(type, i);
+		slot = swp_slot(type, i);
+		entry = swp_slot_to_swp_entry(slot);
 		folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
 		if (IS_ERR(folio))
 			continue;
@@ -2737,7 +2758,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	reenable_swap_slots_cache_unlock();
 
 	/*
-	 * Wait for swap operations protected by get/put_swap_device()
+	 * Wait for swap operations protected by get/swap_slot_put_swap_info()
 	 * to complete.  Because of synchronize_rcu() here, all swap
 	 * operations protected by RCU reader side lock (including any
 	 * spinlock) will be waited too.  This makes it easy to
@@ -3196,7 +3217,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 
 			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
 			for (i = 0; i < SWAP_NR_ORDERS; i++)
-				cluster->next[i] = SWAP_ENTRY_INVALID;
+				cluster->next[i] = SWAP_SLOT_INVALID;
 			local_lock_init(&cluster->lock);
 		}
 	} else {
@@ -3205,7 +3226,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 		if (!si->global_cluster)
 			goto err_free;
 		for (i = 0; i < SWAP_NR_ORDERS; i++)
-			si->global_cluster->next[i] = SWAP_ENTRY_INVALID;
+			si->global_cluster->next[i] = SWAP_SLOT_INVALID;
 		spin_lock_init(&si->global_cluster_lock);
 	}
 
@@ -3538,6 +3559,7 @@ void si_swapinfo(struct sysinfo *val)
  */
 static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
 	unsigned long offset;
@@ -3545,13 +3567,13 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	unsigned char has_cache;
 	int err, i;
 
-	si = swp_swap_info(entry);
+	si = swap_slot_swap_info(slot);
 	if (WARN_ON_ONCE(!si)) {
 		pr_err("%s%08lx\n", Bad_file, entry.val);
 		return -EINVAL;
 	}
 
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
 	VM_WARN_ON(usage == 1 && nr > 1);
 	ci = lock_cluster(si, offset);
@@ -3653,14 +3675,15 @@ int swapcache_prepare(swp_entry_t entry, int nr)
 
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
-	unsigned long offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	unsigned long offset = swp_slot_offset(slot);
 
 	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
 }
 
-struct swap_info_struct *swp_swap_info(swp_entry_t entry)
+struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot)
 {
-	return swap_type_to_swap_info(swp_type(entry));
+	return swap_type_to_swap_info(swp_slot_type(slot));
 }
 
 /*
@@ -3668,7 +3691,8 @@ struct swap_info_struct *swp_swap_info(swp_entry_t entry)
  */
 struct address_space *swapcache_mapping(struct folio *folio)
 {
-	return swp_swap_info(folio->swap)->swap_file->f_mapping;
+	return swap_slot_swap_info(swp_entry_to_swp_slot(folio->swap))
+				->swap_file->f_mapping;
 }
 EXPORT_SYMBOL_GPL(swapcache_mapping);
 
@@ -3702,6 +3726,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	struct page *list_page;
 	pgoff_t offset;
 	unsigned char count;
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	int ret = 0;
 
 	/*
@@ -3710,7 +3735,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	 */
 	page = alloc_page(gfp_mask | __GFP_HIGHMEM);
 
-	si = get_swap_device(entry);
+	si = swap_slot_tryget_swap_info(slot);
 	if (!si) {
 		/*
 		 * An acceptable race has occurred since the failing
@@ -3719,7 +3744,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 		goto outer;
 	}
 
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 
 	ci = lock_cluster(si, offset);
 
@@ -3782,7 +3807,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	spin_unlock(&si->cont_lock);
 out:
 	unlock_cluster(ci);
-	put_swap_device(si);
+	swap_slot_put_swap_info(si);
 outer:
 	if (page)
 		__free_page(page);
-- 
2.47.1


