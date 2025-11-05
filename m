Return-Path: <linux-pm+bounces-37474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5DBC36D40
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F57868528C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCBC31D739;
	Wed,  5 Nov 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Agdn64GG"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic312-24.consmr.mail.gq1.yahoo.com (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E025EFBF
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359713; cv=none; b=p1ydG32iyfY+6//xpc8IcIb0for6vdT+HmMl8txofb8VqdEHeSLpbIegpBEwLY4c/C3Cx/aZmoC/saH/e8A2em6GP5rkn4BRaE35xG/jNFgD5VrE9QTFQQTzoRUBnWlGqNL3MYk0jtImO/KbvZZdqpFt8kET+J+ez/eXUOTrLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359713; c=relaxed/simple;
	bh=lKzdMIEskB3gJDPmjWnD2mrFU4wNhtP6DQMnbxZHIqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=jtD0mLfKgM+1KUApzvXdQ2DNj8V6FVLDmcE9h69fcTGqBhFWJEg2Vl1fj0YrkhKFqconzmWYBIvsAbI3vaMbaepzj67ukWzYDRc3JXuoK96GghVwwoP1b5/feWdWDAvxqW/qBPylNupooJaoUGmUIKXFY7IRmpf/5s5M+Vbg2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Agdn64GG; arc=none smtp.client-ip=98.137.69.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762359704; bh=lFhFYl6BSknLOaSYCe25pwqVII2+MqX7SkGbIIIV1Dg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Agdn64GGTfW1vGbeeArP/UndDyX36MOwC2JnbLFTw7mFu5i3GnbGDVz8ff0Lt9lHaZGbTMoTvfUxG0xunFvtfeOknmnWclZi4qr41qFVWl0UmLwbzjUGYkEu+kFhi8i3AvLmT0n/VcTXEmTNFamU+hRPMP64QqY4cSJsg0W18F9bCvNgypZU2wQ3ofF0IH5Fxepp0/l6x7lHfsOQKGZ9kN5nK8iPMLm3MxlJ6Swv1TM2+Yy7ZoiAj1AnCnCSSA2i7HnlzrDay4XpkHIH5henhx88NaOvsevjSbnWELfLWMTa0Vd/sBEgT5boi+lciiqRtF2/qneDZHVmfLESjfu0Sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762359704; bh=h/A6t8j5+a3TwTmU0cBierOzIL6YIS+YU/IP+qsnLZP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kUh9y0xTkSuSHxdm0gwKIeHYZgfVWT6M81l/KqxlufoybUW0IZdJLWzhxe+jMTjm5b5tS8Bgr1BQUursr+2B1ZXE21cSUOa4nNiYYQlbAmcU10U6QEeuBqnpTBJH3ZSsN9sNPMoTwGp2AhOLzPDJevDmwTyHKdQIwlc9TYYE/lKRcc+e49dplSintWBF2ndBq3/vDHUNoIgONfly/FsQ5cGq5I5GRI4GcvMX7tXYgzhvipU9JSBkyb84LtcoR7NMJWF6pViNmLmJkuzh+M0PvZS+xtImVO3dkpXPKwRzJGOQdqZzSIyMxVGDADHqAnou+PmiskDhFXWIvgXXrr7qWw==
