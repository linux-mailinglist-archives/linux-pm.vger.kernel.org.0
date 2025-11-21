Return-Path: <linux-pm+bounces-38390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9227BC7B9E1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 21:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5753A6A37
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 20:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D4302CB3;
	Fri, 21 Nov 2025 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIO2YzS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8027FD7D;
	Fri, 21 Nov 2025 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755785; cv=none; b=oKJkF9paG86GWgVCnSHZ8Fxw36qSHHDqo7ntwZR88DglMzDyvFcF9NePG2/o12AOe+as+GuD+1zdMzjRF31xRqiGcAbxZumg2IxrIThGOYr5xW+HG+SEbhCSscCbR9klTWiAsBGNpqDRmUhedOZbCYAuNHC2BL5Lwq6XtGc/sBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755785; c=relaxed/simple;
	bh=JEflT0kHi4BAFBWLu5rEq139FjN9D98I3QZI0yOx+Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hJWKC6Hk2tsiybx/JYc2lMyW4wwCaVkdINCSKnDwldj0S6lCf3dgUp9cXWNv+s4SjW6T7aAALR7zsTLFZBIrkm0UUonaLz7rdkNXOgtBgRyl4XmAKrvt8iLfqyuFk3L29W0vQm0PgeM3oAWE9zClAbRiXiIywIRQXNqFjiWoJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIO2YzS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74569C4CEF1;
	Fri, 21 Nov 2025 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763755785;
	bh=JEflT0kHi4BAFBWLu5rEq139FjN9D98I3QZI0yOx+Pw=;
	h=From:To:Cc:Subject:Date:From;
	b=kIO2YzS/+p0GXr22Q5ZAHNanYUONYC+x7R1CTzREGXVgatqZ526gIoYtcBwYjnjzy
	 gKp6lxdAV0D0hNIE0Ksaf68u4lfXCkiOXtZ2tDvLKGUsua48WhkWMEZQm330b3uf1x
	 eVA+Mu4MegrbVmz3iNWaFoloH6xHNqmxPyb6+8HXXKGWtcpNxIQV9EGzs6k+AMHD9G
	 tZfKlqdoIY3wrU/VTWH2I/lRw8Dm3HRLbI2KmNeweZ7FP50k99p+jbtN2vLHNljsLF
	 lZEGOX/wP5QbTM4rlpZm18yOL7fpr21Gs2XsoP/uWeiQyGnJJAEks5yzrB3s96aqC6
	 ftk+0OuY8vM2g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject:
 [PATCH v1] PM: hibernate: Extra cleanup of comments in swap handling code
Date: Fri, 21 Nov 2025 21:09:42 +0100
Message-ID: <5943864.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Continue recent cleanups of comments in the swap handling code.

Unify the use of white space in the comments, drop some unuseful
comments outside function bodies, and move some other comments into
function bodies.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/swap.c |   81 +++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 48 deletions(-)

--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -46,19 +46,18 @@ static bool clean_pages_on_read;
 static bool clean_pages_on_decompress;
 
 /*
- *	The swap map is a data structure used for keeping track of each page
- *	written to a swap partition.  It consists of many swap_map_page
- *	structures that contain each an array of MAP_PAGE_ENTRIES swap entries.
- *	These structures are stored on the swap and linked together with the
- *	help of the .next_swap member.
+ * The swap map is a data structure used for keeping track of each page
+ * written to a swap partition.  It consists of many swap_map_page structures
+ * that contain each an array of MAP_PAGE_ENTRIES swap entries.  These
+ * structures are stored on the swap and linked together with the help of the
+ * .next_swap member.
  *
- *	The swap map is created during suspend.  The swap map pages are
- *	allocated and populated one at a time, so we only need one memory
- *	page to set up the entire structure.
+ * The swap map is created during suspend.  The swap map pages are allocated and
+ * populated one at a time, so we only need one memory page to set up the entire
+ * structure.
  *
- *	During resume we pick up all swap_map_page structures into a list.
+ * During resume we pick up all swap_map_page structures into a list.
  */
-
 #define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(sector_t) - 1)
 
 /*
@@ -89,10 +88,8 @@ struct swap_map_page_list {
 };
 
 /*
- *	The swap_map_handle structure is used for handling swap in
- *	a file-alike way
+ * The swap_map_handle structure is used for handling swap in a file-alike way.
  */
-
 struct swap_map_handle {
 	struct swap_map_page *cur;
 	struct swap_map_page_list *maps;
@@ -117,10 +114,9 @@ struct swsusp_header {
 static struct swsusp_header *swsusp_header;
 
 /*
- *	The following functions are used for tracing the allocated
- *	swap pages, so that they can be freed in case of an error.
+ * The following functions are used for tracing the allocated swap pages, so
+ * that they can be freed in case of an error.
  */
-
 struct swsusp_extent {
 	struct rb_node node;
 	unsigned long start;
@@ -170,15 +166,14 @@ static int swsusp_extents_insert(unsigne
 	return 0;
 }
 
-/*
- *	alloc_swapdev_block - allocate a swap page and register that it has
- *	been allocated, so that it can be freed in case of an error.
- */
-
 sector_t alloc_swapdev_block(int swap)
 {
 	unsigned long offset;
 
+	/*
+	 * Allocate a swap page and register that it has been allocated, so that
+	 * it can be freed in case of an error.
+	 */
 	offset = swp_offset(get_swap_page_of_type(swap));
 	if (offset) {
 		if (swsusp_extents_insert(offset))
@@ -189,16 +184,14 @@ sector_t alloc_swapdev_block(int swap)
 	return 0;
 }
 
-/*
- *	free_all_swap_pages - free swap pages allocated for saving image data.
- *	It also frees the extents used to register which swap entries had been
- *	allocated.
- */
-
 void free_all_swap_pages(int swap)
 {
 	struct rb_node *node;
 
+	/*
+	 * Free swap pages allocated for saving image data.  It also frees the
+	 * extents used to register which swap entries had been allocated.
+	 */
 	while ((node = swsusp_extents.rb_node)) {
 		struct swsusp_extent *ext;
 
@@ -303,6 +296,7 @@ static int hib_wait_io(struct hib_bio_ba
 /*
  * Saving part
  */
+
 static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 {
 	int error;
@@ -615,9 +609,6 @@ static void free_crc_data(struct crc_dat
 	kfree(crc);
 }
 
-/*
- * CRC32 update function that runs in its own thread.
- */
 static int crc32_threadfn(void *data)
 {
 	struct crc_data *d = data;
@@ -642,6 +633,7 @@ static int crc32_threadfn(void *data)
 	}
 	return 0;
 }
+
 /*
  * Structure used for data compression.
  */
@@ -663,9 +655,6 @@ struct cmp_data {
 /* Indicates the image size after compression */
 static atomic64_t compressed_size = ATOMIC_INIT(0);
 
-/*
- * Compression function that runs in its own thread.
- */
 static int compress_threadfn(void *data)
 {
 	struct cmp_data *d = data;
@@ -936,15 +925,15 @@ static int enough_swap(unsigned int nr_p
 }
 
 /**
- *	swsusp_write - Write entire image and metadata.
- *	@flags: flags to pass to the "boot" kernel in the image header
+ * swsusp_write - Write entire image and metadata.
+ * @flags: flags to pass to the "boot" kernel in the image header
  *
- *	It is important _NOT_ to umount filesystems at this point. We want
- *	them synced (in case something goes wrong) but we DO not want to mark
- *	filesystem clean: it is not. (And it does not matter, if we resume
- *	correctly, we'll mark system clean, anyway.)
+ * It is important _NOT_ to umount filesystems at this point. We want them
+ * synced (in case something goes wrong) but we DO not want to mark filesystem
+ * clean: it is not. (And it does not matter, if we resume correctly, we'll mark
+ * system clean, anyway.)
  *
- *	Return: 0 on success, negative error code on failure.
+ * Return: 0 on success, negative error code on failure.
  */
 int swsusp_write(unsigned int flags)
 {
@@ -988,8 +977,8 @@ out_finish:
 }
 
 /*
- *	The following functions allow us to read data using a swap map
- *	in a file-like way.
+ * The following functions allow us to read data using a swap map in a file-like
+ * way.
  */
 
 static void release_swap_reader(struct swap_map_handle *handle)
@@ -1161,9 +1150,6 @@ struct dec_data {
 	unsigned char cmp[CMP_SIZE];              /* compressed buffer */
 };
 
-/*
- * Decompression function that runs in its own thread.
- */
 static int decompress_threadfn(void *data)
 {
 	struct dec_data *d = data;
@@ -1618,7 +1604,6 @@ put:
 /**
  * swsusp_close - close resume device.
  */
-
 void swsusp_close(void)
 {
 	if (IS_ERR(hib_resume_bdev_file)) {
@@ -1630,9 +1615,9 @@ void swsusp_close(void)
 }
 
 /**
- *      swsusp_unmark - Unmark swsusp signature in the resume device
+ * swsusp_unmark - Unmark swsusp signature in the resume device
  *
- *      Return: 0 on success, negative error code on failure.
+ * Return: 0 on success, negative error code on failure.
  */
 #ifdef CONFIG_SUSPEND
 int swsusp_unmark(void)