X-YMail-OSG: nwE6dN0VM1nVVWAo_MuxJSHZfTlqURG7vKjUXvxbYEaf2rY22Ic8pSuV2uofV2y
 JEAmcKaiQa_4yr0jZ41De7Azhx8xXD3MYBUBMteZowvHbhzTtLGxS0yqOr5oyCZTqoL1PiX4zzOh
 ISJgb3Nn6afzZsJbcDVdWw3nYBAh76dxKl6lnb.EGIzRke5daKeUFeKtn1A2CJbZJgaiPbQDIcw.
 2L6S8MiZeAtawUI8UHvpR2pm1ntSkvIhcOQe5Tms.1FWPri2p4FhaXggX7_RzoqUfxFxn9etrIRf
 kV5u9yR1wdyDzuNb8Sw1WmxMmcDlIqUz1mAJKYjAeqRGE0uuPA5Q_bbR2rMaRjfyM6V9cZLOzyWI
 Q8zf5JYGFklYyUjxvUquF8w.Oo0RSUh9IVbM0PhYnE.TQFNFp9uXMf4cqxKAiIhYkoU6G2GkS19x
 1KdX_ABxItlXasD9xHvPZV87Btx2ZSmJRPuRmEc6stdBGEzkezB2R2fsrVzirJ6nFUt0zqo3o6w9
 6QFURgQTyH2rwVB78Xne30i3_rT4GjmMLOE_udneLUXr2fp_n7daXX.WPiBMA68Gs_vITbk_otO2
 BS.f31PsYCXzFyKjFZX4Ne57gv3SEEJ0WzCIhta1JSljy4M.UsY6gSOJmcA0Q6SsRDD4Dz096xm.
 m8gD80aJj55rCLsP20_bAqM1KOk6wWXxx_RdEwxDwx0y19fCjugUV9S.opEj_0qEAPk0p7XGsvlZ
 IGPgTOYiUi12uaNQNwPl8DcIui1sO39qa6vhz9btkCtjabRexd1QqZovUf30RH0lypeb3.oXuE3k
 nv5RnbPPlf6_v3BEhHAOFkgm3FHKyKqdSrKAt0JeyinHFQN8Sc0OWGovP7OjK7xZIq1V5eseQrnX
 6y59qObtABVi9jggEKM9cxYBJCTJ0AoO3QwqrMtayXA6bXQog4nUrNDGwoWDVzS4XGp6BQMtS8ea
 .58H8Jnd7oRp3ntDjY_aEH1cBI5QYZOo9cngoVaRw_w_qvqTwfj2HFdlCUQLhNyCiebVbj8C.cI6
 q.gZQHWwN_ezOXxPIZ8XLPVOYpFgb57LbjHaFtYtDQykfmuKOc3lBi6SM4j6zHHjkICHuorEtxFE
 CjOvy.RuXPySFROyRfqOuY51QycmYNglSsMhsBDbxR8LJ5HD9aCwi9LvxHKTisOxf3kIFfrDyRvU
 4EfRjjGAwL.XzoAqbDrL7X3W8UjVokWMpj6qTRE2YHZnAzPYPMRmpa0ul2NlGuIT1cgQ6QyiKOEq
 q_ME9vJMegL52dn5rtZKmcMZvS8GwN2BlCcdhkzMNdOowySqe0lcv9wO2wzTLzAdmQ2XlhouXuAH
 160V7qt69k_VNwkGTCXm7N5VWSADlMJ9Z2tZJDhcsdJ1UOaVXQLGtP0gLhvoedzo6.vTuhLBykEY
 .h.TB6RxPo0VlNEiu0nA_CPbu_DOXJM8leE4_JyAg08JA5sMp47tAuAVtPMXywaya2AjjGL6E8Tx
 G4Lg9O0xjld26mjff.of576SxK9TU2GRQp2Ikq2.K.VpJFWhebVyiOsQ25HO736FKqnr92Dtmvai
 LMExHYlBTqR96akDlPrL23j3BkkFFpRlf9XChWDaoKdXhhWppdCf4nmVm_uqMQP.6xzw1ejVjoJ9
 rr7pcx5jHWBYqKswkkIXl410KgYToWN7su0bhzuSdl0BXTeV5FBdGQ2Lt2gEecaBvBwemyjZvqPm
 jRJ5RsZM_48tpJ_Rq8jA2EzK7WNGf8.MYojRSys9BufZPCW1L1leaXjVFqsAdwnANC0vQU78AjDT
 4pNHrE_IN2_0v_eDNQo0hqyKZE9ttoPXV.kBtrQfqIpYN4TJq_B4gdeXLB7AKR_VeI0Bvq5zd_Dr
 ibEBStKc6umaB1ROks.TgBLSLAHMLTROmsz.c0tl69Y9LOJgOg1ekD75UdeqmDfQ1E5b_R5xKFOC
 J1NIPnJYGuEs_V55QhaOOQ4lPRUjF.MhBWG1wnemLByBApaSNqY0sMGx_c_b8P.R8RU8JGF.Jsor
 4uKvQsJ_XcMoopXVpGmV8OjiKPg96IFH.wyamIyd7wpNQJFHyy2ve7YPNdMwDJOeLgIQR0t_2Jh5
 n9o6kUbKon5duSeYN4SsLdsVO8rpRRmUXEldP07RtgJiEqmsc4MdE8ve4fmZv4Ib3zZ3SS6PzFXD
 xTMsmWLwBp5K7KJHcTm1ODoab03E9Et3ItFJV.we0h94sv9VrAn7j8o7Fs_xZF6ymOoNDAE6Roxc
 TnMIuZ5NgJN_qp3jtGK624qy8GM8YcEWoGmxk_qcsZnjg5F2xTw15G5kQyVa8yocVW6RMd813Fo6
 2fXCAWeBH6KU-
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: be710f3f-32a3-4cf3-8909-3d48e309034d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Wed, 5 Nov 2025 16:21:44 +0000
Received: by hermes--production-bf1-554db8b85-6h9jt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5d382671a5c559393f42c37a8a0aa397;
          Wed, 05 Nov 2025 15:41:13 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH] power/snapshot: add missing kernel-doc comments in snapshot.c
Date: Wed,  5 Nov 2025 16:41:01 +0100
Message-ID: <20251105154101.30675-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251105154101.30675-1-adelodunolaoluwa.ref@yahoo.com>

A full kernel build reported several kernel-doc warnings in snapshot.c
about function parameters not being documented.

Add the missing kernel-doc comments, including
parameter descriptions and return value details, to eliminate those
warnings and improve code readability.

No functional changes. Documentation only.

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 kernel/power/snapshot.c | 186 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 10 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 645f42e40478..d24b85ef6873 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -187,6 +187,8 @@ static unsigned int allocated_unsafe_pages;
  *
  * Each allocated image page is marked as PageNosave and PageNosaveFree so that
  * swsusp_free() can release it.
+ *
+ * Return: Pointer to the allocated zeroed page on success or Null on failure.
  */
 static void *get_image_page(gfp_t gfp_mask, int safe_needed)
 {
@@ -438,6 +440,9 @@ struct memory_bitmap {
  * This function is used to allocate inner nodes as well as the
  * leave nodes of the radix tree. It also adds the node to the
  * corresponding linked list passed in by the *list parameter.
+ *
+ * Return: Pointer to the allocated radix tree node on success or
+ *         Null on failure
  */
 static struct rtree_node *alloc_rtree_node(gfp_t gfp_mask, int safe_needed,
 					   struct chain_allocator *ca,
@@ -460,10 +465,16 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp_mask, int safe_needed,
 
 /**
  * add_rtree_block - Add a new leave node to the radix tree.
+ * @zone: Bitmap radix tree metadata structure for the memory zone
+ * @gfp_mask: GFP mask for allocation
+ * @safe_needed: Allocate only "safe" memory if set
+ * @ca: Chain allocator to allocate new tree nodes
  *
- * The leave nodes need to be allocated in order to keep the leaves
+ * The leaf nodes need to be allocated in order to keep the leaves
  * linked list in order. This is guaranteed by the zone->blocks
  * counter.
+ *
+ * Return: 0 on success, -ENOMEM if memory allocation fails
  */
 static int add_rtree_block(struct mem_zone_bm_rtree *zone, gfp_t gfp_mask,
 			   int safe_needed, struct chain_allocator *ca)
@@ -530,10 +541,18 @@ static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
 
 /**
  * create_zone_bm_rtree - Create a radix tree for one zone.
+ * @gfp_mask: GFP flags used for memory allocation
+ * @safe_needed: Allocate only "safe" memory if set
+ * @ca: Chain allocator used to allocate tree structures
+ * @start: Starting PFN (page frame number) from the memory zone
+ * @end: Ending PFN (page frame number) + 1 for the memory zone
  *
  * Allocated the mem_zone_bm_rtree structure and initializes it.
  * This function also allocated and builds the radix tree for the
  * zone.
+ *
+ * Return: Pointer to the newly created mem_zone_bm_rtree on success,
+ *         Null on failure
  */
 static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
 						      int safe_needed,
@@ -568,6 +587,8 @@ static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
 
 /**
  * free_zone_bm_rtree - Free the memory of the radix tree.
+ * @zone: Memory zone bitmap radix tree to free
+ * @clear_nosave_free: If non-zero, pages are cleared before being freed
  *
  * Free all node pages of the radix tree. The mem_zone_bm_rtree
  * structure itself is not freed here nor are the rtree_node
@@ -624,6 +645,8 @@ static void free_mem_extents(struct list_head *list)
  * @gfp_mask: Mask to use for memory allocations.
  *
  * The extents represent contiguous ranges of PFNs.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 {
@@ -680,6 +703,14 @@ static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 
 /**
  * memory_bm_create - Allocate memory for a memory bitmap.
+ * @bm: Memory bitmap structure to initialize
+ * @gfp_mask: GFP mask to use for internal memory allocations
+ * @safe_needed: Whether to use the "safe" memory allocation path
+ *
+ * Allocates and initializes the memory structures required to represent
+ * the system memory bitmap for snapshot operations.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 			    int safe_needed)
@@ -722,7 +753,13 @@ static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 
 /**
  * memory_bm_free - Free memory occupied by the memory bitmap.
- * @bm: Memory bitmap.
+ * @bm: Memory bitmap structure to initialize
+ * @clear_nosave_free: If non-zero, also clear and free pages
+ * marked as nosave (used during restore).
+ *
+ * Frees all radix tree structure and page lists associated with
+ * a memory bitmap used for hibernation. After this call, the bitmap
+ * structure is reset and cannot be used until reinitialized.
  */
 static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
 {
@@ -738,12 +775,19 @@ static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
 
 /**
  * memory_bm_find_bit - Find the bit for a given PFN in a memory bitmap.
+ * @bm: Memory bitmap to search
+ * @pfn: Page frame number to locate in the bitmap
+ * @addr: Returns a pointer to the bitmap word containing the bit
+ * @bit_nr: Returns the bit index within the bitmap word
  *
- * Find the bit in memory bitmap @bm that corresponds to the given PFN.
- * The cur.zone, cur.block and cur.node_pfn members of @bm are updated.
+ * Find the bit in memory bitmap @bm that corresponds to the @pfn.
+ * The cur.zone, cur.node and cur.node_pfn members of @bm are updated.
  *
- * Walk the radix tree to find the page containing the bit that represents @pfn
- * and return the position of the bit in @addr and @bit_nr.
+ * Walk the radix tree to find the leaf node containing the bit for @pfn
+ * and return the address of the bitmap block in @addr and the bit member
+ * in @bit_nr.
+ *
+ * Return: 0 on success, -EFAULT if @pfn is outside all bitmap zones.
  */
 static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
 			      void **addr, unsigned int *bit_nr)
@@ -925,6 +969,8 @@ static bool rtree_next_node(struct memory_bitmap *bm)
  *
  * It is required to run memory_bm_position_reset() before the first call to
  * this function for the given memory bitmap.
+ *
+ * Return: The next PFN in the bitmap, or BM_END_OF_MAP if no more PFNs remains.
  */
 static unsigned long memory_bm_next_pfn(struct memory_bitmap *bm)
 {
@@ -990,6 +1036,8 @@ static void memory_bm_recycle(struct memory_bitmap *bm)
 
 /**
  * register_nosave_region - Register a region of unsaveable memory.
+ * @start_pfn: Starting PFN of the memory region that should not be saved
+ * @end_pfn: Ending PFN of the memory that should not be saved
  *
  * Register a range of page frames the contents of which should not be saved
  * during hibernation (to be used in the early initialization code).
@@ -1113,6 +1161,8 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
  * free page frames.  The forbidden_pages_map and free_pages_map pointers are
  * only modified if everything goes well, because we don't want the bits to be
  * touched before both bitmaps are set up.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 int create_basic_memory_bitmaps(void)
 {
@@ -1220,6 +1270,9 @@ void clear_or_poison_free_pages(void)
  * Estimate the number of additional pages needed for setting up a hibernation
  * image data structures for @zone (usually, the returned value is greater than
  * the exact number).
+ *
+ * Return: Estimated number of additional pages required for the hibernation
+ *         image
  */
 unsigned int snapshot_additional_pages(struct zone *zone)
 {
@@ -1292,6 +1345,8 @@ static void mark_free_pages(struct zone *zone)
  * count_free_highmem_pages - Compute the total number of free highmem pages.
  *
  * The returned number is system-wide.
+ *
+ * Return: Total count of the free high memory pages in the system.
  */
 static unsigned int count_free_highmem_pages(void)
 {
@@ -1307,11 +1362,15 @@ static unsigned int count_free_highmem_pages(void)
 
 /**
  * saveable_highmem_page - Check if a highmem page is saveable.
+ * @zone: Zone the page must belong to
+ * @pfn: Page frame number to check
  *
  * Determine whether a highmem page should be included in a hibernation image.
  *
  * We should save the page if it isn't Nosave or NosaveFree, or Reserved,
  * and it isn't part of a free chunk of pages.
+ *
+ * Return: pointer to struct page if saveable, Null otherwise.
  */
 static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
 {
@@ -1340,6 +1399,9 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
 
 /**
  * count_highmem_pages - Compute the total number of saveable highmem pages.
+ *
+ * Return: The total number of high memory pages that can be saved during
+ *         hibernation.
  */
 static unsigned int count_highmem_pages(void)
 {
@@ -1364,6 +1426,8 @@ static unsigned int count_highmem_pages(void)
 
 /**
  * saveable_page - Check if the given page is saveable.
+ * @zone: Zone the PFN belongs to.
+ * @pfn: Page frame number of the page to check.
  *
  * Determine whether a non-highmem page should be included in a hibernation
  * image.
@@ -1371,6 +1435,8 @@ static unsigned int count_highmem_pages(void)
  * We should save the page if it isn't Nosave, and is not in the range
  * of pages statically defined as 'unsaveable', and it isn't part of
  * a free chunk of pages.
+ *
+ * Return: a pointer to the page if it should be saved, or NULL otherwise.
  */
 static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 {
@@ -1403,6 +1469,11 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 
 /**
  * count_data_pages - Compute the total number of saveable non-highmem pages.
+ *
+ * Iterates over populated memory zones and counts pages that are eligible
+ * to be saved during hibernation, excluding high memory pages.
+ *
+ * Return: Total number of saveable non-highmem pages.
  */
 static unsigned int count_data_pages(void)
 {
@@ -1442,12 +1513,16 @@ static inline bool do_copy_page(long *dst, long *src)
 
 /**
  * safe_copy_page - Copy a page in a safe way.
+ * @dst: Destination buffer where the page data will be copied.
+ * @s_page: Source page to copy.
  *
  * Check if the page we are going to copy is marked as present in the kernel
  * page tables. This always is the case if CONFIG_DEBUG_PAGEALLOC or
  * CONFIG_ARCH_HAS_SET_DIRECT_MAP is not set. In that case kernel_page_present()
  * always returns 'true'. Returns true if the page was entirely composed of
  * zeros, otherwise it will return false.
+ *
+ * Return: true if the source page consisted entirely of zeros, false otherwise
  */
 static bool safe_copy_page(void *dst, struct page *s_page)
 {
@@ -1511,10 +1586,15 @@ static inline int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 #endif /* CONFIG_HIGHMEM */
 
 /*
+ * copy_data_pages - Copy all saveable pages for hibernation.
+ * @copy_bm: Bitmap of destination PFFNs where pages will be copied.
+ * @orig_bm: Bimap marking PFNs of pages to be copied.
+ * @zero_bm: Bitmap used to record PFNs of pages that are entirely zero.
+ *
  * Copy data pages will copy all pages into pages pulled from the copy_bm.
  * If a page was entirely filled with zeros it will be marked in the zero_bm.
  *
- * Returns the number of pages copied.
+ * Returns: Number of non-zero pages copied.
  */
 static unsigned long copy_data_pages(struct memory_bitmap *copy_bm,
 			    struct memory_bitmap *orig_bm,
@@ -1642,7 +1722,7 @@ void swsusp_free(void)
  * @nr_pages: Number of page frames to allocate.
  * @mask: GFP flags to use for the allocation.
  *
- * Return value: Number of page frames actually allocated
+ * Return: Number of page frames actually allocated
  */
 static unsigned long preallocate_image_pages(unsigned long nr_pages, gfp_t mask)
 {
@@ -1689,6 +1769,13 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
 
 /**
  *  __fraction - Compute (an approximation of) x * (multiplier / base).
+ *  @x: Value to scale
+ *  @multiplier: Numerator of scale factor
+ *  @base: Denominator of scale factor
+ *
+ *  Returns an integer approximation of x * (multiplier / base).
+ *
+ *  Return: Scaled value.
  */
 static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
 {
@@ -1719,6 +1806,8 @@ static inline unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
 
 /**
  * free_unnecessary_pages - Release preallocated pages not needed for the image.
+ *
+ * Return: The number of pages actually freed.
  */
 static unsigned long free_unnecessary_pages(void)
 {
@@ -1785,6 +1874,9 @@ static unsigned long free_unnecessary_pages(void)
  *
  * where the second term is the sum of (1) reclaimable slab pages, (2) active
  * and (3) inactive anonymous pages, (4) active and (5) inactive file pages.
+ *
+ * Return: Minimum required image size in pages or 0 if @saveable is not
+ *         greater than the freeable pages estimate.
  */
 static unsigned long minimum_image_size(unsigned long saveable)
 {
@@ -1820,6 +1912,8 @@ static unsigned long minimum_image_size(unsigned long saveable)
  * the preallocation of memory is continued until the total number of saveable
  * pages in the system is below the requested image size or the minimum
  * acceptable image size returned by minimum_image_size(), whichever is greater.
+ *
+ * Return: 0 on success, or -ENOMEM if memory preallocation fails.
  */
 int hibernate_preallocate_memory(void)
 {
@@ -1984,9 +2078,12 @@ int hibernate_preallocate_memory(void)
 #ifdef CONFIG_HIGHMEM
 /**
  * count_pages_for_highmem - Count non-highmem pages needed for copying highmem.
+ * @nr_highmem: Number of highmem pages that may need copying
  *
  * Compute the number of non-highmem pages that will be necessary for creating
  * copies of highmem pages.
+ *
+ * Return: Number of non-highmem pages required.
  */
 static unsigned int count_pages_for_highmem(unsigned int nr_highmem)
 {
@@ -2005,6 +2102,14 @@ static unsigned int count_pages_for_highmem(unsigned int nr_highmem) { return 0;
 
 /**
  * enough_free_mem - Check if there is enough free memory for the image.
+ * @nr_pages: Number of normal pages required
+ * @nr_highmem: Number of highmem pages that may need temporary copies
+ *
+ * Determine whether there are enough free non-highmem pages available to
+ * store the hibernation image, including additional memory needed to copy
+ * highmem pages. Also accounts for pages reserved for I/O operations.
+ *
+ * Return: Non-zero if enough memory is available, otherwise zero.
  */
 static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 {
@@ -2025,9 +2130,12 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 #ifdef CONFIG_HIGHMEM
 /**
  * get_highmem_buffer - Allocate a buffer for highmem pages.
+ * @safe_needed: Whether safe memory allocation rules apply
  *
  * If there are some highmem pages in the hibernation image, we may need a
  * buffer to copy them and/or load their data.
+ *
+ * Return: 0 on success, -ENOMEM if allocation fails.
  */
 static inline int get_highmem_buffer(int safe_needed)
 {
@@ -2037,9 +2145,15 @@ static inline int get_highmem_buffer(int safe_needed)
 
 /**
  * alloc_highmem_pages - Allocate some highmem pages for the image.
+ * @bm: Memory bitmap to mark allocated pages in
+ * @nr_highmem: Number of highmem pages that need to be backed
+ *
+ * Allocate as many highmem pages as available up to @nr_highmem, marking
+ * each allocated page in @bm. If fewer free highmem pages exit, allocate
+ * only what is available. The remaining number of pages still needed is
+ * returned.
  *
- * Try to allocate as many pages as needed, but if the number of free highmem
- * pages is less than that, allocate them all.
+ * Return: Number of highmem pages still required after allocation.
  */
 static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
 					       unsigned int nr_highmem)
@@ -2067,6 +2181,9 @@ static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
 
 /**
  * swsusp_alloc - Allocate memory for hibernation image.
+ * @copy_bm: Bitmap tracking allocated pages for image storage
+ * @nr_pages: Number of non-highmem pages needed
+ * @nr_highmem: Number of highmem pages that need to be backed
  *
  * We first try to allocate as many highmem pages as there are
  * saveable highmem pages in the system.  If that fails, we allocate
@@ -2075,6 +2192,8 @@ static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
  * In this approach it is likely that the copies of highmem pages will
  * also be located in the high memory, because of the way in which
  * copy_data_pages() works.
+ *
+ * Return: 0 on success, -ENOMEM on failure.
  */
 static int swsusp_alloc(struct memory_bitmap *copy_bm,
 			unsigned int nr_pages, unsigned int nr_highmem)
@@ -2232,6 +2351,10 @@ static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm,
  * The function returns 0 to indicate the end of the data stream condition,
  * and negative numbers are returned on errors.  If that happens, the structure
  * pointed to by @handle is not updated and should not be used any more.
+ *
+ * Return: Positive number (max bytes available) on success,
+ *         0 on end of stream,
+ *         negative error code on failure.
  */
 int snapshot_read_next(struct snapshot_handle *handle)
 {
@@ -2295,6 +2418,7 @@ static void duplicate_memory_bitmap(struct memory_bitmap *dst,
 
 /**
  * mark_unsafe_pages - Mark pages that were used before hibernation.
+ * @bm: Bitmap tracking pages used before hibernation.
  *
  * Mark the pages that cannot be used for storing the image during restoration,
  * because they conflict with the pages that had been used before hibernation.
@@ -2333,6 +2457,12 @@ static int check_header(struct swsusp_info *info)
 
 /**
  * load_header - Check the image header and copy the data from it.
+ * @info: Buffer containing the hibernation image header.
+ *
+ * Validates the image header and, if successful, initializes counters
+ * for the number of data pages to copy and metadata pages.
+ *
+ * Return: 0 on success, negative error code on failure
  */
 static int load_header(struct swsusp_info *info)
 {
@@ -2356,6 +2486,8 @@ static int load_header(struct swsusp_info *info)
  * For each element of the array pointed to by @buf (1 page at a time), set the
  * corresponding bit in @bm. If the page was originally populated with only
  * zeros then a corresponding bit will also be set in @zero_bm.
+ *
+ * Return: 0 on success, -EFAULT if an invalid or unexpected PFN is found.
  */
 static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm,
 		struct memory_bitmap *zero_bm)
@@ -2412,6 +2544,8 @@ static struct highmem_pbe *highmem_pblist;
  * @bm: Memory bitmap.
  *
  * The bits in @bm that correspond to image pages are assumed to be set.
+ *
+ * Return: Number of highmem pages present in the image.
  */
 static unsigned int count_highmem_image_pages(struct memory_bitmap *bm)
 {
@@ -2445,6 +2579,8 @@ static struct memory_bitmap *safe_highmem_bm;
  * @bm (it must be uninitialized).
  *
  * NOTE: This function should not be called if there are no highmem image pages.
+ *
+ * Return: 0 on success, -ENOMEM if memory allocation fails.
  */
 static int prepare_highmem_image(struct memory_bitmap *bm,
 				 unsigned int *nr_highmem_p)
@@ -2486,6 +2622,8 @@ static struct page *last_highmem_page;
 
 /**
  * get_highmem_page_buffer - Prepare a buffer to store a highmem image page.
+ * @page: Highmem page whose contents are to be saved
+ * @ca: Chain allocator used to obtain metadata structures and fallback pages
  *
  * For a given highmem image page get a buffer that suspend_write_next() should
  * return to its caller to write to.
@@ -2501,6 +2639,9 @@ static struct page *last_highmem_page;
  * with the help of copy_last_highmem_page().  For this purpose, if
  * @buffer is returned, @last_highmem_page is set to the page to which
  * the data will have to be copied from @buffer.
+ *
+ * Return: Pointer to the buffer for writing the page contents,
+ *         ERR_PTR(-ENOMEM) if memory allocation fails.
  */
 static void *get_highmem_page_buffer(struct page *page,
 				     struct chain_allocator *ca)
@@ -2616,6 +2757,9 @@ static inline void free_highmem_data(void) {}
  *
  * Because it was not known which pages were unsafe when @zero_bm was created,
  * make a copy of it and recreate it within safe pages.
+ *
+ * Return: 0 on success, negative error code if preparing memory for the image
+ *         fails
  */
 static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 		struct memory_bitmap *zero_bm)
@@ -2709,9 +2853,16 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 
 /**
  * get_buffer - Get the address to store the next image data page.
+ * @bm: Memory bitmap tracing PFNs to be saved
+ * @ca: Chain allocator used to allocate tracking structures and safe pages
  *
  * Get the address that snapshot_write_next() should return to its caller to
  * write to.
+ *
+ * Return:
+ *  - Pointer to buffer where image data should be written
+ *  - ERR_PTR(-EFAULT) if the bitmap traversal has finished unexpectedly
+ *  - ERR_PTR(-ENOMEM) on allocation failure
  */
 static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 {
@@ -2766,6 +2917,13 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
  * The function returns 0 to indicate the "end of file" condition.  Negative
  * numbers are returned on errors, in which cases the structure pointed to by
  * @handle is not updated and should not be used any more.
+ *
+ * Return:
+ *   - Positive number indicating the number of bytes that can be written to
+ *     the buffer returned by data_of().
+ *   - 0 if all image pages have been processed ("end of file" condition).
+ *   - Negative error code if an error occurs, in which case @handle must not
+ *     used further.
  */
 int snapshot_write_next(struct snapshot_handle *handle)
 {
@@ -2846,11 +3004,15 @@ int snapshot_write_next(struct snapshot_handle *handle)
 
 /**
  * snapshot_write_finalize - Complete the loading of a hibernation image.
+ * @handle: Snapshot handle tracking write progress and buffer state
  *
  * Must be called after the last call to snapshot_write_next() in case the last
  * page in the image happens to be a highmem page and its contents should be
  * stored in highmem.  Additionally, it recycles bitmap memory that's not
  * necessary any more.
+ *
+ * Return: 0 on success, negative error code from
+ *         hibernate_restore_protect_page()
  */
 int snapshot_write_finalize(struct snapshot_handle *handle)
 {
@@ -2897,6 +3059,10 @@ static inline void swap_two_pages_data(struct page *p1, struct page *p2,
  *
  * If the restore eventually fails, we can call this function once again and
  * restore the highmem state as seen by the restore kernel.
+ *
+ * Return:
+ *   - 0 on success or if there are no highmem pages to restore.
+ *   - -ENOMEM if there is not enough memory to allocate a temporary buffer.
  */
 int restore_highmem(void)
 {
-- 
2.43.0


